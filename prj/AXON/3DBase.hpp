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
/*#error You must include axon.hpp*/

// For testing numerics outside of AXON project
//
// Include just enough to stop compiler from bitching

#include <xBase.hpp>

extern "C" {
	#include <math.h>
	#include <limits.h>
	#include <Warp3D/Warp3D.h>
}
#define _AXON_3D_HPP

typedef W3D_Vertex sysVERTEX;

#endif


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  VEC3D:: 3 component vector. Basis of all coordinate geometry. No point in hiding internals for this one
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//inline float32 QSqrt(REGF(0)) { asm("fsqrt.x f0, f0;"); return __f0; }

class TRANSFORM;

class VEC3D {
	public:
		float32 x;
		float32 y;
		float32 z;
	public:
		VEC3D() {}
		VEC3D(float32 ix, float32 iy=0, float32 iz=0) : x(ix), y(iy), z(iz) {}
	public:
		VEC3D& operator=(const VEC3D& c)		{ x=c.x; y=c.y; z=c.z; return *this; }
		VEC3D& operator+=(const VEC3D& c)		{ x+=c.x; y+=c.y; z+=c.z; return *this; }
		VEC3D& operator-=(const VEC3D& c)		{ x-=c.x; y-=c.y; z-=c.z; return *this; }
		VEC3D& operator*=(const VEC3D& c);
		VEC3D& operator*=(rfloat32 i)	{ x*=i; y*=i; z*=i; return *this; }
		VEC3D& operator/=(rfloat32 i)	{ x/=i; y/=i; z/=i; return *this; }
		VEC3D& operator*=(const TRANSFORM& t);
		float32 Magnitude()	{ return sqrt(x*x + y*y + z*z); }
		float32 Normalize()	{ rfloat32 r   = Magnitude(); (*this)/=r; return r; } // Note, normalized vec == direction cosine
};

inline VEC3D& VEC3D::operator*=(const VEC3D& c)
{	// A x B = (b1*c2-b2*c1)i + (a2*c1-a1*c2)j + (a1*b2-a2*b1)k
	rfloat32 tx = x;	x = y*c.z - c.y*z; // (b1*c2-b2*c1)i
	rfloat32 ty = y;	y = c.x*z - tx*c.z; // (a2*c1-a1*c2)j
	z = tx*c.y - c.x*ty;									// (a1*b2-a2*b1)k
	return *this;
}

inline VEC3D operator+(const VEC3D& a, const VEC3D& b)	{ VEC3D r=a; return r+=b; }
inline VEC3D operator-(const VEC3D& a, const VEC3D& b)	{ VEC3D r=a;	return r-=b; }
inline VEC3D operator*(const VEC3D& a, const VEC3D& b)	{ VEC3D r=a;	return r*=b; }
inline VEC3D DirCosine(const VEC3D& a)									{ VEC3D r=a; r.Normalize(); return r; }

