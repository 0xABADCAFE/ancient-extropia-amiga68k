//****************************************************************************//
//**                                                                        **//
//**  File:          math3D.hpp ($NAME=math3D.hpp)                          **//
//**                                                                        **//
//**  Description:   3D vector arithmetic routines                          **//
//**  Comment(s):                                                           **//
//**                                                                        **//
//**  First Started: 2003-01-18                                             **//
//**  Last Updated:  2003-01-18                                             **//
//**                                                                        **//
//**  Author(s):     Karl Churchill                                         **//
//**                                                                        **//
//**  Copyright:     (C)1998-2003, eXtropia Studios                         **//
//**                 Serkan YAZICI, Karl Churchill                          **//
//**                 All Rights Reserved.                                   **//
//**                                                                        **//
//****************************************************************************//

#include "math3D.hpp"

#ifndef USE_HAND_OPTIMIZED

//////////////////////////////////////////////////////////////////////////////
//
//  TRANSFORM& TRANSFORM::operator*=(const TRANSFORN& t)
//
//////////////////////////////////////////////////////////////////////////////

TRANSFORM& TRANSFORM::operator*=(const TRANSFORM& t)
{
  // | a b c d |    | A B C D |
  // | e f g h | \/ | E F G H |
  // | i j k l | /\ | I J K L |
  // | 0 0 0 1 |    | 0 0 0 1 |
  //
  // | aA+bE+cI+dM, aB+bF+cJ+dN, aC+bG+cK+dO, aD+bH+cL+d |
  // | eA+fE+gI+hM, eB+fF+gJ+hN, eC+fG+gK+hO, eD+fH+gL+h |
  // | iA+jE+kI+lM, iB+jF+kJ+lN, iC+jG+kK+lO, iD+jH+kL+l |
  // |           0,           0,           0,          1 |
  //
  // | mA+nE+oI+pM, mB+nF+oJ+pN, mC+nG+oK+pO, mD+nH+oL+pP |

  rfloat32* d = matrix;
  rfloat32* s = t.matrix;

  {
    rfloat32 t1 = d[M_11]; rfloat32 t2 = d[M_12]; rfloat32 t3 = d[M_13];
    d[M_11]  = t1*s[M_11] + t2*s[M_21] + t3*s[M_31];
    d[M_12]  = t1*s[M_12] + t2*s[M_22] + t3*s[M_32];
    d[M_13]  = t1*s[M_13] + t2*s[M_23] + t3*s[M_33];
    d[M_14] += t1*s[M_14] + t2*s[M_24] + t3*s[M_34];
    t1 = d[M_21]; t2 = d[M_22]; t3 = d[M_23];
    d[M_21]  = t1*s[M_11] + t2*s[M_21] + t3*s[M_31];
    d[M_22]  = t1*s[M_12] + t2*s[M_22] + t3*s[M_32];
    d[M_23]  = t1*s[M_13] + t2*s[M_23] + t3*s[M_33];
    d[M_24] += t1*s[M_14] + t2*s[M_24] + t3*s[M_34];
    t1 = d[M_31]; t2 = d[M_32]; t3 = d[M_33];
    d[M_31]  = t1*s[M_11] + t2*s[M_21] + t3*s[M_31];
    d[M_32]  = t1*s[M_12] + t2*s[M_22] + t3*s[M_32];
    d[M_33]  = t1*s[M_13] + t2*s[M_23] + t3*s[M_33];
    d[M_34] += t1*s[M_14] + t2*s[M_24] + t3*s[M_34];
  }
  return *this;
}
#endif

//////////////////////////////////////////////////////////////////////////////
//
//  void TRANSFORM::Rotate(float32 x, float32 y, float32 z)
//
//////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Rotate(float32 x, float32 y, float32 z)
{
  // Performs M' = R(x,y,z).M
  // Build rotation matrix below in the secondary matrix
  //
  //    | CyCz        -CySz         Sy    0 | C = cosine
  //    |                                   | S = sine
  //    | SxSyCz+CxSz -SxSySz+CxCz  SxCy  0 | x = x-axis rotation
  //    |                                   | y = y-axis rotation
  //    |-CxSyCz-SxSz  CxSySz-SxCz  CxCy  0 | z = z-axis rotation
  //    |                                   |
  //    | 0            0            0     1 |
  //
  // Then we multiply the primary matrix into the above matrix
  // to get the desired overall transformation. We then simply
  // switch buffers. No copying :)

  rfloat32 *d = Secondary();

  {
    float32 Sx = sin(x);  float32 Sy = sin(y);  float32 Sz = sin(z);
    float32 Cx = cos(x);  float32 Cy = cos(y);  float32 Cz = cos(z);
    d[M_11] = Cy*Cz;
    d[M_12] = -(Cy*Sz);
    d[M_13] = Sy;
    //d[M_14] = 0;
    d[M_21] = Sx*Sy*Cz + Cx*Sz;
    d[M_22] = Cx*Cz - (Sx*Sy*Sz);
    d[M_23] = Sx*Cy;
    //d[M_24] = 0;
    d[M_31] = -(Cx*Sy*Cz + Sx*Sz);
    d[M_32] = Cx*Sy*Sz - (Sx*Cz);
    d[M_33] = Cx*Cy;
    //d[M_34] = 0;
  }

  {
    // Multiply by primary
    rfloat32 *s = matrix;
    rfloat32 t1 = d[M_11]; rfloat32 t2 = d[M_12]; rfloat32 t3 = d[M_13];
    d[M_11] = t1*s[M_11] + t2*s[M_21] + t3*s[M_31];
    d[M_12] = t1*s[M_12] + t2*s[M_22] + t3*s[M_32];
    d[M_13] = t1*s[M_13] + t2*s[M_23] + t3*s[M_33];
    d[M_14] = t1*s[M_14] + t2*s[M_24] + t3*s[M_34];
    t1 = d[M_21]; t2 = d[M_22]; t3 = d[M_23];
    d[M_21] = t1*s[M_11] + t2*s[M_21] + t3*s[M_31];
    d[M_22] = t1*s[M_12] + t2*s[M_22] + t3*s[M_32];
    d[M_23] = t1*s[M_13] + t2*s[M_23] + t3*s[M_33];
    d[M_24] = t1*s[M_14] + t2*s[M_24] + t3*s[M_34];
    t1 = d[M_31]; t2 = d[M_32]; t3 = d[M_33];
    d[M_31] = t1*s[M_11] + t2*s[M_21] + t3*s[M_31];
    d[M_32] = t1*s[M_12] + t2*s[M_22] + t3*s[M_32];
    d[M_33] = t1*s[M_13] + t2*s[M_23] + t3*s[M_33];
    d[M_34] = t1*s[M_14] + t2*s[M_24] + t3*s[M_34];
  }
  // switch buffers
  matrix = d;
}


//////////////////////////////////////////////////////////////////////////////
//
//  void TRANSFORM::Transform(VEC3D* v, size_t n)
//
//////////////////////////////////////////////////////////////////////////////

void TRANSFORM::Transform(VEC3D* v, size_t n)
{
  register float32* p=&(v->x);
  n++;
  while(--n)
  {
    rfloat32 *m = matrix;
    rfloat32 tx = p[0];
    rfloat32 ty = p[1];
    rfloat32 tz = p[2];
    *p++ = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
    *p++ = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
    *p++ = *(m++)*tx + *(m++)*ty + *(m++)*tz + *(m++);
  }
}

