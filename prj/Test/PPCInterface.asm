;// 68K Interface code to PPC C functions

	INCDIR		include:
	INCLUDE		powerpc/powerpc.i
	XREF			_PowerPCBase

;///////////////////////////////////////////////////////////////
;//
;// extern "C" void Normalize([d0] sint16 *v, [d1] sint32 num)
;//
;///////////////////////////////////////////////////////////////

	XDEF		_Normalize
_Normalize:
	RUNPOWERPC _NormalizePPC
	rts
