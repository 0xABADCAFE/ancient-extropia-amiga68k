//****************************************************************************//
//** File:         TextureSurface.cpp ($NAME=TextureSurface.cpp)            **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is for AmigaOS 68K systems                     **//
//** Library:      xGraphics                                                **//
//** Created:      2001-12-10                                               **//
//** Updated:      2002-02-01                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):      Implemenation for xTEXSURF and xSMPLFONT classes         **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#include <xSystem/GraphicsLib.hpp>

// I found a weird bug caused when switching from GOURAUD to FLAT shading with texturing enabled
// Doesn't seem to be in my code, think is problem with driver

#define FIXW3D_FLATBUG

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xTEXSURF::
//
//  format corresponds to TEXSURF type (equiv to W3D type-1)
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool xTEXSURF::Bind()
{
	if (!context || !data)
		return false;
	if (tex)
		return true;

	uint32 result = 0;
	if (pal && (format == TXL_LUT_8))
	{
		TagItem tTags[] = {
			W3D_ATO_IMAGE,	(uint32)data,
			W3D_ATO_FORMAT,	(uint32)W3D_CHUNKY,
			W3D_ATO_WIDTH,	(uint32)width,
			W3D_ATO_HEIGHT,	(uint32)height,
			W3D_ATO_PALETTE,(uint32)pal,
			TAG_DONE,				0
		};
		if (!(tex = W3D_AllocTexObj(context, &result, tTags)))
			return false;
	}
	else
	{
		TagItem tTags[] = {
			W3D_ATO_IMAGE,	(uint32)data,
			W3D_ATO_FORMAT,	(uint32)(format+1),
			W3D_ATO_WIDTH,	(uint32)width,
			W3D_ATO_HEIGHT,	(uint32)height,
			TAG_DONE,				0
		};
		if (!(tex = W3D_AllocTexObj(context, &result, tTags)))
			return false;
	}
	return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xTEXSURF::UnBind()
{
	if (!context || !tex)
		return;
	W3D_FreeTexObj(context, tex);
	tex	= 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXSURF::Create(S_WH, xTEXSURF::TEXELTYPE fmt, ARGB32* extPal)
{
	if (tex || data)
		return ERR_RSC_LOCKED;

	size_t bytesPerTexel;
	switch (fmt)
	{
		case TXL_LUT_8:
		case TXL_ALPHA_8:
		case TXL_GREY_8:
		case TXL_INTSY_8:		bytesPerTexel = 1; break;
		case TXL_ARGB_1555:
		case TXL_ARGB_4444:
		case TXL_RGB_565:
		case TXL_GA_88:			bytesPerTexel = 2; break;
		case TXL_RGB_888:		bytesPerTexel = 3; break;
		case TXL_ARGB_8888:
		case TXL_RGBA_8888: bytesPerTexel = 4; break;
	}

	w = Clamp(w, 2, 1024);
	h = Clamp(h, 2, 1024);

	sint16 newWidth = 2;
	sint16 newHeight = 2;

	while (newWidth < w)	newWidth<<=1;
	while (newHeight < h)	newHeight<<=1;

	size_t space = newWidth*newHeight*bytesPerTexel;

	if (fmt==TXL_LUT_8)
	{
		if (extPal)
		{
			if (data = MEM::Alloc(space, false))
			{
				pal = extPal;
				goto AllOK;
			}
			else
				return ERR_NO_FREE_STORE;
		}
		else
		{
			if (data = MEM::Alloc(space+256*sizeof(ARGB32), false))
			{
				pal = (ARGB32*)(((uint8*)data)+space);
				goto AllOK;
			}
			else
				return ERR_NO_FREE_STORE;
		}
	}
	else
	{
		if (data = MEM::Alloc(space, false))
		{
			pal = 0;
			goto AllOK;
		}
		else
			return ERR_NO_FREE_STORE;
	}

AllOK:
	RawSize((4*sizeof(uint16))+space);
	width		= newWidth;
	height	= newHeight;
	depth		= bytesPerTexel*8;
	format	= fmt;
	return OK;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xTEXSURF::Delete()
{
	UnBind();
	if (data)
		MEM::Free(data);
	data = 0;
	pal = 0;
	width = 0;
	height = 0;
	format = 0;
	RawSize(4*sizeof(uint16));
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXSURF::ReadyForWrite()
{
	// Must be data waiting to write
	if (data)
		return OK;
	return ERR_PTR_ZERO;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXSURF::ReadyForRead()
{
	// Existing data must be freed first
	if (data)
		return ERR_RSC_LOCKED;
	return OK;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXSURF::WriteBody(XSFIO& f)
{
	// Write the AREA info
	if (f.Write16(&width, 4)!=4)
		return ERR_FILE_WRITE;

	size_t numElements = width*height;

	switch (format)
	{
		// 8-bit formats
		case TXL_LUT_8:
		case TXL_ALPHA_8:
		case TXL_GREY_8:
		case TXL_INTSY_8:
			if (f.Write8(data, numElements)!=numElements)
				return ERR_FILE_WRITE;
			if ((flags & OWNPALETTE) && pal!=0)
			{
				if (f.Write32(pal, 256)!=256)
					return ERR_FILE_WRITE;
			}
			break;

		// 16-bit formats
		case TXL_ARGB_1555:
		case TXL_ARGB_4444:
		case TXL_RGB_565:
		case TXL_GA_88:
			if (f.Write16(data, numElements)!=numElements)
				return ERR_FILE_WRITE;
			break;

		// 24-bit formats
		case TXL_RGB_888:
			if (f.Write8(data, numElements*3)!=numElements*3)
				return ERR_FILE_WRITE;
			break;

		// 32-bit formats
		case TXL_ARGB_8888:
		case TXL_RGBA_8888:
			if (f.Write32(data, numElements)!=numElements)
				return ERR_FILE_WRITE;
			break;
	}
	return RawSize();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXSURF::ReadBody(XSFIO& f)
{
	// Read the AREA info
	if (f.Read16(&width, 4)!=4)
		return ERR_FILE_WRITE;

	// allocate space
	size_t numElements = width*height;
	size_t dataSize = RawSize()-(4*sizeof(uint16));
	data = MEM::Alloc(dataSize, false);
	if (!data)
		return ERR_NO_FREE_STORE;

	switch (format)
	{
		// 8-bit formats
		case TXL_LUT_8:
			{
				// check if a palette is included
				if ((dataSize - numElements)==256*sizeof(ARGB32))
				{
					pal = (ARGB32*)(((uint8*)data)+numElements);
					flags |= OWNPALETTE;
				}
			}
		case TXL_ALPHA_8:
		case TXL_GREY_8:
		case TXL_INTSY_8:
			if (f.Read8(data, numElements)!=numElements)
				return ERR_FILE_READ;
			// load a palette if one is defined
			if (flags & OWNPALETTE)
			{
				if (f.Read32(pal, 256)!=256)
					return ERR_FILE_READ;
			}
			break;

		// 16-bit formats
		case TXL_ARGB_1555:
		case TXL_ARGB_4444:
		case TXL_RGB_565:
		case TXL_GA_88:
			if (f.Read16(data, numElements)!=numElements)
				return ERR_FILE_READ;
			break;

		// 24-bit formats
		case TXL_RGB_888:
			if (f.Read8(data, numElements*3)!=numElements*3)
				return ERR_FILE_READ;
			break;

		// 32-bit formats
		case TXL_ARGB_8888:
		case TXL_RGBA_8888:
			if (f.Read32(data, numElements)!=numElements)
				return ERR_FILE_READ;
			break;
	}
	// Texture data has loaded ok
	// We can immediately bind the data if the context is valid
	if (context) Bind();
	return RawSize();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

xTEXSURF::xTEXSURF() : XSFOBJ("xTEXSURF Image", T_image_raster, T_xTEXTUREMAP, 1, 0), AREA(0,0,0,0),
											 tex(0), data(0), pal(0), flags(0)
{
	RawSize(4*sizeof(sint16)); // AREA data
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xTEXSURF::
//
//  format corresponds to TEXSURF type (equiv to W3D type-1)
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
sint32 xTEXSURF::Create(S_WH, xTEXSURF::TEXELTYPE fmt, void* data, uint32* pal)
{
	if (source || tex)
	{
		//cerr << "xTEXSURF::Create() : In use\n";
		return ERR_RSC_LOCKED;
	}

	uint32 result = 0;
	if (context && data)
	{
		if (pal && (fmt == TXL_LUT_8))
		{
			TagItem tTags[] = {
				W3D_ATO_IMAGE,	(uint32)data,
				W3D_ATO_FORMAT,	(uint32)W3D_CHUNKY,
				W3D_ATO_WIDTH,	(uint32)w,
				W3D_ATO_HEIGHT,	(uint32)h,
				W3D_ATO_PALETTE,(uint32)pal,
				TAG_DONE,				0
			};
			tex = W3D_AllocTexObj(context, &result, tTags);
		}
		else
		{
			TagItem tTags[] = {
				W3D_ATO_IMAGE,	(uint32)data,
				W3D_ATO_FORMAT,	(uint32)(fmt+1),
				W3D_ATO_WIDTH,	(uint32)w,
				W3D_ATO_HEIGHT,	(uint32)h,
				TAG_DONE,				0
			};
			tex = W3D_AllocTexObj(context, &result, tTags);
		}
	}
	if (tex)
	{
		source	= data;
		width		= w;
		height	= h;
		format	= fmt;
		//cerr << "xTEXSURF::Create() OK\n";
		return OK;
	}
	//cerr << "xTEXSURF::Create() W3D_AllocTexObj() error " << (sint32)result << "\n";
	return ERR_RSC;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXSURF::Delete()
{
	if (tex)
	{
		if (tex && context)
		{
			W3D_FreeTexObj(context, tex);
		}
		tex	= 0;
	}
	if ((flags & OWNDATA) && source)
		MEM::Free(source);
	if ((flags & OWNPAL) && (flags & SINGLEBLOCK)==0 && palette)
		MEM::Free(palette);
	source	= 0;
	palette = 0;
	flags		= 0;
	return OK;
}
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
sint32 xTEXSURF::LoadPPM(const char* name, uint32 alphagen, bool narrow)
{
	xFILEIO ppmFile(name, xFILEIO::READ);
	if (ppmFile.Valid()==false)
		return ERR_FILE_OPEN;
	uint32 w=0, h=0;
	// attempt to interpret file header and check file length
	{
		char fileHead[64] = {0};
		ppmFile.ReadText(fileHead, 64, '\n', 4);
		if (sscanf(fileHead, "P6\n%ld\n%ld\n255\n", &w, &h)!=2)
		{
			//cerr << "xTEXSURF::LoadPPM() : Error in PPM header\n";
			ppmFile.Close();
			return ERR_FILE_READ;
		}
		if ( (ppmFile.Size()-ppmFile.Tell())!=(w*h*3) )
		{
			//cerr << "xTEXSURF::LoadPPM() : Error in PPM size\n";
			ppmFile.Close();
			return ERR_FILE_READ;
		}
	}
	// allocate memory to hold data in chosen format
	sint32 dataSize = w*h*((narrow==false)?4:2);
	void* data = MEM::Alloc(dataSize, false, true);
	if (!data)
	{
		//cerr << "xTEXSURF::LoadPPM() : Memory shortage\n";
		ppmFile.Close();
		return ERR_NO_FREE_STORE;
	}

	if ((alphagen & 0x00FFFFFF) == 0)
	{	// basic alpha value. Convert data to chosen format on fly
		rsint32 i = ((w*h))+1;

		if (narrow==false) // ARGB_8888
		{
			//cerr << "xTEXSURF::LoadPPM() : Simple Alpha ARGB32\n";
			ruint32* dest	= (uint32*)data; ruint32	alpha = alphagen;
			while (--i)
			{
				ruint32 t = alpha | ((uint8)ppmFile.GetChar())<<16;
				t |= ((uint8)ppmFile.GetChar())<<8;
				t |= ((uint8)ppmFile.GetChar());
				*(dest++) = t;
			}
		}
		else // ARGB_4444
		{
			//cerr << "xTEXSURF::LoadPPM() : Simple Alpha ARGB16\n";
			ruint16* dest	= (uint16*)data; ruint32	alpha = ((alphagen>>24)/16)<<12;
			while (--i)
			{
				ruint16 t = alpha | (((uint8)ppmFile.GetChar())/16)<<8;
				t |= (((uint8)ppmFile.GetChar())/16)<<4;
				t |= (((uint8)ppmFile.GetChar())/16);
				*(dest++) = t;
			}
		}
	}
	else
	{	// biased alpha value. Alpha determined through bias. Each colour channel has a bias value
		// that describes its overall contribution to the opacity
		uint32 aTab[] = {	(alphagen>>24), (alphagen&0x00FF0000)>>16,
											(alphagen&0x0000FF00)>>8, (alphagen&0x000000FF)};
		uint32 dvz = (aTab[1]<<8) + (aTab[2]<<8) + (aTab[3]<<8);
		if (dvz == 0)
			dvz = 65536*3;
		rsint32 i = ((w*h))+1;
		if (narrow==false) // ARGB_8888
		{
			ruint32* dest	= (uint32*)data;
			while (--i)
			{
				ruint32 v = (uint8)ppmFile.GetChar();
				ruint32 t = v<<16;
				ruint32 a = v*aTab[1];
				v = (uint8)ppmFile.GetChar();
				t |= v<<8;
				a += v*aTab[2];
				v = (uint8)ppmFile.GetChar();
				t |= v;
				a += v*aTab[3];
				a = (a*aTab[0])/dvz;
				*(dest++) = a<<24 | t;
			}
		}
		else // ARGB_4444	:	Keep the alpha value calculation based on the original 24 bit data
		{
			ruint16* dest	= (uint16*)data; dvz <<= 4; // include 8->4 bit division here
			while (--i)
			{
				ruint32 v = (uint8)ppmFile.GetChar();
				ruint16 t = (v/16)<<8;
				ruint32 a = v*aTab[1];
				v = (uint8)ppmFile.GetChar();
				t |= (v/16)<<4;
				a += v*aTab[2];
				v = (uint8)ppmFile.GetChar();
				t |= (v/16);
				a += v*aTab[3];
				a = (a*aTab[0])/dvz;
				*(dest++) = a<<12 | t;
			}
		}
	}
	ppmFile.Close();
	if (Create(w, h, (narrow==true) ? TXS_ARGB_4444 : TXS_ARGB_8888, data)!=OK)
	{
		MEM::Free(data);
		return ERR_RSC_INVALID;
	}
	flags |= OWNDATA;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXSURF::LoadPPMPGM(const char* ppmName, const char* pgmName, bool narrow)
{
	xFILEIO file(ppmName, xFILEIO::READ);
	if (file.Valid()==false)
		return ERR_FILE_OPEN;
	uint32 w=0, h=0;
	{
		char fileHead[64] = {0};
		file.ReadText(fileHead, 64, 'n', 4); // read 4 lines, max 63 chars
		if (sscanf(fileHead, "P6\n%ld\n%ld\n255\n", &w, &h)!=2)
		{
			file.Close();
			return ERR_FILE_READ;
		}
		if ( (file.Size()-file.Tell())!=(w*h*3) )
		{
			file.Close();
			return ERR_FILE_READ;
		}
	}
	// allocate memory to hold data in chosen format
	sint32 dataSize = w*h*((narrow==false)?4:2);
	void* data = MEM::Alloc(dataSize, false, true);
	if (!data)
	{
		file.Close();
		return ERR_NO_FREE_STORE;
	}
	else
	{
		rsint32 i = ((w*h))+1;
		if (narrow==false) // ARGB_8888
		{
			ruint32* dest	= (uint32*)data;
			while (--i)
			{
				ruint32 t = ((uint8)file.GetChar())<<16;
				t |= ((uint8)file.GetChar())<<8;
				t |= ((uint8)file.GetChar());
				*(dest++) = t;
			}
		}
		else // ARGB_4444
		{
			ruint16* dest	= (uint16*)data;
			while (--i)
			{
				ruint16 t = (((uint8)file.GetChar())/16)<<8;
				t |= (((uint8)file.GetChar())/16)<<4;
				t |= (((uint8)file.GetChar())/16);
				*(dest++) = t;
			}
		}
	}
	file.Close();
	file.Open(pgmName, xFILEIO::READ);
	if (file.Valid()==false)
	{
		MEM::Free(data);
		return ERR_FILE_READ;
	}
	else
	{
		uint32 wA=0, hA=0;
		{
			char fileHead[64] = {0};
			file.ReadText(fileHead, 64 , '\n', 4);
			if (sscanf(fileHead, "P5\n%ld\n%ld\n255\n", &wA, &hA)!=2)
			{
				MEM::Free(data);
				file.Close();
				return ERR_FILE_READ;
			}
			if ( w!=wA || h!=hA )
			{
				MEM::Free(data);
				file.Close();
				return ERR_FILE_READ;
			}
			if ( (file.Size()-file.Tell())!=(wA*hA) )
			{
				MEM::Free(data);
				file.Close();
				return ERR_FILE_READ;
			}
		}
	}

	{
		rsint32 i = 1+(w*h);
		if (narrow==false)
		{
			ruint32* dest	= (uint32*)data;
			while (--i)
			{
				ruint32 argb = ((uint8)file.GetChar())<<24;
				argb |= (*dest & 0x00FFFFFF);
				*(dest++) = argb ;
			}
		}
		else
		{
			ruint16* dest	= (uint16*)data;
			while (--i)
			{
				ruint16 argb = (((uint8)file.GetChar())/16)<<12;
				argb |= (*dest & 0x0FFF);
				*(dest++) = argb;
			}
		}
	}

	if (Create(w, h, (narrow==true) ? TXS_ARGB_4444 : TXS_ARGB_8888, data)!=OK)
	{
		MEM::Free(data);
		return ERR_RSC_INVALID;
	}
	flags |= OWNDATA;
	return OK;
}
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xSMPLFONT:: Derived from xTEXSURF
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXFONT::SetFixed(sint16 W, sint16 H, sint16 glW, sint16 glH, sint16 glSpan)
{
	if (flags & XF_FIXED)
	{
		size = H;
		fixed.glyphW	= glW;
		fixed.glyphH	= glH;
		fixed.printW	= W;
		fixed.cps			= glSpan;
		return OK;
	}
	return ERR_RSC_INVALID;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xTEXFONT::LoadFixedPGM(const char* name)
{
	// Loads PGM data, expects 16*16 glyphs irrespective of image size
	// Determines the char size from this, therefore 128*128 image == 8*8 font
	// Converts data into ARGB_4444 for now, with pure white RGB. This way
	// we can use MODULATE texture environment to draw our text any colour
	if (Data())
		return ERR_RSC_LOCKED;

	xFILEIO pgmFile(name, xFILEIO::READ);
	if (pgmFile.Valid()==false)
		return ERR_FILE_OPEN;

	uint32 w=0, h=0;
	{
		char fileHead[64] = {0};
		pgmFile.ReadText(fileHead, 64, '\n', 4);
		if (sscanf(fileHead, "P5\n%ld\n%ld\n255\n", &w, &h)!=2)
		{
			pgmFile.Close();
			return ERR_FILE_READ;
		}
		if ( (pgmFile.Size()-pgmFile.Tell())!=(w*h) )
		{
			pgmFile.Close();
			return ERR_FILE_READ;
		}
	}

	sint32 r = Create(w, h, TXL_ARGB_4444);
	if (r!=OK)
		return r;
	else
	{
		ruint16* dest	= (uint16*)Data();
		rsint32 n = 1+(w*h);
		while (--n)
		{
			*(dest++) = ((pgmFile.GetChar()&0xF0)<<8) | 0x0FFF;
		}
	}
	pgmFile.Close();

	if (Bind())
	{
		Environment(MODULATE);
	}
	flags = XF_FIXED|XF_MONO;
	size = h/16;
	fixed.glyphW = w/16;
	fixed.glyphH = h/16;
	fixed.printW = w/16;
	fixed.cps = 16;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xTEXFONT::Delete()
{
	xTEXSURF::Delete();
	prop.glyphs	= 0;
	prop.spacing = 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xTEXFONT::WriteTextF(DRAWLIST* draw, uint32 col, S_XY, char* text,...)
{
	if (!draw || draw->Flag(DRAWLIST::MAKELIST)==0)
		return;
	char textBuffer[256]; // fix me : use an allocated buffer ?
	va_list arglist;
	va_start(arglist,text);
	sint32 n = vsprintf(textBuffer,text,arglist);
	va_end(arglist);
	if (n<0) return;
	WriteText(draw, col, x, y, textBuffer);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xTEXFONT::WriteText(DRAWLIST* draw, uint32 col, S_XY, char* text)
{
	if (!draw || draw->Flag(DRAWLIST::MAKELIST)==0)
		return;

	#ifdef STATE_FIX
	draw->flags |= DRAWLIST::ENFORCESTATE;
	#endif

	sint32 n = strlen(text);
	if (n==0)
		return;
	DVERTEX* v = draw->GetVertices((n*6), true);
	if (v)
	{
		// reserve first vertex for alpha test code
		++v;
		rsint32 i = n+1;	ruint8* p = (uint8*)text;
		sint32 cursX = x; sint32 cursY = y;
		sint32 vUsed = 0;
		if (flags & XF_FIXED)
		{	// fixed width font. All glyphs are fixed.glyphW * fixed.glyphH in area, but cursor advances
			// in fixed.printW / size increments.
			while(--i)
			{
				uint32 c = *(p++);
				// clip any characters outside current draw area
				if (cursY > x3D::GetDrawBottomLimit())
				{
					break;
				}
				else if (c == (uint32)('\n')) // always handle newlines
				{
					cursY	+= size;	cursX = x;
				}
				else if (c == (uint32)(' '))
					cursX += fixed.printW;
				else if (c == (uint32)('\t'))
					cursX += 3*fixed.printW;
				else if (cursX > x3D::GetDrawRightLimit() || (cursY+size) < x3D::GetDrawTopLimit() ||
								(cursX+fixed.printW) < x3D::GetDrawLeftLimit())
				{
					continue;
				}
				else
				{
					vUsed++;
					uint32 x1 = fixed.glyphW*(c%fixed.cps); // x/y texel offset of glyph
					uint32 y1 = fixed.glyphH*(c/fixed.cps);
					//TL
					v->x			= cursX;							v->y = cursY;										v->z = 0;
					/*v->colour = col;*/						v->u = x1;									(v++)->v = y1;
					//TR
					v->x			= cursX+fixed.glyphW;	v->y = cursY;										v->z = 0;
					/*v->colour = col;*/						v->u = x1+fixed.glyphW;			(v++)->v = y1;
					//BL
					v->x			= cursX;							v->y = cursY+fixed.glyphH;			v->z = 0;
					/*v->colour = col;*/						v->u = x1;									(v++)->v = y1+fixed.glyphH;
					//BL
					v->x			= cursX;							v->y = cursY+fixed.glyphH;			v->z = 0;
					/*v->colour = col;*/						v->u = x1;									(v++)->v = y1+fixed.glyphH;
					//TR
					v->x			= cursX+fixed.glyphW;	v->y = cursY;										v->z = 0;
					/*v->colour = col;*/						v->u = x1+fixed.glyphW;			(v++)->v = y1;
					//BR
					v->x			= cursX+fixed.glyphW;	v->y = cursY+fixed.glyphH;			v->z = 0;
					/*v->colour = col;*/						v->u = x1+fixed.glyphW;			(v++)->v = y1+fixed.glyphH;
					cursX += fixed.printW; // advance 1 char position
				}
			}
		}
		else
		{	// proportional glyphs. Glyph dimensions are stored in an array. The character width of
			// each glyph is stored seperately from the texel width. This allows for kerning etc.
			while(--i)
			{
				ruint32 c = *(p++);
				if (cursY > x3D::GetDrawBottomLimit())
				{
					break;
				}
				else if (c == (uint32)('\n'))
				{
					cursY += size;	cursX = x;
				}
				else if (cursX > x3D::GetDrawRightLimit() || (cursY + size) < x3D::GetDrawTopLimit() ||
								(cursX + prop.spacing[c]) < x3D::GetDrawLeftLimit() )
				{
					continue;
				}
				else if (c == (uint32)(' '))
					cursX += prop.spacing[(' ')];
				else if (c == (uint32)('\t'))
					cursX += 3*prop.spacing[(' ')];
				else
				{
					vUsed++;
					register xRECT16* g = prop.glyphs + c;
					ruint32 space = (g->x2) - (g->x1); // texel width of this glyph
					//TL
					v->x			= cursX;					v->y = cursY;							v->z = 0;
					/*v->colour = col;*/				v->u = g->x1;					(v++)->v = g->y1;
					//TR
					v->x			= cursX+space;		v->y = cursY;							v->z = 0;
					/*v->colour = col;*/				v->u = g->x2;					(v++)->v = g->y1;
					//BL
					v->x			= cursX;					v->y = cursY+size;			v->z = 0;
					/*v->colour = col;*/				v->u = g->x1;					(v++)->v = g->y2;
					//BL
					v->x			= cursX;					v->y = cursY+size;			v->z = 0;
					/*v->colour = col;*/				v->u = g->x1;					(v++)->v = g->y2;
					//TR
					v->x			= cursX+space;		v->y = cursY;							v->z = 0;
					/*v->colour = col;*/				v->u = g->x2;					(v++)->v = g->y1;
					//BR
					v->x			= cursX+space;		v->y = cursY+size;			v->z = 0;
					/*v->colour = col;*/				v->u = g->x2;					(v++)->v = g->y2;
					cursX += prop.spacing[c]; // advance 1 char position
				}
			}
		}
		if (vUsed)
		{
			bool aTest = draw->Enabled(x3D::ALPHA_TEST);
			if (!aTest)
				draw->Enable(x3D::ALPHA_TEST);
			x3D::AMODE	aMode = draw->GetACompareMode();
			float32			aRef = draw->GetAlphaRefValue();
			draw->Enable(x3D::ALPHA_BLEND);
			draw->Enable(x3D::TEXTURE);
			draw->Disable(x3D::GOURAUD);
			draw->SetColour(col);
			draw->SetTexture((xTEXSURF*)this);
			draw->AlphaCompareMode(x3D::ALPHA_GT, 0.2);
			draw->Tris(vUsed*6);
			draw->AlphaCompareMode(aMode, aRef);
			if (!aTest)
				draw->Disable(x3D::ALPHA_TEST);
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
