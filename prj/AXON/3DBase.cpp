//*****************************************************************//
//** Description:   Axonometric Projector, AmigaOS/68K version   **//
//** First Started:                                              **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "3DBase.hpp"

/*
    Require following methods : need a good 3D geometry book

    PLANE:: class



    2) Other utility methods

       a) TraceVec - scans from one VEC3D location to another, something like this
          result = TraceVec(VEC3D* from, VEC3D* to, VEC3D* endPos, MODEL** thing)

          From / to are the locations to trace between and 'endPos' is the address of a VEC3D object to store
          the traced end position in. The 'thing' argument is the address of a MODEL* pointer that will be set to the address
          of the first (if any) MODEL that the trace hit. The result will be a collection of flags.

          VEC3D from(0.1, 0.1, 0.1); VEC3D to(0.8,0.8,0.0); VEC3D endPos(); MODEL* hit=0;
          uint32 result = TraceVec(&from, &to, &endPos, &hit);
          if (result & TRACE_MODEL)
          cout << "Hit model : " << hit->Name() << "\n";
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  VEC3D::
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

VEC3D& VEC3D::operator*=(const TRANSFORM& t)
{
  rfloat32*m = t.matrix;

  rfloat32 tx = x;
  rfloat32 ty = y;
  rfloat32 tz = z;

  x = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
  y = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
  z = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m);

  return *this;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  PLANE::
//
//    Represents the flat plane that intersects three points, defined in anticlockwise order. Define() takes three VEC3D
//  values and uses them to derive the equation for the plane and the unit vector normal to the plane. We choose anticlockwise
//  since this is simpler when dealing with the 3D drivers' triangle strip format
//
//  Theory:
//
//    The unit vector normal to the plane is pretty easy. We just take the cross product of the vectors (p1-p3) and (p2-p3)
//  and normalize thus
//
//               (p2-p3)x(p1-p3)
//          N = -----------------
//              |(p2-p3)x(p1-p3)|
//
//    The generic equation for a plane is defined as 0 = ax + by + cz + d. We have three points p1-p3, for which we
//  know x, y and z. What we need is to determine the values of a, b and c. Once we have these we can determine any
//  point on the plane.
//
//    For our plane, the slightly less general definition z = a.x + b.y + c is sufficient. We can therefore write
//
//          0 = a.x1 + b.y1 + c - z1
//          0 = a.x2 + b.y2 + c - z2
//          0 = a.x3 + b.y3 + c - z3
//
//    This is solvable using determinants by treating a, b and c as the unknowns and using x1...z3
//  as the factors. We arrive at
//
//          a = -D1/D0, b = D2/D0, c = -D3/D0
//
//  where D0 - D3 are the determinants ommiting the constant, a, b and c terms respectively.
//  OK, now we need to determine what D0-D3 are. This is where it gets more involved, keeping track of
//  sign can be nasty :)
//
//        D0 = | x1 y1 1 | = x1.| y2 1 | - y1.| x2 1 | + 1.| x2 y2 |
//             | x2 y2 1 |      | y3 1 |      | x3 1 |     | x3 y3 |
//             | x3 y3 1 |
//
//        D1 = | y1 1 -z1 | = y1.| 1 -z2 | - 1.| y2 -z2 | - z1.| y2 1 |
//             | y2 1 -z2 |      | 1 -z3 |     | y3 -z3 |      | y3 1 |
//             | y3 1 -z3 |
//
//        D2 = | x1 1 -z1 | = x1.| 1 -z2 | - 1.| x2 -z2 | - z1.| x2 1 |
//             | x2 1 -z2 |      | 1 -z3 |     | x3 -z3 |      | x3 1 |
//             | x3 1 -z3 |
//
//        D3 = | x1 y1 -z1 | = x1.| y2 -z2 | - y1.| x2 -z2 | - z1.| x2 y2 |
//             | x2 y2 -z2 |      | y3 -z3 |      | x3 -z3 |      | x3 y3 |
//             | x3 y3 -z3 |
//
//  These expand out to
//
//        D0 = x1.(y2 - y3) - y1.(x2 - x3) + x2.y3 - x3.y2
//        D1 = y1.(z2 - z3) - y3.z2 + y2.z3 - z1.(y2 - y3)
//        D2 = x1.(z2 - z3) - x3.z2 + x2.z3 - z1.(x2 - x3)
//        D3 = x1.y3.z2 - x1.y2.z3 - y1.x3.z2 + y1.x2.z2 - z1.x2.y3 + z1.x3.y2
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PLANE::Define(VEC3D* p1, VEC3D* p2, VEC3D* p3)
{
  flags = SOURCE_V3D;
  i = p1;
  j = p2;
  k = p3;
  VEC3D v = (*p2)-(*p3);
  {
    rfloat32 D0 = p1->x*v.y - p1->y*v.x + p2->x*p3->y - p3->x*p2->y;
    a = (p3->y*p2->z + p1->z*v.y - p1->y*v.z - p2->y*p3->z)/D0;
    b = (p1->x*v.z - p3->x*p2->z + p2->x*p3->z - p1->z*v.x)/D0;
    // use simple substitition for c since required determinant is way too long
    c = p1->z - a*p1->x - b*p1->y;
  }
  normal = v*((*p1)-(*p3));
  normal.Normalize();
  return OK;
}

sint32 PLANE::Define(C3D* p1, C3D* p2, C3D* p3)
{
  flags = SOURCE_C3D;
  i = p1;
  j = p2;
  k = p3;
  VEC3D v = ((VEC3D)*p2)-((VEC3D)*p3);
  {
    rfloat32 D0 = p1->x*v.y - p1->y*v.x + p2->x*p3->y - p3->x*p2->y;
    a = (p3->y*p2->z + p1->z*v.y - p1->y*v.z - p2->y*p3->z)/D0;
    b = (p1->x*v.z - p3->x*p2->z + p2->x*p3->z - p1->z*v.x)/D0;
    // use simple substitition for c since required determinant is way too long
    c = p1->z - a*p1->x - b*p1->y;
  }
  normal = v*((VEC3D)(*p1)-(VEC3D)(*p3));
  normal.Normalize();
  return OK;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  TRANSFORM::
//
//  Abstracts a 4x4 transformation matrix system. Internally optimised to use only 3x4 since w ordinate unused in world space
//  Default construction sets the identity matrix
//
//  Each method is as optimised as possible, touching only those elements that are affected (explicit zero terms removed).
//  Simplified pointer access to internal matrix representation used to assist optimizer
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void TRANSFORM::Scale(float32 s)
{
  // Simulates M' = s*M
  rfloat32* m = matrix;
  *(m++) *= s; *(m++) *= s; *(m++) *= s; *(m++) *= s;
  *(m++) *= s; *(m++) *= s; *(m++) *= s; *(m++) *= s;
  *(m++) *= s; *(m++) *= s; *(m++) *= s; *m *= s;
  flags &= ~IDENTITY;
  flags |= SCALED;
}

///////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Scale(float32 sx, float32 sy, float32 sz)
{
  // Simulates M' = S.M
  rfloat32* m = matrix;
  *(m++) *= sx; *(m++) *= sx; *(m++) *= sx; *(m++) *= sx;
  *(m++) *= sy; *(m++) *= sy; *(m++) *= sy; *(m++) *= sy;
  *(m++) *= sz; *(m++) *= sz; *(m++) *= sz; *m *= sz;
  flags &= ~IDENTITY;
  flags |= SCALED;
}

///////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Scale(const VEC3D& s)
{
  // Simulates M' = S.M
  rfloat32* m = matrix;
  *(m++) *= s.x; *(m++) *= s.x; *(m++) *= s.x; *(m++) *= s.x;
  *(m++) *= s.y; *(m++) *= s.y; *(m++) *= s.y; *(m++) *= s.y;
  *(m++) *= s.z; *(m++) *= s.z; *(m++) *= s.z; *m *= s.z;
  flags &= ~IDENTITY;
  flags |= SCALED;
}

///////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Translate(const VEC3D& p)
{
  // Simulates M' = T.M
  matrix[3]+=p.x;
  matrix[7]+=p.y;
  matrix[11]+=p.z;
  flags &= ~IDENTITY;
  flags |= TRANSLATED;
}

///////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Translate(float32 tx, float32 ty, float32 tz)
{
  // Simulates M' = T.M
  rfloat32* m = matrix;
  matrix[3]+=tx;
  matrix[7]+=ty;
  matrix[11]+=tz;
  flags &= ~IDENTITY;
  flags |= TRANSLATED;
}

///////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Rotate(float32 rx, float32 ry, float32 rz)
{
  // FIXME
  // Some of the elements seem to be incorrectly calculated
  // Test with individual axis 45 degree rotation
  //
  // Performs M' = R.M
  // Build rotation matrix below, then multiply our internal matrix by it.
  //
  //
  //    | CYCZ        -CYSZ         SY    0 |
  //    |                                   |
  //    | SXSYCZ+CXSZ -SXSYSZ+CXCZ  SXCY  0 |
  //    |                                   |
  //    |-CXSYCZ-SXSZ  CXSYSZ-SXCZ  CXCY  0 |
  //    |                                   |
  //    | 0            0            0     1 |
/*
  float32  Rot[9] = { f4*f5,                -(f4*f2),           f1,
                      f0*f1*f5 + f3*f2,     f3*f5 - (f0*f1*f2), f0*f4,
                      -(f3*f1*f5 + f0*f2),  f3*f1*f2 - (f0*f5), f3*f4 };
*/
  {
    // Get the trig temporaries into registers for speed

    float32 f0 = QTRIG::SinF(rx); float32 f1 = QTRIG::SinF(ry); float32 f2 = QTRIG::SinF(rz);
    float32 f3 = QTRIG::CosF(rx); float32 f4 = QTRIG::CosF(ry); float32 f5 = QTRIG::CosF(rz);

    rfloat32* m = Temp();
    // correct layout as above, each row must include zero end terms, even though we'd never use them
    *(m++) = f4*f5;                 *(m++) = -(f4*f2);            *(m++) = f1;    m++; //*(m++) = 0F;
    *(m++) = f0*f1*f5 + f3*f2;      *(m++) = f3*f5 - (f0*f1*f2);  *(m++) = f0*f4; m++; //*(m++) = 0F;
    *(m++) = -(f3*f1*f5 + f0*f2);   *(m++) = f3*f1*f2 - (f0*f5);  *(m++) = f3*f4; //*(m) = 0F;
  }
