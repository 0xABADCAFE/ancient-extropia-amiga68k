//****************************************************************************//
//** File:         DrawListMethods.cpp ($NAME=DrawListMethods.cpp)          **//
//** Description:  eXtropia System Toolkit                                  **//
//** Comment(s):   This file is for AmigaOS 68K systems                     **//
//** Library:      xGraphics                                                **//
//** Created:      2001-12-10                                               **//
//** Updated:      2002-02-01                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):      Implemenation for DRAWLIST buffered operations           **//
//** Copyright:    (C)1996-2002, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//

#include <xSystem/GraphicsLib.hpp>

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Low level interface
//
//  Drawing funcs don't check for vertex array overflow, primarily because they may be operating on areas external to the main
//  drawlist buffer
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DVERTEX* DRAWLIST::GetVertices(sint32 n, bool immediate)
{
  if (n<=0 || n>=vBufSize || (flags & MAKELIST)==0)
    return 0;

  if (vertsUsed+n > vBufSize || instsUsed+1 > iBufSize)
    Flush();
  DVERTEX* v = currVert;
  // Immediate mode means the next drawing func is using these vertices so we don't increment the vertex pointer here. Leave it
  // to the drawing operation to do it.
  // Otherwise we must use SetVertices() to use this allocation later.
  if (!immediate)
  {
    commandReg = currInst->opcode = RSRVD; (currInst++)->numVerts = n;
    currVert+=n;
    vertsUsed+=n;
    instsUsed++;
  }
  return v;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWLIST::SetVertices(DVERTEX* v) // sets the current vertex base pointer
{
  if (instsUsed+1 > iBufSize)
    Flush();
  commandReg = currInst->opcode = PUSH_DVS; (currInst++)->vertBase = v;
  instsUsed++;
  return OK;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWLIST::RestoreVertices() // restores the previous vertex base pointer
{
  if (instsUsed+1 > iBufSize)
    Flush();
  commandReg = currInst->opcode = POP_DVS;
  instsUsed++;
  return OK;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Lines(sint32 n)
{
  if (commandReg==DRW_LINES)    (currInst-1)->numVerts += n;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_LINES; (currInst++)->numVerts = n;
    instsUsed++;
  }
  currVert += n;
  vertsUsed += n;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::LineStrip(sint32 n)
{
  LockMode(LOCKED);
  commandReg = currInst->opcode = DRW_LINESTRIP; (currInst++)->numVerts = n;
  instsUsed++;
  currVert += n;
  vertsUsed += n;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Tris(sint32 n)
{
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += n;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = n;
    instsUsed++;
  }
  currVert += n;
  vertsUsed += n;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::TriStrip(sint32 n)
{
  LockMode(LOCKED);
  commandReg = currInst->opcode = DRW_TRISTRIP; (currInst++)->numVerts = n;
  instsUsed++;
  currVert += n;
  vertsUsed += n;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::TriFan(sint32 n)
{
  LockMode(LOCKED);
  commandReg = currInst->opcode = DRW_TRIFAN; (currInst++)->numVerts = n;
  instsUsed++;
  currVert += n;
  vertsUsed += n;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  High level interface
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWLIST::Flush()
{
  if (currFlushCnt++ == 0 && instsUsed)
    VGPU::ExecuteBuffer(true, instBuf, vertBuf, instsUsed, vBufSize);
  else if (instsUsed)
    VGPU::ExecuteBuffer(false, instBuf, vertBuf, instsUsed, vBufSize); // caused by buffer overflow. Not good!
  //Dump(cout,false);
  vertsUsed = 0;
  instsUsed = 0;
  currVert = vertBuf;
  currInst = instBuf;
  commandReg = NOOP;
  return OK;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWLIST::Begin()
{
  if (nestCount++ == 0)
  {
    breakCnt = 0;
    if (flags & MAKELIST) return ERR_VALUE;
    flags |= MAKELIST|LOCKED;
    instsUsed = 0;
    vertsUsed = 0;
    currVert = vertBuf;
    currInst = instBuf;
  }
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////

sint32 DRAWLIST::End()
{
  if (!nestCount)
    return ERR_RSC;
  if (--nestCount == 0)
  {
    if (flags & MAKELIST==0) return ERR_VALUE;
    flags &= ~(MAKELIST|LOCKED);
    Flush();
    currFlushCnt = 0;
    currVert = vertBuf;
  }
  return OK;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Enable(x3D::STATE s)
{
  if (stateReg & s)           return;
  if (instsUsed+1 > iBufSize) Flush();
  commandReg = currInst->opcode = ENABLE_STATE; (currInst++)->state = s;
  stateReg |= s;
  instsUsed++;
}

/////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Disable(x3D::STATE s)
{
  if ((stateReg&s)==0)      return;
  if (instsUsed+1 > iBufSize) Flush();
  commandReg = currInst->opcode = DISABLE_STATE; (currInst++)->state = s;
  stateReg &= ~s;
  instsUsed++;
}

/////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::SetColour(uint32 colour)
{
  if (colourReg==colour)      return;
  if (commandReg==SET_COLOUR) (currInst-1)->colour = colour;
  else
  {
    if (instsUsed+1 > iBufSize) Flush();
    commandReg = currInst->opcode = SET_COLOUR; colourReg = (currInst++)->colour = colour;
    instsUsed++;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::SetTexture(xTEXSURF* t)
{
  sysTEXTURE* tData = t->Handle();
  if (texReg==tData)
    return;
  if (commandReg==SET_TEXTURE)  (currInst-1)->texture = tData;
  else
  {
    if (instsUsed+1 > iBufSize) Flush();
    commandReg = currInst->opcode = SET_TEXTURE; texReg = (currInst++)->texture = tData;
    instsUsed++;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Clear(uint32 colour)
{
  if (commandReg==CLEAR_RGB)
    (currInst-1)->colour = colour;
  else
  {
    if (instsUsed+2 > iBufSize)
      Flush();
    LockMode(LOCKED);
    commandReg = currInst->opcode = CLEAR_RGB; (currInst++)->colour = colour;
    instsUsed++;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::ClearDepth(float32 z)
{
  if (commandReg==CLEAR_DEPTH)
    (currInst-1)->depth = z;
  else
  {
    if (instsUsed+2 > iBufSize)
      Flush();
    LockMode(LOCKED);
    commandReg = currInst->opcode = CLEAR_DEPTH; (currInst++)->depth = z;
    instsUsed++;
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Blit(xSURFACE* s, S_3CRD)
{
  if (s->Handle()==0)
    return;
  if (vertsUsed+1 > vBufSize || instsUsed+2 > iBufSize)
    Flush();
  LockMode(UNLOCKED);
  commandReg =  currInst->opcode    = BLIT;
  (currInst++)->surf  = s->Handle();
  register DVERTEX* v = currVert++;
  v->x1 = x1; v->y1 = y1;
  v->x2 = x2; v->y2 = y2;
  v->x3 = x3, v->y3 = y3;
  instsUsed++;
  vertsUsed++;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Clip(S_2CRD)
{
  // clip always loads the source rect registers even if unchanged by another op. This is because optimization may need to change the
  // whole clip rectangle
  if (vertsUsed+1 > vBufSize || instsUsed+1 > iBufSize)
    Flush();
  commandReg = (currInst++)->opcode   = CLIP;
  register DVERTEX* v = currVert++;
  v->x1 = x1; v->y1 = y1;
  v->x2 = x2-x1; v->y2 = y2-x1;
  instsUsed++;
  vertsUsed++;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::FogParms(uint32 colour, float32 start, float32 end, float32 density, x3D::FMODE fmode)
{
  if (commandReg == FOGPARMS)
  {
    // modify previous data
    register DVERTEX* v = (currVert-1);
    v->data1 = colour; v->fy1 = start; v->fx2 = end; v->fy2 = density;
    (currInst-1)->data = fmode;
  }
  else
  {
    if (vertsUsed+1 > vBufSize || instsUsed+2 > iBufSize)
      Flush();
    LockMode(LOCKED);
    commandReg =  currInst->opcode  = FOGPARMS;
    (currInst++)->data  = fmode;
    register DVERTEX* v = currVert++;
    v->data1 = colour; v->fy1 = start; v->fx2 = end; v->fy2 = density;
    instsUsed++;
    vertsUsed++;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::BlendMode(x3D::BFUNC sfac, x3D::BFUNC dfac)
{
  if (commandReg == BLENDPARMS)
  {
    (currInst-1)->data = ((sfac<<16) | (dfac));
  }
  else
  {
    if (instsUsed+1 > iBufSize)
      Flush();
    commandReg =  currInst->opcode  = BLENDPARMS;
    (currInst++)->data = ((sfac<<16) | (dfac));
    instsUsed++;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::AlphaCompareMode(x3D::AMODE amode, float32 ref)
{
  alphaReg = ref;
  if (commandReg==SET_AMODE)
  {
    (currVert-1)->data1 = amode;
    (currVert-1)->fy1   = ref;
  }
  else
  {
    if (vertsUsed+1 > vBufSize || instsUsed+1 > iBufSize) Flush();
    commandReg = (currInst++)->opcode = SET_AMODE;
    currVert->data1   = amode;
    (currVert++)->fy1 = ref;
    instsUsed++;
    vertsUsed++;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::LogicMode(x3D::LMODE lmode)
{
  if (logicReg==lmode)        return;
  if (commandReg==SET_LOGIC)  (currInst-1)->data = lmode;
  else
  {
    if (instsUsed+1 > iBufSize) Flush();
    commandReg = currInst->opcode = SET_LOGIC; logicReg = lmode; (currInst++)->data = lmode;
    instsUsed++;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::DepthCompareMode(x3D::ZMODE zmode)
{
  if (zTestReg==zmode)        return;
  if (commandReg==SET_ZMODE)  (currInst-1)->data = zmode;
  else
  {
    if (instsUsed+1 > iBufSize) Flush();
    commandReg = currInst->opcode = SET_ZMODE; zTestReg = zmode; (currInst++)->data = zmode;
    instsUsed++;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::FogMode(x3D::FMODE fmode)
{
  if (fogReg==fmode)        return;
  if (commandReg==SET_FOG)  (currInst-1)->data = fmode;
  else
  {
    if (instsUsed+2 > iBufSize) Flush();
    LockMode(LOCKED);
    commandReg = currInst->opcode = SET_FOG; fogReg = fmode; (currInst++)->data = fmode;
    instsUsed++;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef X_DEBUG
void DRAWLIST::XDebug_BreakPoint()
{
  if (commandReg==BREAKPT)  return;
  else
  {
    if (instsUsed+1 > iBufSize) Flush();
    commandReg = currInst->opcode = BREAKPT; (currInst++)->data = breakCnt++;
    instsUsed++;
  }
}
#endif


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Lines
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Line(uint32 colour, S_2CRD)
{
  if (vertsUsed+2 > vBufSize || instsUsed+5 > iBufSize)
    Flush();
  Disable(TEXTURE);
  Disable(GOURAUD);
  SetColour(colour);
  if (commandReg==DRW_LINES)    (currInst-1)->numVerts += 2;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_LINES; (currInst++)->numVerts = 2;
    instsUsed++;
  }
  {
    // set up two vertices for line
    register DVERTEX* v = currVert;
    v->x = x1;  v->y = y1;  (v++)->z = depthReg;
    v->x = x2;  v->y = y2;  (v++)->z = depthReg;
    currVert = v;
    vertsUsed+=2;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::LineShA(uint32* colour, S_2CRD)
{
  if (vertsUsed+2 > vBufSize || instsUsed+4 > iBufSize)
    Flush();
  Disable(TEXTURE);
  Enable(GOURAUD);
  if (commandReg==DRW_LINES)    (currInst-1)->numVerts += 2;
  else
  {
    LockMode(LOCKED);
    currInst->opcode = commandReg = DRW_LINES; (currInst++)->numVerts = 2;
    instsUsed++;
  }
  {
    // set up two vertices for line
    register DVERTEX* v = currVert;
    v->x = x1;  v->y = y1;  v->z = depthReg;  (v++)->colour = *(colour++);
    v->x = x2;  v->y = y2;  v->z = depthReg;  (v++)->colour = *colour;
    currVert = v;
    vertsUsed+=2;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Triangles
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Tri(uint32 colour, S_3CRD)
{
  if (vertsUsed+3 > vBufSize || instsUsed+5 > iBufSize)
    Flush();
  Disable(TEXTURE);
  Disable(GOURAUD);
  SetColour(colour);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 3;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 3;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    register DVERTEX* v = currVert;
    v->x = x1;  v->y = y1;  (v++)->z = depthReg;
    v->x = x2;  v->y = y2;  (v++)->z = depthReg;
    v->x = x3;  v->y = y3;  (v++)->z = depthReg;
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::TriShA(uint32* colour, S_3CRD)
{
  if (vertsUsed+3 > vBufSize || instsUsed+4 > iBufSize)
    Flush();
  Disable(TEXTURE);
  Enable(GOURAUD);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 3;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 3;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    register DVERTEX* v = currVert;
    v->x = x1;  v->y = y1;  v->z = depthReg;  (v++)->colour = *(colour++);
    v->x = x2;  v->y = y2;  v->z = depthReg;  (v++)->colour = *(colour++);
    v->x = x3;  v->y = y3;  v->z = depthReg;  (v++)->colour = *colour;
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Rectangles
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Rect(uint32 colour, S_2CRD)
{
  if (vertsUsed+6 > vBufSize || instsUsed+5 > iBufSize)
    Flush();
  Disable(TEXTURE);
  Disable(GOURAUD);
  SetColour(colour);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 6;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 6;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    register DVERTEX* v = currVert;
    rfloat32 depth = depthReg;
    v->x = x1;  v->y = y1;  (v++)->z = depth;
    v->x = x2;  v->y = y1;  (v++)->z = depth;
    v->x = x1;  v->y = y2;  (v++)->z = depth;
    v->x = x2;  v->y = y1;  (v++)->z = depth;
    v->x = x2;  v->y = y2;  (v++)->z = depth;
    v->x = x1;  v->y = y2;  (v++)->z = depth;
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::RectShH(uint32* colour, S_2CRD)
{
  #ifdef STATE_FIX
  if (flags & ENFORCESTATE)
  {
    Tri(0, x1,y1, x1,y1, x1,y1);
    flags &= ~ENFORCESTATE;
  }
  #endif
  if (vertsUsed+6 > vBufSize || instsUsed+4 > iBufSize)
    Flush();
  Disable(TEXTURE);
  Enable(GOURAUD);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 6;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 6;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    register DVERTEX* v = currVert;
    rfloat32 depth = depthReg;
    v->x = x1;  v->y = y1;  v->z = depth; (v++)->colour = colour[0];
    v->x = x2;  v->y = y1;  v->z = depth; (v++)->colour = colour[1];
    v->x = x1;  v->y = y2;  v->z = depth; (v++)->colour = colour[0];
    v->x = x2;  v->y = y1;  v->z = depth; (v++)->colour = colour[1];
    v->x = x2;  v->y = y2;  v->z = depth; (v++)->colour = colour[1];
    v->x = x1;  v->y = y2;  v->z = depth; (v++)->colour = colour[0];
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::RectShV(uint32* colour, S_2CRD)
{
  #ifdef STATE_FIX
  if (flags & ENFORCESTATE)
  {
    Tri(0, x1,y1, x1,y1, x1,y1);
    flags &= ~ENFORCESTATE;
  }
  #endif
  if (vertsUsed+6 > vBufSize || instsUsed+4 > iBufSize)
    Flush();
  Disable(TEXTURE);
  Enable(GOURAUD);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 6;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 6;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    register DVERTEX* v = currVert;
    rfloat32 depth = depthReg;
    v->x = x1;  v->y = y1;  v->z = depth; (v++)->colour = colour[0];
    v->x = x2;  v->y = y1;  v->z = depth; (v++)->colour = colour[0];
    v->x = x1;  v->y = y2;  v->z = depth; (v++)->colour = colour[1];
    v->x = x2;  v->y = y1;  v->z = depth; (v++)->colour = colour[0];
    v->x = x2;  v->y = y2;  v->z = depth; (v++)->colour = colour[1];
    v->x = x1;  v->y = y2;  v->z = depth; (v++)->colour = colour[1];
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::RectShA(uint32* colour, S_2CRD)
{
  #ifdef STATE_FIX
  if (flags & ENFORCESTATE)
  {
    Tri(0, x1,y1, x1,y1, x1,y1);
    flags &= ~ENFORCESTATE;
  }
  #endif
  if (vertsUsed+6 > vBufSize || instsUsed+4 > iBufSize)
    Flush();
  Disable(TEXTURE);
  Enable(GOURAUD);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 6;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 6;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    register DVERTEX* v = currVert;
    rfloat32 depth = depthReg;
    v->x = x1;  v->y = y1;  v->z = depth; (v++)->colour = colour[0];
    v->x = x2;  v->y = y1;  v->z = depth; (v++)->colour = colour[1];
    v->x = x1;  v->y = y2;  v->z = depth; (v++)->colour = colour[2];
    v->x = x2;  v->y = y1;  v->z = depth; (v++)->colour = colour[1];
    v->x = x2;  v->y = y2;  v->z = depth; (v++)->colour = colour[3];
    v->x = x1;  v->y = y2;  v->z = depth; (v++)->colour = colour[2];
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::RectTlTx(uint32 colour, S_2CRD, TEXARG)
{ // xTEXSURF& t, sint16 tOfsX, sint16 tOfsY, float32 tSclX, float32 tSclY
  if (vertsUsed+6 > vBufSize || instsUsed+6 > iBufSize)
    Flush();
  Enable(TEXTURE);
  Enable(GOURAUD); // Tex env doesnt like flat shading here
  SetColour(colour);
  SetTexture(t);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 6;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 6;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    rfloat32 tu = ((x2-x1)/tSclX)+tOfsX;
    rfloat32 tv = ((y2-y1)/tSclY)+tOfsY;
    register DVERTEX* v = currVert;
    rfloat32 depth = depthReg;
    v->x = x1;  v->y = y1;  v->z = depth; v->colour = colour; v->u = tOfsX; (v++)->v = tOfsY;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour; v->u = tu;    (v++)->v = tOfsY;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour; v->u = tOfsX; (v++)->v = tv;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour; v->u = tu;    (v++)->v = tOfsY;
    v->x = x2;  v->y = y2;  v->z = depth; v->colour = colour; v->u = tu;    (v++)->v = tv;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour; v->u = tOfsX; (v++)->v = tv;
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::RectTlTxShH(uint32* colour, S_2CRD, TEXARG)
{ // xTEXSURF& t, sint16 tOfsX, sint16 tOfsY, float32 tSclX, float32 tSclY
  if (vertsUsed+6 > vBufSize || instsUsed+5 > iBufSize)
    Flush();
  Enable(TEXTURE);
  Enable(GOURAUD);
  SetTexture(t);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 6;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 6;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    rfloat32 tu = ((x2-x1)/tSclX)+tOfsX;
    rfloat32 tv = ((y2-y1)/tSclY)+tOfsY;
    register DVERTEX* v = currVert;
    rfloat32 depth = depthReg;
    v->x = x1;  v->y = y1;  v->z = depth; v->colour = colour[0];  v->u = tOfsX; (v++)->v = tOfsY;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour[1];  v->u = tu;    (v++)->v = tOfsY;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour[0];  v->u = tOfsX; (v++)->v = tv;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour[1];  v->u = tu;    (v++)->v = tOfsY;
    v->x = x2;  v->y = y2;  v->z = depth; v->colour = colour[1];  v->u = tu;    (v++)->v = tv;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour[0];  v->u = tOfsX; (v++)->v = tv;
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::RectTlTxShV(uint32* colour, S_2CRD, TEXARG)
{ // xTEXSURF& t, sint16 tOfsX, sint16 tOfsY, float32 tSclX, float32 tSclY
  if (vertsUsed+6 > vBufSize || instsUsed+5 > iBufSize)
    Flush();
  Enable(TEXTURE);
  Enable(GOURAUD);
  SetTexture(t);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 6;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 6;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    rfloat32 tu = ((x2-x1)/tSclX)+tOfsX;
    rfloat32 tv = ((y2-y1)/tSclY)+tOfsY;
    register DVERTEX* v = currVert;
    rfloat32 depth = depthReg;
    v->x = x1;  v->y = y1;  v->z = depth; v->colour = colour[0];  v->u = tOfsX; (v++)->v = tOfsY;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour[0];  v->u = tu;    (v++)->v = tOfsY;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour[1];  v->u = tOfsX; (v++)->v = tv;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour[0];  v->u = tu;    (v++)->v = tOfsY;
    v->x = x2;  v->y = y2;  v->z = depth; v->colour = colour[1];  v->u = tu;    (v++)->v = tv;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour[1];  v->u = tOfsX; (v++)->v = tv;
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::RectTlTxShA(uint32* colour, S_2CRD, TEXARG)
{ // xTEXSURF& t, sint16 tOfsX, sint16 tOfsY, float32 tSclX, float32 tSclY
  if (vertsUsed+6 > vBufSize || instsUsed+5 > iBufSize)
    Flush();
  Enable(TEXTURE);
  Enable(GOURAUD);
  SetTexture(t);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 6;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 6;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    rfloat32 tu = ((x2-x1)/tSclX)+tOfsX;
    rfloat32 tv = ((y2-y1)/tSclY)+tOfsY;
    register DVERTEX* v = currVert;
    rfloat32 depth = depthReg;
    v->x = x1;  v->y = y1;  v->z = depth; v->colour = colour[0];  v->u = tOfsX; (v++)->v = tOfsY;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour[1];  v->u = tu;    (v++)->v = tOfsY;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour[2];  v->u = tOfsX; (v++)->v = tv;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour[1];  v->u = tu;    (v++)->v = tOfsY;
    v->x = x2;  v->y = y2;  v->z = depth; v->colour = colour[3];  v->u = tu;    (v++)->v = tv;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour[2];  v->u = tOfsX; (v++)->v = tv;
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::RectScTx(uint32 colour, S_2CRD, TEXARG)
{ // xTEXSURF& t, sint16 tOfsX, sint16 tOfsY, float32 tSclX, float32 tSclY
  if (vertsUsed+6 > vBufSize || instsUsed+6 > iBufSize)
    Flush();
  Enable(TEXTURE);
  Enable(GOURAUD); // texure env doesnt like flat shading here
  SetColour(colour);
  SetTexture(t);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 6;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 6;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    rfloat32 tu = (t->Width()/tSclX)+tOfsX;
    rfloat32 tv = (t->Height()/tSclY)+tOfsY;
    register DVERTEX* v = currVert;
    rfloat32 depth = depthReg;
    v->x = x1;  v->y = y1;  v->z = depth; v->colour = colour; v->u = tOfsX; (v++)->v = tOfsY;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour; v->u = tu;    (v++)->v = tOfsY;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour; v->u = tOfsX; (v++)->v = tv;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour; v->u = tu;    (v++)->v = tOfsY;
    v->x = x2;  v->y = y2;  v->z = depth; v->colour = colour; v->u = tu;    (v++)->v = tv;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour; v->u = tOfsX; (v++)->v = tv;
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::RectScTxShH(uint32* colour, S_2CRD, TEXARG)
{ // xTEXSURF& t, sint16 tOfsX, sint16 tOfsY, float32 tSclX, float32 tSclY
  if (vertsUsed+6 > vBufSize || instsUsed+5 > iBufSize)
    Flush();
  Enable(TEXTURE);
  Enable(GOURAUD);
  SetTexture(t);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 6;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 6;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    rfloat32 tu = (t->Width()/tSclX)+tOfsX;
    rfloat32 tv = (t->Height()/tSclY)+tOfsY;
    register DVERTEX* v = currVert;
    rfloat32 depth = depthReg;
    v->x = x1;  v->y = y1;  v->z = depth; v->colour = colour[0];  v->u = tOfsX; (v++)->v = tOfsY;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour[1];  v->u = tu;    (v++)->v = tOfsY;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour[0];  v->u = tOfsX; (v++)->v = tv;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour[1];  v->u = tu;    (v++)->v = tOfsY;
    v->x = x2;  v->y = y2;  v->z = depth; v->colour = colour[1];  v->u = tu;    (v++)->v = tv;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour[0];  v->u = tOfsX; (v++)->v = tv;
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::RectScTxShV(uint32* colour, S_2CRD, TEXARG)
{ // xTEXSURF& t, sint16 tOfsX, sint16 tOfsY, float32 tSclX, float32 tSclY
  if (vertsUsed+6 > vBufSize || instsUsed+5 > iBufSize)
    Flush();
  Enable(TEXTURE);
  Enable(GOURAUD);
  SetTexture(t);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 6;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 6;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    rfloat32 tu = (t->Width()/tSclX)+tOfsX;
    rfloat32 tv = (t->Height()/tSclY)+tOfsY;
    register DVERTEX* v = currVert;
    rfloat32 depth = depthReg;
    v->x = x1;  v->y = y1;  v->z = depth; v->colour = colour[0];  v->u = tOfsX; (v++)->v = tOfsY;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour[0];  v->u = tu;    (v++)->v = tOfsY;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour[1];  v->u = tOfsX; (v++)->v = tv;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour[0];  v->u = tu;    (v++)->v = tOfsY;
    v->x = x2;  v->y = y2;  v->z = depth; v->colour = colour[1];  v->u = tu;    (v++)->v = tv;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour[1];  v->u = tOfsX; (v++)->v = tv;
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::RectScTxShA(uint32* colour, S_2CRD, TEXARG)
{ // xTEXSURF& t, sint16 tOfsX, sint16 tOfsY, float32 tSclX, float32 tSclY
  if (vertsUsed+6 > vBufSize || instsUsed+5 > iBufSize)
    Flush();
  Enable(TEXTURE);
  Enable(GOURAUD);
  SetTexture(t);
  if (commandReg==DRW_TRIANGLES)    (currInst-1)->numVerts += 6;
  else
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIANGLES; (currInst++)->numVerts = 6;
    instsUsed++;
  }
  {
    // set up two clockwise triangles for rectangle
    rfloat32 tu = (t->Width()/tSclX)+tOfsX;
    rfloat32 tv = (t->Height()/tSclY)+tOfsY;
    register DVERTEX* v = currVert;
    rfloat32 depth = depthReg;
    v->x = x1;  v->y = y1;  v->z = depth; v->colour = colour[0];  v->u = tOfsX; (v++)->v = tOfsY;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour[1];  v->u = tu;    (v++)->v = tOfsY;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour[2];  v->u = tOfsX; (v++)->v = tv;
    v->x = x2;  v->y = y1;  v->z = depth; v->colour = colour[1];  v->u = tu;    (v++)->v = tOfsY;
    v->x = x2;  v->y = y2;  v->z = depth; v->colour = colour[3];  v->u = tu;    (v++)->v = tv;
    v->x = x1;  v->y = y2;  v->z = depth; v->colour = colour[2];  v->u = tOfsX; (v++)->v = tv;
    currVert = v;
    vertsUsed += 6;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Quadrics
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Macro for drawing the edge of a circle
//
// ps = stride
//

#define CIRCLE_EDGE(pv,px,py,pr,pd,ps)                                        \
{                                                                             \
  sint32 quart = DRAW_TSIZE/(ps);                                             \
  (pv)->x = (px);     (pv)->y = (py)-(pr);  (pv)->z = (pd);                   \
  (pv) += quart;                                                              \
  (pv)->x = (px)+(pr);  (pv)->y = (py);     (pv)->z = (pd);                   \
  (pv) += quart;                                                              \
  (pv)->x = (px);     (pv)->y = (py)+(pr);  (pv)->z = (pd);                   \
  (pv) += quart;                                                              \
  (pv)->x = (px)-(pr);  (pv)->y = (py);     (pv)->z = (pd);                   \
  (pv) += quart;                                                              \
  (pv)->x = (px);     (pv)->y = (py)-(pr);  (pv)->z = (pd);                   \
  for (rsint32 i=1, j=(ps); j < DRAW_TSIZE; i++, j+=(ps))                     \
  {                                                                           \
    rfloat32 sn = (pr)*qTrigTab[j];                                           \
    rfloat32 cs = (pr)*qTrigTab[DRAW_TSIZE-j];                                \
    (pv) = currVert+i;                                                        \
    (pv)->x = (px)+sn;  (pv)->y = (py)-cs;    (pv)->z = (pd);                 \
    (pv) += quart;                                                            \
    (pv)->x = (px)+cs;  (pv)->y = (py)+sn;    (pv)->z = (pd);                 \
    (pv) += quart;                                                            \
    (pv)->x = (px)-sn;  (pv)->y = (py)+cs;    (pv)->z = (pd);                 \
    (pv) += quart;                                                            \
    (pv)->x = (px)-cs;  (pv)->y = (py)-sn;    (pv)->z = (pd);                 \
  }                                                                           \
  (pv)+=2;                                                                    \
  currVert = (pv);                                                            \
}                                                                             \

#define CIRCLE_EDGE_CLR(pv,px,py,pr,pd,pc,ps)                                     \
{                                                                                 \
  sint32 quart = DRAW_TSIZE/(ps);                                                 \
  (pv)->x = (px);     (pv)->y = (py)-(pr);  (pv)->z = (pd); (pv)->colour = (pc);  \
  (pv) += quart;                                                                  \
  (pv)->x = (px)+(pr);  (pv)->y = (py);     (pv)->z = (pd); (pv)->colour = (pc);  \
  (pv) += quart;                                                                  \
  (pv)->x = (px);     (pv)->y = (py)+(pr);  (pv)->z = (pd); (pv)->colour = (pc);  \
  (pv) += quart;                                                                  \
  (pv)->x = (px)-(pr);  (pv)->y = (py);     (pv)->z = (pd); (pv)->colour = (pc);  \
  (pv) += quart;                                                                  \
  (pv)->x = (px);     (pv)->y = (py)-(pr);  (pv)->z = (pd); (pv)->colour = (pc);  \
  for (rsint32 i=1, j=(ps); j < DRAW_TSIZE; i++, j+=(ps))                         \
  {                                                                               \
    rfloat32 sn = (pr)*qTrigTab[j];                                               \
    rfloat32 cs = (pr)*qTrigTab[DRAW_TSIZE-j];                                    \
    (pv) = currVert+i;                                                            \
    (pv)->x = (px)+sn;  (pv)->y = (py)-cs;  (pv)->z = (pd); (pv)->colour = (pc);  \
    (pv) += quart;                                                                \
    (pv)->x = (px)+cs;  (pv)->y = (py)+sn;  (pv)->z = (pd); (pv)->colour = (pc);  \
    (pv) += quart;                                                                \
    (pv)->x = (px)-sn;  (pv)->y = (py)+cs;  (pv)->z = (pd); (pv)->colour = (pc);  \
    (pv) += quart;                                                                \
    (pv)->x = (px)-cs;  (pv)->y = (py)-sn;  (pv)->z = (pd); (pv)->colour = (pc);  \
  }                                                                               \
  (pv)+=2;                                                                        \
  currVert = (pv);                                                                \
}                                                                                 \
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Circle(uint32 colour, S_1CRD, sint16 rad)
{
  sint32 segs;
  if (rad > 96)       segs = 4*DRAW_TSIZE;
  else if (rad > 48)  segs = 2*DRAW_TSIZE;
  else if (rad > 12)  segs = DRAW_TSIZE;
  else                segs = DRAW_TSIZE/2;

  if (vertsUsed+segs+2 > vBufSize || instsUsed+5 > iBufSize) Flush();
  Disable(TEXTURE);
  Disable(GOURAUD);
  SetColour(colour);
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIFAN; (currInst++)->numVerts = segs+2;
    instsUsed++;
  }
  {
    rfloat32 fx = x;    rfloat32 fy = y;    rfloat32 fr = rad;
    register DVERTEX* v = currVert++;   rfloat32 fd = depthReg;
    // centre vertex
    v->x = fx;      v->y = fy;      (v++)->z = fd;
    // edge vertices
    segs = (4*DRAW_TSIZE)/segs;
    CIRCLE_EDGE(v,fx,fy,fr,fd,segs)
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::CircleShC(uint32* colour, S_1CRD, sint16 rad)
{
  sint32 segs;
  if (rad > 96)       segs = 4*DRAW_TSIZE;
  else if (rad > 48)  segs = 2*DRAW_TSIZE;
  else if (rad > 12)  segs = DRAW_TSIZE;
  else                segs = DRAW_TSIZE/2;

  if (vertsUsed+segs+2 > vBufSize || instsUsed+4 > iBufSize) Flush();
  Disable(TEXTURE);
  Enable(GOURAUD);
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIFAN; (currInst++)->numVerts = segs+2;
    instsUsed++;
  }
  {
    rfloat32 fx = x;    rfloat32 fy = y;    rfloat32 fr = rad;
    register DVERTEX* v = currVert++;   rfloat32 fd = depthReg;
    ruint32 clr = *(colour++);

    // centre vertex
    v->x = fx;      v->y = fy;      v->z = fd;  (v++)->colour = clr;

    // edge vertices
    clr = *colour;
    segs = (4*DRAW_TSIZE)/segs;
    CIRCLE_EDGE_CLR(v,fx,fy,fr,fd,clr,segs)
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::CircleShPt(uint32* colour, S_2CRD, sint16 rad)
{
  sint32 segs;
  if (rad > 96)       segs = 4*DRAW_TSIZE;
  else if (rad > 48)  segs = 2*DRAW_TSIZE;
  else if (rad > 12)  segs = DRAW_TSIZE;
  else                segs = DRAW_TSIZE/2;

  if (vertsUsed+segs+2 > vBufSize || instsUsed+4 > iBufSize) Flush();
  Disable(TEXTURE);
  Enable(GOURAUD);
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIFAN; (currInst++)->numVerts = segs+2;
    instsUsed++;
  }
  {
    rfloat32 fx = x2;   rfloat32 fy = y2;   rfloat32 fr = rad;
    register DVERTEX* v = currVert++;   rfloat32 fd = depthReg;
    ruint32 clr = *(colour++);

    // shade origin vertex
    v->x = fx;      v->y = fy;      v->z = fd;  (v++)->colour = clr;

    // edge vertices
    fx = x1; fy = y1;   clr = *colour;
    segs = (4*DRAW_TSIZE)/segs;
    CIRCLE_EDGE_CLR(v,fx,fy,fr,fd,clr,segs)
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#undef CIRCLE_EDGE
#undef CIRCLE_EDGE_CLR

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define ELIPSE_EDGE(pv,px,py,prx,pry,pd,ps)                   \
{                                                             \
  sint32 quart = DRAW_TSIZE/(ps);                             \
  (pv)->x = (px);     (pv)->y = (py)-(pry); (pv)->z = (pd);   \
  (pv) += quart;                                              \
  (pv)->x = (px)+(prx); (pv)->y = (py);     (pv)->z = (pd);   \
  (pv) += quart;                                              \
  (pv)->x = (px);     (pv)->y = (py)+(pry); (pv)->z = (pd);   \
  (pv) += quart;                                              \
  (pv)->x = (px)-(prx); (pv)->y = (py);     (pv)->z = (pd);   \
  (pv) += quart;                                              \
  (pv)->x = (px);     (pv)->y = (py)-(pry); (pv)->z = (pd);   \
  for (rsint32 i=1, j=(ps); j < DRAW_TSIZE; i++, j+=(ps))     \
  {                                                           \
    rfloat32 sn = qTrigTab[j];                                \
    rfloat32 cs = qTrigTab[DRAW_TSIZE-j];                     \
    (pv) = currVert+i;                                        \
    (pv)->x = (px)+sn*(prx);  (pv)->y = (py)-cs*(pry);    (pv)->z = (pd); \
    (pv) += quart;                                                        \
    (pv)->x = (px)+cs*(prx);  (pv)->y = (py)+sn*(pry);    (pv)->z = (pd); \
    (pv) += quart;                                                        \
    (pv)->x = (px)-sn*(prx);  (pv)->y = (py)+cs*(pry);    (pv)->z = (pd); \
    (pv) += quart;                                                        \
    (pv)->x = (px)-cs*(prx);  (pv)->y = (py)-sn*(pry);    (pv)->z = (pd); \
  }                                                                       \
  (pv)+=2;                                                                \
  currVert = (pv);                                                        \
}                                                                         \

#define ELIPSE_EDGE_CLR(pv,px,py,prx,pry,pd,pc,ps)                                \
{                                                                                 \
  sint32 quart = DRAW_TSIZE/(ps);                                                 \
  (pv)->x = (px);     (pv)->y = (py)-(pry); (pv)->z = (pd); (pv)->colour = (pc);  \
  (pv) += quart;                                                                  \
  (pv)->x = (px)+(prx); (pv)->y = (py);     (pv)->z = (pd); (pv)->colour = (pc);  \
  (pv) += quart;                                                                  \
  (pv)->x = (px);     (pv)->y = (py)+(pry); (pv)->z = (pd); (pv)->colour = (pc);  \
  (pv) += quart;                                                                  \
  (pv)->x = (px)-(prx); (pv)->y = (py);     (pv)->z = (pd); (pv)->colour = (pc);  \
  (pv) += quart;                                                                  \
  (pv)->x = (px);     (pv)->y = (py)-(pry); (pv)->z = (pd); (pv)->colour = (pc);  \
  for (rsint32 i=1, j=(ps); j < DRAW_TSIZE; i++, j+=(ps))                         \
  {                                                                               \
    rfloat32 sn = qTrigTab[j];                                                    \
    rfloat32 cs = qTrigTab[DRAW_TSIZE-j];                                         \
    (pv) = currVert+i;                                                            \
    (pv)->x = (px)+sn*(prx);  (pv)->y = (py)-cs*(pry);  (pv)->z = (pd); (pv)->colour = (pc);  \
    (pv) += quart;                                                                            \
    (pv)->x = (px)+cs*(prx);  (pv)->y = (py)+sn*(pry);  (pv)->z = (pd); (pv)->colour = (pc);  \
    (pv) += quart;                                                                            \
    (pv)->x = (px)-sn*(prx);  (pv)->y = (py)+cs*(pry);  (pv)->z = (pd); (pv)->colour = (pc);  \
    (pv) += quart;                                                                            \
    (pv)->x = (px)-cs*(prx);  (pv)->y = (py)-sn*(pry);  (pv)->z = (pd); (pv)->colour = (pc);  \
  }                                                                                           \
  (pv)+=2;                                                                                    \
  currVert = (pv);                                                                            \
}                                                                                             \

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::Elipse(uint32 col, S_2CRD)
{
  sint32 segs;
  {
    sint32 rad = (x2>y2) ? x2 : y2;
    if (rad > 96)       segs = 4*DRAW_TSIZE;
    else if (rad > 48)  segs = 2*DRAW_TSIZE;
    else if (rad > 12)  segs = DRAW_TSIZE;
    else                segs = DRAW_TSIZE/2;
  }
  if (vertsUsed+segs+2 > vBufSize || instsUsed+5 > iBufSize) Flush();
  Disable(TEXTURE);
  Disable(GOURAUD);
  SetColour(col);
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIFAN; (currInst++)->numVerts = segs+2;
    instsUsed++;
  }
  {
    rfloat32 fx = x1;   rfloat32 fy = y1;   rfloat32 frx = x2; rfloat32 fry = y2;
    register DVERTEX* v = currVert++;   rfloat32 fd = depthReg;
    // centre vertex
    v->x = fx;      v->y = fy;      (v++)->z = fd;
    // edge vertices
    segs = (4*DRAW_TSIZE)/segs;
    ELIPSE_EDGE(v,fx,fy,frx,fry,fd,segs)
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::ElipseShC(uint32* col, S_2CRD)
{
  sint32 segs;
  {
    sint32 rad = (x2>y2) ? x2 : y2;
    if (rad > 96)       segs = 4*DRAW_TSIZE;
    else if (rad > 48)  segs = 2*DRAW_TSIZE;
    else if (rad > 12)  segs = DRAW_TSIZE;
    else                segs = DRAW_TSIZE/2;
  }
  if (vertsUsed+segs+2 > vBufSize || instsUsed+4 > iBufSize) Flush();
  Disable(TEXTURE);
  Enable(GOURAUD);
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIFAN; (currInst++)->numVerts = segs+2;
    instsUsed++;
  }
  {
    rfloat32 fx = x1;   rfloat32 fy = y1;   rfloat32 frx = x2; rfloat32 fry = y2;
    register DVERTEX* v = currVert++;   rfloat32 fd = depthReg;
    ruint32 clr = *(col++);

    // centre vertex
    v->x = fx;      v->y = fy;      v->z = fd;  (v++)->colour = clr;

    // edge vertices
    clr = *col;
    segs = (4*DRAW_TSIZE)/segs;
    ELIPSE_EDGE_CLR(v,fx,fy,frx,fry,fd,clr,segs)
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void DRAWLIST::ElipseShPt(uint32* col, S_3CRD)
{
  sint32 segs;
  {
    sint32 rad = (x2>y2) ? x2 : y2;
    if (rad > 96)       segs = 4*DRAW_TSIZE;
    else if (rad > 48)  segs = 2*DRAW_TSIZE;
    else if (rad > 12)  segs = DRAW_TSIZE;
    else                segs = DRAW_TSIZE/2;
  }
  if (vertsUsed+segs+2 > vBufSize || instsUsed+4 > iBufSize) Flush();
  Disable(TEXTURE);
  Enable(GOURAUD);
  {
    LockMode(LOCKED);
    commandReg = currInst->opcode = DRW_TRIFAN; (currInst++)->numVerts = segs+2;
    instsUsed++;
  }
  {
    rfloat32 fx = x3;   rfloat32 fy = y3;   rfloat32 frx = x2; rfloat32 fry = y2;
    register DVERTEX* v = currVert++;   rfloat32 fd = depthReg;
    ruint32 clr = *(col++);

    // shade origin vertex
    v->x = fx;      v->y = fy;      v->z = fd;  (v++)->colour = clr;

    // edge vertices
    fx = x1; fy = y1;   clr = *col;
    segs = (4*DRAW_TSIZE)/segs;
    ELIPSE_EDGE_CLR(v,fx,fy,frx,fry,fd,clr,segs)
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
