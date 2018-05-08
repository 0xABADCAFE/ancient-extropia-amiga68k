//****************************************************************************//
//** File:         xBase.cpp ($NAME=xBase.cpp)                              **//
//** Description:  eXtropia Library Base API Source                         **//
//** Comment(s):   This file is used in all systems                         **//
//** Library:      Base                                                     **//
//** Created:      2001-01-22                                               **//
//** Updated:      2001-02-26                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2001, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//


#include <xBase.hpp>
#include <iostream.h>

//// GLOBAL DATA /////////////////////////////////////////////////////////////

char   st[512];                       //Globaly Shared String (volatile)
char   gxSt[8][32];                   //eXtropia Global Tag Strings


//// FILE GLOBAL DATA ////////////////////////////////////////////////////////

STRINGPOOL<32,256>  xbSt;             //Internal String Buffer


//// UTILITY FUNCTIONS ///////////////////////////////////////////////////////

//-- Format String (returns internal string)
char *F(char *format,...)
{
  char *s = xbSt;
  va_list arglist;
  va_start(arglist,format);
  vsprintf(s,format,arglist);
  va_end(arglist);
  return s;
}

//-- Returns upper case version of a string (doesn't modify original)
char *Upper(const char*st)
{
  char *s = xbSt;
  sint32  i=0;
  while(st[i] && i<xbSt.MaxLen()){
    s[i] = toupper(st[i]);
    i++;
  }
  s[i]=0;
  return s;
}


//-- Returns lower case version of a string (doesn't modify original)
char *Lower(const char*st)
{
  char *s = xbSt;
  sint32  i=0;
  while(st[i] && i<xbSt.MaxLen()){
    s[i] = tolower(st[i]);
    i++;
  }
  s[i]=0;
  return s;
}


//-- Format String (returns format)
char *FC(char *format,...)
{
  va_list arglist;
  va_start(arglist,format);
  vsprintf(st,format,arglist);
  va_end(arglist);
  strcpy(format,st);
  return format;
}


//// CLASS xBASELIB //////////////////////////////////////////////////////////

sint32 xBASELIB::numStartArgs = 0;
char** xBASELIB::startArgs = 0;

#ifdef X_VERBOSE
char* xBASELIB::errSev[] =
{
	"Success",
	"Information",
	"Warning",
	"Error",
	"Fatal",
	"Undefined severity 5",
	"Undefined severity 6",
	"Undefined severity 7",
	"Undefined severity 8",
	"Undefined severity 9",
	"Undefined severity 10",
	"Undefined severity 11",
	"Undefined severity 12",
	"Undefined severity 13",
	"Undefined severity 14",
	"End of the World",
	0
};

// first dimenstion corresponds to REPCLASS, second is particular error
char*	xBASELIB::errTbl[][] = {
	{"returned", "User", 0},

	{"Value", "is illegal", "overflowed", "is zero", "underflowed", "is not in range",
	 "has invalid sign",	"has changed", 0},

	{"Pointer", "is not unique", "is empty", "is in use", "is not in range",
	 "is bidirectionally inconsistent", 0},

	{"Memory", "exhausted", "freed twice", 0},

	{"File", "not found", "is empty", "is corrupt", "read failed", "write failed",
	 "was not created", "already exists", "seek before start", "seek past end",
	 "not opened", "not closed", 0},

	{"Resource", "not found", "has incorrect version", "is not correct type",
	 "is locked", "is unavailable", "is exhausted", "access violation",
	 "is invalid", "lost", 0},
	0
};

char* xBASELIB::Error(sint32 err, char* causer)
{
	if (err>=-65536)
	{
		if (causer)
			sprintf(st, "%s : %s %s %d", errSev[0], causer, errTbl[0][0], err);
		else
			sprintf(st, "%s : %d", errSev[0], err);
	}
	else
	{
		err = -err;
		sint32 es = (err & RSMASK)>>RSBITS;
		sint32 ec = (err & RCMASK)>>RCBITS;
		sint32 er = (err & 0x0000FFFF);

		if (ec & USER)
		{	// user defined errors
			ec &= ~USER;
			if (causer)
				sprintf(st, "%s : %s '%s' %s %d:%d", errSev[es], errTbl[0][1], causer, errTbl[0][0], ec, er);
				// <severity> : User '<name>' returned <custom error value>
			else
				sprintf(st, "%s : %s %s %d:%d", errSev[es], errTbl[0][1], errTbl[0][0], ec, er);
				// <severity> : User returned <custom error value>
		}
		else
		{
			// standard error table for built-ins
			if (causer)
			{
				sprintf(st, "%s : %s '%s' %s", errSev[es], errTbl[ec][0], causer, errTbl[ec][er]);
				// <severity> : <error type> '<name>' <error string>
			}
			else
			{
				sprintf(st, "%s : %s %s", errSev[es], errTbl[ec][0], errTbl[ec][er]);
				// <severity> : <error type> <error string>
			}
		}
	}
	return st;
}
#endif

sint32 xBASELIB::Init()
{
	#ifdef X_VERBOSE
	cerr.setf(ios::unitbuf);
	cerr << "xBASELIB Debug build : " __DATE__ " at " __TIME__ "\n";
	#endif
  sint32 result = sysBASELIB::Init();
  if(result!=OK)
    return result;

	// Don't look at me, this part is Serkans code !!!
  char *s[] = { gxSt[1], gxSt[2], gxSt[0] };
  sint32  p=13, i=0;
  sint32  o[][24] = { { 70,18,13,-7,-10,13,-78,57,-24,25,-17,-6,6,-73,0,0,0,0,0,0,0,0,0,0 },
                      { -8,-4,0,1,-65,-43,72,28,49,9,31,38,35,108,0,0,0,0,0,0,0,0,0,0 },
                      { 26,-9,2,6,79,45,1,-20,-82,-16,12,12,-8,-3,111,115,0,0,0,0,0,0,0,0 } };
  while(i<24)
    *s[2]++ =(uint8)((*s[1]++ =(uint8)((p=*s[0]++ =(uint8)(p+o[0][i]))+o[1][i]))+o[2][i++]); // Karl -- Chuckle :)
  return OK;
}

sint32 xBASELIB::Init(int argn, char** argv)
{
	sint32 r = xBASELIB::Init();
	if (r==OK)
	{
		numStartArgs = argn;
		startArgs = argv;
	}
	return r;
}

void xBASELIB::Done()
{
  sysBASELIB::Done();
}

char* xBASELIB::Arg(const char* s)
{
	for (int i=0; i<numStartArgs; i++)
	{
		if (!stricmp(startArgs[i], s))
			if (++i<numStartArgs)
				return startArgs[i];
	}
	return 0;
}
