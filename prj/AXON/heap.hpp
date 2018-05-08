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
//  TEXTUREHEAP
//    This is basically a hashed map of a bunch of textures. The name of the texture is converted into a 32-bit hash that is
//  index linked to a texture. The first time we call a texture it will be loaded and initialised etc. Subsequent calls to the
//  same name will result in the existing texture being returned to us.
//
//  TO DO
//    For now, this is just a basic array implementation. Textures are not LRU tracked in any way so there is no expunge. In
//  future, a pool will be used that allows these things to be implemented, such that each texture has a use count. Whilst the
//  texture is in use, we never expunge. Once the use count falls to zero, the texture will be marked volatile such that it
//  can be expunged when we reach critical heap usage.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class TEXTUREHEAP {
	private:
		static xTEXTURE*	heap;
		static uint32*		keys;
		static sint32			index;
		static sint32			heapSize;

		// probably the case when initialising long lists of objects that we repeatedly use the
		// same texture over and over. We can use a sort of prediction that the next request is
		// the same as the previous. In theory :)

		static xTEXTURE*	lastTexture;
		static uint32			lastKey;
		static xTEXTURE*	FindByKey(uint32 key);
		static uint32			Key(const char* name);

	public:
		static xTEXTURE*	Find(const char* name);
		static sint32			Init(sint32 size);
		static sint32			Done();
		static xTEXTURE*	UsePPM(const char* name, uint32 alphagen = 0xFF000000);
		static xTEXTURE*	UseTex(const char* name, sint32 forceFmt = -1);
};

inline uint32 TEXTUREHEAP::Key(const char* name)
{
	uint8* p = (uint8*)name;
	uint32 r = 0;
	while (*p) r = (r<<1)^*p++; // BS C++ Lang, 3rdEd, 503
	return r;
}

inline xTEXTURE* TEXTUREHEAP::FindByKey(uint32 key)
{
	if (key==lastKey)
		return lastTexture;
	else
	{
		for (rsint32 i = 0; i <= index; i++)
			if (key==keys[i]) return &heap[i];
	}
	return 0;
}

inline xTEXTURE* TEXTUREHEAP::Find(const char* name)
{
	return FindByKey(Key(name));
}