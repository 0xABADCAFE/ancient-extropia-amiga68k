//*****************************************************************//
//** Description:   OS Layer classes, AmigaOS/68K version        **//
//** First Started: 2001-03-08                                   **//
//** Last Updated:  2001-21-08                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xSystem/GraphicsLib.hpp>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xDISPLAY::
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xDISPLAY::MessageBox(char* title, char* opts, char* body,...)
{
	char msgbuff[256];
	va_list arglist;
	va_start(arglist,body);
	vsprintf(msgbuff,body,arglist);
	va_end(arglist);
	EasyStruct mb = {sizeof(EasyStruct),0,title, msgbuff, opts};
	return EasyRequest(win, &mb, 0, arglist);
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xDBWIN::
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDBWIN::Free()
{
	disp.Delete();
	bBuf.Delete();
	if (win)
	{
		CloseWindow(win);
		win = 0;
	}
	if (scr)
	{
		UnlockPubScreen(0, scr);
		scr = 0;
	}
	format = SURF_NONE;
	flags &= ~WIN_OPEN;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xDBWIN::Set(S_RECT, sint16 d, const char* title)
{
	if (flags & WIN_OPEN)
	{
		return ERR_RSC_LOCKED;
	}
	// This just sets up the desired window dimensions. Open()
	if (x < 0 || y < 0 || w < W_MIN_WIDTH || h < W_MIN_HEIGHT || d < 8 || d > 32)
	{
		return ERR_VALUE_ILLEGAL;
	}
	// set sensible initial values, these are checked again on Open() to ensure that the
	// window fits into our screen
	width		= ClipInt(w, W_MIN_WIDTH, S_MAX_WIDTH);
	height	= ClipInt(h, W_MIN_HEIGHT, S_MAX_HEIGHT);
	left		= ClipInt(x, 0, S_MAX_WIDTH-width);
	top			= ClipInt(y, 0, S_MAX_HEIGHT-height);
	depth		= d;
	strncpy(name, title, 63);
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xDBWIN::Open()
{
	if (flags & WIN_OPEN)
		return OK;
	// lock the screen and make sure that everything is ok
	scr = LockPubScreen(0);
	if (!scr)
	{ // check lock
		Free();
		flags |= SCR_LOCK_FAILED;
		return ERR_RSC_UNAVAILABLE;
	}

	if (GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_ISCYBERGFX)==false)
	{
		Free();
		flags |= SCR_TYPE_FAILED;
		return ERR_RSC_UNAVAILABLE;
	}
	else
	{ // check bpp/pixel format
		sint16 d = GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_DEPTH);
		if (depth > d)
		{
			Free();
			flags |= SCR_DEPTH_FAILED;
			return ERR_RSC_UNAVAILABLE;
		}
		depth		= d;
		format	= GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_PIXFMT);
		// clip to fit screen
		sint16 scrw = GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_WIDTH);
		sint16 scrh = GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_HEIGHT);
		width		= ClipInt(width, W_MIN_WIDTH, scrw);
		height	= ClipInt(height, W_MIN_HEIGHT, scrh);
		left		= ClipInt(left, 0, scrw-width);
		top			= ClipInt(top, 0, scrh-height);
	}
	// Open the window
	{
		win = OpenWindowTags(0,
			WA_PubScreen,			(uint32)scr,
			WA_InnerWidth,		(uint32)width,
			WA_InnerHeight,		(uint32)height,
			WA_Left,					left,
			WA_Top,						top,
			WA_Title,					(uint32)name,
			WA_DepthGadget,		true,
			WA_Flags,					WFLG_DRAGBAR|WFLG_REPORTMOUSE|WFLG_RMBTRAP,
			TAG_DONE);
	}
	if (!win)
	{
		Free();
		flags |= WIN_OPEN_FAILED;
		return ERR_RSC_UNAVAILABLE;
	}
	if (disp.Attach(win->RPort)!=OK)
	{
		Free();
		flags |= WIN_SURF_FAILED;
		return ERR_RSC_UNAVAILABLE;
	}
	if (bBuf.Create(width, height, &disp)!=OK)
	{
		Free();
		flags |= BUF_ALLOC_FAILED;
		return ERR_RSC_UNAVAILABLE;
	}
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xDBWIN::Close()
{
	Free();
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Class xSCREEN::
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xSCREEN::Set(xDMODE* mode, const char* title)
{
	if (!mode || scr)
		return ERR_RSC_UNAVAILABLE;
	modeID	= mode->MachineID();
	width		= mode->Width();
	height	= mode->Height();
	depth		= mode->Depth();
	format	= mode->Format();
	strncpy(name, title, 63);
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32	xSCREEN::Open()
{
	if (scr)
		return ERR_RSC;
	scr = OpenScreenTags(0,
		SA_Depth,			8L,
		SA_DisplayID,	modeID,
		SA_ShowTitle,	false,
		SA_Draggable,	false,
		SA_Title,			(uint32)name,
		TAG_DONE);
	if (!scr)
	{
		Free();
		flags |= SCR_OPEN_FAILED;
		return ERR_RSC_UNAVAILABLE;
	}
	//cerr << "Display opened : " << width << "x" << height << "x" << depth << "\n";
	// Open the window
	win = OpenWindowTags(0,
		WA_CustomScreen,	(uint32)scr,
		WA_Width,					(uint32)width,
		WA_Height,				(uint32)height,
		WA_Left,					0,
		WA_Top,						0,
		WA_Title,					0,
		WA_Flags,					WFLG_ACTIVATE|WFLG_BORDERLESS|WFLG_BACKDROP|WFLG_REPORTMOUSE|WFLG_RMBTRAP,
		TAG_DONE);
	if (!win)
	{
		Free();
		flags |= WIN_OPEN_FAILED;
		return ERR_RSC_UNAVAILABLE;
	}

	//cerr << "Window OK\n";
	// Attach surface
	if (surf.Attach(scr->RastPort.BitMap)!=OK)
	{
		Free();
		return ERR_RSC_UNAVAILABLE;
	}
	flags |= WIN_OPEN;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void	xSCREEN::Free()
{
	surf.Delete();
	if (scr)
	{
		if (win)
		{
			CloseWindow(win);
			win = 0;
			//cerr << "Window closed OK\n";
		}
		CloseScreen(scr);
		scr = 0;
		//cerr << "Display closed OK\n";
	}
	flags &= ~WIN_OPEN;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32	xSCREEN::Close()
{
	Free();
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Class xDBSCREEN::
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

xDBSCREEN::xDBSCREEN(): xDISPLAY(), drawBuffer(0), flags(0)
{
	buffer[0]=0; buffer[1]=0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

xDBSCREEN::xDBSCREEN(xDMODE* mode, const char* title) : xDISPLAY(), drawBuffer(0), flags(0)
{
	buffer[0]=0; buffer[1]=0;
	Set(mode, title);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xDBSCREEN::Set(xDMODE* mode, const char* title)
{
	if (!mode || scr)
		return ERR_RSC_UNAVAILABLE;
	modeID	= mode->MachineID();
	width		= mode->Width();
	height	= mode->Height();
	depth		= mode->Depth();
	format	= mode->Format();
	strncpy(name, title, 63);
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32	xDBSCREEN::Open()
{
	if (scr)
		return ERR_RSC;
	scr = OpenScreenTags(0,
		SA_Depth,			8L,
		SA_DisplayID,	modeID,
		SA_ShowTitle,	false,
		SA_Draggable,	false,
		SA_Title,			(uint32)name,
		TAG_DONE);
	if (!scr)
	{
		flags |= SCR_OPEN_FAILED;
		return ERR_RSC_UNAVAILABLE;
	}
	//cerr << "Display opened : " << width << "x" << height << "x" << depth << "\n";
	// Open the window
	win = OpenWindowTags(0,
		WA_CustomScreen,	(uint32)scr,
		WA_Width,					(uint32)width,
		WA_Height,				(uint32)height,
		WA_Left,					0,
		WA_Top,						0,
		WA_Title,					0,
		WA_Flags,					WFLG_ACTIVATE|WFLG_BORDERLESS|WFLG_BACKDROP|WFLG_REPORTMOUSE|WFLG_RMBTRAP,
		TAG_DONE);
	if (!win)
	{
		Free();
		flags |= WIN_OPEN_FAILED;
		return ERR_RSC_UNAVAILABLE;
	}

	//cerr << "Window OK\n";

	// Set up the os screen buffers
	buffer[0] = AllocScreenBuffer(scr, 0, SB_SCREEN_BITMAP);
	if (!buffer[0])
	{
		Free();
		flags |= BUF_ALLOC_FAILED;
		return ERR_RSC_UNAVAILABLE;
	}

	//cerr << "Primary Buffer OK\n";

	buffer[1] = AllocScreenBuffer(scr, 0, 0);
	if (!buffer[1])
	{
		Free();
		flags |= BUF_ALLOC_FAILED;
		return ERR_RSC_UNAVAILABLE;
	}

	//cerr << "Secondary Buffer OK\n";

	// Attach surfaces
	if ((surf[0].Attach(buffer[0]->sb_BitMap)!=OK) || (surf[1].Attach(buffer[1]->sb_BitMap)!=OK))
	{
		Free();
		return ERR_RSC_UNAVAILABLE;
	}
	drawBuffer = 1;
	flags |= WIN_OPEN;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void	xDBSCREEN::Free()
{
	surf[0].Delete();
	surf[1].Delete();
	if (scr)
	{
		if (buffer[0])
		{
			buffer[0]->sb_DBufInfo->dbi_SafeMessage.mn_ReplyPort = 0;
			while (!ChangeScreenBuffer(scr, buffer[0]))
				;
			FreeScreenBuffer(scr, buffer[0]);
			buffer[0] = 0;
			//cerr << "Priamry buffer destroyed OK\n";
		}
		if (buffer[1])
		{
			FreeScreenBuffer(scr, buffer[1]);
			buffer[1] = 0;
			//cerr << "Secondary buffer destroyed OK\n";
		}
		if (win)
		{
			CloseWindow(win);
			win = 0;
			//cerr << "Window closed OK\n";
		}
		CloseScreen(scr);
		scr = 0;
		//cerr << "Display closed OK\n";
	}
	flags &= ~WIN_OPEN;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32	xDBSCREEN::Close()
{
	Free();
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void	xDBSCREEN::Refresh()
{
	buffer[drawBuffer]->sb_DBufInfo->dbi_SafeMessage.mn_ReplyPort = 0;
	while (!ChangeScreenBuffer(scr, buffer[drawBuffer]) )
		;
	drawBuffer ^= 1UL;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Class xDISPLAYIO::
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDISPLAYIO::ApplyInputModification()
{
	// adjust IDCMP input filter to match the input mask
	uint32 IDCMPflags = 0;
	IDCMPflags |= (inputMask & IKEYBOARD) ? /*IDCMP_VANILLAKEY|*/IDCMP_RAWKEY : 0;
	IDCMPflags |= (inputMask & IMOUSEKEYS) ? IDCMP_MOUSEBUTTONS : 0;
	IDCMPflags |= (inputMask & IMOUSEMOVE) ? IDCMP_MOUSEMOVE : 0;
	IDCMPflags |= (inputMask & ICLOSE) ? IDCMP_CLOSEWINDOW : 0;
	ModifyIDCMP(xDISPLAY::win, IDCMPflags);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void	xDISPLAYIO::Idle()
{
	// Waits until an event occurs. Returns immediately if events are pending, processing the event automatically. This prevents
	// us from accidentally desynchronising ourselves with the input queue. Idle() can also be be broken by exit/break signals
	if (!xDISPLAY::win)
		return;
	if (HandleEvent()==false)
		WaitForEvent();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool	xDISPLAYIO::HandleEvent()
{
	// Handles a single event in the input queue. Returns true if events are still pending
	IntuiMessage* msg = (IntuiMessage*)GetMsg(xDISPLAY::win->UserPort);
	if (msg)
	{
		sint32 mouseX			= msg->MouseX-(win->BorderLeft);
		sint32 mouseY			= msg->MouseY-(win->BorderTop);
		sint32 mouseButton = 0;
		bool	mouseKeyEvent = false;
		switch (msg->Class)
		{
			case IDCMP_RAWKEY:
				KeyEvent(msg->Code & 0x0000007F, (msg->Code & 0x00000080)==0, xKEY::KeyToChar(msg));
				break;

			case IDCMP_MOUSEBUTTONS:
				switch(msg->Code)
				{
					case SELECTDOWN:	mouseButton |= (inputMask & IMOUSELEFT) ? XMOUSE_LEFT : 0;			break;
					case SELECTUP:		mouseButton &= (inputMask & IMOUSELEFT) ? ~XMOUSE_LEFT : 0;			break;
					case MIDDLEDOWN:	mouseButton |= (inputMask & IMOUSECENTRE) ? XMOUSE_CENTRE : 0;	break;
					case MIDDLEUP:		mouseButton &= (inputMask & IMOUSECENTRE) ? ~XMOUSE_CENTRE : 0;	break;
					case MENUDOWN:		mouseButton |= (inputMask & IMOUSERIGHT) ? XMOUSE_RIGHT : 0;		break;
					case MENUUP:			mouseButton &= (inputMask & IMOUSERIGHT) ? ~XMOUSE_RIGHT : 0;		break;
				}
				mouseKeyEvent = true; // drop through

			case IDCMP_MOUSEMOVE:
				if ((inputMask & IMOUSENOCLIP)==0)
				{ // constrain the coordinates to window area
					mouseX = ClipInt(mouseX, 0, width-1);
					mouseY = ClipInt(mouseY, 0, height-1);
				}
				if (inputMask & IMOUSEIDLEMOVE)
					MouseEvent(mouseX, mouseY, mouseButton); // idle movement
				else if ((inputMask & IMOUSEKEYMOVE) && mouseButton)
					MouseEvent(mouseX, mouseY, mouseButton); // movement if key down
				else if (mouseKeyEvent)
					MouseEvent(mouseX, mouseY, mouseButton); // key up/down
				break;

			case IDCMP_NEWSIZE:
				ResizeEvent();
				break;

			case IDCMP_CLOSEWINDOW:
				ExitEvent();
				break;

			default:
				//cout << "Unspecified event\n";
				break;
		}
		ReplyMsg((Message*)msg);
		return true;
	}
	return false;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool xDISPLAYIO::WaitForEvent()
{
	// Waits until an input and/or exit/break event occurs. We use the xTHREADABLE::GoIdle() method, which is general purpose and
	// ensures that the idle state can be broken by recieving either SIGNAL_WAIT or SIGNAL_EXIT
	// Returns true if an input event signal was set, false if only the exit/break signal occured

	sysSIGNAL eventSignal = 1<<xDISPLAY::win->UserPort->mp_SigBit;
	if (THREAD::SYSTEMSIGNAL==THREAD::Sleep(0, true, false, eventSignal))
		return true;
	return false;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDISPLAYIO::DiscardQueued()
{
	if (xDISPLAY::win)
	{
		Message* dummy = 0;
		while(dummy = GetMsg(xDISPLAY::win->UserPort))
			ReplyMsg(dummy);
	}
}
