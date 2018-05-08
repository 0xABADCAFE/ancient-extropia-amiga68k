/*

	Extropia System Library test code by Karlos, eXtropia Studios

*/

#include "APP.hpp"

#ifdef PI
#undef PI
#endif

#include <math.h>

class LMIMAGE {
	private:
		xTEXSURF* data;
		struct {
			sint16 x1;
			sint16 y1;
			sint16 x2;
			sint16 y2;
		} subImage[7];

	private:
		void RenderLayer(uint32 n, DRAWLIST* d, S_2CRD, uint32 c, float32 z);

	public:
		bool Load(const char* PPM, const char* PGM);
		bool Bind();
		void SetAmbient(S_2CRD)	{ subImage[0].x1=x1; subImage[0].y1=y1; subImage[0].x2=x2; subImage[0].y2=y2; }
		void SetPosX(S_2CRD)		{ subImage[1].x1=x1; subImage[1].y1=y1; subImage[1].x2=x2; subImage[1].y2=y2; }
		void SetNegX(S_2CRD)		{ subImage[2].x1=x1; subImage[2].y1=y1; subImage[2].x2=x2; subImage[2].y2=y2; }
		void SetPosY(S_2CRD)		{ subImage[3].x1=x1; subImage[3].y1=y1; subImage[3].x2=x2; subImage[3].y2=y2; }
		void SetNegY(S_2CRD)		{ subImage[4].x1=x1; subImage[4].y1=y1; subImage[4].x2=x2; subImage[4].y2=y2; }
		void SetPosZ(S_2CRD)		{ subImage[5].x1=x1; subImage[5].y1=y1; subImage[5].x2=x2; subImage[5].y2=y2; }
		void SetNegZ(S_2CRD)		{ subImage[6].x1=x1; subImage[6].y1=y1; subImage[6].x2=x2; subImage[6].y2=y2; }

		void Draw(DRAWLIST* draw, S_2CRD, uint32* lightInfo, float32 z=0f);

