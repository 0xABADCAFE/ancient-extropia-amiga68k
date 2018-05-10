
; Storm C Compiler
; extropialib:lib/Platforms/Amiga68k/BaseLib/MemMove.cpp
	mc68030
	mc68881
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
	XREF	_TimerBase
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
	XREF	_fpuPrecision__CPU
	XREF	_cpuNames__CPU

	SECTION "Round16__r23d:0",CODE

	rts

	SECTION "Copy__MEM__r8Pvr9Pvr0Ui:0",CODE


;void MEM::Copy(REGP(0) void* dst, REGP(1) void* src, REGI(0) size_t 
	XDEF	Copy__MEM__r8Pvr9Pvr0Ui
Copy__MEM__r8Pvr9Pvr0Ui
	movem.l	d2/d3/a2/a6,-(a7)
	exg	a0,a1
L142
;	if (!len || dst == src)
	tst.l	d0
	beq.b	L144
L143
	cmp.l	a0,a1
	bne.b	L145
L144
;		return;
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L145
;	if ( ((uint32)dst|(uint32)src) & 3UL )
	move.l	a1,d1
	move.l	a0,d2
	or.l	d2,d1
	and.l	#3,d1
	beq.b	L147
L146
;		CopyMem(src, dst, len);
	move.l	_SysBase,a6
	jsr	-$270(a6)
;		return;
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L147
;	if (len > 3)
	cmp.l	#3,d0
	bls	L165
L148
;		rsint32 loop = (len+60)>>6;
	move.l	d0,d1
	add.l	#$3C,d1
	moveq	#6,d2
	lsr.l	d2,d1
;		switch ((len>>2) & 15)
	move.l	d0,d2
	moveq	#2,d3
	lsr.l	d3,d2
	and.l	#$F,d2
	cmp.l	#$F,d2
	bhi.b	L165
	move.l	L170(pc,d2.l*4),a2
	jmp	(a2)
L170
	dc.l	L149
	dc.l	L164
	dc.l	L163
	dc.l	L162
	dc.l	L161
	dc.l	L160
	dc.l	L159
	dc.l	L158
	dc.l	L157
	dc.l	L156
	dc.l	L155
	dc.l	L154
	dc.l	L153
	dc.l	L152
	dc.l	L151
	dc.l	L150
;			
L149
;	*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L150
;			case 15:			*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L151
;			case 14:			*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L152
;			case 13:			*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L153
;			case 12:			*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L154
;			case 11:			*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L155
;			case 10:			*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L156
;			case 9:				*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L157
;			case 8:				*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L158
;			case 7:				*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L159
;			case 6:				*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L160
;			case 5:				*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L161
;			case 4:				*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L162
;			case 3:				*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L163
;			case 2:				*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
;			
L164
;			case 1:				*((uint32*)dst)++ = *((uint32*)src)++;
	move.l	(a0)+,(a1)+
	subq.l	#1,d1
	tst.l	d1
	bne.b	L149
L165
;	switch (len & 3)
	and.l	#3,d0
	cmp.l	#2,d0
	beq.b	L167
	bhi.b	L171
	cmp.l	#0,d0
	beq.b	L169
	cmp.l	#1,d0
	beq.b	L168
	bra.b	L169
L171
	cmp.l	#3,d0
	beq.b	L166
	bra.b	L169
;		
L166
;		case 3: *((uint8*)dst)++ = *((uint8*)src)++;
	move.b	(a0)+,(a1)+
;		
L167
;		case 2: *((uint8*)dst)++ = *((uint8*)src)++;
	move.b	(a0)+,(a1)+
;		
L168
;		case 1: *((uint8*)dst)++ = *((uint8*)src)++;
	move.b	(a0),(a1)
;		
L169
	movem.l	(a7)+,d2/d3/a2/a6
	rts

	SECTION "Zero__MEM__r8Pvr0Ui:0",CODE


;void MEM::Zero(REGP(0) void* dst, REGI(0) size_t len)
	XDEF	Zero__MEM__r8Pvr0Ui
Zero__MEM__r8Pvr0Ui
	movem.l	d2/d3,-(a7)
L172
;	if (!len) 
	tst.l	d0
	bne.b	L174
L173
;	if (!len) return;
	movem.l	(a7)+,d2/d3
	rts
L174
;	if (len>3)
	cmp.l	#3,d0
	bls	L198
L175
;		sint32 start = ((uint32)dst & 3UL);
	move.l	a0,d1
	and.l	#3,d1
;		if (start)
	beq.b	L180
L176
;			len -= (4+start);
	move.l	d1,d2
	addq.l	#4,d2
	sub.l	d2,d0
;			switch(start)
	cmp.l	#2,d1
	beq.b	L178
	bgt.b	L203
	cmp.l	#1,d1
	beq.b	L177
	bra.b	L180
L203
	cmp.l	#3,d1
	beq.b	L179
	bra.b	L180
;				
L177
;				case 1: *((uint8*)dst)++ = 0;
	clr.b	(a0)+
;				
L178
;				case 2: *((uint8*)dst)++ = 0;
	clr.b	(a0)+
;				
L179
;				case 3: *((uint8*)dst)++ = 0;
	clr.b	(a0)+
L180
;		if (len>3)
	cmp.l	#3,d0
	bls	L198
L181
;			rsint32 loop = (len+60)>>6;
	move.l	d0,d1
	add.l	#$3C,d1
	moveq	#6,d2
	lsr.l	d2,d1
;			switch ((len>>2) & 15)
	move.l	d0,d2
	moveq	#2,d3
	lsr.l	d3,d2
	and.l	#$F,d2
	cmp.l	#$F,d2
	bhi.b	L198
	move.l	L204(pc,d2.l*4),a1
	jmp	(a1)
L204
	dc.l	L182
	dc.l	L197
	dc.l	L196
	dc.l	L195
	dc.l	L194
	dc.l	L193
	dc.l	L192
	dc.l	L191
	dc.l	L190
	dc.l	L189
	dc.l	L188
	dc.l	L187
	dc.l	L186
	dc.l	L185
	dc.l	L184
	dc.l	L183
;				
L182
;	*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L183
;				case 15:			*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L184
;				case 14:			*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L185
;				case 13:			*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L186
;				case 12:			*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L187
;				case 11:			*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L188
;				case 10:			*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L189
;				case 9:				*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L190
;				case 8:				*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L191
;				case 7:				*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L192
;				case 6:				*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L193
;				case 5:				*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L194
;				case 4:				*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L195
;				case 3:				*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L196
;				case 2:				*((uint32*)dst)++ = 0;
	clr.l	(a0)+
;				
L197
;				case 1:				*((uint32*)dst)++ = 0;
	clr.l	(a0)+
	subq.l	#1,d1
	tst.l	d1
	bne.b	L182
L198
;	switch (len&3)
	and.l	#3,d0
	cmp.l	#2,d0
	beq.b	L200
	bhi.b	L205
	cmp.l	#0,d0
	beq.b	L202
	cmp.l	#1,d0
	beq.b	L201
	bra.b	L202
L205
	cmp.l	#3,d0
	beq.b	L199
	bra.b	L202
;		
L199
;		case 3: *((uint8*)dst)++ = 0;
	clr.b	(a0)+
;		
L200
;		case 2: *((uint8*)dst)++ = 0;
	clr.b	(a0)+
;		
L201
;		case 1: *((uint8*)dst)++ = 0;
	clr.b	(a0)
;		
L202
	movem.l	(a7)+,d2/d3
	rts

	SECTION "Set__MEM__r8Pvr0ir1Ui:0",CODE


;void MEM::Set(REGP(0) void* dst, REGI(0) int c, REGI(1) size_t len)
	XDEF	Set__MEM__r8Pvr0ir1Ui
Set__MEM__r8Pvr0ir1Ui
	movem.l	d2-d5,-(a7)
L206
;	if (!len) 
	tst.l	d1
	bne.b	L208
L207
;	if (!len) return;
	movem.l	(a7)+,d2-d5
	rts
L208
;	if (len>3)
	cmp.l	#3,d1
	bls	L232
L209
;		sint32 start = ((uint32)dst & 3UL);
	move.l	a0,d2
	and.l	#3,d2
;		if (start)
	beq.b	L214
L210
;			len -= (4+start);
	move.l	d2,d3
	addq.l	#4,d3
	sub.l	d3,d1
;			switch(start)
	cmp.l	#2,d2
	beq.b	L212
	bgt.b	L237
	cmp.l	#1,d2
	beq.b	L211
	bra.b	L214
L237
	cmp.l	#3,d2
	beq.b	L213
	bra.b	L214
;				
L211
;				case 1: *((uint8*)dst)++ = c;
	move.b	d0,(a0)+
;				
L212
;				case 2: *((uint8*)dst)++ = c;
	move.b	d0,(a0)+
;				
L213
;				case 3: *((uint8*)dst)++ = c;
	move.b	d0,(a0)+
L214
;		if (len>3)
	cmp.l	#3,d1
	bls	L232
L215
;			ruint32 v = c<<24|c<<16|c<<8|c;
	move.l	d0,d2
	moveq	#$18,d3
	asl.l	d3,d2
	move.l	d0,d3
	moveq	#$10,d4
	asl.l	d4,d3
	or.l	d3,d2
	move.l	d0,d3
	moveq	#$8,d4
	asl.l	d4,d3
	or.l	d3,d2
	or.l	d0,d2
;			rsint32 loop = (len+60)>>6;
	move.l	d1,d3
	add.l	#$3C,d3
	moveq	#6,d4
	lsr.l	d4,d3
;			switch ((len>>2) & 15)
	move.l	d1,d4
	moveq	#2,d5
	lsr.l	d5,d4
	and.l	#$F,d4
	cmp.l	#$F,d4
	bhi.b	L232
	move.l	L238(pc,d4.l*4),a1
	jmp	(a1)
L238
	dc.l	L216
	dc.l	L231
	dc.l	L230
	dc.l	L229
	dc.l	L228
	dc.l	L227
	dc.l	L226
	dc.l	L225
	dc.l	L224
	dc.l	L223
	dc.l	L222
	dc.l	L221
	dc.l	L220
	dc.l	L219
	dc.l	L218
	dc.l	L217
;				
L216
;	*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L217
;				case 15:			*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L218
;				case 14:			*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L219
;				case 13:			*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L220
;				case 12:			*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L221
;				case 11:			*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L222
;				case 10:			*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L223
;				case 9:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L224
;				case 8:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L225
;				case 7:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L226
;				case 6:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L227
;				case 5:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L228
;				case 4:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L229
;				case 3:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L230
;				case 2:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L231
;				case 1:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
	subq.l	#1,d3
	cmp.l	#0,d3
	bgt.b	L216
L232
;	switch (len&3)
	and.l	#3,d1
	cmp.l	#2,d1
	beq.b	L234
	bhi.b	L239
	cmp.l	#0,d1
	beq.b	L236
	cmp.l	#1,d1
	beq.b	L235
	bra.b	L236
L239
	cmp.l	#3,d1
	beq.b	L233
	bra.b	L236
;		
L233
;		case 3: *((uint8*)dst)++ = c;
	move.b	d0,(a0)+
;		
L234
;		case 2: *((uint8*)dst)++ = c;
	move.b	d0,(a0)+
;		
L235
;		case 1: *((uint8*)dst)++ = c;
	move.b	d0,(a0)
;		
L236
	movem.l	(a7)+,d2-d5
	rts

	SECTION "Set16__MEM__r8Pvr0Usr1Ui:0",CODE


;void MEM::Set16(REGP(0) void* dst, REGI(0) uint16 c, REGI(1) size_t 
	XDEF	Set16__MEM__r8Pvr0Usr1Ui
Set16__MEM__r8Pvr0Usr1Ui
	movem.l	d2-d5,-(a7)
L240
;	if (!cnt || ((uint32)dst & 1UL) ) 
	tst.l	d1
	beq.b	L242
L241
	move.l	a0,d2
	and.l	#1,d2
	beq.b	L243
L242
;	if (!cnt || ((uint32)dst & 1UL) )
	movem.l	(a7)+,d2-d5
	rts
L243
;	if (cnt>1)
	cmp.l	#1,d1
	bls	L264
L244
;		if ((uint32)dst & 2UL)
	move.l	a0,d2
	and.l	#2,d2
	beq.b	L246
L245
;			*((uint16*)dst)++ = c;
	move.w	d0,(a0)+
;			--cnt;
	subq.l	#1,d1
L246
;		if (cnt>1)
	cmp.l	#1,d1
	bls	L264
L247
;			ruint32 v = c<<16|c;
	moveq	#0,d2
	move.w	d0,d2
	moveq	#$10,d3
	asl.l	d3,d2
	moveq	#0,d3
	move.w	d0,d3
	or.l	d3,d2
;			rsint32 loop = (cnt+30)>>5;
	move.l	d1,d3
	add.l	#$1E,d3
	moveq	#5,d4
	lsr.l	d4,d3
;			switch ((cnt>>1) & 15)
	move.l	d1,d4
	moveq	#1,d5
	lsr.l	d5,d4
	and.l	#$F,d4
	cmp.l	#$F,d4
	bhi.b	L264
	move.l	L267(pc,d4.l*4),a1
	jmp	(a1)
L267
	dc.l	L248
	dc.l	L263
	dc.l	L262
	dc.l	L261
	dc.l	L260
	dc.l	L259
	dc.l	L258
	dc.l	L257
	dc.l	L256
	dc.l	L255
	dc.l	L254
	dc.l	L253
	dc.l	L252
	dc.l	L251
	dc.l	L250
	dc.l	L249
;				
L248
;	*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L249
;				case 15:			*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L250
;				case 14:			*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L251
;				case 13:			*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L252
;				case 12:			*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L253
;				case 11:			*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L254
;				case 10:			*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L255
;				case 9:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L256
;				case 8:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L257
;				case 7:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L258
;				case 6:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L259
;				case 5:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L260
;				case 4:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L261
;				case 3:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L262
;				case 2:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
;				
L263
;				case 1:				*((uint32*)dst)++ = v;
	move.l	d2,(a0)+
	subq.l	#1,d3
	tst.l	d3
	bne.b	L248
L264
;	if (cnt & 1UL)
	and.l	#1,d1
	beq.b	L266
L265
;		*((uint16*)dst) = c;
	move.w	d0,(a0)
L266
	movem.l	(a7)+,d2-d5
	rts

	SECTION "Set32__MEM__r8Pvr0Ujr1Ui:0",CODE


;void MEM::Set32(REGP(0) void* dst, REGI(0) uint32 c, REGI(1) size_t 
	XDEF	Set32__MEM__r8Pvr0Ujr1Ui
Set32__MEM__r8Pvr0Ujr1Ui
	movem.l	d2/d3,-(a7)
L268
;	if (!cnt || ((uint32)dst & 1UL) ) 
	tst.l	d1
	beq.b	L270
L269
	move.l	a0,d2
	and.l	#1,d2
	beq.b	L271
L270
;	if (!cnt || ((uint32)dst & 1UL) )
	movem.l	(a7)+,d2/d3
	rts
L271
;	rsint32 loop = (cnt+15)>>4;
	move.l	d1,d2
	add.l	#$F,d2
	moveq	#4,d3
	lsr.l	d3,d2
;	switch (cnt & 15)
	and.l	#$F,d1
	cmp.l	#$F,d1
	bhi.b	L288
	move.l	L289(pc,d1.l*4),a1
	jmp	(a1)
L289
	dc.l	L272
	dc.l	L287
	dc.l	L286
	dc.l	L285
	dc.l	L284
	dc.l	L283
	dc.l	L282
	dc.l	L281
	dc.l	L280
	dc.l	L279
	dc.l	L278
	dc.l	L277
	dc.l	L276
	dc.l	L275
	dc.l	L274
	dc.l	L273
;		
L272
;	*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L273
;		case 15:			*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L274
;		case 14:			*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L275
;		case 13:			*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L276
;		case 12:			*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L277
;		case 11:			*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L278
;		case 10:			*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L279
;		case 9:				*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L280
;		case 8:				*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L281
;		case 7:				*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L282
;		case 6:				*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L283
;		case 5:				*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L284
;		case 4:				*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L285
;		case 3:				*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L286
;		case 2:				*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
;		
L287
;		case 1:				*((uint32*)dst)++ = c;
	move.l	d0,(a0)+
	subq.l	#1,d2
	tst.l	d2
	bne.b	L272
L288
	movem.l	(a7)+,d2/d3
	rts

	SECTION "Set64__MEM__r8Pvr9RUlr0Ui:0",CODE


;void MEM::Set64(REGP(0) void* dst, REGP(1) uint64& c, REGI(0) size_t
	XDEF	Set64__MEM__r8Pvr9RUlr0Ui
Set64__MEM__r8Pvr9RUlr0Ui
	movem.l	d2-d4,-(a7)
L290
;	if (!cnt || ((uint32)dst & 1UL) ) 
	tst.l	d0
	beq.b	L292
L291
	move.l	a0,d1
	and.l	#1,d1
	beq.b	L293
L292
;	if (!cnt || ((uint32)dst & 1UL) )
	movem.l	(a7)+,d2-d4
	rts
L293
;	ruint32 x1 = ((uint32*)&c)[0];
	move.l	(a1),d2
;	ruint32 x2 = ((uint32*)&c)[1];
	move.l	4(a1),d1
;	rsint32 loop = (cnt+7)>>3;
	move.l	d0,d3
	addq.l	#7,d3
	moveq	#3,d4
	lsr.l	d4,d3
;	switch (cnt & 7)
	and.l	#7,d0
	cmp.l	#7,d0
	bhi.b	L302
	move.l	L303(pc,d0.l*4),a1
	jmp	(a1)
L303
	dc.l	L294
	dc.l	L301
	dc.l	L300
	dc.l	L299
	dc.l	L298
	dc.l	L297
	dc.l	L296
	dc.l	L295
;		
L294
;	*((uint32*)dst)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)dst)++ = x2;
	move.l	d1,(a0)+
;		
L295
;		case 7:				*((uint32*)dst)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)dst)++ = x2;
	move.l	d1,(a0)+
;		
L296
;		case 6:				*((uint32*)dst)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)dst)++ = x2;
	move.l	d1,(a0)+
;		
L297
;		case 5:				*((uint32*)dst)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)dst)++ = x2;
	move.l	d1,(a0)+
;		
L298
;		case 4:				*((uint32*)dst)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)dst)++ = x2;
	move.l	d1,(a0)+
;		
L299
;		case 3:				*((uint32*)dst)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)dst)++ = x2;
	move.l	d1,(a0)+
;		
L300
;		case 2:				*((uint32*)dst)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)dst)++ = x2;
	move.l	d1,(a0)+
;		
L301
;		case 1:				*((uint32*)dst)++ = x1;
	move.l	d2,(a0)+
;									*((uint32*)dst)++ = x2;
	move.l	d1,(a0)+
	subq.l	#1,d3
	tst.l	d3
	bne.b	L294
L302
	movem.l	(a7)+,d2-d4
	rts

	END
