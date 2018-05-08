//*****************************************************************//
//** Description:   OS Layer classes, AmigaOS/68K version        **//
//** First Started: 2001-03-08                                   **//
//** Last Updated:  2001-09-06                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xSystem/ServiceLib.hpp>

#define CASTNODE(x) ((Node*)((MinNode*)(x)))
#define CASTLIST(x) ((List*)((MinList*)(x)))


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  xCHAINABLE::
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


sint32 xCHAINABLE::LinkFront(xCHAIN* c)
{
  if (chain)  return ERR_RSC_LOCKED;  // in chain already
  if (!c)     return ERR_PTR_ZERO;    // no chain passed
  AddHead(CASTLIST(c), CASTNODE(this));
  c->items++; chain = c;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xCHAINABLE::LinkEnd(xCHAIN* c)
{
  if (chain)  return ERR_RSC_LOCKED;
  if (!c)     return ERR_PTR_ZERO;
  AddTail(CASTLIST(c), CASTNODE(this));
  c->items++; chain = c;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xCHAINABLE::LinkBefore(xCHAIN* c, xCHAINABLE* x)
{
  if (chain)          return ERR_RSC_LOCKED;
  if (!c || !x)       return ERR_PTR_ZERO;          // no chain or before link
  if (x==this)        return ERR_PTR_USED;          // we are link !!
  if (x->chain != c)  return ERR_PTR_INCONSISTENT;  // before link is in different chain

  Insert(CASTLIST(c), CASTNODE(this), CASTNODE(x));
  c->items++; chain = c;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xCHAINABLE::UnLink()
{
  if (!chain) return ERR_RSC;
  ::Remove(CASTNODE(this));
  chain->items--; chain = 0;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#undef CASTNODE
#undef CASTLIST

