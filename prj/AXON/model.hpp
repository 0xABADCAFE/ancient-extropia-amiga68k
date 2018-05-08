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


/*
class ELEMENT : protected AXON {

  private:
    sint32      vertexCount;
    uint32      state;
    C3D*        vertexTemplate; // data describing raw elemnt geometry
    VEC3D*      normalTemplate;
    xTEXTURE*   texture;
    C3D*        vertices;
    VEC3D*      normals;
    sysVERTEX*  drawData;

  protected:
    enum {
      INVALID   = 0x00000000,
      POINT     = 0x00000001,
      POINTS    = 0x00000002,
      LINE      = 0x00000003,
      LINES     = 0x00000004,
      TRIANGLE  = 0x00000005,
      TRIFAN    = 0x00000006,
      TRISTRIP  = 0x00000007
    };

    void Draw();
};
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class MODEL : protected AXON {

  protected:
    TRANSFORM transform;
    VEC3D     origin;
    VEC3D     angles;
    VEC3D     scale;
    //VEC3D     absMin;
    //VEC3D     absMax;


  public:
    virtual void ClipBox() = 0;
    virtual void Place(const VEC3D& o, float32 s, sint16 x, sint16 y, sint16 z) = 0;
    virtual void Move(const VEC3D& dir) = 0;
    virtual void Rotate(sint16 x, sint16 y, sint16 z) = 0;
    virtual void Render(VIEW& view) = 0;

  public:
    virtual ~MODEL() {}
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class RGBCUBE : public MODEL {

  private:
    C3D pt[16];

  public:
    void ClipBox() {}
    void Place(const VEC3D& o, float32 s, sint16 x=0, sint16 y=0, sint16 z=0);
    void Move(const VEC3D& dir) {}
    void Rotate(sint16 x, sint16 y, sint16 z) {}
    void Render(VIEW& view);

  public:
    RGBCUBE() {}
    ~RGBCUBE() {}
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class PINETREE : public MODEL {
  private:
    static sint32     count;
    static xTEXTURE*  texture;
    static C3D        points[30];

  private:
    sysTEXTURE*     tex;
    sysVERTEX*      pj;

  public:
    void ClipBox() {}
    void Place(const VEC3D& o, float32 s, sint16 x=0, sint16 y=0, sint16 z=0);
    void Move(const VEC3D& dir) {}
    void Rotate(sint16 x, sint16 y, sint16 z) {}
    void Render(VIEW& view);

  public:
    PINETREE();
    ~PINETREE();
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class BUILDING : public MODEL {
  private:
    static sint32     count;
    static xTEXTURE*  texture;
    static C3D        points[];

  private:
    sysTEXTURE*     tex;
    sysVERTEX*      pj;

  public:
    void ClipBox() {}
    void Place(const VEC3D& o, float32 s, sint16 x=0, sint16 y=0, sint16 z=0);
    void Move(const VEC3D& dir) {}
    void Rotate(sint16 x, sint16 y, sint16 z) {}
    void Render(VIEW& view);

  public:
    BUILDING();
    ~BUILDING();
};