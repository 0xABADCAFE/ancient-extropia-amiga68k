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

#include <stdlib.h>

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  TO DO
//
//  Clean up WORLDMAP code
//  Add load save support
//
//
//  Implement MAPCELL meshing based on that for WORLDMAP, base Render() call on that
//  Implement MAPCELL unique texturing
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  WORLDMAP::
//
//  TO DO : convert scale to use user defined scaling instead of 0.0 - 1.0
//
//  Basis of game world
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

UINT32      WORLDMAP::dimension   = 0;
UINT32      WORLDMAP::logDim      = 0;
FLOAT32     WORLDMAP::fracLimit   = 0F;
C3D*        WORLDMAP::worldGrid   = NOTSET;
FLOAT32     WORLDMAP::minZ        = -0.1F;
FLOAT32     WORLDMAP::maxZ        = 0.1F;
FLOAT32     WORLDMAP::floodLevel  = 0F;

FLOAT32     WORLDMAP::scale       = 1F;
char*       WORLDMAP::unitName    = NOTSET;
FLOAT32     WORLDMAP::detailLevel = 0F;

SINT32      WORLDMAP::vCachePtr   = 0;
sysVERTEX*  WORLDMAP::vCache      = NOTSET;

UINT32      WORLDMAP::frames      = 0;
UINT32      WORLDMAP::frameTime   = 0;
UINT32      WORLDMAP::totalTime   = 0;
xTIMER      WORLDMAP::stopWatch;

MAPCELL*    WORLDMAP::cell        = NOTSET;
MAPCELL**   WORLDMAP::visible     = NOTSET;
MAPCELL**   WORLDMAP::wet         = NOTSET;
MODEL**     WORLDMAP::things      = NOTSET;

