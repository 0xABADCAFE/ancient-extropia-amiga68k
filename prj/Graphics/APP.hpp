/*

	Extropia System Library test code by Karlos, eXtropia Studios

*/

#ifndef _DRAWLIST_APP_DEMO_HPP
#define _XSYSTEM_APP_DEMO_HPP

#include <xSystem/GraphicsLib.hpp>

class APP {
	private:
		static xDBSCREEN* testWindow;
		static DRAWLIST		draw;
		static xTEXFONT		testFont;
		static char*			textBuffer;

	public:
		static sint32 Init();
		static sint32 Done();

		static void		Demo1();
		static void		Demo2();
		static void		Demo3();
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif