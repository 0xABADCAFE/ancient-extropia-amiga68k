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

extern "C" {
	#include <clib/alib_protos.h>
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  MILLICLOCK
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Device*		MILLICLOCK::TimerBase = TimerBase = (Device*)::FindName(&SysBase->DeviceList, TIMERNAME);
EClockVal	MILLICLOCK::current;
uint32		MILLICLOCK::clockFreq = 0;

uint32 MILLICLOCK::Elapsed()
{
	::ReadEClock(&current);
	ruint32 ticks;
	if (current.ev_hi == mark.ev_hi)
		ticks = current.ev_lo - mark.ev_lo;
	else
		ticks = 0xFFFFFFFF-mark.ev_lo + current.ev_lo;
	return (1000*ticks)/clockFreq;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DELAY
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DELAY::DELAY() : timerSignal(0), flags(0)
{
	if ( !(timerPort = ::CreateMsgPort()) )
	{
		flags |= PORT_FAIL;
		return;
	}
	timerSignal = 1<<timerPort->mp_SigBit;
	if ( !(timerIO = ::CreateExtIO(timerPort, sizeof(timerequest))) )
	{
		flags |= IORQ_FAIL;
		return;
	}
	if (::OpenDevice(TIMERNAME, UNIT_MICROHZ, timerIO, 0)!=0)
	{
		flags |= OPDV_FAIL;
		return;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DELAY::~DELAY()
{
	if (timerIO)
	{
		if (flags & IORQ_USED)
		{
			::AbortIO(timerIO);
			::WaitIO(timerIO);
			::SetSignal(0, timerSignal);
		}
		::CloseDevice(timerIO);
		::DeleteExtIO(timerIO);
	}
	if (timerPort)
		::DeleteMsgPort(timerPort);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DELAY::Abort()
{
	// Cancels a scheduled wake up
	if (timerIO && (flags & IORQ_USED))
	{
		::AbortIO(timerIO);
		::WaitIO(timerIO);
		::SetSignal(0, timerSignal);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sysSIGNAL DELAY::Pause(uint32 millis, sysSIGNAL trigger)
{
	if (!(millis|trigger))
		return 0;
	Abort();
	if (millis)
	{
		timerReq->tr_node.io_Command	= TR_ADDREQUEST;
		timerReq->tr_time.tv_secs			= (millis/1000);
		timerReq->tr_time.tv_micro		= 1000*(millis%1000);
		::SendIO(timerIO);
		flags |= IORQ_USED;
		flags &= ~IORQ_4EVR;
	}
	else
		flags |= IORQ_4EVR;
	return ::Wait(timerSignal|trigger);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sysSIGNAL DELAY::Pause(sysSIGNAL trigger)
{
	if (trigger)
	{
		if (timerIO && (flags & IORQ_USED))
		if (::CheckIO(timerIO)==0)
			return ::Wait(trigger|timerSignal);
		else
			return timerSignal;
	}
	return 0;
}
