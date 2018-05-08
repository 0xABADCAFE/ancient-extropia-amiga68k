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
//  MAPCELL
//
//  Basic Rendering unit. Will be much expanded later, for now is totally flat and single colour (bor-ing)
//
//  Cell verticies are defined in map space, that is 0 <= x/y/z <= 1
//  This simplifies rendering as we shall see later
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class MODEL;
class MAPCELL : protected AXON {

  private:
    UINT32        flags;
    SINT32        points;     // expand me
    W3D_Vertex*   projected;
    MODEL*        thing;      // expand me
    W3D_Texture*  tex;
    W3D_Texture*  detail;
    C3D           data[5];
    MAPCELL*      neighbour[8];
    enum {
      TL_VIS  = 0x00000001,
      TR_VIS  = 0x00000002,
      BR_VIS  = 0x00000004,
      BL_VIS  = 0x00000008,
      VIS     = 0x0000000F,
      WATER   = 0x00000010,
      RETEX   = 0x00000020,
      NOTEX   = 0x00000040
    };


  public:
    void Set(C3D& tl, C3D& tr, C3D& br, C3D& bl, UINT32 c, xTEXTURE* t, xTEXTURE* d);
    FLOAT32 Topology(); // evaluates a cell complexity based on four corners

    BOOL AddThing(MODEL& t) { if (thing || flags & WATER) return FALSE; thing = &t; return TRUE; }

  public:
    C3D&  CT()  { return data[0]; }
    C3D&  TL()  { return data[1]; }
    C3D&  TR()  { return data[2]; }
    C3D&  BR()  { return data[3]; }
    C3D&  BL()  { return data[4]; }

    void LinkABLF(MAPCELL* m) { neighbour[0]=m; }
    void LinkAB(MAPCELL* m)   { neighbour[1]=m; }
    void LinkABRT(MAPCELL* m) { neighbour[2]=m; }
    void LinkRT(MAPCELL* m)   { neighbour[3]=m; }
    void LinkBLRT(MAPCELL* m) { neighbour[4]=m; }
    void LinkBL(MAPCELL* m)   { neighbour[5]=m; }
    void LinkBLLF(MAPCELL* m) { neighbour[6]=m; }
    void LinkLF(MAPCELL* m)   { neighbour[7]=m; }
    MAPCELL* NbrABLF()  { return neighbour[0]; }
    MAPCELL* NbrAB()    { return neighbour[1]; }
    MAPCELL* NbrABRT()  { return neighbour[2]; }
    MAPCELL* NbrRT()    { return neighbour[3]; }
    MAPCELL* NbrBLRT()  { return neighbour[4]; }
    MAPCELL* NbrBT()    { return neighbour[5]; }
    MAPCELL* NbrBTLF()  { return neighbour[6]; }
    MAPCELL* NbrLF()    { return neighbour[7]; }

  public:
    BOOL    Visibility(VIEW& v);  // Retests visibility
    BOOL    Visible(VIEW& v);     // returns TRUE if overlaps projected viewport
    void    Display(VIEW& v);     // displays cell in viewport
    void    Render(VIEW& v);      // renders cell
    void    Detail();             // renders detail, use AFTER Render();
    void    WaterSurf();          // renders water texture
    BOOL    Wet()             { return flags & WATER; }
    MODEL*  Thing()           { return thing; }

    MAPCELL();
    ~MAPCELL();
};

inline BOOL MAPCELL::Visible(VIEW& v)
{
  if (!v.State(VIEW::CHANGED))
    return flags & VIS;
  else
    return Visibility(v);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  WORLDMAP::
//
//  Implements a 2D array of MAPCELLs. Each cell is linked to all of its immediate neighbours.
//  Implements main rendering routine, used to generate an image in the specific VIEW
//  Provides a vertex cache that allows transformed verticies to be continuously reused as long as the
//  view is unchanging
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define MAX_MAP_VERTICES 16384UL
#define MAX_VIS_MODELS   2047UL

class MODEL;

class WORLDMAP : protected AXON {

  private:
    // Fundamental properties
    static UINT32       dimension;    // cells to map edge, equivalent to 2^logDim
    static UINT32       logDim;
    static FLOAT32      fracLimit;    // surface generation fracture limit
    static C3D*         worldGrid;    // temporary fracture surface
    static FLOAT32      minZ, maxZ;   // World height extrema
    static FLOAT32      floodLevel;   // World water level

    // Abstract properties
    static FLOAT32      scale;        // World scale value
    static char*        unitName;     // World scale unit name (eg 'metres', 'kilometres', etc)
    static FLOAT32      detailLevel;

    // Vertex Cache
    static SINT32       vCachePtr;  // Current vertex cache index
    static sysVERTEX*   vCache;     // Cache for projected vertices, reset every time view changes

    // Data
    static MAPCELL*     cell;         // World MAPCELL array
    static MAPCELL**    visible;      // render list for currently visible cells
    static MAPCELL**    wet;          // as above for cells with water
    static MODEL**      things;       // as above for objects

    // Performance
    static UINT32       frames;
    static UINT32       frameTime;
    static UINT32       totalTime;
    static xTIMER       stopWatch;

    // Graphics
    static xTEXTURE     ground;
    static xTEXTURE     water[8];

  private:
    static void         GeneratePoints();
    static SINT32       LinkCells();
    static C3D&         Junction(RUINT16 i, RUINT16 j)  { return worldGrid[(j*(dimension+1))+i]; }

  public:
    static sysVERTEX*   CachedVertices(SINT32 n);
    static void         FreeVertices()                  { vCachePtr = 0;}
    static sysTEXTURE*  WaterTex()                      { return TexHandle(&water[(frames&7)]); }
    static FLOAT32      WaterSize()                     { return 4F*water[0].Width(); }
    static FLOAT32      Scale()                         { return scale; }
    static char*        UnitName()                      { return unitName; }

  public:
    static SINT32       Init(UINT32 d, FLOAT32 ws, FLOAT32 fr, FLOAT32 zmn, FLOAT32 zmx, char* uName, char* txName);
    static SINT32       Done();
    static FLOAT32      LOD()                           { return detailLevel; }
    static FLOAT32      MinWZ()                         { return minZ; }
    static FLOAT32      MaxWZ()                         { return maxZ; }
    static FLOAT32      RangeWZ()                       { return maxZ - minZ; }
    static MAPCELL&     Cell(RUINT16 i, RUINT16 j)      { return cell[(j*dimension)+i]; }
    static SINT32       Clip(VIEW& v);
    static UINT32       Render(VIEW& v);
    static FLOAT32      MaxZoom()                       { return 0.75*dimension; }
    static FLOAT32      MinZoom()                       { return 0.0625*dimension; }
    static FLOAT32      SeaLevel()                      { return floodLevel; }
    static void         DisplayStats(VIEW& v);
    static UINT32       Frames()                        { return frames; }
    static UINT32       FrameTime()                     { return frameTime; }
    static FLOAT32      AvgFrameTime()                  { return (FLOAT32)totalTime/(FLOAT32)frames; }
};

inline sysVERTEX* WORLDMAP::CachedVertices(SINT32 n)
{
  if (n+vCachePtr > MAX_MAP_VERTICES)
  {
    cout << "Vertex Overflow\n";
    return 0;
  }
  sysVERTEX* v = vCache+vCachePtr;
  vCachePtr+=n;
  return v;
}