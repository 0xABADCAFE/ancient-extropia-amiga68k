
; Storm C Compiler
; Mendoza:Extropia/eXtropia/lib/Platforms/Amiga68k/HandOptimized/sysBaseO.cpp
	mc68030
	mc68881
	XREF	Zero__MEM__PvUi
	XREF	Set__MEM__PviUi
	XREF	_system
	XREF	_std__in
	XREF	_std__out
	XREF	_std__err
	XREF	_st
	XREF	_gxSt
	XREF	_numStartArgs__xBASELIB
	XREF	_startArgs__xBASELIB
	XREF	_SysBase
	XREF	_IntuitionBase
	XREF	_DOSBase
	XREF	_PowerPCBase
	XREF	_sysData__sysBASELIB
	XREF	_msgbuff__sysBASELIB
	XREF	_main__sysBASELIB
	XREF	_allocated__MEM
	XREF	_totSize__MEM
	XREF	_nextFree__MEM
	XREF	_cnt__MEM
	XREF	_maxAllocs__MEM

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "Swap16__MEM__r8PUsr9PUsr0Ui:0",CODE


;void MEM::Swap16(REGP(0) uint16* from, REGP(1) uint16* to, REGI(0) s
	XDEF	Swap16__MEM__r8PUsr9PUsr0Ui
Swap16__MEM__r8PUsr9PUsr0Ui
	movem.l	d2/d3/a2,-(a7)
L284
;	if (count <= 0)
	tst.l	d0
	bne.b	L286
L285
;		return;
	movem.l	(a7)+,d2/d3/a2
	rts
L286
;	if (count > 1)
	cmp.l	#1,d0
	bls	L304
L287
;		rsint32 n = count>>5;
	move.l	d0,d1
	moveq	#5,d2
	lsr.l	d2,d1
;		switch ((count>>1) & 15)
	move.l	d0,d2
	moveq	#1,d3
	lsr.l	d3,d2
	and.l	#$F,d2
	cmp.l	#$F,d2
	bhi.b	L304
	move.l	L307(pc,d2.l*4),a2
	jmp	(a2)
L307
	dc.l	L288
	dc.l	L303
	dc.l	L302
	dc.l	L301
	dc.l	L300
	dc.l	L299
	dc.l	L298
	dc.l	L297
	dc.l	L296
	dc.l	L295
	dc.l	L294
	dc.l	L293
	dc.l	L292
	dc.l	L291
	dc.l	L290
	dc.l	L289
;			
L288
;	*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L289
;			case 15:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L290
;			case 14:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L291
;			case 13:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L292
;			case 12:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L293
;			case 11:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L294
;			case 10:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L295
;			case 9:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L296
;			case 8:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L297
;			case 7:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L298
;			case 6:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L299
;			case 5:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L300
;			case 4:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L301
;			case 3:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L302
;			case 2:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L303
;			case 1:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
	subq.l	#1,d1
	cmp.l	#0,d1
	bgt.b	L288
L304
;	if (count & 1)
	and.l	#1,d0
	beq.b	L306
L305
;		*((uint16*)to)++ = *((uint16*)from)++;
	move.w	(a0),(a1)
L306
	movem.l	(a7)+,d2/d3/a2
	rts

	SECTION "Swap32__MEM__r8PUjr9PUjr0Ui:0",CODE


;void MEM::Swap32(REGP(0) uint32* from, REGP(1) uint32* to, REGI(0) s
	XDEF	Swap32__MEM__r8PUjr9PUjr0Ui
Swap32__MEM__r8PUjr9PUjr0Ui
	movem.l	d2/a2,-(a7)
L308
;	if (count <= 0)
	tst.l	d0
	bne.b	L310
L309
;		return;
	movem.l	(a7)+,d2/a2
	rts
L310
;	rsint32 n = count>>4;
	move.l	d0,d1
	moveq	#4,d2
	lsr.l	d2,d1
;	switch (count & 15)
	and.l	#$F,d0
	cmp.l	#$F,d0
	bhi.b	L327
	move.l	L328(pc,d0.l*4),a2
	jmp	(a2)
L328
	dc.l	L311
	dc.l	L326
	dc.l	L325
	dc.l	L324
	dc.l	L323
	dc.l	L322
	dc.l	L321
	dc.l	L320
	dc.l	L319
	dc.l	L318
	dc.l	L317
	dc.l	L316
	dc.l	L315
	dc.l	L314
	dc.l	L313
	dc.l	L312
;		
L311
;	*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L312
;		case 15:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L313
;		case 14:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L314
;		case 13:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L315
;		case 12:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L316
;		case 11:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L317
;		case 10:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L318
;		case 9:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L319
;		case 8:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L320
;		case 7:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L321
;		case 6:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L322
;		case 5:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L323
;		case 4:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L324
;		case 3:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L325
;		case 2:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L326
;		case 1:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
	subq.l	#1,d1
	cmp.l	#0,d1
	bgt.b	L311
L327
	movem.l	(a7)+,d2/a2
	rts

	SECTION "Swap64__MEM__r8PUlr9PUlr0Ui:0",CODE


;void MEM::Swap64(REGP(0) uint64* from, REGP(1) uint64* to, REGI(0) s
	XDEF	Swap64__MEM__r8PUlr9PUlr0Ui
Swap64__MEM__r8PUlr9PUlr0Ui
	movem.l	d2/a2,-(a7)
L329
;	if (count <= 0)
	tst.l	d0
	bne.b	L331
L330
;		return;
	movem.l	(a7)+,d2/a2
	rts
L331
;	rsint32 n = count>>3;
	move.l	d0,d1
	moveq	#3,d2
	lsr.l	d2,d1
;	switch (count & 7)
	and.l	#7,d0
	cmp.l	#7,d0
	bhi.b	L340
	move.l	L341(pc,d0.l*4),a2
	jmp	(a2)
L341
	dc.l	L332
	dc.l	L339
	dc.l	L338
	dc.l	L337
	dc.l	L336
	dc.l	L335
	dc.l	L334
	dc.l	L333
;		
L332
;	*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L333
;		case 7:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L334
;		case 6:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L335
;		case 5:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L336
;		case 4:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L337
;		case 3:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L338
;		case 2:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L339
;		case 1:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
	subq.l	#1,d1
	cmp.l	#0,d1
	bgt.b	L332
L340
	movem.l	(a7)+,d2/a2
	rts

	SECTION "Copy8__MEM__r8PUcr9PUcr0Ui:0",CODE


;void MEM::Copy8(REGP(0) uint8* from, REGP(1) uint8* to, REGI(0) size
	XDEF	Copy8__MEM__r8PUcr9PUcr0Ui
Copy8__MEM__r8PUcr9PUcr0Ui
	movem.l	d2/d3/a2/a6,-(a7)
L342
;	if (count <= 0)
	tst.l	d0
	bne.b	L344
L343
;		return;
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L344
;	if (((uint32)from|(uint32)to) & 1)
	move.l	a0,d1
	move.l	a1,d2
	or.l	d2,d1
	and.l	#1,d1
	beq.b	L346
L345
;		CopyMem(from, to, count);
	move.l	_SysBase,a6
	jsr	-$270(a6)
;		return;
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L346
;	if (count > 3)
	cmp.l	#3,d0
	bls	L364
L347
;		rsint32 n = count>>6;
	move.l	d0,d1
	moveq	#6,d2
	lsr.l	d2,d1
;		switch ((count>>2) & 15)
	move.l	d0,d2
	moveq	#2,d3
	lsr.l	d3,d2
	and.l	#$F,d2
	cmp.l	#$F,d2
	bhi.b	L364
	move.l	L369(pc,d2.l*4),a2
	jmp	(a2)
L369
	dc.l	L348
	dc.l	L363
	dc.l	L362
	dc.l	L361
	dc.l	L360
	dc.l	L359
	dc.l	L358
	dc.l	L357
	dc.l	L356
	dc.l	L355
	dc.l	L354
	dc.l	L353
	dc.l	L352
	dc.l	L351
	dc.l	L350
	dc.l	L349
;			
L348
;	*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L349
;			case 15:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L350
;			case 14:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L351
;			case 13:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L352
;			case 12:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L353
;			case 11:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L354
;			case 10:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L355
;			case 9:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L356
;			case 8:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L357
;			case 7:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L358
;			case 6:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L359
;			case 5:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L360
;			case 4:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L361
;			case 3:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L362
;			case 2:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L363
;			case 1:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
	subq.l	#1,d1
	cmp.l	#0,d1
	bgt.b	L348
L364
;	switch (count & 3)
	and.l	#3,d0
	cmp.l	#2,d0
	beq.b	L366
	bhi.b	L370
	cmp.l	#0,d0
	beq.b	L368
	cmp.l	#1,d0
	beq.b	L367
	bra.b	L368
L370
	cmp.l	#3,d0
	beq.b	L365
	bra.b	L368
;		
L365
;		case 3: *to++ = *from++;
	move.b	(a0)+,(a1)+
;		
L366
;		case 2: *to++ = *from++;
	move.b	(a0)+,(a1)+
;		
L367
;		case 1: *to++ = *from++;
	move.b	(a0),(a1)
;		
L368
	movem.l	(a7)+,d2/d3/a2/a6
	rts

	SECTION "Copy16__MEM__r8PUsr9PUsr0Ui:0",CODE


;void MEM::Copy16(REGP(0) uint16* from, REGP(1) uint16* to, REGI(0) s
	XDEF	Copy16__MEM__r8PUsr9PUsr0Ui
Copy16__MEM__r8PUsr9PUsr0Ui
	movem.l	d2/d3/a2,-(a7)
L371
;	if (count <= 0)
	tst.l	d0
	bne.b	L373
L372
;		return;
	movem.l	(a7)+,d2/d3/a2
	rts
L373
;	if (count > 1)
	cmp.l	#1,d0
	bls	L391
L374
;		rsint32 n = count>>5;
	move.l	d0,d1
	moveq	#5,d2
	lsr.l	d2,d1
;		switch ((count>>1) & 15)
	move.l	d0,d2
	moveq	#1,d3
	lsr.l	d3,d2
	and.l	#$F,d2
	cmp.l	#$F,d2
	bhi.b	L391
	move.l	L394(pc,d2.l*4),a2
	jmp	(a2)
L394
	dc.l	L375
	dc.l	L390
	dc.l	L389
	dc.l	L388
	dc.l	L387
	dc.l	L386
	dc.l	L385
	dc.l	L384
	dc.l	L383
	dc.l	L382
	dc.l	L381
	dc.l	L380
	dc.l	L379
	dc.l	L378
	dc.l	L377
	dc.l	L376
;			
L375
;	*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L376
;			case 15:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L377
;			case 14:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L378
;			case 13:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L379
;			case 12:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L380
;			case 11:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L381
;			case 10:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L382
;			case 9:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L383
;			case 8:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L384
;			case 7:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L385
;			case 6:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L386
;			case 5:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L387
;			case 4:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L388
;			case 3:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L389
;			case 2:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;			
L390
;			case 1:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
	subq.l	#1,d1
	cmp.l	#0,d1
	bgt.b	L375
L391
;	if (count & 1)
	and.l	#1,d0
	beq.b	L393
L392
;		*((uint16*)to)++ = *((uint16*)from)++;
	move.w	(a0),(a1)
L393
	movem.l	(a7)+,d2/d3/a2
	rts

	SECTION "Copy32__MEM__r8PUjr9PUjr0Ui:0",CODE


;void MEM::Copy32(REGP(0) uint32* from, REGP(1) uint32* to, REGI(0) s
	XDEF	Copy32__MEM__r8PUjr9PUjr0Ui
Copy32__MEM__r8PUjr9PUjr0Ui
	movem.l	d2/a2,-(a7)
L395
;	if (count <= 0)
	tst.l	d0
	bne.b	L397
L396
;		return;
	movem.l	(a7)+,d2/a2
	rts
L397
;	rsint32 n = count>>4;
	move.l	d0,d1
	moveq	#4,d2
	lsr.l	d2,d1
;	switch (count & 15)
	and.l	#$F,d0
	cmp.l	#$F,d0
	bhi.b	L414
	move.l	L415(pc,d0.l*4),a2
	jmp	(a2)
L415
	dc.l	L398
	dc.l	L413
	dc.l	L412
	dc.l	L411
	dc.l	L410
	dc.l	L409
	dc.l	L408
	dc.l	L407
	dc.l	L406
	dc.l	L405
	dc.l	L404
	dc.l	L403
	dc.l	L402
	dc.l	L401
	dc.l	L400
	dc.l	L399
;		
L398
;	*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L399
;		case 15:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L400
;		case 14:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L401
;		case 13:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L402
;		case 12:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L403
;		case 11:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L404
;		case 10:			*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L405
;		case 9:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L406
;		case 8:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L407
;		case 7:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L408
;		case 6:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L409
;		case 5:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L410
;		case 4:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L411
;		case 3:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L412
;		case 2:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L413
;		case 1:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
	subq.l	#1,d1
	cmp.l	#0,d1
	bgt.b	L398
L414
	movem.l	(a7)+,d2/a2
	rts

	SECTION "Copy64__MEM__r8PUlr9PUlr0Ui:0",CODE


;void MEM::Copy64(REGP(0) uint64* from, REGP(1) uint64* to, REGI(0) s
	XDEF	Copy64__MEM__r8PUlr9PUlr0Ui
Copy64__MEM__r8PUlr9PUlr0Ui
	movem.l	d2/a2,-(a7)
L416
;	if (count <= 0)
	tst.l	d0
	bne.b	L418
L417
;		return;
	movem.l	(a7)+,d2/a2
	rts
L418
;	rsint32 n = count>>3;
	move.l	d0,d1
	moveq	#3,d2
	lsr.l	d2,d1
;	switch (count & 7)
	and.l	#7,d0
	cmp.l	#7,d0
	bhi.b	L427
	move.l	L428(pc,d0.l*4),a2
	jmp	(a2)
L428
	dc.l	L419
	dc.l	L426
	dc.l	L425
	dc.l	L424
	dc.l	L423
	dc.l	L422
	dc.l	L421
	dc.l	L420
;		
L419
;	*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L420
;		case 7:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L421
;		case 6:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L422
;		case 5:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L423
;		case 4:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L424
;		case 3:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L425
;		case 2:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;		
L426
;		case 1:				*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
;									*((uint32*)to)++ = *((uint32*)from)++;
	move.l	(a0)+,(a1)+
	subq.l	#1,d1
	cmp.l	#0,d1
	bgt.b	L419
L427
	movem.l	(a7)+,d2/a2
	rts

	SECTION "Zero8__MEM__r8PUcr0Ui:0",CODE


;void MEM::Zero8(REGP(0) uint8* to, REGI(0) size_t count)
	XDEF	Zero8__MEM__r8PUcr0Ui
Zero8__MEM__r8PUcr0Ui
	movem.l	d2/d3,-(a7)
L429
;	if (count <= 0)
	tst.l	d0
	bne.b	L431
L430
;		return;
	movem.l	(a7)+,d2/d3
	rts
L431
;	if ((uint32)to & 1)
	move.l	a0,d1
	and.l	#1,d1
	beq.b	L433
L432
;		MEM::Zero(to, count);
	move.l	d0,-(a7)
	move.l	a0,-(a7)
	jsr	Zero__MEM__PvUi
	addq.w	#$8,a7
;		return;
	movem.l	(a7)+,d2/d3
	rts
L433
;	if (count > 3)
	cmp.l	#3,d0
	bls	L451
L434
;		rsint32 n = count>>6;
	move.l	d0,d1
	moveq	#6,d2
	lsr.l	d2,d1
;		switch ((count>>2) & 15)
	move.l	d0,d2
	moveq	#2,d3
	lsr.l	d3,d2
	and.l	#$F,d2
	cmp.l	#$F,d2
	bhi.b	L451
	move.l	L456(pc,d2.l*4),a1
	jmp	(a1)
L456
	dc.l	L435
	dc.l	L450
	dc.l	L449
	dc.l	L448
	dc.l	L447
	dc.l	L446
	dc.l	L445
	dc.l	L444
	dc.l	L443
	dc.l	L442
	dc.l	L441
	dc.l	L440
	dc.l	L439
	dc.l	L438
	dc.l	L437
	dc.l	L436
;			
L435
;	*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L436
;			case 15:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L437
;			case 14:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L438
;			case 13:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L439
;			case 12:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L440
;			case 11:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L441
;			case 10:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L442
;			case 9:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L443
;			case 8:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L444
;			case 7:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L445
;			case 6:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L446
;			case 5:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L447
;			case 4:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L448
;			case 3:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L449
;			case 2:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L450
;			case 1:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
	subq.l	#1,d1
	cmp.l	#0,d1
	bgt.b	L435
L451
;	switch (count & 3)
	and.l	#3,d0
	cmp.l	#2,d0
	beq.b	L453
	bhi.b	L457
	cmp.l	#0,d0
	beq.b	L455
	cmp.l	#1,d0
	beq.b	L454
	bra.b	L455
L457
	cmp.l	#3,d0
	beq.b	L452
	bra.b	L455
;		
L452
;		case 3: *to++ = 0;
	clr.b	(a0)+
;		
L453
;		case 2: *to++ = 0;
	clr.b	(a0)+
;		
L454
;		case 1: *to++ = 0;
	clr.b	(a0)
;		
L455
	movem.l	(a7)+,d2/d3
	rts

	SECTION "Zero16__MEM__r8PUsr0Ui:0",CODE


;void MEM::Zero16(REGP(0) uint16* to, REGI(0) size_t count)
	XDEF	Zero16__MEM__r8PUsr0Ui
Zero16__MEM__r8PUsr0Ui
	movem.l	d2/d3,-(a7)
L458
;	if (count <= 0)
	tst.l	d0
	bne.b	L460
L459
;		return;
	movem.l	(a7)+,d2/d3
	rts
L460
;	if (count > 1)
	cmp.l	#1,d0
	bls	L478
L461
;		rsint32 n = count>>5;
	move.l	d0,d1
	moveq	#5,d2
	lsr.l	d2,d1
;		switch ((count>>1) & 15)
	move.l	d0,d2
	moveq	#1,d3
	lsr.l	d3,d2
	and.l	#$F,d2
	cmp.l	#$F,d2
	bhi.b	L478
	move.l	L481(pc,d2.l*4),a1
	jmp	(a1)
L481
	dc.l	L462
	dc.l	L477
	dc.l	L476
	dc.l	L475
	dc.l	L474
	dc.l	L473
	dc.l	L472
	dc.l	L471
	dc.l	L470
	dc.l	L469
	dc.l	L468
	dc.l	L467
	dc.l	L466
	dc.l	L465
	dc.l	L464
	dc.l	L463
;			
L462
;	*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L463
;			case 15:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L464
;			case 14:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L465
;			case 13:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L466
;			case 12:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L467
;			case 11:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L468
;			case 10:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L469
;			case 9:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L470
;			case 8:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L471
;			case 7:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L472
;			case 6:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L473
;			case 5:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L474
;			case 4:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L475
;			case 3:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L476
;			case 2:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;			
L477
;			case 1:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
	subq.l	#1,d1
	cmp.l	#0,d1
	bgt.b	L462
L478
;	if (count & 1)
	and.l	#1,d0
	beq.b	L480
L479
;		*((uint16*)to)++ = 0;
	clr.w	(a0)
L480
	movem.l	(a7)+,d2/d3
	rts

	SECTION "Zero32__MEM__r8PUjr0Ui:0",CODE


;void MEM::Zero32(REGP(0) uint32* to, REGI(0) size_t count)
	XDEF	Zero32__MEM__r8PUjr0Ui
Zero32__MEM__r8PUjr0Ui
	move.l	d2,-(a7)
L482
;	if (count <= 0)
	tst.l	d0
	bne.b	L484
L483
;		return;
	move.l	(a7)+,d2
	rts
L484
;	rsint32 n = count>>4;
	move.l	d0,d1
	moveq	#4,d2
	lsr.l	d2,d1
;	switch (count & 15)
	and.l	#$F,d0
	cmp.l	#$F,d0
	bhi.b	L501
	move.l	L502(pc,d0.l*4),a1
	jmp	(a1)
L502
	dc.l	L485
	dc.l	L500
	dc.l	L499
	dc.l	L498
	dc.l	L497
	dc.l	L496
	dc.l	L495
	dc.l	L494
	dc.l	L493
	dc.l	L492
	dc.l	L491
	dc.l	L490
	dc.l	L489
	dc.l	L488
	dc.l	L487
	dc.l	L486
;		
L485
;	*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L486
;		case 15:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L487
;		case 14:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L488
;		case 13:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L489
;		case 12:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L490
;		case 11:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L491
;		case 10:			*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L492
;		case 9:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L493
;		case 8:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L494
;		case 7:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L495
;		case 6:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L496
;		case 5:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L497
;		case 4:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L498
;		case 3:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L499
;		case 2:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L500
;		case 1:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
	subq.l	#1,d1
	cmp.l	#0,d1
	bgt.b	L485
L501
	move.l	(a7)+,d2
	rts

	SECTION "Zero64__MEM__r8PUlr0Ui:0",CODE


;void MEM::Zero64(REGP(0) uint64* to, REGI(0) size_t count)
	XDEF	Zero64__MEM__r8PUlr0Ui
Zero64__MEM__r8PUlr0Ui
	move.l	d2,-(a7)
L503
;	if (count <= 0)
	tst.l	d0
	bne.b	L505
L504
;		return;
	move.l	(a7)+,d2
	rts
L505
;	rsint32 n = count>>3;
	move.l	d0,d1
	moveq	#3,d2
	lsr.l	d2,d1
;	switch (count & 7)
	and.l	#7,d0
	cmp.l	#7,d0
	bhi.b	L514
	move.l	L515(pc,d0.l*4),a1
	jmp	(a1)
L515
	dc.l	L506
	dc.l	L513
	dc.l	L512
	dc.l	L511
	dc.l	L510
	dc.l	L509
	dc.l	L508
	dc.l	L507
;		
L506
;	*((uint32*)to)++ = 0;
	clr.l	(a0)+
;									*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L507
;		case 7:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;									*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L508
;		case 6:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;									*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L509
;		case 5:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;									*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L510
;		case 4:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;									*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L511
;		case 3:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;									*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L512
;		case 2:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;									*((uint32*)to)++ = 0;
	clr.l	(a0)+
;		
L513
;		case 1:				*((uint32*)to)++ = 0;
	clr.l	(a0)+
;									*((uint32*)to)++ = 0;
	clr.l	(a0)+
	subq.l	#1,d1
	cmp.l	#0,d1
	bgt.b	L506
L514
	move.l	(a7)+,d2
	rts

	SECTION "Set8__MEM__r8PUcr0Ucr1Ui:0",CODE


;void MEM::Set8(REGP(0) uint8* to, REGI(0) uint8 val, REGI(1) size_t 
	XDEF	Set8__MEM__r8PUcr0Ucr1Ui
Set8__MEM__r8PUcr0Ucr1Ui
	movem.l	d2-d5,-(a7)
L516
;	if ((uint32)to & 1)
	move.l	a0,d2
	and.l	#1,d2
	beq.b	L518
L517
;		MEM::Set(to, val, count);
	move.l	d1,-(a7)
	and.l	#$FF,d0
	move.l	d0,-(a7)
	move.l	a0,-(a7)
	jsr	Set__MEM__PviUi
	add.w	#$C,a7
;		return;
	movem.l	(a7)+,d2-d5
	rts
L518
;	if (count > 3)
	cmp.l	#3,d1
	bls	L536
L519
;		ruint32 x = val<<24 | val<<16 | val<<8 | val;
	moveq	#0,d2
	move.b	d0,d2
	moveq	#$18,d3
	asl.l	d3,d2
	moveq	#0,d3
	move.b	d0,d3
	moveq	#$10,d4
	asl.l	d4,d3
	or.l	d3,d2
	moveq	#0,d3
	move.b	d0,d3
	moveq	#$8,d4
	asl.l	d4,d3
	or.l	d3,d2
	moveq	#0,d3
	move.b	d0,d3
	or.l	d3,d2
;		rsint32 n = count>>6;
	move.l	d1,d3
	moveq	#6,d4
	lsr.l	d4,d3
;		switch ((count>>2) & 15)
	move.l	d1,d4
	moveq	#2,d5
	lsr.l	d5,d4
	and.l	#$F,d4
	cmp.l	#$F,d4
	bhi.b	L536
	move.l	L541(pc,d4.l*4),a1
	jmp	(a1)
L541
	dc.l	L520
	dc.l	L535
	dc.l	L534
	dc.l	L533
	dc.l	L532
	dc.l	L531
	dc.l	L530
	dc.l	L529
	dc.l	L528
	dc.l	L527
	dc.l	L526
	dc.l	L525
	dc.l	L524
	dc.l	L523
	dc.l	L522
	dc.l	L521
;			
L520
;	*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L521
;			case 15:			*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L522
;			case 14:			*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L523
;			case 13:			*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L524
;			case 12:			*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L525
;			case 11:			*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L526
;			case 10:			*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L527
;			case 9:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L528
;			case 8:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L529
;			case 7:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L530
;			case 6:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L531
;			case 5:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L532
;			case 4:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L533
;			case 3:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L534
;			case 2:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L535
;			case 1:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
	subq.l	#1,d3
	cmp.l	#0,d3
	bgt.b	L520
L536
;	switch (count & 3)
	and.l	#3,d1
	cmp.l	#2,d1
	beq.b	L538
	bhi.b	L542
	cmp.l	#0,d1
	beq.b	L540
	cmp.l	#1,d1
	beq.b	L539
	bra.b	L540
L542
	cmp.l	#3,d1
	beq.b	L537
	bra.b	L540
;		
L537
;		case 3: *to++ = val;
	move.b	d0,(a0)+
;		
L538
;		case 2: *to++ = val;
	move.b	d0,(a0)+
;		
L539
;		case 1: *to++ = val;
	move.b	d0,(a0)
;		
L540
	movem.l	(a7)+,d2-d5
	rts

	SECTION "Set16__MEM__r8PUsr0Usr1Ui:0",CODE


;void MEM::Set16(REGP(0) uint16* to, REGI(0) uint16 val, REGI(1) size
	XDEF	Set16__MEM__r8PUsr0Usr1Ui
Set16__MEM__r8PUsr0Usr1Ui
	movem.l	d2-d5,-(a7)
L543
;	if (count <= 0)
	tst.l	d1
	bne.b	L545
L544
;		return;
	movem.l	(a7)+,d2-d5
	rts
L545
;	if (count > 1)
	cmp.l	#1,d1
	bls	L563
L546
;		ruint32 x = val<<16 | val;
	moveq	#0,d2
	move.w	d0,d2
	moveq	#$10,d3
	asl.l	d3,d2
	moveq	#0,d3
	move.w	d0,d3
	or.l	d3,d2
;		rsint32 n = count>>5;
	move.l	d1,d3
	moveq	#5,d4
	lsr.l	d4,d3
;		switch ((count>>1) & 15)
	move.l	d1,d4
	moveq	#1,d5
	lsr.l	d5,d4
	and.l	#$F,d4
	cmp.l	#$F,d4
	bhi.b	L563
	move.l	L566(pc,d4.l*4),a1
	jmp	(a1)
L566
	dc.l	L547
	dc.l	L562
	dc.l	L561
	dc.l	L560
	dc.l	L559
	dc.l	L558
	dc.l	L557
	dc.l	L556
	dc.l	L555
	dc.l	L554
	dc.l	L553
	dc.l	L552
	dc.l	L551
	dc.l	L550
	dc.l	L549
	dc.l	L548
;			
L547
;	*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L548
;			case 15:			*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L549
;			case 14:			*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L550
;			case 13:			*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L551
;			case 12:			*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L552
;			case 11:			*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L553
;			case 10:			*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L554
;			case 9:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L555
;			case 8:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L556
;			case 7:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L557
;			case 6:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L558
;			case 5:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L559
;			case 4:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L560
;			case 3:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L561
;			case 2:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
;			
L562
;			case 1:				*((uint32*)to)++ = x;
	move.l	d2,(a0)+
	subq.l	#1,d3
	cmp.l	#0,d3
	bgt.b	L547
L563
;	if (count & 1)
	and.l	#1,d1
	beq.b	L565
L564
;		*((uint16*)to)++ = val;
	move.w	d0,(a0)
L565
	movem.l	(a7)+,d2-d5
	rts

	SECTION "Set32__MEM__r8PUjr0Ujr1Ui:0",CODE


;void MEM::Set32(REGP(0) uint32* to, REGI(0) uint32 val, REGI(1) size
	XDEF	Set32__MEM__r8PUjr0Ujr1Ui
Set32__MEM__r8PUjr0Ujr1Ui
	movem.l	d2/d3,-(a7)
L567
;	if (count <= 0)
	tst.l	d1
	bne.b	L569
L568
;		return;
	movem.l	(a7)+,d2/d3
	rts
L569
;	rsint32 n = count>>4;
	move.l	d1,d2
	moveq	#4,d3
	lsr.l	d3,d2
;	switch (count & 15)
	and.l	#$F,d1
	cmp.l	#$F,d1
	bhi.b	L586
	move.l	L587(pc,d1.l*4),a1
	jmp	(a1)
L587
	dc.l	L570
	dc.l	L585
	dc.l	L584
	dc.l	L583
	dc.l	L582
	dc.l	L581
	dc.l	L580
	dc.l	L579
	dc.l	L578
	dc.l	L577
	dc.l	L576
	dc.l	L575
	dc.l	L574
	dc.l	L573
	dc.l	L572
	dc.l	L571
;		
L570
;	*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L571
;		case 15:			*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L572
;		case 14:			*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L573
;		case 13:			*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L574
;		case 12:			*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L575
;		case 11:			*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L576
;		case 10:			*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L577
;		case 9:				*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L578
;		case 8:				*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L579
;		case 7:				*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L580
;		case 6:				*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L581
;		case 5:				*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L582
;		case 4:				*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L583
;		case 3:				*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L584
;		case 2:				*((uint32*)to)++ = val;
	move.l	d0,(a0)+
;		
L585
;		case 1:				*((uint32*)to)++ = val;
	move.l	d0,(a0)+
	subq.l	#1,d2
	cmp.l	#0,d2
	bgt.b	L570
L586
	movem.l	(a7)+,d2/d3
	rts

	SECTION "Set64__MEM__r8PUlr9RUlr0Ui:0",CODE


;void MEM::Set64(REGP(0) uint64* to, REGP(1) uint64& val, REGI(0) siz
	XDEF	Set64__MEM__r8PUlr9RUlr0Ui
Set64__MEM__r8PUlr9RUlr0Ui
	movem.l	d2-d4,-(a7)
L588
;	if (count <= 0)
	tst.l	d0
	bne.b	L590
L589
;		return;
	movem.l	(a7)+,d2-d4
	rts
L590
;	ruint32 x1 = ((uint32*)&val)[0];
	move.l	(a1),d2
;	ruint32 x2 = ((uint32*)&val)[1];
	move.l	4(a1),d1
;	rsint32 n = count>>3;
	move.l	d0,d3
	moveq	#3,d4
	lsr.l	d4,d3
;	switch (count & 7)
	and.l	#7,d0
	cmp.l	#7,d0
	bhi.b	L599
	move.l	L600(pc,d0.l*4),a1
	jmp	(a1)
L600
	dc.l	L591
	dc.l	L598
	dc.l	L597
	dc.l	L596
	dc.l	L595
	dc.l	L594
	dc.l	L593
	dc.l	L592
;		
L591
;	*((uint32*)to)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)to)++ = x2;
	move.l	d1,(a0)+
;		
L592
;		case 7:				*((uint32*)to)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)to)++ = x2;
	move.l	d1,(a0)+
;		
L593
;		case 6:				*((uint32*)to)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)to)++ = x2;
	move.l	d1,(a0)+
;		
L594
;		case 5:				*((uint32*)to)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)to)++ = x2;
	move.l	d1,(a0)+
;		
L595
;		case 4:				*((uint32*)to)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)to)++ = x2;
	move.l	d1,(a0)+
;		
L596
;		case 3:				*((uint32*)to)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)to)++ = x2;
	move.l	d1,(a0)+
;		
L597
;		case 2:				*((uint32*)to)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)to)++ = x2;
	move.l	d1,(a0)+
;		
L598
;		case 1:				*((uint32*)to)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)to)++ = x2;
	move.l	d1,(a0)+
	subq.l	#1,d3
	cmp.l	#0,d3
	bgt.b	L591
L599
	movem.l	(a7)+,d2-d4
	rts

	END
