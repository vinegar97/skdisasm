; =============== S U B R O U T I N E =======================================


SetUp_ObjAttributes:
		move.l	(a1)+,mappings(a0)		; Mappings location

SetUp_ObjAttributes2:
		move.w	(a1)+,art_tile(a0)		; VRAM offset

SetUp_ObjAttributes3:
		move.w	(a1)+,priority(a0)		; Priority
		move.b	(a1)+,width_pixels(a0)		; Width
		move.b	(a1)+,height_pixels(a0)		; Height
		move.b	(a1)+,mapping_frame(a0)		; Mappings frame
		move.b	(a1)+,collision_flags(a0)	; Collision Number
		bset	#2,render_flags(a0)		; Object uses world coordinates
		addq.b	#2,routine(a0)			; Increase routine counter

locret_529CE:
		rts
; End of function SetUp_ObjAttributes


; =============== S U B R O U T I N E =======================================


CreateChild1_Normal:
		moveq	#0,d2				; Includes positional offset data
		move.w	(a2)+,d6

.loop:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	.end
		move.w	a0,parent3(a1)			; Parent RAM address into $46
		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(a0),art_tile(a1)	; Mappings and VRAM offset copied from parent object
		move.l	(a2)+,(a1)			; Object address
		move.b	d2,subtype(a1)			; Index of child object (done sequentially for each object)
		move.w	x_pos(a0),d0
		move.b	(a2)+,d1			; X Positional offset
		move.b	d1,child_dx(a1)			; $42 has the X offset
		ext.w	d1
		add.w	d1,d0
		move.w	d0,x_pos(a1)			; Apply offset to new position
		move.w	y_pos(a0),d0
		move.b	(a2)+,d1			; Same as above for Y
		move.b	d1,child_dy(a1)			; $43 has the Y offset
		ext.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a1)			; Apply offset
		addq.w	#2,d2				; Add 2 to index
		dbf	d6,.loop			; Loop
		moveq	#0,d0

.end:
		rts
; End of function CreateChild1_Normal


; =============== S U B R O U T I N E =======================================


CreateChild2_Complex:
		moveq	#0,d2				; Includes positional offset data, velocity, and a few pointers
		move.w	(a2)+,d6

.loop:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	.end
		move.w	a0,parent3(a1)			; Parent RAM address into $46
		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(a0),art_tile(a1)	; Mappings and VRAM offset copied from parent object
		move.l	(a2)+,(a1)			; Object address
		move.l	(a2)+,$3E(a1)			; Object data (to be read by SetUp_ObjAttributes)
		move.l	(a2)+,$30(a1)			; Raw animation pointer
		move.l	(a2)+,$34(a1)			; Next routine
		move.b	d2,subtype(a1)
		move.w	x_pos(a0),d0
		move.b	(a2)+,d1
		move.b	d1,child_dx(a1)			; See offset information above
		ext.w	d1
		add.w	d1,d0
		move.w	d0,x_pos(a1)
		move.w	y_pos(a0),d0
		move.b	(a2)+,d1
		move.b	d1,child_dy(a1)			; See offset information above
		ext.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a1)
		move.w	(a2)+,x_vel(a1)			; X velocity
		move.w	(a2)+,y_vel(a1)			; Y velocity
		addq.w	#2,d2
		dbf	d6,.loop
		moveq	#0,d0

.end:
		rts
; End of function CreateChild2_Complex


; =============== S U B R O U T I N E =======================================


CreateChild3_NormalRepeated:
		moveq	#0,d2			; Same as Child creation routine 1, except it repeats one object several times rather than different objects sequentially
		move.w	(a2)+,d6

