	.file	"TestPPC.c"
	.global	@__NormalizePPC
#vsc cpu 603E
	.text
	.sdreg	r2
	.global	_NormalizePPC
	.align	4
_NormalizePPC:
	lis	r12,4660
	stwu	r1,-48(r1)
	addi	r12,r12,22136
	stw	r31,32(r1)
	mr	r31,r3
	lwz	r11,_funky(r2)
	cmplw	cr0,r11,r12
	bne	cr0,l33
	li	r8,0
	mr	r9,r31
	cmpwi	cr0,r4,0
	ble	cr0,l32
	mr	r7,r4
l30:
	neg	r10,r8
	lha	r5,0(r9)
	addi	r9,r9,2
	extsh	r6,r5
	cmpw	cr0,r6,r10
	blt	cr0,l8
	cmpw	cr0,r6,r8
	ble	cr0,l9
l8:
	extsh	r8,r5
l9:
	addi	r7,r7,-1
	cmpwi	cr0,r7,0
	bgt	cr0,l30
l32:
	cmpwi	cr0,r8,0
	beq	cr0,l33
	cmpwi	cr0,r8,0
	bge	cr0,l14
	neg	r3,r8
	b	l15
l14:
	mr	r3,r8
l15:
	lis	r12,17200
	mr	r9,r31
	cmpwi	cr0,r4,0
	stw	r12,24(r1)
	xoris	r12,r3,32768
	stw	r12,28(r1)
	lfd	f11,24(r1)
	lfd	f13,l37(r2)
	lfd	f12,l38(r2)
	fsub	f11,f11,f13
	fdiv	f11,f12,f11
	fmr	f10,f11
	ble	cr0,l33
	mr	r10,r4
l31:
	lis	r12,17200
	addi	r10,r10,-1
	lha	r11,0(r9)
	cmpwi	cr0,r10,0
	stw	r12,24(r1)
	xoris	r12,r11,32768
	stw	r12,28(r1)
	lfd	f11,24(r1)
	lfd	f13,l39(r2)
	fsub	f11,f11,f13
	fmuls	f11,f11,f10
	fctiwz	f0,f11
	stfd	f0,24(r1)
	lha	r0,30(r1)
	sth	r0,0(r9)
	addi	r9,r9,2
	bgt	cr0,l31
l33:
	lwz	r31,32(r1)
	addi	r1,r1,48
	blr
	.type	_NormalizePPC,@function
	.size	_NormalizePPC,$-_NormalizePPC
# stacksize=48
	.align	2
	.globl	_magic
	.tocd
	.align	2
	.type	_magic,@object
	.size	_magic,4
_magic:
	.long	3405691582
	.align	2
	.globl	_codePPC
	.type	_codePPC,@object
	.size	_codePPC,4
_codePPC:
	.long	_NormalizePPC
	.globl	_funky
	.align	3
l39:
	.long	0x43300000,0x80000000
	.align	3
l38:
	.long	0x40e00000,0x00000000
	.align	3
l37:
	.long	0x43300000,0x80000000
	.align	3
l36:
	.long	0x43300000,0x80000000
	.align	3
l35:
	.long	0x40e00000,0x00000000
	.align	3
l34:
	.long	0x43300000,0x80000000
