//****************************************************************************//
//** File:         DrawListGPU.cpp ($NAME=DrawListGPU.cpp)                  **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is for AmigaOS 68K systems                     **//
//** Library:      xGraphics                                                **//
//** Created:      2001-12-10                                               **//
//** Updated:      2002-02-01                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):      Implemenation for VGPU class                             **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#include <xSystem/GraphicsLib.hpp>

#ifdef X_VERBOSE
char*       VGPU::opcodes[]   = {
  "noop      ",
  "done      ",
  "rsrv data ",
  "clip area ",
  "clr rgb   ",
  "clr zbf   ",
  "points    ",
  "lines     ",
  "linestrip ",
  "tris      ",
  "trifan    ",
  "tristrip  ",
  "ostext    ",
  "blt bm2ds ",
  "blt ds2bm ",
  "set blndfn",
  "set fogdat",
  "set rgbmsk",
  "set col   ",
  "set tex   ",
  "set lop   ",
  "set fogmd ",
  "set zcmp  ",
  "set acmp  ",
  "enbl st   ",
  "dsbl st   ",
  "lock mode ",
  "push dvs  ",
  "pop dvs   ",
  "abort     ",
  "breakpt   ",
  "jsr       ",
  "ret       ",
  "<illegal> ",
  0
};
#endif

VGPU::DVSTACKDATA VGPU::stack[DVSTACK_DEPTH]  = {0};
sint32            VGPU::stackPos              = 0;
DVERTEX*          VGPU::vertexBase            = 0;
DVERTEX*          VGPU::vertexTop             = 0;
sint32            VGPU::dataPos               = 0;
sint32            VGPU::instPos               = 0;
uint32            VGPU::exe_flags             = 0;
uint32            VGPU::exe_errReg            = ERR_NONE;
uint32            VGPU::exe_stateReg          = 0;
uint32            VGPU::exe_colourReg         = 0;
sysTEXTURE*       VGPU::exe_texReg            = 0;
uint32            VGPU::exe_fogReg            = 0;