/*
  {
    rfloat32* m = Temp();
    cout.precision(6);
    cout.setf(ios::fixed);
    cout << "\nTRANSFORM::Rotate(" << rx << ", " << ry << ", " << rz <<") Matrix\n";
    cout << "|\t" << m[0] << "\t" << m[1] << "\t" << m[2] << "\t" << m[3] << "\t|\n";
    cout << "|\t" << m[4] << "\t" << m[5] << "\t" << m[6] << "\t" << m[7] << "\t|\n";
    cout << "|\t" << m[8] << "\t" << m[9] << "\t" << m[10] << "\t" << m[11] << "\t|\n";
    cout << "|\t" << 0F << "\t" << 0F << "\t" << 0F << "\t" << 1F << "\t|\n\n";
    cout.unsetf(ios::fixed);
    cout.setf(ios::scientific);
  }
*/
  {
    rfloat32* d = Temp();
    rfloat32* s1 = d;
    rfloat32* s2 = matrix;

    // Optimized
    // This could be a loop, but is it worth it for 3 iterations ?
    // Note use of simplest addressing modes made possible by using a row * row structure

    // 1st row
    {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);
      s1++; // s1 points to next row of source matrix

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) = (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
    }
    // 2nd row
    {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);
      s1++;

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) = (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
    }
    // 3rd row
    {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) = (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
    }
  }
  // Switch matrix buffer such that the result becomes the current matrix
  Swap();
  flags |= ROTATED;
}

