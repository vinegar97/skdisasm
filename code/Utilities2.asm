; ---------------------------------------------------------------------------
; Called at the end of each frame to perform vertical synchronization
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Wait_VSync:
		move	#$2300,sr

.loop:
		tst.b	(V_int_routine).w
		bne.s	.loop	; wait until V-int's run
		rts
; End of function Wait_VSync

; ---------------------------------------------------------------------------
; Generates a pseudo-random number in d0
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Random_Number:
		move.l	(RNG_seed).w,d1
		tst.w	d1
		bne.s	+
		move.l	#$2A6D365B,d1	; reset seed if needed

+
		move.l	d1,d0
		asl.l	#2,d1
		add.l	d0,d1
		asl.l	#3,d1
		add.l	d0,d1
		move.w	d1,d0
		swap	d1
		add.w	d1,d0
		move.w	d0,d1
		swap	d1
		move.l	d1,(RNG_seed).w
		rts
; End of function Random_Number

; ---------------------------------------------------------------------------
; Calculates the sine and cosine of the angle in d0 (360 degrees = 256)
; Returns the sine in d0 and the cosine in d1 (both multiplied by $100)
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


GetSineCosine:
		andi.w	#$FF,d0
		add.w	d0,d0
		addi.w	#$40*2,d0	; $40 = 90 degrees, sin(x+90) = cos(x)
		move.w	SineTable(pc,d0.w),d1
		subi.w	#$40*2,d0
		move.w	SineTable(pc,d0.w),d0
		rts
; End of function GetSineCosine

; ---------------------------------------------------------------------------
SineTable:
		binclude "Levels/Misc/sine.bin"
		even
; ---------------------------------------------------------------------------
; Calculates the arctangent of y/x and returns it in d0 (360 degrees = 256)
; Inputs: d1 = input x, d2 = input y
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


GetArcTan:
		movem.l	d3-d4,-(sp)
		moveq	#0,d3
		moveq	#0,d4
		move.w	d1,d3
		move.w	d2,d4
		or.w	d3,d4
		beq.s	GetArcTan_Zero	; special case when both x and y are zero
		move.w	d2,d4
		tst.w	d3
		bpl.s	+
		neg.w	d3

+
		tst.w	d4
		bpl.s	+
		neg.w	d4

+
		cmp.w	d3,d4
		bhs.s	+	; if |y| >= |x|
		lsl.l	#8,d4
		divu.w	d3,d4
		moveq	#0,d0
		move.b	ArcTanTable(pc,d4.w),d0
		bra.s	++

+
		lsl.l	#8,d3
		divu.w	d4,d3
		moveq	#$40,d0
		sub.b	ArcTanTable(pc,d3.w),d0	; arctan(y/x) = 90 - arctan(x/y)

+
		tst.w	d1
		bpl.s	+
		neg.w	d0
		addi.w	#$80,d0	; place angle in appropriate quadrant

+
		tst.w	d2
		bpl.s	+
		neg.w	d0
		addi.w	#$100,d0	; place angle in appropriate quadrant

+
		movem.l	(sp)+,d3-d4
		rts
; ---------------------------------------------------------------------------

GetArcTan_Zero:
		move.w	#$40,d0	; angle = 90 degrees
		movem.l	(sp)+,d3-d4
		rts
; End of function GetArcTan

; ---------------------------------------------------------------------------
ArcTanTable:
		binclude "Levels/Misc/arctan.bin"
		even
