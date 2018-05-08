//*****************************************************************//
//** Description:   Axonometric Projector, AmigaOS/68K version   **//
//** First Started:                                              **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "axon.hpp"

/*

  TO DO

  FIXES

    1) Fix z scaling factor in projection matrix aka 'The Noah Phenomenon'
       Think this is a clamping problem, values are being calculated outside 0.0 - 1.0

  EXPANSION

    1) Implement Raster Coord -> World space C3D method, use to allow mouse selection of world entities etc.
       Shouldn't be too tricky, similar operation to view rectangle projection

    2) Implement choice of view type (centre, bottom etc)

    3) User definable keys. Will have to wait until I design xKEY:: to interpret the raw keycodes. Don't want to use
       VANILLA_KEYS since they don't report key up/special key presses etc. Probably will use OS console.device for
       the rawkey --> key conversion where needed since is fast and neatly does the localization.
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  VIEW::
//
//  This is the main front end of the projection system
//
//  Provides
//
//  Double buffered display
//  Asynchronous user input
//  Camera
//  ViewPort projection
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

VIEW::VIEW() : xDBWIN(), prjOrigin(0,0,0), zoomLevel(16.0F), flags(BOUNDS_PERP), viewAngle(0), viewPitch(90)
{
  aspect = 1F;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

VIEW::VIEW(S_RECT, sint16 d, const char* title) : xDBWIN(x, y, w, h, d, title), prjOrigin(0,0,0), zoomLevel(16.0F),
                                                  flags(BOUNDS_PERP|MODELS|WATER|DETAIL|BACKFILL), viewAngle(0), viewPitch(90)
{
  aspect = (float32)height/(float32)width;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

VIEW::~VIEW()
{
  Close();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 VIEW::Open()
{
  aspect = (float32)height/(float32)width;
  sint32 r = xDBWIN::Open();
  if (r==OK)
  {
    r = xDRAW::Bind(DrawSurface());
    if (r==OK)
    {
      flags |= DRAW_BOUND;
      r = xDRAW::AllocDepthBuffer();
      if (r==OK)
      {
        xDRAW::DepthCompareMode(xDRAW::DEPTH_LEQ);
        flags |= ZBUFFER_OK;
        SetInput(xINPUT::IDEFAULT);
        return OK;
      }
      else
      {
        puts("VIEW::Open() : no z buffer available");
        flags &= ~(DRAW_BOUND|ZBUFFER_OK);
        xDRAW::Release();
        xDBWIN::Close();
        return ERR_USER;
      }
    }
    puts("VIEW::Open() : couldn't Bind() draw surface");
    xDBWIN::Close();
    return ERR_USER;
  }
  puts("VIEW::Open() : couldn't create display");
  return r;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 VIEW::Close()
{
  if (flags & ZBUFFER_OK)
  {
    flags &= ~ZBUFFER_OK;
    xDRAW::FreeDepthBuffer();
  }
  if (flags & DRAW_BOUND)
  {
    flags &= ~DRAW_BOUND;
    xDRAW::Release();
  }
  flags &= ~QUIT;
  return xDBWIN::Close();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::MouseEvent(sint32 x, sint32 y, sint32 buttons)
{
  printf("Mouse [%d, %d, %d]\n", x, y, buttons);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::KeyEvent(sint32 keyCode, bool state, sint32 ch)
{
  if (!state) // don't bother with key up events
    return;
  switch (keyCode)
  {
    case xKEY::ESC:
      flags |= QUIT;
      //cout << "Exit\n";
      break;

    case xKEY::F1:
      sysBASELIB::MessageBox("Info", "Proceed", "This is not a PC.Pressing F1 isn't goint to help you!\nStop pressing useless keys!");
      break;

    case xKEY::F2:
      flags ^= SHOWMAP;
      break;

    case xKEY::F3:
      flags ^= SHOWMAPC;
      break;

    case xKEY::F4:
      flags ^= DETAIL;
      break;

    case xKEY::F5:
      flags ^= MODELS;
      break;

    case xKEY::F6:
      flags ^= WATER;
      break;

    case xKEY::F7:
      flags ^= STATS;
      break;

    case xKEY::F8:
      Dump();
      break;

    case xKEY::F9:
      MEM::DebugInfo();
      break;

    case xKEY::LEFT:
      Yaw(viewAngle+1); // yaw left
      break;

    case xKEY::RIGHT:
      Yaw(viewAngle-1); // yaw right
      break;

    case xKEY::DOWN:
      Pitch(viewPitch-1); // shallower view
      break;

    case xKEY::UP:
      Pitch(viewPitch+1); // steeper view
      break;

    case xKEY::NP_4:
      Move(prjOrigin.x-DeltaRight().x, prjOrigin.y-DeltaRight().y); // scroll left (window sense)
      break;

    case xKEY::NP_6:
      Move(prjOrigin.x+DeltaRight().x, prjOrigin.y+DeltaRight().y); // scroll right (window sense)
      break;

    case xKEY::NP_2:
      Move(prjOrigin.x-DeltaUp().x, prjOrigin.y-DeltaUp().y); // scroll down (window sense)
      break;

    case xKEY::NP_8:
      Move(prjOrigin.x+DeltaUp().x, prjOrigin.y+DeltaUp().y); // scroll up (window sense)
      break;

    case xKEY::NP_1:
      Move(prjOrigin.x-DeltaRight().x-DeltaUp().x, prjOrigin.y-DeltaRight().y-DeltaUp().y); // scroll down/left (window sense)
      break;

    case xKEY::NP_3:
      Move(prjOrigin.x+DeltaRight().x-DeltaUp().x, prjOrigin.y+DeltaRight().y-DeltaUp().y); // scroll down/right (window sense)
      break;

    case xKEY::NP_7:
      Move(prjOrigin.x-DeltaRight().x+DeltaUp().x, prjOrigin.y-DeltaRight().y+DeltaUp().y); // scroll up/left (window sense)
      break;

    case xKEY::NP_9:
      Move(prjOrigin.x+DeltaRight().x+DeltaUp().x, prjOrigin.y+DeltaRight().y+DeltaUp().y); // scroll up/right (window sense)
      break;

    default:
      switch (ch)
      {
        case ',':
          Zoom(zoomLevel/1.01F);
          break;

        case '.':
          Zoom(zoomLevel*1.01F);
          break;

        case 'b':
        case 'B':
          flags ^= BACKFILL;
          break;
        default:
          printf("I don't know what to do with the '%c' key\n", ch);
          break;
      }
      break;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::ExitEvent()
{
  puts("Exit");
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Window specific
void VIEW::ResizeEvent()
{
  puts("Resize");
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::MoveEvent()
{
  puts("Move");
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Camera(float32 x, float32 y, float32 z, sint16 a, sint16 p)
{
  flags |= CHANGED;
  prjOrigin.x = ClipFloat(x, 0.0F, WORLDMAP::Scale());
  prjOrigin.y = ClipFloat(y, 0.0F, WORLDMAP::Scale());
  zoomLevel   = ClipFloat(z, WORLDMAP::MinZoom(), WORLDMAP::MaxZoom());
  viewAngle   = a;
  viewPitch   = ClipInt(p, 10, 90);
  vA = a % 360;
  if (vA != 0)
    vA = (vA > 0) ? 360-vA : -vA;
  if (vA%90==0)
    flags |= BOUNDS_PERP;
  else
    flags &= ~BOUNDS_PERP;

  Project();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Display()
{
  // RASTER y axis inverted wrt CARTESIAN y axis -> Ry = k-Cy
  register sysVERTEX* vt = Vertices(10);
  {
    rfloat32 scaleF = width/WORLDMAP::Scale();
    rfloat32 offset = (height-width)/2F;
    vt[0].x=scaleF*projected[0].x;    vt[0].y=scaleF*(WORLDMAP::Scale()-projected[0].y)+offset;   vt[0].z=0;
    vt[1].x=scaleF*projected[1].x;    vt[1].y=scaleF*(WORLDMAP::Scale()-projected[1].y)+offset;   vt[1].z=0;
    vt[2].x=scaleF*projected[2].x;    vt[2].y=scaleF*(WORLDMAP::Scale()-projected[2].y)+offset;   vt[2].z=0;
    vt[3].x=scaleF*projected[3].x;    vt[3].y=scaleF*(WORLDMAP::Scale()-projected[3].y)+offset;   vt[3].z=0;
    vt[4].x=vt[0].x; vt[4].y=vt[0].y; vt[4].z=0;
    vt[5].x=scaleF*boundTL.x;         vt[5].y=scaleF*(WORLDMAP::Scale()-boundTL.y)+offset;        vt[5].z=0;
    vt[6].x=scaleF*boundBR.x;         vt[6].y=scaleF*(WORLDMAP::Scale()-boundTL.y)+offset;        vt[6].z=0;
    vt[7].x=scaleF*boundBR.x;         vt[7].y=scaleF*(WORLDMAP::Scale()-boundBR.y)+offset;        vt[7].z=0;
    vt[8].x=scaleF*boundTL.x;         vt[8].y=scaleF*(WORLDMAP::Scale()-boundBR.y)+offset;        vt[8].z=0;
    vt[9].x=vt[5].x; vt[9].y=vt[5].y; vt[9].z=0;
  }
  {
    SetColour(0xFFFFFF00);
    LineStrip(vt,5);
    SetColour(0xFF0000FF);
    LineStrip(vt+5,5);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Move(float32 x, float32 y)
{
  flags |= CHANGED;
  prjOrigin.x = ClipFloat(x, 0.0F, WORLDMAP::Scale());
  prjOrigin.y = ClipFloat(y, 0.0F, WORLDMAP::Scale());
  Project();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Zoom(float32 z)
{
  flags |= CHANGED;
  zoomLevel = ClipFloat(z, WORLDMAP::MinZoom(), WORLDMAP::MaxZoom());
//  viewPitch = 70-(sint16)(60F*((zoomLevel-WORLDMAP::MinZoom())/(WORLDMAP::MaxZoom()-WORLDMAP::MinZoom())));
//  Project();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Yaw(sint16 a)
{
  if (a != viewAngle)
  {
    flags |= CHANGED;
    viewAngle = a%360;
    if (viewAngle != 0)
      vA = (viewAngle > 0) ? 360-viewAngle : -viewAngle;
    else
      vA = 0;
    if (vA%90==0)
      flags |= BOUNDS_PERP;
    else
      flags &= ~BOUNDS_PERP;
//    Project();
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Pitch(sint16 p)
{
  p = ClipInt(p, 10, 90);
  if (p != viewPitch)
  {
    flags |= CHANGED;
    viewPitch = p;
//    Project();
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// WORLD CARTESIAN SENSE

void VIEW::Project()
{
  register VEC3D* vp = projected;
  {
    rfloat32 x2 = WORLDMAP::Scale()/(2F*zoomLevel);
    rfloat32 y2 = (x2*aspect)/QTRIG::SinI(viewPitch);
    rfloat32 ox = QTRIG::CosI(vA);
    rfloat32 oy = QTRIG::SinI(vA);
    rfloat32 x1 = x2*ox;  // TRx * cos A'
    rfloat32 y1 = y2*oy;  // TRy * sin A'
    x2 *= oy;             // TRx * sin A'
    y2 *= ox;             // TRy * cos A'

    ox = prjOrigin.x;
    oy = prjOrigin.y;
    // The above variables now contain the following, note TR == ViewRect top right corner
    //
    // x1 = TRx * cos(A')
    // y1 = TRy * sin(A')
    // x2 = TRx * sin(A')
    // y2 = TRy * cos(A')
    // ox = Ox
    // oy = Oy
    //
    // rotate and translate ViewRect single step. We can do this simply by using
    // addition/subtraction of above terms and taking note of symmetry relating the corners
    // to BR

    vp[0].x = ox - x1 - y1; // TL'x = Ox + [ -TRx *  cos A' ] + [  TRy * -sin A' ]
    vp[0].y = oy - x2 + y2; // TL'y = Oy + [ -TRx *  sin A' ] + [  TRy *  cos A' ]
    vp[1].x = ox + x1 - y1; // TR'x = Ox + [  TRx *  cos A' ] + [  TRy * -sin A' ]
    vp[1].y = oy + x2 + y2; // TR'y = Oy + [  TRx *  sin A' ] + [  TRy *  cos A' ]
    vp[2].x = ox + x1 + y1; // BR'x = Ox + [  TRx *  cos A' ] + [ -TRy * -sin A' ]
    vp[2].y = oy + x2 - y2; // BR'y = Oy + [  TRx *  sin A' ] + [ -TRy *  cos A' ]
    vp[3].x = ox - x1 + y1; // BL'x = Ox + [ -TRx *  cos A' ] + [ -TRy * -sin A' ]
    vp[3].y = oy - x2 - y2; // BL'y = Oy + [ -TRx *  sin A' ] + [ -TRy *  cos A' ]

    ox = 0.02F;
    oy = -ox;
    vp[4].x = oy*y1;            // Up'x = [ 0 * cos A' ] + [ TRy * -sin A' ]
    vp[4].y = ox*y2;            // Up'y = [ 0 * sin A' ] + [ TRy * cos A' ]
    vp[5].x = ox*x1;            // Right'x = [ TRx * cos A' ] + [ 0 * -sin A' ]
    vp[5].y = ox*x2;            // Right'y = [ TRx * sin A' ] + [ 0 * cos A' ]

  }
  // Auto evaluate bounding box
  {
    if (vA < 90)
    {
      boundTL.x = vp[0].x;    boundBR.x = vp[2].x;
      boundTL.y = vp[1].y;    boundBR.y = vp[3].y;
    }
    else if (vA < 180)
    {
      boundTL.x = vp[1].x;    boundBR.x = vp[3].x;
      boundTL.y = vp[2].y;    boundBR.y = vp[0].y;
    }
    else if (vA < 270)
    {
      boundTL.x = vp[2].x;    boundBR.x = vp[0].x;
      boundTL.y = vp[3].y;    boundBR.y = vp[1].y;
    }
    else // if (vA < 360)
    {
      boundTL.x = vp[3].x;    boundBR.x = vp[1].x;
      boundTL.y = vp[0].y;    boundBR.y = vp[2].y;
    }
  }
  // clip the boundingbox to WORLDMAP extrema
  boundTL.x = ClipFloat(boundTL.x, 0F, WORLDMAP::Scale());
  boundTL.y = ClipFloat(boundTL.y, 0F, WORLDMAP::Scale());
  boundBR.x = ClipFloat(boundBR.x, 0F, WORLDMAP::Scale());
  boundBR.y = ClipFloat(boundBR.y, 0F, WORLDMAP::Scale());

  // set the detail level ( 1 / zoomLevel )
  {
    //  World to View projection matrix
    //  We maintain a matrix used to project worldmap coordinates to view space
    //
    //  V = view offset       (pixels)
    //  O = projection origin (map units)
    //
    //  Sz = sin(yaw)
    //  Cz = cos(yaw)
    //  Sx = sin(pitch)
    //  Cx = cos(pitch)
    //  zf = zoom factor/ world scale
    //  vf = view scale factor (view width in pixel units)
    //  zs = z scaling factor for best range (0-1.0)
    //
    //  zs = 1/(0.5F+(sin(viewPitch)*(worldZRange/worldScale)) + viewAspect*cot(viewPitch))
    //
    //  Matrix performs the following operations in single step
    //
    //  Change origin to projection origin : Tp
    //  Rotate Yaw                         : Rz
    //  Rotate Pitch                       : Rx
    //  Screen axis inversion              : A
    //  Scale X/Y/Z to screen              : S
    //  Change origin to viewport top-left : Tv
    //
    //  Full projection matrix, P = Tv.S.A.Rx.Rz.Tp
    //  Which expands to
    //
    //  [  Cz*z1     -Sz*z1      0        Vx+z1*(Sz*Oy-Cz*Ox)     ]
    //  [ -Sx*Sz*z1  -Sx*Cz*z1  -Cx*z1    Vy+Sx*z1*(Ox*Sz+Oy*Cz)  ]
    //  [  Cx*Sz*z2   Cx*Cz*z2  -Sx*z2    Vz-Cx*z2*(Ox*Sz+Oy*Cz)  ]
    //  [  0          0          0        1                       ]
    //
    //  z1 = zoom*width, z2 = zoom*zScreenScale
    //
    {
      float32 Sz = QTRIG::SinI(360-vA);
      float32 Cz = QTRIG::CosI(360-vA);
      float32 Sx = QTRIG::SinI(viewPitch);
      float32 Cx = QTRIG::CosI(viewPitch);
      float32 f4 = zoomLevel/WORLDMAP::Scale(); // zf
      float32 f5 = width*f4;                    // z1
      rfloat32 *m = matrix1;

      *(m++) = Cz*f5;
      *(m++) = -(Sz*f5);
      *(m++) = 0;
      *(m++) = (width*0.5F)+f5*(Sz*prjOrigin.y - Cz*prjOrigin.x);

      *(m++) = -(Sx*Sz*f5);
      *(m++) = -(Sx*Cz*f5);
      *(m++) = -(Cx*f5);
      *(m++) = (aspect*width*0.5F)+(Sx*f5*(Sz*prjOrigin.x + Cz*prjOrigin.y));

      f5 = f4/(1.5+(Sx*WORLDMAP::RangeWZ()/WORLDMAP::Scale()) + aspect*(Cx/Sx)); // z2

      *(m++) = Cx*Sz*f5;
      *(m++) = Cx*Cz*f5;
      *(m++) = -(Sx*f5);
      *m     = 0.5F-(Cx*f5*(Sz*prjOrigin.x + Cz*prjOrigin.y));
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

VIEW& VIEW::operator*=(const TRANSFORM& t)
{
  // Creates a composite matrix that enables model -> world -> screen in 1 pass

  // performs M' = V.M

  rfloat32* d  = matrix2;
  rfloat32* s1 = matrix1;
  rfloat32* s2 = t.matrix;

  // 1st row
  {
      // 'cache' source row terms, except last which is used once
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) = (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]) + *(s1++);
  }
  // 2nd row
  {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) = (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]) + *(s1++);
  }
  // 3rd row
  {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) = (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]) + *(s1++);
  }
  flags |= TRANSFORM_MODEL;
  return *this;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Transform(C3D* src, sysVERTEX* dst, uint32 n)
{
  // Transform a set of vertices to screen space
  rfloat32 *m;
  if (flags & TRANSFORM_MODEL)
  {
    m = matrix2;
    flags &= ~TRANSFORM_MODEL;
  }
  else
    m = matrix1;
  n++;
  while(--n)
  {
    {
      rfloat32 tx = src->x;
      rfloat32 ty = src->y;
      rfloat32 tz = src->z;
      VTX_X(dst) = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
      VTX_Y(dst) = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
      VTX_Z(dst) = Clamp(*(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++), 0.0F, 1.0F);
      m -= 12; // reset matrix pointer
    }
    dst->u      = src->u;
    dst->v      = src->v;
    ARGBtoCol((src++)->c, &((dst++)->color));
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Dump()
{
  printf("\nVIEW Data\nViewPort dimensions : %d x %d pixels\n", width, height);
  printf("View Zoom           : %8.5f\n", zoomLevel);
  printf("View Angle          : %d\n", viewAngle);
  printf("Transform Angle     : %d\n", vA);
  printf("View Pitch          : %d\n", viewPitch);
  printf("Projection Origin   : %8.5f, %8.5f %s\n", prjOrigin.x, prjOrigin.y, WORLDMAP::UnitName());
  printf("Transform TL        : %8.5f, %8.5f %s\n", projected[0].x, projected[0].y, WORLDMAP::UnitName());
  printf("Transform TR        : %8.5f, %8.5f %s\n", projected[1].x, projected[1].y, WORLDMAP::UnitName());
  printf("Transform BR        : %8.5f, %8.5f %s\n", projected[2].x, projected[2].y, WORLDMAP::UnitName());
  printf("Transform BL        : %8.5f, %8.5f %s\n", projected[3].x, projected[3].y, WORLDMAP::UnitName());
  printf("BoundingBox TL      : %8.5f, %8.5f %s\n", boundTL.x, boundTL.y, WORLDMAP::UnitName());
  printf("BoundingBox BR      : %8.5f, %8.5f %s\n", boundBR.x, boundBR.y, WORLDMAP::UnitName());
  printf("DeltaUp             : %8.5f, %8.5f %s\n", projected[4].x, projected[4].y, WORLDMAP::UnitName());
  printf("DeltaRight          : %8.5f, %8.5f %s\n", projected[5].x, projected[5].y, WORLDMAP::UnitName());
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// WORLD CARTESIAN SENSE

bool VIEW::PointInside(float32 x, float32 y)
{
  if (flags & BOUNDS_PERP)
  {
    // simple test since boundary is colinear with map
    if (x >= boundTL.x && y <= boundTL.y && x <= boundBR.x && y >= boundBR.y)
      return true;
    else
      return false;
  }
  else
  {
    // More complex test. Need to check point against following boundaries
    //
    // A1'() Parallel through TL     A1"() Perpendicular through TL
    // A2'() Parallel through BR     A2"() Perpendicular through TL
    //
    // The comparison depends on which quarter circle vA is in

    rfloat32 pp = QTRIG::CotI(vA);
    rfloat32 pl = QTRIG::TanI(vA);
    register VEC3D* vp = projected;
    if (vA < 90) // 1st quarter
    {                                         // When 0 < vA < 90
      rfloat32 yTest = vp[0].y+(x-vp[0].x)*pl;  // Py <= A1'(Px)
      if (y <= yTest)
      {
        yTest = vp[0].y+(x-vp[0].x)*pp;         // Py >= A1"(Px)
        if (y >= yTest)
        {
          yTest = vp[2].y+(x-vp[2].x)*pl;       // Py <= A2'(Px)
          if (y <= yTest)
          {
            yTest = vp[2].y+(x-vp[2].x)*pp;     // Py >= A2"(Px)
            if (y >= yTest)
              return true;
          }
        }
      }
      return false;
    }

    else if (vA < 180) // 2nd quarter
    {                                         // When 90 < vA < 180
      rfloat32 yTest = vp[0].y+(x-vp[0].x)*pl;  // Py >= A1'(Px)
      if (y >= yTest)
      {
        yTest = vp[0].y+(x-vp[0].x)*pp;         // Py >= A1"(Px)
        if (y >= yTest)
        {
          yTest = vp[2].y+(x-vp[2].x)*pl;       // Py <= A2'(Px)
          if (y <= yTest)
          {
            yTest = vp[2].y+(x-vp[2].x)*pp;     // Py <= A2"(Px)
            if (y <= yTest)
              return true;
          }
        }
      }
      return false;
    }

    else if (vA < 270) // 3rd quarter
    {                                         // When 180 < vA < 270
      rfloat32 yTest = vp[0].y+(x-vp[0].x)*pl;  // Py >= A1'(Px)
      if (y >= yTest)
      {
        yTest = vp[0].y+(x-vp[0].x)*pp;         // Py <= A1"(Px)
        if (y <= yTest)
        {
          yTest = vp[2].y+(x-vp[2].x)*pl;       // Py >= A2'(Px)
          if (y >= yTest)
          {
            yTest = vp[2].y+(x-vp[2].x)*pp;     // Py <= A2"(Px)
            if (y <= yTest)
              return true;
          }
        }
      }
      return false;
    }

    else // 4th quarter
    {                                         // When 270 < vA < 360
      rfloat32 yTest = vp[0].y+(x-vp[0].x)*pl;  // Py <= A1'(Px)
      if (y <= yTest)
      {
        yTest = vp[0].y+(x-vp[0].x)*pp;         // Py <= A1"(Px)
        if (y <= yTest)
        {
          yTest = vp[2].y+(x-vp[2].x)*pl;       // Py >= A2'(Px)
          if (y >= yTest)
          {
            yTest = vp[2].y+(x-vp[2].x)*pp;     // Py >= A2"(Px)
            if (y >= yTest)
              return true;
          }
        }
      }
    }
  }
}
