/*

	Extropia System Library test code by Karlos, eXtropia Studios

*/

#ifndef _TEXTURE_EDIT_APP_HPP
#define _TEXTURE_EDIT_APP_HPP

#include <xBase.hpp>
#include <xSystem/GraphicsLib.hpp>

class APP {
	private:
		static xSCREEN* 	testWindow;
		static DRAWLIST*	draw;
		static xTEXFONT*	testFont;
		static char*			textBuffer;

		static xTEXSURF*	source;
		static xTEXSURF*	dest;

	public:
		static sint32 Init();
		static sint32 Done();
		static void DrawGUI();
		static void TestSprite();
};

/*
class APPCONTEXT : public xSCREEN, public xDISPLAYIO {

	protected:
		void		MouseEvent(sint32 x, sint32 y, sint32 buttons);
		void		KeyEvent(sint32 keyCode, bool state, sint32 ch);

	public:
		sint32 Open();
		sint32 Close();
};
*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif