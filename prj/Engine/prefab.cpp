//****************************************************************************//
//**                                                                        **//
//**  File:          prefab.cpp ($NAME=prefab.cpp)                          **//
//**                                                                        **//
//**  Description:   Map block prefab class definition                      **//
//**  Comment(s):                                                           **//
//**                                                                        **//
//**  First Started: 2003-01-18                                             **//
//**  Last Updated:  2003-01-23                                             **//
//**                                                                        **//
//**  Author(s):     Karl Churchill                                         **//
//**                                                                        **//
//**  Copyright:     (C)1998-2003, eXtropia Studios                         **//
//**                 Serkan YAZICI, Karl Churchill                          **//
//**                 All Rights Reserved.                                   **//
//**                                                                        **//
//****************************************************************************//


#include "prefab.hpp"

PREFAB_BASE::PREFAB_BASE() : numTris(0), numVerts(0), numVertNorms(0), numFaceNorms(0), numPlaneConsts(0)
{

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void PREFAB_BASE::Zero()
{
  numTris = 0;
  numVerts = 0;
  numVertNorms = 0;
  numFaceNorms = 0;
  numPlaneConsts = 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PREFAB_BASE::Set(size_t nTris, size_t nVerts, size_t nVNorms, size_t nFNorms, size_t nPConsts)
{
  if (nTris<0 || nTris > maxTris)
  { // zero triangles is allowed (totally empty space)
    puts("[error] invalid triangle count");
    return ERR_VALUE;
  }
  else if (nTris==0)
  { // Null prefab
    if (nVerts || nVNorms || nFNorms || nPConsts)
    {
      puts("[warning] malformed null prefab");
      Zero();
      return OK;
    }
  }
  else
  { // Validate ranges
    if (nVerts<3 || nVerts>nTris*3)
    {
      puts("[warning] invalid vertex count");
      nVerts = nTris*3;
    }
    if (nVNorms<1 || nVNorms>nVerts)
    {
      puts("[warning] invalid vertex normal count");
      nVNorms = nVerts;
    }
    if (nFNorms<1 || nFNorms>nTris)
    {
      puts("[warning] invalid face normal count");
      nFNorms = nTris;
    }
    if (nPConsts<1 || nPConsts>nTris)
    {
      puts("[warning] invalid plane constant count");
      nPConsts = nTris;
    }
  }
  numTris         = nTris;
  numVerts        = nVerts;
  numVertNorms    = nVNorms;
  numFaceNorms    = nFNorms;
  numPlaneConsts  = nPConsts;
  return OK;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PREFAB::Create(size_t nTris, size_t nVerts, size_t nVNorms, size_t nFNorms, size_t nPConsts)
{
  if (vertices)
    return ERR_RSC_LOCKED;

  if (Set(nTris, nVerts, nVNorms, nFNorms, nPConsts)!=OK)
  {
    Zero();
    return ERR_VALUE;
  }

  size_t reqSize = (numTris*sizeof(TRIDEF))
                 + (numVerts*sizeof(VERTEX))
                 + ((numVertNorms + numFaceNorms)*sizeof(VEC3D))
                 + (numPlaneConsts*sizeof(float32));

  void* mem = MEM::Alloc(reqSize, true, MEM::ALIGN_CACHE);
  if (!mem)
  {
    printf("PREFAB::Create() - [error] failed to allocate %d bytes\n", reqSize);
    Zero(); // ensures all data zeroed
    return ERR_NO_FREE_STORE;
  }

  // Data arrangement
  //
  // low address ------> high address
  // [.......][....][...][....][....]
  // |        |     |    |     |
  // |        |     |    |     tris <32-bit>
  // |        |     |    planeConsts <32-bit>
  // |        |     faceNorms <32bit>
  // |        vertNorms <cache>
  // vertices <cache>

  vertices        = (VERTEX*)mem;
  vertNorms       = (VEC3D*)(vertices + numVerts);
  faceNorms       = vertNorms + numVertNorms;
  planeConsts     = (float32*)(faceNorms + numFaceNorms);
  tris            = (TRIDEF*)(planeConsts + numPlaneConsts);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void PREFAB::Delete()
{
  if (vertices)
    MEM::Free(vertices);
  vertices = 0;
  Zero();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
