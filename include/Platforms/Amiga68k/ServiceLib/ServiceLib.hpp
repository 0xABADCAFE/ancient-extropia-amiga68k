//****************************************************************************//
//** File:         ServiceLib.hpp ($NAME=ServiceLib.hpp)                    **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is included in AmigaOS 68K systems             **//
//** Library:      ServiceLib                                               **//
//** Created:      2001-01-20                                               **//
//** Updated:      2001-11-17                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#ifndef _XSYSTEM_RESOURCES68K_HPP
#define _XSYSTEM_RESOURCES68K_HPP

#ifndef KARL_FIXES

// A tricky name conflict exists in the AmigaOS includes, namely the fact that several OS library pointers share
// the same name as an extended library structure to which they point. Not really a problem for C since the latter
// must always be preceeded by the struct keyword. Gives C++ mode a bit of a headache under STORM 3, so I modified
// the includes such that these library structures are renamed leaving the pointer names (which are required by linker
// well alone.

#error ServiceLib.hpp needs KARL_FIXES defined to compile correctly
#endif

typedef uint32 sysSIGNAL;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xCHAIN:: / xCHAINABLE::
//
//  Service class that allows efficient implementation of linked lists.
//
//  Here we wrap exec's MinList/MinNode system for compactness. A degree of robustness is added. You cannot add a node to a list if
//  that node is already in a list. Lists keep a record of the current number of entries, nodes store a pointer to the list they are
//  in.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xCHAIN;

class xCHAINABLE : private struct MinNode {
	friend class xCHAIN;
	private:
		xCHAIN*	chain;
		uint32	flags; // 64 bit aligned including MinNode

