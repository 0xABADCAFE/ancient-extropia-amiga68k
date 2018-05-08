;//****************************************************************************//
;//**                                                                        **//
;//**  File:          Int32Casts.asm ($NAME=Int32Casts.asm)                  **//
;//**                                                                        **//
;//**  Description:   JASMINE code execution routines, MC68040+              **//
;//**  Comment(s):    8-32 bit Integer arithmetic operations                 **//
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

	INCDIR  "Extropialib:prj/VM2/Jasmine/M680x0"
	INCLUDE "Jasmine.i"
	INCLUDE "Casts.i"

	XDEF	fI16_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fI32_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fI64_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF32_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF64_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fI32_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fI64_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF32_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF64_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fI64_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF32_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF64_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fF32_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fF64_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fU64_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fU32_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fU16_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fU8_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fU64_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fU32_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fU16_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fU8_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fI32_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fI16_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fI8_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fI16_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fI8_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fI8_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fI16_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fI32_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fI64_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF32_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF64_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fI32_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fI64_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF32_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF64_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fI64_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF32_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fF64_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fF32_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fF64_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fS64_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fS32_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fS16_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fS8_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fS64_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fS32_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fS16_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fS8_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fI32_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fI16_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	;//XDEF	fI8_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fI16_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fI8_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	XDEF	fI8_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	SECTION ":0",CODE

;//////////////////////////////////////////////////////////////////////////////

	CNOP	0,8
fI16_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	U2I	b,w
	
	CNOP	0,8
fI32_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	U2I	b,l
	
	CNOP	0,8
fF32_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	U2F	b,s

fF64_U8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	U2F	b,d
	
	CNOP	0,8
fI32_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	U2I	w,l
	
;//fI64_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fF32_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	U2F	w,s
	
	CNOP	0,8
fF64_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	U2F	w,d
	
;//fI64_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fF32_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	U2F	l,s
	
	CNOP	0,8
fF64_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	U2F	l,d
	
;//fF32_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//fF64_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//fU64_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fU32_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	F2U	d,l
	
	CNOP	0,8
fU16_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	F2U	d,w
	
	CNOP	0,8
fU8_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	F2U	d,b
	
;//fU64_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fU32_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	F2U	s,l
	
	CNOP	0,8
fU16_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	F2U	s,w
	
	CNOP	0,8
fU8_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	F2U	s,b
	
;//fI32_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//fI16_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//fI8_U64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fI16_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	U2I	l,w

	CNOP	0,8
fI8_U32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	U2I	l,b
	
	CNOP	0,8
fI8_U16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	U2I	w,b
	
	CNOP	0,8
fI16_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	S2I	b,w
	
	CNOP	0,8
fI32_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	S2I	b,l
	
;//fI64_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fF32_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	S2F	b,s
	
	CNOP	0,8
fF64_S8__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	S2F	b,d
	
	CNOP	0,8
fI32_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	S2I	l,w
	
;//fI64_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fF32_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	S2F	w,s
	
	CNOP	0,8
fF64_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	S2F	w,d
	
;//fI64_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fF32_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	S2F	l,s
	
	CNOP	0,8
fF64_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	S2F	l,d
	
;//fF32_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//fF64_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//fS64_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fS32_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	F2S	d,l
	
	CNOP	0,8
fS16_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	F2S	d,w
	
	CNOP	0,8
fS8_F64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	F2S	d,b
	
;//fS64_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fS32_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	F2S	s,l
	
	CNOP	0,8
fS16_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	F2S	s,w
	
	CNOP	0,8
fS8_F32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	F2S	s,b
	
;//fI32_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//fI16_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

;//fI8_S64__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip

	CNOP	0,8
fI16_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	S2I	l,w
	
	CNOP	0,8
fI8_S32__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	S2I	l,b

	CNOP	0,8
fI8_S16__JASMINE_OP__r10P07JASMINEr11PPFPvr10P07JASMINEr7Uip
	S2I	b,w
	
;//////////////////////////////////////////////////////////////////////////////

	END

;//////////////////////////////////////////////////////////////////////////////
