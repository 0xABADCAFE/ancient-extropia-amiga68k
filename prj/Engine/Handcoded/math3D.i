;//****************************************************************************//
;//**                                                                        **//
;//**  File:          math3D.i ($NAME=math3D.i)                              **//
;//**                                                                        **//
;//**  Description:   Class data description and required XREFS              **//
;//**  Comment(s):                                                           **//
;//**                                                                        **//
;//**  First Started: 2002-08-04                                             **//
;//**  Last Updated:  2002-08-24                                             **//
;//**                                                                        **//
;//**  Author(s):     Karl Churchill                                         **//
;//**                                                                        **//
;//**  Copyright:     (C)1998-2002, eXtropia Studios                         **//
;//**                 Serkan YAZICI, Karl Churchill                          **//
;//**                 All Rights Reserved.                                   **//
;//**                                                                        **//
;//****************************************************************************//

;//////////////////////////////////////////////////////////////////////////////
;//
;//  MC680x0 definitions
;//
;//////////////////////////////////////////////////////////////////////////////

;// Target

	mc68040

;// Imported symbols

;// Class member offsets

VEC3D_x	EQU 0
VEC3D_y	EQU 4
VEC3D_z	EQU 8
;// matrix array offsets
M_11		EQU 0
M_12		EQU 4
M_13		EQU 8
M_14		EQU 12
M_21		EQU 16
M_22		EQU 20
M_23		EQU 24
M_24		EQU 28
M_31		EQU 32
M_32		EQU 36
M_33		EQU 40
M_34		EQU 44
M_41		EQU 48
M_42		EQU 52
M_43		EQU 56
M_44		EQU 60