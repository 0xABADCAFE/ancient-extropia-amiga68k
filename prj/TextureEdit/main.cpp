/*

	Extropia System Library test code by Karlos, eXtropia Studios

*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "APP.hpp"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int main()
{
	if (APP::Init()!=OK)
		return 10;

	APP::Done();
	return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////
