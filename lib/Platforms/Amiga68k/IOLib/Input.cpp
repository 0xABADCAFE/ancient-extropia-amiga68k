//*****************************************************************//
//** Description:   extropia IO classes                          **//
//**                AmigaOS/68K 3.x level implementation         **//
//** First Started: 2000-12-24                                   **//
//** Last Updated:  2002-05-18                                   **//
//** Author         K. Churchill                                 **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xSystem/IOLib.hpp>

LIBRARY*  KeyMapBase   = 0;

sint32  xKEY::useCount = 0;

xKEY::xKEY()
{
  if (0 == useCount++)
  {
    KeyMapBase = OpenLibrary("keymap.library", 37);
    if (!KeyMapBase)
      useCount = 0;
  }
}

xKEY::~xKEY()
{
  if (--useCount == 0)
  {
    if (KeyMapBase)
    {
      CloseLibrary(KeyMapBase);
      KeyMapBase = 0;
    }
  }
  if (useCount<0)
    useCount = 0;
}

sint32  xKEY::KeyToChar(IntuiMessage* m)
{
  if (!m || ((m->Code & 0x7F) > SPACE))
    return 0;
  else
  {
    InputEvent  inputEvent = {
      0,
      IECLASS_RAWKEY,
      0,
      m->Code,
      m->Qualifier
    };
    inputEvent.ie_EventAddress = *((uint8**)(m->IAddress));
    char mapped[2] = "";
    MapRawKey(&inputEvent, mapped, 2, 0);
    return (sint32)mapped[0];
  }
}