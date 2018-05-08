//*****************************************************************//
//** Description:   eXtropia Storage IO                          **//
//** First Started: 2002-02-09                                   **//
//** Last Updated:  2002-02-09                                   **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _XSFIO_HPP
#define _XSFIO_HPP

#include <xSystem/IOLib.hpp>

#define XSF_SIG {'X','S','F',0}
#define XSF_VER 1
#define XSF_REV 0

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XSFIO
//
//  This is a pure interface for all XSF implementations. There are no general unsized writes since XSF provides endian conversion
//  and hence must know the size of each element written.
//
//  NOTES
//
//  Some compilers don't like references to abstract base classes as function args, though this is legal. We need this to implement
//  certian methods for XSF components such as XSFHEAD::operator==(XSFIO&) etc.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#if (XC_ALLOW_REF_ABSTRACT==0)
// ABSTRACT BASE
class XSFIO : public xIOS {
	public:
		virtual sint32	Read8(void* d,size_t n)	= 0;
		virtual sint32	Read16(void* d,size_t n) = 0;
		virtual sint32	Read32(void* d,size_t n) = 0;
		virtual sint32	Read64(void* d,size_t n) = 0;
		virtual sint32	Write8 (void* d,size_t n) = 0;
		virtual sint32	Write16(void* d,size_t n) = 0;
		virtual sint32	Write32(void* d,size_t n) = 0;
		virtual sint32	Write64(void* d,size_t n) = 0;
		virtual bool		Valid()	= 0;
		virtual bool		EndOfFile()	= 0;
		virtual bool		StartOfFile()	= 0;
		virtual sint32	Seek(sint32 position, sint32 mode) = 0;
		virtual sint32	Tell() = 0;
		virtual sint32	Size() = 0;
		virtual uint8		DataFormat() = 0;
		virtual uint8		FileOptions() = 0;
		virtual ~XSFIO() {}
};
#else
// NORMAL BASE ONLY. PROTECTED CONSTRUCTOR PREVENTS OBJECT INSTANCES
class XSFIO : public xIOS {
	protected:
		XSFIO() {}
	public:
		virtual sint32	Read8(void* d,size_t n)							{ return 0; }
		virtual sint32	Read16(void* d,size_t n)						{ return 0; }
		virtual sint32	Read32(void* d,size_t n)						{ return 0; }
		virtual sint32	Read64(void* d,size_t n)						{ return 0; }
		virtual sint32	Write8 (void* d,size_t n)						{ return 0; }
		virtual sint32	Write16(void* d,size_t n)						{ return 0; }
		virtual sint32	Write32(void* d,size_t n)						{ return 0; }
		virtual sint32	Write64(void* d,size_t n)						{ return 0; }
		virtual bool		Valid()															{ return 0; }
		virtual bool		EndOfFile()													{ return 0; }
		virtual bool		StartOfFile()												{ return 0; }
		virtual sint32	Seek(sint32 position, sint32 mode)	{ return 0; }
		virtual sint32	Tell()															{ return 0; }
		virtual sint32	Size()															{ return 0; }
		virtual uint8		DataFormat()												{ return 0; }
		virtual uint8		FileOptions()												{ return 0; }
		virtual ~XSFIO() {}
};
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XSFDATAID
//
//  Basic 32-bit key generator that generates an ID value from a string.
//  Every xsf chunk object uses such a key, derived from a (C style) string that can be used to identify an object
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class XDATAID
{
	private:
		uint32 idValue;
	protected:
		uint32 Value(const char* text);
	public:
		XDATAID& operator=(const char* text)	{ idValue = Value(text); return *this; }
		operator uint32() 										{ return idValue; }
		uint32 operator()() 									{ return idValue; }
	public:
		bool operator==(XDATAID& i)	{ return idValue==i.idValue; }
		bool operator!=(XDATAID& i)	{ return idValue!=i.idValue; }
		bool operator==(const char* text) { return idValue==Value(text); }
		bool operator!=(const char* text) { return idValue!=Value(text); }
	public:
		XDATAID() : idValue(0)			{}
		XDATAID(const char* text)		{ idValue = Value(text); }
		~XDATAID()									{}
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XSFHEAD
//
//  Simple file header, primarily designed for single object files. Data is char & unsigned byte based, thus totally portable.
//  A signature of upto 12 chars is supported, shorter names MUST pad the signature with zeros. The entire structure 16 bytes
//  thus giving 64-bit alignment of subsequent data.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class XSFHEAD {
	private:
		static char	sigXSF[4]; // XSF\0
		uint8				verXSF;
		uint8				revXSF;
	protected:
		char				sig[6];
		uint8				version;
		uint8				revision;
		uint8 			dataFormat;
		uint8				fileOptions;
	private:
		static uint32	CheckXSF(XSFHEAD& t);

	public:
		enum {
			SAMEFORMAT			= 0x00000001, // basically is XSF and the signatures match
			EXACT						= 0x00000002,

			XSF_VER_HIGHER	= 0x00000004,
			XSF_VER_LOWER		= 0x00000008,
			XSF_VER_DIFF		= 0x0000000C,

			XSF_REV_HIGHER	= 0x00000010,
			XSF_REV_LOWER		= 0x00000020,
			XSF_REV_DIFF		= 0x00000030,

			VERSION_HIGHER	= 0x00000040,
			VERSION_LOWER		= 0x00000080,
			VERSION_DIFF		= 0x000000C0,

			REVISION_HIGHER	= 0x00000100,
			REVISION_LOWER	= 0x00000200,
			REVISION_DIFF		= 0x00000300,

			BYTESWAPPED			= 0x00000400,
			NEGATIVEFMT			= 0x00000800,
			OTHERPLATFORM		= 0x00000C00,

			OTHERFILESPEC		= 0x00001000
		};
	public:
		bool		Read(XSFIO& file);
		bool		Write(XSFIO& file);
		uint8		Version() 	{ return version; }
		uint8		Revision()	{ return revision; }
		uint8		Format()		{ return dataFormat; }
		uint8		Options()		{ return fileOptions; }
		bool		operator!=(XSFHEAD& x);
		uint32	operator==(XSFHEAD& x);
		uint32	operator==(XSFIO& file);
		bool		operator!=(XSFIO& file) { return (*this==file)==0; }
		void		Set(const char* id, uint8 ver, uint8 rev, uint8 df, uint8 ff);

	public:
		XSFHEAD() : verXSF(XSF_VER), revXSF(XSF_REV) { sig[0] = 0; }
		XSFHEAD(const char* id, uint8 ver, uint8 rev, uint8 df, uint8 ff) : verXSF(XSF_VER), revXSF(XSF_REV) { Set(id,rev,ver,df,ff); }
		~XSFHEAD() {}
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XSFBASIC
//
//  Basic implementation of XSF 1.0 file stream.
//
//  Behaviour
//
//	There is no default constructor. Construction requires XSFHEAD properties to be specified. The object is then only compatible
//  with files of the corresponding format.
//
//  You can specify a machine data format different from the current platform when creating the object.
//
//	When opening a read file with different version information from the object, the default behaviour is to note the differences
//  and skip the header data. The header can be force loaded using the override switch in Open()
//  Any differences can be determined by testing the value returned by State()
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class XSFBASIC : public XSFIO, private XSFHEAD, private xFILEIO {
	private:
		uint32	flags;
	public:
		uint32	State(uint32 f)								{ return flags & f; }					// returns operator==() style information
		sint32	Read8(void* d,size_t n)				{ return xFILEIO::Read8(d,n); }
		sint32	Read16(void* d,size_t n)			{ return State(BYTESWAPPED) ? xFILEIO::Read16Swap(d,n) : xFILEIO::Read16(d,n); }
		sint32	Read32(void* d,size_t n)			{ return State(BYTESWAPPED) ? xFILEIO::Read32Swap(d,n) : xFILEIO::Read32(d,n); }
		sint32	Read64(void* d,size_t n)			{ return State(BYTESWAPPED) ? xFILEIO::Read64Swap(d,n) : xFILEIO::Read64(d,n); }
		sint32	Write8 (void* d,size_t n) 		{ return xFILEIO::Write8(d,n); }
		sint32	Write16(void* d,size_t n) 		{ return State(BYTESWAPPED) ? xFILEIO::Write16Swap(d,n) : xFILEIO::Write16(d,n); }
		sint32	Write32(void* d,size_t n)			{ return State(BYTESWAPPED) ? xFILEIO::Write32Swap(d,n) : xFILEIO::Write32(d,n); }
		sint32	Write64(void* d,size_t n) 		{ return State(BYTESWAPPED) ? xFILEIO::Write64Swap(d,n) : xFILEIO::Write64(d,n); }
		bool		Valid()												{ return xFILEIO::Valid(); }
		bool		EndOfFile()										{ return xFILEIO::EndOfFile(); }
		bool		StartOfFile()									{ return xFILEIO::StartOfFile(); }
		sint32	Seek(sint32 pos, sint32 mode)	{ return xFILEIO::Seek(pos, mode); }
		sint32	Tell()												{ return xFILEIO::Tell(); }
		sint32	Size()												{ return xFILEIO::Size(); }
		uint8		DataFormat()									{ return dataFormat; }
		uint8		FileOptions()									{ return fileOptions; }
		sint32	Flush()												{ return xFILEIO::Flush(); }
		sint32	Close()												{ flags = 0; return xFILEIO::Close(); }
		bool		operator!=(XSFBASIC& x)				{ return (XSFHEAD&)(*this)!=(XSFHEAD&)x;}
		uint32	operator==(XSFBASIC& x)				{ return (XSFHEAD&)(*this)==(XSFHEAD&)x;}

		sint32	Define(const char* id, uint8 ver, uint8 rev, uint8 df=X_HARDWARE, uint8 ff=0);

		sint32	Open(const char* fileName, bool override = false, sint32 mode = xIOS::READ, sint32 bufferSize=1024);
		sint32	Create(const char* fileName, sint32 bufferSize=1024);
	public:
		XSFBASIC(const char* id, uint8 ver, uint8 rev, uint8 df=X_HARDWARE, uint8 ff=0) : XSFHEAD(id,ver,rev,df,ff), xFILEIO(), flags(0) {}
		~XSFBASIC() { Close(); }
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XSFOBJ
//
//  Base class for XSF objects. Such objects can be stored and retrieved from any XSFIO stream
//
//  **** NOTE: UPDATE XSF BASE SPECIFICATION TO THIS NEW DATA LAYOUT ****
//
//  RawSize is the size of the data stored. You must set this correctly.
//  Read/Write return the total number of bytes read/written (or an error)
//	Read/Write first test ReadyForRead/ReadyForWrite which can be overloaded as required
//  The overloaded ReadBody/WriteBody must return the number of bytes read/written or a suitable error.
//  This should be equal to the XSFOBJ rawSize value.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define XSFOBJ_FILEOFFSET_CHUNKID				4
#define XSFOBJ_FILEOFFSET_SUPERCLASS		6
#define XSFOBJ_FILEOFFSET_SUBCLASS			8
#define XSFOBJ_FILEOFFSET_CONSUPERCLASS	10
#define XSFOBJ_FILEOFFSET_CONSUBCLASS		12
#define XSFOBJ_FILEOFFSET_RAWSIZE				16
#define XSFOBJ_FILEOFFSET_NAMEPTR				20
#define XSFOBJ_FILEOFFSET_EXTPROPS			24
#define XSFOBJ_FILEOFFSET_CONTROL				28
#define XSFOBJ_FILEOFFSET_VERSION				30
#define XSFOBJ_FILEOFFSET_REVISION			31
#define XSFOBJ_FILEOFFSET_OBJECTDATA		32

#define XSFOBJ_FILESIZE ((sizeof(XDATAID))+(5*sizeof(uint16))+(3*sizeof(uint32))+(6*sizeof(uint8)))

class XSFOBJ {
	private:
		static uint8 fileMarker[4];
		XDATAID	chunkID;
		uint16	superClass;
		uint16	subClass;
		uint16	cnctSuper;
		uint16	cnctSub;
		uint32	rawSize;
		uint32	namePtr;
		uint32	extProps;
		uint16	control;
		uint8		version;
		uint8		revision;
	protected:
		void		ID(const char* text)						{ chunkID = text; }
		void		SuperClass(uint16 c)						{ superClass = c; }
		void		SubClass(uint16 c)							{ subClass = c; }
		void		RawSize(size_t t)								{ rawSize = t; }
		void		ExtendedProps(uint32 p)					{ extProps = p; }
		void		Control(uint16 c)								{ control = c; }
		void		Version(uint8 v)								{ version = v; }
		void		Revision(uint8 r)								{ revision = r; }
		// object body IO
		virtual sint32 ReadyForWrite()					{ return OK; }
		virtual sint32 ReadyForRead()						{ return OK; }
		virtual sint32 WriteBody(XSFIO& f)			{ return 0; }				// must return bytes written or error type
		virtual sint32 ReadBody(XSFIO& f)				{ return 0; }				// must return bytes read or error type
	public:
		enum {
			SEEK_CHUNKID				= 4,
			SEEK_SUPERCLASS			= 6,
			SEEK_SUBCLASS				= 8,
			SEEK_CONSUPERCLASS	= 10,
			SEEK_CONSUBCLASS		= 12,
			SEEK_RAWSIZE				= 16,
			SEEK_NAMEPTR				= 20,
			SEEK_EXTPROPS				= 24,
			SEEK_CONTROL				= 28,
			SEEK_VERSION				= 30,
			SEEK_REVISION				= 31,
			SEEK_OBJECTDATA			= 32,
			SEEK_SIZE 					= ((sizeof(XDATAID))+(5*sizeof(uint16))+(3*sizeof(uint32))+(6*sizeof(uint8)))
		};

		XDATAID	ID()														{ return chunkID; }
		uint16	SuperClass()										{ return superClass; }
		uint16	SubClass()											{ return subClass; }
		uint32	RawSize()												{ return rawSize; }
		uint32	ExtendedProps()									{ return extProps; }
		uint16	Control()												{ return control; }
		uint8		Version()												{ return version; }
		uint8		Revision()											{ return revision; }
		sint32	Write(XSFIO& f);	// returns total bytes written (or error)
		sint32	Read(XSFIO& f);		// returns total bytes read (or error)

		#ifdef X_VERBOSE
		void		Dump(ostream& out);
		#endif
	public:
		XSFOBJ();
		XSFOBJ(const char* desc, uint16 super, uint16 sub, uint8 ver, uint8 rev);
		virtual ~XSFOBJ() {}
};

#include <XSF/XSFClassDefs.hpp>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  XSFCHUNKLIST_MIN
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class XSFCHUNKLIST_MIN : public XSFOBJ {
	private:

	protected:

	public:
};
#endif
