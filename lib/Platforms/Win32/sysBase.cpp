//****************************************************************************// 
//** File:         sysBase.cpp ($NAME=sysBase.cpp)                          **// 
//** Description:  eXtropia Library Base API Source for Win32s              **// 
//** Comment(s):   This file is included in Win32 systems                   **// 
//** Library:      Base                                                     **// 
//** Created:      2001-02-20                                               **// 
//** Updated:      2001-02-26                                               **// 
//** Author(s):    Serkan YAZICI, Karl Churchill                            **// 
//** Note(s):                                                               **// 
//** Copyright:    (C)1996-2001, eXtropia Studios                           **// 
//**               Serkan YAZICI, Karl Churchill                            **// 
//**               All Rights Reserved.                                     **// 
//****************************************************************************// 
 
 
#include <xBase.hpp> 
 
 
#ifndef XP_WIN32 
  #error "Error: This file is for use with Win32 systems only" 
#endif  //XP_WIN32// 
 
// Memory swapping functions. These are an ideal target for asm opts, try MMX? 
 
void MEM::Swap16(ruint16* s, ruint16* d, rsize_t n) 
{ 
  do { 
    ruint16 r = *s++; 
    *d++ = (r<<8) | (r>>8); 
  } while(--n); 
} 
 
/////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
void MEM::Swap32(ruint32* s, ruint32* d, rsize_t n) 
{ 
  do { 
    ruint32 r = *s++; 
    *d++ = (r<<24) | ((r&0xFF00)<<8) | ((r>>8)&0xFF00) | (r>>24); 
  } while(--n); 
} 
 
/////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
void MEM::Swap64(ruint64* s, ruint64* d, rsize_t n) 
{ 
  // For true 64-bit machines you might want to do this with uint64 
  do { 
    ruint32 r1 = *((uint32*)s++); ruint32 r2 = *((uint32*)s++); 
    *((uint32*)d++) = (r2<<24) | ((r2&0xFF00)<<8) | ((r2>>8)&0xFF00) | (r2>>24); 
    *((uint32*)d++) = (r1<<24) | ((r1&0xFF00)<<8) | ((r1>>8)&0xFF00) | (r1>>24); 
  } while(--n); 
} 
 
/////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
//// CLASS sysBASELIB //////////////////////////////////////////////////////// 
 
 
sint32 sysBASELIB::Init() 
{  
  return OK;  //SUCCESS 
} 
 
sint32 sysBASELIB::Done() 
{ 
  return OK; 
} 
 
 