	public:
		LMIMAGE();
		~LMIMAGE();
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LMIMAGE::LMIMAGE() : data(0)
{
	for (sint32 i=0; i<7; i++)
	{
		subImage[i].x1 = 0;
		subImage[i].y1 = 0;
		subImage[i].x2 = 0;
		subImage[i].y2 = 0;
	}
	data = new xTEXSURF;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LMIMAGE::~LMIMAGE()
{
	if (data)
		delete data;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool LMIMAGE::Load(const char* PPM, const char* PGM)
{
	return xTEXSURF_LOADER::LoadPPMAlphaPGMWide(data, PPM, PGM);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool LMIMAGE::Bind()
{
	if (data->Bind()==false)
		return false;
	data->Environment(xTEXSURF::MODULATE);
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void LMIMAGE::RenderLayer(uint32 n, DRAWLIST* draw, S_2CRD, uint32 c, float32 z)
{
	if (n>6)
		return;

	DVERTEX* v = draw->GetVertices(6, true);
	if (!v)
		return;

	//TL
	v->x	= x1;		v->y = y1;	v->z = z;		v->colour = c;
	v->u	= subImage[n].x1;		(v++)->v = subImage[n].y1;

	//TR
	v->x	= x2;		v->y = y1;	v->z = z;		v->colour = c;
	v->u	= subImage[n].x2;		(v++)->v = subImage[n].y1;

	//BL
	v->x	= x1;		v->y = y2;	v->z = z;		v->colour = c;
	v->u	= subImage[n].x1;		(v++)->v = subImage[n].y2;

	//BL
	v->x	= x1;		v->y = y2;	v->z = z;		v->colour = c;
	v->u	= subImage[n].x1;		(v++)->v = subImage[n].y2;

	//TR
	v->x	= x2;		v->y = y1;	v->z = z;		v->colour = c;
	v->u	= subImage[n].x2;		(v++)->v = subImage[n].y1;

	//BR
	v->x	= x2;		v->y = y2;	v->z = z;		v->colour = c;
	v->u	= subImage[n].x2;		(v++)->v = subImage[n].y2;

	draw->SetTexture(data);
	draw->Tris(6);
}


void LMIMAGE::Draw(DRAWLIST* draw, S_2CRD, uint32* lightInfo, float32 z)
{
	if (!draw || !lightInfo)
		return;

	bool aTest = draw->Enabled(x3D::ALPHA_TEST);
	if (!aTest) draw->Enable(x3D::ALPHA_TEST);

	x3D::AMODE	aMode = draw->GetACompareMode();
	float32			aRef = draw->GetAlphaRefValue();

	draw->AlphaCompareMode(x3D::ALPHA_GT, 0.06);
	draw->Enable(x3D::GOURAUD);
	draw->Enable(x3D::ALPHA_BLEND);
	draw->Enable(x3D::TEXTURE);

	for (sint32 n=0; n<7; n++, lightInfo++)
	{
		if ((*lightInfo)&0xFF000000)
			RenderLayer(n, draw, x1, y1, x2, y2, *lightInfo, z);
	}

	draw->AlphaCompareMode(aMode, aRef);
	if (!aTest) draw->Disable(x3D::ALPHA_TEST);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct DEMOCOLOUR {
	uint32 amb;
	uint32 posX;
	uint32 posY;
	uint32 posZ;
	uint32 negX;
	uint32 negY;
	uint32 negZ;
};

static DEMOCOLOUR demoCols[] = {
	{0xFF101010, 0xFFFFFFFF, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000},
	{0xFF101010, 0x00000000, 0xFFFFFFFF, 0x00000000, 0x00000000, 0x00000000, 0x00000000},
	{0xFF101010, 0x00000000, 0x00000000, 0xFFFFFFFF, 0x00000000, 0x00000000, 0x00000000},
	{0xFF101010, 0x00000000, 0x00000000, 0x00000000, 0xFFFFFFFF, 0x00000000, 0x00000000},
	{0xFF101010, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xFFFFFFFF, 0x00000000},
	{0xFF101010, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xFFFFFFFF},
	{0xFF101010, 0xFFFFFFFF, 0x00000000, 0x00000000, 0x00000000, 0x40FFFFFF, 0x60FFFFFF},
	{0xFF000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x40FFC020},
	{0xFF300000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x40FF4000, 0xFFFFC000},
	{0xFF300000, 0x00000000, 0x90FFFFFF, 0x00000000, 0x00000000, 0xC0FFFFFF, 0xFFFFC000},
	{0xFF000020, 0x50FFFFFF, 0xFF0080FF, 0x40FF0000, 0x5F0050FF, 0x00000000, 0x4020FF20},
	{0xFF000000, 0x00000000, 0x2000FF00, 0x00000000, 0x400FF000, 0x00000000, 0x00000000},
	{0xFF402020, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xFFFF0000, 0xFF000000},
	{0xFFFFFFFF, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000},
	{0xFF000000, 0x80FF0000, 0x8000FFFF, 0x8000FF00, 0x80FF00FF, 0x800000FF, 0x80FFFF00},
	{0x00000000, 0x60FFFFFF, 0x60000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000},
};

void APP::TestSprite()
{
	LMIMAGE* test = new LMIMAGE;
	if (test)
	{
		if (test->Load("data/64x128/woman_clrm.ppm", "data/64x128/woman_lit.pgm")==true)
		{
			test->SetAmbient(0, 0, 63, 127);
			test->SetPosX(64, 0, 127, 127);
			test->SetPosY(128, 0, 191, 127);
			test->SetPosZ(192, 0, 255, 127);
			test->SetNegX(64, 128, 127, 255);
			test->SetNegY(128, 128, 191, 255);
			test->SetNegZ(192, 128, 255, 255);
			draw->Begin();
			{
				testFont->WriteText(draw, 0xFFFFFFFF, 4, 32, "Loaded images");
				for (sint32 i=0, y=128; y<384; y+=128)
				{
					for (sint32 x=64; x<576; x+=64)
					{
						ruint32* light = &(demoCols[i++].amb);
						test->Draw(draw, x, y, x+63, y+127, light, 0.0);
					}
				}
			}
			draw->End();
			testWindow->Refresh();
		}
		delete test;
	}
}

void APP::DrawGUI()
{
	draw->Begin();
	{
		uint32 bkg[] = {0xFF000020, 0xFF204080};
		draw->Disable(x3D::ALPHA_BLEND);
		draw->RectShV(bkg, 0, 0, 640, 24);
		draw->RectShV(bkg, 0, 24, 640, 480);
		testFont->WriteText(draw, 0xFFFFFFFF, 4, 8, "Lightsourced sprite test app V0.1 [Amiga 68040]");
	}
	draw->End();
	testWindow->Refresh();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

xSCREEN* 		APP::testWindow = 0;
DRAWLIST*		APP::draw;
xTEXFONT*		APP::testFont;
char*				APP::textBuffer = 0; // lame

xTEXSURF*		APP::source = 0;
xTEXSURF*		APP::dest = 0;

sint32 APP::Init()
{
	if (xBASELIB::Init()!=OK)
	{
		Done();
		return ERR_RSC_INVALID;
	}
	if (xGFX::Init()!=OK)
	{
		sysBASELIB::MessageBox("Debug Info","Proceed","Failed to Init() xGFX");
		Done();
		return ERR_RSC_UNAVAILABLE;
	}

	if (DRAW::Init()!=OK)
	{
		sysBASELIB::MessageBox("Debug Info","Proceed","Failed to Init() DRAW");
		Done();
		return ERR_RSC_INVALID;
	}
	textBuffer = (char*)MEM::Alloc(2048);
	if (!textBuffer)
	{
		sysBASELIB::MessageBox("Debug Info","Proceed","Failed to allocate textBuffer");
		Done();
		return ERR_RSC_UNAVAILABLE;
	}

	xDMODE* mode = xGFX::BestMode(640,480,16);
	if (!mode)
	{
		sysBASELIB::MessageBox("Debug Info","Proceed","Failed to allocate fullscreen");
		Done();
		return ERR_RSC_UNAVAILABLE;
	}
	testWindow = new xSCREEN(mode, "DRAWLIST Demo");
	if (!testWindow)
	{
		sysBASELIB::MessageBox("Debug Info","Proceed","Failed to allocate window");
		Done();
		return ERR_RSC_INVALID;
	}
	if (testWindow->Open()!=OK)
	{
		sysBASELIB::MessageBox("Debug Info","Proceed","Failed to open window");
		Done();
		return ERR_RSC_INVALID;
	}

	if (DRAW::Bind(testWindow->DrawSurface())!=OK)
	{
		sysBASELIB::MessageBox("Debug Info","Proceed","Failed to Bind() window draw surface");
		Done();
		return ERR_RSC_INVALID;
	}

	draw = new DRAWLIST(8192,1024);
	if (!draw)
	{
		sysBASELIB::MessageBox("Debug Info","Proceed","Failed to create DRAWLIST object");
		Done();
		return ERR_RSC_INVALID;
	}

	testFont = new xTEXFONT;
	if (!testFont)
	{
		sysBASELIB::MessageBox("Debug Info","Proceed","Failed to create xTEXFONT object");
		Done();
		return ERR_RSC_INVALID;
	}
	if (testFont->LoadFixedPGM("data/chars256_13pt.pgm")!=OK)
	{
		sysBASELIB::MessageBox("Debug Info","Proceed","Failed open font data");
		Done();
		return ERR_RSC_INVALID;
	}
	else
		testFont->SetFixed(7,13,8,14,16);
	draw->BlendMode(x3D::PXL_ALPHA, x3D::ONE);
	DrawGUI();
	testWindow->MessageBox("Info","OK", "OK so far");

	TestSprite();
	testWindow->MessageBox("Info","OK", "OK so far");

	DrawGUI();
	draw->BlendMode(x3D::ONE, x3D::ONE);
	TestSprite();
	testWindow->MessageBox("Info","OK", "OK so far");

	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 APP::Done()
{
	if (testWindow)
	{
		if (testFont);
			delete testFont;
		if (draw)
			delete draw;
		DRAW::Release();
		testWindow->Close();
		delete testWindow;
	}
	DRAW::Done();
	xGFX::Done();

	if (textBuffer)
		MEM::Free(textBuffer);

	xBASELIB::Done();
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
