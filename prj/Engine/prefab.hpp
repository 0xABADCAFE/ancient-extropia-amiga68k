//****************************************************************************//
//**                                                                        **//
//**  File:          prefab.hpp ($NAME=prefab.hpp)                          **//
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

#ifndef _ENGINE_PREFAB_HPP
#define _ENGINE_PREFAB_HPP

#include <xBase.hpp>
#include <xSystem/GraphicsLib.hpp>
#include <xSystem/IOLib.hpp>
#include "math3D.hpp"

class VERTEX : public VEC3D {
  public:
    float32 w;
    float32 u;
    float32 v;
    ARGB32  colour;
    ARGB32  ambient;
  public:
    VERTEX() : VEC3D(0,0,0), w(1.0), u(0), v(0), colour(0), ambient(0) {}
}; // 32 bytes

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  PREFAB_BASE
//
//  Data representation for map unit
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class PREFAB_BASE {
  friend class PREFABUTIL;
  public:
    typedef struct {
      uint8 iTexture;     // index of texture
      uint8 iVertex1;     // index of first vertex, relative to prefab
      uint8 iVertex2;
      uint8 iVertex3;
      uint8 iVertexNorm1; // index of first vertex normal
      uint8 iVertexNorm2;
      uint8 iVertexNorm3;
      uint8 iFaceNorm;    // index of face normal
      uint8 iPlaneConst;  // index of face plane constant
      uint8 solid;        // is solid w.r.t. entities
      uint8 trans;        // is transparent
      uint8 vis;          // is visible
  } TRIDEF; // 12

  protected:
    const size_t  maxTris = 85;
    size_t numTris;
    size_t numVerts;
    size_t numVertNorms;
    size_t numFaceNorms;
    size_t numPlaneConsts;

    void      Zero();
    sint32    Set(size_t tris, size_t verts, size_t vNorms, size_t fNorms, size_t fConsts);

    PREFAB_BASE();

  public:
    virtual ~PREFAB_BASE() {}
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  PREFAB
//
//  Runtime implementation of map unit
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class PREFAB : public PREFAB_BASE {
  private:
    VERTEX    *vertices;
    VEC3D     *vertNorms;
    VEC3D     *faceNorms;
    float32   *planeConsts;
    TRIDEF    *tris;

  protected:

  public:
    sint32    Create(size_t tris, size_t verts, size_t vNorms, size_t fNorms, size_t fConsts);
    void      Delete();
    PREFAB() : PREFAB_BASE(), vertices(0) {}
    ~PREFAB() { Delete(); }

};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  PREFAB_EDIT
//
//  Editable implementation of map unit (for utility programs)
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class PREFAB_EDIT : public PREFAB_BASE {
  private:
    static char buf[256];
    VERTEX    *vertices;
    VEC3D     *vertNorms;
    VEC3D     *faceNorms;
    float32   *planeConsts;
    TRIDEF    *tris;

  protected:
    bool  ReadTextTri(size_t i);
    bool  ReadTextVert(size_t i);
    bool  ReadTextVNorm(size_t i);
    bool  ReadTextFNorm(size_t i);
    bool  ReadTextPConst(size_t i);

  public:
    sint32    Create(size_t tris, size_t verts, size_t vNorms, size_t fNorms, size_t fConsts);
    void      Delete();

    sint32    SortTriangles();
    sint32    ReadText(const char* fileName);
    sint32    WriteText(const char* fileName);

    sint32    AddVertex(float32 x, float32 y, float32 z, float32 u, float32 v, ARGB32 col);
    sint32    DelVertex(size_t i);

    sint32    AddVertexNormal(float32 x, float32 y, float32 z);
    sint32    DelVertexNormal(size_t i);

    sint32    AddFaceNormal(float32 x, float32 y, float32 z);
    sint32    DelFaceNormal(size_t i);

    sint32    AddTriangle(size_t tex, size_t v1, size_t v2, size_t v3, size_t n1, size_t n2, size_t n3);
    sint32    DelVertexNormal(size_t i);

  public:
    PREFAB_EDIT() : PREFAB_BASE(), vertices(0) { }
    ~PREFAB_EDIT() { Delete(); }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif
