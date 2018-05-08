//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _VIRTUALMACHINE_2_OBJCODE_HPP
#define _VIRTUALMACHINE_2_OBJCODE_HPP

#include <xBase.hpp>

#include "VM_Opts.hpp"
#include "VM_Code.hpp"

#include <xSystem/xIO.hpp>
#include <XSF/XSF.hpp>

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
//
/////////////////////////////////////////////////////////////////////////////////////

class VMOBJ : public XSFOBJ {

	private:
		// this data portion is xsf persistent. Putting it into a structure allows
		// easier XSF RawSize evaluation
		struct SHARED32 {
			uint32	codeLen;			// in instruction words
			uint32	data64Len;		// in bytes
			uint32	data32Len;		// in bytes
			uint32	data16Len;		// in bytes

			uint32	data8Len;			// in bytes
			uint32	const64Len;		// in bytes
			uint32	const32Len;		// in bytes
			uint32	const16Len;		// in bytes

			uint32	const8Len;		// in bytes
			uint32	stackSize;		// in bytes
			uint32	methodSize;		// in units
			uint32	regSize;			// in units
			uint32	checksum;

			SHARED32() : codeLen(0), data64Len(0), data32Len(0), data16Len(0), data8Len(0), const64Len(0), const32Len(0),
									const16Len(0), const8Len(0), stackSize(0), methodSize(0), regSize(0), checksum(0xBABECAFE) {}
		} shared32;

		struct SHARED16 {
			sint16	progVersion;
			sint16	progRevision;

			SHARED16() : progVersion(0), progRevision(0) {}
		} shared16;

		struct SHARED8 {
			char progName[32];
			SHARED8() { memset(progName,0,32); }
		} shared8;

		uint32*	code;
		uint64*	wrtblData;
		uint64*	constData;
		static const char* XSFIDString;

		void		Free();
		sint32	Alloc();

	protected:
		sint32	WriteBody(XSFIO& f);
		sint32	ReadBody(XSFIO& f);

	public:
		static const char*	XSFFileSig;
		static const uint16	XSFSuperClass;
		static const uint16	XSFSubClass;
		static const uint8	XSFDataFormat;
		static const uint8	XSFFileFormat;

	public:
		uint32*			Code()					{ return code; }
		void*				Data()					{ return wrtblData; }
		void*				Cnst()					{ return constData; }
		size_t			Stack()					{ return shared32.stackSize; }
		size_t			MethodStack()		{ return shared32.methodSize; }
		size_t			RegisterStack()	{ return shared32.regSize; }
		sint16			Version()				{ return shared16.progVersion; }
		sint16			Revision()			{ return shared16.progRevision; }
		const char*	Name()					{ return (const char*)shared8.progName; }
		sint32			Create(char* n, sint16 v, sint16 r, size_t I, size_t S, size_t MS, size_t RS, size_t D64, size_t D32, size_t D16, size_t D8, size_t C64, size_t C32, size_t C16, size_t C8);

		uint32			CodeSize();
		uint32			DataSize();
		uint32			CnstSize();

		VMOBJ();
		~VMOBJ();
};

/////////////////////////////////////////////////////////////////////////////////////

#endif
