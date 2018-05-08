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

VIEW::VIEW() : xDBWIN(), zoomLevel(16.0F), flags(BOUNDS_PERP), viewAngle(0), viewPitch(90)
{
  prjOrigin.y = prjOrigin.x = 0.5F;
  aspect = 1F;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

VIEW::VIEW(S_RECT, SINT16 d, const char* title) : xDBWIN(x, y, w, h, d, title), zoomLevel(16.0F),
                                                  flags(BOUNDS_PERP|MODELS|WATER|DETAIL), viewAngle(0), viewPitch(90)
{
  prjOrigin.y = prjOrigin.x = 0.5F;
  aspect = (FLOAT32)height/(FLOAT32)width;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

VIEW::~VIEW()
{
  Close();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SINT32 VIEW::Open()
{
  aspect = (FLOAT32)height/(FLOAT32)width;
  SINT32 r = xDBWIN::Open();
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
        Begin();
        return OK;
      }
      else
      {
        cout << "VIEW::Open() : no z buffer available\n";
        flags &= ~(DRAW_BOUND|ZBUFFER_OK);
        xDRAW::Release();
        xDBWIN::Close();
        return ERR_USER;
      }
    }
    cout << "VIEW::Open() : couldn't Bind() draw surface\n";
    xDBWIN::Close();
    return ERR_USER;
  }
  cout << "VIEW::Open() : couldn't create display\n";
  return r;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SINT32 VIEW::Close()
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
  Remove();
  flags &= ~QUIT;
  return xDBWIN::Close();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::MouseEvent(SINT32 x, SINT32 y, SINT32 buttons)
{
   cout << "Mouse [" << x << ", " << y << ", " << buttons << "]\n";
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::KeyEvent(SINT32 keyCode)
{
  WaitLock();
  switch (keyCode)
  {
    case 0x00000045:
      flags |= QUIT;
      //cout << "Exit\n";
      break;

    case 0x00000050:
      sysBASELIB::MessageBox("Info", "Proceed", "This is not a PC.Pressing F1 isn't goint to help you!\nStop pressing useless keys!");
      break;

    case 0x00000051:
      if (flags & SHOWMAP)
        flags &= ~SHOWMAP;
      else
        flags |= SHOWMAP;
      break;

    case 0x00000052:
      if (flags & SHOWMAPC)
        flags &= ~SHOWMAPC;
      else
        flags |= SHOWMAPC;
      break;

    case 0x00000053:
      if (flags & DETAIL)
        flags &= ~DETAIL;
      else
        flags |= DETAIL;
      break;

    case 0x00000054:
      if (flags & MODELS)
        flags &= ~MODELS;
      else
        flags |= MODELS;
      break;

    case 0x00000055:
      if (flags & WATER)
        flags &= ~WATER;
      else
        flags |= WATER;
      break;

    case 0x00000056:
      if (flags & STATS)
        flags &= ~STATS;
      else
        flags |= STATS;
      break;

    case 0x00000057:
      Dump(cout);
      break;

    case 0x00000058:
      MEM::DebugInfo();
      break;

    case 0x0000004F:
      Yaw(viewAngle+1);
      //cout << "Rotate left\n";
      break;

    case 0x0000004E:
      Yaw(viewAngle-1);
      //cout << "Rotate right\n";
      break;

    case 0x0000004D:
      Pitch(viewPitch-1);
      //cout << "Pitch down\n";
      break;

    case 0x0000004C:
      Pitch(viewPitch+1);
      //cout << "Pitch up\n";
      break;

    case 11:
      Zoom(zoomLevel/1.01F);
      //cout << "Zoom out\n";
      break;

    case 12:
      Zoom(zoomLevel*1.01F);
      //cout << "Zoom in\n";
      break;

    case 45:
      Move(prjOrigin.x-DeltaRight().x, prjOrigin.y-DeltaRight().y);
      break;

    case 47:
      Move(prjOrigin.x+DeltaRight().x, prjOrigin.y+DeltaRight().y);
      break;

    case 30:
      Move(prjOrigin.x-DeltaUp().x, prjOrigin.y-DeltaUp().y);
      break;

    case 62:
      Move(prjOrigin.x+DeltaUp().x, prjOrigin.y+DeltaUp().y);
      break;

    default:
      break;
  }
  FreeLock();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::ExitEvent()
{
  cout << "Exit\n";
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Window specific
void VIEW::ResizeEvent()
{
  cout << "Resize\n";
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::MoveEvent()
{
  cout << "Move\n";
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Camera(FLOAT32 x, FLOAT32 y, FLOAT32 z, SINT16 a, SINT16 p)
{
  WaitLock();
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
  FreeLock();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Display()
{
  // RASTER y axis inverted wrt CARTESIAN y axis -> Ry = k-Cy
  register sysVERTEX* vt = Vertices(10);
  {
    RFLOAT32 scaleF = width/WORLDMAP::Scale();
    RFLOAT32 offset = (height-width)/2F;
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

void VIEW::Move(FLOAT32 x, FLOAT32 y)
{
  flags |= CHANGED;
  prjOrigin.x = ClipFloat(x, 0.0F, WORLDMAP::Scale());
  prjOrigin.y = ClipFloat(y, 0.0F, WORLDMAP::Scale());
  Project();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Zoom(FLOAT32 z)
{
  flags |= CHANGED;
  zoomLevel = ClipFloat(z, WORLDMAP::MinZoom(), WORLDMAP::MaxZoom());
//  viewPitch = 70-(SINT16)(60F*((zoomLevel-WORLDMAP::MinZoom())/(WORLDMAP::MaxZoom()-WORLDMAP::MinZoom())));
  Project();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Yaw(SINT16 a)
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
    Project();
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Pitch(SINT16 p)
{
  p = ClipInt(p, 10, 90);
  if (p != viewPitch)
  {
    flags |= CHANGED;
    viewPitch = p;
    Project();
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// WORLD CARTESIAN SENSE

void VIEW::Project()
{
  register C2D* vp = projected;
  {
    RFLOAT32 x2 = WORLDMAP::Scale()/(2F*zoomLevel);
    RFLOAT32 y2 = (x2*aspect)/QSin(viewPitch);
    RFLOAT32 ox = QCos(vA);
    RFLOAT32 oy = QSin(vA);
    RFLOAT32 x1 = x2*ox;  // TRx * cos A'
    RFLOAT32 y1 = y2*oy;  // TRy * sin A'
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
    //
    //  We maintain a matrix used to project worldmap coordinates to view space
    //
    //  V = view offset       (pixels)
    //  O = projection origin (map units)
    //
    //  SZ = sin(yaw)
    //  CZ = cos(yaw)
    //  SX = sin(pitch)
    //  CX = cos(pitch)
    //  zf = zoom factor/ world scale
    //  vf = view scale factor (view width in pixel units)
    //  zs = z scaling factor for best range (0-1.0)
    //
    //  zs = 1 / (aspect.(CX/SX) + SX.(maxWz-minWz))
    //
    //  Matrix is composite of scale, rotate Yaw, rotate Pitch, invert Y/Z senses
    //
    //
    //    | x'|   | Vx |   |  (CZ.vf.zf)    -(SZ.vf.zf)     0          | | (x-Ox) |
    //    |   |   |    |   |                                           | |        |
    //    | y'| = | Vy | + |  (SX.SZ.vf.zf)  (SX.CZ.vf.zf)  (CX.vf.zf) | | (y-Oy) |
    //    |   |   |    |   |                                           | |        |
    //    | z'|   | Vz |   |  (CX.SZ.zf.zs)  (CX.CZ.zf.zs) -(SX.zs)    | | (z-Oz) |
    //
    //  Note : z' in range 0 - 1.0, not scaled by vf, hence Vz = 0.5. Also world z unaffected by zoomLevel

    RFLOAT32 f0 = QSin(360-vA);                 // SZ
    RFLOAT32 f1 = QCos(360-vA);                 // CZ
    RFLOAT32 f2 = QSin(viewPitch);              // SX
    RFLOAT32 f3 = QCos(viewPitch);              // CX
    RFLOAT32 f4 = zoomLevel/WORLDMAP::Scale();  // zf
    RFLOAT32 f5 = width*f4;                     // vf.zf
    RFLOAT32 *m = matrix;
    {
      *(m++) = width*0.5F;        // Vx
      *(m++) = (f1*f5);           // (CZ.vf.zf)
      *(m++) = -(f0*f5);          // (SZ.vf.zf)
      *(m++) = aspect*width*0.5F; // Vy
      *(m++) = -(f2*f0*f5);       // -(SX.SZ.vf.zf)
      *(m++) = -(f2*f1*f5);       // -(SX.CZ.vf.zf)
      *(m++) = -(f3*f5);          // -(CX.vf.zf)

      // z terms require different scaling factor to transform values into best 0.0 - 1.0 range
      f5     = aspect/(aspect*(f3/f2) + f2*(WORLDMAP::RangeWZ()/WORLDMAP::Scale())); // f5 = zf.zs;

      *(m++) = f4*f3*f0*f5;                 // (CX.SZ.zf.zs)
      *(m++) = f4*f3*f1*f5;                 // (CX.CZ.zf.zs)

      f5    /= WORLDMAP::Scale();

      *(m++) = -(f2*f5);                    // -(SX.zs)
    }
  }

  // Do the visibility analysis. This way, only when we actually reproject to we do cell clipping.
  // Also, this method is called primarily from the sub thread, so it doesn't impact on the main routine
  WORLDMAP::Clip(*this);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VIEW::Dump(ostream& out)
{
  out.setf(ios::showpoint);
  out << "\nVIEW Data\n" << "ViewPort dimensions : " << width << "*" << height << "\n";
  out << "View Zoom           : " << zoomLevel << "\n";
  out << "View Angle          : " << viewAngle << "\n";
  out << "Transform Angle     : " << vA << "\n";
  out << "View Pitch          : " << viewPitch << "\n";
  out << "Projection Origin   : " << prjOrigin.x << ", " << prjOrigin.y << " " << WORLDMAP::UnitName() << "\n";
  out << "Transform TL        : " << projected[0].x << ", " << projected[0].y << " " << WORLDMAP::UnitName()<< "\n";
  out << "Transform TR        : " << projected[1].x << ", " << projected[1].y << " " << WORLDMAP::UnitName()<< "\n";
  out << "Transform BR        : " << projected[2].x << ", " << projected[2].y << " " << WORLDMAP::UnitName()<< "\n";
  out << "Transform BL        : " << projected[3].x << ", " << projected[3].y << " " << WORLDMAP::UnitName()<< "\n";
  out << "BoundingBox TL      : " << boundTL.x << ", " << boundTL.y << " " << WORLDMAP::UnitName()<< "\n";
  out << "BoundingBox BR      : " << boundBR.x << ", " << boundBR.y << " " << WORLDMAP::UnitName()<< "\n";
  out << "DeltaUp             : " << projected[4].x << ", " << projected[4].y << " " << WORLDMAP::UnitName()<< "\n";
  out << "DeltaRight          : " << projected[5].x << ", " << projected[5].y << " " << WORLDMAP::UnitName()<< "\n";
/*
  out << "Projection Matrix   : | " << matrix[1] << " " << matrix[2] << " " << 0F << " |\n"
         "                      | " << matrix[4] << " " << matrix[5] << " " << matrix[6] << " |\n"
         "                      | " << matrix[7] << " " << matrix[8] << " " << matrix[9] << " |\n";
*/
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// WORLD CARTESIAN SENSE

BOOL VIEW::PointInside(FLOAT32 x, FLOAT32 y)
{
  if (flags & BOUNDS_PERP)
  {
    // simple test since boundary is colinear with map
    if (x >= boundTL.x && y <= boundTL.y && x <= boundBR.x && y >= boundBR.y)
      return TRUE;
    else
      return FALSE;
  }
  else
  {
    // More complex test. Need to check point against following boundaries
    //
    // A1'() Parallel through TL     A1"() Perpendicular through TL
    // A2'() Parallel through BR     A2"() Perpendicular through TL
    //
    // The comparison depends on which quarter circle vA is in

    RFLOAT32 pp = Perp(vA);
    RFLOAT32 pl = Parallel(vA);
    register C2D* vp = projected;
    if (vA < 90) // 1st quarter
    {                                         // When 0 < vA < 90
      RFLOAT32 yTest = vp[0].y+(x-vp[0].x)*pl;  // Py <= A1'(Px)
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
              return TRUE;
          }
        }
      }
      return FALSE;
    }

    else if (vA < 180) // 2nd quarter
    {                                         // When 90 < vA < 180
      RFLOAT32 yTest = vp[0].y+(x-vp[0].x)*pl;  // Py >= A1'(Px)
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
              return TRUE;
          }
        }
      }
      return FALSE;
    }

    else if (vA < 270) // 3rd quarter
    {                                         // When 180 < vA < 270
      RFLOAT32 yTest = vp[0].y+(x-vp[0].x)*pl;  // Py >= A1'(Px)
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
              return TRUE;
          }
        }
      }
      return FALSE;
    }

    else // 4th quarter
    {                                         // When 270 < vA < 360
      RFLOAT32 yTest = vp[0].y+(x-vp[0].x)*pl;  // Py <= A1'(Px)
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
              return TRUE;
          }
        }
      }
    }
  }
}
