//****************************************************************************//
//** File:         xResources.hpp ($NAME=xResources.hpp)                    **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is included in AmigaOS 68K systems             **//
//** Library:      xServices                                                **//
//** Created:      2001-01-20                                               **//
//** Updated:      2001-11-17                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#include <xSystem/ServiceLib.hpp>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  THREAD_MAIN
//
//  This is only used to wrap the main execution path with a THREAD derived interface
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class THREAD_MAIN : public THREAD
{
  friend class THREAD;
  private:
    THREAD_MAIN();

  protected:
    sint32  Run() { return ERR_ACCESS; }

  public:
    sint32 Start(sint32 pri=PRI_DEFAULT, size_t stk = STACK_DEFAULT) { return ERR_ACCESS; }
    sint32 Stop() { return ERR_ACCESS; }
  public:
    ~THREAD_MAIN();
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

THREAD_MAIN::THREAD_MAIN() : THREAD()
{
  internal = (Process*)rootThread;
  state = SPAWNED;
  strcpy(name, "THREAD 1");
  sleeper = new IDLE;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

THREAD_MAIN::~THREAD_MAIN()
{
  if (sleeper)
    delete sleeper;
  state = 0;

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  THREAD
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32  THREAD::threadCnt   = 1;
sint32  THREAD::threadsIdle = 0;
Task*   THREAD::rootThread  = ::FindTask(0);

THREAD::THREAD() :  classID(IDTAG), external(0), internal(0), sleeper(0), stackSize(0), priority(0),
                    state(0), retVal(0)
{
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

THREAD::~THREAD()
{
  Stop();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

THREAD* THREAD::Main()
{
  static THREAD_MAIN appThread();
  return &appThread;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

THREAD* THREAD::Current()
{
  // For THREAD class objects, the Task->tc_UserData pointer
  // points to a THREADNODE object that references the THREAD
  // object. The THREADNODE contains an ID that ensures were
  // handling a THREAD class created task

  Task* task = ::FindTask(0);
  if (task==rootThread)
    return Main();
  else if (task)
  {
    THREAD* thread = (THREAD*)(task->tc_UserData);
    if (thread && thread->classID == IDTAG)
      return thread;
  }
  return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void THREAD::Init()
{
  THREAD *t = Current();
  if (t)
  {
    if (!(t->sleeper = new IDLE))
    {
      t->state |= STARTERROR;
      return;
    }
    t->state |= SPAWNED;
    ::Signal(t->external, (uint32)SIGNAL_SYNC);
    ++threadCnt;
    retVal = t->Run();
    --threadCnt;
    t->state |= COMPLETED;
    return;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void THREAD::Done()
{
  THREAD* t = Current();
  if (t)
  {
    if (t->sleeper)
    {
      delete t->sleeper;
      t->sleeper = 0;
    }
    t->state &= ~SPAWNED;
    ::Signal(t->external, (uint32)SIGNAL_SYNC);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 THREAD::GoIdle()
{
  if ((Task*)internal!=::FindTask(0))
    return ERR_ACCESS;
  else if (state & ABORTREQ)
    return SLEEPABORTED;
  sysSIGNAL gotSignals = sleeper->Suspend();
  if (gotSignals & SIGNAL_REMV)
  {
    sleeper->Abort();
    state |= SHUTDOWN;
    return REMOVE;
  }
  else if (gotSignals & SIGNAL_WAKE)
    return WAKECALL;
  else if (gotSignals & sleeper->TimerSignal())
    return TIMEOUT;
  else if (gotSignals & sleeper->ReqSignal());
    return SYSTEMSIGNAL;
  return UNKNOWN;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 THREAD::GoIdle(uint32 millis, bool abortReq, bool ignoreWake, sysSIGNAL trigger)
{
  // Only spawned thread may GoIdle(). A time value of zero means sleep forever
  // which really means sleep until someone calls Remove(), Wake() or one one
  // of the trigger signals is received.
  if ((Task*)internal!=::FindTask(0))
    return ERR_ACCESS;

  if (abortReq)
    state |= ABORTREQ;
  else
    state &= ~ABORTREQ;
  sysSIGNAL gotSignals;
  ++threadsIdle;
  if (ignoreWake)
  {
    state |= IGNOREWAKE;
    gotSignals = sleeper->Suspend(millis, trigger|SIGNAL_REMV);
  }
  else
  {
    state &= ~IGNOREWAKE;
    gotSignals = sleeper->Suspend(millis, trigger|SIGNAL_WAKE|SIGNAL_REMV);
  }
  state &= ~(SLEEPING|IGNOREWAKE);
  --threadsIdle;
  if (abortReq)
    AbortIdle();
  if (gotSignals & SIGNAL_REMV)
  {
    AbortIdle();
    state |= SHUTDOWN;
    return REMOVE;
  }
  else if (gotSignals & SIGNAL_WAKE)
    return WAKECALL;
  else if (gotSignals & sleeper->TimerSignal())
    return TIMEOUT;
  else if (gotSignals & trigger);
    return SYSTEMSIGNAL;
  return UNKNOWN;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 THREAD::Start(sint32 pri, size_t stk)
{
  if (state & SPAWNED)
    return ERR_ALREADYRUNNING;
  external = ::FindTask(0);
  stackSize = Clamp(stk, STACK_MINIMUM, STACK_MAXIMUM);
  priority  = Clamp(pri, PRI_MINIMUM, PRI_MAXIMUM);
  sprintf(name, "THREAD %d", threadCnt+1);
  TagItem threadTags[] = {
    NP_Entry,       (uint32)&THREAD::Init,
    NP_StackSize,   (uint32)stackSize,
    NP_Priority,    (uint32)priority,
    NP_Name,        (uint32)name,
    NP_ExitCode,    (uint32)&THREAD::Done,
    NP_FreeSeglist, (uint32)false,
    NP_CloseOutput, (uint32)true,
    TAG_DONE,       0L
  };
  // Forbid()/Permit() allow us to immediately modify the Task portion of the newly created process before it starts
  ::Forbid();
  state = 0;
  internal = ::CreateNewProc(threadTags);
  if (!internal)
  {
    ::Permit();
    return ERR_STARTUP;
  }
  else // set up our our handle
    internal->pr_Task.tc_UserData = (void*)this;
  ::Permit();

// ::Wait for the thread to call us back. When this happens, one of three
// possible things is true
//
// 1) Thread initialisation was a success and is running
//    --> return OK
//
// 2) Thread initialisation was a success and has finished already
//    --> clear thread pointer and all but COMPLETED state flag
//
// 3) Thread initialisation failed
//    --> clear thread pointer and all flags

  while ((state & (SPAWNED|STARTERROR|COMPLETED))==0)
    ::Wait((uint32)SIGNAL_SYNC);
  if (state & STARTERROR)
  {
    state = 0;
    return ERR_STARTUP;
  }
  if (state & COMPLETED)
  {
    state = COMPLETED;
    internal = 0;
  }
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 THREAD::Stop()
{
  if ((Task*)internal == rootThread)
    return ERR_ACCESS;
  if (!(state & SPAWNED) || !internal)
    return ERR_NOTRUNNING;

  external = ::FindTask(0);
  // Spawned threads may only not call their own Remove()
  if ((Task*)internal==external)
  {
    external = 0;
    return ERR_ACCESS;
  }
  state |= SHUTDOWN;
  ::Signal((Task*)internal, (uint32)SIGNAL_REMV);
  // wait for thread to finalize
  while(state & SPAWNED)
    ::Wait((uint32)SIGNAL_SYNC);
  internal = 0;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 THREAD::Sleep(uint32 millis, bool abortReq, bool ignoreWake, sysSIGNAL trigger)
{
  THREAD* t = Current();
  if (t)
    return t->GoIdle(millis, abortReq, ignoreWake, trigger);
  return ERR_ACCESS;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 THREAD::Sleep()
{
  THREAD* t = Current();
  if (t)
    return t->GoIdle();
  return ERR_ACCESS;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void THREAD::AbortSleep()
{
  THREAD* t = Current();
  if (t)
    t->AbortIdle();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 THREAD::Wake()
{
  if (!internal || !(state & SPAWNED))
    return ERR_NOTRUNNING;
  else if ((Task*)internal==::FindTask(0))
    return ERR_ACCESS;
  else if (state & IGNOREWAKE)
    return ERR_UNWAKEABLE;
  ::Signal((Task*)internal, SIGNAL_WAKE);
  return OK;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  LOCK
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


sint32 LOCK::TryLock()
{
  if (destructor)
    return DESTROYED;
  return ::AttemptSemaphore(&lock)!=0 ? OK : ALREADYLOCKED;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 LOCK::WaitLock()
{
  // Once the destructor is invoked, new attempts to lock the object
  // will fail
  if (destructor)
    return DESTROYED;
  ::ObtainSemaphore(&lock);
  if (destructor)
    return DESTROYED;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 LOCK::TryReadOnlyLock()
{
  if (destructor)
    return DESTROYED;
  return ::AttemptSemaphore(&lock)!=0 ? OK : ALREADYLOCKED;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 LOCK::WaitReadOnlyLock()
{
  if (destructor)
    return DESTROYED;
  ::ObtainSemaphoreShared(&lock);
  if (destructor)
    return DESTROYED;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 LOCK::Pending()
{
  if (destructor)
    return DESTROYED;
  return lock.ss_NestCount - lock.ss_QueueCount - 1;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void LOCK::FreeLock()
{
  if (!MyLock()) // some plonker may have called FreeLock() without holding a lock
  {
    if (destructor) // alternatively the destructor may be at work and multiple locks freed simultaneously
      return;
  }
  if (lock.ss_NestCount>0)
    ::ReleaseSemaphore(&lock);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 LOCK::Locked()
{
  if (destructor)
    return DESTROYED;
  return lock.ss_NestCount;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool LOCK::MyLock()
{
  if (destructor)
    return false;
  return lock.ss_Owner == ::FindTask(0);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

THREAD* LOCK::LockOwner()
{
  if (lock.ss_Owner==THREAD::rootThread)
    return THREAD::Main();
  else if (lock.ss_Owner)
  {
    THREAD* thread = (THREAD*)(lock.ss_Owner->tc_UserData);
    if (thread && thread->classID == THREAD::IDTAG)
      return thread;
  }
  return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LOCK::LOCK() : destructor(0)
{
  creator = ::FindTask(0);
  ::InitSemaphore(&lock);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LOCK::~LOCK()
{
  if (!destructor)
  {
    // Flag the object as undergoing destruction, get an exclusive lock
    // and then unwind any locks that have been requested since.
    destructor = ::FindTask(0);
    ::ObtainSemaphore(&lock);
    while (lock.ss_NestCount)
      ::ReleaseSemaphore(&lock);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
