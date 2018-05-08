//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _VIRTUALMACHINE_2_CODE_HPP
#define _VIRTUALMACHINE_2_CODE_HPP

#include <xBase.hpp>

#include "VM_Opts.hpp"

// See DesignSpecs.txt for discussion

/////////////////////////////////////////////////////////////////////////////////////
//
//  OPCODE FORMAT
//
//  Commands are built using 32-bit words. The first word consists of an opcode byte
//  followed by up to three operand effective address bytes.
//  Each operand effective address may require an extension word
//  Finally, any data words specific to the command (for example, a branch offset)
//  follow.
//
//  [ opcd ] [ ea 1 ] [ ea 2 ] [ ea 3 ]  instruction word
//  [ possible ea 1 extension word    ]  data words
//  [ possible ea 2 extension word    ]
//  [ possible ea 3 extension word    ]
//  [ possible opcode data word #1    ]
//  [            ..etc..              ]
//
//  Notes
//
//  In reality, most commands should require no more than two or three words in
//  their entirety. Also, literal data is not valid as a destination.
//
//  The instruction word uses byte data as opposed to bitfields to simplify
//  decode.
//
/////////////////////////////////////////////////////////////////////////////////////

class VM {
	public:
		enum {
			// datatypes
			U8,			U16,		U32,		U64,		S8,			S16,		S32,		S64,
			F32,		F64,
			PU8,		PU16,		PU32,		PU64,		PS8,		PS16,		PS32,		PS64,
			PF32,		PF64
		};

		enum {
			// Basic addressing modes

			// GP register value
			// Operand value = r<n>
			R0,			R1,			R2,			R3, 		R4,			R5,			R6,			R7,
			R8,			R9,			R10,		R11,		R12,		R13,		R14,		R15,
			R16,		R17,		R18,		R19,		R20,		R21,		R22,		R23,
			R24,		R25,		R26,		R27,		R28,		R29,		R30,		R31,

			// GP register pointer
			// Operand value = *r<n>
			IR0,		IR1,		IR2,		IR3, 		IR4,		IR5,		IR6,		IR7,
			IR8,		IR9,		IR10,		IR11,		IR12,		IR13,		IR14,		IR15,
			IR16,		IR17,		IR18,		IR19,		IR20,		IR21,		IR22,		IR23,
			IR24,		IR25,		IR26,		IR27,		IR28,		IR29,		IR30,		IR31,

			// GP register pointer, signed offset
			// Operand value = *(r<n> + offset)
			// Requires 1 extension word for offset
			LIR0,		LIR1,		LIR2,		LIR3, 	LIR4,		LIR5,		LIR6,		LIR7,
			LIR8,		LIR9,		LIR10,	LIR11,	LIR12,	LIR13,	LIR14,	LIR15,
			LIR16,	LIR17,	LIR18,	LIR19,	LIR20,	LIR21,	LIR22,	LIR23,
			LIR24,	LIR25,	LIR26,	LIR27,	LIR28,	LIR29,	LIR30,	LIR31,

			// GP register pointer, signed offset with update
			// r<n> += offset, operand value = *(r<n>)
			// Requires 1 extension word for offset
			LUIR0,	LUIR1,	LUIR2,	LUIR3, 	LUIR4,	LUIR5,	LUIR6,	LUIR7,
			LUIR8,	LUIR9,	LUIR10,	LUIR11,	LUIR12,	LUIR13,	LUIR14,	LUIR15,
			LUIR16,	LUIR17,	LUIR18,	LUIR19,	LUIR20,	LUIR21,	LUIR22,	LUIR23,
			LUIR24,	LUIR25,	LUIR26,	LUIR27,	LUIR28,	LUIR29,	LUIR30,	LUIR31,

			// Special address modes

			// GP register pointer, gp register signed offset / update
			// Operand value = *(r<n> + r<ofs>) [, r<n> += r<ofs>]
			// Nore : r<ofs> assumed to hold signed 32-bit integer
			// Requires 1 word extension for base and offset regs
			IRRO,		IRROU,
			IRSRO,	IRSROU,	// as above with 16-bit litetal scale

