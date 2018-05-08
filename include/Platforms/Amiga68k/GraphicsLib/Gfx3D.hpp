//****************************************************************************//
//** File:         xGraphics3D.hpp ($NAME=xGraphics3D.hpp)                  **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is included in AmigaOS 68K systems             **//
//** Library:      xGraphics                                                **//
//** Created:      2001-01-20                                               **//
//** Updated:      2002-01-07                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):      Sub header of xGraphics.hpp, not to be included alone    **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#ifndef _XSYSTEM_GRAPHICS3D_68K_HPP
#define _XSYSTEM_GRAPHICS3D_68K_HPP

// AmigaOS includes not included by sysBASE or xResources

extern "C" {
	#include <proto/Warp3D.h>
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extern	LIBRARY				*Warp3DBase;		// Graphics Card 3D extensions

typedef W3D_Texture		sysTEXTURE;
typedef W3D_Vertex		sysVERTEX;
typedef W3D_Color			sysCOLOUR4C;
typedef	W3D_ColorRGB	sysCOLOUR3C;
typedef W3D_Scissor		sysSCISSOR;

// Macros for handling sysVERTEX* This way you dont need to know the layout of sysVERTEX
// as these are platform dependent. Note that VTX_C() is the address of the vertex colour information

#define VTX_X(vtx)	((vtx)->x)					// base cordinates
#define VTX_Y(vtx)	((vtx)->y)
#define VTX_Z(vtx)	((vtx)->z)
#define VTX_W(vtx)	((vtx)->w)
#define	VTX_C(vtx)	(&(vtx)->color)			// vertex colour address
#define	VTX_CR(vtx)	((vtx)->color.r)		// colour values
#define	VTX_CG(vtx)	((vtx)->color.g)
#define	VTX_CB(vtx)	((vtx)->color.b)
#define	VTX_CA(vtx)	((vtx)->color.a)
#define VTX_U(vtx)	((vtx)->u)					// texture coordinates
#define VTX_V(vtx)	((vtx)->v)

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DVERTEX structure. Contains single 3D vertex or 8 other 32-bit data
//
//  Note that W3D vertex array funcs require a w coordinate to operate correctly
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct DVERTEX {
	//        vertex data     int crd data  float crd data
	union {		float32 x;			sint32 x1;		float32 fx1;	uint32 data1; };
	union {		float32 y;			sint32 y1;		float32 fy1;	uint32 data2; };
	union {		float32 z;			sint32 x2;		float32 fx2;	uint32 data3; };
	union {		float32 w;			sint32 y2;		float32 fy2;	uint32 data4; };
	union {		float32 u;			sint32 x3;		float32 fx3;	uint32 data5; };
	union {		float32 v;			sint32 y3;		float32 fy3;	uint32 data6; };
	union {		uint32	colour;	sint32 x4;		float32 fx4;	uint32 data7; };
	union {		float32 bright;	sint32 y4;		float32 fy4;	uint32 data8; };
};

// size defs for custom vertex array support
#define DV_OFS_XYZ	0									// byte offset of xyz data
#define DV_OFS_UV		4*sizeof(float32)	//  "     "    "  uv (texture coord) data
#define DV_OFS_W		-sizeof(float32)	//  "     "    "  w from uv
#define DV_OFS_V		sizeof(float32)		//  "     "    "  v from uv
#define DV_OFS_CLR	6*sizeof(float32)	//  "     "    "  colour data
#define DV_STRIDE		sizeof(DVERTEX)		//  "     "    "  sequential vertices

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  x3D
//
//  Handles 3D resource allocation, states and drawing operations (via vertex arrays)
//  This is primarily a base implementation class, used by higher level drawing routines that need fast access
//  to the hardware
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define X3D_POINTS_OLDSTYLE // vertex array points via emulation
#define X3D_LINES_OLDSTYLE	// vertex array lines via emulation
//#define X3D_TRIS_OLDSTYLE	// vertex array triangles via emulation

class xTEXTURE;

class sys3DDEVICE {
	protected:
		static W3D_Driver*	hw3D;
		static W3D_Context*	context;
};

class x3D : private sys3DDEVICE {
	friend class xTEXTURE;

	// USER LAYER
	public:
		typedef enum {
			TEXTURE				= W3D_TEXMAPPING,
			GOURAUD				= W3D_GOURAUD,
			TEXENV_GLOBAL	= W3D_GLOBALTEXENV,
			DEPTH_BUFFER	= W3D_ZBUFFER,
			DEPTH_UPDATE	= W3D_ZBUFFERUPDATE,
			DEPTH_CUE			= W3D_FOGGING,
			FOGGING				= W3D_FOGGING,
			BLEND					= W3D_BLENDING,
			ALPHA_BLEND		= W3D_BLENDING,
			ALPHA_TEST		= W3D_ALPHATEST,
			DITHERING			= W3D_DITHERING,
			CHROMA_TEST		= W3D_CHROMATEST,
			LOGIC					= W3D_LOGICOP
		} STATE;
		typedef enum {
			ALPHA_LT			= W3D_A_LESS,
			ALPHA_LEQ			= W3D_A_LEQUAL,
			ALPHA_EQ			= W3D_A_EQUAL,
			ALPHA_GEQ			= W3D_A_GEQUAL,
			ALPHA_GT			= W3D_A_GREATER,
			ALPHA_NEQ			= W3D_A_NOTEQUAL,
			ALPHA_NEVER		= W3D_A_NEVER,
			ALPHA_ALWAYS	= W3D_A_ALWAYS
		} AMODE;
		typedef enum {
			DEPTH_LT			= W3D_Z_LESS,
			DEPTH_LEQ			= W3D_Z_LEQUAL,
			DEPTH_EQ			= W3D_Z_EQUAL,
			DEPTH_GEQ			= W3D_Z_GEQUAL,
			DEPTH_GT			= W3D_Z_GREATER,
			DEPTH_NEQ			= W3D_Z_NOTEQUAL,
			DEPTH_NEVER		= W3D_Z_NEVER,
			DEPTH_ALWAYS	= W3D_Z_ALWAYS
		} ZMODE;
		typedef enum {
			L_CLEAR				= W3D_LO_CLEAR,
			L_AND					= W3D_LO_AND,
			L_S_AND_NOT_D	= W3D_LO_AND_REVERSE,
			L_COPY				= W3D_LO_COPY,
			L_NOT_S_AND_D	= W3D_LO_AND_INVERTED,
			L_NOP					= W3D_LO_NOOP,
			L_XOR					= W3D_LO_XOR,
			L_OR					= W3D_LO_OR,
			L_NOR					= W3D_LO_NOR,
			L_NXOR				= W3D_LO_EQUIV,
			L_NOT_D				= W3D_LO_INVERT,
			L_OR_NOT_D		= W3D_LO_OR_REVERSE,
			L_NOT_S				= W3D_LO_COPY_INVERTED,
			L_NOTS_OR_D		= W3D_LO_OR_INVERTED,
			L_NAND				= W3D_LO_NAND,
			L_SET					= W3D_LO_SET
		} LMODE;
		typedef enum {
			F_LINEAR	= W3D_FOG_LINEAR,
			F_EXP			= W3D_FOG_EXP,
			F_EXP2		= W3D_FOG_EXP_2
		} FMODE;
		typedef enum {
			ZERO						= W3D_ZERO,									// source + dest
			ONE							= W3D_ONE,									// source + dest
			PXL_RGB					= W3D_SRC_COLOR,						// dest only
			BUF_RGB					= W3D_DST_COLOR,						// source only
			PXL_INV_RGB			= W3D_ONE_MINUS_SRC_COLOR,	// dest only
			BUF_INV_RGB			= W3D_ONE_MINUS_DST_COLOR,	// source only
			PXL_ALPHA				= W3D_SRC_ALPHA,						// source + dest
			PXL_INV_ALPHA		= W3D_ONE_MINUS_SRC_ALPHA,	// source + dest
			BUF_ALPHA				= W3D_DST_ALPHA,						// source + dest
			BUF_INV_ALPHA		= W3D_ONE_MINUS_DST_ALPHA,	// source + dest
			PXL_ALPHA_SAT		= W3D_SRC_ALPHA_SATURATE,		// source only
			CONST_RGB				= W3D_CONSTANT_COLOR,
			INV_CONST_RGB		= W3D_ONE_MINUS_CONSTANT_COLOR,
			CONST_ALPHA			= W3D_CONSTANT_ALPHA,
			INV_CONST_ALPHA	= W3D_ONE_MINUS_CONSTANT_ALPHA
		} BFUNC;

	// Implementation
	private:
		static W3D_Scissor	drawRegion;
		static W3D_Fog			fogData;
		static uint32				flags;
		static DVERTEX*			vertices; // used by array emulation support
		static sysTEXTURE*	currTex;	// "" ""
		static xSURFACE*		drawSurface;
		static uint32				currCol;

		static bool					useV4;

		enum {
			LOCKED			= 0x00000001,
			GOT_ZBUFFER	= 0x00010000,
			GOT_STENCIL = 0x00020000
		};

		static bool	v3DrawPoints(sint32 ofst, sint32 vCnt)		{ return false; } // not implemented yet
		static bool	v3DrawLines(sint32 ofst, sint32 vCnt);
		static bool	v3DrawLineStrip(sint32 ofst, sint32 vCnt);
		static bool	v3DrawLineLoop(sint32 ofst, sint32 vCnt)	{ return false; }

	protected:
		enum {
			AUTOTEXTURE		= W3D_AUTOTEXMANAGEMENT,
			PERSPECTIVE		= W3D_PERSPECTIVE,
			SPECULAR			= W3D_SPECULAR,
			SCISSOR				= W3D_SCISSOR,
		};

		// Resource control
		static bool					DrawSurface(xSURFACE* s);
		static sint32				BuildContext(xSURFACE* s, bool indirect=false);
		static sint32				FreeContext();
		static W3D_Driver*	Driver()	{ return hw3D; }
		static W3D_Context*	Context()	{ return context; }
		static bool					isV4()		{ return useV4; }
/*
		static sysTEXTURE*	CreateTexture(S_WH, TX_SURFTYPE fmt, void* data, uint32* pal=0);
		static sint32				DeleteTexture(sysTEXTURE* t);
*/
		// Locking
		static bool		LockHW()	{
			if (flags & LOCKED)
				return true;
			if (W3D_LockHardware(context)==W3D_SUCCESS) {
				flags |= LOCKED;
				return true;
				}
				flags &=~LOCKED;
				return false;
			}

		static void		UnLockHW()	{
			flags &=~LOCKED;
			W3D_UnLockHardware(context);
		}

		static bool		Locked()		{ return (flags & LOCKED)!=0; }

		// State control
		static bool		Enable(STATE state)	{
			return (W3D_SetState(context, state, W3D_ENABLE)==W3D_SUCCESS);
		}

		static bool		Disable(STATE state)	{
			return (W3D_SetState(context, state, W3D_DISABLE)==W3D_SUCCESS);
		}

		static bool		Enabled(STATE state)	{
			return (W3D_GetState(context, state)==W3D_ENABLED);
		}

		static bool		SetAlphaCompare(AMODE m, float32& v)	{
			return (W3D_SetAlphaMode(context, m, &v)==W3D_SUCCESS);
		}

		static bool		SetBlendMode(BFUNC s, BFUNC d)	{
			return (W3D_SetBlendMode(context, s, d)==W3D_SUCCESS);
		}

		static bool		SetMaskARGB(ruint32 c)	{
			return (W3D_SetColorMask(context,
								(c&0x00FF0000),
								(c&0x0000FF00),
								(c&0x000000FF),
								(c&0xFF000000))==W3D_SUCCESS);
		}

		static bool		SetFogMode(FMODE mode)	{
			return (W3D_SetFogParams(context, &fogData, mode)==W3D_SUCCESS);
		}

		static bool		SetLogicOperation(LMODE mode)	{
			return (W3D_SetLogicOp(context, mode)==W3D_SUCCESS);
		}

		static void		SetTexture(sysTEXTURE* t)	{
			currTex = t;
			W3D_BindTexture(context, 0, t);
		}

		static bool		SetVertexArray(DVERTEX* v);
		static bool		SetColour(uint32 c);
		static bool		SetFogProperties(FMODE m, uint32 c, float32 s, float32 e, float32 d);

		// Z buffer
		static bool		AllocZBuffer()	{
			if (W3D_AllocZBuffer(context)==W3D_SUCCESS) {
				flags |= GOT_ZBUFFER;
				return true;
			}
			flags &=~GOT_ZBUFFER;
			return false;
		}

		static void		FreeZBuffer()	{
			flags &=~GOT_ZBUFFER;
			W3D_FreeZBuffer(context);
		}

		static bool		ZBuffer()	{
			return (flags & GOT_ZBUFFER)!=0;
		}

		static bool		ClearZBuffer(float64& val)	{
			return (W3D_ClearZBuffer(context, &val)==W3D_SUCCESS);
		}

		static bool		SetZCompare(ZMODE mode)	{
			return (W3D_SetZCompareMode(context, mode)==W3D_SUCCESS);
		}

		static bool		UploadZBuffer(S_2CRD, float64* p);
		static bool		DownloadZBuffer(S_2CRD, float64* p);

		// Stencil buffer
		static bool		AllocStencil()	{
			if (W3D_AllocStencilBuffer(context)==W3D_SUCCESS) {
				flags |= GOT_STENCIL;
				return TRUE;
			}
			flags &=~GOT_STENCIL;
			return FALSE;
		}

		static void		FreeStencil()	{
			flags &=~GOT_STENCIL;
			W3D_FreeStencilBuffer(context);
		}

		static bool		Stencil()	{
			return (flags & GOT_STENCIL)!=0;
		}

		static bool		ClearStencil(uint32& val)	{
			return (W3D_ClearStencilBuffer(context, &val)==W3D_SUCCESS);
		}

		static bool		UploadStencil(S_2CRD, uint32* p)	{
			return (W3D_FillStencilBuffer(context, x1, y1, x2-x1, y2-y1, 32, p)==W3D_SUCCESS);
		}

		static bool		UploadStencil(S_2CRD, uint16* p)	{
			return (W3D_FillStencilBuffer(context, x1, y1, x2-x1, y2-y1, 16, p)==W3D_SUCCESS);
		}

		static bool		UploadStencil(S_2CRD, uint8* p)		{
			return (W3D_FillStencilBuffer(context, x1, y1, x2-x1, y2-y1, 8, p)==W3D_SUCCESS);
		}

		static bool		DownloadStencil(S_2CRD, uint32* p);
		// do other stencil funcs

		// Drawing
		static bool		SetDrawArea(S_2CRD);
		static bool		SetDrawArea(xSURFACE* s, S_2CRD);
		static void		FreeDrawArea()	{
			drawRegion.top = 0;
			drawRegion.left = 0;
			drawRegion.width = 0;
			drawRegion.height = 0;
			W3D_SetDrawRegion(context, 0, 0, &drawRegion);
		}

		static bool		Clear(ruint32 rgb)	{
			return (W3D_ClearDrawRegion(context, rgb)==W3D_SUCCESS);
		}

		static bool		DrawPoints(sint32 ofst, sint32 vCnt)	{
			if (useV4)
				return (W3D_DrawArray(context, W3D_PRIMITIVE_POINTS, ofst, vCnt)==W3D_SUCCESS);
			else
				return v3DrawPoints(ofst, vCnt);
		}

		static bool		DrawLines(rsint32 ofst, rsint32 vCnt) {
			if (useV4)
				return (W3D_DrawArray(context, W3D_PRIMITIVE_LINES, ofst, vCnt)==W3D_SUCCESS);
			else
				return v3DrawLines(ofst, vCnt);
		}

		static bool		DrawLineStrip(sint32 ofst, sint32 vCnt)	{
			if (useV4)
				return (W3D_DrawArray(context, W3D_PRIMITIVE_LINESTRIP, ofst, vCnt)==W3D_SUCCESS);
			else
				return v3DrawLineStrip(ofst, vCnt);
		}

		static bool		DrawLineLoop(rsint32 ofst, rsint32 vCnt){
			if (useV4)
				return (W3D_DrawArray(context, W3D_PRIMITIVE_LINELOOP, ofst, vCnt)==W3D_SUCCESS);
			else
				return v3DrawLineLoop(ofst, vCnt);
		}


		static bool		DrawTris(rsint32 ofst, rsint32 vCnt)	{
			return (W3D_DrawArray(context, W3D_PRIMITIVE_TRIANGLES, ofst, vCnt)==W3D_SUCCESS);
		}

		static bool		DrawTriFan(rsint32 ofst, rsint32 vCnt)	{
			return (W3D_DrawArray(context, W3D_PRIMITIVE_TRIFAN, ofst, vCnt)==W3D_SUCCESS);
		}

		static bool		DrawTriStrip(rsint32 ofst, rsint32 vCnt)	{
			return (W3D_DrawArray(context, W3D_PRIMITIVE_TRISTRIP, ofst, vCnt)==W3D_SUCCESS);
		}

		static bool		DrawIndirect()	{
			return (W3D_Flush(context)==W3D_SUCCESS);
		}

		static void		FlushFrame()	{
			W3D_FlushFrame(context);
		}

	public:
		static xSURFACE*	DrawSurface()	{
			return drawSurface;
		}

		static sint32		GetDrawLeftLimit()	{
			return drawRegion.left;
		}

		static sint32		GetDrawRightLimit()	{
			return drawRegion.left+drawRegion.width;
		}

		static sint32		GetDrawTopLimit()	{
			return drawRegion.top;
		}

		static sint32		GetDrawBottomLimit()	{
			return drawRegion.top+drawRegion.height;
		}

		static void			SetV4() { useV4 = TRUE; }
		static void			SetV3() { useV4 = FALSE; }

	// Initialisation, performed through xGFX code
	protected:
		static sint32 	Init(uint32 ID); // ID is AmigaOS displaymodeID for querying driver - implementation detail
		static sint32 	Done();
};

#endif