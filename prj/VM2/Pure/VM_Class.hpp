//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _XSFVIRTUALMACHINE2_HPP
#define _XSFVIRTUALMACHINE2_HPP

#include <xBase.hpp>
#include <xSystem/xResources.hpp>

#include "VM_Opts.hpp"
#include "VM_Code.hpp"
#include "VM_ObjectCode.hpp"

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


/////////////////////////////////////////////////////////////////////////////////////
//
//  VIRTUAL MACHINE CLASS
//
/////////////////////////////////////////////////////////////////////////////////////

class VMCORE {
	private:
		enum {
			RUNNING						= 0,
			END_OF_CODE,
			MATH_DIVBYZERO,
			STACK_OVERFLOW,
			STACK_UNDERFLOW,
			METHD_OVERFLOW,
			METHD_UNDERFLOW,
			REGS_OVERFLOW,
			REGS_UNDERFLOW,
			ILLEGAL_OPCODE,
			ILLEGAL_EATYPE,
			NUM_EXITCODES
		};
	#ifdef XP_AMIGAOS
		typedef void* (*EAFUNC)(register __a2 VMCORE*, register __d7 size_t);
		typedef void 	(*OPFUNC)(register __a2 VMCORE*);
	#else
		typedef void* (*EAFUNC)(VMCORE*, size_t);
		typedef void 	(*OPFUNC)(VMCORE*);
	#endif

		union GPR {
			private:
				union { uint8			u8[8];		sint8			s8[8];																			 };
				union { uint16		u16[4];		sint16		s16[4];																			 };
				union { uint32		u32[2];		sint32		s32[2];		float32	f32[2];										 };
				union	{ uint64		u64;			sint64		s64;			float64	f64; 											 };
				union { uint8*		pu8[2];		uint16*		pu16[2];	uint32* pu32[2];	uint64*	pu64[2]; };
				union { sint8*		ps8[2];		sint16*		ps16[2];	sint32* ps32[2];	sint64*	ps64[2]; };
				union { float32*	pf32[2];	float64*	pf64[2]; 																		 };
				union { char*			pch[2];		wchar_t*	pwch[2]; 																		 };

			public:
			#if (X_ENDIAN == XA_BIGENDIAN)
				void*			Data8()					{	return &u8[7];		 }
				void*			Data16()				{ return &u16[3];		 }
				void*			Data32()				{ return &u32[1];		 }
				void*			Data64()				{ return &u64; 			 }
				void*			Data(uint32 s)	{ return &u8[(8-s)]; }
				char*			&PtrCh()				{ return pch[1];		 }
				uint8*		&PtrU8()				{ return pu8[1]; 		 }
				uint16*		&PtrU16()				{ return pu16[1];		 }
				uint32*		&PtrU32()				{ return pu32[1];		 }
				uint64*		&PtrU64()				{ return pu64[1];		 }
				sint8*		&PtrS8()				{ return ps8[1];		 }
				sint16*		&PtrS16()				{ return ps16[1];		 }
				sint32*		&PtrS32()				{ return ps32[1];		 }
				sint64*		&PtrS64()				{ return ps64[1];		 }
				float32*	&PtrF32()				{ return pf32[1];		 }
				float64*	&PtrF64()				{ return pf64[1];		 }
				uint8&		ValU8()					{	return u8[7];			 }
				uint16&		ValU16()				{ return u16[3];		 }
				uint32&		ValU32()				{ return u32[1];		 }
				uint64&		ValU64()				{ return u64;				 }
				sint8&		ValS8()					{	return s8[7];			 }
				sint16&		ValS16()				{ return s16[3];		 }
				sint32&		ValS32()				{ return s32[1];		 }
				sint64&		ValS64()				{ return s64;				 }
				float32&	ValF32()				{ return f32[1];		 }
				float64&	ValF64()				{ return f64;				 }
				uint32		MSW()						{ return u32[0];		 }
				uint32		LSW()						{ return u32[1];		 }
			#else
				void*			Data8()					{	return u8;	}
				void*			Data16()				{ return u16;	}
				void*			Data32()				{ return u32; }
				void*			Data64()				{ return &u64; }
				void*			Data(uint32 s)	{ return &u64; }
				char*			&PtrCh()				{ return pch[0];}
				uint8*		&PtrU8()				{ return pu8[0]; }
				uint16*		&PtrU16()				{ return pu16[0]; }
				uint32*		&PtrU32()				{ return pu32[0]; }
				uint64*		&PtrU64()				{ return pu64[0]; }
				sint8*		&PtrS8()				{ return ps8[0]; }
				sint16*		&PtrS16()				{ return ps16[0]; }
				sint32*		&PtrS32()				{ return ps32[0]; }
				sint64*		&PtrS64()				{ return ps64[0]; }
				float32*	&PtrF32()				{ return pf32[0];}
				float64*	&PtrF64()				{ return pf64[0];}
				uint8&		ValU8()					{	return u8[0];	}
				uint16&		ValU16()				{ return u16[0];}
				uint32&		ValU32()				{ return u32[0]; }
				uint64&		ValU64()				{ return u64; }
				sint8&		ValS8()					{	return s8[0];	}
				sint16&		ValS16()				{ return s16[0];}
				sint32&		ValS32()				{ return s32[0]; }
				sint64&		ValS64()				{ return s64; }
				float32&	ValF32()				{ return f32[0]; }
				float64&	ValF64()				{ return f64; }
				uint32		MSW()						{ return u32[1]; }
				uint32		LSW()						{ return u32[0]; }
			#endif
		}	gpRegs[32];

		GPR	imReg[2];

		union {
			uint8* u8;			uint16* u16;			uint32* u32;			uint64* u64;
			sint8* s8;			sint16* s16;			sint32* s32;			sint64* s64;
			float32* f32;		float64* f64;			char*		ch;				wchar_t* wch;
			void*		any;		GPR* reg;
		} op[3];

		uint32* 	instPtr;
		void*			dataSectPtr;
		void*			constSectPtr;
		uint32**	methodStack;
		uint64*		regStack;
		uint8*		stack;
		uint32		exitReg;
		sint32		countReg;


		uint32**	methodStackBase;
		uint32**	methodStackTop;
		uint8*		stackBase;
		uint8*		stackTop;
		uint64*		regStackBase;
		uint64*		regStackTop;

		VMOBJ*		vmObject;

		static OPFUNC instTable[256];
		static OPFUNC sysTable[256];
		static EAFUNC	eaTable[256];
		static sint32 illegalDone;
		static const char* resultString[NUM_EXITCODES];

		#include "VM_Funcs.hpp"

		sint32	Alloc(size_t stackSize, size_t methStackSize, size_t regStackSize=128);
		void		Free();

		sint32	GetPC() { if (vmObject && vmObject->Code()!=0) return (sint32)(instPtr - vmObject->Code()); return -1; }

		static	void	Execute(EX_ARGS);

	public:
		const char*		ExitResult()	{	return (const char*)resultString[exitReg]; }
		uint32				Execute(VMOBJ& prog);

		VMCORE();
		~VMCORE();
};



/////////////////////////////////////////////////////////////////////////////////////

#endif