///////////////////////////////////////////////////////////////////////////////

TRANSFORM& TRANSFORM::operator*=(const TRANSFORM& t)
{
  // a*A + b*E + c*I,   a*B + b*F + c*J,    a*C + b*G + c*K,    d + a*D + b*H + c*L
  //
  // e*A + f*E + g*I,   e*B + f*F + g*J,    e*C + f*G + g*K,    h + e*D + f*H + g*L
  //
  // i*A + j*E + k*I,   i*B + j*F + k*J,    i*C + j*G + k*K,    l + i*D + j*H + k*L
  //
  // 0                  0                   0                   1

  rfloat32* d  = matrix;
  rfloat32* s1 = d;
  rfloat32* s2 = t.matrix;

  // 1st row
  {
      // 'cache' source row terms, except last which is used once
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);
      s1++;

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) += (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
  }
  // 2nd row
  {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);
      s1++;

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) += (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
  }
  // 3rd row
  {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) += (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
  }
  return *this;
}

///////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Transform(VEC3D* s, uint32 n)
{ // transform VEC3D 'in place', no copying
  n++;
  while(--n)
  {

  }
}

///////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Transform(C3D* s, uint32 n)
{ // transform C3D 'in place', no copying
  n++;
  while(--n)
  {

  }
}

///////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Transform(sysVERTEX* s, uint32 n)
{ // transform sysVERTEX 'in place', no copying
  n++;
  while(--n)
  {

  }
}

