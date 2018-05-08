//****************************************************************************//
//** File:         DrawList.cpp ($NAME=DrawList.cpp)                        **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is for AmigaOS 68K systems                     **//
//** Library:      xGraphics                                                **//
//** Created:      2001-12-10                                               **//
//** Updated:      2002-02-01                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):      Implemenation for DRAW and DRAWLIST classes              **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//


#include <xSystem/GraphicsLib.hpp>

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32				DRAW::flags				= 0;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAW::Bind(xSURFACE* s)
{
	if (!s || !(s->Handle()))
		return ERR_PTR_ZERO;
	if (x3D::Context())
	{
		if (s->Format()==x3D::DrawSurface()->Format())
		{
			if (x3D::SetDrawArea(s, 0, 0, s->Width(), s->Height())==false)
			{
/*
				#ifdef X_DEBUG
				sysBASELIB::MessageBox("Debug Info", "Proceed", "DRAW::Bind()\nFailed to set draw area");
				#endif
*/
				return ERR_RSC_INVALID;
			}
			if (x3D::ZBuffer() && (s->Size() != x3D::DrawSurface()->Size()))
			{
				x3D::FreeZBuffer();
				x3D::AllocZBuffer();
			}
			return OK;
		}
		else
			x3D::FreeContext();		// surface format different, free this context
	}
	return x3D::BuildContext(s,false);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAW::Release()
{
	if (x3D::Context())
	{
		x3D::FreeDrawArea();
		return OK;
	}
	return WRN_RSC_UNAVAILABLE;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAW::Init()
{
	#ifdef X_VERBOSE
	cerr << "DRAW Debug build : " __DATE__ " at " __TIME__ "\n";
	#endif
	return OK;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAW::Done()
{
	if (x3D::Context())
		x3D::FreeContext();
	return OK;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

float32				DRAWLIST::qTrigTab[DRAW_TSIZE+1]	= {
	0.000000000,	0.098017128,	0.195090300,	0.290284640,
	0.382683390,	0.471396680,	0.555570170,	0.634393220,
	0.707106710,	0.773010380,	0.831469540,	0.881921200,
	0.923879480,	0.956940290,	0.980785250,	0.995184710,
	1.000000000
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::InitRegs()
{
	currFlushCnt	= 0;
	breakCnt			= 0;
	nestCount			= 0;
	commandReg		= 0;
	stateReg			= 0;
	colourReg			= 0;
	depthReg			= 0;
	alphaReg			= 0;
	texReg				= 0;
	logicReg			= L_CLEAR;
	fogReg				= F_LINEAR;
	zTestReg			= DEPTH_ALWAYS;
	aTestReg			= ALPHA_ALWAYS;
}

DRAWLIST::DRAWLIST() : flags(0), vertBuf(0), currVert(0), instBuf(0), currInst(0), vBufSize(0), iBufSize(0)
{
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

DRAWLIST::DRAWLIST(sint32 vBuf, sint32 cBuf) : flags(0), vertBuf(0)
{
	Create(vBuf, cBuf);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWLIST::Create(sint32 vBuf, sint32 cBuf)
{
	if (vertBuf)
		return ERR_RSC_LOCKED;
	vBuf	= Clamp(vBuf, 256, 262144);
	cBuf	= Clamp(cBuf, 256, 65536);
	void*	data	= MEM::Alloc((cBuf*sizeof(DCOMMAND))+(vBuf*sizeof(DVERTEX)), true);
	if (!data)
	{
		vertBuf 		= 0;
		instBuf 		= 0;
		currVert		= 0;
		currInst		= 0;
		vBufSize		= 0;
		iBufSize		= 0;
		return ERR_NO_FREE_STORE;
	}
	vertBuf 		= (DVERTEX*)data;
	instBuf 		= (DCOMMAND*)((sint32)data+(vBuf*sizeof(DVERTEX)));
	currVert		= vertBuf;
	currInst		= instBuf;
	vBufSize		= vBuf;
	iBufSize		= cBuf;
	InitRegs();
	return OK;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Delete()
{
	if (vertBuf)
	{
		MEM::Free(vertBuf);
		vertBuf 		= 0;
		instBuf 		= 0;
		currVert		= 0;
		currInst		= 0;
		vBufSize		= 0;
		iBufSize		= 0;
		InitRegs();
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

DRAWLIST::~DRAWLIST()
{
	Delete();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef X_VERBOSE

void DRAWLIST::DumpVerts(ostream& out, sint32 start, sint32 num)
{
	DVERTEX* t = vertBuf+start;
	for (sint32 j=0; j < num; j++, t++)
	{
		out << "\t\t{" << t->x << ", " << t->y << ", " << t->z \
				<< ", " << t->u << ", " << t->v << ", 0x" << (void*)t->colour << "}\n";
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::DumpCoords1(ostream& out, sint32 pos)
{
	DVERTEX* t = vertBuf+pos;
	out << "(" << t->x1 << ", " << t->y1 << ")";
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::DumpCoords2(ostream& out, sint32 pos)
{
	DVERTEX* t = vertBuf+pos;
	out << "(" << t->x1 << ", " << t->y1 << "), (" << t->x2 << ", " << t->y2 << ")";
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::DumpCoords3(ostream& out, sint32 pos)
{
	DVERTEX* t = vertBuf+pos;
	out << "(" << t->x1 << ", " << t->y1 << "), (" << t->x2 << ", " << t->y2 << "), (" << t->x3 \
			<< ", " << t->y3 << ")";
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::DumpCoords3F(ostream& out, sint32 pos)
{
	DVERTEX* t = vertBuf+pos;
	out << "(" << t->fx1 << ", " << t->fy1 << "), (" << t->fx2 << ", " << t->fy2 << "), (" << t->fx3 \
			<< ", " << t->fy3 << ")";
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Dump(ostream& out, bool showVerts)
{
	sint32 vp = 0;
	out << "DRAWLIST::Dump() : " << instsUsed << " commands\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
	for (sint32 i=0; i < instsUsed; i++)
	{
		uint32 cmd = instBuf[i].opcode;
		out << i << ":\t" << VGPU::Opcode(cmd);

		switch (cmd) {
			case RSRVD:
			case DRW_POINTS:
			case DRW_LINES:
			case DRW_LINESTRIP:
			case DRW_TRIANGLES:
			case DRW_TRIFAN:
			case DRW_TRISTRIP:
				{
					sint32 n = instBuf[i].numVerts;
					out << "\t" << n << "\n";
					if (showVerts)
					{
						out << "\t{ vertex data at " << vp << ":\n";
						DumpVerts(out, vp, n);
						cout << "\t}\n\n";
					}
					vp += n;
				}
				break;

			case CLEAR_DEPTH:
				out << "\t" << instBuf[i].depth << "\n";
				break;

			case CLEAR_RGB:
			case SET_COLOUR:
			case SET_TEXTURE:
			case SET_FOG:
			case SET_LOGIC:
			case SET_ZMODE:
			case SET_AMODE:
			case LOCK:
			case ENABLE_STATE:
			case DISABLE_STATE:
			case BLENDPARMS:
			case PUSH_DVS:
				out << "\t0x" << instBuf[i].anyHex << "\n";
				break;

			case CLIP:
				out << "\n\t{ coord data at " << vp << ": ";
				DumpCoords2(out, vp++);
				out << " }\n\n";
				break;

			case BLIT2:
			case BLIT:
				out << "\t0x" << instBuf[i].anyHex << "\n\t{ coord data at " << vp << ": ";
				DumpCoords3(out, vp++);
				out << " }\n\n";
				break;

			case BREAKPT:
				out << "\t#" << instBuf[i].data << "\n";
				break;

			case FOGPARMS:
				out << "\t0x" << instBuf[i].anyHex << "\n\t{ fog data at " << vp << ": ";
				DumpCoords3F(out, vp++);
				out << " }\n\n";
				break;

			default:
				out << "\n";
				break;
		}
	}
	out << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
}

#endif // X_VERBOSE

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
