//*****************************************************************//
//** Description:   xUtility library : Ranged Integers           **//
//** First Started: 2001-03-15                                   **//
//** Last Updated:  2001-03-15                                   **//
//** Author         Serkan YAZICI                                **//
//** Copyright:     (C)1998-2000, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _XUTILITY_RANGED_INTS_HPP
#define _XUTILITY_RANGED_INTS_HPP

#include <xBase.hpp>


//-- Protected Integer for Memory Pokers (32 Bit, Signed only)
class XINT32 {
  int val;
  int old;
public:   //Operators
  XINT32():val(0),old(0){ }
  XINT32(int i)         { val=(i<<1)+1; old=0; }
  void operator=(int i) { val=(i<<1)+1; }
  operator int()        { return (val-1)>>1; }
  int operator()()      { return (val-1)>>1; }
  int operator++()      { val+=2; return (val-1)>>1; }   //prefix
  int operator++(int)   { val+=2; return (val-3)>>1; }   //postfix
  int operator--()      { val-=2; return (val-1)>>1; }   //prefix
  int operator--(int)   { val-=2; return (val+1)>>1; }   //postfix
  int operator+=(int i) { val+=i<<1; return (val-1)>>1; }
  int operator-=(int i) { val-=i<<1; return (val-1)>>1; }
  int operator*=(int i) { val--; val*=i; val++; return (val-1)>>1; }
  int operator/=(int i) { val/=i; val+=!(val&1); return (val-1)>>1; }
public:   //Expressions
  int operator==(int i) { return ((val-1)>>1)==i; }
  int operator!=(int i) { return ((val-1)>>1)!=i; }
  int operator>(int i)  { return ((val-1)>>1)>i; }
  int operator<(int i)  { return ((val-1)>>1)<i; }
  int operator>=(int i) { return ((val-1)>>1)>=i; }
  int operator<=(int i) { return ((val-1)>>1)<=i; }
public:   //Utility Methods
  int Actual()          { return val; }
  void SetActual(int i) { val=i; }
  int hasChanged()      { if(val!=old) { old=val; return 1; } return 0; }
};


//-- Integer with inlined range checking: LINT (Limited Integer)
template <class T,int min,int max> class LINT {
  T val;
public:    //Operators
  LINT() : val(min)     { }
  LINT(int i)           { (i>min)?((i<max)?(val=i):(val=max)):(val=min); }
  void operator=(int i) { (i>min)?((i<max)?(val=i):(val=max)):(val=min); }
  operator T()          { return val; }
  T operator()()        { return val; }
  T operator++()        { return (val<max)?(++val):(val=max); }   //++prefix
  T operator++(int)     { return (val<max)?(val++):(val=max); }   //postfix++
  T operator--()        { return (val>min)?(--val):(val=min); }   //--prefix
  T operator--(int)     { return (val>min)?(val--):(val=min); }   //postfix--
  T operator+=(int i)   { return (val+i<max)?(val+=i):(val=max); }
  T operator-=(int i)   { return (val>min+i)?(val-=i):(val=min); }
  T operator*=(int i)   { return ((long)val*i<max)?(val*=i):(val=max); }
  T operator<<=(int i)  { return ((long)(val<<i)<max)?(val<<=i):(val=max); }
  T operator/=(int i)   { return ((long)val/i>min)?(val/=i):(val=min); }
  T operator>>=(int i)  { return ((long)(val>>i)>min)?(val>>=i):(val=min); }
};

//-- Ranged (Limited) Integer Types
#define LUINT8(min,max)   LINT<uint8,min,max>
#define LUINT16(min,max)  LINT<uint16,min,max>
#define LUINT32(min,max)  LINT<uint32,min,max>
#define LUINT64(min,max)  LINT<uint64,min,max>
#define LSINT8(min,max)   LINT<sint8,min,max>
#define LSINT16(min,max)  LINT<sint16,min,max>
#define LSINT32(min,max)  LINT<sint32,min,max>
#define LSINT64(min,max)  LINT<sint64,min,max>

#endif // _XUTILITY_RANGED_INTS_HPP