			// Count register, used for block instructions
			CTR,

			// Writable / Constant data section pointer, unsigned offset
			// Operand value = ds[offset] / cds[offset]
			// Requires 1 extension word for offset. Constant section valid as source
			// operand only
			DS, CDS,

			// Literal data in instruction stream. Signed integers < 32-bits are stored
			// as 32-bit sign extended.
			// 64-bit literal data is not allowed. 64-bit literals must be stored in the
			// constant data section of the program
			// Source operand only
			// Requires 1 word extension
			LITERAL,

			// Offset from the current PC : used for JSR only
			OFFSET_PC,

			NUM_EA,
			REGMASK			= 0x1F,
			TYPE				= 0xE0,
			R_DIR				= 0x00,
			R_IND				= 0x20,
			R_IND_OFS		= 0x40,
			R_IND_OFSU	= 0x60,
			SPECIAL			= 0x80,

			// small literals
			IM0=224,IM1,		IM2,		IM3, 		IM4,		IM5,		IM6,		IM7,
			IM8,		IM9,		IM10,		IM11,		IM12,		IM13,		IM14,		IM15,
			IM16,		IM17,		IM18,		IM19,		IM20,		IM21,		IM22,		IM23,
			IM24,		IM25,		IM26,		IM27,		IM28,		IM29,		IM30,		IM31
		};

		enum {
			NOP,
			END,
			SYS,
			LEA,		// load effective address
			BRA,		// branch

			BNEQ_I8,		BNEQ_I16,			BNEQ_I32,			BNEQ_I64,			BNEQ_F32,			BNEQ_F64,
			BLS_I8,			BLS_I16,			BLS_I32,			BLS_I64,			BLS_F32,			BLS_F64,
			BLSEQ_I8,		BLSEQ_I16,		BLSEQ_I32,		BLSEQ_I64,		BLSEQ_F32,		BLSEQ_F64,
			BEQ_I8,			BEQ_I16,			BEQ_I32,			BEQ_I64,			BEQ_F32,			BEQ_F64,
			BGREQ_I8,		BGREQ_I16,		BGREQ_I32,		BGREQ_I64,		BGREQ_F32,		BGREQ_F64,
			BGR_I8,			BGR_I16,			BGR_I32,			BGR_I64,			BGR_F32,			BGR_F64,

			CALL,
			RET,

			// Standard arg commands (1,2 operands)
			PUSH_X8,		PUSH_X16,			PUSH_X32,			PUSH_X64,
			POP_X8,			POP_X16,			POP_X32,			POP_X64,
			SAVE,				RESTORE,
			CLR_X8,			CLR_X16,			CLR_X32,			CLR_X64,
			MOVE_X8,		MOVE_X16,			MOVE_X32,			MOVE_X64,

			ENDIAN_X16,	ENDIAN_X32,		ENDIAN_X64,
			SWAP_X8,		SWAP_X16,			SWAP_X32,			SWAP_X64,

			// Type cast (wider)
			I8TOI16,		I8TOI32,			I8TOI64,			I8TOF32,			I8TOF64,
			I16TOI32,		I16TOI64,			I16TOF32,			I16TOF64,
			I32TOI64,		I32TOF32,			I32TOF64,
			I64TOF32,		I64TOF64,
			F32TOF64,

			// Type cast (narrower)
			F64TOF32,		F64TOI64,			F64TOI32,			F64TOI16,			F64TOI8,
			F32TOI64,		F32TOI32,			F32TOI16,			F32TOI8,
			I64TOI32,		I64TOI16,			I64TOI8,
			I32TOI16,		I32TOI8,
			I16TOI8,

			// Arithmetic commands, data treat as signed integer / float (3 operands)
			ADD_I8,			ADD_I16,			ADD_I32,			ADD_I64,			ADD_F32,			ADD_F64,
			SUB_I8,			SUB_I16,			SUB_I32,			SUB_I64,			SUB_F32,			SUB_F64,
			MUL_I8,			MUL_I16,			MUL_I32,			MUL_I64,			MUL_F32,			MUL_F64,
			DIV_I8,			DIV_I16,			DIV_I32,			DIV_I64,			DIV_F32,			DIV_F64,
			MOD_I8,			MOD_I16,			MOD_I32,			MOD_I64,			MOD_F32,			MOD_F64,