///////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Transform(VEC3D* s, VEC3D* d, uint32 n)
{
  n++;
  while(--n)
  {

  }
}

///////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Transform(VEC3D* s, C3D* d, uint32 n)
{
  n++;
  while(--n)
  {

  }
}

///////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Transform(C3D* s, C3D* d, uint32 n)
{
  n++;
  while(--n)
  {

  }
}


void TRANSFORM::Transform(C3D* s, sysVERTEX* d, uint32 n)
{
  n++;
  while(--n)
  {

  }
}


void TRANSFORM::Transform(sysVERTEX* s, sysVERTEX* d, uint32 n)
{
  n++;
  while(--n)
  {

  }
}


void TRANSFORM::Dump()
{
  puts("\nTRANSFORM Matrix");
  printf("| %8.5 %8.5 %8.6 %8.5 |\n", matrix[0], matrix[1], matrix[2], matrix[3]);
  printf("| %8.5 %8.5 %8.6 %8.5 |\n", matrix[4], matrix[5], matrix[6], matrix[7]);
  printf("| %8.5 %8.5 %8.6 %8.5 |\n", matrix[8], matrix[9], matrix[10], matrix[11]);
  printf("| %8.5 %8.5 %8.6 %8.5 |\n", 0F, 0F, 0F, 1F);
}

///////////////////////////////////////////////////////////////////////////////
//
//  QTRIG::
//
///////////////////////////////////////////////////////////////////////////////

float32 QTRIG::sineData[91] = {
  0.000000,   0.0174524,  0.0348995,  0.0523360,  0.0697565,
  0.0871557,  0.104528,   0.121869,   0.139173,   0.156434,
  0.173648,   0.190809,   0.207912,   0.224951,   0.241922,
  0.258819,   0.275637,   0.292372,   0.309017,   0.325568,
  0.342020,   0.358368,   0.374607,   0.390731,   0.406737,
  0.422618,   0.438371,   0.453990,   0.469472,   0.484810,
  0.500000,   0.515038,   0.529919,   0.544639,   0.559193,
  0.573576,   0.587785,   0.601815,   0.615661,   0.629320,
  0.642788,   0.656059,   0.669131,   0.681998,   0.694658,
  0.707107,   0.719340,   0.731354,   0.743145,   0.754710,
  0.766044,   0.777146,   0.788011,   0.798636,   0.809017,
  0.819152,   0.829038,   0.838671,   0.848048,   0.857167,
  0.866025,   0.874620,   0.882948,   0.891007,   0.898794,
  0.906308,   0.913545,   0.920505,   0.927184,   0.933580,
  0.939693,   0.945519,   0.951057,   0.956305,   0.961262,
  0.965926,   0.970296,   0.974370,   0.978148,   0.981627,
  0.984808,   0.987688,   0.990268,   0.992546,   0.994522,
  0.996195,   0.997564,   0.998630,   0.999391,   0.999848,
  1.000000
};

float32 QTRIG::gradData[91] = {
  0.000000,   0.0174551,  0.0349208,  0.0524078,  0.0699268,
  0.0874887,  0.105104,   0.122785,   0.140541,   0.158384,
  0.176327,   0.194380,   0.212557,   0.230868,   0.249328,
  0.267949,   0.286745,   0.305731,   0.324920,   0.344328,
  0.363970,   0.383864,   0.404026,   0.424475,   0.445229,
  0.466308,   0.487733,   0.509525,   0.531709,   0.554309,
  0.577350,   0.600861,   0.624869,   0.649408,   0.674509,
  0.700208,   0.726543,   0.753554,   0.781286,   0.809784,
  0.839100,   0.869287,   0.900404,   0.932515,   0.965689,
  1.00000,    1.03553,    1.07237,    1.11061,    1.15037,
  1.19175,    1.23490,    1.27994,    1.32704,    1.37638,
  1.42815,    1.48256,    1.53986,    1.60033,    1.66428,
  1.73205,    1.80405,    1.88073,    1.96261,    2.05030,
  2.14451,    2.24604,    2.35585,    2.47509,    2.60509,
  2.74748,    2.90421,    3.07768,    3.27085,    3.48741,
  3.73205,    4.01078,    4.33148,    4.70463,    5.14455,
  5.67128,    6.31375,    7.11537,    8.14435,    9.51436,
  11.4301,    14.3007,    19.0811,    28.6362,    57.2899,
  1000.0
};


