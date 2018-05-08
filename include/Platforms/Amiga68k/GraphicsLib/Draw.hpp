//****************************************************************************//
//** File:         DRAW.hpp ($NAME=DRAW.hpp)    				                    **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is included in AmigaOS 68K systems             **//
//** Library:      xGraphics                                                **//
//** Created:      2001-12-10                                               **//
//** Updated:      2002-02-01                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#ifndef _XSYSTEM_DRAW68K_HPP
#define _XSYSTEM_DRAW68K_HPP

#include <XSF/XSF.hpp>

extern "C" {
	#include <pragma/diskfont_lib.h>
	#include <pragma/warp3d_lib.h>
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xTEXSURF
//
//  Implements XSFIO
//
//  To do
//    Compress texture body data
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xTEXSURF : virtual public XSFOBJ, public AREA, private sys3DDEVICE {
	private:
		sysTEXTURE*	tex;
		void*				data;
		ARGB32*			pal;
		uint32			flags;
		enum {
			OWNPALETTE = 0x00000001
		};
	protected:
		sint32 ReadyForWrite();
		sint32 ReadyForRead();
		sint32 WriteBody(XSFIO& f);
		sint32 ReadBody(XSFIO& f);

	public:
		typedef enum {
			TXL_LUT_8					= 0, // 256 palette based
			TXL_ARGB_1555			= 1, // A RRRRRGG..GGGBBBB
			TXL_RGB_565				=	2, // RRRRR GGG..GGG BBBBB
			TXL_RGB_888				= 3, // RRRRRRRR..GGGGGGGG..BBBBBBBB
			TXL_ARGB_4444			= 4, // AAAA RRRR..GGGG BBBB
			TXL_ARGB_8888			= 5, // AAAAAAAA..RRRRRRRR..GGGGGGGG..BBBBBBBB
			TXL_ALPHA_8				= 6, // 8-bit Alpha only
			TXL_GREY_8				= 7, // 8-bit Greyscale R=G=B=GREY
			TXL_GA_88					= 8, // 8-bit Greyscale and 8-bit alpha
			TXL_INTSY_8				= 9, // 8-bit Intensity R=G=B=A=INTENSITY
			TXL_RGBA_8888			= 10,// RRRRRRRR..GGGGGGGG..BBBBBBBB..AAAAAAAA
			TXL_MAX_TYPES			= 11 // for arrays and stuff
		} TEXELTYPE;
		typedef enum {
			REPLACE				= W3D_REPLACE,
			DECAL					= W3D_DECAL,
			MODULATE			= W3D_MODULATE
		} ENVTYPE;
		typedef enum {
			CLAMP					= W3D_CLAMP,
			REPEAT				=	W3D_REPEAT
		} FILLTYPE;
		typedef enum {
			LINEAR				= W3D_LINEAR,
			NEAREST				= W3D_NEAREST,
			NEAR_MIP_NEAR	= W3D_NEAREST_MIP_NEAREST,
			LINR_MIP_NEAR	= W3D_LINEAR_MIP_NEAREST,
			NEAR_MIP_LINR	= W3D_NEAREST_MIP_LINEAR,
			LINR_MIP_LINR = W3D_LINEAR_MIP_LINEAR,
		} FILTERTYPE;

		bool				Bind();
		void				UnBind();
		sint32			Create(S_WH, TEXELTYPE fmt, ARGB32* p=0);
		sint32			Create(S_WH, ARGB32* p);
		void				Delete();

		sysTEXTURE*	Handle()	{ return tex; }
		void*				Data()		{ return data; }
		ARGB32*			Palette()	{ return pal; }

		void		Environment(ENVTYPE p)														{ W3D_SetTexEnv(context, tex, p, 0); }
		void		Filter(FILTERTYPE max, FILTERTYPE min=NEAREST)		{ W3D_SetFilter(context, tex, min, max); }

	public:
		xTEXSURF();
		~xTEXSURF() { Delete(); }
};


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xFONT
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

class DRAWLIST;

class xFONT {
	public:
		enum {
			XF_FIXED	= 0x00000001,
			XF_PROP		= 0x00000002,
			XF_MONO		= 0x00000004,	// mono just uses alpha texture
			XF_COLOUR	= 0x00000008, // colour uses ARGB type texture
			XF_DESIGN	= 0x0000000F,
			XF_ASCII7	= 0x00000010,
			XF_LATIN8	= 0x00000100,
			XF_ISO98	= 0x00000200,
			XF_7BIT		= 0x000000F0,
			XF_8BIT		= 0x00000F00,
			XF_WIDE16	= 0x0000F000,
			XF_WIDE32	= 0x000F0000
		};
	public:
		virtual ~xFONT() {}

		virtual void Bold()  {};
		virtual void Italic() {};
		virtual void Normal() {};
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xTEXFONT
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


struct xRECT16 {
	sint16 x1,y1,x2,y2;
};

class xTEXFONT : private xTEXSURF, public xFONT {
	private:
		uint32			flags;
		sint32			size; // printing char height
		union {
			struct {
				sint16	glyphW; // texture sub image size
				sint16	glyphH; // "" "" "" "" "" "" "" "
				sint16	printW; // printing char width
				sint16	cps;		// chars per texture span
			} fixed;
			struct {
				xRECT16*	glyphs;			// array of numChars topleft/botRight coord sets (texel units) for character data
				sint16*		spacing;		// array of numChars character spacing data (texel units)
			} prop;
		};

	public:
		sint32		SetFixed(sint16 W, sint16 H, sint16 glW, sint16 glH, sint16 glSpan);
		sint32		Size()					{ return size; }
		sint16		Width(uint32 c) { if (flags & XF_FIXED) return fixed.printW; if (flags & XF_PROP) return prop.spacing[c]; return 0; }
		sint32		LoadFixedPGM(const char* name);
		void			Delete();

		void			WriteText(DRAWLIST* draw, uint32 col, S_XY, char* text);
		void			WriteTextF(DRAWLIST* draw, uint32 col, S_XY, char* text,...); // formatted text

	public:
		xTEXFONT() : xTEXSURF(), flags(0), size(0) {}
		~xTEXFONT() { Delete(); }
};



///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DRAW
//
//  High level immediate mode access to drawing hardware
//
//  When using full screen, multibuffered display, must call Swap() after refreshing display
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

class DRAW : virtual public x3D, virtual public x2D {
	private:
		static uint32		flags;

	protected:

		enum {
			UNLOCKED			= 0x00000000,
			LOCKED				= 0x00000001
		};

	public:
		static sint32		Bind(xSURFACE* s);
		static bool			Swap(xSURFACE* s){ return x3D::DrawSurface(s); } // for double buffered screens
		static sint32		Release();
		static bool			LockHW()				{ return x3D::LockHW(); }
		static void			UnLockHW()			{ x3D::UnLockHW(); }
		static bool			Locked()				{ return x3D::Locked(); }

	public:
		static sint32		Init();
		static sint32		Done();
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DCOMMAND  GPU command stucture. Represents a single command processed by the VGPU class
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct DCOMMAND {
	uint32 opcode;
	union {
		sint32			numVerts;
		uint32			colour;
		uint32			state;
		uint32			data;
		float32			depth;
		sysTEXTURE* texture;
		sysSURFACE*	surf;
		DVERTEX*		vertBase;
		void*				anyHex;
		void*				arg;
	};
};

// opcodes
enum {
	NOOP					= 0,	// nothing
	DONE,								// End of the list
	RSRVD,							// Any drawing operations pruned by an optimizer are set to RSRVD
	CLIP,								// sets the drawing area
	CLEAR_RGB,					//
	CLEAR_DEPTH,				//
	DRW_POINTS,					// these are all vertex array compatible operations
	DRW_LINES,					// ..
	DRW_LINESTRIP,			// ..
	DRW_TRIANGLES,			// ..
	DRW_TRIFAN,					// ..
	DRW_TRISTRIP,				// ..
	DRW_OSTEXT,					// .. basic OS level text rendering
	BLIT,								// blits from source bitmap to destination
	BLIT2,							// blits to bitmap from draw surface
	BLENDPARMS,					//
	FOGPARMS,						//
	MASKRGB,						//
	SET_COLOUR,					// Flat shading mode colour
	SET_TEXTURE,				// current texture
	SET_LOGIC,					// logic operation
	SET_FOG,						//
	SET_ZMODE,					//
	SET_AMODE,					//
	ENABLE_STATE,				// drawing states
	DISABLE_STATE,			//
	LOCKHW,							//
	PUSH_DVS,						// Allows changing of vertex buffers via stack system
	POP_DVS,						//
	ABORT,
	BREAKPT,
	JSR,								// allows a jump to another list
	RET,								// returns to previous list
	MAX_OPCODE					// name "<illegal>"
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  VGPU:: Back end of drawlist system, responsible for executing DCOMMAND instructions
//
//  VGPU class is back end of DRAWLIST system
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

typedef void (*GPUCODE)(REGP(0) void* arg); // function that executes an opcode

#define DVSTACK_DEPTH 16

class VGPU : private DRAW {
	private:
		static struct DVSTACKDATA {
			DVERTEX*	vertexBase;
			sint32		vertexPos;
		} stack[DVSTACK_DEPTH];

		static sint32				stackPos;
		static DVERTEX*			vertexBase;
		static DVERTEX*			vertexTop;
		static sint32				dataPos;
		static sint32				instPos;
		static uint32				exe_flags;
		static uint32				exe_stateReg;
		static uint32				exe_colourReg;
		static sysTEXTURE*	exe_texReg;
		static uint32				exe_fogReg;
		static uint32				exe_errReg;
		static GPUCODE			funcTab[MAX_OPCODE];

		static void					_DrawDummy(REGP(0) void* arg);
		static void					_Skip(REGP(0) void* arg);
		static void					_Clip(REGP(0) void* arg);
		static void					_ClearRGB(REGP(0) void* arg);
		static void					_ClearDepth(REGP(0) void* arg);
		static void					_DrawPoints(REGP(0) void* arg);
		static void					_DrawLines(REGP(0) void* arg);
		static void					_DrawLineStrip(REGP(0) void* arg);
		static void					_DrawTris(REGP(0) void* arg);
		static void					_DrawTrifan(REGP(0) void* arg);
		static void					_DrawTriStrip(REGP(0) void* arg);
		static void					_DrawOSText(REGP(0) void* arg);
		static void					_Blit(REGP(0) void* arg);
		static void					_Blit2(REGP(0) void* arg);
		static void					_BlendMode(REGP(0) void* arg);
		static void					_FogParms(REGP(0) void* arg);
		static void					_ColourMask(REGP(0) void* arg);
		static void					_SetColour(REGP(0) void* arg);
		static void					_SetTexture(REGP(0) void* arg);
		static void					_SetLogic(REGP(0) void* arg);
		static void					_SetFogMode(REGP(0) void* arg);
		static void					_SetZCompare(REGP(0) void* arg);
		static void					_SetACompare(REGP(0) void* arg);
		static void					_Enable(REGP(0) void* arg);
		static void					_Disable(REGP(0) void* arg);
		static void					_Lock(REGP(0) void* arg);
		static void					_PushDVS(REGP(0) void* arg);
		static void					_PopDVS(REGP(0) void* arg);
		static void					_Abort(REGP(0) void* arg);
		static void					_BreakPoint(REGP(0) void* arg);
		#ifdef X_VERBOSE
		static char*				opcodes[];
		#endif
		enum	{
			ERR_NONE	= 0,
			ERR_LOCK,
			ERR_DRAW,
			ERR_STACK_OVER,
			ERR_STACK_UNDER,
			ERR_UNDEF
		};

	public:
		#ifdef X_VERBOSE
		static char*				Opcode(sint32 code) { if (code<0||code>=MAX_OPCODE) return opcodes[MAX_OPCODE]; return opcodes[code];}
		#endif
		static sint32				ExecuteBuffer(bool initRegs, DCOMMAND* insts, DVERTEX* data, sint32 cnt, sint32 dcnt);
};


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DRAWLIST
//
//  Drawlists are an instruction queue and vertex buffer combined. A high level interface provides various
//  2D operations.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Warp3D V4 Array functions do not seem to draw anything when using lines
// as a primitive. Until I root out the problem, gonna draw old style lines (bugger!)
#define LINES_OLD

// trig table used by quadrics
#define DRAW_TSIZE 16

// useful abbeviations
#define TEXARG xTEXSURF* t, sint16 tOfsX, sint16 tOfsY, float32 tSclX, float32 tSclY
#define DEFTEXARG xTEXSURF* t, sint16 tOfsX=0, sint16 tOfsY=0, float32 tSclX=1.0, float32 tSclY=1.0

// fixes a small W3D bug caused by certian state changes
#define STATE_FIX

class DRAWLIST : protected DRAW {
	friend class xTEXFONT;
	private:
		uint32			flags;
		DVERTEX*		vertBuf;
		DCOMMAND*		instBuf;
		DVERTEX*		currVert;
		DCOMMAND*		currInst;
		sint32			vBufSize;
		sint32			iBufSize;
		sint32			vertsUsed;
		sint32			instsUsed;
		sint32			currFlushCnt;
		sint32			breakCnt;
		sint32			nestCount;

		// principal registers
		uint32			commandReg;
		uint32			stateReg;
		uint32			colourReg;
		float32			depthReg;
		float32			alphaReg;
		sysTEXTURE*	texReg;
		LMODE				logicReg;
		FMODE				fogReg;
		ZMODE				zTestReg;
		AMODE				aTestReg;

		static float32	qTrigTab[DRAW_TSIZE+1];

	#ifdef STATE_FIX
		enum {
			ENFORCESTATE	= 0x10000000
		};
	#endif

		sint32				Flush(); // This actually commits the drawing, using VGPU::ExecuteBuffer()
		void					InitRegs();

	#ifdef X_VERBOSE
		void					DumpVerts(ostream& out, sint32 start, sint32 num);
		void					DumpCoords1(ostream& out, sint32 num);
		void					DumpCoords2(ostream& out, sint32 num);
		void					DumpCoords3(ostream& out, sint32 num);
		void					DumpCoords3F(ostream& out, sint32 num);
	#endif


	public:
		enum {
			LOCKSTATE			= 0x00000001,
			MAKELIST			= 0x00000002 // list under construction
		};

		// Low level buffered drawing
		void					LockMode(ruint32 s); // either LOCKED or UNLOCKED
		void					SetColour(uint32 colour);
		uint32				GetColour()								 { return colourReg; }
		void					SetTexture(xTEXSURF* t);
		uint32				Flag(ruint32 f=0xFFFFFFFF) { return flags & f; }
		DVERTEX*			GetVertices(sint32 n, bool immediate=true); // allocates n volatile vertices in the draw buffer.
		sint32				SetVertices(DVERTEX* v);										// This changes the vertex buffer pointer, can be external
		sint32				RestoreVertices();													// This restores the previous vertex buffer pointer
		void					Lines(sint32 n);
		void					LineStrip(sint32 n);
		void					Tris(sint32 n);
		void					TriStrip(sint32 n);
		void					TriFan(sint32 n);
		bool					Enabled(STATE s) 		{ return (stateReg & s)!=0; }
		float32				GetDepthValue()			{ return depthReg; }
		float32				GetAlphaRefValue()	{ return alphaReg; }
		LMODE					GetLogicMode()			{ return logicReg; }
		FMODE					GetFogMode()				{ return fogReg; }
		ZMODE					GetZCompareMode()		{ return zTestReg; }
		AMODE					GetACompareMode()		{ return aTestReg; }

	public:
		// Simple 2D high level buffered interface
		void					Line(uint32 colour, S_2CRD);
		void					LineShA(uint32* colour, S_2CRD);

		void					Tri(uint32 colour, S_3CRD);
		void					TriShA(uint32* colour, S_3CRD);

		void					Rect(uint32 colour, S_2CRD);
		void					RectShH(uint32* colour, S_2CRD);
		void					RectShV(uint32* colour, S_2CRD);
		void					RectShA(uint32* colour, S_2CRD);
		void					RectTlTx(uint32 colour, S_2CRD, DEFTEXARG);
		void					RectTlTxShH(uint32* colour, S_2CRD, DEFTEXARG);
		void					RectTlTxShV(uint32* colour, S_2CRD, DEFTEXARG);
		void					RectTlTxShA(uint32* colour, S_2CRD, DEFTEXARG);
		void					RectScTx(uint32 colour, S_2CRD, DEFTEXARG);
		void					RectScTxShH(uint32* colour, S_2CRD, DEFTEXARG);
		void					RectScTxShV(uint32* colour, S_2CRD, DEFTEXARG);
		void					RectScTxShA(uint32* colour, S_2CRD, DEFTEXARG);

		void					Circle(uint32 colour, S_1CRD, sint16 rad);
		void					CircleShC(uint32* colour, S_1CRD, sint16 rad);
		void					CircleShPt(uint32* colour, S_2CRD, sint16 rad);
/*
		void					CircleScTx(uint32 colour, S_1CRD, sint16 rad, xTEXSURF* t);
		void					CircleScTxShC(uint32* colour, S_1CRD, sint16 rad, xTEXSURF* t);
		void					CircleScTxShPt(uint32* colour, S_2CRD, sint16 rad, xTEXSURF* t);
*/
		void					Elipse(uint32 col, S_2CRD);
		void					ElipseShC(uint32* col, S_2CRD);
		void					ElipseShPt(uint32* col, S_3CRD);
/*
		void					ElipseScTx(uint32 col, S_2CRD, xTEXSURF* t);
		void					ElipseScTxShC(uint32* col, S_2CRD, xTEXSURF* t);
		void					ElipseScTxShPt(uint32* col, S_3CRD, xTEXSURF* t);
*/
		void					Clear(uint32 col);
		void					ClearDepth(float32 z);
		void					Clip(S_2CRD);
		void					Blit(xSURFACE* s, S_3CRD);
		void					Depth(rfloat32 z)									{ depthReg = ClipFloat(z, 0.0, 1.0); }
		void					DepthCompareMode(ZMODE zmode);
		void					AlphaCompareMode(AMODE amode, float32 ref);
		void					BlendMode(BFUNC s, BFUNC d);
		void					FogParms(uint32 colour, float32 start, float32 end, float32 density, FMODE fmode);
		void					LogicMode(LMODE l);
		void					FogMode(FMODE f);
		void					Enable(STATE s);
		void					Disable(STATE s);
		sint32				Begin();
		sint32				End();

	#ifdef X_VERBOSE
		void					Dump(ostream& out, bool showVerts=false);
	#endif
	#ifdef X_DEBUG
		void					XDebug_BreakPoint();
	#endif

		sint32				Create(sint32 vBuf, sint32 cBuf);
		void					Delete();
	public:
		DRAWLIST();
		DRAWLIST(sint32 vBuf, sint32 cBuf);
		~DRAWLIST();
};

/////////////////////////////////////////////////////////////////////////////////////////////
//
//  INLINE FUNCTIONS
//
/////////////////////////////////////////////////////////////////////////////////////////////

inline void DRAWLIST::LockMode(ruint32 s)
{
	if ( (flags & LOCKSTATE) == s)
		return;

	if (s)	flags |= LOCKED;
	else		flags &= ~LOCKED;

	if (commandReg==LOCKHW)		(currInst-1)->data = s;
	else
	{
		commandReg = currInst->opcode = LOCKHW; (currInst++)->data = s;
		instsUsed++;
	}
}


#endif