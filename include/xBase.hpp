//****************************************************************************//
//** File:         xBase.hpp ($NAME=xBase.hpp)                              **//
//** Description:  eXtropia Library Base API                                **//
//** Comment(s):   This file is included in all systems                     **//
//** Library:      Base                                                     **//
//** Created:      2001-01-20                                               **//
//** Updated:      2002-01-25                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//


#ifndef _xBASE_HPP_INCLUDED
#define _xBASE_HPP_INCLUDED
#ifndef __STORM__
#pragma once
#endif

//File Version ($VERSION=1.00)
#define xBASE_HPP_VERSION     0x0100
//Release Ver. ($RELEASE=1)
#define xBASE_HPP_RELEASE     0x0001


//// INCLUDE LIBRARIES ///////////////////////////////////////////////////////


#include "xDefs.hpp"

#ifdef X_VERBOSE
#include <iostream.h>
#endif

#ifndef __STORM__
#pragma pack (push)
#endif
extern "C" {
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <stdarg.h>
  #include <ctype.h>
}
#ifndef __STORM__
#pragma pack (pop)
#endif

//// GLOBAL VARIABLES ////////////////////////////////////////////////////////


extern char   st[512];                //Globaly Shared String (volatile)
extern char   gxSt[8][32];            //eXtropia Global Tag Strings


//// FUNCTION PROTOTYPES /////////////////////////////////////////////////////


char *F(char *format,...);            //Returns C-Style Formatted string (volatile)
char *FC(char *format,...);           //Formats and Returns format string itself
char *Upper(const char*);             //Returns uppercase string (volatile)
char *Lower(const char*);             //Returns lowercase string (volatile)


//// USEFUL MACROS ///////////////////////////////////////////////////////////

/*
#define X1Y1X2Y2       rsint16 x1,rsint16 y1,rsint16 x2,rsint16 y2      //2 points (Default)
#define cX1Y1X2Y2      rsint16 cx1,rsint16 cy1,rsint16 cx2,rsint16 cy2  //2 points (Clipping)
#define rX1Y1X2Y2      sint16 &rx1,sint16 &ry1,sint16 &rx2,sint16 &ry2  //2 points (Reference)
#define X1Y1           rsint16 x1,rsint16 y1                            //1 point  (Top-Left)
#define X2Y2           rsint16 x2,rsint16 y2                            //1 point  (Bottom-Right)
#define XY             rsint16 x,rsint16 y                              //1 point  (Default)
#define MXMY           rsint16 mx,rsint16 my                            //1 point  (Mouse)
#define RXRY           sint16 &rx,sint16 &ry                            //1 point  (Reference)
#define WH             rsint16 w,rsint16 h                              //Dimesions(Default)
*/

//// CLASSES /////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//
// Error Type
//
// Basic type is sint32, in which any positive or zero value is deemed to be
// success. Negative values below -65536 are deemed to be errors according
// to the format discussed below. The range allows for functions that return
// values within sint16 or larger if positive to return a formatted error.
//
// Format
//
// -(0x0000 Ssss Cccccccc Vvvvvvvvvvvvvvvv) : Severity, Class, Value
//
// Class values 0-127 are 'internal', 128-255 are custom
//
// Macros are provided to construct an error value from the above properties.
//
// The xBASELIB::Error() function translates an internal error into text
// format thus
//
// Error(sint32 error)
//   => "<severity> : <error class> <specific error>"
//
// Error(sint32 error, char* cause)
//   => "<severity> : <error class> '<cause>' <specific error>"
//
// Custom error types are translated thus
//
// Error(sint32 error)
//   => "<severity> : User returned Class:Value"
//
// Error(sint32 error, char* cause)
//   => "<severity> : User '<cause>' returned Class:Value"
//
//////////////////////////////////////////////////////////////////////////////


typedef enum {
	SUCCESS			= 0,
	INFO 				= 1,
	WARNING			= 2,
	ERROR				= 3,
	FATAL				= 4,
	CATACLYSMIC	= 15,
	RSBITS			= 24,
	RSMASK			= 0x0F000000
} ERRSEVERITY;

typedef enum {
	RESULT		= 0,
	VALUE			= 1,
	POINTER		= 2,
	MEMORY		= 3,
	IO				= 4,
	RESOURCE	= 5,
	USER			= 128, // if this bit is set, is a user error type
	RCBITS		= 16,
	RCMASK		= 0x00FF0000
} ERRCLASS;

#define GPRPT(s,c,v)	(-( ((s)<<RSBITS)			| ((c)<<RCBITS) | (v)) )
#define RPERR(c,v)		(-( (ERROR<<RSBITS)		| ((c)<<RCBITS) | (v)) )
#define RPWRN(c,v)		(-( (WARNING<<RSBITS)	| ((c)<<RCBITS) | (v)) )
#define RPINF(c,v)		(-( (INFO<<RSBITS)		| ((c)<<RCBITS) | (v)) )

