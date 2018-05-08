//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author       	Karl Churchill                               **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xBase.hpp>
#include "JasmineCode.hpp"

#include <xSystem/xResources.hpp>

#include <Platforms/Amiga68K/ServiceLib/Thread.hpp>

class THREADTEST : public THREAD {

	static SignalSemaphore	lock;
	static sint32						cnt;
	protected:
		sint32 Run();

	public:
		THREADTEST();
		~THREADTEST();
};


SignalSemaphore	THREADTEST::lock = {0};
sint32					THREADTEST::cnt = 0;

THREADTEST::THREADTEST()
{
	if (0==cnt++)
	{
		InitSemaphore(&lock);
		puts("Semaphore created");
	}
}

THREADTEST::~THREADTEST()
{
	Remove();
	if (0==--cnt)
	{
		puts("Semaphore destroyed");
	}
}


sint32 THREADTEST::Run()
{
	sint32 i = 0;
	while(ShutDown()==0)
	{
		if (AttemptSemaphore(&lock))
		{
			printf("%s i = %d\n", Name(), i);
			ReleaseSemaphore(&lock);
		}
		i++;
		Sleep(500);
	}
	ObtainSemaphore(&lock);
	printf("%s bye!\n", Name());
	ReleaseSemaphore(&lock);
	return i;
}

struct OPDEFS {
	const char* opcode;
	const char* mnemonic;
	const char* ea1;
	const char* ea2;
	const char* ea3;
	const char* ext;
};

