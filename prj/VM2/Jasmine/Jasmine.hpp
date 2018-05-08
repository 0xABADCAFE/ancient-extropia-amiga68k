//****************************************************************************//
//**                                                                        **//
//**  File:          Jasmine.hpp ($NAME=Jasmine.hpp)                        **//
//**                                                                        **//
//**  Description:   JASMINE Virtual Machine main project header            **//
//**  Comment(s):    This file to be included in any source that uses the   **//
//**                 runtime JASMINE class                                  **//
//**                                                                        **//
//**  First Started: 2002-08-04                                             **//
//**  Last Updated:  2002-08-24                                             **//
//**                                                                        **//
//**  Author(s):     Karl Churchill, Serkan YAZICI                          **//
//**                                                                        **//
//**  Copyright:     (C)1998-2002, eXtropia Studios                         **//
//**                 Serkan YAZICI, Karl Churchill                          **//
//**                 All Rights Reserved.                                   **//
//**                                                                        **//
//****************************************************************************//

#ifndef _JASMINE_HPP
#define _JASMINE_HPP

#include <xBase.hpp>
#include <xSystem/ServiceLib.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  Compilation switches
//
//  JASMINE_DEBUG_ENABLE
//    Enables dump instruction output and other debugging output
//
//  JASMINE_MACRO_EA
//    If specified, special macros that decode instruction operands as needed
//  will be used rather than a seperate EA decode stage. This can make the code
//  larger but gives more scope to optimising compilers. The macros expand the
//  most common addressing modes inline.
//
//  JASMINE_BREAK_DETECT_ALWAYS
//  JASMINE_BREAK_DETECT_BRANCH_ONLY
//    If specified, code to detect user breaks will be inserted in the runtime
//  interpreter. The former inserts the code in the main execution loop, thus
//  checking for breaks at each statement processed. The latter inserts the
//  code only in branch statements as these are the only places an infinte
//  loop should be able to occur, allowing the remainder of the code to run
//  unchecked (hence faster).
//
//  Note : These options require xTHREADABLE::GotSignal(). On some systems,
//         break detection will be unneeded since user break is handled by the
//         OS.
//
//
//  JASMINE_HANDCODED
//    If enabled the C++ code for low-level execution will be suppressed
//  in favour of hand coded assembly versions. The C++ code will simply not
//  be generated, so the appropriate asm code can be added at the linker stage.
//    This directive overrides the JASMINE_MACRO_EA/JASMINE_INLINE_* directives
//  since all such lowlevel code is assumed to be hand written.
//
//
//  Note : Obviously the above is totally platform dependent. No extern "asm"
//         directives are used as different compilers handle such directives in
//         different ways. Furthermore, C++ type checking may be lost in such
//         cases. Therefore, symbols exported by your chosen assembler should
//         follow the C++ symbol syntax:
//
//         _<MethodName>__<ClassName>__<ArgumentSpecification>
//
//         The ArgumentSpecification syntax is rather complex but follows
//         standardised rules defined in the C++ linkage specification.
//         Consult your linker documentation for details.
//
////////////////////////////////////////////////////////////////////////////////

#define JASMINE_DEBUG_ENABLE
#define JASMINE_MACRO_EA
#define JASMINE_BREAK_DETECT_BRANCH_ONLY
//#define JASMINE_BREAK_DETECT_ALWAYS
#define JASMINE_HANDCODED

#include "JasmineCode.hpp"
#include "JasmineClass.hpp"
#include "JasmineInline.hpp"
#include "JasmineObject.hpp"

#endif