	public:
		sint32			LinkFront(xCHAIN* c);
		sint32 			LinkEnd(xCHAIN* c);
		sint32 			LinkBefore(xCHAIN* c, xCHAINABLE* x);
		sint32 			UnLink();
		xCHAINABLE* Next();
		xCHAINABLE* Prev();
	public:
		xCHAINABLE() : chain(0), flags(0) {}
		~xCHAINABLE();
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xCHAIN : private struct MinList {
	friend class xCHAINABLE;
	private:
		uint32	items; // 64-bit aligned

	public:
		uint32			Items() { return items; }

		xCHAINABLE* First() { return (xCHAINABLE*)mlh_Head; }
		xCHAINABLE* Last()	{ return (xCHAINABLE*)mlh_Tail; }

	public:
		xCHAIN();
		~xCHAIN() {}
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline xCHAIN::xCHAIN() : items(0)
{
	mlh_Head = (MinNode*)&mlh_Tail;
	mlh_Tail = 0;
	mlh_TailPred = (MinNode*)&mlh_Head;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline xCHAINABLE* xCHAINABLE::Next()
{
	return (xCHAINABLE*)mln_Succ;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline xCHAINABLE* xCHAINABLE::Prev()
{
	return (xCHAINABLE*)mln_Pred;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline xCHAINABLE::~xCHAINABLE()
{
	UnLink();
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  MILLICLOCK
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class MILLICLOCK {
	private:
		static Device*		TimerBase;
		static EClockVal	current;
		static uint32			clockFreq;
		EClockVal					mark;

	public:
		void			Set()			{ ReadEClock(&current); mark = current; }
		uint32		Elapsed();

	public:
		MILLICLOCK() { clockFreq = ReadEClock(&current); mark = current; }
		~MILLICLOCK() {}
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DELAY [service class only]
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class DELAY {
	private:
		enum {
			PORT_FAIL	= 0x00000001,
			IORQ_FAIL = 0x00000002,
			OPDV_FAIL = 0x00000004,
			IORQ_USED = 0x00000008,
			IORQ_4EVR	= 0x00000010,
			IORQ_PNDG	= 0x00000020,
		};
		MsgPort*					timerPort;
		union {
			IORequest*			timerIO;
			timerequest*		timerReq;
		};
		sysSIGNAL					timerSignal;
		uint32						flags;

	protected:
		sysSIGNAL	TimerSignal() { return timerSignal; }
		void			Abort();
		sysSIGNAL	Pause(uint32 millis, sysSIGNAL trigger);
		sysSIGNAL Pause(sysSIGNAL trigger);

	protected:
		DELAY();
		virtual ~DELAY();
};



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  THREAD [service class only]
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class THREAD {
	public:
/*
		class Exception {
			public:
				Exception() {  }
				~Exception() {  }
		};
		class StartFail			: public THREAD::Exception {};
		class AccessDenied	: public THREAD::Exception {};
		class NotRunning		: public THREAD::Exception {};
		class UnknownThread	: public THREAD::Exception {};
*/
	private:
		friend class THREAD_MAIN;
		friend class LOCK;

		class IDLE : protected DELAY {
			private:
				sysSIGNAL req;

			public:
				sysSIGNAL	Suspend()												{ return DELAY::Pause(req); }
				sysSIGNAL	Suspend(uint32 ms, sysSIGNAL t) { req = t; return DELAY::Pause(ms, req); }
				sysSIGNAL	TimerSignal()										{ return DELAY::TimerSignal(); }
				sysSIGNAL	ReqSignal()											{ return req; }
				void			Abort()													{ DELAY::Abort();}
				IDLE() : DELAY(), req(0)									{}
				~IDLE()																		{}
		};

		enum {
			SPAWNED				= 0x00000001,
			STARTERROR		= 0x00000002,
			COMPLETED			= 0x00000004,
			SHUTDOWN			= 0x00000008,
			SLEEPING			= 0x00000010,
			IGNOREWAKE		= 0x00000020,
			ABORTREQ			= 0x00000040,
			IDTAG					= 0x58534C54,
			SIGNAL_REMV		= SIGBREAKF_CTRL_C,
			SIGNAL_WAKE		= SIGBREAKF_CTRL_D,
			SIGNAL_SYNC		= SIGBREAKF_CTRL_F
		};
		static sint32	threadCnt;
		static sint32	threadsIdle;
		static Task*	rootThread;
		uint32				classID;
		Task*					external;
		Process*			internal;
		IDLE*					sleeper;
		size_t				stackSize;
		sint16				priority;
		uint16				state;
		sint32				retVal;
		char					name[16];

		static void Init();
		static void Done();

	protected:
		sint32	GoIdle(uint32 millis, bool abortReq, bool ignoreWake, sysSIGNAL trigger);
		sint32	GoIdle();
		void		AbortIdle() { sleeper->Abort(); state |= ABORTREQ; }
		bool		ShutDown()	{ return (state & SHUTDOWN)==SHUTDOWN; }

		virtual sint32	Run() = 0;

	public:
		enum {
			STACK_MINIMUM		= 2048,
			STACK_MAXIMUM		= 1048576,
			STACK_DEFAULT		= 4096,
			PRI_MAXIMUM			= 1,
			PRI_MINIMUM			= -128,
			PRI_DEFAULT			= 0,

			ERR_STARTUP					= -1,
			ERR_ACCESS					= -2,
			ERR_NOTRUNNING			= -3,
			ERR_ALREADYRUNNING	= -4,
			ERR_UNWAKEABLE			= -5,
			ERR_UNKNOWNTHREAD		= -6,

			TIMEOUT					= 0,
			WAKECALL				= 1,
			REMOVE					= 2,
			SYSTEMSIGNAL		= 3,
			SLEEPABORTED		= 4,
			UNKNOWN					= 5
		};
		static bool			GotBreak()	{ return (SetSignal(0,SIGBREAKF_CTRL_C) & SIGBREAKF_CTRL_C) ? true : false; }
		static sint32		Num()				{ return threadCnt; }
		static sint32		NumIdle()		{ return threadsIdle; }
		static sint32		NumActive()	{ return threadCnt - threadsIdle; }
		static THREAD*	Current();
		static THREAD*	Main();
		static sint32		Sleep(uint32 ms, bool abortReq=false, bool ignoreWake=false, sysSIGNAL trigger=0);
		static sint32		Sleep();
		static void			AbortSleep();
		bool						Started()		{ return state & SPAWNED; }
		bool						Completed()	{ return state & COMPLETED; }
		bool						Sleeping()	{ return Started() && (state & SLEEPING); }
		bool						Running()		{ return Started() && ((state & SLEEPING)==0); }
		sint32					Returned()	{ return retVal; }
		const char*			Name()			{ return name; }

		sint32	Start(sint32 pri=PRI_DEFAULT, size_t stk=STACK_DEFAULT);
		sint32	Stop();
		sint32	Wake();

	protected:
		THREAD();
		virtual ~THREAD();
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  LOCK
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class LOCK {
	private:
		SignalSemaphore	lock;
		Task*						creator;
		Task*						destructor;

	public:
/*
		class		Exception {};
		class		Destroyed			: public LOCK::Exception {};
		class		InvalidOwner	: public LOCK::Exception {};
*/

		enum {
			ALREADYLOCKED	= -1,
			INVALIDOWNER	= -2,
			DESTROYED			= -3
		};
		sint32	TryLock();
		sint32	TryReadOnlyLock();
		sint32	WaitLock();
		sint32	WaitReadOnlyLock();
		sint32	Pending();
		sint32	Locked();
		bool		MyLock();
		void		FreeLock();
		THREAD*	LockOwner();

	protected:
		LOCK();
		virtual ~LOCK();
};

#endif