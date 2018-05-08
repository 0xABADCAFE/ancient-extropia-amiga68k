/*

  Extropia System Library test code by Karlos, eXtropia Studios

*/

#include "APP.hpp"

#include <xSystem/ServiceLib.hpp>

#include <math.h>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

xDBSCREEN*  APP::testWindow = 0;
DRAWLIST    APP::draw;
xTEXFONT    APP::testFont;
char*       APP::textBuffer = 0; // lame

sint32 APP::Init()
{
  if (xBASELIB::Init()!=OK)
  {
    Done();
    return ERR_RSC_INVALID;
  }
  if (xGFX::Init()!=OK)
  {
    sysBASELIB::MessageBox("Debug Info","Proceed","Failed to Init() xGFX");
    Done();
    return ERR_RSC_UNAVAILABLE;
  }

  if (DRAW::Init()!=OK)
  {
    sysBASELIB::MessageBox("Debug Info","Proceed","Failed to Init() DRAW");
    Done();
    return ERR_RSC_INVALID;
  }
  textBuffer = (char*)MEM::Alloc(2048);
  if (!textBuffer)
  {
    sysBASELIB::MessageBox("Debug Info","Proceed","Failed to allocate textBuffer");
    Done();
    return ERR_RSC_UNAVAILABLE;
  }

  xDMODE* mode = xGFX::BestMode(640,480,16);
  if (!mode)
  {
    sysBASELIB::MessageBox("Debug Info","Proceed","Failed to allocate fullscreen");
    Done();
    return ERR_RSC_UNAVAILABLE;
  }
  testWindow = new xDBSCREEN(mode, "DRAWLIST Demo");
  if (!testWindow)
  {
    sysBASELIB::MessageBox("Debug Info","Proceed","Failed to allocate window");
    Done();
    return ERR_RSC_INVALID;
  }
  if (testWindow->Open()!=OK)
  {
    sysBASELIB::MessageBox("Debug Info","Proceed","Failed to open window");
    Done();
    return ERR_RSC_INVALID;
  }

  if (DRAW::Bind(testWindow->DrawSurface())!=OK)
  {
    sysBASELIB::MessageBox("Debug Info","Proceed","Failed to Bind() window draw surface");
    Done();
    return ERR_RSC_INVALID;
  }
  if (draw.Create(8192,1024)!=OK)
  {
    sysBASELIB::MessageBox("Debug Info","Proceed","Failed to create DRAWLIST object");
    Done();
    return ERR_RSC_INVALID;
  }
  if (testFont.LoadFixedPGM("data/chars256_13pt.pgm")!=OK)
  {
    sysBASELIB::MessageBox("Debug Info","Proceed","Failed open font data");
    Done();
    return ERR_RSC_INVALID;
  }
  else
    testFont.SetFixed(7,13,8,14,16);

  testWindow->MessageBox("Info","OK", "OK so far");
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 APP::Done()
{
  if (testWindow)
  {
    testFont.Delete();
    draw.Delete();
    DRAW::Release();
    testWindow->Close();
    delete testWindow;
    testWindow = 0;
  }
  DRAW::Done();
  xGFX::Done();

  if (textBuffer)
    MEM::Free(textBuffer);

  xBASELIB::Done();
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void APP::Demo1()
{
  xFILEIO info("app.cpp", xFILEIO::READ);
  if (info.Valid()==FALSE)
    return;
  uint32 bkgd[] = {0xFF001020, 0xFF2040C0};
  uint32 rgbw[] = {0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFFFFFFF};
  while(info.EndOfFile()==FALSE)
  {
    sint32 y = 48;
    draw.Begin();
    {
      draw.Disable(x3D::ALPHA_BLEND);
      draw.RectShV(bkgd, 0,0,640,480);
      draw.RectShV(rgbw+2, 8, 32, 632, 40);
      draw.RectShV(rgbw+2, 8, 440, 632, 448);
      {
        info.ReadText(textBuffer, 2047, '\n', 30);
        testFont.WriteText(&draw, 0xFFA0A0A0, 8, y, textBuffer);
      }
    }
    draw.End();
    testWindow->Refresh();
    DRAW::Swap(testWindow->DrawSurface());
    testWindow->MessageBox("Demo","OK","Proceed");
  }
  info.Close();
}

void APP::Demo2()
{
  // This demonstrates using the low level drawing interface. Here we directly manipulate vertices
  // in the drawlist itself. We use GetVertices() to request space and then set the vertex data
  // ourselves. We only need to keep the pointer returned if we dont intend to use the vertices
  // immediately with a suitable low level operation.
  uint32 bkgd[] = {0xFF001020, 0xFF2040C0};
  uint32 rgbw[] = {0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFFFFFFF};
  {
    draw.Begin();
    {
      // draw background
      draw.Disable(x3D::ALPHA_BLEND);
      draw.RectShV(bkgd, 0,0,640,480);
      draw.RectShV(rgbw+2, 8, 32, 632, 40);
      draw.RectShV(rgbw+2, 8, 440, 632, 448);
      // Allocate 66 volatile vertices to use immediately.
      // This is sufficient to create a 64 segment triangle fan, allowing a very regular circle
      {
        register DVERTEX* v = draw.GetVertices(66);
        // the centre vertex is pure white
        v->x = 320;
        v->y = 240;
        v->z = 0;
        (v++)->colour = 0xFFFFFFFF;
        for (rsint32 i=0; i < 65; i++)
        { // calculate the rim vertices
          rfloat32 ang  = i*(2*PI/64F);
          v->x          = 320 + 128*sin(ang);
          v->y          = 240 + 128*cos(ang);
          v->z          = 0;
          // The colour channels are seperated by 2PI/3 (120 degrees).
          ruint32 rgb   = 0xFF000000;
          rgb          |= 128UL-(uint32)(127F*cos(ang))<<16;          // red
          rgb          |= 128UL-(uint32)(127F*cos(ang+(2*PI/3)))<<8;  // green
          rgb          |= 128UL-(uint32)(127F*cos(ang+(4*PI/3)));     // blue
          (v++)->colour = rgb;
        }
        draw.Enable(x3D::GOURAUD); // make sure vertex shading is enabled
        draw.TriFan(66);
      }
      testFont.WriteText(&draw, 0xFFFFFFFF, 8, 8, "Low level drawing demo");
      testFont.WriteText(&draw, 0xFF808080, 8, 48, "A colourwheel rendered by using GetVertices() and TriFan()");
    }
    draw.End();
    testWindow->Refresh();
    DRAW::Swap(testWindow->DrawSurface());
  }
  testWindow->MessageBox("Demo","OK","Bugger me");
}

void APP::Demo3()
{
  uint32 bkgd[] = {0xFFFF0000, 0xFF0000FF, 0x3FFFFFFF, 0x3F2050FF, 0x3FFFFFFF, 0x3FFF0040};
  uint32 rgb[] = {0xFFFF0000, 0xFF00FF00, 0xFF0000FF};
  xTEXSURF myTex;
  myTex.LoadPPM("data/tex3.ppm", 0xFFFFFFFF);
  myTex.SetFilter(xTEXSURF::LINEAR);
  myTex.SetEnv(xTEXSURF::MODULATE);
  {
    // Make sure that all textures etc are uploaded
    draw.Begin();
    {
      draw.Disable(x3D::ALPHA_BLEND);
      draw.RectShV(bkgd, 0, 0, 640, 480);
      for (sint16 y=0; y<480; y+=64)
        for (sint16 x=0; x<640; x+=64)
          if ( (x^y)&64 )
            draw.RectShH(bkgd, x+8, y+8, x+56, y+56);
          else
            draw.RectShV(bkgd+1, x+8, y+8, x+56, y+56);
      draw.Enable(x3D::ALPHA_BLEND);
      draw.RectTlTxShH(rgb, 64, 70, 320, 412, &myTex, 0, 0, -256F/192F, 256F/192F);
      draw.RectTlTxShH(rgb+1, 320, 70, 576, 412, &myTex, 64, 0, -256F/192F, 256/192F);
      testFont.WriteText(&draw, 0xFFFFFFFF, 8, 456, "Another silly example :)");
    }
    draw.End();
    testWindow->Refresh();
    DRAW::Swap(testWindow->DrawSurface());
  }
  testWindow->MessageBox("Info","OK", "Textures resident\nContinue");

  sint32 totC=0;
  sint32 totD=0;
  sint32 totS=0;
  sint32 totW=0;
  {
    MILLICLOCK t;
    for (sint32 i=0; i<255; i++)
    {
      t.Set();
      draw.Begin();
      {
        draw.Disable(x3D::ALPHA_BLEND);
        draw.RectShV(bkgd, 0, 0, 640, 480);
        for (sint16 y=0; y<480; y+=64)
          for (sint16 x=0; x<640; x+=64)
            if ( (x^y)&64 )
              draw.RectShH(bkgd, x+8, y+8, x+56, y+56);
            else
              draw.RectShV(bkgd+1, x+8, y+8, x+56, y+56);
        draw.Enable(x3D::ALPHA_BLEND);
        draw.RectTlTxShH(rgb, 64, 70, 320, 412, &myTex, 2*i, 0, -256F/192F, 256F/192F);
        draw.RectTlTxShH(rgb+1, 320, 70, 576, 412, &myTex, 64+2*i, 0, -256F/192F, 256/192F);
        testFont.WriteText(&draw, 0xFFFFFFFF, 8, 456, "Another silly example :)");
      }
      totC+=t.Elapsed();
      t.Set();
      draw.End();
      totD+=t.Elapsed();
      t.Set();
      testWindow->Refresh();
      DRAW::Swap(testWindow->DrawSurface());
      totS+=t.Elapsed();
      t.Set();
      testWindow->WaitSync();
      totW+=t.Elapsed();
    }
  }
  myTex.Delete();
  testWindow->MessageBox("Demo Information","OK",
                         "List construction : %f ms\n"
                         "Buffer execution  : %f ms\n"
                         "Refresh time      : %f ms\n"
                         "Sync waiting time : %f ms",
                         (float64)totC/256.0, (float64)totD/256.0, (float64)totS/256.0, (float64)totW/256.0 );
}