xTEXTURE    WORLDMAP::ground;
xTEXTURE    WORLDMAP::water[8]    = { };

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
SINT32 WORLDMAP::Init(UINT32 dim, FLOAT32 s, FLOAT32 fracture, FLOAT32 zmin, FLOAT32 zmax, char* uName, char* texName)
{
  // Allocates dim*dim cells
  // Specifies each cells' location
  // defines each cells neighbouring links

  if (uName)
    unitName = uName;
  if (s > 0)
    scale = s;
/*
  fracture /= scale;
  zmin /= scale;
  zmax /= scale;
*/

  minZ       = ClipFloat(-(scale/2F), 0F, zmin);
  maxZ       = ClipFloat(0F, (scale/2F), zmax);
  logDim     = ClipInt(dim, 1, 8); // 8 is big....Very Big ! (256*256)
  fracLimit  = ClipFloat(fracture, 0F, scale/20F);

  cout << "WORLDMAP::Init() : Initialising resources...";
  if (ground.LoadPPM(texName)!=OK)
  {
    cout << "Error reading texture " << texName << "\n";
    Done();
    return ERR_RSC;
  }
  else
  {
    ground.SetEnv(xTEXTURE::MODULATE);
    ground.SetFilter(xTEXTURE::LINEAR);
  }

  {
    char waterName[] = "data/rip0.tex";
    for (SINT32 i = 0; i < 8; i++)
    {
      sprintf(waterName, "data/rip%d.tex", i);
      if (water[i].Load(waterName)!=OK)
      {
        cout << "Error reading texture " << waterName << "\n";
        Done();
      }
      else
      {
        water[i].SetEnv(xTEXTURE::MODULATE);
        water[i].SetFilter(xTEXTURE::LINEAR);
      }
    }
  }

  dimension = 1<<logDim;

  vCache = New(vCache, MAX_MAP_VERTICES);
  if (!vCache)
  {
    Done();
    return ERR_NO_FREE_STORE;
  }

  cell = New(cell, (dimension*dimension));
  if (!cell)
  {
    Done();
    return ERR_NO_FREE_STORE;
  }

  // Allocate space for 2 NTA of MAPCELL pointers
  visible = New(visible, (2*dimension*dimension)+2);
  if (!visible)
  {
    Done();
    return ERR_NO_FREE_STORE;
  }
  wet = visible + (dimension*dimension)+1;

  // Allocate space of NTA of MODEL pointers
  things = New(things, MAX_VIS_MODELS+1);
  if (!things)
  {
    Done();
    return ERR_NO_FREE_STORE;
  }

  // Allocate a temporary world grid. This is then fractured and used to define all the cells in the map
  worldGrid = New(worldGrid, ((dimension+1)*(dimension+1)));
  if (!worldGrid)
  {
    Done();
    return ERR_NO_FREE_STORE;
  }

  cout << "done\n";

  {
    cout << "WORLDMAP::Init() : Generating surface...";
    GeneratePoints();
    for (SINT32 j=0; j<dimension; j++)
    {
      for (SINT32 i=0; i<dimension; i++)
      {
        // go for checkerboard pattern
        RUINT32 c = (i&1) ? ((j&1) ? 0xFF808080:0xFFFFFFFF) : ((j&1) ? 0xFFFFFFFF:0xFF808080);
        SINT32 tl = i+(j*(dimension+1));
        SINT32 bl = i+((j+1)*(dimension+1));
        Cell(i,j).Set(worldGrid[tl], worldGrid[tl+1], worldGrid[bl+1], worldGrid[bl], c, &ground, &ground);
      }
    }
    cout << "done\n";
  }

  // No longer need the grid since cells now contain the data
  Delete(worldGrid);
  worldGrid = NOTSET;

  // Link cells to neighbours
  cout << "WORLDMAP::Init() : Linking cells...";
  LinkCells();
  cout << "done\n";
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SINT32 WORLDMAP::Done()
{
  ground.Delete();

  for (SINT32 i = 0; i < 8; i++)
    water[i].Delete();

  if (vCache);
    Delete(vCache);
  if (cell)
    Delete(cell);
  if (visible)
    Delete(visible);
  if (things)
    Delete(things);
  if (worldGrid)
    Delete(worldGrid);

  vCache    = 0;
  cell      = 0;
  visible   = 0;
  wet       = 0;
  things    = 0;
  worldGrid = 0;
  dimension = 0;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void WORLDMAP::GeneratePoints()
{
  // Define grid
  SINT32 i, j;

  #define FRACTURE (fracLimit*(((FLOAT32)rand()/RAND_MAX)-0.5F))

  // Set random corner heights
  Junction(0,0).z                 = FRACTURE;
  Junction(0,dimension).z         = FRACTURE;
  Junction(dimension,0).z         = FRACTURE;
  Junction(dimension,dimension).z = FRACTURE;

  FLOAT32 minF = 0;
  FLOAT32 maxF = 0;

  // Fracture grid junctions
  for (SINT32 pass=logDim; pass >= 0; pass--)
  {
    SINT32 o = (1<<pass);
    for (j = 0; j < dimension; j += o)
    {
      for (i = 0; i < dimension; i += o)
      {
        SINT32 di = i&((1<<(pass+1))-1);
        SINT32 dj = j&((1<<(pass+1))-1);
        if (!((di == 0) && (dj == 0)))
        {
          if (di == 0)
          {
            RFLOAT32 average = (Junction(i, j+o).z + Junction(i, j-o).z)/2F;
            average += FRACTURE;
            if (average < minF)
              minF = average;
            else if (average > maxF)
              maxF = average;
            Junction(i,j).z = ClipFloat(average, minZ, maxZ);
          }
          else if (dj == 0)
          {
            RFLOAT32 average = (Junction(i+o, j).z + Junction(i-o, j).z)/2F;
            average += FRACTURE;
            if (average < minF)
              minF = average;
            else if (average > maxF)
              maxF = average;
            Junction(i,j).z = ClipFloat(average, minZ, maxZ);
          }
          else if (di && dj)
          {
            RFLOAT32 average = Junction(i+o, j+o).z + Junction(i+o, j-o).z
                             + Junction(i-o, j+o).z + Junction(i-o, j-o).z;
            average /= 4F;
            average += FRACTURE;
            if (average < minF)
              minF = average;
            else if (average > maxF)
              maxF = average;
            Junction(i,j).z = ClipFloat(average, minZ, maxZ);
          }
        }
      }
    }
  }
  #undef FRACTURE

  {
    FLOAT32 d = scale/dimension;
    FLOAT32 x, y;
    FLOAT32 txScale = (ground.Width() < ground.Height()) ? ground.Height() : ground.Width();
    txScale /= scale;
    for (j=0, y=0.0; j<=dimension; j++, y+=d)
    {
      for (i=0, x=0.0; i<=dimension; i++, x+=d)
      {
        SINT32 m = i+(j*(dimension+1));
        worldGrid[m].x = x;
        worldGrid[m].y = y;

        // TO DO : Real lighting. This is **LAME**

        UINT32 c = (UINT32)(200F*(worldGrid[m].z-minF)/(maxF-minF))+50;

        worldGrid[m].c = 0xFF | c<<16 | c<<8 | c;
        worldGrid[m].u = 8F*x*txScale;
        worldGrid[m].v = 8F*y*txScale;
      }
    }
  }

  // Rescale the world minimum/maximum z to allow for better object height adjustment
  minZ = minF*1.05F;
  maxZ = maxF*1.10F;

  floodLevel = (maxZ + (3F*minZ))/3F;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SINT32 WORLDMAP::LinkCells()
{
  //  Do cell linkage. Cells are linked to their neighbours as follows
  //
  //    Body     Edge     Corner
  //
  //    A B C    0 B C    0 0 0
  //     \|/      \|/      \|/
  //    H-X-D    0-X-D    0-X-D
  //     /|\      /|\      /|\
  //    G F E    0 F E    0 F E

  // Do the four corners, then the edges then finally the body

  // TL, none above, none left
  //cout << "Linking map corners\n";
  RSINT32 m = dimension;
  cell[0].LinkABLF(0);  cell[0].LinkAB(0);          cell[0].LinkABRT(0);                cell[0].LinkBLLF(0);
  cell[0].LinkLF(0);    cell[0].LinkRT(&cell[1]);   cell[0].LinkBL(&cell[m]);           cell[0].LinkBLRT(&cell[m+1]);
  // TR, none above, none right
  RSINT32 n=m-1;
  cell[n].LinkABLF(0);  cell[n].LinkAB(0);          cell[n].LinkABRT(0);                cell[n].LinkRT(0);
  cell[n].LinkBLRT(0);  cell[n].LinkLF(&cell[n-1]); cell[n].LinkBL(&cell[(2*m)-1]);     cell[n].LinkBLLF(&cell[(2*m)-2]);
  // BR, none below, none right
  n = (m*m)-1;
  cell[n].LinkABRT(0);  cell[n].LinkRT(0);          cell[n].LinkBLRT(0);                cell[n].LinkBL(0);
  cell[n].LinkBLLF(0);  cell[n].LinkLF(&cell[n-1]); cell[n].LinkAB(&cell[(m*(m-1))-1]); cell[n].LinkABLF(&cell[(m*(m-1))-2]);
  // BL, none below, none left
  n = m*(m-1);
  cell[n].LinkABLF(0);  cell[n].LinkBLRT(0);        cell[n].LinkBL(0);                  cell[n].LinkBLLF(0);
  cell[n].LinkLF(0);    cell[n].LinkRT(&cell[n+1]); cell[n].LinkAB(&cell[n-m]);         cell[n].LinkABRT(&cell[n-m+1]);
  // Do edges next
  // Top
  //cout << "Linking map top edge\n";
  n = m-1;
  RSINT32 i;
  for (i=1; i<n; i++)
  {
    //cout << "i = " << i << "\n";
    cell[i].LinkABLF(0);            cell[i].LinkAB(0);          cell[i].LinkABRT(0);            cell[i].LinkLF(&cell[i-1]);
    cell[i].LinkBLLF(&cell[i+m-1]); cell[i].LinkBL(&cell[i+m]); cell[i].LinkBLRT(&cell[i+m+1]); cell[i].LinkRT(&cell[i+1]);
  }
  // Bottom
  //cout << "Linking map bottom edge\n";
  n = m*m-1;
  RSINT32 o = 1+m*(m-1); // index for bottom left+1
  for (i=o; i<n; i++)
  {
    //cout << "i = " << i << "\n";
    cell[i].LinkBLLF(0);            cell[i].LinkBL(0);          cell[i].LinkBLRT(0);            cell[i].LinkLF(&cell[i-1]);
    cell[i].LinkABLF(&cell[i-m-1]); cell[i].LinkAB(&cell[i-m]); cell[i].LinkABRT(&cell[i-m+1]); cell[i].LinkRT(&cell[i+1]);
  }
  // Left
  //cout << "Linking map left edge\n";
  o = m-1;
  for (i=1, n=m; i<o; i++, n+=m)
  {
    //cout << "i = " << n << "\n";
    cell[n].LinkABLF(0);            cell[n].LinkLF(0);          cell[n].LinkBLLF(0);            cell[n].LinkAB(&cell[n-m]);
    cell[n].LinkABRT(&cell[n-m+1]); cell[n].LinkRT(&cell[n+1]); cell[n].LinkBLRT(&cell[n+m+1]); cell[n].LinkBL(&cell[n+m]);
  }
  // Right
  //cout << "Linking map right edge\n";
  for (i=1, n=m+o; i<o; i++, n+=m)
  {
    //cout << "i = " << n << "\n";
    cell[n].LinkABRT(0);            cell[n].LinkRT(0);          cell[n].LinkBLRT(0);            cell[n].LinkAB(&cell[n-m]);
    cell[n].LinkABLF(&cell[n-m-1]); cell[n].LinkLF(&cell[n-1]); cell[n].LinkBLLF(&cell[n+m-1]); cell[n].LinkBL(&cell[n+m]);
  }
  // Body. Thankfully this is easy with 2 loops
  //
  // o == dimension - 1
  // m == dimension
  // i == row offset
  // n == current cell index
  //cout << "Linking map body\n";
  i = m;
  for (RSINT32 y=1; y<o; y++, i+=m)
  {
    //cout << "i = " << i+1 << " to " << i+o-1 << "\n";
    for (RSINT32 x=1; x<o; x++)
    {
      n = i+x;
      cell[n].LinkLF(&cell[n-1]); cell[n].LinkABLF(&cell[n-m-1]); cell[n].LinkAB(&cell[n-m]); cell[n].LinkABRT(&cell[n-m+1]);
      cell[n].LinkRT(&cell[n+1]); cell[n].LinkBLRT(&cell[n+m+1]); cell[n].LinkBL(&cell[n+m]); cell[n].LinkBLLF(&cell[n+m-1]);
    }
  }
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SINT32 WORLDMAP::Clip(VIEW& view)
{
  // Builds a null terminated array of pointers to those cells determined to be visible
  SINT32 minX = (SINT32)(((view.BTL().x/scale)*(FLOAT32)dimension)-0.5F)-1;
  SINT32 maxY = (SINT32)(((view.BTL().y/scale)*(FLOAT32)dimension)+0.5F)+1;
  SINT32 maxX = (SINT32)(((view.BBR().x/scale)*(FLOAT32)dimension)+0.5F)+1;
  SINT32 minY = (SINT32)(((view.BBR().y/scale)*(FLOAT32)dimension)-0.5F)-1;

  minX = ClipInt(minX, 0, dimension);
  minY = ClipInt(minY, 0, dimension);
  maxX = ClipInt(maxX, 0, dimension);
  maxY = ClipInt(maxY, 0, dimension);

  detailLevel = (view.Zoom()-MinZoom())/MaxZoom();
  FreeVertices();
  {
    SINT32 i = 0, j = 0, k = 0;
    for (RSINT32 y = minY; y < maxY; y++)
    {
      for (RSINT32 x = minX; x < maxX; x++)
      {
        register MAPCELL* c = &Cell(x,y);
        if (c->Visibility(view))
        {
          visible[i++] = c;
          if (c->Wet())
            wet[j++] = c;
          if (c->Thing())
            things[k++] = c->Thing();
        }
      }
    }
    // null terminate lists
    visible[i]  = 0;
    wet[j]      = 0;
    things[k]   = 0;
  }
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

UINT32 WORLDMAP::Render(VIEW& view)
{
  view.WaitLock();
  stopWatch.Set();
  {
    Disable(ALPHA_BLEND);
    Enable(GOURAUD);
    Enable(TEXTURE);
    Enable(DEPTH_BUFFER);
    Enable(DEPTH_UPDATE);
    ClearDepthBuffer();
    RSINT32 i = 0;
    while(visible[i])
      visible[i++]->Render(view);

    // Detail texture pass, dont modify z buffer
    if (view.State(VIEW::DETAIL) && detailLevel > 0.4F)
    {
      //Flush();
      Disable(DEPTH_UPDATE);
      Enable(ALPHA_BLEND);
      i = 0;
      while(visible[i])
        visible[i++]->Detail();
      Disable(ALPHA_BLEND);
      Enable(DEPTH_UPDATE);
    }

    // Water pass
    if (view.State(VIEW::WATER))
    {
      Enable(ALPHA_BLEND);
      Disable(GOURAUD);
      SetColour(0xFFB0C0FF);
      i = 0;
      while(wet[i])
        wet[i++]->WaterSurf();
      Enable(GOURAUD);
    }

    // Draw models
    if (view.State(VIEW::MODELS))
    {
      i = 0;
      while(things[i])
        things[i++]->Render(view);
    }
    Disable(GOURAUD);
  }
  frameTime = stopWatch.ElapsedSet();
  totalTime += frameTime;

  // Draw map view if active
  if (view.State(VIEW::SHOWMAP))
  {
    Disable(DEPTH_UPDATE);
    Disable(TEXTURE);
    Enable(ALPHA_BLEND);
    if (view.State(VIEW::SHOWMAPC))
    {
      RSINT32 i = 0;
      while(visible[i])
        visible[i++]->Display(view);
    }
    view.Display();
    Disable(ALPHA_BLEND);
  }
  frames++;
  if (view.State(VIEW::STATS))
    DisplayStats(view);
  view.FrameDone();
  view.FreeLock();
  return frameTime;
}

void WORLDMAP::DisplayStats(VIEW& view)
{
  // Renders bar graph display for frameTime, vertex cache usage etc
  static UINT32   gradient[] = {0xA0FF2000, 0xFF008000};
  static UINT32   peakTime    = 0;
  static FLOAT32  peakVCache  = 0;
  SINT16          viewW = view.Width();
  SINT16          viewH = view.Height();
  FLOAT32         vCacheUse = (FLOAT32)vCachePtr/MAX_MAP_VERTICES;

  // reset peak counters after every 64 frames rendered
  peakVCache  = frames&63UL ? (vCacheUse>peakVCache ? vCacheUse:peakVCache):vCacheUse;
  peakTime    = frames&63UL ? (frameTime>peakTime ? frameTime:peakTime):frameTime;

  Disable(DEPTH_BUFFER);
  Enable(ALPHA_BLEND);
  // scale bars
  RectShV(gradient, Coord(16, 16), Coord(32, viewH-16));
  RectShV(gradient, Coord(40, 16), Coord(56, viewH-16));
  RectShV(gradient, Coord(64, 16), Coord(80, viewH-16));
  RectShV(gradient, Coord(88, 16), Coord(104, viewH-16));

  // time
  Rect(0x80FFFFFF, Coord(18, viewH-peakTime-16), Coord(30, viewH-16));
  Rect(0x80FFFFFF, Coord(42, viewH-frameTime-16), Coord(54, viewH-16));

  // vertex cache
  SINT16 v = (SINT16)(peakVCache*((FLOAT32)viewH-32));
  Rect(0x80FFFFFF, Coord(66, viewH-v-16), Coord(78, viewH-16));
  v = (SINT16)(vCacheUse*((FLOAT32)viewH-32));
  Rect(0x80FFFFFF, Coord(90, viewH-v-16), Coord(102, viewH-16));
  Disable(ALPHA_BLEND);
  Enable(DEPTH_BUFFER);
}