/*
static const char* eaMode[256] =
{
	"r0",							"r1",							"r2",						"r3",						"r4",						"r5",						"r6",						"r7",
	"r8",							"r9",							"r10",					"r11",					"r12",					"r13",					"r14",					"r15",
	"r16",						"r17",						"r18",					"r19",					"r20",					"r21",					"r22",					"r23",
	"r24",						"r25",						"r26",					"r27",					"r28",					"r29",					"r30",					"r31",

	"(r0)",						"(r1)",						"(r2)",					"(r3)",				 	"(r4)",					"(r5)",					"(r6)",					"(r7)",
	"(r8)",						"(r9)",						"(r10)",				"(r11)",				"(r12)",				"(r13)",				"(r14)",				"(r15)",
	"(r16)",					"(r17)",					"(r18)",				"(r19)",				"(r20)",				"(r21)",				"(r22)",				"(r23)",
	"(r24)",					"(r25)",					"(r26)",				"(r27)",				"(r28)",				"(r29)",				"(r30)",				"(r31)",

	"(r0,#%d)",				"(r1,#%d)",				"(r2,#%d)",			"(r3,#%d)", 		"(r4,#%d)",			"(r5,#%d)",			"(r6,#%d)",			"(r7,#%d)",
	"(r8,#%d)",				"(r9,#%d)",				"(r10,#%d)",		"(r11,#%d)",		"(r12,#%d)",		"(r13,#%d)",		"(r14,#%d)",		"(r15,#%d)",
	"(r16,#%d)",			"(r17,#%d)",			"(r18,#%d)",		"(r19,#%d)",		"(r20,#%d)",		"(r21,#%d)",		"(r22,#%d)",		"(r23,#%d)",
	"(r24,#%d)",			"(r25,#%d)",			"(r26,#%d)",		"(r27,#%d)",		"(r28,#%d)",		"(r29,#%d)",		"(r30,#%d)",		"(r31,#%d)",

	"(r0,#%d)+",			"(r1,#%d)+",			"(r2,#%d)+",		"(r3,#%d)+", 		"(r4,#%d)+",		"(r5,#%d)+",		"(r6,#%d)+",		"(r7,#%d)+",
	"(r8,#%d)+",			"(r9,#%d)+",			"(r10,#%d)+",		"(r11,#%d)+",		"(r12,#%d)+",		"(r13,#%d)+",		"(r14,#%d)+",		"(r15,#%d)+",
	"(r16,#%d)+",			"(r17,#%d)+",			"(r18,#%d)+",		"(r19,#%d)+",		"(r20,#%d)+",		"(r21,#%d)+",		"(r22,#%d)+",		"(r23,#%d)+",
	"(r24,#%d)+",			"(r25,#%d)+",			"(r26,#%d)+",		"(r27,#%d)+",		"(r28,#%d)+",		"(r29,#%d)+",		"(r30,#%d)+",		"(r31,#%d)+",

	"(r%d,r%d)",			"(r%d,r%d)+",
	"(r%d,r%d,#%d)",	"(r%d,r%d,#%d)+",	"ctr",					"(data,#%d)", 	"(cnst,#%d)",		"#%d",					"(pc,#%d)",

	0
};


static const char* opcode[256] =
{
	"NOP",				"END",					"SYS",					"LEA",					"BRA",
	"BNEQ_I8",		"BNEQ_I16",			"BNEQ_I32",			"BNEQ_I64",			"BNEQ_f32",			"BNEQ_F64",
	"BLS_I8",			"BLS_I16",			"BLS_I32",			"BLS_I64",			"BLS_F32",			"BLS_F64",
	"BLSEQ_I8",		"BLSEQ_I16",		"BLSEQ_I32",		"BLSEQ_I64",		"BLSEQ_F32",		"BLSEQ_F64",
	"BEQ_I8",			"BEQ_I16",			"BEQ_I32",			"BEQ_I64",			"BEQ_F32",			"BEQ_F64",
	"BGREQ_I8",		"BGREQ_I16",		"BGREQ_I32",		"BGREQ_I64",		"BGREQ_F32",		"BGREQ_F64",
	"BGR_I8",			"BGR_I16",			"BGR_I32",			"BGR_I64",			"BGR_F32",			"BGR_F64",

	"CALL",				"RET",

	"PUSH_X8",		"PUSH_X16",			"PUSH_X32",			"PUSH_X64",
	"POP_X8",			"POP_X16",			"POP_X32",			"POP_X64",
	"SAVE",				"RESTORE",
	"CLR_X8",			"CLR_X16",			"CLR_X32",			"CLR_X64",
	"MOVE_X8",		"MOVE_X16",			"MOVE_X32",			"MOVE_X64",

	"EMOV_X16",		"EMOV_X32",			"EMOV_X64",
	"SWAP_X8",		"SWAP_X16",			"SWAP_X32",			"SWAP_X64",

	"S16_S8",			"S32_S8",				"S64_S8",				"F32_S8",				"F64_S8",
	"S32_S16",		"S64_S16",			"F32_S32",			"F64_S16",
	"S64_S32",		"F32_S32",			"F64_S32",
	"F32_S64",		"F64_S32",
	"F64_S64",

	"F32_F64",		"S64_F64",			"S32_F64",			"S16_F64",			"S8_F64",
	"S64_F32",		"S32_F32",			"S16_F32",			"S8_F32",
	"S32_S64",		"S16_S64",			"S8_S64",
	"S16_S32",		"S8_S32",
	"S8_S16",

	"I16_U8",			"I32_U8",				"I64_U8",				"F32_U8",				"F64_U8",
 	"I32_U16",		"I64_U16",			"F32_U16",			"F64_U16",
	"I64_U32",		"F32_U32",			"F64_U32",
	"F32_U64",		"F64_U64",

	"U64_F64",		"U32_F64",			"U16_F64",			"U8_F64",
	"U64_F32",		"U32_F32",			"U16_F32",			"U8_F32",
	"U32_I64",		"U16_I64",			"U8_I64",
	"U16_I32",		"U8_I32",
	"U8_I16",

	"ADD_I8",			"ADD_I16",			"ADD_I32",			"ADD_I64",			"ADD_F32",			"ADD_F64",
	"SUB_I8",			"SUB_I16",			"SUB_I32",			"SUB_I64",			"SUB_F32",			"SUB_F64",
	"MUL_U8",			"MUL_U16",			"MUL_U32",			"MUL_U64",
	"MUL_I8",			"MUL_I16",			"MUL_I32",			"MUL_I64",			"MUL_F32",			"MUL_F64",
	"DIV_U8",			"DIV_U16",			"DIV_U32",			"DIV_U64",
	"DIV_I8",			"DIV_I16",			"DIV_I32",			"DIV_I64",			"DIV_F32",			"DIV_F64",
	"MOD_U8",			"MOD_U16",			"MOD_U32",			"MOD_U64",
	"MOD_I8",			"MOD_I16",			"MOD_I32",			"MOD_I64",			"MOD_F32",			"MOD_F64",

	"NEG_I8",			"NEG_I16",			"NEG_I32",			"NEG_I64",			"NEG_F32",			"NEG_F64",
	"SHL_I8",			"SHL_I16",			"SHL_I32",			"SHL_I64",
	"SHR_I8",			"SHR_I16",			"SHR_I32",			"SHR_I64",
	"AND_X8",			"AND_X16",			"AND_X32",			"AND_X64",
	"OR_X8",			"OR_X16",				"OR_X32",				"OR_X64",
	"XOR_X8",			"XOR_X16",			"XOR_X32",			"XOR_X64",
	"INV_X8",			"INV_X16",			"INV_X32",			"INV_X64",

	"SHL_X8",			"SHL_X16",			"SHL_X32",			"SHL_X64",
	"SHR_X8",			"SHR_X16",			"SHR_X32",			"SHR_X64",
	"NEW_OBJ",
	"DEL_OBJ",
	"CALL_STATIC",
	"CALL_METHOD",
	"CALL_VIRTUAL",
	"CALL_NATIVE",
	0
};

static const char* sysOpcode[256] = {
	"SYS_OUT_U8",			"SYS_OUT_U16",				"SYS_OUT_U32",				"SYS_OUT_U64",
	"SYS_OUT_S8",			"SYS_OUT_S16",				"SYS_OUT_S32",				"SYS_OUT_S64",
	"SYS_OUT_F32",		"SYS_OUT_F64",				"SYS_OUT_STR",
	"SYS_INP_U8",			"SYS_INP_U16",				"SYS_INP_U32",				"SYS_INP_U64",
	"SYS_INP_S8",			"SYS_INP_S16",				"SYS_INP_S32",				"SYS_INP_S64",
	"SYS_INP_F32",		"SYS_INP_F64",				"SYS_INP_STR",
	"SYS_BRK",				"SYS_DUMP",						"SYS_VER",
	"SYS_NEW_X8",			"SYS_NEW_X16",				"SYS_NEW_X32",				"SYS_NEW_X64",
	"SYS_DEL_X8",			"SYS_DEL_X16",				"SYS_DEL_X32",				"SYS_DEL_X64",
	0
};


static const char* mnemonic[256] =
{
	"nop",				"end",					"",							"lea",					"bra",
	"bneq.i8",		"bneq.i16",			"bneq.i32",			"bneq.i64",			"bneq.f32",			"bneq.f64",
	"bls.i8",			"bls.i16",			"bls.i32",			"bls.i64",			"bls.f32",			"bls.f64",
	"blseq.i8",		"blseq.i16",		"blseq.i32",		"blseq.i64",		"blseq.f32",		"blseq.f64",
	"beq.i8",			"beq.i16",			"beq.i32",			"beq.i64",			"beq.f32",			"beq.f64",
	"bgreq.i8",		"bgreq.i16",		"bgreq.i32",		"bgreq.i64",		"bgreq.f32",		"bgreq.f64",
	"bgr.i8",			"bgr.i16",			"bgr.i32",			"bgr.i64",			"bgr.f32",			"bgr.f64",

	"call",				"ret",

	"push.8",			"push.16",			"push.32",			"push.64",
	"pop.8",			"pop.16",				"pop.32",				"pop.64",
	"save",				"restore",
	"clr.8",			"clr.16",				"clr.32",				"clr.64",
	"move.8",			"move.16",			"move.32",			"move.64",

	"emov.16",		"emov.32",			"emov.64",
	"swap.8",			"swap.16",			"swap.32",			"swap.64",

	"s16.s8",			"s32.s8",				"s64.s8",				"f32.s8",				"f64.s8",
	"s32.s16",		"s64.s16",			"f32.s16",			"f64.s16",
	"s64.s32",		"f32.s32",			"f64.s32",
	"f32.s64",		"f64.s64",
	"f64.f32",

	"f32.f64",		"s64.f64",			"s32.f64",			"s16.f64",			"s8.f64",
	"s64.f32",		"s32.f32",			"s16.f32",			"s8.f32",
	"s32.s64",		"s16.s64",			"s8.s64",
	"s16.s32",		"s8.s32",
	"s8.s16",

	"s16.u8",			"s32.u8",				"s64.u8",				"f32.u8",				"f64.u8",
	"s32.u16",		"s64.u16",			"f32.u16",			"f64.u16",
	"s64.u32",		"f32.u32",			"f64.u32",
	"f32.u64",		"f64.u64",

	"u64.f64",		"u32.f64",			"u16.f64",			"u8.f64",
	"u64.f32",		"u32.f32",			"u16.f32",			"u8.f32",
	"u32.s64",		"u16.s64",			"u8.s64",
	"u16.s32",		"u8.s32",
	"u8.s16",

	"add.i8",			"add.i16",			"add.i32",			"add.i64",			"add.f32",			"add.f64",
	"sub.i8",			"sub.i16",			"sub.i32",			"sub.i64",			"sub.f32",			"sub.f64",
	"mul.u8",			"mul.u16",			"mul.u32",			"mul.u64",
	"mul.s8",			"mul.s16",			"mul.s32",			"mul.s64",			"mul.f32",			"mul.f64",
	"div.u8",			"div.u16",			"div.u32",			"div.u64",
	"div.s8",			"div.s16",			"div.s32",			"div.s64",			"div.f32",			"div.f64",
	"mod.u8",			"mod.u16",			"mod.u32",			"mod.u64",
	"mod.s8",			"mod.s16",			"mod.s32",			"mod.s64",			"mod.f32",			"mod.f64",

	"neg.i8",			"neg.i16",			"neg.i32",			"neg.i64",			"neg.f32",			"neg.f64",
	"shl.i8",			"shl.i16",			"shl.i32",			"shl.i64",
	"shr.i8",			"shr.i16",			"shr.i32",			"shr.i64",
	"and.8",			"and.16",				"and.32",				"and.64",
	"or.8",				"or.16",				"or.32",				"or.64",
	"xor.8",			"xor.16",				"xor.32",				"xor.64",
	"not.8",			"not.16",				"not.32",				"not.64",

	"shl.8",			"shl.16",				"shl.32",				"shl.64",
	"shr.8",			"shr.16",				"shr.32",				"shr.64",

	"newobj",
	"delobj",
	"callst",
	"callmd",
	"callv",
	"calln",
	0
};

static const char* sysMnemonics[256] = {
	"print.u8",		"print.u16",		"print.u32",		"print.u64",
	"print.s8",		"print.s16",		"print.s32",		"print.s64",
	"print.f32",	"print.f64",		"print",
	"read.u8",		"read.u16",			"read.u32",			"read.u64",
	"read.s8",		"read.s16",			"read.s32",			"read.s64",
	"read.f32",		"read.f64",			"read",
	"break",			"dump",					"ver",
	"new.8",			"new.16",				"new.32",				"new.64",
	"del.8",			"del.16",				"del.32",				"del.64",
	0
};
*/


