//****************************************************************************//
//** File:         Display.hpp ($NAME=Display.hpp)                          **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is included in AmigaOS 68K systems             **//
//** Library:      xGraphics                                                **//
//** Created:      2001-01-20                                               **//
//** Updated:      2002-01-07                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#include <xSystem/IOLib.hpp>
#include <xSystem/ServiceLib.hpp>

#ifndef _XSYSTEM_DISPLAY68K_HPP
#define _XSYSTEM_DISPLAY68K_HPP


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xDMODE : Auxilliary class for xGFX
//
//  Display mode data object, describes a display modes properties.
//
//  Though xDMODE objects can be constructed, only xGFX::Init() can actually set the internals This is to ensure
//  that only valid modes can be used by the application.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xDMODE : public AREA {
  friend class xGFX;
  private:
    uint32  ID;
    char    name[DISPLAYNAMELEN];
    void    ReadCGXData(CyberModeNode* m);
  public:
    char*   Name()      { return name; }
    uint32  MachineID() { return ID; }
  #ifdef X_VERBOSE
    void    Dump(ostream& out);
  #endif

  public:
    xDMODE() : ID(0)  { }
    ~xDMODE() { }
};


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xDISPLAYABLE::
//
//  Service interface for objects that can be added to displays. We inherit xCHAINABLE to ease the construction of lists that
//  we may want to attach to a display.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xDISPLAYABLE : public xCHAINABLE {

  public:
    virtual sint32 ViewDefine(S_2CRD)                   { return OK; }
    virtual sint32 ViewClear()  { return OK; }
    virtual sint32 ViewRender() { return OK; }

  public:
    xDISPLAYABLE() {}
    virtual ~xDISPLAYABLE() { }
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xDISPLAY:: Base class for all display types (window/fullscreen)
//
//  Provides the following complete interface
//
//  Locking
//    xLOCKABLE:: full interface
//
//  Query
//    AREA:: interface
//
//  Control
//    Open()
//    Close()
//    Refresh()
//    WaitSync() waits until the video beam passes the bottom of the visible area
//
//  Data access (virtual)
//    DrawSurface() returns handle to rendering surface
//    ViewSurface() returns handle to visible surface (same as above for unbuffered displays)
//
//  Other
//    virtual destructor
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define W_MIN_WIDTH 128   // minimum window width
#define W_MIN_HEIGHT 128  // minimum window height
#define S_MIN_WIDTH 320   // minimum fullscreen width
#define S_MIN_HEIGHT 200  // minimum fullscreen height
#define S_MAX_WIDTH 1600  // maximum fullscreen width
#define S_MAX_HEIGHT 1200 // maximum fullscreen height

class xDISPLAY : virtual public AREA {

  protected:
  // all the display types have these
    char          name[64];
    Screen*       scr;
    Window*       win;

  public:
  // AREA::
  //virtual sint32 Width()
  //virtual sint32 Height()
  //virtual sint32 Depth()
  //virtual sint32 Format()
    virtual sint32      Open()=0;
    virtual sint32      Close()=0;
    virtual void        Refresh()=0;
    virtual xSURFACE*   DrawSurface()=0;
    virtual xSURFACE*   ViewSurface()=0;

    void    WaitSync()  { WaitTOF(); /*WaitBOVP(&(scr->ViewPort));*/ }
    sint32  MessageBox(char* title, char* opts, char* body,...);

  public:
    xDISPLAY() : AREA(), scr(0), win(0) {}
    virtual ~xDISPLAY() { }
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xDISPLAYIO Service mixin class for input handling
//
//  Each class adds the following input extensions to any xDISPLAY:: derived class
//
//  Data
//    IKEYBOARD
//    IMOUSELEFT
//    IMOUSECENTRE
//    IMOUSERIGHT
//    IMOUSEKEYMOVE
//    IMOUSEIDLEMOVE
//    IMOUSENOCLIP
//    ICLOSE
//    IMOUSEMOVE
//    IMOUSEKEYS
//    IDEFAULT
//
//  Query
//    InputMask()
//    InputQueued() returns true whilst input events are queued. Events MUST be always be handled
//
//  Control
//    ApplyInputModification()
//    SetInput(uint32 f)
//    ClrInput(uint32 f)
//
//    Launch()    [xDISPLAYIO_ASYNC only]
//    ShutDown()  [xDISPLAYIO_ASYNC only]
//
//  Operation
//    MouseEvent(sint32 x, sint32 y, sint32 buttons)
//    KeyEvent(sint32 keyCode)
//    ExitEvent()
//    ResizeEvent()
//    MoveEvent()
//
//  For async, recommended use is to override Open() / Close() in derived class to call Launch() and ShutDown().
//  This is not mandatory however; the input thread can be switched on and off where needed.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xDISPLAYIO : virtual protected xDISPLAY, public xINPUT {