inline float32 AngCosine(VEC3D& a, VEC3D& b)
{
	// returns cos(Ang) where Ang is the angle between two VEC3D
	rfloat32 t = a.x*b.x + a.y*b.y + a.z*b.z;
	return t / (a.Magnitude()*b.Magnitude());
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  C3D:: A simple vertex type, adds colour and texture coordinates to VEC3D. No point in hiding internals for this one
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class C3D : public VEC3D {
	public:
		float32 u; // 2D texture ordinates
		float32 v;
		uint32	c; // basic point color
	public:
		C3D() {}
		C3D(float32 ix, float32 iy=0, float32 iz=0, float32 iu=0, float32 iv=0, uint32 ic=0) : VEC3D(ix,iy,iz), u(iu), v(iv), c(ic) {}
	public:
		C3D& operator=(const C3D& a) { x=a.x, y=a.y; z=a.z; u=a.u; v=a.v; c=a.c; return *this; }
};

inline C3D operator+(const C3D& a, const VEC3D& b)	{ C3D r=a; r+=b; return r; } // VEC3D::operator+=()
inline C3D operator+(const VEC3D& a, const C3D& b)	{ C3D r=b; r+=a; return r; } // VEC3D::operator+=()
inline C3D operator-(const C3D& a, const VEC3D& b)	{	C3D r=a; r-=b; return r; } // VEC3D::operator-=()
inline C3D operator-(const VEC3D& a, const C3D& b)	{	C3D r=b; r-=a; return r; } // VEC3D::operator+=()

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  PLANE::
//
//    Represents planar surface intersecting three points, defined in counter clockwise order. The equation of the plane
//  and the unit vector normal to it are evaluated for use. The former is useful in testing surface contact etc, the latter for
//  evaluating lighting, collision rebound etc..
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class PLANE {
	private:
		uint32	flags;
		VEC3D*	i;
		VEC3D*	j;
		VEC3D*	k;
		VEC3D normal;
		float32 a; // coefficients for z(x,y) = a.x + b.y + c
		float32 b;
		float32 c;

		enum {
			SOURCE_V3D = 0x00000001, // used to implement a form of RTTI
			SOURCE_C3D = 0x00000002
		};

	public:
		VEC3D&		Normal() { return normal; }
		sint32		Define(VEC3D* p1, VEC3D* p2, VEC3D* p3);
		sint32		Define(C3D* p1, C3D* p2, C3D* p3);
		sint32		Define(VEC3D& p1, VEC3D& p2, VEC3D& p3) { return Define(&p1, &p2, &p3); }
		sint32		Define(C3D& p1, C3D& p2, C3D& p3)				{ return Define(&p1, &p2, &p3); }

		float32		XForYZ(float32 y, float32 z) { return (z - b*y - c)/a; }
		float32		YForXZ(float32 x, float32 z) { return (z - a*x - c)/b; }
		float32		ZForXY(float32 x, float32 y) { return a*x + b*y + c; }
		void			XForYZ(VEC3D& p) { p.z = XForYZ(p.y, p.z); }
		void			YForXZ(VEC3D& p) { p.z = YForXZ(p.x, p.z); }
		void			ZForXY(VEC3D& p) { p.z = ZForXY(p.x, p.y); }
		void			PushC3D(register C3D* s) { *(s++) = *((C3D*)i); *(s++) = *((C3D*)j); *s = *((C3D*)k); }
	public:
		PLANE() {}
		PLANE(VEC3D* p1, VEC3D* p2, VEC3D* p3) { Define(p1, p2, p3); }
		PLANE(VEC3D& p1, VEC3D& p2, VEC3D& p3) { Define(p1, p2, p3); }
		PLANE(C3D* p1, C3D* p2, C3D* p3) { Define(p1, p2, p3); }
		PLANE(C3D& p1, C3D& p2, C3D& p3) { Define(p1, p2, p3); }
		~PLANE() {}
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  TRANSFORM::
//
//  Abstracts a 4x4 transformation matrix system. Internally optimised to use only 3x4 since w ordinate always 1 in world space
//  and unused. This usually allows us to skip the final row/column in matrix*matrix steps.
//
//  Each method designed to alter only the parts of the matrix that are affected.
//
//  Default construction sets the identity matrix
//
//  Call transform methods in order to build transformation
//
//  Notes
//
//  Implements a double buffered 3*4 matrix.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class TRANSFORM {

	friend class VEC3D;
	friend class VIEW;
	friend TRANSFORM operator*(const TRANSFORM& a, const TRANSFORM& b);

	private:
		float32		data[24]; // contains enough space for 2 3*4 matrices
		float32*	matrix;
		uint32		flags;

	protected:
		enum {
			UPPERBUFF		= 0x00000001,
			IDENTITY		= 0x00000002, // is identity matrix
			SCALED			= 0x00000004,
			TRANSLATED	= 0x00000008,
			ROTATED			= 0x00000010,
			MULTIPLIED	= 0x00000020
		};

		float32*	Matrix()	{ return matrix; }
		float32*	Temp()		{ return (flags & UPPERBUFF) ? data : data+12; }
		void			Swap()		{ if (flags & UPPERBUFF) { matrix = data; flags &= ~UPPERBUFF; } else { matrix = data+12; flags |= UPPERBUFF; } }

	public:
		void Identity();
		void Scale(float32 s);
		void Scale(float32 sx, float32 sy, float32 sz);
		void Scale(const VEC3D& s);
		void Translate(float32 tx, float32 ty, float32 tz);
		void Translate(const VEC3D& p);
		void Rotate(float32 rx, float32 ry, float32 rz);
		void Rotate(const VEC3D& p) { Rotate(p.x, p.y, p.z); }

		void Transform(VEC3D* s, uint32 n);
		void Transform(C3D* s, uint32 n);
		void Transform(sysVERTEX* s, uint32 n);

		void Transform(VEC3D* s, VEC3D* d, uint32 n);
		void Transform(VEC3D* s, C3D* d, uint32 n);
		void Transform(C3D* s, C3D* d, uint32 n);
		void Transform(C3D* s, sysVERTEX* d, uint32 n);
		void Transform(sysVERTEX* s, sysVERTEX* d, uint32 n);

		bool IsIdentity() { return (flags & IDENTITY); }
	public:
		TRANSFORM& operator*=(const TRANSFORM& t);
		TRANSFORM& operator=(const TRANSFORM& t);
		void Dump();

	public:
		inline TRANSFORM();
		~TRANSFORM() {}
};

inline void TRANSFORM::Identity()
{
	// Quickly loads identity matrix
	ruint32* m = (uint32*)matrix;
	ruint32 one = 0x3F800000; // 68K binary rep of sp 1.0
	*(m++) = one; *(m++)	= 0; *(m++)	= 0; *(m++)	= 0; *(m++)	= 0;
	*(m++) = one; *(m++)	= 0; *(m++)	= 0; *(m++)	= 0; *(m++)	= 0;
	*(m++) = one; *(m)		= 0;
	flags = IDENTITY;
}

inline TRANSFORM& TRANSFORM::operator=(const TRANSFORM& t)
{
	if (t.flags & IDENTITY)
		Identity();
	else
	{
		ruint32* s = (uint32*)t.matrix;
		ruint32* d = (uint32*)matrix;
		*(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++);
		*(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++);
		*(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++); *(s) = *(d);
		flags |= (t.flags & ~UPPERBUFF);
	}
	return *this;
}

inline TRANSFORM::TRANSFORM() : flags(0)
{
	matrix = data;
	Identity();
}

inline TRANSFORM operator*(const TRANSFORM& a, const TRANSFORM& b)
{
	if (a.flags & TRANSFORM::IDENTITY)
		return b
	else if (b.flags & TRANSFORM::IDENTITY)
		return a;
	else
	{
		TRANSFORM r = a;
		return r*=b;
	}
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  QTRIG:: High speed trig class, integer degree angle based, float estimated by interpolation.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class QTRIG {

	private:
		static float32	sineData[91]; // small sine LUT for 0-90 deg inclusive
		static float32	gradData[91]; // small LUT for angular gradient data (tan)

	public:
		static float32	SinI(ruint32 i); // i = 0-360 degrees
		static float32	CosI(ruint32 i); // i = 0-360 degrees
		static float32	SinF(rfloat32 a);
		static float32	SinF2(rfloat32 a);
		static float32	CosF(rfloat32 a);
		static float32	CosF2(rfloat32 a);
		static float32	TanI(ruint32 i);
		static float32	CotI(ruint32 i);
		//static float32	TanF(rfloat32 a);
		//static float32	CotF(rfloat32 a);
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline	float32 QTRIG::SinI(ruint32 i)
{
	if (i<90)
		return sineData[i];			// sin(0...PI/2)
	else if (i<180)
		return sineData[180-i];	// sin(PI/2...PI)    : y axis reflection symmetrical to sin(0...PI/2)
	else if (i<270)
		return -sineData[i-180];// sin(PI...3PI/2)   : x axis reflection symmetrical to sin(0...PI/2)
	else if (i<360)
		return -sineData[360-i];// sin(3PI/2...2PI)  : x/y axis reflection symmetrical to sin(0...PI/2)
	else
		return sineData[i-360];	// to allow interpolator to wrap to first quater
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline	float32 QTRIG::CosI(ruint32 i)
{
	if (i<90)
		return sineData[90-i];	// cos(0...PI/2) 	  : y axis reflection symmetrical to sin(0...PI/2)
	else if (i<180)
		return -sineData[i-90];	// cos(PI/2...PI)   : x axis reflection symmetrical to sin(0...PI/2)
	else if (i<270)
		return -sineData[270-i];// cos(PI...3PI/2)  : x/y axis reflection symmetrical to sin(0...PI/2)
	else if (i<360)
		return sineData[i-270];	// cos(3PI/2...2PI) : congruent with sin(0...PI/2)
	else
		return sineData[450-i];	// to allow interpolator to wrap to first quater
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline float32 QTRIG::SinF(rfloat32 x)
{	// linearly interpolated version
	// Note we must be specific about casting here because of the fact that we are dealing with
	// mixed mode arithmetic
	ruint32 i = (uint32)x;
	x -= i;
	return (float32)((1.0F-x)*SinI(i) + x*SinI(i+1));
}


inline float32 QTRIG::SinF2(rfloat32 x)
{ // interpolated version that uses a nearest cosine gradient, aprx 3x more accurate than above
	#define D2R PI/180.0F
	ruint32 i = (uint32)x;
	x -= i;
	if (x<0.5F)
		x*=D2R;
	else
	{
		x = (x-1F)*D2R; i++;
	}
	if (i<90)
		return sineData[i] + x*sineData[90-i];
	else if (i<180)
		return sineData[180-i] - x*sineData[i-90];
	else if (i<270)
		return -sineData[i-180] - x*sineData[270-i];
	else if (i<360)
		return x*sineData[i-270] - sineData[360-i];
	else
		return sineData[i-360] + x*sineData[450-i];
	#undef D2R
}

inline float32 QTRIG::CosF(rfloat32 x)
{	// interpolated version
	// Note we must be specific about casting here because of the fact that we are dealing with
	// mixed mode arithmetic
	ruint32 i = (uint32)x;
	x -= i;
	return (float32)((1.0F-x)*CosI(i) + x*CosI(i+1));
}

inline float32 QTRIG::CosF2(rfloat32 x)
{ // interpolated version that uses a nearest -sine gradient, aprx 3x more accurate than above
	#define D2R PI/180.0F
	ruint32 i = (uint32)x;
	x -= i;
	if (x<0.5F)
		x*=D2R;
	else
	{
		x = (x-1F)*D2R; i++;
	}
	if (i<90)
		return sineData[90-i] - x*sineData[i];
	else if (i<180)
		return  -sineData[i-90] - x*sineData[180-i];
	else if (i<270)
		return  -sineData[270-i] + x*sineData[i-180];
	else if (i<360)
		return  -sineData[360-i] - x*sineData[i-270];
	else
		return sineData[450-i] - x*sineData[i-360];
	#undef D2R
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline	float32 QTRIG::TanI(ruint32 i)
{
	if (i<90)
		return gradData[i];				// 0 --> infinity
	else if (i<180)
		return -gradData[180-i];	// -infinity --> 0
	else if (i<270)
		return gradData[i-180];   // 0 --> infinity
	else if (i<360)
		return -gradData[360-i];	// -infinity --> 0
	else
		return gradData[i-360];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline	float32 QTRIG::CotI(ruint32 i)
{
	if (i<90)
		return -gradData[90-i];		// -infinity --> 0
	else if (i<180)
		return gradData[i-90];		// 0 --> infinity
	else if (i<270)
		return -gradData[270-i];	// -infinity --> 0
	else if (i<360)
		return gradData[i-270];		// 0 --> infinity
	else
		return -gradData[450-i];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