.loop:
		movea.l	a2,a3
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	.end
		move.w	a0,parent3(a1)
		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(a0),art_tile(a1)
		move.l	(a3)+,(a1)
		move.b	d2,subtype(a1)
		move.w	x_pos(a0),d0
		move.b	(a3)+,d1
		move.b	d1,child_dx(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,x_pos(a1)
		move.w	y_pos(a0),d0
		move.b	(a3)+,d1
		move.b	d1,child_dy(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a1)
		addq.w	#2,d2
		dbf	d6,.loop
		moveq	#0,d0

.end:
		rts
; End of function CreateChild3_NormalRepeated


; =============== S U B R O U T I N E =======================================


CreateChild4_LinkListRepeated:
		movea.l	a0,a3				; Creates a linked object list. Previous object address is in $46, while next object in list is at $44
		moveq	#0,d2
		move.w	(a2)+,d6

.loop:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	.end
		move.w	a3,parent3(a1)
		move.w	a1,$44(a3)
		movea.l	a1,a3
		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(a0),art_tile(a1)
		move.l	(a2),(a1)
		move.b	d2,subtype(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addq.w	#2,d2
		dbf	d6,.loop
		moveq	#0,d0

.end:
		rts
; End of function CreateChild4_LinkListRepeated


; =============== S U B R O U T I N E =======================================


CreateChild5_ComplexAdjusted:
		moveq	#0,d2				; Same as child routine 2, but adjusts both X position and X velocity based on parent object's orientation
		move.w	(a2)+,d6

.loop:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	.end
		move.w	a0,parent3(a1)
		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(a0),art_tile(a1)
		move.l	(a2)+,(a1)
		move.l	(a2)+,$3E(a1)
		move.l	(a2)+,$30(a1)
		move.l	(a2)+,$34(a1)
		move.b	d2,subtype(a1)
		move.w	x_pos(a0),d0
		move.b	(a2)+,d1
		move.b	d1,child_dx(a1)
		ext.w	d1
		btst	#0,render_flags(a0)
		beq.s	.noflip
		neg.w	d1

.noflip:
		add.w	d1,d0
		move.w	d0,x_pos(a1)
		move.w	y_pos(a0),d0
		move.b	(a2)+,d1
		move.b	d1,child_dy(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a1)
		move.w	(a2)+,d1
		btst	#0,render_flags(a0)
		beq.s	.noflip2
		neg.w	d1

.noflip2:
		move.w	d1,x_vel(a1)
		move.w	(a2)+,y_vel(a1)
		addq.w	#2,d2
		dbf	d6,.loop
		moveq	#0,d0

.end:
		rts
; End of function CreateChild5_ComplexAdjusted


; =============== S U B R O U T I N E =======================================


CreateChild6_Simple:
		moveq	#0,d2				; Simple child creation routine, merely creates x number of the same object at the parent's position
		move.w	(a2)+,d6

.loop:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	.end
		move.w	a0,parent3(a1)
		move.l	(a2),(a1)
		move.b	d2,subtype(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addq.w	#2,d2
		dbf	d6,.loop
		moveq	#0,d0

.end:
		rts
; End of function CreateChild6_Simple


; =============== S U B R O U T I N E =======================================


CreateChild7_Normal2:
		moveq	#0,d2				; Same as child routine 1, but does not limit children to object slots after the parent
		move.w	(a2)+,d6

.loop:
		jsr	(AllocateObject).l
		bne.s	.end
		move.w	a0,parent3(a1)
		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(a0),art_tile(a1)
		move.l	(a2)+,(a1)
		move.b	d2,subtype(a1)
		move.w	x_pos(a0),d0
		move.b	(a2)+,d1
		move.b	d1,child_dx(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,x_pos(a1)
		move.w	y_pos(a0),d0
		move.b	(a2)+,d1
		move.b	d1,child_dy(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a1)
		addq.w	#2,d2
		dbf	d6,.loop
		moveq	#0,d0

.end:
		rts
; End of function CreateChild7_Normal2


; =============== S U B R O U T I N E =======================================


CreateChild8_TreeListRepeated:
		movea.l	a0,a3				; Creates a linked object list like routine 4, but they only chain themselves one way. All maintain the calling object as their parent
		moveq	#0,d2
		move.w	(a2)+,d6

.loop:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	.end
		move.w	a3,parent3(a1)
		move.w	a0,$44(a1)
		movea.l	a1,a3
		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(a0),art_tile(a1)
		move.l	(a2),(a1)
		move.b	d2,subtype(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addq.w	#2,d2
		dbf	d6,.loop
		moveq	#0,d0

.end:
		rts
; End of function CreateChild8_TreeListRepeated


; =============== S U B R O U T I N E =======================================


Refresh_ChildPosition:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d0
		move.b	child_dx(a0),d1
		ext.w	d1
		add.w	d1,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),d0
		move.b	child_dy(a0),d1
		ext.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a0)
		rts
; End of function Refresh_ChildPosition


; =============== S U B R O U T I N E =======================================


Refresh_ChildPositionAdjusted:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d0
		move.b	child_dx(a0),d1
		ext.w	d1
		bclr	#0,render_flags(a0)
		btst	#0,render_flags(a1)
		beq.s	loc_52C96
		neg.w	d1
		bset	#0,render_flags(a0)

loc_52C96:
		add.w	d1,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),d0
		move.b	child_dy(a0),d1
		ext.w	d1
		bclr	#1,render_flags(a0)
		btst	#1,render_flags(a1)
		beq.s	loc_52CBC
		neg.w	d1
		bset	#1,render_flags(a0)

loc_52CBC:
		add.w	d1,d0
		move.w	d0,y_pos(a0)
		rts
; End of function Refresh_ChildPositionAdjusted


; =============== S U B R O U T I N E =======================================


Animate_Raw:
		movea.l	$30(a0),a1
; End of function Animate_Raw


; =============== S U B R O U T I N E =======================================


Animate_RawNoSST:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_52CEA
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#1,d0
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	1(a1,d0.w),d1
		bmi.s	loc_52CEC
		move.b	(a1),anim_frame_timer(a0)
		move.b	d1,mapping_frame(a0)

locret_52CEA:
		rts
; ---------------------------------------------------------------------------

loc_52CEC:
		neg.b	d1
		jsr	off_52CF8-4(pc,d1.w)
		clr.b	anim_frame(a0)
		rts
; End of function Animate_RawNoSST

off_52CF8:
		bra.w	AnimateRaw_Restart		;FC
; ---------------------------------------------------------------------------
		bra.w	AnimateRaw_Jump			;F8
; ---------------------------------------------------------------------------
		bra.w	AnimateRaw_CustomCode		;F4
; ---------------------------------------------------------------------------

AnimateRaw_Jump:
		move.b	2(a1,d0.w),d1
		ext.w	d1
		lea	(a1,d1.w),a1
		move.l	a1,$30(a0)

AnimateRaw_Restart:
		move.b	1(a1),mapping_frame(a0)
		move.b	(a1),anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

AnimateRaw_CustomCode:
		clr.b	anim_frame_timer(a0)
		movea.l	$34(a0),a1
		jmp	(a1)

; =============== S U B R O U T I N E =======================================


Animate_RawAdjustFlipX:
		movea.l	$30(a0),a1
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_52D5A
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#1,d0
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	1(a1,d0.w),d1
		bmi.s	loc_52CEC
		bclr	#6,d1
		beq.s	loc_52D52
		bchg	#0,render_flags(a0)

loc_52D52:
		move.b	(a1),anim_frame_timer(a0)
		move.b	d1,mapping_frame(a0)

locret_52D5A:
		rts
; End of function Animate_RawAdjustFlipX

; ---------------------------------------------------------------------------

Animate_RawAdjustFlipY:
		movea.l	$30(a0),a1
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_52D90
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#1,d0
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	1(a1,d0.w),d1
		bmi.w	loc_52CEC
		bclr	#6,d1
		beq.s	loc_52D88
		bchg	#1,render_flags(a0)

loc_52D88:
		move.b	(a1),anim_frame_timer(a0)
		move.b	d1,mapping_frame(a0)

locret_52D90:
		rts

; =============== S U B R O U T I N E =======================================


Animate_RawMultiDelay:
		movea.l	$30(a0),a1

Animate_RawNoSSTMultiDelay:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_52DBE
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#2,d0
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	(a1,d0.w),d1
		bmi.s	loc_52DC2
		move.b	d1,mapping_frame(a0)
		move.b	1(a1,d0.w),anim_frame_timer(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_52DBE:
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_52DC2:
		neg.b	d1
		jsr	off_52DCE-4(pc,d1.w)
		clr.b	anim_frame(a0)
		rts
; End of function Animate_RawMultiDelay

off_52DCE:
		bra.w	loc_52DE8
; ---------------------------------------------------------------------------
		bra.w	loc_52DDA
; ---------------------------------------------------------------------------
		bra.w	loc_52DF6
; ---------------------------------------------------------------------------

loc_52DDA:
		move.b	1(a1,d0.w),d1
		ext.w	d1
		lea	(a1,d1.w),a1
		move.l	a1,$30(a0)

loc_52DE8:
		move.b	(a1),mapping_frame(a0)
		move.b	1(a1),anim_frame_timer(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_52DF6:
		clr.b	anim_frame_timer(a0)
		movea.l	$34(a0),a1
		jsr	(a1)
		moveq	#-1,d2
		rts

; =============== S U B R O U T I N E =======================================


Animate_RawMultiDelayFlipX:
		movea.l	$30(a0),a1

Animate_RawNoSSTMultiDelayFlipX:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_52E3C
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#2,d0
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	(a1,d0.w),d1
		bmi.s	loc_52DC2
		bclr	#6,d1
		beq.s	loc_52E2E
		bchg	#0,render_flags(a0)

loc_52E2E:
		move.b	d1,mapping_frame(a0)
		move.b	1(a1,d0.w),anim_frame_timer(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_52E3C:
		moveq	#0,d2
		rts
; End of function Animate_RawMultiDelayFlipX


; =============== S U B R O U T I N E =======================================


Animate_RawMultiDelayFlipY:
		movea.l	$30(a0),a1
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_52E7A
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#2,d0
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	(a1,d0.w),d1
		bmi.w	loc_52DC2
		bclr	#6,d1
		beq.s	loc_52E6C
		bchg	#1,render_flags(a0)

loc_52E6C:
		move.b	d1,mapping_frame(a0)
		move.b	1(a1,d0.w),anim_frame_timer(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_52E7A:
		moveq	#0,d2
		rts
; End of function Animate_RawMultiDelayFlipY


; =============== S U B R O U T I N E =======================================


Animate_RawGetFaster:
		movea.l	$30(a0),a1
		bset	#5,$38(a0)
		bne.s	loc_52E92
		move.b	(a1),$2E(a0)
		clr.b	$2F(a0)

loc_52E92:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_52ECA
		move.b	$2E(a0),d2
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.b	#1,d0
		move.b	2(a1,d0.w),d1
		bpl.s	loc_52EBA
		moveq	#0,d0
		move.b	2(a1),d1
		tst.b	d2
		beq.s	loc_52ECE
		subq.b	#1,d2
		move.b	d2,$2E(a0)

loc_52EBA:
		move.b	d0,anim_frame(a0)
		move.b	d1,mapping_frame(a0)
		move.b	d2,anim_frame_timer(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_52ECA:
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_52ECE:
		move.b	d0,anim_frame(a0)
		move.b	d1,mapping_frame(a0)
		move.b	d2,anim_frame_timer(a0)
		move.b	$2F(a0),d0
		addq.b	#1,d0
		move.b	d0,$2F(a0)
		cmp.b	1(a1),d0
		blo.s	loc_52EFA
		bclr	#5,$38(a0)
		clr.b	$2F(a0)
		movea.l	$34(a0),a2
		jsr	(a2)

loc_52EFA:
		moveq	#-1,d2
		rts
; End of function Animate_RawGetFaster

; ---------------------------------------------------------------------------

Animate_RawGetSlower:
		movea.l	$30(a0),a1
		bset	#5,$38(a0)
		bne.s	loc_52F0E
		clr.w	$2E(a0)

loc_52F0E:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_52F42
		move.b	$2E(a0),d2
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.b	#1,d0
		move.b	1(a1,d0.w),d1
		bpl.s	loc_52F2E
		moveq	#0,d0
		move.b	1(a1),d1
		addq.b	#1,d2

loc_52F2E:
		move.b	d0,anim_frame(a0)
		move.b	d1,mapping_frame(a0)
		move.b	d2,anim_frame_timer(a0)
		cmp.b	(a1),d2
		bhs.s	loc_52F44
		move.b	d2,$2E(a0)

locret_52F42:
		rts
; ---------------------------------------------------------------------------

loc_52F44:
		move.b	$2F(a0),d0
		addq.b	#1,d0
		move.b	d0,$2F(a0)
		cmp.b	1(a1),d0
		blo.s	locret_52F42
		bclr	#5,$38(a0)
		clr.b	$2F(a0)
		movea.l	$34(a0),a2
		jmp	(a2)

; =============== S U B R O U T I N E =======================================


Swing_UpAndDown:
		move.w	$40(a0),d0	; Acceleration
		move.w	y_vel(a0),d1	; Velocity
		move.w	$3E(a0),d2	; Maximum acceleration before "swinging"
		moveq	#0,d3
		btst	#0,$38(a0)
		bne.s	loc_52F90
		neg.w	d0			; Apply upward acceleration
		add.w	d0,d1
		neg.w	d2
		cmp.w	d2,d1
		bgt.s	loc_52FA2
		bset	#0,$38(a0)
		neg.w	d0
		neg.w	d2
		moveq	#1,d3

loc_52F90:
		add.w	d0,d1		; Apply downward acceleration
		cmp.w	d2,d1
		blt.s	loc_52FA2
		bclr	#0,$38(a0)
		neg.w	d0
		add.w	d0,d1
		moveq	#1,d3

loc_52FA2:
		move.w	d1,y_vel(a0)
		rts
; End of function Swing_UpAndDown


; =============== S U B R O U T I N E =======================================


Swing_LeftAndRight:
		move.w	$3C(a0),d0
		move.w	x_vel(a0),d1
		move.w	$3A(a0),d2
		moveq	#0,d3
		btst	#3,$38(a0)
		bne.s	loc_52FD4
		neg.w	d0
		add.w	d0,d1
		neg.w	d2
		cmp.w	d2,d1
		bgt.s	loc_52FE6
		bset	#3,$38(a0)
		neg.w	d0
		neg.w	d2
		moveq	#1,d3

loc_52FD4:
		add.w	d0,d1
		cmp.w	d2,d1
		blt.s	loc_52FE6
		bclr	#3,$38(a0)
		neg.w	d0
		add.w	d0,d1
		moveq	#1,d3

loc_52FE6:
		move.w	d1,x_vel(a0)
		rts
; End of function Swing_LeftAndRight


; =============== S U B R O U T I N E =======================================


Swing_UpAndDown_Count:
		bsr.w	Swing_UpAndDown
		tst.w	d3
		beq.s	locret_53006
		move.b	$39(a0),d2
		subq.b	#1,d2
		move.b	d2,$39(a0)
		bmi.s	loc_53004
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_53004:
		moveq	#1,d0

locret_53006:
		rts
; End of function Swing_UpAndDown_Count


; =============== S U B R O U T I N E =======================================


Obj_Wait:
		subq.w	#1,$2E(a0)
		bmi.s	loc_53010
		rts
; ---------------------------------------------------------------------------

loc_53010:
		movea.l	$34(a0),a1
		jmp	(a1)
; End of function Obj_Wait


; =============== S U B R O U T I N E =======================================


ObjHitFloor_DoRoutine:
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_53024
		beq.s	loc_53024
		rts
; ---------------------------------------------------------------------------

loc_53024:
		add.w	d1,y_pos(a0)
		movea.l	$34(a0),a1
		jmp	(a1)
; End of function ObjHitFloor_DoRoutine


; =============== S U B R O U T I N E =======================================


ObjHitFloor2_DoRoutine:
		move.w	x_vel(a0),d3
		ext.l	d3
		lsl.l	#8,d3
		add.l	x_pos(a0),d3
		swap	d3
		jsr	(ObjCheckFloorDist2).l
		cmpi.w	#-1,d1
		blt.s	loc_53054
		cmpi.w	#$C,d1
		bge.s	loc_53054
		add.w	d1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_53054:
		movea.l	$34(a0),a1
		jmp	(a1)
; End of function ObjHitFloor2_DoRoutine


; =============== S U B R O U T I N E =======================================


ObjHitWall_DoRoutine:
		jsr	(ObjCheckRightWallDist).l
		tst.w	d1
		bmi.s	loc_53066
		rts
; ---------------------------------------------------------------------------

loc_53066:
		add.w	d1,x_pos(a0)
		movea.l	$34(a0),a1
		jmp	(a1)
; End of function ObjHitWall_DoRoutine

; ---------------------------------------------------------------------------

ObjHitWall2_DoRoutine:
		jsr	(ObjCheckLeftWallDist).l
		tst.w	d1
		bmi.s	loc_5307C
		rts
; ---------------------------------------------------------------------------

loc_5307C:
		add.w	d1,x_pos(a0)
		movea.l	$34(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

Draw_And_Touch_Sprite:
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Child_Draw_Sprite:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_530A4
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_530A4:
		bra.w	Go_Delete_Sprite
; ---------------------------------------------------------------------------

Child_DrawTouch_Sprite:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_530C0
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_530C0:
		bra.w	Go_Delete_Sprite
; ---------------------------------------------------------------------------

Child_Remember_Draw_Sprite:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_530D6
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_530D6:
		bsr.w	Remove_From_TrackingSlot
		bra.w	Go_Delete_Sprite
; ---------------------------------------------------------------------------

Child_Draw_Sprite2:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_530F0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_530F0:
		bra.w	Go_Delete_Sprite_2
; ---------------------------------------------------------------------------

Child_DrawTouch_Sprite2:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_53114
		btst	#7,status(a1)
		bne.s	loc_5310E
		jsr	(Add_SpriteToCollisionResponseList).l

loc_5310E:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_53114:
		bra.w	Go_Delete_Sprite_2
; ---------------------------------------------------------------------------

Child_Draw_Sprite_FlickerMove:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_5312A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5312A:
		bset	#7,status(a0)
		move.l	#Obj_FlickerMove,(a0)
		clr.b	collision_flags(a0)
		bsr.w	Set_IndexedVelocity
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Child_Draw_Sprite2_FlickerMove:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_5312A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Child_DrawTouch_Sprite_FlickerMove:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_5312A
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Child_DrawTouch_Sprite2_FlickerMove:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_5312A
		btst	#7,status(a1)
		beq.s	loc_5318E
		bset	#7,status(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5318E:
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_IncLevEndXGradual:
		move.w	(Camera_max_X_pos).w,d0
		move.l	$30(a0),d1
		addi.l	#$4000,d1
		move.l	d1,$30(a0)
		swap	d1
		add.w	d1,d0
		cmp.w	(Camera_stored_max_X_pos).w,d0
		bhs.s	loc_531BC
		move.w	d0,(Camera_max_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_531BC:
		move.w	(Camera_stored_max_X_pos).w,(Camera_max_X_pos).w

loc_531C2:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_DecLevStartXGradual:
		move.w	(Camera_min_X_pos).w,d0
		move.l	$30(a0),d1
		addi.l	#$4000,d1
		move.l	d1,$30(a0)
		swap	d1
		sub.w	d1,d0
		cmp.w	(Camera_stored_min_X_pos).w,d0
		ble.s	loc_531EA
		move.w	d0,(Camera_min_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_531EA:
		move.w	(Camera_stored_min_X_pos).w,(Camera_min_X_pos).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_DecLevStartYGradual:
		move.w	(Camera_min_Y_pos).w,d0
		move.l	$30(a0),d1
		addi.l	#$4000,d1
		move.l	d1,$30(a0)
		swap	d1
		sub.w	d1,d0
		cmp.w	(Camera_stored_min_Y_pos).w,d0
		ble.s	loc_53218
		move.w	d0,(Camera_min_Y_pos).w
		rts
; ---------------------------------------------------------------------------

loc_53218:
		move.w	(Camera_stored_min_Y_pos).w,(Camera_min_Y_pos).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_IncLevEndYGradual:
		move.w	(Camera_max_Y_pos).w,d0
		move.l	$30(a0),d1
		addi.l	#$8000,d1
		move.l	d1,$30(a0)
		swap	d1
		add.w	d1,d0
		cmp.w	(Camera_stored_max_Y_pos).w,d0
		bgt.s	loc_53246
		move.w	d0,(Camera_max_Y_pos).w
		rts
; ---------------------------------------------------------------------------

loc_53246:
		move.w	(Camera_stored_max_Y_pos).w,(Camera_max_Y_pos).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
Child6_IncLevX:
		dc.w 1-1
		dc.l Obj_IncLevEndXGradual
Child6_DecLevX:
		dc.w 1-1
		dc.l Obj_DecLevStartXGradual
Child6_DecLevY:
		dc.w 1-1
		dc.l Obj_DecLevStartYGradual
Child6_IncLevY:
		dc.w 1-1
		dc.l Obj_IncLevEndYGradual

; =============== S U B R O U T I N E =======================================


Find_SonicTails:
		moveq	#0,d0			; d0 = 0 if Sonic/Tails is left of object, 2 if right of object
		moveq	#0,d1			; d1 = 0 if Sonic/Tails is above object, 2 if below object
		lea	(Player_1).w,a1
		move.w	x_pos(a0),d2
		sub.w	x_pos(a1),d2
		bpl.s	loc_53280
		neg.w	d2
		addq.w	#2,d0

loc_53280:
		lea	(Player_2).w,a2
		move.w	x_pos(a0),d3
		sub.w	x_pos(a2),d3
		bpl.s	loc_53292
		neg.w	d3
		addq.w	#2,d1

loc_53292:
		cmp.w	d3,d2
		bls.s	loc_5329C
		movea.l	a2,a1
		move.w	d1,d0
		move.w	d3,d2

loc_5329C:
		moveq	#0,d1
		move.w	y_pos(a0),d3
		sub.w	y_pos(a1),d3
		bpl.s	locret_532AC
		neg.w	d3
		addq.w	#2,d1

locret_532AC:
		rts
; End of function Find_SonicTails


; =============== S U B R O U T I N E =======================================


Change_FlipX:
		bclr	#0,render_flags(a0)
		tst.w	d0
		beq.s	.return
		bset	#0,render_flags(a0)

.return:
		rts
; End of function Change_FlipX


; =============== S U B R O U T I N E =======================================


Change_FlipXWithVelocity:
		bclr	#0,render_flags(a0)
		tst.w	x_vel(a0)
		bmi.s	.return
		bset	#0,render_flags(a0)

.return:
		rts
; End of function Change_FlipXWithVelocity


; =============== S U B R O U T I N E =======================================


Change_FlipXUseParent:
		bclr	#0,render_flags(a0)
		movea.w	parent3(a0),a1
		btst	#0,render_flags(a1)
		beq.s	.return
		bset	#0,render_flags(a0)

.return:
		rts
; End of function Change_FlipXUseParent


; =============== S U B R O U T I N E =======================================


Find_OtherObject:
		moveq	#0,d0			; d0 = 0 if other object is left of calling object, 2 if right of it
		moveq	#0,d1			; d1 = 0 if other object is above calling object, 2 if below it
		move.w	x_pos(a0),d2
		sub.w	x_pos(a1),d2
		bpl.s	loc_53300
		neg.w	d2
		addq.w	#2,d0

loc_53300:
		moveq	#0,d1
		move.w	y_pos(a0),d3
		sub.w	y_pos(a1),d3
		bpl.s	locret_53310
		neg.w	d3
		addq.w	#2,d1

locret_53310:
		rts
; End of function Find_OtherObject


; =============== S U B R O U T I N E =======================================


MoveSprite_LightGravity:
		moveq	#$20,d1
		move.w	x_vel(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,x_pos(a0)
		move.w	y_vel(a0),d0
		add.w	d1,y_vel(a0)
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,y_pos(a0)
		rts
; End of function MoveSprite_LightGravity


; =============== S U B R O U T I N E =======================================


MoveSprite_CircularSimple:
		move.b	$3C(a0),d0
		jsr	(GetSineCosine).l
		asr.w	d2,d0
		asr.w	d2,d1
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d2
		move.w	y_pos(a1),d3
		add.w	d0,d2
		add.w	d1,d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		rts
; End of function MoveSprite_CircularSimple


; =============== S U B R O U T I N E =======================================


MoveSprite_CircularSimpleOffset:
		move.b	$3C(a0),d0
		jsr	(GetSineCosine).l
		asr.w	d2,d0
		asr.w	d2,d1
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d2
		move.w	y_pos(a1),d3
		move.b	child_dx(a0),d4
		ext.w	d4
		add.w	d4,d2
		move.b	child_dy(a0),d4
		ext.w	d4
		add.w	d4,d3
		add.w	d0,d2
		add.w	d1,d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		rts
; End of function MoveSprite_CircularSimpleOffset


; =============== S U B R O U T I N E =======================================


MoveSprite_AtAngleLookup:
		moveq	#0,d0
		move.b	$3C(a0),d0
		move.w	d0,d1
		andi.w	#$3F,d0
		lsr.w	#5,d1
		andi.w	#6,d1
		movea.w	parent3(a0),a1
		lea	$40(a2),a3
		move.w	x_pos(a1),d2
		move.w	y_pos(a1),d3
		move.w	d0,d4
		not.w	d4
		move.w	AtAngle_LookupIndex(pc,d1.w),d1
		jsr	AtAngle_LookupIndex(pc,d1.w)
		add.w	d5,d2
		add.w	d6,d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		rts
; End of function MoveSprite_AtAngleLookup

; ---------------------------------------------------------------------------
AtAngle_LookupIndex:
		dc.w AtAngle_00_3F-AtAngle_LookupIndex
		dc.w AtAngle_40_7F-AtAngle_LookupIndex
		dc.w AtAngle_80_BF-AtAngle_LookupIndex
		dc.w AtAngle_C0_FF-AtAngle_LookupIndex
; ---------------------------------------------------------------------------

AtAngle_00_3F:
		moveq	#0,d5
		move.b	(a2,d0.w),d5
		moveq	#0,d6
		move.b	(a3,d4.w),d6
		rts
; ---------------------------------------------------------------------------

AtAngle_40_7F:
		moveq	#0,d5
		move.b	(a3,d4.w),d5
		moveq	#0,d6
		move.b	(a2,d0.w),d6
		neg.w	d6
		rts
; ---------------------------------------------------------------------------

AtAngle_80_BF:
		moveq	#0,d5
		move.b	(a2,d0.w),d5
		neg.w	d5
		moveq	#0,d6
		move.b	(a3,d4.w),d6
		neg.w	d6
		rts
; ---------------------------------------------------------------------------

AtAngle_C0_FF:
		moveq	#0,d5
		move.b	(a3,d4.w),d5
		neg.w	d5
		moveq	#0,d6
		move.b	(a2,d0.w),d6
		rts

; =============== S U B R O U T I N E =======================================


MoveSprite_CircularLookup:
		moveq	#0,d0
		move.b	$3C(a0),d0
		move.w	d0,d1
		andi.w	#$3F,d0
		lsr.w	#5,d1
		andi.w	#6,d1
		movea.w	parent3(a0),a1
		lea	$40(a2),a3
		move.w	x_pos(a1),d2
		move.w	y_pos(a1),d3
		move.b	child_dx(a0),d4
		ext.w	d4
		btst	#0,render_flags(a0)
		beq.s	loc_53448
		neg.w	d4

loc_53448:
		add.w	d4,d2
		move.b	child_dy(a0),d4
		ext.w	d4
		add.w	d4,d3
		move.w	d0,d4
		not.w	d4
		lea	AtAngle_LookupIndex(pc),a4
		move.w	(a4,d1.w),d1
		jsr	(a4,d1.w)
		btst	#0,render_flags(a0)
		beq.s	loc_5346C
		neg.w	d5

loc_5346C:
		add.w	d5,d2
		add.w	d6,d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		rts
; End of function MoveSprite_CircularLookup


; =============== S U B R O U T I N E =======================================


MoveSprite_AngleYLookup:
		moveq	#0,d0
		move.b	$3C(a0),d0
		move.w	d0,d1
		andi.w	#$3F,d0
		lsr.w	#5,d1
		andi.w	#6,d1
		movea.w	parent3(a0),a1
		lea	$40(a2),a3
		move.w	y_pos(a1),d3
		move.w	d0,d4
		not.w	d4
		move.w	AngleY_LookupIndex(pc,d1.w),d1
		jsr	AngleY_LookupIndex(pc,d1.w)
		add.w	d1,d3
		move.w	d3,y_pos(a0)
		rts
; End of function MoveSprite_AngleYLookup

; ---------------------------------------------------------------------------
AngleY_LookupIndex:
		dc.w loc_534B4-AngleY_LookupIndex
		dc.w loc_534BC-AngleY_LookupIndex
		dc.w loc_534C6-AngleY_LookupIndex
		dc.w loc_534D0-AngleY_LookupIndex
; ---------------------------------------------------------------------------

loc_534B4:
		moveq	#0,d1
		move.b	(a3,d4.w),d1
		rts
; ---------------------------------------------------------------------------

loc_534BC:
		moveq	#0,d1
		move.b	(a2,d0.w),d1
		neg.w	d1
		rts
; ---------------------------------------------------------------------------

loc_534C6:
		moveq	#0,d1
		move.b	(a3,d4.w),d1
		neg.w	d1
		rts
; ---------------------------------------------------------------------------

loc_534D0:
		moveq	#0,d1
		move.b	(a2,d0.w),d1
		rts

; =============== S U B R O U T I N E =======================================


MoveSprite_AngleXLookupOffset:
		moveq	#0,d0
		move.b	$3C(a0),d0
		move.b	d0,d1
		rol.b	#3,d1
		andi.w	#6,d1
		move.w	AngleX_LookupIndex(pc,d1.w),d2
		jmp	AngleX_LookupIndex(pc,d2.w)
; End of function MoveSprite_AngleXLookupOffset

; ---------------------------------------------------------------------------
AngleX_LookupIndex:
		dc.w loc_534F6-AngleX_LookupIndex
		dc.w loc_534FE-AngleX_LookupIndex
		dc.w loc_5350A-AngleX_LookupIndex
		dc.w loc_5351A-AngleX_LookupIndex
; ---------------------------------------------------------------------------

loc_534F6:
		move.b	(a1,d0.w),d1
		bra.w	loc_5352A
; ---------------------------------------------------------------------------

loc_534FE:
		moveq	#$7F,d1
		sub.w	d0,d1
		move.b	(a1,d1.w),d1
		bra.w	loc_5352A
; ---------------------------------------------------------------------------

loc_5350A:
		move.w	d0,d1
		andi.w	#$3F,d1
		move.b	(a1,d1.w),d1
		neg.w	d1
		bra.w	loc_5352A
; ---------------------------------------------------------------------------

loc_5351A:
		move.w	#$FF,d1
		sub.w	d0,d1
		move.b	(a1,d1.w),d1
		neg.w	d1
		bra.w	loc_5352A
; ---------------------------------------------------------------------------

loc_5352A:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d2
		move.b	child_dx(a0),d3
		ext.w	d3
		add.w	d3,d2
		add.w	d1,d2
		move.w	d2,x_pos(a0)
		move.w	y_pos(a1),d2
		move.b	child_dy(a0),d3
		ext.w	d3
		add.w	d3,d2
		move.w	d2,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
		moveq	#0,d0			; Same as above but unused
		move.b	$3C(a0),d0
		move.b	d0,d1
		rol.b	#3,d1
		andi.w	#6,d1
		move.w	off_53568(pc,d1.w),d2
		jmp	off_53568(pc,d2.w)
; ---------------------------------------------------------------------------
off_53568:
		dc.w loc_53570-off_53568
		dc.w loc_53578-off_53568
		dc.w loc_53584-off_53568
		dc.w loc_53594-off_53568
; ---------------------------------------------------------------------------

loc_53570:
		move.b	(a1,d0.w),d1
		bra.w	loc_535A4
; ---------------------------------------------------------------------------

loc_53578:
		moveq	#$7F,d1
		sub.w	d0,d1
		move.w	(a1,d1.w),d1
		bra.w	loc_535A4
; ---------------------------------------------------------------------------

loc_53584:
		move.w	d0,d1
		andi.w	#$3F,d1
		move.w	(a1,d1.w),d1
		neg.w	d1
		bra.w	loc_535A4
; ---------------------------------------------------------------------------

loc_53594:
		move.w	#$FF,d1
		sub.w	d0,d1
		move.w	(a1,d1.w),d1
		neg.w	d1
		bra.w	loc_535A4
; ---------------------------------------------------------------------------

loc_535A4:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d2
		move.b	child_dx(a0),d3
		ext.w	d3
		add.w	d3,d2
		move.w	d2,x_pos(a0)
		move.w	y_pos(a1),d2
		move.b	child_dy(a0),d3
		ext.w	d3
		add.w	d3,d2
		add.w	d1,d2
		move.w	d2,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
		subq.w	#1,$2E(a0)			; Timed object, not actually used
		bmi.w	Go_Delete_Sprite
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		subq.w	#1,$2E(a0)			; Timed object with gravity-influenced movement
		bmi.w	Go_Delete_Sprite
		jsr	(MoveSprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

MoveDraw_SpriteTimed:
		subq.w	#1,$2E(a0)
		bmi.w	Go_Delete_Sprite
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

MoveDraw_SpriteTimed2:
		subq.w	#1,$2E(a0)
		bmi.w	Go_Delete_Sprite
		jsr	(MoveSprite_LightGravity).l
		bra.w	Draw_And_Touch_Sprite

; =============== S U B R O U T I N E =======================================


TimedSprite_ScreenLock:
		subq.w	#1,$2E(a0)
		bmi.s	loc_5361C
		rts
; ---------------------------------------------------------------------------

loc_5361C:
		move.b	#1,(Boss_flag).w
		bra.w	Go_Delete_Sprite_2
; End of function TimedSprite_ScreenLock


; =============== S U B R O U T I N E =======================================


BossFlash:
		lea	(Normal_palette_line_2+$2).w,a1
		moveq	#0,d0
		tst.w	(a1)
		bne.s	.noflash
		move.w	#$EEE,d0

.noflash:
		move.w	d0,(a1)
		rts
; End of function BossFlash


; =============== S U B R O U T I N E =======================================


SetUp_ObjAttributesSlotted:
		moveq	#0,d0
		move.w	(a1)+,d1		; Maximum number of objects that can be made in this array
		move.w	d1,d2
		move.w	(a1)+,d3		; Base VRAM offset of object
		move.w	(a1)+,d4		; Amount to add to base VRAM offset for each slot
		moveq	#0,d5
		move.w	(a1)+,d5		; Index of slot array to use
		lea	(Slotted_object_bits).w,a2
		adda.w	d5,a2			; Get the address of the array to use
		move.b	(a2),d5
		beq.s	loc_53678		; If array is clear, just make the object

loc_53650:
		lsr.b	#1,d5			; Check slot (each bit)
		bcc.s	loc_53678		; If clear, make object
		addq.w	#1,d0			; Increment bit number
		add.w	d4,d3			; Add VRAM offset
		dbf	d1,loc_53650		; Repeat max times
		moveq	#0,d0
		move.l	d0,(a0)
		move.l	d0,x_pos(a0)
		move.l	d0,y_pos(a0)
		move.b	d0,subtype(a0)
		move.b	d0,render_flags(a0)
		move.w	d0,status(a0)		; If no open slots, then destroy this object period
		addq.w	#8,sp
		rts
; ---------------------------------------------------------------------------

loc_53678:
		bset	d0,(a2)			; Turn this slot on
		move.b	d0,ros_bit(a0)
		move.w	a2,ros_addr(a0)		; Keep track of slot address and bit number
		move.w	d3,art_tile(a0)		; Use correct VRAM offset
		move.l	(a1)+,mappings(a0)	; Mapping address
		move.w	(a1)+,priority(a0)	; Priority
		move.b	(a1)+,width_pixels(a0)	; Width
		move.b	(a1)+,height_pixels(a0)	; Height
		move.b	(a1)+,mapping_frame(a0)	; Frame number
		move.b	(a1)+,collision_flags(a0)	; Collision number
		bset	#2,status(a0)		; Turn object slotting on
		move.b	#-1,objoff_3A(a0)	; Reset objoff_3A (used by Perform_DPLC)
		bset	#2,render_flags(a0)	; Use screen coordinates
		addq.b	#2,routine(a0)		; Next routine
		rts
; End of function SetUp_ObjAttributesSlotted


; =============== S U B R O U T I N E =======================================


Perform_DPLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0	; Get the frame number
		cmp.b	$3A(a0),d0		; If frame number remains the same as before, don't do anything
		beq.s	.end
		move.b	d0,$3A(a0)
		movea.l	(a2)+,a3		; Source address of art
		move.w	art_tile(a0),d4
		andi.w	#$7FF,d4		; Isolate tile location offset
		lsl.w	#5,d4			; Convert to VRAM address
		movea.l	(a2)+,a2		; Address of DPLC script
		add.w	d0,d0
		adda.w	(a2,d0.w),a2		; Apply offset to script
		move.w	(a2)+,d5		; Get number of DMA transactions
		moveq	#0,d3

.loop:
		move.w	(a2)+,d3		; Art source offset
		move.l	d3,d1
		andi.w	#$FFF0,d1		; Isolate all but lower 4 bits
		add.w	d1,d1
		add.l	a3,d1			; Get final source address of art
		move.w	d4,d2			; Destination VRAM address
		andi.w	#$F,d3
		addq.w	#1,d3
		lsl.w	#4,d3			; d3 is the total number of words to transfer (maximum 16 tiles per transaction)
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l	; Add to queue
		dbf	d5,.loop		; Keep going

.end:
		rts
; End of function Perform_DPLC

; ---------------------------------------------------------------------------

Sprite_CheckDelete:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	loc_5371C
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5371C:
		move.w	respawn_addr(a0),d0
		beq.s	loc_53728
		movea.w	d0,a2
		bclr	#7,(a2)

loc_53728:
		bset	#7,status(a0)
		move.l	#Delete_Current_Sprite,(a0)
		rts
; ---------------------------------------------------------------------------

Sprite_CheckDelete2:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	loc_5374E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5374E:
		move.w	respawn_addr(a0),d0
		beq.s	loc_5375A
		movea.w	d0,a2
		bclr	#7,(a2)

loc_5375A:
		bset	#4,$38(a0)
		move.l	#Delete_Current_Sprite,(a0)
		rts
; ---------------------------------------------------------------------------
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	loc_5371C
		rts
; ---------------------------------------------------------------------------

Sprite_CheckDeleteXY:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_Sprite
		move.w	y_pos(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmpi.w	#$200,d0
		bhi.w	Go_Delete_Sprite
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_FlickerMove:
		jsr	(MoveSprite).l
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_Sprite
		move.w	y_pos(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmpi.w	#$200,d0
		bhi.w	Go_Delete_Sprite
		btst	#0,(V_int_run_count+3).w
		beq.w	locret_529CE
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouch:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_5371C
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouch2:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_5374E
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_5371C
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouchXY:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_Sprite
		move.w	y_pos(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmpi.w	#$200,d0
		bhi.w	Go_Delete_Sprite
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Sprite_CheckDeleteSlotted:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	Go_Delete_SpriteSlotted
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Go_Delete_SpriteSlotted:
		move.w	respawn_addr(a0),d0
		beq.s	Go_Delete_SpriteSlotted2
		movea.w	d0,a2
		bclr	#7,(a2)

Go_Delete_SpriteSlotted2:
		move.l	#Delete_Current_Sprite,(a0)
		bset	#7,status(a0)

; =============== S U B R O U T I N E =======================================


Remove_From_TrackingSlot:
		move.b	ros_bit(a0),d0
		movea.w	ros_addr(a0),a1
		bclr	d0,(a1)
		rts
; End of function Remove_From_TrackingSlot

; ---------------------------------------------------------------------------
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	Go_Delete_SpriteSlotted
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouchSlotted:
		tst.b	status(a0)
		bmi.s	Go_Delete_SpriteSlotted3
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	Go_Delete_SpriteSlotted
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Go_Delete_SpriteSlotted3:
		move.l	#Delete_Current_Sprite,(a0)
		bra.s	Remove_From_TrackingSlot
; ---------------------------------------------------------------------------
		tst.b	status(a0)				; Unused, seems to be identical to the above
		bmi.s	Go_Delete_SpriteSlotted3
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_SpriteSlotted
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		move.w	x_pos(a0),d0				; Next six are unused, virtually the same
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_Sprite
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_Sprite
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_Sprite_2
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_Sprite_2
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_SpriteSlotted2
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_SpriteSlotted2
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_539C4:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_Sprite_2
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


Go_Delete_Sprite:
		move.l	#Delete_Current_Sprite,(a0)
		bset	#7,status(a0)
		rts
; End of function Go_Delete_Sprite


; =============== S U B R O U T I N E =======================================


Go_Delete_Sprite_2:
		move.l	#Delete_Current_Sprite,(a0)
		bset	#4,$38(a0)
		rts
; End of function Go_Delete_Sprite_2


; =============== S U B R O U T I N E =======================================


Set_IndexedVelocity:
		moveq	#0,d1
		move.b	subtype(a0),d1
		add.w	d1,d1
		add.w	d1,d0
		lea	Obj_VelocityIndex(pc,d0.w),a1
		move.w	(a1)+,x_vel(a0)
		move.w	(a1)+,y_vel(a0)
		btst	#0,render_flags(a0)
		beq.s	.noflip
		neg.w	x_vel(a0)

.noflip:
		rts
; End of function Set_IndexedVelocity

; ---------------------------------------------------------------------------
Obj_VelocityIndex:
		dc.w  -$100, -$100
		dc.w   $100, -$100
		dc.w  -$200, -$200
		dc.w   $200, -$200
		dc.w  -$300, -$200
		dc.w   $300, -$200
		dc.w  -$200, -$200
		dc.w      0, -$200
		dc.w  -$400, -$300
		dc.w   $400, -$300
		dc.w   $300, -$300
		dc.w  -$400, -$300
		dc.w   $400, -$300
		dc.w  -$200, -$200
		dc.w   $200, -$200
		dc.w      0, -$100
		dc.w   -$40, -$700
		dc.w   -$80, -$700
		dc.w  -$180, -$700
		dc.w  -$100, -$700
		dc.w  -$200, -$700
		dc.w  -$280, -$700
		dc.w  -$300, -$700

; =============== S U B R O U T I N E =======================================


Find_SonicTails8Way:
		bsr.w	Find_SonicTails		; This routine seems bugged slightly. Shouldn't the first two cmpi instructions look at d3 and not d2?
		cmp.w	d2,d3
		beq.s	loc_53AD0
		bhi.s	loc_53AAA
		swap	d3			; If Y distance is closer to object
		clr.w	d3
		divu.w	d2,d3
		tst.w	d0
		beq.s	loc_53A9C
		cmpi.w	#$8000,d2	; If Y was closer and Sonic is to right of object
		blo.s	loc_53AEC
		tst.w	d0
		beq.s	loc_53AE8
		bra.w	loc_53AF0
; ---------------------------------------------------------------------------

loc_53A9C:
		cmpi.w	#$8000,d2	; If Y was closer and Sonic is to left of object
		blo.s	loc_53AFC
		tst.w	d1
		bne.s	loc_53AF8
		bra.w	loc_53B00
; ---------------------------------------------------------------------------

loc_53AAA:
		swap	d2			; If X distance is closer to object
		clr.w	d2
		divu.w	d3,d2
		tst.w	d1
		bne.s	loc_53AC2
		cmpi.w	#$8000,d2
		blo.s	loc_53AE4
		tst.w	d0
		bne.s	loc_53AE8
		bra.w	loc_53B00
; ---------------------------------------------------------------------------

loc_53AC2:
		cmpi.w	#$8000,d2
		blo.s	loc_53AF4
		tst.w	d0
		bne.s	loc_53AF0
		bra.w	loc_53AF8
; ---------------------------------------------------------------------------

loc_53AD0:
		tst.w	d0				; If X and Y distance are identical
		beq.s	loc_53ADC
		tst.w	d1
		beq.s	loc_53AE8
		bra.w	loc_53AF0
; ---------------------------------------------------------------------------

loc_53ADC:
		tst.w	d1
		bne.s	loc_53AF8
		bra.w	loc_53B00
; ---------------------------------------------------------------------------

loc_53AE4:
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_53AE8:
		moveq	#1,d4
		rts
; ---------------------------------------------------------------------------

loc_53AEC:
		moveq	#2,d4
		rts
; ---------------------------------------------------------------------------

loc_53AF0:
		moveq	#3,d4
		rts
; ---------------------------------------------------------------------------

loc_53AF4:
		moveq	#4,d4
		rts
; ---------------------------------------------------------------------------

loc_53AF8:
		moveq	#5,d4
		rts
; ---------------------------------------------------------------------------

loc_53AFC:
		moveq	#6,d4
		rts
; ---------------------------------------------------------------------------

loc_53B00:
		moveq	#7,d4
		rts
; End of function Find_SonicTails8Way


; =============== S U B R O U T I N E =======================================


Set_VelocityXTrackSonic:
		lea	(Player_1).w,a1
		bsr.w	Find_OtherObject
		bclr	#0,render_flags(a0)
		tst.w	d0
		beq.s	loc_53B1E
		neg.w	d4
		bset	#0,render_flags(a0)

loc_53B1E:
		move.w	d4,x_vel(a0)
		rts
; End of function Set_VelocityXTrackSonic


; =============== S U B R O U T I N E =======================================


Chase_Object:
		move.w	d0,d2			; d0 = Maximum speed
		neg.w	d2
		move.w	d1,d3			; d1 = acceleration
		move.w	x_pos(a0),d4
		cmp.w	x_pos(a1),d4
		seq	d5
		beq.s	loc_53B4C
		bcs.s	loc_53B3A
		neg.w	d1

loc_53B3A:
		move.w	x_vel(a0),d4
		add.w	d1,d4
		cmp.w	d2,d4
		blt.s	loc_53B4C
		cmp.w	d0,d4
		bgt.s	loc_53B4C
		move.w	d4,x_vel(a0)

loc_53B4C:
		move.w	y_pos(a0),d4
		cmp.w	y_pos(a1),d4
		beq.s	loc_53B6E
		bcs.s	loc_53B5A
		neg.w	d3

loc_53B5A:
		move.w	y_vel(a0),d4
		add.w	d3,d4
		cmp.w	d2,d4
		blt.s	locret_53B6C
		cmp.w	d0,d4
		bgt.s	locret_53B6C
		move.w	d4,y_vel(a0)

locret_53B6C:
		rts
; ---------------------------------------------------------------------------

loc_53B6E:
		tst.b	d5
		beq.s	locret_53B6C
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		rts
; End of function Chase_Object


; =============== S U B R O U T I N E =======================================


Chase_ObjectXOnly:
		move.w	d0,d2
		neg.w	d2
		move.w	x_pos(a1),d3
		move.b	child_dx(a0),d4
		ext.w	d4
		add.w	d4,d3
		cmp.w	x_pos(a0),d3
		bhs.s	loc_53B94
		neg.w	d1

loc_53B94:
		move.w	x_vel(a0),d3
		add.w	d1,d3
		cmp.w	d2,d3
		blt.s	locret_53BA6
		cmp.w	d0,d3
		bgt.s	locret_53BA6
		move.w	d3,x_vel(a0)

locret_53BA6:
		rts
; End of function Chase_ObjectXOnly


; =============== S U B R O U T I N E =======================================


Chase_ObjectYOnly:
		move.w	d0,d2
		neg.w	d2
		move.w	y_pos(a1),d3
		move.b	child_dy(a0),d4
		ext.w	d4
		add.w	d4,d3
		cmp.w	y_pos(a0),d3
		bhs.s	loc_53BC0
		neg.w	d1

loc_53BC0:
		move.w	y_vel(a0),d3
		add.w	d1,d3
		cmp.w	d2,d3
		blt.s	locret_53BD2
		cmp.w	d0,d3
		bgt.s	locret_53BD2
		move.w	d3,y_vel(a0)

locret_53BD2:
		rts
; End of function Chase_ObjectYOnly

; ---------------------------------------------------------------------------
		move.w	d0,d2			; Unused, seems to be a combination of the above two routines, but additionally using offsets
		neg.w	d2
		move.w	d1,d3
		move.w	x_pos(a1),d6
		move.b	child_dx(a0),d4
		ext.w	d4
		add.w	d4,d6
		cmp.w	x_pos(a0),d6
		seq	d5
		beq.s	loc_53C04
		bcc.s	loc_53BF2
		neg.w	d1

loc_53BF2:
		move.w	x_vel(a0),d4
		add.w	d1,d4
		cmp.w	d2,d4
		blt.s	loc_53C04
		cmp.w	d0,d4
		bgt.s	loc_53C04
		move.w	d4,x_vel(a0)

loc_53C04:
		move.w	y_pos(a1),d6
		move.b	child_dy(a0),d4
		ext.w	d4
		add.w	d4,d6
		cmp.w	y_pos(a0),d6
		beq.s	loc_53C2E
		bcc.s	loc_53C1A
		neg.w	d3

loc_53C1A:
		move.w	y_vel(a0),d4
		add.w	d3,d4
		cmp.w	d2,d4
		blt.s	locret_53C2C
		cmp.w	d0,d4
		bgt.s	locret_53C2C
		move.w	d4,y_vel(a0)

locret_53C2C:
		rts
; ---------------------------------------------------------------------------

loc_53C2E:
		tst.b	d5
		beq.s	locret_53C2C
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

Obj_FadeSelectedFromBlack:
		move.l	#loc_53C4E,(a0)
		move.b	#7,$39(a0)
		move.b	#3,$2F(a0)

loc_53C4E:
		subq.b	#1,$2E(a0)
		bmi.s	loc_53C56
		rts
; ---------------------------------------------------------------------------

loc_53C56:
		subq.b	#1,$39(a0)
		bmi.w	loc_531C2
		move.b	$2F(a0),$2E(a0)
		lea	(Normal_palette_line_2).w,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#$E,d4
		moveq	#-$20,d5
		moveq	#$20-1,d6

loc_53C72:
		bsr.w	IncColor_Obj
		dbf	d6,loc_53C72
		rts

; =============== S U B R O U T I N E =======================================


IncColor_Obj:
		move.b	(a1),d0
		and.b	d4,d0
		move.b	(a2)+,d1
		and.b	d4,d1
		cmp.b	d1,d0
		bhs.s	loc_53C8A
		addq.b	#2,d0

loc_53C8A:
		move.b	d0,(a1)+
		move.b	(a1),d0
		move.b	d0,d1
		and.b	d5,d0
		move.b	(a2)+,d2
		move.b	d2,d3
		and.b	d5,d2
		cmp.b	d2,d0
		bhs.s	loc_53CA0
		addi.b	#$20,d0

loc_53CA0:
		and.b	d4,d1
		and.b	d4,d3
		cmp.b	d3,d1
		bhs.s	loc_53CAA
		addq.b	#2,d1

loc_53CAA:
		or.b	d0,d1
		move.b	d1,(a1)+
		rts
; End of function IncColor_Obj

; ---------------------------------------------------------------------------

MoveFall_AnimateRaw:
		jsr	(MoveSprite).l
		jmp	Animate_Raw(pc)
; ---------------------------------------------------------------------------

Move_AnimateRaw:
		jsr	(MoveSprite2).l
		jmp	Animate_Raw(pc)
; ---------------------------------------------------------------------------

MoveSlowFall_AnimateRaw:
		jsr	MoveSprite_LightGravity(pc)
		jmp	Animate_Raw(pc)
; ---------------------------------------------------------------------------
		jsr	Swing_UpAndDown(pc)

Move_AnimateRaw_Wait:
		jsr	(MoveSprite2).l

loc_53CD6:
		jsr	Animate_Raw(pc)
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

Refresh_ChildPosWait:
		jsr	Refresh_ChildPosition(pc)

Wait_Draw:
		jsr	Obj_Wait(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

MoveWaitTouch:
		jsr	(MoveSprite2).l
		jsr	Obj_Wait(pc)
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------

loc_53CFA:
		jsr	Refresh_ChildPosition(pc)

AnimateRaw_DrawTouch:
		jsr	Animate_RawMultiDelay(pc)
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------

AnimateRaw_MoveChkDel:
		jsr	Animate_Raw(pc)

MoveChkDel:
		jsr	(MoveSprite).l
		jmp	Sprite_CheckDeleteXY(pc)
; ---------------------------------------------------------------------------
		jsr	Animate_Raw(pc)

MoveTouchChkDel:
		jsr	(MoveSprite).l
		jmp	Sprite_CheckDeleteTouchXY(pc)
; ---------------------------------------------------------------------------

Move_WaitNoFall:
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

Swing_MoveWaitNoFall:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------
		jsr	Animate_Raw(pc)
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------
		jsr	Animate_Raw(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		jsr	(MoveSprite2).l
		jsr	Animate_Raw(pc)
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		jsr	Animate_Raw(pc)
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------

EnemyDefeat_Score:
		bset	#7,status(a0)
		movea.w	$44(a0),a1
		moveq	#0,d0
		move.w	(Chain_bonus_counter).w,d0
		addq.w	#2,(Chain_bonus_counter).w
		cmpi.w	#6,d0
		blo.s	loc_53D88
		moveq	#6,d0

loc_53D88:
		move.w	d0,$3E(a0)
		move.w	word_53DE8(pc,d0.w),d0
		cmpi.w	#$20,(Chain_bonus_counter).w
		blo.s	loc_53DA2
		move.w	#1000,d0	; 10000 points
		move.w	#$A,$3E(a0)

loc_53DA2:
		movea.w	a1,a3
		jsr	(HUD_AddToScore).l
		move.l	#Obj_Explosion,(a0)
		move.b	#0,routine(a0)
		tst.w	y_vel(a1)
		bmi.s	loc_53DD0
		move.w	y_pos(a1),d0
		cmp.w	y_pos(a0),d0
		bcc.s	loc_53DDC
		neg.w	y_vel(a1)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_53DD0:
		addi.w	#$100,y_vel(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_53DDC:
		subi.w	#$100,y_vel(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
word_53DE8:
		dc.w 10			; 100 points
		dc.w 20			; 200 points
		dc.w 50			; 500 points
		dc.w 100		; 1000 points

; =============== S U B R O U T I N E =======================================


Check_LRControllerShake:
		subq.b	#1,$3D(a0)
		bpl.s	loc_53E02
		move.b	#5,$3C(a0)
		move.b	#60,$3D(a0)

loc_53E02:
		movea.w	$3E(a0),a2
		move.w	(a2),d0
		andi.w	#$C,d0
		beq.s	locret_53E26
		move.w	$3A(a0),d1
		move.w	d0,$3A(a0)
		andi.w	#$C,d1
		eor.w	d1,d0
		beq.s	locret_53E26
		subq.b	#1,$3C(a0)
		bmi.s	locret_53E26
		moveq	#0,d0

locret_53E26:
		rts
; End of function Check_LRControllerShake


; =============== S U B R O U T I N E =======================================


Check_PlayerCollision:
		move.b	collision_property(a0),d0
		beq.s	locret_53E50
		clr.b	collision_property(a0)
		move.w	parent3(a0),d1
		beq.s	loc_53E40
		movea.w	d1,a1
		bset	#0,$38(a1)

loc_53E40:
		andi.w	#3,d0
		add.w	d0,d0
		movea.w	word_53E52-2(pc,d0.w),a1
		move.w	a1,$44(a0)
		moveq	#1,d1

locret_53E50:
		rts
; End of function Check_PlayerCollision

; ---------------------------------------------------------------------------
word_53E52:
		dc.w Player_1
		dc.w Player_2
		dc.w Player_1

; =============== S U B R O U T I N E =======================================


Check_PlayerInRange:
		moveq	#0,d0
		lea	(Player_2).w,a2
		move.w	x_pos(a2),d1
		move.w	y_pos(a2),d2
		move.w	x_pos(a0),d3
		move.w	y_pos(a0),d4
		add.w	(a1)+,d3
		move.w	d3,d5
		add.w	(a1)+,d5
		add.w	(a1)+,d4
		move.w	d4,d6
		add.w	(a1)+,d6
		bsr.w	sub_53E8C
		swap	d0
		lea	(Player_1).w,a2
		move.w	x_pos(a2),d1
		move.w	y_pos(a2),d2
; End of function Check_PlayerInRange


; =============== S U B R O U T I N E =======================================


sub_53E8C:
		cmp.w	d3,d1
		blo.s	locret_53E9E
		cmp.w	d5,d1
		bhs.s	locret_53E9E
		cmp.w	d4,d2
		blo.s	locret_53E9E
		cmp.w	d6,d2
		bhs.s	locret_53E9E
		move.w	a2,d0

locret_53E9E:
		rts
; End of function sub_53E8C


; =============== S U B R O U T I N E =======================================


PalLoad_Line1:
		lea	(Normal_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d0

.loop:
		move.l	(a1)+,(a2)+
		dbf	d0,.loop
		rts
; End of function PalLoad_Line1


; =============== S U B R O U T I N E =======================================


Displace_PlayerOffObject:
		move.b	status(a0),d0
		andi.b	#standing_mask,d0
		beq.s	locret_53EE8
		bclr	#p1_standing_bit,status(a0)
		beq.s	loc_53ED0
		lea	(Player_1).w,a1
		; This should clear Status_OnObj instead of p1_standing_bit.
		; Thankfully, they both equal 3. Sonic (3) & Knuckles corrects this.
		bclr	#p1_standing_bit,status(a1)
		bset	#Status_InAir,status(a1)

loc_53ED0:
		bclr	#p2_standing_bit,status(a0)
		beq.s	locret_53EE8
		lea	(Player_2).w,a1
		; Bug: this should clear Status_OnObj instead of p2_standing_bit.
		; As a result, player 2's Status_RollJump is cleared instead.
		; Sonic (3) & Knuckles corrects this as well.
		bclr	#p2_standing_bit,status(a1)
		bset	#Status_InAir,status(a1)

locret_53EE8:
		rts
; End of function Displace_PlayerOffObject


; =============== S U B R O U T I N E =======================================


Run_PalRotationScript:
		lea	(Palette_rotation_data).w,a1

loc_53EEE:
		move.w	(a1),d0					; load palette displacement to d0
		beq.s	locret_53F32				; if 0, return
		subq.b	#1,2(a1)				; decrement delay
		bpl.s	loc_53F22				; if still positive, go to next entry
		movea.l	4(a1),a2				; load palette script address to a2
		movea.w	(a2),a3					; load destination address to a3
		lea	(a2,d0.w),a4				; copy script address to a4 and skip to palette data
		move.w	(a4),d1					; load the first entry to d1
		bpl.s	loc_53F0A				; if positive, it is a normal entry
		bsr.w	sub_53F26				; this is a command

loc_53F0A:
		moveq	#0,d2
		move.b	2(a2),d2				; load number of colors to d2

loc_53F10:
		move.w	(a4)+,(a3)+				; copy the next color into destination
		dbf	d2,loc_53F10				; loop for every color
		move.w	(a4)+,d0				; load next delay
		move.b	d0,2(a1)				; save the delay
		move.l	a4,d0					; copy current script position into d0
		sub.l	a2,d0					; calculate the current displacement from palette script origin
		move.w	d0,(a1)					; store it back

loc_53F22:
		addq.w	#8,a1					; go to next script
		bra.s	loc_53EEE				; run the code again
; End of function Run_PalRotationScript


; =============== S U B R O U T I N E =======================================


sub_53F26:
		move.b	3(a2),d2				; load additional parameter to d2
		bne.s	loc_53F34
		moveq	#4,d0					; Start from the beginning of the rotation
		lea	(a2,d0.w),a4

locret_53F32:
		rts
; ---------------------------------------------------------------------------

loc_53F34:
		neg.w	d1
		jmp	.table-8(pc,d1.w)
; End of function sub_53F26

; ---------------------------------------------------------------------------

.table
		bra.w	loc_53F42
		bra.w	loc_53F64
; ---------------------------------------------------------------------------

loc_53F42:
		addq.b	#1,3(a1)		; Add one to counter
		cmp.b	3(a1),d2		; Compare with max counter
		bhi.s	loc_53F5C
		move.w	2(a4),d2
		adda.w	d2,a2
		move.l	a2,4(a1)		; Load new script after counter has finished
		movea.w	(a2),a3
		clr.w	2(a1)

loc_53F5C:
		moveq	#4,d0			; Start from the beginning of the rotation
		lea	(a2,d0.w),a4
		rts
; ---------------------------------------------------------------------------

loc_53F64:
		addq.b	#1,3(a1)
		cmp.b	3(a1),d2
		bls.s	loc_53F76
		moveq	#4,d0			; Start from the beginning of the rotation
		lea	(a2,d0.w),a4
		rts
; ---------------------------------------------------------------------------

loc_53F76:
		movea.l	(Palette_rotation_custom).w,a2
		move.l	a1,-(sp)
		jsr	(a2)				; Run custom routine
		movea.l	(sp)+,a1
		addq.w	#4,sp
		bra.s	loc_53F22

; =============== S U B R O U T I N E =======================================


Child_GetPriority:
		movea.w	parent3(a0),a1
		bclr	#7,art_tile(a0)
		btst	#7,art_tile(a1)
		beq.s	loc_53F9C
		bset	#7,art_tile(a0)

loc_53F9C:
		move.w	priority(a1),priority(a0)
		rts
; End of function Child_GetPriority


; =============== S U B R O U T I N E =======================================


Child_GetPriorityOnce:
		movea.w	parent3(a0),a1
		btst	#7,art_tile(a1)
		beq.s	locret_53FB8
		bset	#7,art_tile(a0)
		move.l	(sp),(a0)

locret_53FB8:
		rts
; End of function Child_GetPriorityOnce


; =============== S U B R O U T I N E =======================================


CopyWordData_7:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+

CopyWordData_6:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+

CopyWordData_5:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
; End of function CopyWordData_7


; =============== S U B R O U T I N E =======================================


CopyWordData_4:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
; End of function CopyWordData_4


; =============== S U B R O U T I N E =======================================


CopyWordData_3:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+

CopyWordData_2:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
		rts
; End of function CopyWordData_3


; =============== S U B R O U T I N E =======================================


Obj_WaitOffscreen:
		move.l	#Map_Offscreen,mappings(a0)
		bset	#2,render_flags(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		move.l	(sp)+,$34(a0)
		move.l	#loc_53FFC,(a0)

loc_53FFC:
		tst.b	render_flags(a0)
		bmi.s	loc_5402C
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	loc_5401A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5401A:
		move.w	respawn_addr(a0),d0
		beq.s	loc_54026
		movea.w	d0,a2
		bclr	#7,(a2)

loc_54026:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_5402C:
		move.l	$34(a0),(a0)			; Restore normal object operation when onscreen
		rts
; End of function Obj_WaitOffscreen

; ---------------------------------------------------------------------------
Map_Offscreen:
		dc.w 0
; ---------------------------------------------------------------------------

Obj_Song_Fade_ToLevelMusic:
		move.w	#2*60,$2E(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.l	#loc_54048,(a0)

loc_54048:
		subq.w	#1,$2E(a0)
		bpl.w	locret_529CE
		bsr.w	Restore_LevelMusic
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_Song_Fade_Transition:
		move.w	#2*60,$2E(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.l	#loc_5406E,(a0)

loc_5406E:
		subq.w	#1,$2E(a0)
		bpl.w	locret_529CE
		move.b	subtype(a0),d0
		jsr	(Play_Music).l
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


Restore_LevelMusic:
		moveq	#0,d0
		lea	(Apparent_zone_and_act).w,a1
		move.b	(a1)+,d0
		add.b	d0,d0
		add.b	(a1),d0
		move.b	PlayLevelMusic_Playlist(pc,d0.w),d0
		move.w	d0,(Current_music).w
		btst	#Status_Invincible,(Player_1+status_secondary).w
		beq.s	loc_540A4
		moveq	#signextendB(mus_Invincibility),d0		; If invincible, play invincibility

loc_540A4:
		jmp	(Play_Music).l
; End of function Restore_LevelMusic

; ---------------------------------------------------------------------------
PlayLevelMusic_Playlist:
		dc.b mus_AIZ1, mus_AIZ2
		dc.b mus_HCZ1, mus_HCZ2
		dc.b mus_MGZ1, mus_MGZ2
		dc.b mus_CNZ1, mus_CNZ2
		dc.b mus_FBZ1, mus_FBZ2
		dc.b mus_ICZ1, mus_ICZ2
		dc.b mus_LBZ1, mus_LBZ2

; =============== S U B R O U T I N E =======================================


Restore_PlayerControl:
		lea	(Player_1).w,a1

Restore_PlayerControl2:
		clr.b	object_control(a1)
		bclr	#Status_InAir,status(a1)
		move.w	#(5<<8)|5,anim(a1)	; and prev_anim
		clr.b	anim_frame(a1)
		clr.b	anim_frame_timer(a1)
		rts
; End of function Restore_PlayerControl


; =============== S U B R O U T I N E =======================================


Obj_EndSignControl:
		move.l	#Obj_EndSignControlWait,(a0)
		st	(_unkFAA8).w		; End of level is in effect
		bclr	#7,render_flags(a0)
		bset	#4,$38(a0)
		move.w	#$7F,$2E(a0)
		move.l	#Obj_EndSignControlDoSign,$34(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		rts
; End of function Obj_EndSignControl

; ---------------------------------------------------------------------------
PLC_EndSignStuff: plrlistheader
		plreq $69E, ArtNem_SignpostStub
		plreq ArtTile_Monitors, ArtNem_Monitors
PLC_EndSignStuff_End
; ---------------------------------------------------------------------------

Obj_EndSignControlWait:
		bclr	#7,render_flags(a0)
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

Obj_EndSignControlDoSign:
		move.l	#Obj_EndSignControlAwaitStart,(a0)
		clr.b	(Boss_flag).w
		jsr	Restore_LevelMusic(pc)
		lea	Child6_EndSign(pc),a2
		jsr	CreateChild6_Simple(pc)
		lea	PLC_EndSignStuff(pc),a1
		jsr	(Load_PLC_Raw).l
		jmp	AfterBoss_Cleanup(pc)
; ---------------------------------------------------------------------------
Child6_EndSign:
		dc.w 1-1
		dc.l Obj_EndSign
; ---------------------------------------------------------------------------

Obj_EndSignControlAwaitStart:
		tst.b	(_unkFAA8).w
		bne.w	locret_529CE
		move.l	#Obj_EndSignControlDoStart,(a0)
		jsr	Restore_PlayerControl(pc)
		lea	(Player_2).w,a1
		jmp	Restore_PlayerControl2(pc)
; ---------------------------------------------------------------------------

Obj_EndSignControlDoStart:
		tst.b	(End_of_level_flag).w		; Wait for title card to finish
		beq.w	locret_529CE
		jsr	Change_Act2Sizes(pc)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
		jsr	Displace_PlayerOffObject(pc)
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


Check_CameraInRange:
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(a1)+,d0
		blo.s	loc_54198
		cmp.w	(a1)+,d0
		bhi.s	loc_54198
		move.w	(Camera_X_pos).w,d1
		cmp.w	(a1)+,d1
		blo.s	loc_54198
		cmp.w	(a1)+,d1
		bhi.s	loc_54198
		move.l	(sp),(a0)
		rts
; ---------------------------------------------------------------------------

loc_54198:
		jsr	(Delete_Sprite_If_Not_In_Range).l
		addq.w	#4,sp
		rts
; End of function Check_CameraInRange

; ---------------------------------------------------------------------------

loc_541A2:
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		move.w	(Camera_target_max_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		blo.s	locret_541C6
		move.w	d0,(Camera_min_Y_pos).w
		move.w	$3A(a0),d0
		cmp.w	(Camera_X_pos).w,d0
		bhi.s	locret_541C6
		movea.l	$34(a0),a1
		jsr	(a1)

locret_541C6:
		rts
; ---------------------------------------------------------------------------

loc_541C8:
		btst	#0,$38(a0)
		bne.s	loc_541E6
		subq.w	#1,$2E(a0)
		bpl.s	loc_541E6
		move.b	$26(a0),d0
		jsr	(Play_Music).l
		bset	#0,$38(a0)

loc_541E6:
		btst	#1,$38(a0)
		bne.s	loc_54202
		move.w	(Camera_target_max_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	loc_54202
		move.w	d0,(Camera_min_Y_pos).w
		bset	#1,$38(a0)

loc_54202:
		btst	#2,$38(a0)
		bne.s	loc_54220
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		move.w	$1C(a0),d0
		cmp.w	(Camera_X_pos).w,d0
		bhi.s	loc_54220
		bset	#2,$38(a0)

loc_54220:
		move.b	$38(a0),d0
		andi.b	#7,d0
		cmpi.b	#7,d0
		bne.w	locret_529CE
		clr.b	$38(a0)
		clr.w	$1C(a0)
		clr.b	$26(a0)
		movea.l	$34(a0),a1
		jmp	(a1)

; =============== S U B R O U T I N E =======================================


Change_Act2Sizes:
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		lsl.w	#4,d0
		lea	(LevelSizes).l,a1
		lea	8(a1,d0.w),a1			; Get level sizes for act 2
		move.w	(a1)+,(Camera_stored_min_X_pos).w
		move.w	(a1)+,(Camera_stored_max_X_pos).w
		move.w	(a1)+,(Camera_stored_min_Y_pos).w
		move.w	(a1)+,d1
		move.w	d1,(Camera_stored_max_Y_pos).w	; Put level sizes into the target size memory
		move.w	d1,(Camera_target_max_Y_pos).w
		cmpi.b	#$10,d0
		beq.w	locret_529CE		; If we're in HCZ, don't immediately apply these changes. There's another event to do.
; End of function Change_Act2Sizes


; =============== S U B R O U T I N E =======================================


Make_LevelSizeObj:
		lea	Child1_Act2LevelSize(pc),a2
		jmp	CreateChild1_Normal(pc)
; End of function Make_LevelSizeObj

; ---------------------------------------------------------------------------
Child1_Act2LevelSize:
		dc.w 3-1
		dc.l Obj_IncLevEndXGradual
		dc.b    0,   0
		dc.l Obj_DecLevStartYGradual
		dc.b    0,   0
		dc.l Obj_IncLevEndYGradual
		dc.b    0,   0

; =============== S U B R O U T I N E =======================================


StartNewLevel:
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		move.w	#1,(Restart_level_flag).w
		clr.b	(Last_star_post_hit).w
		clr.b	(Special_bonus_entry_flag).w
		rts
; End of function StartNewLevel


; =============== S U B R O U T I N E =======================================


Play_SFX_Continuous:
		move.b	(V_int_run_count+3).w,d1
		andi.b	#$F,d1
		bne.w	locret_529CE
		jmp	(Play_SFX).l
; End of function Play_SFX_Continuous

; ---------------------------------------------------------------------------

loc_542B8:
		move.b	#7,$39(a0)
		move.w	#3,$2E(a0)
		move.l	#loc_542CA,(a0)

loc_542CA:
		subq.w	#1,$2E(a0)
		bpl.w	locret_529CE
		move.w	#3,$2E(a0)
		lea	(Normal_palette).w,a1
		moveq	#$40-1,d0

loc_542DE:
		bsr.w	sub_542F0
		dbf	d0,loc_542DE
		subq.b	#1,$39(a0)
		bmi.w	Go_Delete_Sprite
		rts

; =============== S U B R O U T I N E =======================================


sub_542F0:
		moveq	#$E,d2
		move.b	(a1),d3
		and.b	d2,d3
		cmp.b	d2,d3
		bhs.s	loc_542FE
		addq.b	#2,d3
		move.b	d3,(a1)

loc_542FE:
		addq.w	#1,a1
		move.b	(a1),d3
		move.b	d3,d4
		andi.b	#$E0,d3
		andi.b	#$E,d4
		cmpi.b	#$E0,d3
		bhs.s	loc_54316
		addi.b	#$20,d3

loc_54316:
		cmp.b	d2,d4
		bhs.s	loc_5431C
		addq.b	#2,d4

loc_5431C:
		or.b	d3,d4
		move.b	d4,(a1)+
		rts
; End of function sub_542F0

; ---------------------------------------------------------------------------

loc_54322:
		move.b	#7,$39(a0)
		move.w	#3,$2E(a0)
		move.l	#loc_54334,(a0)

loc_54334:
		subq.w	#1,$2E(a0)
		bpl.w	locret_529CE
		move.w	#3,$2E(a0)
		lea	(Normal_palette).w,a1
		lea	(Target_palette).w,a2
		moveq	#$40-1,d0

loc_5434C:
		bsr.w	sub_5435E
		dbf	d0,loc_5434C
		subq.b	#1,$39(a0)
		bmi.w	Go_Delete_Sprite
		rts

; =============== S U B R O U T I N E =======================================


sub_5435E:
		move.b	(a2)+,d2
		andi.b	#$E,d2
		move.b	(a1),d3
		cmp.b	d2,d3
		bls.s	loc_5436E
		subq.b	#2,d3
		move.b	d3,(a1)

loc_5436E:
		addq.w	#1,a1
		move.b	(a2)+,d2
		move.b	d2,d3
		andi.b	#$E0,d2
		andi.b	#$E,d3
		move.b	(a1),d4
		move.b	d4,d5
		andi.b	#$E0,d4
		andi.b	#$E,d5
		cmp.b	d2,d4
		bls.s	loc_54390
		subi.b	#$20,d4

loc_54390:
		cmp.b	d3,d5
		bls.s	loc_54396
		subq.b	#2,d5

loc_54396:
		or.b	d4,d5
		move.b	d5,(a1)+
		rts
; End of function sub_5435E

; ---------------------------------------------------------------------------
sub_5439C:
		move.w	(Player_mode).w,d0
		cmpi.w	#2,d0
		beq.s	loc_543B2
		cmpi.w	#7,(Chaos_emerald_count).w
		beq.s	loc_543B6
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_543B2:
		moveq	#1,d0
		rts
; ---------------------------------------------------------------------------

loc_543B6:
		moveq	#2,d0
		rts

; =============== S U B R O U T I N E =======================================


BossDefeated_StopTimer:
		clr.b	(Update_HUD_timer).w
; End of function BossDefeated_StopTimer


; =============== S U B R O U T I N E =======================================


BossDefeated:
		move.w	#$3F,$2E(a0)
		moveq	#100,d0
		jsr	(HUD_AddToScore).l
		bclr	#7,render_flags(a0)
		rts
; End of function BossDefeated


; =============== S U B R O U T I N E =======================================


Player_Load_PLC:
		move.l	a0,-(sp)
		lea	(Player_1).w,a0
		moveq	#0,d0
		move.b	character_id(a0),d0
		lsl.w	#2,d0
		movea.l	Player_Load_PLC_Index(pc,d0.w),a1
		jsr	(a1)
		movea.l	(sp)+,a0
		rts
; End of function Player_Load_PLC

; ---------------------------------------------------------------------------
Player_Load_PLC_Index:
		dc.l Sonic_Load_PLC
		dc.l Tails_Load_PLC

; =============== S U B R O U T I N E =======================================


PLCLoad_AnimalsAndExplosion:
		lea	PLC_Explosion(pc),a1
		jsr	(Load_PLC_Raw).l
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		add.w	d0,d0
		move.w	PLCLoad_Animals_Index(pc,d0.w),d0
		lea	PLCLoad_Animals_Index(pc,d0.w),a1
		jmp	(Load_PLC_Raw).l
; End of function PLCLoad_AnimalsAndExplosion

; ---------------------------------------------------------------------------
PLCLoad_Animals_Index:
		dc.w PLC_Animals_AIZ-PLCLoad_Animals_Index
		dc.w PLC_Animals_HCZ-PLCLoad_Animals_Index
		dc.w PLC_Animals_MGZ-PLCLoad_Animals_Index
		dc.w PLC_Animals_CNZ-PLCLoad_Animals_Index
		dc.w PLC_Animals_FBZ-PLCLoad_Animals_Index
		dc.w PLC_Animals_ICZ-PLCLoad_Animals_Index
		dc.w PLC_Animals_LBZ-PLCLoad_Animals_Index
PLC_Animals_AIZ: plrlistheader
		plreq $580, ArtNem_BlueFlicky
		plreq $592, ArtNem_Chicken
PLC_Animals_AIZ_End

PLC_Animals_HCZ: plrlistheader
		plreq $580, ArtNem_Rabbit
		plreq $592, ArtNem_Seal
PLC_Animals_HCZ_End

PLC_Animals_MGZ: plrlistheader
		plreq $580, ArtNem_BlueFlicky
		plreq $592, ArtNem_Chicken
PLC_Animals_MGZ_End

PLC_Animals_CNZ: plrlistheader
		plreq $580, ArtNem_Rabbit
		plreq $592, ArtNem_BlueFlicky
PLC_Animals_CNZ_End

PLC_Animals_FBZ: plrlistheader
		plreq $580, ArtNem_Squirrel
		plreq $592, ArtNem_BlueFlicky
PLC_Animals_FBZ_End

PLC_Animals_ICZ: plrlistheader
		plreq $580, ArtNem_Penguin
		plreq $592, ArtNem_Seal
PLC_Animals_ICZ_End

PLC_Animals_LBZ: plrlistheader
		plreq $580, ArtNem_Squirrel
		plreq $592, ArtNem_Chicken
PLC_Animals_LBZ_End
; ---------------------------------------------------------------------------

AddRings:
		lea	(Ring_count).w,a2
		lea	(Update_HUD_ring_count).w,a3
		lea	(Extra_life_flags).w,a4
		lea	(Total_ring_count).w,a5
		move.w	#999,d1
		add.w	d0,(a5)
		cmp.w	(a5),d1
		bhs.s	loc_544A0
		move.w	d1,(a5)

loc_544A0:
		add.w	d0,(a2)
		cmp.w	(a2),d1
		bhs.s	loc_544A8
		move.w	d1,(a2)

loc_544A8:
		ori.b	#1,(a3)
		cmpi.w	#100,(a2)
		blo.s	loc_544C4
		bset	#1,(a4)
		beq.s	loc_544CC
		cmpi.w	#200,(a2)
		blo.s	loc_544C4
		bset	#2,(a4)
		beq.s	loc_544CC

loc_544C4:
		moveq	#signextendB(sfx_RingRight),d0
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------

loc_544CC:
		addq.w	#1,(Monitors_broken).w		; Add an extra life
		addq.b	#1,(Life_count).w
		addq.b	#1,(Update_HUD_life_count).w
		moveq	#signextendB(mus_ExtraLife),d0
		jmp	(Play_Music).l
