//*****************************************************************//
//** Description:   eXtropia Storage IO                          **//
//** First Started: 2002-02-09                                   **//
//** Last Updated:  2002-02-09                                   **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <XSF/XSF.hpp>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XSFDATAID
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32 XDATAID::Value(const char* text)
{
	register uint8* p = (uint8*)text;
	ruint32 val = 0;
	while (*p) val = (val<<1)^*p++;
	return val;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XSFHEAD
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

char	XSFHEAD::sigXSF[4] = {'X','S','F',0};

uint32 XSFHEAD::CheckXSF(XSFHEAD& x)
{
	// checks the head against the XSF version and native setup
	uint32 result = 0;
	if (x.verXSF > XSF_VER)
		result |= XSF_VER_HIGHER;
	else if (x.verXSF < XSF_VER)
		result |= XSF_VER_LOWER;
	if (x.revXSF > XSF_REV)
		result |= XSF_REV_HIGHER;
	else if (x.revXSF < XSF_REV)
		result |= XSF_REV_LOWER;
	return result;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool XSFHEAD::operator!=(XSFHEAD& x)
{
	// signatures that are < 6 chars ALWAYS ZERO PADDED
	{
		register char *s1 = sig, *s2 = x.sig;
		rsint16 i = 7;
		while (--i)
		{
			if ( *(s1++) != *(s2++) )
				return true;
		}
		return false;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32 XSFHEAD::operator==(XSFHEAD& x)
{
	if (*this!=x)
		return 0;
	// See if there are any differences and put them in the result
	uint32 result = CheckXSF(*this);
	if (x.version > version)
		result |= VERSION_HIGHER;
	else if (x.version < version)
		result |= VERSION_LOWER;
	if (x.revision > revision)
		result |= REVISION_HIGHER;
	else if (x.revision < revision)
		result |= REVISION_LOWER;
	if (x.dataFormat != dataFormat)
	{
		if ((x.dataFormat & XA_ENDIANMASK) != (dataFormat & XA_ENDIANMASK))
			result |= BYTESWAPPED;
		if ((x.dataFormat & XA_NEGATIVEMASK) != (dataFormat & XA_NEGATIVEMASK))
			result |= NEGATIVEFMT;
	}
	if (x.fileOptions != fileOptions)
		result |= OTHERFILESPEC;
	if (!result)
		result |= EXACT;
	return result | SAMEFORMAT;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool	XSFHEAD::Read(XSFIO& f)
{
	char b[4] = {0};
	f.Read8(b,4);
	if (b[3] || (strcmp((char*)sigXSF,b)!=0))
	{
		f.Seek(0, xIOS::START);
		return false;
	}
	return f.Read8((void*)this, sizeof(XSFHEAD))==sizeof(XSFHEAD);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool	XSFHEAD::Write(XSFIO& f)
{
	if (f.Write8(sigXSF,4)!=4)
		return false;
	return f.Write8((void*)this, sizeof(XSFHEAD))==sizeof(XSFHEAD);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32 XSFHEAD::operator==(XSFIO& f)
{
	// Test will automatically skip to the file start to perform the test.
	sint32 pos = f.Tell();
	if(pos<0)
		return ERR_FILE_READ;
	if(pos>0)
		f.Seek(0, xIOS::START);
	XSFHEAD t;
	t.Read(f);
	f.Seek(pos, xIOS::START);
	return *this==t;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void XSFHEAD::Set(const char* id, uint8 ver, uint8 rev, uint8 df, uint8 ff)
{
	// Name copy can use all 6 chars, no zero byte is mandatory
	// unless namelen < 6, when all extra bytes must be zero.
	char* tID = (char*)id;
	{
		rsint16	i = 7; register char* s = sig;
		while (--i)
			if ( !((*s++)=(*tID++)) )	break;
		if (i++)
			while (--i)	*s++ = 0;
	}
	version = ver;
	revision = rev;
	dataFormat = df;
	fileOptions = ff;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XSFBASIC
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XSFBASIC::Define(const char* id, uint8 ver, uint8 rev, uint8 df, uint8 ff)
{
	// cant define an open file
	if (Valid())
		return ERR_FILE;
	XSFHEAD::Set(id, ver, rev, df, ff);
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 XSFBASIC::Create(const char* fileName, sint32 bufferSize)
{
	if (xFILEIO::Open(fileName, xIOS::WRITE, bufferSize)!=OK)
		return ERR_FILE_CREATE;
	if (XSFHEAD::Write(*this))
	{
		// Take care of user deliberately setting an alien data format
		if ((dataFormat & XA_ENDIANMASK) != (X_HARDWARE & XA_ENDIANMASK))
			flags |= BYTESWAPPED;
		if ((dataFormat & XA_NEGATIVEMASK) != (X_HARDWARE & XA_NEGATIVEMASK))
			flags |= NEGATIVEFMT;
		return OK;
	}
	xFILEIO::Close();
	return ERR_FILE_CREATE;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define XSFHEADERSIZE (sizeof(XSFHEAD)+4) // 4==sizeof(sigXSF)

sint32 XSFBASIC::Open(const char* fileName, bool override, sint32 mode, sint32 bufferSize)
{
	if (mode==xIOS::WRITE)
		return Create(fileName, bufferSize);
	if (xFILEIO::Open(fileName, mode, bufferSize)!=OK)
		return ERR_FILE_OPEN;
	uint32 r = (XSFHEAD&)(*this)==((XSFIO&)(*this)); // will highlight any differences
	if (!r)
	{
		xFILEIO::Close();
		return ERR_FILE;
	}
	if (override)
		XSFHEAD::Read((XSFIO&)*this);
	else
		xFILEIO::Seek(XSFHEADERSIZE, xIOS::START);
	flags = r;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XSFOBJ
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint8	XSFOBJ::fileMarker[4] = {'x','s','f',0};

XSFOBJ::XSFOBJ() :	chunkID("Undefined"), superClass(T_none), subClass(T_none), cnctSuper(T_none), cnctSub(T_none),
										rawSize(0), namePtr(0), extProps(0), control(0), version(0), revision(0)
{
}

XSFOBJ::XSFOBJ(const char* desc, uint16 super, uint16 sub, uint8 ver, uint8 rev) : chunkID(desc), superClass(super),
							subClass(sub), cnctSuper(T_none), cnctSub(T_none), rawSize(0), namePtr(0), extProps(0), control(0),
							version(ver), revision(rev)
{
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32	XSFOBJ::Write(XSFIO& f)
{
	sint32 r = ReadyForWrite();
	if (r!=OK)
	{
/*
		#ifdef X_DEBUG
		sysBASELIB::MessageBox("Error","Abort","XSFIO write error\nObject not ready");
		#endif
*/
		return r;
	}

	// Always clone the file dataFormat byte in the object file marker. This info is not used by the basic IO routines
	// which always assume the global XSFIO file dataFormat. However, user extensions to the XSF format may need to
	// know on a per-object basis what data format is used.
	// For example, if an XSF file is decomposed into its objects, we can still see which machine layout each object
	// was created with. Useful for applications that create multi object files by stripping the objects from single
	// object files

	fileMarker[3] = f.DataFormat();
	if (f.Write8(fileMarker,4)!=4 || f.Write32(&chunkID,1)!=1 || f.Write16(&superClass,4)!=4 ||	f.Write32(&rawSize,3)!=3 || \
			f.Write16(&control,1)!=1 ||	f.Write8(&version,2)!=2)
	{
/*
		#ifdef X_DEBUG
		sysBASELIB::MessageBox("Error","Abort","XSFIO error\nCouldn't write object header");
		#endif
*/
		return ERR_FILE_WRITE;
	}
	r = WriteBody(f);
	if (r<0)
		return r; // error report
	return r+XSFOBJ_FILESIZE; // bytes written
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32	XSFOBJ::Read(XSFIO& f)
{
	sint32 r = ReadyForRead();
	if (r!=OK)
	{
/*
		#ifdef X_DEBUG
		sysBASELIB::MessageBox("Error","Abort","XSFIO read error\nObject not ready");
		#endif
*/
		return r;
	}

	// If not on marker, there is a problem. Only compare 3 'xsf' bytes, since the fourth is a machine dataFormat byte.
	// We could check this, but the simple IO routines expect objects to have the same layout as the parent file

	char b[4] = {0};
	if (f.Read8(b,4)!=4 || (strncmp(b,(char*)fileMarker,3)!=0))
	{
/*
		#ifdef X_DEBUG
		sysBASELIB::MessageBox("Error","Abort","XSFIO error\nCouldn't read XSF object marker");
		#endif
*/
		return ERR_FILE_READ;
	}
	if (f.Read32(&chunkID,1)!=1 || f.Read16(&superClass,4)!=4 || f.Read32(&rawSize,3)!=3 || f.Read16(&control,1)!=1 || \
			f.Read8(&version,2)!=2)
	{
/*
		#ifdef X_DEBUG
		sysBASELIB::MessageBox("Error","Abort","XSFIO error\nCouldn't read object header");
		#endif
*/
		return ERR_FILE_READ;
	}
	r = ReadBody(f);
	if (r<0)
		return r; // error report
	return r+XSFOBJ_FILESIZE; // bytes read
}