			MUL_U8,			MUL_U16,			MUL_U32,			MUL_U64,
			DIV_U8,			DIV_U16,			DIV_U32,			DIV_U64,
			MOD_U8,			MOD_U16,			MOD_U32,			MOD_U64,

			NEG_I8,			NEG_I16,			NEG_I32,			NEG_I64,			NEG_F32,			NEG_F64,
			SHL_I8,			SHL_I16,			SHL_I32,			SHL_I64,
			SHR_I8,			SHR_I16,			SHR_I32,			SHR_I64,

			// Logic commands, data treat as unsigned binary (2/3 operands)
			AND_X8,			AND_X16,			AND_X32,			AND_X64,
			OR_X8,			OR_X16,				OR_X32,				OR_X64,
			XOR_X8,			XOR_X16,			XOR_X32,			XOR_X64,
			INV_X8,			INV_X16,			INV_X32,			INV_X64,
			SHL_X8,			SHL_X16,			SHL_X32,			SHL_X64,
			SHR_X8,			SHR_X16,			SHR_X32,			SHR_X64,

#ifdef USE_VM_BLOCKCOMMANDS
			// Blockmode variants
			BCLR_X8,		BCLR_X16,			BCLR_X32,			BCLR_X64,
			BMOVE_X8,		BMOVE_X16,		BMOVE_X32,		BMOVE_X64,
			BADD_I8,		BADD_I16,			BADD_I32,			BADD_I64,			BADD_F32,			BADD_F64,
			BSUB_I8,		BSUB_I16,			BSUB_I32,			BSUB_I64,			BSUB_F32,			BSUB_F64,
			BMUL_I8,		BMUL_I16,			BMUL_I32,			BMUL_I64,			BMUL_F32,			BMUL_F64,
			BDIV_I8,		BDIV_I16,			BDIV_I32,			BDIV_I64,			BDIV_F32,			BDIV_F64,
			BMOD_I8,		BMOD_I16,			BMOD_I32,			BMOD_I64,			BMOD_F32,			BMOD_F64,
			BNEG_I8,		BNEG_I16,			BNEG_I32,			BNEG_I64,			BNEG_F32,			BNEG_F64,
			BSHL_I8,		BSHL_I16,			BSHL_I32,			BSHL_I64,
			BSHR_I8,		BSHR_I16,			BSHR_I32,			BSHR_I64,
			BAND_X8,		BAND_X16,			BAND_X32,			BAND_X64,
			BOR_X8,			BOR_X16,			BOR_X32,			BOR_X64,
			BXOR_X8,		BXOR_X16,			BXOR_X32,			BXOR_X64,
			BINV_X8,		BINV_X16,			BINV_X32,			BINV_X64,
			BSHL_X8,		BSHL_X16,			BSHL_X32,			BSHL_X64,
			BSHR_X8,		BSHR_X16,			BSHR_X32,			BSHR_X64,
#endif

			NUM_OPS
		};

	// SYS opcode subcommands
	enum {
			OUT_U8,			OUT_U16,			OUT_U32,			OUT_U64,
			OUT_S8,			OUT_S16,			OUT_S32,			OUT_S64,
			OUT_F32,		OUT_F64,			OUT_STR,
			INP_U8,			INP_U16,			INP_U32,			INP_U64,
			INP_S8,			INP_S16,			INP_S32,			INP_S64,
			INP_F32,		INP_F64,			INP_STR,
			BRK,				DUMP,					VER,
			NEW_X8,			NEW_X16,			NEW_X32,			NEW_X64,
			DEL_X8,			DEL_X16,			DEL_X32,			DEL_X64,
			NEWS_X8,		NEWS_X16,			NEWS_X32,			NEWS_X64,
			DELS_X8,		DELS_X16,			DELS_X32,			DELS_X64,
			NUM_SYS
	};
};

/////////////////////////////////////////////////////////////////////////////////////


#endif
