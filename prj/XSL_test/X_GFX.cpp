/*

  Extropia System Library test code by Karlos, eXtropia Studios

*/

#include <xBase.hpp>
#include <xSystem/xResources.hpp>
#include <xSystem/xDraw.hpp>
#include <fstream.h>
#include <stdlib.h>

uint32 fill0[] = {0x7FFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFFFFFFF};
uint32 fill1[] = {0x80303080, 0xFF0080FF, 0xFFFF2010};
uint32 fill2[] = {0x80FFFF10, 0xFF208040, 0xFF1020FF};
uint32 fill3[] = {0x2F1020FF, 0xFFD0D0FF};
uint32 fill4[] = {0xFF204020, 0xFF40A040};
uint32 fill5[] = {0x18FF5050, 0xFF501010};
uint32 fill6[] = {0xFFC0C03F, 0xFFC0C0FF, 0xFFC0C000, 0xFFC0403F};

uint32 BenchmarkQuardics(xDISPLAY& win);
uint32 Primitives(xDISPLAY& win);
uint32 TriangleFX(xDISPLAY& win);
uint32 BounceFX(xDISPLAY& win);
uint32 CampFireFX(xDISPLAY& win);
uint32 LightSourceTXFX(xDISPLAY& win);

/////////////////////////////////////////////////////////////////////////////////////////////