typedef enum {
	// value errors	- general purpose for 'value out of range' type
	ERR_VALUE_CHANGED		= RPERR(VALUE,7),
	ERR_VALUE_SIGN			= RPERR(VALUE,6),
	ERR_VALUE_RANGE			= RPERR(VALUE,5),
	ERR_VALUE_MIN				= RPERR(VALUE,4),
	ERR_VALUE_ZERO			= RPERR(VALUE,3),
	ERR_VALUE_MAX				= RPERR(VALUE,2),
	ERR_VALUE_ILLEGAL		= RPERR(VALUE,1),
	ERR_VALUE						= RPERR(VALUE,0),
	// file related errors
	ERR_FILE_CLOSE			= RPERR(IO,12),
	ERR_FILE_OPEN				= RPERR(IO,11),
	ERR_FILE_SEEK_END		= RPERR(IO,10),
	ERR_FILE_SEEK_BEG		= RPERR(IO,9),
	ERR_FILE_SEEK				= RPERR(IO,8),
	ERR_FILE_EXISTS			= RPERR(IO,7), // to stop unwanted overwrite
	ERR_FILE_CREATE			= RPERR(IO,6),
	ERR_FILE_WRITE			= RPERR(IO,5),
	ERR_FILE_READ				= RPERR(IO,4),
	ERR_FILE_CORRUPT		= RPERR(IO,3),
	ERR_FILE_EMPTY			= RPERR(IO,2),
	ERR_FILE_NOT_FOUND	= RPERR(IO,1),
	ERR_FILE						= RPERR(IO,0),
	// resource errors - note that a resource can be anything
	ERR_RSC_LOST				= RPERR(RESOURCE,9),
	ERR_RSC_INVALID			= RPERR(RESOURCE,8),
	ERR_RSC_NOACCESS		= RPERR(RESOURCE,7),
	ERR_RSC_EXHAUSTED		= RPERR(RESOURCE,6),
	ERR_RSC_UNAVAILABLE	= RPERR(RESOURCE,5),
	ERR_RSC_LOCKED			= RPERR(RESOURCE,4),	// A resource was in use
	ERR_RSC_TYPE				= RPERR(RESOURCE,3),	// A resource was not of correct type, format etc.
	ERR_RSC_VERSION			= RPERR(RESOURCE,2),	// Anything that requires a specific resource version can return this
	ERR_RSC_NOT_FOUND 	= RPERR(RESOURCE,1),	// Anything that has to locate a resource can return this
	ERR_RSC							= RPERR(RESOURCE,0),
	// pointer errors
	ERR_PTR_INCONSISTENT= RPERR(POINTER,5), // anything using bidirectional pointers may return this
	ERR_PTR_RANGE				= RPERR(POINTER,4),	// anything expecting a pointer to be in a range can return this
	ERR_PTR_USED				= RPERR(POINTER,3),	// anything that requires a zero pointer to initialize can return this
	ERR_PTR_ZERO				= RPERR(POINTER,2),	// anything that requires a vailid pointer to something can return this
	ERR_PTR_NOT_UNIQUE  = RPERR(POINTER,1), // anything requiring a unique pointer can return this
	ERR_PTR							= RPERR(POINTER,0),
	// memory
	ERR_MULTIPLE_FREE		= RPERR(MEMORY,2),
	ERR_NO_FREE_STORE 	= RPERR(MEMORY,1),	// anything allocating free space can return this
	// user
	ERR_USER						= RPERR(USER,0),
	// value errors	- general purpose for 'value out of range' type
	WRN_VALUE_CHANGED		= RPWRN(VALUE,7),
	WRN_VALUE_SIGN			= RPWRN(VALUE,6),
	WRN_VALUE_RANGE			= RPWRN(VALUE,5),
	WRN_VALUE_MIN				= RPWRN(VALUE,4),
	WRN_VALUE_ZERO			= RPWRN(VALUE,3),
	WRN_VALUE_MAX				= RPWRN(VALUE,2),
	WRN_VALUE_ILLEGAL		= RPWRN(VALUE,1),
	WRN_VALUE						= RPWRN(VALUE,0),
	// file warnings - identical to error types, but for non-critical operations
	WRN_FILE_CLOSE			= RPWRN(IO,12),
	WRN_FILE_OPEN				= RPWRN(IO,11),
	WRN_FILE_SEEK_END		= RPWRN(IO,10),
	WRN_FILE_SEEK_BEG		= RPWRN(IO,9),
	WRN_FILE_SEEK				= RPWRN(IO,8),
	WRN_FILE_EXISTS			= RPWRN(IO,7),
	WRN_FILE_CREATE			= RPWRN(IO,6),
	WRN_FILE_WRITE			= RPWRN(IO,5),
	WRN_FILE_READ				= RPWRN(IO,4),
	WRN_FILE_CORRUPT		= RPWRN(IO,3),
	WRN_FILE_EMPTY			= RPWRN(IO,2),
	WRN_FILE_NOT_FOUND	= RPWRN(IO,1),
	WRN_FILE						= RPWRN(IO,0),
	// resorce warnings
	WRN_RSC_INVALID			= RPWRN(RESOURCE,8),
	WRN_RSC_NOACCESS		= RPWRN(RESOURCE,7),
	WRN_RSC_EXHAUSTED		= RPWRN(RESOURCE,6),
	WRN_RSC_UNAVAILABLE	= RPWRN(RESOURCE,5),
	WRN_RSC_LOCKED			= RPWRN(RESOURCE,4),
	WRN_RSC_TYPE				= RPWRN(RESOURCE,3),
	WRN_RSC_VERSION			= RPWRN(RESOURCE,2),
	WRN_RSC_NOT_FOUND 	= RPWRN(RESOURCE,1),
	WRN_RSC							= RPWRN(RESOURCE,0),
	// pointer warnings
	WRN_PTR_INCONSISTENT= RPWRN(POINTER,5),
	WRN_PTR_RANGE				= RPWRN(POINTER,4),
	WRN_PTR_USED				= RPWRN(POINTER,3),
	WRN_PTR_ZERO				= RPWRN(POINTER,2),
	WRN_PTR_NOT_UNIQUE 	= RPWRN(POINTER,1),
	WRN_PTR							= RPWRN(POINTER,0),
	// memory
	WRN_MULTIPLE_FREE		= RPWRN(MEMORY,2),
	WRN_NO_FREE_STORE 	= RPWRN(MEMORY,1),	// doubt if a faied memory allocation would ever be a warning
	// user
	WRN_USER						= RPWRN(USER,0),
	// info
	INFO_USER						= RPINF(USER,0),
	OK 									= 0				// hooray - sucess !
} XL_RET;


