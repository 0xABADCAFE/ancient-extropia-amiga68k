//*****************************************************************//
//** Description:   OS Layer classes                             **//
//** First Started: 2001-03-08                                   **//
//** Last Updated:  2001-21-08                                   **//
//** Author(s):     Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _XSYSTEM_IO_HPP
#define _XSYSTEM_IO_HPP

#include <xBase.hpp>

#if defined(XP_AMIGAOS)
  #include "Platforms/Amiga68k/IOLib/IOLib.hpp"
#elif defined(XP_WIN32)
  #include "Platforms/Win32/IOLib/IOLib.hpp"
#else
  #error "Error: OS Platform Not Defined"
#endif  //Platform Options//

#endif