  protected:
    void    ApplyInputModification(); // Adjusts the input stream to match the required IO functionality
    bool    WaitForEvent();           // Returns true if events, false if exit signal also recieved
    bool    HandleEvent();            // Handles an event in the input queue, returns true
    void    DiscardQueued();          // Discards remaining input to enable safe closing

  public:
    // Display specific events
    void    Idle();                 // Waits until an event occurs
    bool    InputQueued()           { return HandleEvent(); }

    virtual void ResizeEvent() = 0; // window resize or resolution change
    virtual void MoveEvent() = 0;
  public:
    xDISPLAYIO()  {}
    ~xDISPLAYIO() {}
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xDBWIN:: Double buffered window display
//
//  The OS window is opened such that the inside area of the window corresponds to the desired width/height
//  The window cannot be opened if the existing screen's depth is less than the requested display depth.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xDBWIN : public xDISPLAY {

  private:
    uint32      flags;
    sint16      left;
    sint16      top;
    xSURFACE    bBuf;     // our own surface
    xSURFACE    disp;     // the screen surface
    enum {
      WIN_OPEN          = 0x00000001,
      SCR_LOCK_FAILED   = 0x00000100,
      SCR_TYPE_FAILED   = 0x00000200,
      SCR_DEPTH_FAILED  = 0x00000400,
      WIN_OPEN_FAILED   = 0x00000800,
      WIN_SURF_FAILED   = 0x00001000,
      BUF_ALLOC_FAILED  = 0x00002000
    };

  protected:
    sint16      WinX()        { return win->LeftEdge; }
    sint16      WinY()        { return win->TopEdge; }
    sint16      WinW()        { return win->Width; }
    sint16      WinH()        { return win->Height; }
    sint16      WinBL()       { return win->BorderLeft; }
    sint16      WinBR()       { return win->BorderRight; }
    sint16      WinBT()       { return win->BorderTop; }
    sint16      WinBB()       { return win->BorderBottom; }
    sint16      ViewX()       { return WinX()+WinBL(); }          // View offset into screen surface
    sint16      ViewY()       { return WinY()+WinBT(); }
    sint16      ViewW()       { return WinW()-WinBL()-WinBR(); }
    sint16      ViewH()       { return WinH()-WinBT()-WinBB(); }
    void        Free();       // cleanly releases the resources

  public:
    sint32      Set(S_RECT, sint16 d, const char* title);
    sint32      Open();
    sint32      Close();
    void        Refresh()     { xSURFACE::BlitC(&bBuf, &disp, 0, 0, ViewW(), ViewH(), WinBL(), WinBT()); }
    xSURFACE*   DrawSurface() { return &bBuf; }
    xSURFACE*   ViewSurface() { return &disp; }

  public:
    xDBWIN() : xDISPLAY(), flags(0), top(0), left(0) { }
    xDBWIN(S_RECT, sint16 d, const char* title="Unnamed") : xDISPLAY(), flags(0) { Set(x, y, w, h, d, title); }
    ~xDBWIN() { Close(); }
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xSCREEN:: Fullscreen display class, single buffer
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xSCREEN : public xDISPLAY {
  private:
    xSURFACE      surf;
    uint32        modeID;

  protected:
    uint32      flags;
    enum {
      WIN_OPEN          = 0x00000001,
      SCR_OPEN_FAILED   = 0x00000100,
      WIN_OPEN_FAILED   = 0x00000800
    };
    void        Free();       // cleanly releases the resources
  public:
    sint32      Set(xDMODE* mode, const char* title);
    sint32      Open();
    sint32      Close();
    void        Refresh()     {}
    xSURFACE*   DrawSurface() { return &surf; }
    xSURFACE*   ViewSurface() { return &surf; }

  public:
    xSCREEN() : xDISPLAY(), flags(0) {}
    xSCREEN(xDMODE* mode, const char* title="Unnamed") : xDISPLAY(), flags(0) { Set(mode,title); }
    ~xSCREEN() { Close(); }
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xDBSCREEN:: Double buffered Screen
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class xDBSCREEN : public xDISPLAY {
  private:
    xSURFACE      surf[2];
    ScreenBuffer* buffer[2];
    uint32        modeID;
    sint32        drawBuffer;

  protected:
    uint32      flags;
    enum {
      WIN_OPEN          = 0x00000001,
      SCR_OPEN_FAILED   = 0x00000100,
      WIN_OPEN_FAILED   = 0x00000800,
      BUF_ALLOC_FAILED  = 0x00002000
    };
    void        Free();       // cleanly releases the resources
  public:
    sint32      Set(xDMODE* mode, const char* title);
    sint32      Open();
    sint32      Close();
    void        Refresh();
    xSURFACE*   DrawSurface() { return surf+drawBuffer; }
    xSURFACE*   ViewSurface() { return surf+(drawBuffer^1UL); }

  public:
    xDBSCREEN();
    xDBSCREEN(xDMODE* mode, const char* title="Unnamed");
    ~xDBSCREEN() { Close(); }
};

#endif