// Opcode Function table
GPUCODE     VGPU::funcTab[MAX_OPCODE] = {
  _DrawDummy,
  _DrawDummy,
  _Skip,
  _Clip,
  _ClearRGB,
  _ClearDepth,
  _DrawPoints,
  _DrawLines,
  _DrawLineStrip,
  _DrawTris,
  _DrawTrifan,
  _DrawTriStrip,
  _DrawOSText,
  _Blit,
  _Blit2,
  _BlendMode,
  _FogParms,
  _ColourMask,
  _SetColour,
  _SetTexture,
  _SetLogic,
  _SetFogMode,
  _SetZCompare,
  _SetACompare,
  _Enable,
  _Disable,
  _Lock,
  _PushDVS,
  _PopDVS,
  _Abort,
  _BreakPoint,
  _DrawDummy,
  _DrawDummy
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 VGPU::ExecuteBuffer(bool initRegs, DCOMMAND* insts, DVERTEX* vData, sint32 num, sint32 dcnt)
{
  if (!x3D::Context() || !insts || !vData || num <= 0 || dcnt <= 0)
  {
    #ifdef X_VERBOSE
    cout << "VGPU::ExecuteBuffer() : Illegal args\n";
    #endif
    return ERR_VALUE;
  }
/*
  if (initRegs)
  {
    stackPos      = 0;
    exe_stateReg  = 0;
    exe_colourReg = 0;
    exe_texReg    = 0;
    W3D_SetState(context, W3D_GOURAUD, W3D_DISABLE);
    W3D_SetState(context, W3D_TEXMAPPING, W3D_DISABLE);
    W3D_SetState(context, W3D_BLENDING, W3D_DISABLE);

  }
*/

  vertexBase  = vData;
  vertexTop   = vData+dcnt;
  x3D::SetVertexArray(vertexBase);
  dataPos = 0;
  instPos = 0;
  if (x3D::LockHW()==false)
  {
    #ifdef X_VERBOSE
    cout << "VGPU::ExecuteBuffer() : locking failed\n";
    #endif
    return ERR_RSC_UNAVAILABLE;
  }
  #ifdef X_DEBUG
  sint32  lastOp = 0;
  void*   lastArg = 0;
  #endif
  {
    // initialise exe registers
    exe_flags             = LOCKED;
    exe_errReg            = ERR_NONE;
    register DCOMMAND* c  = insts;
    rsint32 i             = num+1;
    while (--i && exe_errReg==ERR_NONE)
    {
      #ifdef X_DEBUG
      lastOp  = c->opcode;
      lastArg = c->arg;
      #endif
      funcTab[c->opcode](c->arg); c++; instPos++;
    }
    x3D::FlushFrame();
  }
  x3D::UnLockHW();

  // Error trap code
  #ifdef X_DEBUG
  if (exe_errReg)
  {
    switch(exe_errReg)
    {
      #ifdef X_VERBOSE
      case ERR_LOCK:
        sysBASELIB::MessageBox("Debug Info","Proceed","VGPU : %s %0X\nLocking failed\n\n" \
                    "stateReg : %0X\ncolourReg : %0X\ntexReg : %p",             \
                    opcodes[lastOp], lastArg, exe_stateReg, exe_colourReg, exe_texReg);
        break;

      case ERR_DRAW:
        sysBASELIB::MessageBox("Debug Info","Proceed","VGPU : %s %0X\nDraw failed\n\n"  \
                    "stateReg : %0X\ncolourReg : %0X\ntexReg : %p",         \
                    opcodes[lastOp], lastArg, exe_stateReg, exe_colourReg, exe_texReg);
        break;

      case ERR_STACK_OVER:
        sysBASELIB::MessageBox("Debug Info","Proceed","VGPU : %s %0X\nStack overflow\n\n" \
                    "stateReg : %0X\ncolourReg : %0X\ntexReg : %p",     \
                    opcodes[lastOp], lastArg, exe_stateReg, exe_colourReg, exe_texReg);
        break;

      case ERR_STACK_UNDER:
        sysBASELIB::MessageBox("Debug Info","Proceed","VGPU : %s %0X\nStack underflow\n\n"  \
                    "stateReg : %0X\ncolourReg : %0X\ntexReg : %p",               \
                    opcodes[lastOp], lastArg, exe_stateReg, exe_colourReg, exe_texReg);

      default:
        sysBASELIB::MessageBox("Debug Info","Proceed","VGPU : %s %0X\nUndiagnosed error %d\n\n" \
                    "stateReg : %0X\ncolourReg : %0X\ntexReg : %p",               \
                    opcodes[lastOp], lastArg, exe_errReg, exe_stateReg, exe_colourReg, exe_texReg);
      #else

      case ERR_LOCK:        sysBASELIB::MessageBox("Debug Info","Proceed","VGPU : Locking failed"); break;
      case ERR_DRAW:        sysBASELIB::MessageBox("Debug Info","Proceed","VGPU : Draw failed");  break;
      case ERR_STACK_OVER:  sysBASELIB::MessageBox("Debug Info","Proceed","VGPU : Stack overflow"); break;
      case ERR_STACK_UNDER: sysBASELIB::MessageBox("Debug Info","Proceed","VGPU : Stack underflow"); break;
      default:              sysBASELIB::MessageBox("Debug Info","Proceed","VGPU : Undiagnosed error");

      #endif
    }
  }
  #endif
  return exe_errReg == ERR_NONE ? OK : ERR_RSC_UNAVAILABLE;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_DrawDummy(REGP(0) void* arg)
{
//  cout << "_DrawDummy() got inst : " << data << "\n";
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_Skip(REGP(0) void* arg)
{
  ruint32 num = (uint32)arg;
  dataPos+=num;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_Clip(REGP(0) void* arg)
{
  register DVERTEX* v = vertexBase+dataPos;
  x3D::SetDrawArea(v->x1, v->y1, v->x2, v->y2);
  dataPos++;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_ClearRGB(REGP(0) void* arg)
{
  exe_errReg = (x3D::Clear((uint32)arg) ? 0 : ERR_DRAW);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_ClearDepth(REGP(0) void* arg)
{
  float64 d = ((float32)arg);
  exe_errReg = (x3D::ClearZBuffer(d) ? 0 : ERR_DRAW);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_DrawPoints(REGP(0) void* arg)
{
  uint32 cnt = (uint32)arg;
  exe_errReg = (x3D::DrawPoints(dataPos, cnt) ? 0 : ERR_DRAW);
  dataPos+=cnt;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_DrawLines(REGP(0) void* arg)
{
  uint32 cnt = (uint32)arg;
  exe_errReg = (x3D::DrawLines(dataPos, cnt) ? 0 : ERR_DRAW);
  dataPos+=cnt;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_DrawLineStrip(REGP(0) void* arg)
{
  uint32 cnt = (uint32)arg;
  exe_errReg = (x3D::DrawLineStrip(dataPos, cnt) ? 0 : ERR_DRAW);
  dataPos+=cnt;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_DrawTris(REGP(0) void* arg)
{
  uint32 cnt = (uint32)arg;
  exe_errReg = (x3D::DrawTris(dataPos, cnt) ? 0 : ERR_DRAW);
  dataPos+=cnt;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_DrawTrifan(REGP(0) void* arg)
{
  uint32 cnt = (uint32)arg;
  exe_errReg = (x3D::DrawTriFan(dataPos, cnt) ? 0 : ERR_DRAW);
  dataPos+=cnt;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_DrawTriStrip(REGP(0) void* arg)
{
  uint32 cnt = (uint32)arg;
  exe_errReg = (x3D::DrawTriStrip(dataPos, cnt) ? 0 : ERR_DRAW);
  dataPos+=cnt;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_DrawOSText(REGP(0) void* arg)
{
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_Blit(REGP(0) void* arg)
{
  register DVERTEX* v = vertexBase+dataPos;
  x2D::BlitDirect((sysSURFACE*)arg, x3D::DrawSurface()->Handle(), v->x1, v->y1, v->x2, v->y2, v->x3, v->y3);
  dataPos++;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_Blit2(REGP(0) void* arg)
{
  register DVERTEX* v = vertexBase+dataPos;
  x2D::BlitDirect(x3D::DrawSurface()->Handle(), (sysSURFACE*)arg, v->x2, v->x1, v->y1, v->y2, v->x3, v->y3);
  dataPos++;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_BlendMode(REGP(0) void* arg)
{
  ruint32 fac = (uint32)arg;
  x3D::SetBlendMode((BFUNC)(fac>>16), (BFUNC)(fac&0x0000FFFF));
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_FogParms(REGP(0) void* arg)
{
  register DVERTEX* v = vertexBase+dataPos;
  exe_errReg = (x3D::SetFogProperties((FMODE)arg, v->data1, v->fy1, v->fx2, v->fx2) ? 0 : ERR_UNDEF);
  dataPos++;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_ColourMask(REGP(0) void* arg)
{
  ruint32 c = (uint32)arg;
  exe_errReg = (x3D::SetMaskARGB(c) ? 0 : ERR_UNDEF);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_SetColour(REGP(0) void* arg)
{
  ruint32 clr = (uint32)arg;
  exe_colourReg = clr;
  exe_errReg = (x3D::SetColour(clr) ? 0 : ERR_UNDEF);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_SetTexture(REGP(0) void* arg)
{
  exe_texReg = (sysTEXTURE*)arg;
  x3D::SetTexture((sysTEXTURE*)arg);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_SetLogic(REGP(0) void* arg)
{
  x3D::SetLogicOperation((LMODE)arg);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_SetFogMode(REGP(0) void* arg)
{
  exe_errReg = (x3D::SetFogMode((FMODE)arg) ? 0 : ERR_UNDEF);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_SetZCompare(REGP(0) void* arg)
{
  exe_errReg = (x3D::SetZCompare((ZMODE)arg) ? 0 : ERR_UNDEF);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_SetACompare(REGP(0) void* arg)
{
  register DVERTEX* v = vertexBase+dataPos;
  exe_errReg = (x3D::SetAlphaCompare(AMODE(v->data1), v->fy1) ? 0 : ERR_UNDEF);
  dataPos++;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_Enable(REGP(0) void* arg)
{
  ruint32 state = (uint32)arg;
  exe_stateReg |= state;
  exe_errReg = (x3D::Enable((STATE)state) ? 0 : ERR_UNDEF);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_Disable(REGP(0) void* arg)
{
  ruint32 state = (uint32)arg;
  exe_stateReg &= ~state;
  exe_errReg = (x3D::Disable((STATE)state) ? 0 : ERR_UNDEF);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_Lock(REGP(0) void* arg)
{
  if (((uint32)arg)==LOCKED)
  {
    if (x3D::LockHW())
      exe_flags |= LOCKED;
    else
    {
      exe_errReg = ERR_LOCK;
      exe_flags &= ~LOCKED;
    }
  }
  else
  {
    exe_flags &= ~LOCKED;
    x3D::UnLockHW();
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_PushDVS(REGP(0) void* arg)
{
  if (stackPos<DVSTACK_DEPTH && arg!=0)
  {
    stack[stackPos].vertexBase    = vertexBase;
    stack[stackPos++].vertexPos   = dataPos;
    // if the address is inside the current vertex buffer we
    // just need to modify dataPos. If it's not, then we have to
    // physically change the driver vertex pointers
    register DVERTEX* v = (DVERTEX*)arg;
    if (v>vertexBase && v<vertexTop)
      dataPos = v-vertexBase;
    else
    { // set the new vertex pointer
      x3D::SetVertexArray(v);
      vertexBase = v;
      dataPos = 0;
    }
  }
  else
    exe_errReg = ERR_STACK_OVER;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_PopDVS(REGP(0) void* arg)
{
  if (stackPos>0)
  {
    // if the current vertex base same as that on stack, just set the dataPos, otherwhise we need to change the
    // driver vertex pointers
    register DVERTEX* v = stack[--stackPos].vertexBase;
    if (vertexBase != v)
    {
      x3D::SetVertexArray(v);
      vertexBase = v;
    }
    dataPos   = stack[stackPos].vertexPos;
  }
  else
    exe_errReg = ERR_STACK_UNDER;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_Abort(REGP(0) void* arg)
{
  exe_errReg = ERR_UNDEF;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void VGPU::_BreakPoint(REGP(0) void* arg)
{
  if (exe_flags & LOCKED)
    x3D::UnLockHW();
  {
    sysBASELIB::MessageBox("Debug Info","Proceed","VGPU breakpoint %d\n"            \
                    "instPos : %d\ndataPos : %d\nexe_flags %0X\nexe_stateReg : %0X\n"   \
                    "exe_colourReg : %0X\nexe_texReg : %0p\nexe_fogReg : %d",           \
                    (uint32)arg, instPos, dataPos, exe_flags, exe_stateReg, exe_colourReg, exe_texReg, exe_fogReg);
  }
  if (exe_flags & LOCKED)
    exe_errReg = (x3D::LockHW() ? 0 : ERR_LOCK);
}