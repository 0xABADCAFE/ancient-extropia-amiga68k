//*****************************************************************//
//** Description:   Axonometric Projector, AmigaOS/68K version   **//
//** First Started:                                              **//
//** Last Updated:                                               **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xBase.hpp>

#include "3DBase.hpp"

int main()
{
	if (xBASELIB::Init()!=OK)
	{
		cout << "xBASE library initialisation failed\n";
		return 10;
	}

	cout << "Hello World\n";

	TRANSFORM test;
	test.Translate(-0.5, -0.5, 0);
	test.Rotate(90,0,0);
	test.Scale(100,100,1);
	test.Translate(50,50, 0);

	VEC3D point1(0.5,0.5,0.6);

	cout << "point1.x = " << point1.x << "\n";
	cout << "point1.y = " << point1.y << "\n";
	cout << "point1.z = " << point1.z << "\n";

	point1*=test;

	cout.setf(ios::fixed);

	cout << "point1.x = " << point1.x << "\n";
	cout << "point1.y = " << point1.y << "\n";
	cout << "point1.z = " << point1.z << "\n";

	xBASELIB::Done();
	return 0;
}
/*
int CompareFloat(const void* v1, const void* v2)
{
	FLOAT32 t = *((FLOAT32*)v1) - *((FLOAT32*)v2);
	if ((fabs(t)<0.00001F))
		return 0;
	else if (t>0F)
		return 1;
	else
		return -1;
}

#define D2R PI/180.0F

FLOAT32 SinF1(FLOAT32 x)
{
	return (FLOAT32)sin(x*D2R);
}

FLOAT32 CosF1(FLOAT32 x)
{
	return (FLOAT32)cos(x*D2R);
}
#undef D2R


void TestSin(SINT32 samples)
{
	cout << "Sin() Estimation Test\n";
	FLOAT64 err1 = 0;
	FLOAT64 err2 = 0;
	SINT32	totWorse = 0;
	static FLOAT32 worseVal[500] = {0};
	for (SINT32 i=0; i < samples; i++)
	{
		FLOAT32 t = 0.1F + (89.9F*(FLOAT32)rand())/RAND_MAX;
		FLOAT32 t0 = SinF1(t);
		FLOAT32 t1 = fabs(1F-(QTRIG::SinF(t)/t0));
		FLOAT32 t2 = fabs(1F-(QTRIG::SinF2(t)/t0));
		if (t2>t1)
		{
			worseVal[totWorse] = t - (SINT32)t;
			totWorse++;
		}
		err1 += (FLOAT64)t1;
		err2 += (FLOAT64)t2;
	}
	qsort(worseVal, totWorse, sizeof(FLOAT32), CompareFloat);
	err1 /= (FLOAT64)i;
	err2 /= (FLOAT64)i;
	cout << "Sampled " << i << " points,\terr t1 = " << err1 << ",\terr t2 = " << err2 << ",\tt2/t1 = " << err2/err1 << "\n";
	cout << "Worse t2 estimations : " << totWorse << ", == " << 100F*(FLOAT32)totWorse/(FLOAT32)samples << "%\n";
	for (i=0; i < totWorse; i++)
	{
		cout << "Worse : " << worseVal[i] << "\n";
	}
}

void TestCos(SINT32 samples)
{
	cout << "Cos() Estimation Test\n";
	FLOAT64 err1 = 0;
	FLOAT64 err2 = 0;
	SINT32	totWorse = 0;
	static FLOAT32 worseVal[500] = {0};
	for (SINT32 i=0; i < samples; i++)
	{
		FLOAT32 t = 0.1F + (89.9F*(FLOAT32)rand())/RAND_MAX;
		FLOAT32 t0 = CosF1(t);
		FLOAT32 t1 = fabs(1F-(QTRIG::CosF(t)/t0));
		FLOAT32 t2 = fabs(1F-(QTRIG::CosF2(t)/t0));
		if (t2>t1)
		{
			worseVal[totWorse] = t - (SINT32)t;
			totWorse++;
		}
		err1 += (FLOAT64)t1;
		err2 += (FLOAT64)t2;
	}
	qsort(worseVal, totWorse, sizeof(FLOAT32), CompareFloat);
	err1 /= (FLOAT64)i;
	err2 /= (FLOAT64)i;
	cout << "Sampled " << i << " points,\terr t1 = " << err1 << ",\terr t2 = " << err2 << ",\tt2/t1 = " << err2/err1 << "\n";
	cout << "Worse t2 estimations : " << totWorse << ", == " << 100F*(FLOAT32)totWorse/(FLOAT32)samples << "%\n";
	for (i=0; i < totWorse; i++)
	{
		cout << "Worse : " << worseVal[i] << "\n";
	}
}
*/