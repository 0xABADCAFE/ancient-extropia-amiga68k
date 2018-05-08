//****************************************************************************//
//** File:         prj/xDAC/APP.cpp ($NAME=APP.cpp)                         **//
//** Description:  xDAC Application class implementation                    **//
//** Comment(s):                                                            **//
//** Created:      2002-01-20                                               **//
//** Updated:      2002-02-21                                               **//
//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#include "APP.hpp"


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DRAWLIST	draw;
xTEXFONT	font;

APPWINDOW APP::viewWindow(128,128,800,600,16,"xDAC " X_PLATFORM);
DRAWWAVE	APP::sourceWave;
DRAWFRAME	APP::frame;
char*			APP::xDacName = 0;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 APP::Init(const char* wave, const char* xName, sint32 frameSize, sint32 bitrate, bool fast)
{
	// Set up all libraries

	if (xAUDIO::Init()!=OK)
	{
		#ifdef X_VERBOSE
 		sysBASELIB::MessageBox("Program Aborted", "OK", xBASELIB::Error(ERR_RSC_INVALID, "xAUDIO"));
		#endif
		Done();
		return ERR_RSC_INVALID;
	}

	if (xGFX::Init()!=OK)
	{
		#ifdef X_VERBOSE
 		sysBASELIB::MessageBox("Program Aborted", "OK", xBASELIB::Error(ERR_RSC_INVALID, "xGFX"));
		#endif
		Done();
		return ERR_RSC_INVALID;
	}
	else if (DRAW::Init()!=OK)
	{
		#ifdef X_VERBOSE
 		sysBASELIB::MessageBox("Program Aborted", "OK", xBASELIB::Error(ERR_RSC_INVALID, "DRAW"));
		#endif
		Done();
		return ERR_RSC_INVALID;
	}
	// Create window
	if (viewWindow.Open()!=OK)
	{
 		sysBASELIB::MessageBox("Program Aborted", "OK", "Unable to open display");
		Done();
		return ERR_RSC_INVALID;
	}

	if (draw.Create(8192,1024)!=OK)
	{
 		sysBASELIB::MessageBox("Program Aborted", "OK", "Unable to create DRAWLIST");
		Done();
		return ERR_RSC_INVALID;
	}

	if (font.LoadFixedPGM("data/font.pgm")!=OK)
	{
 		sysBASELIB::MessageBox("Program Aborted", "OK", "Unable to load font data");
		Done();
		return ERR_RSC_INVALID;
	}
	else
		font.SetFixed(7, 13, 8, 14, 16);

	x3D::SetV4();

	// Add displayable things
	{
		sint16 w = viewWindow.Width();
		sint16 h = viewWindow.Height();
		sourceWave.ViewDefine(8, 8, w-8, (h/3)-4);
		frame.ViewDefine(8, (h/3)+4, w-8, h-8);
		viewWindow.AddDrawThing(sourceWave);
		viewWindow.AddDrawThing(frame);
		viewWindow.Clear();
		viewWindow.Refresh();
	}

	// Load the selected wave
	if (sourceWave.Load(wave)!=OK)
	{
 		sysBASELIB::MessageBox("Program Aborted", "OK", "Unable to load file %s", wave);
		Done();
		return ERR_FILE_READ;
	}
	xDacName = xName ? (char*)xName : "ram:test.xdac";
	sint32 len = sourceWave.Size();
	sourceWave.SetRange(0, len, 1);
	frameSize=Clamp(frameSize,32,1024);
	frame.Set(sourceWave,frameSize,bitrate,fast);
	viewWindow.Refresh();
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 APP::Done()
{
	frame.Delete();
	sourceWave.Delete();
	font.Delete();
	draw.Delete();
	viewWindow.Close();
	DRAW::Done();
	xGFX::Done();
	xAUDIO::Done();
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

APPWINDOW::APPWINDOW() : xDBWIN(), flags(0)
{
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

APPWINDOW::APPWINDOW(S_RECT, sint16 d, const char* title) : xDBWIN(x, y, w, h, d, title), flags(0)
{
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

APPWINDOW::~APPWINDOW()
{
	Close();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 APPWINDOW::Open()
{
	sint32 r = xDBWIN::Open();
	if (r==OK)
	{
		r = DRAW::Bind(DrawSurface());
		if (r==OK)
		{
			flags |= DRAW_BOUND;
			ApplyInputModification();
			return OK;
		}
		else
		{
 			sysBASELIB::MessageBox("Program Aborted", "OK", "APPWINDOW::Open()\nCouldn't bind draw surface");
			xDBWIN::Close();
			return ERR_USER;
		}
	}
	sysBASELIB::MessageBox("Program Aborted", "OK", "APPWINDOW::Open()\nUnable to create display");
	return r;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 APPWINDOW::Close()
{
	if (flags & DRAW_BOUND)
	{
		flags &= ~DRAW_BOUND;
		DRAW::Release();
	}
	flags &= ~QUIT;
	return xDBWIN::Close();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void APPWINDOW::Clear()
{
	draw.Begin();
	{
		draw.Clear(0);
	}
	draw.End();
	xDBWIN::Refresh();
}

void APPWINDOW::Refresh()
{
	draw.Begin();
	{
		//draw.Clear(0);
		for (xDISPLAYABLE* t = (xDISPLAYABLE*)drawThings.First(); t->Next()!=0; t = (xDISPLAYABLE*)t->Next())
			t->ViewRender();
	}
	draw.End();
	xDBWIN::Refresh();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void APPWINDOW::MouseEvent(sint32 x, sint32 y, sint32 buttons)
{
	 //cout << "Mouse [" << x << ", " << y << ", " << buttons << "]\n";
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void APPWINDOW::KeyEvent(sint32 keyCode, bool state, sint32 ch)
{
	if (state) // respond to key down events only
	{
		switch (keyCode)
		{	// check for special keys (non printing) first
			case xKEY::ESC:
				flags |= QUIT;
				break;

			case xKEY::WINDOZE:
				sysBASELIB::MessageBox("Oh No!", "Cringe", "Aargh, you hit my shame button!");
				break;

			// function keys
			case xKEY::F1:
				APP::frame.DecFrameLen(8);
				break;
			case xKEY::F2:
				APP::frame.IncFrameLen(8);
				break;
			case xKEY::F3:
				APP::frame.DecBitRate();
				break;
			case xKEY::F4:
				APP::frame.IncBitRate();
				break;
			case xKEY::F5:
				APP::sourceWave.SetFreq(APP::sourceWave.Frequency()>>1);
				break;
			case xKEY::F6:
				APP::sourceWave.SetFreq(APP::sourceWave.Frequency()-100);
				break;
			case xKEY::F7:
				APP::sourceWave.SetFreq(APP::sourceWave.Frequency()+100);
				break;
			case xKEY::F8:
				APP::sourceWave.SetFreq(APP::sourceWave.Frequency()<<1);
				break;
			case xKEY::F9:
				APP::sourceWave.SetFreq(22050);
				break;
			case xKEY::F10:
				MEM::DebugInfo();
				break;

			// other
			case xKEY::ENTER:
				if (APP::sourceWave.IsPlaying())
					APP::sourceWave.Stop();
				else
					APP::sourceWave.Play(22050, APP::sourceWave.StartPos(), APP::sourceWave.Range());
				break;
			case xKEY::SPACE: // Space - show full wave
				APP::sourceWave.SetRange(0, APP::sourceWave.Size(), 1.0F);
				break;

			// keypad keys
			case xKEY::NP_ENT:
				APP::EncodeXDAC();
				break;
			case xKEY::NP_7:
				APP::frame.First();
				break;
			case xKEY::NP_1:
				APP::frame.Last();
				break;
			case xKEY::NP_4:
				APP::frame--;
				APP::sourceWave.SetRange(APP::frame.StartPos(), APP::frame.Size(), 1.0F);
				break;
			case xKEY::NP_5:
				APP::sourceWave.SetRange(APP::frame.StartPos(), APP::frame.Size(), 1.0F);
				break;
			case xKEY::NP_6:
				APP::frame++;
				APP::sourceWave.SetRange(APP::frame.StartPos(), APP::frame.Size(), 1.0F);
				break;
			case xKEY::NP_MINUS: // zoom -5%
				APP::sourceWave.ZoomRange(1.05F);
				break;
			case xKEY::NP_PLUS: // zoom +5%
				APP::sourceWave.ZoomRange(1F/1.05F);
				break;

			// cursors
			case xKEY::LEFT:
				APP::sourceWave.ScrollRange(-0.125F);
				break;
			case xKEY::RIGHT:
				APP::sourceWave.ScrollRange(0.125);
				break;
			case xKEY::UP:
				APP::sourceWave.ZoomY(1.05F);
				break;
			case xKEY::DOWN:
				APP::sourceWave.ZoomY(1F/1.05F);
				break;

			// check for printable keys (ch)
			default:
				switch (ch)
				{
					case ',': // < - previous frame
						APP::frame--;
						break;

					case '.': // > - next frame
						APP::frame++;
						break;

					case 's':
					case 'S':
						APP::frame.ForceS1();	// force Serkan Delta Method
						break;

					case 'k':
					case 'K':
						APP::frame.ForceK1();	// force Karl Delta Method
						break;

					case 'a':
					case 'A':
						APP::frame.ForceNone(); // Machine chooses method
						break;

					default:
						break;
				}
				break;
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void APPWINDOW::ExitEvent()
{
	//cout << "Exit\n";
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Window specific
void APPWINDOW::ResizeEvent()
{
	//cout << "Resize\n";
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void APPWINDOW::MoveEvent()
{
	//cout << "Move\n";
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DRAWWAVE::
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWWAVE::ViewClear()
{
	static uint32 backColour[]	= {	0xFF800000, 0xFF108010, 0xFF000080, 0xFF202040, 0xFF6060C0 };
	static uint32 barColour[]		= { 0xFF2020C0, 0xFF8080FF, 0xFF2020C0 };
	draw.Disable(x3D::ALPHA_BLEND);
	sint32 c = Channels();
	if (c==0)
		c=1;
	for (sint32 i=0,dy=(borderBottom-borderTop-16)/c,py=borderTop;i<c;i++,py+=dy)
	{
		draw.RectShV(backColour, borderLeft, py, borderRight, py+(dy/2));
		draw.RectShV(backColour+1, borderLeft, py+(dy/2), borderRight, py+dy);
	}
	draw.RectShV(barColour, 	borderLeft, borderBottom-16, borderRight, borderBottom-4);
	draw.RectShV(barColour+1, borderLeft, borderBottom-4, borderRight, borderBottom);
	draw.Enable(x3D::ALPHA_BLEND);
	draw.Rect(0x40000000, borderLeft+4, borderBottom-10, borderRight-4, borderBottom-6);

	draw.Enable(x3D::ALPHA_BLEND);
	draw.Line(0x80000000, borderLeft+4, borderBottom-10, borderRight-4, borderBottom-10);
	draw.Line(0x80000000, borderLeft+4, borderBottom-10, borderLeft+4, borderBottom-6);
	draw.Line(0x80FFFFFF, borderRight-4, borderBottom-10, borderRight-4, borderBottom-6);
	draw.Line(0x80FFFFFF, borderLeft+4, borderBottom-6, borderRight-4, borderBottom-6);

	flags |= REDRAW_ME;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWWAVE::ViewRender()
{
	if ((flags & REDRAW_ME)==0)
		return OK;
	sint16* buffer = Data();
	if (buffer==0 || Size()==0)
	{
		ViewClear();
		font.WriteText(&draw, 0xFFFFFFFF, borderLeft+4, borderTop+4, "Waveform : Empty");
		return OK;
	}
	else
	{
		buffer += drawStart*Channels();
		uint32 visRange = (uint32)(borderRight-borderLeft-1);
		uint32 buffStep = visRange >= drawRange ? 1 : (drawRange/visRange);
		uint32 points = drawRange/buffStep;

		buffStep *= Channels();
		ViewClear();

		{
			static uint32 barColour[]		= { 0xFF8090FF, 0xFFEFEFFF, 0xFFC0C0FF };
			// Verticies for position bar
			float32 x1 = ClipFloat(borderLeft+visRange*(float32)drawStart/(float32)Length(), 0, borderRight-8F);
			float32 x2 = x1 + ClipFloat(visRange*(float32)drawRange/(float32)Length(), 8, visRange);
			draw.Enable(x3D::ALPHA_BLEND);
			draw.Rect(0x40000000, x1+2, borderBottom-15, x2+2, borderBottom-1);
			draw.RectShV(barColour, 	x1, borderBottom-13, x2, borderBottom-8);
			draw.RectShV(barColour+1, x1, borderBottom-8, x2, borderBottom-3);
			draw.Line(0x80FFFFFF, x1, borderBottom-13, x1, borderBottom-3);
			draw.Line(0x80FFFFFF, x1, borderBottom-13, x2, borderBottom-13);
			draw.Line(0x80000000, x2, borderBottom-13, x2, borderBottom-3);
			draw.Line(0x80000000, x1, borderBottom-3, x2, borderBottom-3);
		}
		draw.Disable(x3D::GOURAUD);
		draw.Disable(x3D::ALPHA_BLEND);
		{
			uint32 cols[] = {0x7F8080FF, 0x7FFF8080, 0x7F90FF80, 0x7FFFFF80};
			float32 dy = (borderBottom-borderTop-16)/Channels();
			float32 py = borderTop;
			for (sint32 k=0; k<Channels(); k++, py+=dy)
			{
				DVERTEX* p = draw.GetVertices(points);
				{
					// Waveform vertices
					rfloat32	x	= borderLeft+0.5F;
					rfloat32 dx	= (float32)visRange/(float32)(points-1);
					rfloat32 y	= py+(dy/2F);
					rfloat32 my	= drawYMag*(y - py)/32800F;
					for (rsint32 i = 0, j = k; i<points; i++, p++, j+=buffStep, x += dx)
					{
						p->x = x;
						p->y = ClipFloat((y - my*(float32)buffer[j]), py, py+dy);
						p->z = 0;
					}
					draw.SetColour(cols[k]);
					draw.LineStrip(points);
				}
			}
			font.WriteTextF(&draw, 0xFFFFFFFF, borderLeft+4, borderTop+4,\
													"Start: %d, Range: %d, Y scale: %f, Freq: %d Hz", \
													drawStart, drawRange, drawYMag, Frequency());
		}
	}
	flags &= ~REDRAW_ME;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWWAVE::ViewDefine(S_2CRD)
{
	borderLeft		= x1;
	borderTop 		= y1;
	borderRight		= x2;
	borderBottom	= y2;
	flags = REDRAW_ME;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWWAVE::SetRange(uint32 start, uint32 range, float32 yMag)
{
	if (Length())
	{
		drawRange = Clamp(range, 2, Length());
		if (start+drawRange > Length())
			drawStart = Length()-drawRange;
		else
			drawStart = start;
		drawYMag = Clamp(yMag, 1, 256);
	}
	flags |= REDRAW_ME;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWWAVE::ZoomRange(float32 factor)
{
	float32 s = (EndPos() + StartPos())/2F;
	float32 r = factor*(float32)drawRange;
	r = Clamp(r,16,Length());
	s -= (r/2F);
	s = Clamp(s,0,Length()-2);
	SetRange((uint32)s, (uint32)r, drawYMag);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWWAVE::ScrollRange(float32 factor)
{
	float32 s = factor*(float32)drawRange;
	s += (float32)drawStart;
	s = Clamp(s,0,Length()-2);
	SetRange((uint32)s, drawRange, drawYMag);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWWAVE::ZoomY(float32 factor)
{
	SetRange(drawStart, drawRange, drawYMag*factor);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32	DRAWWAVE::Play(uint32 start, uint32 len, float32 vol, float32 pan)
{
	// TO DO : AHI device intarface support for playback as stream

	if (flags & IS_PLAYING)
		return OK;
	else
	{
		len = Clamp(len, 0, Length());
		start = Clamp(start, 0, len);
		len = Clamp(len, 0, Length()-start);
	}
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWWAVE::Stop()
{
	if (flags & IS_PLAYING==0)
		return OK;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DRAWFRAME::
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWFRAME::ViewClear()
{
	ARGB32 backColour[2] = { 0xFF000000, 0xFF000000 };
	if (!ZeroFrame())
	{
		if (maxDelta>0)
			backColour[0].Red()= ((255F*(float32)maxDelta/32768F));
		else
			backColour[0].Blue()= ((255F*(float32)(-maxDelta)/32768F));
		if (minDelta>0)
			backColour[1].Red()= ((255F*(float32)minDelta/32768F));
		else
			backColour[1].Blue()= ((255F*(float32)(-minDelta)/32768F));
	}
	draw.Disable(x3D::ALPHA_BLEND);
	draw.RectShV((uint32*)backColour, borderLeft, borderTop, borderRight, borderBottom);
	flags |= REDRAW_ME;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWFRAME::ViewRender()
{
	if ((flags & REDRAW_ME)==0)
	{
		return OK;
	}
	if (Size()==0)
	{
		ViewClear();
		font.WriteText(&draw, 0xFFFF0000, borderLeft+4, borderTop+4, "No data available");
		return OK;
	}
	else if (ZeroFrame())
	{
		ViewClear();
		font.WriteTextF(&draw, 0xFFFF0000, borderLeft+4, borderTop+4, "Frame [%d/%d] is silent", frameNum, maxFrame);
		return OK;
	}
	else
	{
		ViewClear();
		draw.Disable(x3D::GOURAUD);
		uint32	visRange		= (uint32)(borderRight-borderLeft-1);
		uint32	buffStep		= visRange >= uniqueDelta ? 1 : 1+(uint32)((float32)uniqueDelta/(float32)visRange);
		uint32	points 			= uniqueDelta/buffStep;
		uint32	allocated		= uniqueDelta<(1<<bitRate) ? uniqueDelta : (1<<bitRate);
		register DVERTEX* p = draw.GetVertices(2*points+allocated);
		{	// delta vertices
			// sorted delta display
			// Adapt scale based on max/min delta values
			float32 y		= (borderTop + borderBottom)/2F;
			float32 my	= (y - borderTop)/32768F;
			float32 deltaRange = 65536F/(float32)(1+labs(maxDelta-minDelta));
			y += my*(float32)(maxDelta+minDelta)/2F;
			my *= deltaRange;
			// Unique delta values
			{
				float32	x		= borderLeft+0.5F;
				float32 dx	= (float32)visRange/(float32)(points-1);
				rsint16* d = DeltaUnique();
				for (rsint32 i=0, j=0; i < points; i++, p++, d++, j+=buffStep, x += dx)
				{
					p->x = x;
					p->y = Clamp((y - my*(float32)(*d)), borderTop+1, borderBottom-1);
					p->z = 0;
				}
				draw.SetColour(0xFFA0A030);
				draw.LineStrip(points);
			}
			// Chosen delta values
			{
				float32	x		= borderLeft+0.5F;
				float32 dx	= (float32)visRange/(float32)(allocated-1);
				rsint16* q = Table();
				for (rsint32 i=0; i < allocated; i++, p++, q++, x += dx)
				{
					p->x = x;
					p->y = Clamp((y - my*(float32)(*q)), borderTop+1, borderBottom-1);
					p->z = 0;
				}
				if (allocated<=(1<<bitRate))
					draw.SetColour(0xFFA0A0A0);
				else
					draw.SetColour(0xFFFFFF30);
				draw.LineStrip(allocated);
			}
			// Population display
			{	// re adapt vertical scale based on maximum population
				float32	x		= borderLeft+0.5F;
				float32 dx	= (float32)visRange/(float32)(points-1);
				float32 y = borderBottom;
				float32 my = (borderBottom-borderTop)/(float32)frameSize;
				sint16*	f = DeltaFreq();
				for (sint32 i=0, j=0; i < points; i++, p++, f++, j+=buffStep, x += dx)
				{
					p->x = x;
					p->y = Clamp((y - my*(float32)(*f)), borderTop+1, borderBottom-1);
					p->z = 0;
				}
				draw.SetColour(0xFF60A0FF);
				draw.LineStrip(points);
			}
		}
		{
			draw.Enable(x3D::ALPHA_BLEND);
			uint32 c[]={0x60000000, 0x600000FF};
			if (allocated<=16)
				draw.RectShH(c, borderLeft+8, borderTop+(2*font.Size()), borderLeft+4+(11*font.Width(0)), borderTop+4+((allocated+2)*font.Size()));
			else
				draw.RectShH(c, borderLeft+8, borderTop+(2*font.Size()), borderLeft+4+(23*font.Width(0)), borderTop+4+(18*font.Size()));
		}
		if (flags & ENCODING)
		{
			uint32 grad[] = { 0x8000FF00, 0x80FF0000 };
			draw.RectShH(grad, borderLeft, borderBottom-font.Size()-8, borderRight, borderBottom);
			sint16 w = ((borderRight-borderLeft)*frameNum)/maxFrame;
			draw.Rect(0xA08080FF, borderLeft, borderBottom-font.Size()-5, borderLeft+w, borderBottom-3);
		}
		switch (channels)
		{
			case 1:
				font.WriteTextF(&draw, 0xFFFFFFFF, borderLeft+4, borderTop+4,			\
												"Frame [%d/%d] Ln: %d, Mn: %d, Mx: %+d, U: %d, S: %+d",	\
												frameNum, maxFrame, frameSize, minDelta, maxDelta, uniqueDelta, StartSample()[0]);
			break;
			case 2:
				font.WriteTextF(&draw, 0xFFFFFFFF, borderLeft+4, borderTop+4,			\
												"Frame [%d/%d] Ln: %d, Mn: %d, Mx: %+d, U: %d, S1: %+d, S2: %+d",	\
												frameNum, maxFrame, frameSize, minDelta, maxDelta, uniqueDelta, StartSample()[0], StartSample()[1]);
			break;
			case 3:
				font.WriteTextF(&draw, 0xFFFFFFFF, borderLeft+4, borderTop+4,			\
												"Frame [%d/%d] Ln: %d, Mn: %d, Mx: %+d, U: %d, S1: %+d, S2: %+d, S3: %+d",	\
												frameNum, maxFrame, frameSize, minDelta, maxDelta, uniqueDelta, StartSample()[0], StartSample()[1], StartSample()[2]);
			break;
			case 4:
				font.WriteTextF(&draw, 0xFFFFFFFF, borderLeft+4, borderTop+4,			\
												"Frame [%d/%d] Ln: %d, Mn: %d, Mx: %+d, U: %d, S1: %+d, S2: %+d, S3: %+d, S4: %+d",	\
												frameNum, maxFrame, frameSize, minDelta, maxDelta, uniqueDelta, StartSample()[0], StartSample()[1], StartSample()[2], StartSample()[3]);
			break;
			default:
			break;
		}
		{
			sint16* q = Table();
			if (allocated <= 16)
			{
				for (sint32 i = 0; i < allocated ; i++)
				{
					font.WriteTextF(&draw, 0xFFE0E0E0, borderLeft+12, borderTop+4+((i+2)*font.Size()), "%2d:%+6d", i, *(q++));
				}
			}
			else if (allocated <= 32)
			{
				for (sint32 i = 0; i < 16 ; i++)
					font.WriteTextF(&draw, 0xFFE0E0E0, borderLeft+12, borderTop+4+((i+2)*font.Size()), "%2d:%+6d", i, *(q++));
				for (i = 0; i < allocated-16 ; i++)
					font.WriteTextF(&draw, 0xFFE0E0E0, borderLeft+12*font.Width(0)+12, borderTop+4+((i+2)*font.Size()), "%2d:%+6d", i+16, *(q++));
			}
		}
		if (flags & ENCODING)
			font.WriteTextF(&draw, 0xFFFFFFFF, borderLeft+4, borderBottom-font.Size()-4, "Encoding %.2f%%, last %d ms", 100F*(float32)frameNum/maxFrame, evalTime);
		else
			font.WriteTextF(&draw, 0xFF60A0FF, borderLeft+4, borderBottom-font.Size()-4, "Analysis %d ms", evalTime);
	}
	flags &= ~REDRAW_ME;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWFRAME::Write(XSFIO& file)
{
	sint32 size = XDACENCODE::Write(file);
	if (size<0)
	{
		flags &= ~ENCODING;
		return ERR_FILE_WRITE;
	}
	flags |= ENCODING;
	return size;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWFRAME::ViewDefine(S_2CRD)
{
	borderLeft		= x1;
	borderTop 		= y1;
	borderRight		= x2;
	borderBottom	= y2;
	flags = REDRAW_ME;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 APP::EncodeXDAC()
{
	XSFBASIC output(XDAC_IDSTRING, XDAC_VERSION, XDAC_REVISION, XDAC_DATAFORMAT, XDAC_FILEFORMAT);
	output.Create(xDacName);
	if (!output.Valid())
		return ERR_FILE_CREATE;
	sint32 filePos = output.Tell();

	XDAC dummy(1+frame.Max(), frame.Size(), sourceWave.Channels(), sourceWave.Frequency(), 0, \
						((sourceWave.Channels()>1) ? XDAC_G_CHANS_ALWAYS_MERGED : XDAC_G_SINGLE_CHANNEL)	);

	dummy.Write(output);

	sint32 totSize = 0;

	frame.First();
	for(sint32 i=0; i <= frame.Max(); i++)
	{
		sint32 size = frame.Write(output);
		if(size<0)
		{
			output.Close();
			sysBASELIB::MessageBox("Error", "Proceed", "Error occured writing to\n%s", xDacName);
			frame.Finished();
			return ERR_FILE_WRITE;
		}
		else
			viewWindow.Refresh();
		totSize+=size;
		frame++;
	}
	// Go back and write the raw size info
	totSize *= sizeof(uint16);
	totSize += dummy.RawSize();
	output.Seek(filePos+XSFOBJ_FILEOFFSET_RAWSIZE, xIOS::START);
	output.Write32(&totSize,1);
	output.Close();

	frame.First();
	frame.Finished();
	sysBASELIB::MessageBox("Info", "Proceed", "Wrote xDAC file\n%s", xDacName);
	return OK;
}