uint32 Primitives(xDISPLAY& win)
{
  // Shows some of the drawing primitives with and without shading
  sint16 x = win.Width()/4;
  sint16 y = win.Height()/4;
  xTIMER t;
  t.Set();
  xDRAW::Begin();
  {
    xDRAW::Clear();
    xDRAW::Disable(xDRAW::ALPHA_BLEND);
    // show some simple rectangles
    xDRAW::Rect(0xFFFF0000, Coord(4,4), Coord(x-4,y-4));
    xDRAW::RectShH(fill1, Coord(x+4,4), Coord(2*x-4,y-4));
    xDRAW::RectShV(fill4, Coord(2*x+4,4), Coord(3*x-4,y-4));
    xDRAW::RectShA(fill0, Coord(3*x+4,4), Coord(4*x-4,y-4));

    // show some triangles
    xDRAW::Tri(0xFF00FF00, Coord(4,2*y-4), Coord(x/2+4,y+4), Coord(x-4, 2*y-4));
    xDRAW::TriShA(fill1, Coord(x+4,2*y-4), Coord(x/2+x+4,y+4), Coord(2*x-4, 2*y-4));

    // show some circles
    xDRAW::Circle(0xFFFF00FF, Coord(x/2,y/2+2*y), (x/2-4));
    xDRAW::CircleShC(fill2, Coord(x+x/2,y/2+2*y), (x/2-4));
    xDRAW::CircleShPt(fill3, Coord(x/2,y/2+3*y), Coord(-32,-32), (x/2-4));

    // show some elipses
    xDRAW::Elipse(0xFF0000FF, Coord(3*x, y/2+y), Coord(x-4,y/2-4));
    xDRAW::ElipseShC(fill3, Coord(3*x, y/2+2*y), Coord(x-4,y/2-4));
    xDRAW::ElipseShPt(fill5, Coord(3*x, y/2+3*y), Coord(-40, -20), Coord(x-4,y/2-4));
  }
  xDRAW::End();
  uint32 ms = t.ElapsedSet();
  win.Refresh();
  return ms;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32 TriangleFX(xDISPLAY& win)
{
  // draws a 'lattice' of shaded triangles, using alpha blending to generate a nice
  // transparency

  // Since Width()/Height() are virtual, get them now. Some compilers might not
  // inline AREAs methods
  sint16 winW = win.Width();
  sint16 winH = win.Height();
  xDRAW::Enable(xDRAW::ALPHA_BLEND);
  xTIMER t;
  t.Set();
  xDRAW::Begin();
  {
    xDRAW::Clear();
    for (sint32 i = 0; i < winW; i+=16)
    {
      xDRAW::TriShA(fill1, Coord(i, 0), Coord(winW>>1,winH>>1), Coord(i,winH));
      xDRAW::TriShA(fill2, Coord(0, i), Coord(winW>>1,winH>>1), Coord(winW, i));
    }
  }
  xDRAW::End();
  uint32 ms = t.ElapsedSet();
  win.Refresh();
  return ms;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32 BounceFX(xDISPLAY& win)
{
  // draws a nice 'motion blurred' picture of a falling ball using simple
  // primitives and alpha blending to simulate the motion blur
  sint16 winW = win.Width();
  sint16 winH = win.Height();
  xTIMER t;
  t.Set();
  xDRAW::Begin();
  {
    xDRAW::Clear();

    // draw sky and ground
    xDRAW::Disable(xDRAW::ALPHA_BLEND);
    xDRAW::RectShV(fill3, 0, Coord(winW,winH-180));
    xDRAW::RectShV(fill4, Coord(0,winH-180), Coord(winW,winH));

    // draw the transparent after-images
    xDRAW::Enable(xDRAW::ALPHA_BLEND);
    for (sint32 i = 0, n = 1; i < (winH-256); i+=n, n+=2)
    {
      xDRAW::CircleShPt(fill5, Coord(winW>>1,96+i), Coord(-24,-32), 64);
    }
    // draw the shadow
    xDRAW::Elipse(0x30000000, Coord((winW>>1)+64,176+i), Coord(76,16));

    // draw the ball
    xDRAW::Disable(xDRAW::ALPHA_BLEND);
    xDRAW::CircleShPt(fill5, Coord(winW>>1,96+i), Coord(-24,-32), 64);
    xDRAW::End();
    win.Refresh();
  }
  xDRAW::End();
  uint32 ms = t.ElapsedSet();
  win.Refresh();
  return ms;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32 CampFireFX(xDISPLAY& win)
{
  // Draws a cute campfire using xTEXTURE::Cell() to achieve simple flame animation
  // The position of the objects is stored here in dimension independent coords (0.0 - 1.0)
  // We convert these to xDRAW ICOORD2D (really uint32) by multiplying by the display
  // dimensions

  static float32 posF[48] = {
    //sky
    0.0,        0.0,        1.0,      0.375,  // top to near horizon
    0.0,        0.375,      1.0,      0.5,    // near horizon to horizon
    0.0,        0.5,        1.0,      1.0,    // horizon to front
    //trees
    0.169922,   0.28125,    0.494141, 0.605469, // each as rectangle x1,y1,x2,y2
    0.0332031,  0.326172,   0.357422, 0.576172,
    0.619141,   0.326172,   0.943359, 0.585453,
    0.337891,   0.220703,   0.638672, 0.595703,
    -0.246094,  0.0664062,  0.402344, 0.742187, // note the negative x1 value - were allowed to draw off screen
    0.421875,   0.0644531,  0.945312, 0.664062,
    0.681641,   0.128906,   1.23242,  0.703125,
    // flame & glow
    0.5,        0.375,      0.5,      0.75,     // basic flame sprite position
    0.5,        0.75,       0.6,      0.1     // elipse data for glow effect
  };

  // Some colour data for shaded objects
  static uint32 bGrad[10] = {
    0xFF00004F, 0xFFA040FF, 0xFF000000, 0xFF000802, // background gradients
    0xFF080820, 0xFFFF6030, 0xFF080820, 0xFF8F4020, // tree gradients
    0x7FFFE030, 0xFF0A0802                          // fire gradients
  };

  // Coordinate after window dimension converison
  ICOORD2D pos[24];
  {
    // convert the coordinate data to fit the window dimension
    float32 w = win.Width();
    float32 h = win.Height();
    sint32 i;
    for (i = 0; i < 24; i++)
    {
      sint16 x = (posF[(i<<1)]*w);
      sint16 y = (posF[(i<<1)+1]*h);
      pos[i] = Coord(x,y);
    }
  }

  ICOORD2D* skyPos      = pos;
  ICOORD2D* treePos     = pos+6;
  ICOORD2D* firePos     = pos+20;
  uint32*   skyCol      = bGrad;
  uint32*   treeCol     = bGrad+4;
  uint32*   fireCol     = bGrad+8;

  // load the texture. The data is 256*128*24 bit ppm, arranged as 8*32 frames of
  // 32*128. We load the data, asking the routine to generate an alpha channel for
  // the texture based on a bias of each of red green and blue.
  xTEXTURE flame;
  if (flame.LoadPPM("flame.ppm",0xFFFFFFA0)!=OK)
  {
    sysBASELIB::MessageBox("Error", "OK", "Couldn't load texture");
    return 0;
  }
  else
  {
    flame.SetFilter(W3D_LINEAR);
    flame.SetEnv(xTEXTURE::REPLACE);
    flame.DefineCell(Coord(32,128), 8, 1); // manually set frame info
  }

  xTEXTURE ground;
  if (ground.LoadPPM("ground.ppm")!=OK)
  {
    flame.Delete();
    sysBASELIB::MessageBox("Error", "OK", "Couldn't load texture");
    return 0;
  }
  else
  {
    ground.SetFilter(W3D_LINEAR);
    ground.SetEnv(xTEXTURE::MODULATE);
  }

  xTEXTURE tree;
  if (tree.Load("tree.tex")!=OK)
  {
    flame.Delete();
    ground.Delete();
    sysBASELIB::MessageBox("Error", "OK", "Couldn't load tree texture");
    return 0;
  }
  else
  {
    tree.SetFilter(W3D_LINEAR);
    tree.SetEnv(xTEXTURE::MODULATE);
  }

  MEM::DebugInfo();

  sint16 flameX  = CoordX(firePos[0]);
  sint16 flameY1 = CoordY(firePos[0]);
  sint16 flameY2 = CoordY(firePos[1]);

  uint32 ms   = 0;
  sint32 size = 64+(16*rand())/RAND_MAX; // flame size base
  xTIMER t;
  for (sint32 i = 0, j = 0; i<512; i++, j++)
  {
    if (j>=flame.Cells())
      j = 0;

    t.Set();
    xDRAW::Begin();
    {
      // draw background
      xDRAW::Disable(xDRAW::ALPHA_BLEND);
      xDRAW::RectShV(skyCol,    skyPos[0], skyPos[1]);
      xDRAW::RectShV(skyCol+1,  skyPos[2], skyPos[3]);
      xDRAW::RectShV(skyCol+2,  skyPos[4], skyPos[5]);
      xDRAW::Enable(xDRAW::ALPHA_BLEND);

      {
        // randomly flare the flame size
        if (rand()>(14*RAND_MAX/16))
          size += rand()/(RAND_MAX/32);

        // modulate some of the colours based on the flame size. The random value added here imparts a flicker
        uint32 m = size+(rand()/(RAND_MAX/16));
        SetCol32A(fireCol[0],0x6F+m);
        SetCol32G(treeCol[1],0x60+m);
      }

      if ((i&3L)==0)
      {
        SetCol32B(skyCol[0], 0x4F-(i>>3));
        SetCol32R(skyCol[1], 0xA0-(i>>2));
        SetCol32G(skyCol[1], 0x40-(i>>3));
      }


      // draw the glow
      xDRAW::ElipseScTxShC(fireCol, firePos[2], firePos[3], ground);

      // draw some trees
      {
        xDRAW::RectScTxShV(treeCol+2, treePos[0], treePos[1], tree);
        xDRAW::RectScTxShV(treeCol+2, treePos[2], treePos[3], tree);
        xDRAW::RectScTxShV(treeCol+2, treePos[4], treePos[5], tree);
        xDRAW::RectScTxShV(treeCol, treePos[6], treePos[7], tree);
        xDRAW::RectScTxShV(treeCol, treePos[8], treePos[9], tree);
        xDRAW::RectScTxShV(treeCol, treePos[10], treePos[11], tree);
        xDRAW::RectScTxShV(treeCol, treePos[12], treePos[13], tree);
      }

      // draw the flame
      flame.Cell(j);
      xDRAW::RectScTx(0xFFFFFFFF, Coord(flameX-(size>>1), flameY1-size), Coord(flameX+(size>>1), flameY2), flame);

      // gradually decay the flame size towards default of 64
      size = (size<<3) - size + 64; size>>=3;

    }
    xDRAW::End();
    ms += t.ElapsedSet();
    win.Refresh();
    win.WaitSync();
  }
  return ms;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uint32 LightSourceTXFX(xDISPLAY& win)
{
  // Now this is a killer 2D effect.
  // We have a little robot animation using a special multi-layered frame effect.
  // Using alpha channels and blending we can simulate real-time lighting of our sprite.

  // The cells are defined in the texture. We have arranged them such that each lightmap
  // begins on a new row

  xTEXTURE robot;
  sint32 r = robot.LoadLST("robot.tex",TXS_ARGB_4444);
  robot.SetEnv(xTEXTURE::MODULATE);
  if(r!=OK)
  {
    sysBASELIB::MessageBox("Error", "OK", "Couldn't load texture\nReason %s",xBASELIB::Error(r));
    return 0;
  }

  uint32 background[] = {0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000};

  uint32 ambient = 0xFF202020;
  uint32 top     = 0x00C0D0FF;
  uint32 bottom  = 0xFFFF0000;
  uint32 left    = 0x000080FF;
  uint32 right   = 0xFFFFFF00;

  sint16 winW = win.Width();
  sint16 winH = win.Height();
  uint32 ms = 0;  xTIMER t;

  xDRAW::Disable(xDRAW::ALPHA_BLEND);
  for (sint32 i=0, j=0; i<256; i++, j++)
  {
    if (j>=robot.CellsH()) j = 0;
    t.Set();
    xDRAW::Begin();
    {
      // mess about with background colour to match robot's shading
      background[1] = background[0] = Col32(0xFF, i>>1, i>>1, i>>1);
      background[2] = Col32(0xFF, 255-i, 128-(i>>1), 0);
      background[3] = Col32(0xFF, 255-i, i>>1, i);
      xDRAW::RectShA(background, 0, Coord(winW, winH));
      xDRAW::Enable(xDRAW::ALPHA_BLEND);
      {
        robot.Cell(j);
        robot.SetFilter(xTEXTURE::LINEAR);
        xDRAW::RectScTx(ambient, Coord((winW>>1)+160,(winH>>1)-160), Coord((winW>>1)-160,(winH>>1)+160), robot);
        robot.Cell(j+robot.CellsH());
        xDRAW::RectScTx(top, Coord((winW>>1)+160,(winH>>1)-160), Coord((winW>>1)-160,(winH>>1)+160), robot);
        robot.Cell(j+robot.CellsH()*2);
        xDRAW::RectScTx(bottom, Coord((winW>>1)+160,(winH>>1)-160), Coord((winW>>1)-160,(winH>>1)+160), robot);
        robot.Cell(j+robot.CellsH()*3);
        xDRAW::RectScTx(left, Coord((winW>>1)+160,(winH>>1)-160), Coord((winW>>1)-160,(winH>>1)+160), robot);
        robot.Cell(j+robot.CellsH()*4);
        xDRAW::RectScTx(right, Coord((winW>>1)+160,(winH>>1)-160), Coord((winW>>1)-160,(winH>>1)+160), robot);
      }
      robot.SetFilter(xTEXTURE::NEAREST);
      for (sint32 k=80, n=j; k <= winW; k+=80, n++)
      {
        if (n>=robot.CellsH()) n = 0;
        robot.Cell(n);
        xDRAW::RectScTx(ambient, Coord(k, winH-120), Coord(k-80, winH-40), robot);
        robot.Cell(n+robot.CellsH());
        xDRAW::RectScTx(top, Coord(k, winH-120), Coord(k-80, winH-40), robot);
        robot.Cell(n+robot.CellsH()*2);
        xDRAW::RectScTx(bottom, Coord(k, winH-120), Coord(k-80, winH-40), robot);
        robot.Cell(n+robot.CellsH()*3);
        xDRAW::RectScTx(left, Coord(k, winH-120), Coord(k-80,winH-40), robot);
        robot.Cell(n+robot.CellsH()*4);
        xDRAW::RectScTx(right, Coord(k, winH-120), Coord(k-80, winH-40), robot);
      }

      // show lighting graph
      xDRAW::Disable(xDRAW::ALPHA_BLEND);
      xDRAW::Rect(ambient,  Coord(16,4), Coord(16+GetCol32A(ambient), 12));
      xDRAW::Rect(top,      Coord(16,16),Coord(16+GetCol32A(top),     24));
      xDRAW::Rect(bottom,   Coord(16,28),Coord(16+GetCol32A(bottom),  36));
      xDRAW::Rect(left,     Coord(16,40),Coord(16+GetCol32A(left),    48));
      xDRAW::Rect(right,    Coord(16,52),Coord(16+GetCol32A(right),   60));

      SetCol32A(top, i);
      SetCol32A(bottom, 255-i);
      SetCol32A(left, i);
      SetCol32A(right, 255-i);
    }
    xDRAW::End();
    ms += t.ElapsedSet();
    win.Refresh();
    win.WaitSync();
  }
  return ms;
}

uint32 BenchmarkQuadrics(xDISPLAY& test)
{
/*
  xTIMER tmr; uint32 ms;
  sysBASELIB::MessageBox("Info", "Proceed", "Benchmark the xDRAW class\nquadric functions");

  xDRAW::Begin();
  {
    xDRAW::Clear();
    tmr.Set();
    for (sint32 i=0; i < 50; i++)
      xDRAW::Circle(0xFF0000FF, Coord(256,256), 240);
    ms = tmr.ElapsedSet();
  }
  xDRAW::End();
  test.Refresh();
  sysBASELIB::MessageBox("Info", "Go on", "xDRAW::Circle()\nTook %f ms", (float64)ms/50);

  xDRAW::Begin();
  {
    xDRAW::Clear();
    tmr.Set();
    for (sint32 i=0; i < 50; i++)
      xDRAW::CircleShC(fill1, Coord(256,256), 240);
    ms = tmr.ElapsedSet();
  }
  xDRAW::End();
  test.Refresh();
  sysBASELIB::MessageBox("Info", "Go on", "xDRAW::CircleShC()\nTook %f ms", (float64)ms/50);

  xDRAW::Begin();
  {
    xDRAW::Clear();
    tmr.Set();
    for (sint32 i=0; i < 50; i++)
      xDRAW::CircleShPt(fill1, Coord(256,256), Coord(-40,-40), 240);
    ms = tmr.ElapsedSet();
  }
  xDRAW::End();
  test.Refresh();
  sysBASELIB::MessageBox("Info", "Go on", "xDRAW::CircleShPt()\nTook %f ms", (float64)ms/50);

  xDRAW::Begin();
  {
    xDRAW::Clear();
    tmr.Set();
    for (sint32 i=0; i < 50; i++)
      xDRAW::Elipse(0xFFFF0000, Coord(256,256), Coord(256,128));
    ms = tmr.ElapsedSet();
  }
  xDRAW::End();
  test.Refresh();
  sysBASELIB::MessageBox("Info", "Go on", "xDRAW::Elipse()\nTook %f ms", (float64)ms/50);

  xDRAW::Begin();
  {
    xDRAW::Clear();
    tmr.Set();
    for (sint32 i=0; i < 50; i++)
      xDRAW::ElipseShC(fill2, Coord(256,256), Coord(256,128));
  }
  xDRAW::End();
  test.Refresh();
  sysBASELIB::MessageBox("Info", "Go on", "xDRAW::ElipseShC()\nTook %f ms", (float64)ms/50);

  xDRAW::Begin();
  {
    xDRAW::Clear();
    tmr.Set();
    for (sint32 i=0; i < 50; i++)
      xDRAW::ElipseShPt(fill2, Coord(256,256), Coord(-64,-32), Coord(256,128));
  }
  xDRAW::End();
  test.Refresh();
  sysBASELIB::MessageBox("Info", "Go on", "xDRAW::ElipseShPt()\nTook %f ms", (float64)ms/50);
*/
  return 0;
}
