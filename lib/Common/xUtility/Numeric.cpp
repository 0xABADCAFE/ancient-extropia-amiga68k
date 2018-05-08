//*****************************************************************//
//** Description:   xUtility library : numeric classes           **//
//** First Started: 2001-06-02                                   **//
//** Last Updated:  2001-06-02                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2000, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xUtility/Numeric.hpp>
#include <fstream.h> // Just for Dump()

#if XNUM_DATASIZE == 1024

#include XNUM_TABLE_SOURCE

void xNUM::Init()
{
	#ifdef X_VERBOSE
	cerr << "xNUM Debug build : " __DATE__ " at " __TIME__ "\n";
	#endif
}

#else

float32	xNUM::data[XNUM_DATASIZE+1]			= {0};
float32 xNUM::arcData[XNUM_DATASIZE+1]	= {0};
float32	xNUM::eFrac[XNUM_DATASIZE+1]		= {0};
float32	xNUM::eInt[E_RANGE]							= {0};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xNUM::Init()
{
	// Generate data for sin/asin/exp
	sint32 i;
	for (i=0; i<XNUM_DATASIZE; i++)
	{
		data[i]			= sin(i*DBL_PI/(2*XNUM_DATASIZE));
		arcData[i]	= asin(i/XNUM_DATASIZE);
		eFrac[i]		= exp(-i/XNUM_DATASIZE);
	}
	data[XNUM_DATASIZE]			= 1.0;
	eFrac[XNUM_DATASIZE]		= 1.0;
	arcData[XNUM_DATASIZE]	= DBL_PI/2;
	for (i=0; i < E_RANGE; i++)
	{
		eInt[i]			= exp(i+E_MIN_INT);
	}
	#ifdef X_DEBUG
	cerr << "xNUM Debug build : " __DATE__ " at " __TIME__ "\n";
	#endif
}

