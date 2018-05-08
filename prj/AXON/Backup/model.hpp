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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class MODEL : protected AXON {

	protected:
		VEC3D o;

	public:
		virtual void Place(VEC3D& o, FLOAT32 s, SINT16 x, SINT16 y, SINT16 z) = 0;
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
		void Place(VEC3D& o, FLOAT32 s, SINT16 x=0, SINT16 y=0, SINT16 z=0);
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
		static SINT32		count;
		static xTEXTURE texture;
		static C3D			points[30];

	private:
		sysTEXTURE*			tex;
		sysVERTEX*			pj;
		C3D							pt[30];

	public:
		void Place(VEC3D& o, FLOAT32 s, SINT16 x=0, SINT16 y=0, SINT16 z=0);
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
		static SINT32		count;
		static xTEXTURE texture;
		static C3D			points[];

	private:
		sysTEXTURE*			tex;
		sysVERTEX*			pj;
		C3D							pt[6];

	public:
		void Place(VEC3D& o, FLOAT32 s, SINT16 x=0, SINT16 y=0, SINT16 z=0);
		void Render(VIEW& view);

	public:
		BUILDING();
		~BUILDING();
};