//-- Simple cyclic/shared string pool mostly to be used by the library
template <int noSt,int lenSt> class STRINGPOOL {
  char   st[noSt][lenSt];
  uint32 n;
public:
  char *operator()()    { n++; if(n>noSt-1)n=0; return st[n]; }
  operator char*()      { n++; if(n>noSt-1)n=0; return st[n]; }
  uint32 MaxLen()       { return lenSt-1; }
  STRINGPOOL() : n(0)   { }
};


//-- xBase Library: Call xBASELIB::Init() before using library, Done() at the end
class xBASELIB {

	private:
		static sint32	numStartArgs;
		static char**	startArgs;
	#ifdef X_VERBOSE
		static char*	errSev[];		// serverity
		#ifdef XC_STORM
		static char*	errTbl[][]; // contains the built in error strings
		#else
		static char*	errTbl[8][16]; // watcom needs defined dimensions
		#endif
	#endif
	public:
  	static sint32 Init();                    //Returns NONZERO on Error
		static sint32 Init(int argn, char** argv);
		static char*	Arg(const char* s);
	  static void   Done();
	#ifdef X_VERBOSE
		static char*	Error(sint32 err, char* causer=0); // describes an error code
	#endif
};


//// DEFINES /////////////////////////////////////////////////////////////////


//-- Name & Company Tags
#define eXtropia          gxSt[0]
#define xSerkan           gxSt[1]
#define xKarl             gxSt[2]


//// INLINE FUNCTIONS ////////////////////////////////////////////////////////

template<class T, class U, class V>	inline T		Clamp(T v, U min, V max)	{ return ((v < min) ? min : ((v > max) ? max : v)); }
template<class T>										inline void	Swap(T& a, T& b)					{ T tmp=a; a=b; b=tmp; }
template<class T>										inline T		Round(T v)								{ return (f<0) ? (f-0.5F) : (f+0.5F); }

inline sint16 Round16(rfloat32 f)		{ return (f<0) ? (sint16)(f-0.5F) : (sint16)(f+0.5F); }
inline sint16 Round16(rfloat64 f)		{ return (f<0) ? (sint16)(f-0.5) : (sint16)(f+0.5); }
inline sint32 Round32(rfloat32 f)		{ return (f<0) ? (sint32)(f-0.5F) : (sint32)(f+0.5F); }
inline sint32 Round32(rfloat64 f)		{ return (f<0) ? (sint32)(f-0.5) : (sint32)(f+0.5); }

inline sint32		ClipInt(rsint32 v,  rsint32 min, rsint32 max)				{return ((v < min) ? min : ((v > max) ? max : v));}
inline float32	ClipFloat(rfloat32 v, rfloat32 min, rfloat32 max)		{return ((v < min) ? min : ((v > max) ? max : v));}
inline float32	ClipDouble(rfloat64 v, rfloat64 min, rfloat64 max)	{return ((v < min) ? min : ((v > max) ? max : v));}

//// INCLUDE PLATFORM SPECIFIC BASE LIBRARY //////////////////////////////////


#if defined(XP_AMIGAOS)
  #include "Platforms/Amiga68k/sysBase.hpp"
#elif defined(XP_WIN32)
  #include "Platforms/Win32/sysBase.hpp"
#else
  #error "Error: OS Platform Not Defined"
#endif  //Platform Options//


#endif  //_xBASE_HPP_INCLUDED//