//*****************************************************************//
//** Description:   Axonometric Projector, AmigaOS/68K version   **//
//** First Started:                                              **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _AXON_HPP
#error You must include axon.hpp
#endif

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  VIEW
//
//  Handles ViewPort. Multiple VIEWs are possible, each with unique zoom/angles
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class VIEW : public xDBWIN, public xDISPLAYINPUT, protected AXON {

  friend class MAPCELL;

  private:
    C2D prjOrigin;
    C2D projected[6];
    C2D boundTL;
    C2D boundBR;
    FLOAT32 matrix[10];   // for conversion from world->view space
    FLOAT32 zoomLevel;
    FLOAT32 aspect;       // viewport aspect, 0.75 for most displays
    UINT32  flags;
    SINT16  viewAngle;    // in degrees
    SINT16  viewPitch;    // in degrees
    UINT16  vA;           // modulated viewAngle;
    UINT16  vP;           // modulated viewPitch

    void    MouseEvent(SINT32 x, SINT32 y, SINT32 buttons);
    void    KeyEvent(SINT32 keyCode);
    void    ExitEvent();

    // Window specific
    void    ResizeEvent();
    void    MoveEvent();

  public:
    enum {
      DRAW_BOUND  = 0x00000001,
      ZBUFFER_OK  = 0x00000002,
      SHOWMAP     = 0x00000004,
      SHOWMAPC    = 0x00000008,
      DETAIL      = 0x00000010,
      MODELS      = 0x00000020,
      WATER       = 0x00000040,
      STATS       = 0x00000080,
      BOUNDS_PERP = 0x00010000,
      CHANGED     = 0x00020000,
      RENDERED    = 0x00040000,
      QUIT        = 0x01000000
    };

    SINT32    Open(); // calculates aspect, binds, gets z buffer
    SINT32    Close();
    UINT32    State(UINT32 r) { return r & flags; }
    void      Project();
    void      Display();
    void      FrameDone() { flags |= RENDERED; flags &= ~CHANGED; }

    // Camera
    void      Camera(FLOAT32 x, FLOAT32 y, FLOAT32 z, SINT16 a, SINT16 p);
    void      Move(FLOAT32 x, FLOAT32 y);
    void      Zoom(FLOAT32 z);
    FLOAT32   Zoom()          { return zoomLevel; }
    void      Yaw(SINT16 a);
    SINT16    Yaw()           { return viewAngle; }
    SINT16    YawMod()        { return 360-vA; }
    void      Pitch(SINT16 p);
    SINT16    Pitch()         { return viewPitch; }

    C2D&    Origin()        { return prjOrigin; }
    C2D&    TL()            { return projected[0]; }
    C2D&    TR()            { return projected[1]; }
    C2D&    BR()            { return projected[2]; }
    C2D&    BL()            { return projected[3]; }
    C2D&    DeltaUp()       { return projected[4]; }
    C2D&    DeltaRight()    { return projected[5]; }
    C2D&    BTL()           { return boundTL; }
    C2D&    BBR()           { return boundBR; }

    // Used by external rendering code
    FLOAT32*  Matrix()        { return matrix; }
    FLOAT32   Aspect()        { return aspect; }
    BOOL      PointInside(FLOAT32 x, FLOAT32 y);

    // Debug
    void      Dump(ostream& out);

  public:
    VIEW();
    VIEW(S_RECT, SINT16 d, const char* title="Axonometric View");
    ~VIEW();
};