#endif // XNUM_DATASIZE == 1024

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xNUM::Done()
{
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef XNUM_HAND_OPTIMIZED

float32 xNUM::Sin(rfloat32 x)
{
	x *= (2*XNUM_DATASIZE/PI);
	ruint32 i = (uint32)x;
	x -= i;
	return (1.0F-x)*SinI(i) + x*SinI(i+1);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

float32 xNUM::Cos(rfloat32 x)
{
	x *= (2*XNUM_DATASIZE/PI);
	ruint32 i = (uint32)x;
	x -= i;
	return (1.0F-x)*CosI(i) + x*CosI(i+1);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

float32 xNUM::Tan(rfloat32 x)
{
	x *= (2*XNUM_DATASIZE/PI);
	ruint32 i = (uint32)x;
	x -= i;

	// Below is optimized to get each sin / cosine pair read together, which increases chance of cache hit. i2 holds cosine index

	if (i<XNUM_DATASIZE)
	{
		ruint32 i2 = XNUM_DATASIZE-i;
		return ( (1.0F-x)*data[i] + x*data[i+1] ) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
	}
	else if (i<(2*XNUM_DATASIZE))
	{
		ruint32 i2 = i-XNUM_DATASIZE; i = (2*XNUM_DATASIZE)-i;
		return ( -(1.0F-x)*data[i] - x*data[i+1] ) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
	}
	else if (i<(3*XNUM_DATASIZE))
	{
		ruint32 i2 = (3*XNUM_DATASIZE)-i; i -= (2*XNUM_DATASIZE);
		return ( (1.0F-x)*data[i] + x*data[i+1]) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
	}
	else if (i<(4*XNUM_DATASIZE))
	{
		ruint32 i2 = i-(3*XNUM_DATASIZE); i = (4*XNUM_DATASIZE)-i;
		return ( -(1.0F-x)*data[i] - x*data[i+1]) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
	}
	else
	{
		ruint32 i2 = (5*XNUM_DATASIZE)-i; i -= (4*XNUM_DATASIZE);
		return ( (1.0F-x)*data[i] + x*data[i+1]) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

float32 xNUM::ASin(rfloat32 x)
{
	x *= XNUM_DATASIZE;
	if (x<0F)
	{
		x = -x;
		ruint32 i = (x - 0.5F);
		x -= i;
		return -(1.0F-x)*arcData[i] - x*arcData[i+1];
	}
	else
	{
		ruint32 i = (x - 0.5F);
		x	-= i;
		return (1.0F-x)*arcData[i] + x*arcData[i+1];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

float32 xNUM::ACos(rfloat32 x)
{
	x *= XNUM_DATASIZE;
	if (x<0F)
	{
		x = -x;
		ruint32 i = (x - 0.5F);
		x -= i;
		return (PI/2) + (1.0F-x)*arcData[i] + x*arcData[i+1];
	}
	else
	{
		ruint32 i = (x - 0.5F);
		x	-= i;
		return (PI/2) - (1.0F-x)*arcData[i] - x*arcData[i+1];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

float32 xNUM::Exp(rfloat32 x)
{
	rsint32 i = (x+0.5F);
	x -= (i-1);
	x *= XNUM_DATASIZE;
	ruint32 i2 = (x-0.5F);	x -= i2;
	return eInt[i+(-E_MIN_INT)]*( (1.0F-x)*eFrac[i2] + x*eFrac[i2+1]);
}

#endif // XNUM_HAND_OPTIMIZED


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef XNUM_GENSOURCE

sint32 xNUM::GenTables(char* fileName)
{
	ofstream out(fileName);
	if (!out)
		return ERR_FILE_CREATE;

	out <<	"//*****************************************************************//\n"\
					"//** Description:   xUtility library : numeric class Data        **//\n"\
					"//** Author         Source auto generated via xNUM::Dump()       **//\n"\
					"//** Copyright:     (C)1998-2001, eXtropia Studios               **//\n"\
					"//**                Serkan YAZICI, Karl Churchill                **//\n"\
					"//**                All Rights Reserved.                         **//\n"\
					"//*****************************************************************//\n";

	out << "\n// Sine data[0...PI/2]\nfloat32 xNUM::data[XNUM_DATASIZE+2]= {";
	out.precision(10);
	out.setf(ios::fixed);
	for (sint32 i=0; i<XNUM_DATASIZE+1; i++)
	{
		if (i%8==0)
			out << "\n\t";
		out << sin(i*DBL_PI/(2*XNUM_DATASIZE)) << ", ";
	}
	out << sin((i-2)*DBL_PI/(2*XNUM_DATASIZE)) << "\n};\n";

	out << "\n// Arc Sine data[0...1]\nfloat32 xNUM::arcData[XNUM_DATASIZE+2] = {";
	for (i=0; i<XNUM_DATASIZE+1; i++)
	{
		if (i%8==0)
			out << "\n\t";
		out << asin((float64)i/XNUM_DATASIZE) << ", ";
	}
	out << DBL_PI/2 << "\n};\n";

	out << "\n// Fractional exponent data[-1...0]\nfloat32 xNUM::eFrac[XNUM_DATASIZE+2] = {";
	for (i=0; i<XNUM_DATASIZE+1; i++)
	{
		if (i%8==0)
			out << "\n\t";
		out << exp((float64)(i-XNUM_DATASIZE)/XNUM_DATASIZE) << ", ";
	}
	out << 1.0 << "\n};\n";

	out.unsetf(ios::fixed);
	out.setf(ios::scientific);
	out << "\n// Integer exponent data[" << E_MIN_INT <<"..." << E_RANGE+E_MIN_INT << "]\nfloat32 xNUM::eInt[E_RANGE] = {";
	for (i=0; i<E_RANGE; i++)
	{
		if (i%6==0)
			out << "\n\t";
		out << exp((float64)i+E_MIN_INT);
		if (i < E_RANGE-1)
			out << ", ";
	}
	out << "\n};\n";
	out.close();
	return OK;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xNUM::Test(ostream& out)
{
	out << "\nxNumeric/XNUM class test...\n";

	#define LOOPS 100000
	rfloat32 z = 2*DBL_PI/LOOPS;
	float32 a;
	xTIMER counter;
	sint32 loopTime;
	out << "\n\tBenchmarking loop body, " << LOOPS << " iterations...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=0; i < LOOPS; i++, x+=z)
		{
			a = x;
		}

		loopTime = counter.ElapsedSet();
		out << "Took " << loopTime << " ms\n";
	}

	out << "\n\tBenchmarking Standard Library sin()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=0; i < LOOPS; i++, x += z)
		{
			a = sin(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\n\tBenchmarking xNumeric Library xNUM::Sin()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=0; i < LOOPS; i++, x += z)
		{
			a = Sin(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\n\tBenchmarking xNumeric Library xNUM::SinQ()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=0; i < LOOPS; i++, x += z)
		{
			a = SinQ(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\n\tBenchmarking xNumeric Library xNUM::SinI()...";
	{
		rsint32 i;
		counter.Set();
		for (i=0; i < LOOPS; i++)
		{
			a = SinI(i&(XNUM_DATASIZE-1));
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	out << "\tBenchmarking Standard Library cos()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=0; i < LOOPS; i++, x += z)
		{
			a = cos(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\tBenchmarking xNumeric Library xNUM::Cos()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=0; i < LOOPS; i++, x += z)
		{
			a = Cos(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\tBenchmarking xNumeric Library xNUM::CosQ()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=0; i < LOOPS; i++, x += z)
		{
			a = CosQ(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\tBenchmarking xNumeric Library xNUM::CosI()...";
	{
		rsint32 i;
		counter.Set();
		for (i=0; i < LOOPS; i++)
		{
			a = CosI(i&(XNUM_DATASIZE-1));
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	out << "\tBenchmarking Standard Library tan()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=0; i < LOOPS; i++, x += z)
		{
			a = tan(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\tBenchmarking xNumeric Library xNUM::Tan()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=0; i < LOOPS; i++, x += z)
		{
			a = Tan(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\tBenchmarking xNumeric Library xNUM::TanQ()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=0; i < LOOPS; i++, x += z)
		{
			a = TanQ(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\tBenchmarking xNumeric Library xNUM::TanI()...";
	{
		rsint32 i;
		counter.Set();
		for (i=0; i < LOOPS; i++)
		{
			a = TanI(i&(XNUM_DATASIZE-1));
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	z = 2/LOOPS;

	out << "\n\tBenchmarking Standard Library asin()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=-1.0; i < LOOPS; i++, x += z)
		{
			a = asin(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\n\tBenchmarking xNumeric Library xNUM::ASin()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=-1.0; i < LOOPS; i++, x += z)
		{
			a = ASin(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\n\tBenchmarking xNumeric Library xNUM::ASinQ()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=-1.0; i < LOOPS; i++, x += z)
		{
			a = ASinQ(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	out << "\tBenchmarking Standard Library acos()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=-1.0; i < LOOPS; i++, x += z)
		{
			a = acos(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\tBenchmarking xNumeric Library xNUM::ACos()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=-1.0; i < LOOPS; i++, x += z)
		{
			a = ACos(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\tBenchmarking xNumeric Library xNUM::ACosQ()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=-1.0; i < LOOPS; i++, x += z)
		{
			a = ACosQ(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	out << "\tBenchmarking Standard Library atan()...";
	{
		rfloat32 x;
		rsint32 i;
		counter.Set();
		for (i=0, x=-1.0; i < LOOPS; i++, x += z)
		{
			a = atan(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	z = 70.0/LOOPS;

	out << "\n\tBenchmarking Standard Library exp()...";
	{
		rfloat32 x=-35;
		counter.Set();
		for (rsint32 i=0; i < LOOPS; i++, x += z)
		{
			a = exp(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}

	out << "\tBenchmarking xNUM::Exp()...";
	{
		rfloat32 x=-35;
		counter.Set();
		for (rsint32 i=0; i < LOOPS; i++, x += z)
		{
			a = xNUM::Exp(x);
		}

		sint32 t = counter.ElapsedSet()-loopTime;
		out << "Took " << t << " ms, a = " << a << "\n";
	}


/*
	#undef LOOPS
	#define LOOPS 500
	z = PI/(2*LOOPS);

	out << "\n\tPerforimg error comparison for sine...\n";
	{
		rfloat32 x, s, d1, d2;
		rsint32 i;
		for (i=0, x=0; i < LOOPS; i++, x += z)
		{
			s = sin(x);
			d1 = 100*(xNUM::SinQ(x) - s);
			d2 = 100*(xNUM::Sin(x) - s);
			if (d1 > 0.1 || d2 > 0.0001)
				out << "x = " << x << ", i = " << i << ", sin(x) = " << s << ", err SinQ(x) = " << d1 << "%, err Sin(x) = " << d2 << "%\n";
		}
	}

	out << "\n\tPerforimg error comparison for cosine...\n";
	{
		rfloat32 x, s, d1, d2;
		rsint32 i;
		for (i=0, x=0; i < LOOPS; i++, x += z)
		{
			s = cos(x);
			d1 = 100*(xNUM::CosQ(x) - s);
			d2 = 100*(xNUM::Cos(x) - s);
			if (d1 > 0.1 || d2 > 0.0001)
				out << "x = " << x << ", i = " << i << ", cos(x) = " << s << ", err CosQ(x) = " << d1 << "%, err Cos(x) = " << d2 << "%\n";
		}
	}

	out << "\n\tPerforimg error comparison for tangent...\n";
	{
		rfloat32 x, s, d1;
		rsint32 i;
		for (i=0, x=0; i < LOOPS; i++, x += z)
		{
			s = tan(x);
			d1 = 100*(xNUM::Tan(x) - s);
			if (d1 > 0.1)
				out << "x = " << x << ", i = " << i << ", tan(x) = " << s << ", err Tan(x) = " << d1 << "%\n";
		}
	}
*/
	out << "\nAll done\n";

}

#endif // XNUM_GENSOURCE
