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
#error You must include axon.hpp you kniggit!
#endif

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  VIEW
//
//  Handles ViewPort. Multiple VIEWs are possible, each with unique zoom/angles
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class VIEW : public xDBWIN, public xDISPLAYIO, protected AXON {

	friend class MAPCELL;

	private:
		float32 matrix1[12];
		float32 matrix2[12];

		VEC3D	prjOrigin;
		VEC3D	projected[6];
		VEC3D	boundTL;
		VEC3D	boundBR;
		float32 zoomLevel;
		float32 aspect;				// viewport aspect, 0.75 for most displays
		uint32	flags;
		sint16	viewAngle;		// in degrees
		sint16	viewPitch;		// in degrees
		uint16	vA;						// modulated viewAngle;
		uint16	vP;						// modulated viewPitch

		void		MouseEvent(sint32 x, sint32 y, sint32 buttons);
		void		KeyEvent(sint32 keyCode, bool state, sint32 ch);
		void		ExitEvent();

		// Window specific
		void		ResizeEvent();
		void		MoveEvent();

	public:
		enum {
			DRAW_BOUND			= 0x00000001,
			ZBUFFER_OK			= 0x00000002,
			SHOWMAP					= 0x00000004,
			SHOWMAPC				= 0x00000008,
			DETAIL					= 0x00000010,
			MODELS					= 0x00000020,
			WATER						= 0x00000040,
			STATS						= 0x00000080,
			TRANSFORM_MODEL	= 0x00000100,
			BOUNDS_PERP			= 0x00010000,
			CHANGED					= 0x00020000,
			RENDERED				= 0x00040000,
			BACKFILL				= 0x00080000,
			QUIT						= 0x01000000
		};

		sint32		Open(); // calculates aspect, binds, gets z buffer
		sint32		Close();
		uint32		State(uint32 r) { return r & flags; }
		void			Project();
		void			Display();
		void			FrameDone() { flags |= RENDERED; flags &= ~CHANGED; }

		void			HandleInput(sint32 maxEvents=8)		{ while (InputQueued() && --maxEvents) ; }

		// Camera
		void			Camera(float32 x, float32 y, float32 z, sint16 a, sint16 p);
		void			Move(float32 x, float32 y);
		void			Zoom(float32 z);
		float32		Zoom()					{ return zoomLevel; }
		void			Yaw(sint16 a);
		sint16		Yaw()						{ return viewAngle; }
		sint16		YawMod()				{ return 360-vA; }
		void			Pitch(sint16 p);
		sint16		Pitch()					{ return viewPitch; }

		VEC3D&		Origin()				{ return prjOrigin; }
		VEC3D&		TL()						{ return projected[0]; }
		VEC3D&		TR()						{ return projected[1]; }
		VEC3D&		BR()						{ return projected[2]; }
		VEC3D&		BL()						{ return projected[3]; }
		VEC3D&		DeltaUp()				{ return projected[4]; }
		VEC3D&		DeltaRight()		{ return projected[5]; }
		VEC3D&		BTL()						{ return boundTL; }
		VEC3D&		BBR()						{ return boundBR; }

		// Used by external rendering code
		float32		Aspect()				{ return aspect; }
		bool			PointInside(float32 x, float32 y);

		// Debug
		void			Dump();

		VIEW&			operator*=(const TRANSFORM& t);
		void			Transform(C3D* s, sysVERTEX* d, uint32 n);

	public:
		VIEW();
		VIEW(S_RECT, sint16 d, const char* title="Axonometric View");
		~VIEW();
};