extern "C" uint32		FloatToUint(register __fp0 float64 x);
extern "C" float64	UintToFloat(register __d0 uint32 x);
extern "C" float64	Uint64ToFloat(register __d0 uint32 msw, register __d1 uint32 lsw);
extern "C" float64	Sint64ToFloat(register __d0 sint32 msw, register __d1 uint32 lsw);

extern float64 Sint64ToFloat64(register __a0 sint64&);

int main(int argc, char** argv)
{
	if (xBASELIB::Init()!=OK)
	{
		puts("Error initializing base library");
		return 10;
	}
	/*	for (sint32 i=0; i<VM::NUM_OPS; i++)
	{
		printf("    %-16s 0x%X     00     00     00                %s\n", opcode[i], i, mnemonic[i]);
	}
*/

	//printf("0x%08X%08X\n",(&t)[0],(&t)[1]);

	#define THREADMAX 4

	printf("sizeof THREAD %u\n", sizeof(THREAD));
/*
	THREADTEST *threads = new THREADTEST[THREADMAX];
	for (sint32 i=0; i<THREADMAX; i++)
	{
		threads[i].Start(THREAD::PRI_MINIMUM);
		Delay(10);
	}
	sysBASELIB::MessageBox("Info", "OK", "Kill them threads");
	delete[] threads;
*/

	THREADTEST* t = new THREADTEST;
	if (t)
	{
		t->Start();
		sysBASELIB::MessageBox("Info", "OK", "Kill that thread");
		delete t;
	}

	xBASELIB::Done();
	return 0;
}

