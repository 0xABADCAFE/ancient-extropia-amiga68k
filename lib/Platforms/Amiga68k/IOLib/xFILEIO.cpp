//*****************************************************************//
//** Description:   extropia asynchronous file IO class          **//
//**                AmigaOS/68K 3.x level implementation         **//
//** First Started: 2000-12-24                                   **//
//** Last Updated:  2001-03-21                                   **//
//** Author         C++ OOP version Karl Churchill               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//**                Original ASYNCIO C code (C) 1999 Amiga Inc.  **//
//*****************************************************************//

#include <xSystem/IOLib.hpp>

///////////////////////////////////////////////////////////////////////////////////////////////////////

bool xFILEIO::Exists(const char* fileName)
{
	BPTR handle = ::Open(fileName,MODE_OLDFILE);
	if (handle)
	{
		::Close(handle);
		return true;
	}
	return false;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::ReadText(char* buf, sint32 max, char mark, sint32 num)
{
	char* p = buf;
	rsint32 i = max;
	while (--i && num)
	{
		rsint32 c = GetChar();
		if (c==ERR_FILE_READ || c==EOF) // terminate if error
			break;
		if (c==(sint32)mark)
			num--;
		*(p++) = (char)c;
	}
	*p = 0; // null terminate
	return (max-i); // return num chars read
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::WriteText(char* format,...)
{
	va_list a;
	va_start(a,format);
	sint32 num = vsprintf(sysBASELIB::MsgBuf(),format,a);
	va_end(a);
	return Write(sysBASELIB::MsgBuf(), 1, num);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

void xFILEIO::SendPacket(void* arg2)
{
	af_Packet.sp_Pkt.dp_Port = &af_PacketPort;
	af_Packet.sp_Pkt.dp_Arg2 = (sint32)arg2;
	PutMsg(af_Handler, &af_Packet.sp_Msg);
	flags |= WAIT_PACKET;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::WaitPacket()
{
	if (flags & WAIT_PACKET)
	{
		while (true)
		{
			af_PacketPort.mp_Flags = PA_SIGNAL;
			Remove((struct Node *)WaitPort(&af_PacketPort));

			// Ignore spurious crap
			af_PacketPort.mp_Flags = PA_IGNORE;
			flags &= ~WAIT_PACKET;

			sint32 bytes = af_Packet.sp_Pkt.dp_Res1;
			if (bytes >= 0)
				return bytes;
			// see if the user wants to try again...
			if (ErrorReport(af_Packet.sp_Pkt.dp_Res2,REPORT_STREAM,af_File,NULL))
			{
				flags &= ~FILE_GOOD;
				return ERR_RSC_UNAVAILABLE;
			}
			if (flags & OPEN_READ)
				SendPacket(af_Buffers[af_CurrentBuf]);
			else
				SendPacket(af_Buffers[1 - af_CurrentBuf]);
		}
	}
	SetIoErr(af_Packet.sp_Pkt.dp_Res2);
	return af_Packet.sp_Pkt.dp_Res1;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

void xFILEIO::RequeuePacket()
{
	AddHead(&af_PacketPort.mp_MsgList,&af_Packet.sp_Msg.mn_Node);
	flags |= WAIT_PACKET;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

void xFILEIO::RecordSyncFailure()
{
	af_Packet.sp_Pkt.dp_Res1 = -1;
	af_Packet.sp_Pkt.dp_Res2 = IoErr();
	af_BytesLeft = 0;
	flags &= ~FILE_GOOD;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Open(const char* fileName, sint32 mode, sint32 bufferSize)
{
	BPTR				handle = 0;
	BPTR				lock = 0;

	if (mode == READ)
	{
		if (handle = ::Open(fileName,MODE_OLDFILE))
		{
			lock = Lock(fileName,ACCESS_READ);

			if (::Seek(handle, 0, OFFSET_END)>=0)
			{
				fileSize = ::Seek(handle, 0, OFFSET_CURRENT);
			}
			else
			{
				::Close(handle);
				fileSize = 0;
				handle = 0;
			}
			::Seek(handle, 0, OFFSET_BEGINNING);
			flags |= OPEN_READ;
		}
	}
	else
	{
		if (mode == WRITE)
		{
			if (handle = ::Open(fileName,MODE_NEWFILE))
			{
				fileSize = 0;
				flags |= OPEN_WRITE;
			}
		}
		else if (mode == APPEND)
		{
			if (handle = ::Open(fileName,MODE_READWRITE))
			{
				flags |= OPEN_APPEND;
				if (::Seek(handle,0,OFFSET_END)>=0)
				{
					fileSize = ::Seek(handle, 0, OFFSET_CURRENT);
				}
				else
				{
					::Close(handle);
					fileSize = 0;
					handle = 0;
				}
			}
		}
		if (handle)
			lock = ParentOfFH(handle);
	}

	if (handle)
	{
		sint32 blockSize = 512;
		if (lock)
		{
			xAlignObject32(InfoData, infoData);
			if (Info(lock,&infoData))
			{
				blockSize  = infoData.id_BytesPerBlock;
				bufferSize = (((bufferSize + (blockSize*2) - 1) / (blockSize*2)) * (blockSize*2));
			}
			UnLock(lock);
			lock = NULL;
		}

		// Align for best 68K cache boundary (16 byte)
		bufferSpace = MEM::Alloc(bufferSize, true, MEM::ALIGN_CACHE);
		if (bufferSpace)
		{
			af_File			= handle;
			af_BlockSize = blockSize;

			FileHandle* fh   = (FileHandle*)BADDR(af_File);
			af_Handler       = fh->fh_Type;
			af_BufferSize    = bufferSize >> 1;

			af_Buffers[0]    = bufferSpace;
			af_Buffers[1]    = (void*)((uint32)bufferSpace + af_BufferSize);

			af_Offset        = af_Buffers[0];
			af_CurrentBuf    = 0;
			af_SeekOffset    = 0;

			flags &= ~WAIT_PACKET;
			// message port setup
			af_PacketPort.mp_MsgList.lh_Head     = (struct Node *)&af_PacketPort.mp_MsgList.lh_Tail;
			af_PacketPort.mp_MsgList.lh_Tail     = NULL;
			af_PacketPort.mp_MsgList.lh_TailPred = (struct Node *)&af_PacketPort.mp_MsgList.lh_Head;
			af_PacketPort.mp_Node.ln_Type        = NT_MSGPORT;
			af_PacketPort.mp_Node.ln_Name        = NULL;
			af_PacketPort.mp_Flags               = PA_IGNORE;
			af_PacketPort.mp_SigBit              = SIGB_SINGLE;
			af_PacketPort.mp_SigTask             = FindTask(NULL);

			af_Packet.sp_Pkt.dp_Link          = &af_Packet.sp_Msg;
			af_Packet.sp_Pkt.dp_Arg1          = fh->fh_Arg1;
			af_Packet.sp_Pkt.dp_Arg3          = af_BufferSize;
			af_Packet.sp_Pkt.dp_Res1          = 0;
			af_Packet.sp_Pkt.dp_Res2          = 0;
			af_Packet.sp_Msg.mn_Node.ln_Name  = (char*)&af_Packet.sp_Pkt;
			af_Packet.sp_Msg.mn_Node.ln_Type  = NT_MESSAGE;
			af_Packet.sp_Msg.mn_Length        = sizeof(struct StandardPacket);

			if (mode == READ)
			{	// prefetch
				af_Packet.sp_Pkt.dp_Type = ACTION_READ;
				af_BytesLeft             = 0;
				af_Offset                = af_Buffers[1];
				if (af_Handler)
					SendPacket(af_Buffers[0]);
			}
			else
			{
				af_Packet.sp_Pkt.dp_Type = ACTION_WRITE;
				af_BytesLeft             = af_BufferSize;
			}
		}
		else
		{
			flags &= ~OPEN_ANY;
			::Close(handle);
			SetIoErr(ERROR_NO_FREE_STORE);
		}
	}
	else
		flags &= ~OPEN_ANY;

	if(lock != NULL)
	{
		flags &= ~OPEN_ANY;
		sint32 error = IoErr();
		UnLock(lock);
		SetIoErr(error);
	}
	if (flags & OPEN_ANY)
	{
		flags |= FILE_GOOD;
		return OK;
	}
	else
		return ERR_FILE_OPEN;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Flush()
{
	// This should only be used when there is a problem. Flushing scews the block alignment and is
	// best avoided
	sint32 result = WaitPacket();
	{
		if (result >= 0)
		{
			if (flags & (OPEN_WRITE|OPEN_APPEND))
			{// this will flush out any pending data in the write buffer
				if (af_BufferSize > af_BytesLeft)
				result = ::Write(af_File,af_Buffers[af_CurrentBuf],af_BufferSize - af_BytesLeft);
			}
		}
	}
	return result;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Close()
{
	sint32 result = OK;
	if (flags & OPEN_ANY)
	{
		result = WaitPacket();
		if (result >= 0)
		{
			if (flags & (OPEN_WRITE|OPEN_APPEND))
			{// this will flush out any pending data in the write buffer
				if (af_BufferSize > af_BytesLeft)
				result = ::Write(af_File,af_Buffers[af_CurrentBuf],af_BufferSize - af_BytesLeft);
			}
		}
		::Close(af_File);
	}
	else
	{
		SetIoErr(ERROR_INVALID_LOCK);
		result = ERR_FILE_CLOSE;
	}

	if (bufferSpace)
	{
		MEM::Free(bufferSpace);
		bufferSpace = 0;
	}
	flags &= ~(OPEN_ANY|FILE_GOOD);
	return result;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Read(void* buffer, size_t s, size_t n)
{
	n *= s;
	sint32 totalBytes = 0;
	// if we need more bytes than there are in the current buffer, enter the read loop
	while (n > af_BytesLeft)
	{
		MEM::Copy(buffer, af_Offset, af_BytesLeft);
		n										-= af_BytesLeft;
		buffer							= (void*)((uint32)buffer + af_BytesLeft);
		totalBytes					+= af_BytesLeft;
		af_BytesLeft				= 0;
		sint32 bytesArrived = WaitPacket();
		if (bytesArrived <= 0)
		{
			if (bytesArrived == 0)
			{ // end of file reached
				flags |= FILE_ATEND;
				SetIoErr(0);
				return totalBytes/s;
			}
			return ERR_FILE_READ;
		}
		// ask that the buffer be filled
		SendPacket(af_Buffers[1-af_CurrentBuf]);
		if (af_SeekOffset > bytesArrived)
			af_SeekOffset = bytesArrived;
		af_Offset      = (void*)((uint32)af_Buffers[af_CurrentBuf] + af_SeekOffset);
		af_CurrentBuf  = 1 - af_CurrentBuf;
		af_BytesLeft   = bytesArrived - af_SeekOffset;
		af_SeekOffset  = 0;
	}
	MEM::Copy(buffer, af_Offset, n);
	af_BytesLeft -= n;
	af_Offset     = (void*)((uint32)af_Offset + n);
	return (totalBytes + n)/s;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Write(void* buffer, size_t s, size_t n)
{
	n *= s;
	sint32 totalBytes = 0;
	while (n > af_BytesLeft)
	{// NIL
		if (!af_Handler)
		{
			af_Offset			= af_Buffers[0];
			af_BytesLeft	= af_BufferSize;
			return n;
		}

		if (af_BytesLeft)
		{
			MEM::Copy(af_Offset, buffer, af_BytesLeft);
			n		-= af_BytesLeft;
			buffer			= (void*)((uint32)buffer + af_BytesLeft);
			totalBytes	+= af_BytesLeft;
		}
		if (WaitPacket() < 0)
			return ERR_FILE_WRITE;

		// send the current buffer out to disk
		SendPacket(af_Buffers[af_CurrentBuf]);

		af_CurrentBuf	= 1 - af_CurrentBuf;
		af_Offset			= af_Buffers[af_CurrentBuf];
		af_BytesLeft	= af_BufferSize;
	}

	MEM::Copy(af_Offset, buffer, n);
	af_BytesLeft		-= n;
	af_Offset				= (void*)((uint32)af_Offset + n);
	return (totalBytes + n)/s;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Tell()
{
	if (flags & OPEN_READ)
	{
		sint32 bytesArrived = WaitPacket();
		if (bytesArrived < 0)
			return ERR_FILE_SEEK;
		return ::Seek(af_File,0,OFFSET_CURRENT) - (af_BytesLeft+bytesArrived) + af_SeekOffset;
	}
	else
		return Seek(0, CURRENT);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Seek(sint32 position, sint32 mode)
{
	sint32 bytesArrived = WaitPacket();
	if (bytesArrived < 0)
		return ERR_FILE_SEEK;
	sint32 current;
	if (flags & OPEN_READ)
	{// figure out what the actual file position is
		sint32 filePos = ::Seek(af_File,0,OFFSET_CURRENT);
		if (filePos < 0)
		{
			RecordSyncFailure();
			return ERR_FILE_SEEK;
		}
		// figure out what the caller's file position is
		current = filePos - (af_BytesLeft+bytesArrived) + af_SeekOffset;
		sint32 target;
		// figure out the absolute offset within the file where we must seek to
		if (mode == CURRENT)
		{
			target = current + position;
		}
		else if (mode == START)
		{
			target = position;
		}
		else /* if (mode == MODE_END) */
		{
			xAlignObject32(FileInfoBlock, fib);
			if (!ExamineFH(af_File,&fib))
			{
				RecordSyncFailure();
				return ERR_FILE_SEEK;
			}
			target = fib.fib_Size + position;
		}
		// figure out what range of the file is currently in our buffers
		sint32 minBuf = current - (sint32)((uint32)af_Offset - (uint32)af_Buffers[1-af_CurrentBuf]);
		sint32 maxBuf = current + af_BytesLeft + bytesArrived;  /* WARNING: this is one too big */
		sint32 diff = target - current;

		if ((target < minBuf) || (target >= maxBuf))
		{
            /* the target seek location isn't currently in our buffers, so
             * move the actual file pointer to the desired location, and then
             * restart the async read thing...
             */
            /* this is to keep our file reading block-aligned on the device.
             * block-aligned reads are generally quite a bit faster, so it is
             * worth the trouble to keep things aligned
             */
			sint32 roundTarget = (target / af_BlockSize) * af_BlockSize;
			if (::Seek(af_File,roundTarget-filePos,OFFSET_CURRENT) < 0)
			{
				RecordSyncFailure();
				return ERR_FILE_SEEK;
			}
			SendPacket(af_Buffers[0]);
			af_SeekOffset = target-roundTarget;
			af_BytesLeft  = 0;
			af_CurrentBuf = 0;
			af_Offset     = af_Buffers[1];
		}
		else if ((target < current) || (diff <= af_BytesLeft))
		{
            /* one of the two following things is true:
             *
             * 1. The target seek location is within the current read buffer,
             * but before the current location within the buffer. Move back
             * within the buffer and pretend we never got the pending packet,
             * just to make life easier, and faster, in the read routine.
             *
             * 2. The target seek location is ahead within the current
             * read buffer. Advance to that location. As above, pretend to
             * have never received the pending packet.
             */

			RequeuePacket();
			af_BytesLeft -= diff;
			af_Offset     = (void*)((uint32)af_Offset + diff);
		}
		else
		{
            /* at this point, we know the target seek location is within
             * the buffer filled in by the packet that we just received
             * at the start of this function. Throw away all the bytes in the
             * current buffer, send a packet out to get the async thing going
             * again, readjust buffer pointers to the seek location, and return
             * with a grin on your face... :-)
             */

			SendPacket(af_Buffers[1-af_CurrentBuf]);
			diff -= af_BytesLeft - af_SeekOffset;
			af_Offset     = (void*)((uint32)af_Buffers[af_CurrentBuf] + diff);
			af_BytesLeft  = bytesArrived - diff;
			af_SeekOffset = 0;
			af_CurrentBuf = 1 - af_CurrentBuf;
		}
	}
	else
	{
		if (af_BufferSize > af_BytesLeft)
		{
			if (::Write(af_File,af_Buffers[af_CurrentBuf],af_BufferSize - af_BytesLeft) < 0)
			{
				RecordSyncFailure();
				return ERR_FILE_SEEK;
			}
		}

        /* this will unfortunately generally result in non block-aligned file
         * access. We could be sneaky and try to resync our file pos at a
         * later time, but we won't bother. Seeking in write-only files is
         * relatively rare (except when writing IFF files with unknown chunk
         * sizes, where the chunk size has to be written after the chunk data)
         */

		current = ::Seek(af_File,position,mode);
		if (current < 0)
		{
			RecordSyncFailure();
			return ERR_FILE_SEEK;
		}

		af_BytesLeft  = af_BufferSize;
		af_CurrentBuf = 0;
		af_Offset     = af_Buffers[0];
	}
	return current;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Endian swapping block IO. These impose fairly strict alignment. For each, the buffer and file
//  buffer alignment must be at least 16 bits (objects on stack may not be optimally aligned)
//
///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Read16Swap(void* buffer,size_t n)
{
	if (((uint32)buffer|(uint32)af_Offset)&1UL)
		return ERR_PTR;

	n <<= 1;
	sint32 totalBytes = 0;
	// if we need more bytes than there are in the current buffer, enter the read loop
	while (n > af_BytesLeft)
	{
		MEM::Swap16(buffer, af_Offset, (af_BytesLeft>>1));
		n										-= af_BytesLeft;
		buffer							= (void*)((uint32)buffer + af_BytesLeft);
		totalBytes					+= af_BytesLeft;
		af_BytesLeft				= 0;
		sint32 bytesArrived = WaitPacket();
		if (bytesArrived <= 0)
		{
			if (bytesArrived == 0)
			{ // end of file reached
				flags |= FILE_ATEND;
				SetIoErr(0);
				return totalBytes>>1;
			}
			return ERR_FILE_READ;
		}
		// ask that the buffer be filled
		SendPacket(af_Buffers[1-af_CurrentBuf]);
		if (af_SeekOffset > bytesArrived)
			af_SeekOffset = bytesArrived;
		af_Offset      = (void*)((uint32)af_Buffers[af_CurrentBuf] + af_SeekOffset);
		af_CurrentBuf  = 1 - af_CurrentBuf;
		af_BytesLeft   = bytesArrived - af_SeekOffset;
		af_SeekOffset  = 0;
	}
	MEM::Swap16(buffer, af_Offset, (n>>1));
	af_BytesLeft -= n;
	af_Offset     = (void*)((uint32)af_Offset + n);
	return (totalBytes + n)>>1;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Read32Swap(void* buffer,size_t n)
{
	if (((uint32)buffer|(uint32)af_Offset)&1UL)
		return ERR_PTR;

	n <<= 2;
	sint32 totalBytes = 0;
	// if we need more bytes than there are in the current buffer, enter the read loop
	while (n > af_BytesLeft)
	{
		MEM::Swap32(buffer, af_Offset, (af_BytesLeft>>2));
		n										-= af_BytesLeft;
		buffer							= (void*)((uint32)buffer + af_BytesLeft);
		totalBytes					+= af_BytesLeft;
		af_BytesLeft				= 0;
		sint32 bytesArrived = WaitPacket();
		if (bytesArrived <= 0)
		{
			if (bytesArrived == 0)
			{ // end of file reached
				flags |= FILE_ATEND;
				SetIoErr(0);
				return totalBytes>>2;
			}
			return ERR_FILE_READ;
		}
		// ask that the buffer be filled
		SendPacket(af_Buffers[1-af_CurrentBuf]);
		if (af_SeekOffset > bytesArrived)
			af_SeekOffset = bytesArrived;
		af_Offset      = (void*)((uint32)af_Buffers[af_CurrentBuf] + af_SeekOffset);
		af_CurrentBuf  = 1 - af_CurrentBuf;
		af_BytesLeft   = bytesArrived - af_SeekOffset;
		af_SeekOffset  = 0;
	}
	MEM::Swap32(buffer, af_Offset, (n>>2));
	af_BytesLeft -= n;
	af_Offset     = (void*)((uint32)af_Offset + n);
	return (totalBytes + n)>>2;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Read64Swap(void* buffer,size_t n)
{
	if (((uint32)buffer|(uint32)af_Offset)&1UL)
		return ERR_PTR;

	n <<= 3;
	sint32 totalBytes = 0;
	// if we need more bytes than there are in the current buffer, enter the read loop
	while (n > af_BytesLeft)
	{
		MEM::Swap64(buffer, af_Offset, (af_BytesLeft>>3));
		n										-= af_BytesLeft;
		buffer							= (void*)((uint32)buffer + af_BytesLeft);
		totalBytes					+= af_BytesLeft;
		af_BytesLeft				= 0;
		sint32 bytesArrived = WaitPacket();
		if (bytesArrived <= 0)
		{
			if (bytesArrived == 0)
			{ // end of file reached
				flags |= FILE_ATEND;
				SetIoErr(0);
				return totalBytes>>3;
			}
			return ERR_FILE_READ;
		}
		// ask that the buffer be filled
		SendPacket(af_Buffers[1-af_CurrentBuf]);
		if (af_SeekOffset > bytesArrived)
			af_SeekOffset = bytesArrived;
		af_Offset      = (void*)((uint32)af_Buffers[af_CurrentBuf] + af_SeekOffset);
		af_CurrentBuf  = 1 - af_CurrentBuf;
		af_BytesLeft   = bytesArrived - af_SeekOffset;
		af_SeekOffset  = 0;
	}
	MEM::Swap64(buffer, af_Offset, (n>>3));
	af_BytesLeft -= n;
	af_Offset     = (void*)((uint32)af_Offset + n);
	return (totalBytes + n)>>3;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Write16Swap(void* buffer,size_t n)
{
	if (((uint32)buffer|(uint32)af_Offset)&1UL)
		return ERR_PTR;
	n <<= 1;
	sint32 totalBytes = 0;
	while (n > af_BytesLeft)
	{// NIL
		if (!af_Handler)
		{
			af_Offset			= af_Buffers[0];
			af_BytesLeft	= af_BufferSize;
			return n;
		}

		if (af_BytesLeft)
		{
			MEM::Swap16(af_Offset, buffer, (af_BytesLeft>>1));
			n		-= af_BytesLeft;
			buffer			= (void*)((uint32)buffer + af_BytesLeft);
			totalBytes	+= af_BytesLeft;
		}
		if (WaitPacket() < 0)
			return ERR_FILE_WRITE;

		// send the current buffer out to disk
		SendPacket(af_Buffers[af_CurrentBuf]);

		af_CurrentBuf	= 1 - af_CurrentBuf;
		af_Offset			= af_Buffers[af_CurrentBuf];
		af_BytesLeft	= af_BufferSize;
	}

	MEM::Swap16(af_Offset, buffer, (n>>1));
	af_BytesLeft		-= n;
	af_Offset				= (void*)((uint32)af_Offset + n);
	return (totalBytes + n)>>1;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Write32Swap(void* buffer,size_t n)
{
	if (((uint32)buffer|(uint32)af_Offset)&1UL)
		return ERR_PTR;
	n <<= 2;
	sint32 totalBytes = 0;
	while (n > af_BytesLeft)
	{// NIL
		if (!af_Handler)
		{
			af_Offset			= af_Buffers[0];
			af_BytesLeft	= af_BufferSize;
			return n;
		}

		if (af_BytesLeft)
		{
			MEM::Swap32(af_Offset, buffer, (af_BytesLeft>>2));
			n		-= af_BytesLeft;
			buffer			= (void*)((uint32)buffer + af_BytesLeft);
			totalBytes	+= af_BytesLeft;
		}
		if (WaitPacket() < 0)
			return ERR_FILE_WRITE;

		// send the current buffer out to disk
		SendPacket(af_Buffers[af_CurrentBuf]);

		af_CurrentBuf	= 1 - af_CurrentBuf;
		af_Offset			= af_Buffers[af_CurrentBuf];
		af_BytesLeft	= af_BufferSize;
	}

	MEM::Swap32(af_Offset, buffer, (n>>2));
	af_BytesLeft		-= n;
	af_Offset				= (void*)((uint32)af_Offset + n);
	return (totalBytes + n)>>2;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xFILEIO::Write64Swap(void* buffer,size_t n)
{
	if (((uint32)buffer|(uint32)af_Offset)&1UL)
		return ERR_PTR;
	n <<= 3;
	sint32 totalBytes = 0;
	while (n > af_BytesLeft)
	{// NIL
		if (!af_Handler)
		{
			af_Offset			= af_Buffers[0];
			af_BytesLeft	= af_BufferSize;
			return n;
		}

		if (af_BytesLeft)
		{
			MEM::Swap64(af_Offset, buffer, (af_BytesLeft>>3));
			n		-= af_BytesLeft;
			buffer			= (void*)((uint32)buffer + af_BytesLeft);
			totalBytes	+= af_BytesLeft;
		}
		if (WaitPacket() < 0)
			return ERR_FILE_WRITE;

		// send the current buffer out to disk
		SendPacket(af_Buffers[af_CurrentBuf]);

		af_CurrentBuf	= 1 - af_CurrentBuf;
		af_Offset			= af_Buffers[af_CurrentBuf];
		af_BytesLeft	= af_BufferSize;
	}

	MEM::Swap64(af_Offset, buffer, (n>>3));
	af_BytesLeft		-= n;
	af_Offset				= (void*)((uint32)af_Offset + n);
	return (totalBytes + n)>>3;
}
