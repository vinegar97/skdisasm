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

locret_8405E:
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
		move.w	art_tile(a0),art_tile(a1)	; Mappings and VRAM offset copied from parent object
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
		move.w	art_tile(a0),art_tile(a1)	; Mappings and VRAM offset copied from parent object
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
		move.w	art_tile(a0),art_tile(a1)
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
		move.w	art_tile(a0),art_tile(a1)
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
		move.w	art_tile(a0),art_tile(a1)
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
		move.l	mappings(a0),mappings(a1)
		move.w	art_tile(a0),art_tile(a1)
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
		move.w	art_tile(a0),art_tile(a1)
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
		move.w	art_tile(a0),art_tile(a1)
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


CreateChild9_TreeList:
		movea.l	a0,a3				; Same as routine 8, but creates separate objects in a list rather than repeating the same object
		moveq	#0,d2
		move.w	(a2)+,d6

.loop:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	.end
		move.w	a3,parent3(a1)
		move.w	a0,$44(a1)
		movea.l	a1,a3
		move.l	mappings(a0),mappings(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.l	(a2)+,(a1)
		move.b	d2,subtype(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addq.w	#2,d2
		dbf	d6,.loop
		moveq	#0,d0

.end:
		rts
; End of function CreateChild9_TreeList


; =============== S U B R O U T I N E =======================================


CreateChild10_NormalAdjusted:
		moveq	#0,d2				; Same as child routine 1, but adjusts X position based on parent object's orientation
		move.w	(a2)+,d6

.loop:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	.end
		move.w	a0,parent3(a1)
		move.l	mappings(a0),mappings(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.l	(a2)+,(a1)
		move.b	d2,subtype(a1)
		move.w	x_pos(a0),d0
		move.b	(a2)+,d1
		btst	#0,render_flags(a0)
		beq.s	.noflip
		bset	#0,render_flags(a1)
		neg.b	d1

.noflip:
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
; End of function CreateChild10_NormalAdjusted


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
		beq.s	loc_843D2
		neg.w	d1
		bset	#0,render_flags(a0)

loc_843D2:
		add.w	d1,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),d0
		move.b	child_dy(a0),d1
		ext.w	d1
		bclr	#1,render_flags(a0)
		btst	#1,render_flags(a1)
		beq.s	loc_843F8
		neg.w	d1
		bset	#1,render_flags(a0)

loc_843F8:
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
		bpl.s	locret_84426
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#1,d0
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	1(a1,d0.w),d1
		bmi.s	loc_84428
		move.b	(a1),anim_frame_timer(a0)
		move.b	d1,mapping_frame(a0)

locret_84426:
		rts
; ---------------------------------------------------------------------------

loc_84428:
		neg.b	d1
		jsr	off_84434-4(pc,d1.w)
		clr.b	anim_frame(a0)
		rts
; End of function Animate_RawNoSST

off_84434:
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
; End of function Animate_RawAdjustFlipX


; =============== S U B R O U T I N E =======================================


Animate_RawNoSSTAdjustFlipX:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_84496
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#1,d0
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	1(a1,d0.w),d1
		bmi.s	loc_84428
		bclr	#6,d1
		beq.s	loc_8448E
		bchg	#0,render_flags(a0)

loc_8448E:
		move.b	(a1),anim_frame_timer(a0)
		move.b	d1,mapping_frame(a0)

locret_84496:
		rts
; End of function Animate_RawNoSSTAdjustFlipX


; =============== S U B R O U T I N E =======================================


Animate_RawAdjustFlipY:
		movea.l	$30(a0),a1
; End of function Animate_RawAdjustFlipY


; =============== S U B R O U T I N E =======================================


Animate_RawNoSSTAdjustFlipY:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_844CC
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#1,d0
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	1(a1,d0.w),d1
		bmi.w	loc_84428
		bclr	#6,d1
		beq.s	loc_844C4
		bchg	#1,render_flags(a0)

loc_844C4:
		move.b	(a1),anim_frame_timer(a0)
		move.b	d1,mapping_frame(a0)

locret_844CC:
		rts
; End of function Animate_RawNoSSTAdjustFlipY

; =============== S U B R O U T I N E =======================================


Animate_ExternalPlayerSprite:
		subq.b	#1,anim_frame_timer(a1)
		bpl.s	loc_84500
		move.b	(a2),anim_frame_timer(a1)
		moveq	#0,d0
		move.b	anim_frame(a1),d0
		addq.b	#2,d0
		move.b	d0,anim_frame(a1)
		move.b	1(a2,d0.w),d1
		beq.s	loc_84504
		move.b	d1,mapping_frame(a1)
		bclr	#0,render_flags(a1)
		tst.b	2(a2,d0.w)
		beq.s	loc_84500
		bset	#0,render_flags(a1)

loc_84500:
		jmp	Player_Load_PLC2(pc)
; ---------------------------------------------------------------------------

loc_84504:
		jsr	Player_Load_PLC2(pc)
		movea.l	$34(a0),a1
		jmp	(a1)
; End of function Animate_ExternalPlayerSprite


; =============== S U B R O U T I N E =======================================


Animate_RawCheckResult:
		movea.l	$30(a0),a1
; End of function Animate_RawCheckResult


; =============== S U B R O U T I N E =======================================


Animate_RawNoSSTCheckResult:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_8453E
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#1,d0
		move.b	d0,anim_frame(a0)
		lea	1(a1,d0.w),a2
		moveq	#0,d1
		move.b	(a2)+,d1
		cmpi.b	#-1,d1
		beq.s	loc_84542
		move.b	(a1),anim_frame_timer(a0)
		move.b	d1,mapping_frame(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_8453E:
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_84542:
		move.b	(a2)+,d1
		neg.b	d1
		jsr	off_84552-4(pc,d1.w)
		clr.b	anim_frame(a0)
		moveq	#-1,d2
		rts
; End of function Animate_RawNoSSTCheckResult

off_84552:
		bra.w	loc_8456A
; ---------------------------------------------------------------------------
		bra.w	loc_8455E
; ---------------------------------------------------------------------------
		bra.w	loc_84576
; ---------------------------------------------------------------------------

loc_8455E:
		move.b	(a2)+,d1
		ext.w	d1
		lea	(a1,d1.w),a1
		move.l	a1,$30(a0)

loc_8456A:
		move.b	1(a1),mapping_frame(a0)
		move.b	(a1),anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_84576:
		clr.b	anim_frame_timer(a0)
		movea.l	$34(a0),a1
		jmp	(a1)

; =============== S U B R O U T I N E =======================================


Set_Raw_Animation:
		move.l	a1,$30(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		rts
; End of function Set_Raw_Animation


; =============== S U B R O U T I N E =======================================


Stop_Object:
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		clr.w	ground_vel(a1)
		rts
; End of function Stop_Object


; =============== S U B R O U T I N E =======================================


Animate_RawMultiDelay:
		movea.l	$30(a0),a1

Animate_RawNoSSTMultiDelay:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_845C8
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#2,d0
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	(a1,d0.w),d1
		bmi.s	loc_845CC
		move.b	d1,mapping_frame(a0)
		move.b	1(a1,d0.w),anim_frame_timer(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_845C8:
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_845CC:
		neg.b	d1
		jsr	off_845D8-4(pc,d1.w)
		clr.b	anim_frame(a0)
		rts
; End of function Animate_RawMultiDelay

off_845D8:
		bra.w	loc_845F2
; ---------------------------------------------------------------------------
		bra.w	loc_845E4
; ---------------------------------------------------------------------------
		bra.w	loc_84600
; ---------------------------------------------------------------------------

loc_845E4:
		move.b	1(a1,d0.w),d1
		ext.w	d1
		lea	(a1,d1.w),a1
		move.l	a1,$30(a0)

loc_845F2:
		move.b	(a1),mapping_frame(a0)
		move.b	1(a1),anim_frame_timer(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_84600:
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
		bpl.s	loc_84646
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#2,d0
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	(a1,d0.w),d1
		bmi.s	loc_845CC
		bclr	#6,d1
		beq.s	loc_84638
		bchg	#0,render_flags(a0)

loc_84638:
		move.b	d1,mapping_frame(a0)
		move.b	1(a1,d0.w),anim_frame_timer(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_84646:
		moveq	#0,d2
		rts
; End of function Animate_RawMultiDelayFlipX


; =============== S U B R O U T I N E =======================================


Animate_RawMultiDelayFlipY:
		movea.l	$30(a0),a1
; End of function Animate_RawMultiDelayFlipY


; =============== S U B R O U T I N E =======================================


Animate_RawNoSSTMultiDelayFlipY:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_84684
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#2,d0
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	(a1,d0.w),d1
		bmi.w	loc_845CC
		bclr	#6,d1
		beq.s	loc_84676
		bchg	#1,render_flags(a0)

loc_84676:
		move.b	d1,mapping_frame(a0)
		move.b	1(a1,d0.w),anim_frame_timer(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_84684:
		moveq	#0,d2
		rts
; End of function Animate_RawNoSSTMultiDelayFlipY


; =============== S U B R O U T I N E =======================================


Animate_Raw2MultiDelay:
		movea.l	$30(a0),a1

Animate_Raw2NoSSTMultiDelay:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_846BA
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#2,d0
		move.b	d0,anim_frame(a0)
		lea	(a1,d0.w),a2
		moveq	#0,d1
		move.b	(a2)+,d1
		cmpi.b	#-1,d1
		beq.s	loc_846BE
		move.b	d1,mapping_frame(a0)
		move.b	1(a1,d0.w),anim_frame_timer(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_846BA:
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_846BE:
		move.b	(a2)+,d1
		neg.b	d1
		jsr	off_846CC-4(pc,d1.w)
		clr.b	anim_frame(a0)
		rts
; End of function Animate_Raw2MultiDelay

off_846CC:
		bra.w	loc_846E4
; ---------------------------------------------------------------------------
		bra.w	loc_846D8
; ---------------------------------------------------------------------------
		bra.w	loc_846F2
; ---------------------------------------------------------------------------

loc_846D8:
		move.b	(a2)+,d1
		ext.w	d1
		lea	(a1,d1.w),a1
		move.l	a1,$30(a0)

loc_846E4:
		move.b	(a1),mapping_frame(a0)
		move.b	1(a1),anim_frame_timer(a0)
		moveq	#-1,d2
		rts
; ---------------------------------------------------------------------------

loc_846F2:
		clr.b	anim_frame_timer(a0)
		movea.l	$34(a0),a1
		jsr	(a1)
		moveq	#-1,d2
		rts

; =============== S U B R O U T I N E =======================================


Animate_RawGetFaster:
		movea.l	$30(a0),a1
; End of function Animate_RawGetFaster


; =============== S U B R O U T I N E =======================================


Animate_RawNoSSTGetFaster:
		bset	#5,$38(a0)
		bne.s	loc_84714
		move.b	(a1),$2E(a0)
		clr.b	$2F(a0)

loc_84714:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_8474C
		move.b	$2E(a0),d2
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.b	#1,d0
		move.b	2(a1,d0.w),d1
		bpl.s	loc_8473C
		moveq	#0,d0
		move.b	2(a1),d1
		tst.b	d2
		beq.s	loc_84750
		subq.b	#1,d2
		move.b	d2,$2E(a0)

loc_8473C:
		move.b	d0,anim_frame(a0)
		move.b	d1,mapping_frame(a0)
		move.b	d2,anim_frame_timer(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_8474C:
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_84750:
		move.b	d0,anim_frame(a0)
		move.b	d1,mapping_frame(a0)
		move.b	d2,anim_frame_timer(a0)
		move.b	$2F(a0),d0
		addq.b	#1,d0
		move.b	d0,$2F(a0)
		cmp.b	1(a1),d0
		blo.s	loc_8477C
		bclr	#5,$38(a0)
		clr.b	$2F(a0)
		movea.l	$34(a0),a2
		jsr	(a2)

loc_8477C:
		moveq	#-1,d2
		rts
; End of function Animate_RawNoSSTGetFaster


; =============== S U B R O U T I N E =======================================


Animate_RawGetSlower:
		movea.l	$30(a0),a1
; End of function Animate_RawGetSlower


; =============== S U B R O U T I N E =======================================


Animate_RawNoSSTGetSlower:
		bset	#5,$38(a0)
		bne.s	loc_84790
		clr.w	$2E(a0)

loc_84790:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_847C4
		move.b	$2E(a0),d2
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.b	#1,d0
		move.b	1(a1,d0.w),d1
		bpl.s	loc_847B0
		moveq	#0,d0
		move.b	1(a1),d1
		addq.b	#1,d2

loc_847B0:
		move.b	d0,anim_frame(a0)
		move.b	d1,mapping_frame(a0)
		move.b	d2,anim_frame_timer(a0)
		cmp.b	(a1),d2
		bhs.s	loc_847C6
		move.b	d2,$2E(a0)

locret_847C4:
		rts
; ---------------------------------------------------------------------------

loc_847C6:
		move.b	$2F(a0),d0
		addq.b	#1,d0
		move.b	d0,$2F(a0)
		cmp.b	1(a1),d0
		blo.s	locret_847C4
		bclr	#5,$38(a0)
		clr.b	$2F(a0)
		movea.l	$34(a0),a2
		jmp	(a2)

; End of function Animate_RawNoSSTGetSlower



; =============== S U B R O U T I N E =======================================


Swing_UpAndDown:
		move.w	$40(a0),d0	; Acceleration
		move.w	y_vel(a0),d1	; Velocity
		move.w	$3E(a0),d2	; Maximum acceleration before "swinging"
		moveq	#0,d3
		btst	#0,$38(a0)
		bne.s	loc_84812
		neg.w	d0			; Apply upward acceleration
		add.w	d0,d1
		neg.w	d2
		cmp.w	d2,d1
		bgt.s	loc_84824
		bset	#0,$38(a0)
		neg.w	d0
		neg.w	d2
		moveq	#1,d3

loc_84812:
		add.w	d0,d1		; Apply downward acceleration
		cmp.w	d2,d1
		blt.s	loc_84824
		bclr	#0,$38(a0)
		neg.w	d0
		add.w	d0,d1
		moveq	#1,d3

loc_84824:
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
		bne.s	loc_84856
		neg.w	d0
		add.w	d0,d1
		neg.w	d2
		cmp.w	d2,d1
		bgt.s	loc_84868
		bset	#3,$38(a0)
		neg.w	d0
		neg.w	d2
		moveq	#1,d3

loc_84856:
		add.w	d0,d1
		cmp.w	d2,d1
		blt.s	loc_84868
		bclr	#3,$38(a0)
		neg.w	d0
		add.w	d0,d1
		moveq	#1,d3

loc_84868:
		move.w	d1,x_vel(a0)
		rts
; End of function Swing_LeftAndRight


; =============== S U B R O U T I N E =======================================


Swing_UpAndDown_Count:
		bsr.w	Swing_UpAndDown
		tst.w	d3
		beq.s	locret_84888
		move.b	$39(a0),d2
		subq.b	#1,d2
		move.b	d2,$39(a0)
		bmi.s	loc_84886
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_84886:
		moveq	#1,d0

locret_84888:
		rts
; End of function Swing_UpAndDown_Count


; =============== S U B R O U T I N E =======================================


Obj_Wait:
		subq.w	#1,$2E(a0)
		bmi.s	loc_84892
		rts
; ---------------------------------------------------------------------------

loc_84892:
		movea.l	$34(a0),a1
		jmp	(a1)
; End of function Obj_Wait


; =============== S U B R O U T I N E =======================================


ObjHitFloor_DoRoutine:
		tst.w	y_vel(a0)
		bmi.s	locret_848AA
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_848AC
		beq.s	loc_848AC

locret_848AA:
		rts
; ---------------------------------------------------------------------------

loc_848AC:
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
		blt.s	loc_848DE
		cmpi.w	#$C,d1
		bge.s	loc_848DE
		add.w	d1,y_pos(a0)
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_848DE:
		movea.l	$34(a0),a1
		jsr	(a1)
		moveq	#1,d0
		rts
; End of function ObjHitFloor2_DoRoutine


; =============== S U B R O U T I N E =======================================


ObjHitWall_DoRoutine:
		jsr	(ObjCheckRightWallDist).l
		tst.w	d1
		bmi.s	loc_848F4
		rts
; ---------------------------------------------------------------------------

loc_848F4:
		add.w	d1,x_pos(a0)
		movea.l	$34(a0),a1
		jmp	(a1)
; End of function ObjHitWall_DoRoutine

; ---------------------------------------------------------------------------

ObjHitWall2_DoRoutine:
		jsr	(ObjCheckLeftWallDist).l
		tst.w	d1
		bmi.s	loc_8490A
		rts
; ---------------------------------------------------------------------------

loc_8490A:
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
		bne.w	Go_Delete_Sprite
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Child_DrawTouch_Sprite:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.w	Go_Delete_Sprite
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Child_CheckParent:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.w	Go_Delete_Sprite
		rts
; ---------------------------------------------------------------------------

Child_AddToTouchList:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.w	Go_Delete_Sprite
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

Child_Remember_Draw_Sprite:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_84984
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_84984:
		bsr.w	Remove_From_TrackingSlot
		bra.w	Go_Delete_Sprite
; ---------------------------------------------------------------------------

Child_Draw_Sprite2:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_8499E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8499E:
		bra.w	Go_Delete_Sprite_2
; ---------------------------------------------------------------------------

Child_DrawTouch_Sprite2:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_849C2
		btst	#7,status(a1)
		bne.s	loc_849BC
		jsr	(Add_SpriteToCollisionResponseList).l

loc_849BC:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_849C2:
		bra.w	Go_Delete_Sprite_2
; ---------------------------------------------------------------------------

Child_Draw_Sprite_FlickerMove:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_849D8
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_849D8:
		bset	#7,status(a0)
		move.l	#Obj_FlickerMove,(a0)
		clr.b	collision_flags(a0)
		bsr.w	Set_IndexedVelocity
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Child_Draw_Sprite2_FlickerMove:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_849D8
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Child_DrawTouch_Sprite_FlickerMove:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_849D8
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Child_DrawTouch_Sprite2_FlickerMove:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_849D8
		btst	#7,status(a1)
		beq.s	loc_84A3C
		bset	#7,status(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_84A3C:
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
		bhs.s	loc_84A6A
		move.w	d0,(Camera_max_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_84A6A:
		move.w	(Camera_stored_max_X_pos).w,(Camera_max_X_pos).w

loc_84A70:	; used in S3, unused in S&K
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
		ble.s	loc_84A98
		move.w	d0,(Camera_min_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_84A98:
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
		ble.s	loc_84AC6
		move.w	d0,(Camera_min_Y_pos).w
		rts
; ---------------------------------------------------------------------------

loc_84AC6:
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
		bgt.s	loc_84AF4
		move.w	d0,(Camera_max_Y_pos).w
		rts
; ---------------------------------------------------------------------------

loc_84AF4:
		move.w	(Camera_stored_max_Y_pos).w,(Camera_max_Y_pos).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
Child6_IncLevX:
		dc.w 1-1
		dc.l Obj_IncLevEndXGradual
Child6_DecLevX:	; used in S3, unused in S3K
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
		bpl.s	loc_84B2E
		neg.w	d2
		addq.w	#2,d0

loc_84B2E:
		lea	(Player_2).w,a2
		move.w	x_pos(a0),d3
		sub.w	x_pos(a2),d3
		bpl.s	loc_84B40
		neg.w	d3
		addq.w	#2,d1

loc_84B40:
		cmp.w	d3,d2
		bls.s	loc_84B4A
		movea.l	a2,a1
		move.w	d1,d0
		move.w	d3,d2

loc_84B4A:
		moveq	#0,d1
		move.w	y_pos(a0),d3
		sub.w	y_pos(a1),d3
		bpl.s	locret_84B5A
		neg.w	d3
		addq.w	#2,d1

locret_84B5A:
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
		bpl.s	loc_84BAE
		neg.w	d2
		addq.w	#2,d0

loc_84BAE:
		moveq	#0,d1
		move.w	y_pos(a0),d3
		sub.w	y_pos(a1),d3
		bpl.s	locret_84BBE
		neg.w	d3
		addq.w	#2,d1

locret_84BBE:
		rts
; End of function Find_OtherObject


; =============== S U B R O U T I N E =======================================


MoveSprite_LightGravity:
		moveq	#$20,d1

MoveSprite_CustomGravity:
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


MoveSprite_NormGravity:
		moveq	#$38,d1
		move.w	x_vel(a1),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,x_pos(a1)
		move.w	y_vel(a1),d0
		add.w	d1,y_vel(a1)
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,y_pos(a1)
		rts
; End of function MoveSprite_NormGravity


; =============== S U B R O U T I N E =======================================


MoveSprite_Circular:
		move.b	$3C(a0),d0
		jsr	(GetSineCosine).l
		move.w	$3A(a0),d2
		move.w	d2,d3
		muls.w	d0,d2
		swap	d2
		muls.w	d1,d3
		swap	d3
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d0
		add.w	d2,d0
		move.b	child_dx(a0),d4
		ext.w	d4
		add.w	d4,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),d1
		add.w	d3,d1
		move.b	child_dy(a0),d4
		ext.w	d4
		add.w	d4,d1
		move.w	d1,y_pos(a0)
		rts
; End of function MoveSprite_Circular


; =============== S U B R O U T I N E =======================================


MoveSprite_CircularSimple:
		move.b	$3C(a0),d0
		jsr	(GetSineCosine).l
		swap	d0
		clr.w	d0
		swap	d1
		clr.w	d1
		asr.l	d2,d0
		asr.l	d2,d1
		movea.w	parent3(a0),a1
		move.l	x_pos(a1),d2
		move.l	y_pos(a1),d3
		add.l	d0,d2
		add.l	d1,d3
		move.l	d2,x_pos(a0)
		move.l	d3,y_pos(a0)
		rts
; End of function MoveSprite_CircularSimple

; ---------------------------------------------------------------------------

MoveSprite_CircularSimpleCheckFlip:
		move.b	$3C(a0),d0
		jsr	(GetSineCosine).l
		swap	d0
		clr.w	d0
		swap	d1
		clr.w	d1
		asr.l	d2,d0
		asr.l	d2,d1
		movea.w	parent3(a0),a1
		move.l	x_pos(a1),d2
		move.l	y_pos(a1),d3
		btst	#0,render_flags(a1)
		beq.s	loc_84C9E
		neg.l	d0

loc_84C9E:
		add.l	d0,d2
		add.l	d1,d3
		move.l	d2,x_pos(a0)
		move.l	d3,y_pos(a0)
		rts

; =============== S U B R O U T I N E =======================================


MoveSprite_CircularSimpleOffset:
		move.b	$3C(a0),d0
		jsr	(GetSineCosine).l
		swap	d0
		clr.w	d0
		swap	d1
		clr.w	d1
		asr.l	d2,d0
		asr.l	d2,d1
		movea.w	parent3(a0),a1
		move.l	x_pos(a1),d2
		move.l	y_pos(a1),d3
		move.b	child_dx(a0),d4
		ext.w	d4
		swap	d4
		clr.w	d4
		add.l	d4,d2
		move.b	child_dy(a0),d4
		ext.w	d4
		swap	d4
		clr.w	d4
		add.l	d4,d3
		add.l	d0,d2
		add.l	d1,d3
		move.l	d2,x_pos(a0)
		move.l	d3,y_pos(a0)
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
		beq.s	loc_84DAA
		neg.w	d4

loc_84DAA:
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
		beq.s	loc_84DCE
		neg.w	d5

loc_84DCE:
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
		move.w	.Index(pc,d1.w),d1
		jsr	.Index(pc,d1.w)
		add.w	d1,d3
		move.w	d3,y_pos(a0)
		rts
; End of function MoveSprite_AngleYLookup

; ---------------------------------------------------------------------------
.Index:
		dc.w loc_84E16-.Index
		dc.w loc_84E1E-.Index
		dc.w loc_84E28-.Index
		dc.w loc_84E32-.Index
; ---------------------------------------------------------------------------

loc_84E16:
		moveq	#0,d1
		move.b	(a3,d4.w),d1
		rts
; ---------------------------------------------------------------------------

loc_84E1E:
		moveq	#0,d1
		move.b	(a2,d0.w),d1
		neg.w	d1
		rts
; ---------------------------------------------------------------------------

loc_84E28:
		moveq	#0,d1
		move.b	(a3,d4.w),d1
		neg.w	d1
		rts
; ---------------------------------------------------------------------------

loc_84E32:
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
		move.w	.Index(pc,d1.w),d2
		jmp	.Index(pc,d2.w)
; End of function MoveSprite_AngleXLookupOffset

; ---------------------------------------------------------------------------
.Index:
		dc.w loc_84E58-.Index
		dc.w loc_84E60-.Index
		dc.w loc_84E6C-.Index
		dc.w loc_84E7C-.Index
; ---------------------------------------------------------------------------

loc_84E58:
		move.b	(a1,d0.w),d1
		bra.w	loc_84E8C
; ---------------------------------------------------------------------------

loc_84E60:
		moveq	#$7F,d1
		sub.w	d0,d1
		move.b	(a1,d1.w),d1
		bra.w	loc_84E8C
; ---------------------------------------------------------------------------

loc_84E6C:
		move.w	d0,d1
		andi.w	#$3F,d1
		move.b	(a1,d1.w),d1
		neg.w	d1
		bra.w	loc_84E8C
; ---------------------------------------------------------------------------

loc_84E7C:
		move.w	#$FF,d1
		sub.w	d0,d1
		move.b	(a1,d1.w),d1
		neg.w	d1
		bra.w	loc_84E8C
; ---------------------------------------------------------------------------

loc_84E8C:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d2
		move.b	child_dx(a0),d3
		ext.w	d3
		add.w	d3,d2
		btst	#0,render_flags(a1)
		beq.s	loc_84EA6
		neg.w	d1

loc_84EA6:
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
		move.w	off_84ED4(pc,d1.w),d2
		jmp	off_84ED4(pc,d2.w)
; ---------------------------------------------------------------------------
off_84ED4:
		dc.w loc_84EDC-off_84ED4
		dc.w loc_84EE4-off_84ED4
		dc.w loc_84EF0-off_84ED4
		dc.w loc_84F00-off_84ED4
; ---------------------------------------------------------------------------

loc_84EDC:
		move.b	(a1,d0.w),d1
		bra.w	loc_84F10
; ---------------------------------------------------------------------------

loc_84EE4:
		moveq	#$7F,d1
		sub.w	d0,d1
		move.w	(a1,d1.w),d1
		bra.w	loc_84F10
; ---------------------------------------------------------------------------

loc_84EF0:
		move.w	d0,d1
		andi.w	#$3F,d1
		move.w	(a1,d1.w),d1
		neg.w	d1
		bra.w	loc_84F10
; ---------------------------------------------------------------------------

loc_84F00:
		move.w	#$FF,d1
		sub.w	d0,d1
		move.w	(a1,d1.w),d1
		neg.w	d1
		bra.w	loc_84F10

loc_84F10:
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
		bmi.s	loc_84F88
		rts
; ---------------------------------------------------------------------------

loc_84F88:
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
		beq.s	loc_84FE4		; If array is clear, just make the object

loc_84FBC:
		lsr.b	#1,d5			; Check slot (each bit)
		bcc.s	loc_84FE4		; If clear, make object
		addq.w	#1,d0			; Increment bit number
		add.w	d4,d3			; Add VRAM offset
		dbf	d1,loc_84FBC		; Repeat max times
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

loc_84FE4:
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
		bhi.s	loc_85088
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_85088:
		move.w	respawn_addr(a0),d0
		beq.s	loc_85094
		movea.w	d0,a2
		bclr	#7,(a2)

loc_85094:
		bset	#7,status(a0)
		move.l	#Delete_Current_Sprite,(a0)
		rts
; ---------------------------------------------------------------------------

Sprite_CheckDelete2:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	loc_850BA
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_850BA:
		move.w	respawn_addr(a0),d0
		beq.s	loc_850C6
		movea.w	d0,a2
		bclr	#7,(a2)

loc_850C6:
		bset	#4,$38(a0)
		move.l	#Delete_Current_Sprite,(a0)
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
		bhi.w	Go_Delete_Sprite_3
		move.w	y_pos(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmpi.w	#$200,d0
		bhi.w	Go_Delete_Sprite_3
		bchg	#6,$38(a0)
		beq.w	locret_8405E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouch:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_85088
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouch2:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_850BA
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
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
		move.w	x_pos(a0),d0				; Next three are unused, virtually the same
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_85088
		rts
; ---------------------------------------------------------------------------
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_85088
		rts
; ---------------------------------------------------------------------------
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_85088
		jmp	(Add_SpriteToCollisionResponseList).l

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

; ---------------------------------------------------------------------------

Go_Delete_Sprite_3:
		move.l	#Delete_Current_Sprite,(a0)
		bset	#7,status(a0)
		bset	#4,$38(a0)
		rts

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
		dc.w      0, -$100
		dc.w  -$100, -$100
		dc.w   $100, -$100
		dc.w  -$200, -$100
		dc.w   $200, -$100
		dc.w  -$200, -$200
		dc.w   $200, -$200
		dc.w  -$300, -$200
		dc.w   $300, -$200
		dc.w  -$300, -$300
		dc.w   $300, -$300
		dc.w  -$400, -$300
		dc.w   $400, -$300
		dc.w  -$200, -$300
		dc.w   $200, -$300

; =============== S U B R O U T I N E =======================================


Find_SonicTails8Way:
		bsr.w	Find_SonicTails		; This routine seems bugged slightly. Shouldn't the first two cmpi instructions look at d3 and not d2?
		cmp.w	d2,d3
		beq.s	loc_853E2
		bhi.s	loc_853BC
		swap	d3			; If Y distance is closer to object
		clr.w	d3
		divu.w	d2,d3
		tst.w	d0
		beq.s	loc_853AE
		cmpi.w	#$8000,d2	; If Y was closer and Sonic is to right of object
		blo.s	loc_853FE
		tst.w	d0
		beq.s	loc_853FA
		bra.w	loc_85402
; ---------------------------------------------------------------------------

loc_853AE:
		cmpi.w	#$8000,d2	; If Y was closer and Sonic is to left of object
		blo.s	loc_8540E
		tst.w	d1
		bne.s	loc_8540A
		bra.w	loc_85412
; ---------------------------------------------------------------------------

loc_853BC:
		swap	d2			; If X distance is closer to object
		clr.w	d2
		divu.w	d3,d2
		tst.w	d1
		bne.s	loc_853D4
		cmpi.w	#$8000,d2
		blo.s	loc_853F6
		tst.w	d0
		bne.s	loc_853FA
		bra.w	loc_85412
; ---------------------------------------------------------------------------

loc_853D4:
		cmpi.w	#$8000,d2
		blo.s	loc_85406
		tst.w	d0
		bne.s	loc_85402
		bra.w	loc_8540A
; ---------------------------------------------------------------------------

loc_853E2:
		tst.w	d0				; If X and Y distance are identical
		beq.s	loc_853EE
		tst.w	d1
		beq.s	loc_853FA
		bra.w	loc_85402
; ---------------------------------------------------------------------------

loc_853EE:
		tst.w	d1
		bne.s	loc_8540A
		bra.w	loc_85412
; ---------------------------------------------------------------------------

loc_853F6:
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_853FA:
		moveq	#1,d4
		rts
; ---------------------------------------------------------------------------

loc_853FE:
		moveq	#2,d4
		rts
; ---------------------------------------------------------------------------

loc_85402:
		moveq	#3,d4
		rts
; ---------------------------------------------------------------------------

loc_85406:
		moveq	#4,d4
		rts
; ---------------------------------------------------------------------------

loc_8540A:
		moveq	#5,d4
		rts
; ---------------------------------------------------------------------------

loc_8540E:
		moveq	#6,d4
		rts
; ---------------------------------------------------------------------------

loc_85412:
		moveq	#7,d4
		rts
; End of function Find_SonicTails8Way


; =============== S U B R O U T I N E =======================================


Set_VelocityXTrackSonic:
		lea	(Player_1).w,a1
		bsr.w	Find_OtherObject
		bclr	#0,render_flags(a0)
		tst.w	d0
		beq.s	loc_85430
		neg.w	d4
		bset	#0,render_flags(a0)

loc_85430:
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
		beq.s	loc_8545E
		bcs.s	loc_8544C
		neg.w	d1

loc_8544C:
		move.w	x_vel(a0),d4
		add.w	d1,d4
		cmp.w	d2,d4
		blt.s	loc_8545E
		cmp.w	d0,d4
		bgt.s	loc_8545E
		move.w	d4,x_vel(a0)

loc_8545E:
		move.w	y_pos(a0),d4
		cmp.w	y_pos(a1),d4
		beq.s	loc_85480
		bcs.s	loc_8546C
		neg.w	d3

loc_8546C:
		move.w	y_vel(a0),d4
		add.w	d3,d4
		cmp.w	d2,d4
		blt.s	locret_8547E
		cmp.w	d0,d4
		bgt.s	locret_8547E
		move.w	d4,y_vel(a0)

locret_8547E:
		rts
; ---------------------------------------------------------------------------

loc_85480:
		tst.b	d5
		beq.s	locret_8547E
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
		bhs.s	loc_854A6
		neg.w	d1

loc_854A6:
		move.w	x_vel(a0),d3
		add.w	d1,d3
		cmp.w	d2,d3
		blt.s	locret_854B8
		cmp.w	d0,d3
		bgt.s	locret_854B8
		move.w	d3,x_vel(a0)

locret_854B8:
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
		bhs.s	loc_854D2
		neg.w	d1

loc_854D2:
		move.w	y_vel(a0),d3
		add.w	d1,d3
		cmp.w	d2,d3
		blt.s	locret_854E4
		cmp.w	d0,d3
		bgt.s	locret_854E4
		move.w	d3,y_vel(a0)

locret_854E4:
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
		beq.s	loc_85516
		bcc.s	loc_85504
		neg.w	d1

loc_85504:
		move.w	x_vel(a0),d4
		add.w	d1,d4
		cmp.w	d2,d4
		blt.s	loc_85516
		cmp.w	d0,d4
		bgt.s	loc_85516
		move.w	d4,x_vel(a0)

loc_85516:
		move.w	y_pos(a1),d6
		move.b	child_dy(a0),d4
		ext.w	d4
		add.w	d4,d6
		cmp.w	y_pos(a0),d6
		beq.s	loc_85540
		bcc.s	loc_8552C
		neg.w	d3

loc_8552C:
		move.w	y_vel(a0),d4
		add.w	d3,d4
		cmp.w	d2,d4
		blt.s	locret_8553E
		cmp.w	d0,d4
		bgt.s	locret_8553E
		move.w	d4,y_vel(a0)

locret_8553E:
		rts
; ---------------------------------------------------------------------------

loc_85540:
		tst.b	d5
		beq.s	locret_8553E
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

Obj_FadeSelectedToBlack:
		move.l	#loc_8555E,(a0)
		move.b	#7,$39(a0)
		st	(Palette_rotation_disable).w

loc_8555E:
		subq.w	#1,$2E(a0)
		bpl.s	locret_8558E
		move.w	$3A(a0),$2E(a0)
		movea.w	$30(a0),a1
		move.w	$3C(a0),d0
		moveq	#$E,d1
		moveq	#-$20,d2

loc_85576:
		bsr.w	DecColor_Obj
		dbf	d0,loc_85576
		subq.b	#1,$39(a0)
		bpl.s	locret_8558E
		clr.b	(Palette_rotation_disable).w
		jsr	(Go_Delete_Sprite).l

locret_8558E:
		rts

; =============== S U B R O U T I N E =======================================


DecColor_Obj:
		move.b	(a1),d3
		and.b	d1,d3
		beq.s	loc_85598
		subq.b	#2,d3

loc_85598:
		move.b	d3,(a1)+
		move.b	(a1),d3
		move.b	d3,d4
		and.b	d2,d3
		beq.s	loc_855A6
		subi.b	#$20,d3

loc_855A6:
		and.b	d1,d4
		beq.s	loc_855AC
		subq.b	#2,d4

loc_855AC:
		or.b	d3,d4
		move.b	d4,(a1)+
		rts
; End of function DecColor_Obj

; ---------------------------------------------------------------------------

Obj_FadeSelectedFromBlack:
		move.l	#loc_855C2,(a0)
		move.b	#7,$39(a0)
		st	(Palette_rotation_disable).w

loc_855C2:
		subq.w	#1,$2E(a0)
		bpl.s	locret_855F6
		move.w	$3A(a0),$2E(a0)
		movea.w	$30(a0),a1
		movea.w	$32(a0),a2
		move.w	$3C(a0),d0
		moveq	#$E,d1
		moveq	#-$20,d2

loc_855DE:
		bsr.w	IncColor_Obj
		dbf	d0,loc_855DE
		subq.b	#1,$39(a0)
		bpl.s	locret_855F6
		clr.b	(Palette_rotation_disable).w
		jsr	(Go_Delete_Sprite).l

locret_855F6:
		rts

; =============== S U B R O U T I N E =======================================


IncColor_Obj:
		move.b	(a1),d3
		and.b	d1,d3
		move.b	(a2)+,d4
		and.b	d1,d4
		cmp.b	d4,d3
		bhs.s	loc_85606
		addq.b	#2,d3

loc_85606:
		move.b	d3,(a1)+
		move.b	(a1),d3
		move.b	d3,d4
		and.b	d2,d3
		move.b	(a2)+,d5
		move.b	d5,d6
		and.b	d2,d5
		cmp.b	d5,d3
		bhs.s	loc_8561C
		addi.b	#$20,d3

loc_8561C:
		and.b	d1,d4
		and.b	d1,d6
		cmp.b	d6,d4
		bhs.s	loc_85626
		addq.b	#2,d4

loc_85626:
		or.b	d3,d4
		move.b	d4,(a1)+
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

loc_85652:
		jsr	Animate_Raw(pc)
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

Refresh_ChildPosWait:
		jsr	Refresh_ChildPosition(pc)

Wait_Draw:
		jsr	Obj_Wait(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Wait_FadeToLevelMusic:
		subq.w	#1,$2E(a0)
		bmi.s	loc_85674
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_85674:
		bclr	#7,render_flags(a0)
		move.w	#(2*60)-1,$2E(a0)
		jsr	(AllocateObject).l
		bne.s	loc_8568E
		move.l	#Obj_Song_Fade_ToLevelMusic,(a1)

loc_8568E:
		movea.l	$34(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

Wait_NewDelay:
		subq.w	#1,$2E(a0)
		bmi.s	loc_856A0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_856A0:
		bclr	#7,render_flags(a0)
		move.w	#(2*60)-1,$2E(a0)
		movea.l	$34(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

MoveWaitTouch:
		jsr	(MoveSprite2).l
		jsr	Obj_Wait(pc)
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------

loc_856C0:	; used in S3, unused in S&K
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

; =============== S U B R O U T I N E =======================================


EnemyDefeated:
		bsr.w	EnemyDefeat_Score
		movea.w	$44(a0),a1
		tst.w	y_vel(a1)
		bmi.s	loc_85750
		move.w	y_pos(a1),d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_85758
		neg.w	y_vel(a1)
		rts
; ---------------------------------------------------------------------------

loc_85750:
		addi.w	#$100,y_vel(a1)
		rts
; ---------------------------------------------------------------------------

loc_85758:
		subi.w	#$100,y_vel(a1)
		rts
; End of function EnemyDefeated


; =============== S U B R O U T I N E =======================================


EnemyDefeat_Score:
		bset	#7,status(a0)
		clr.b	collision_flags(a0)
		moveq	#0,d0
		move.w	(Chain_bonus_counter).w,d0
		addq.w	#2,(Chain_bonus_counter).w
		cmpi.w	#6,d0
		blo.s	loc_8577C
		moveq	#6,d0

loc_8577C:
		move.w	d0,$3E(a0)
		move.w	word_857AC(pc,d0.w),d0
		cmpi.w	#$20,(Chain_bonus_counter).w
		blo.s	loc_85796
		move.w	#1000,d0	; 10000 points
		move.w	#$A,$3E(a0)

loc_85796:
		movea.w	a1,a3
		jsr	(HUD_AddToScore).l
		move.l	#Obj_Explosion,(a0)
		move.b	#0,routine(a0)
		rts
; End of function EnemyDefeat_Score

; ---------------------------------------------------------------------------
word_857AC:
		dc.w 10			; 100 points
		dc.w 20			; 200 points
		dc.w 50			; 500 points
		dc.w 100		; 1000 points

; =============== S U B R O U T I N E =======================================


HurtCharacter_Directly:
		movea.l	a0,a2
		movea.l	a1,a0
		jsr	(HurtCharacter).l
		movea.l	a2,a0
		rts
; End of function HurtCharacter_Directly


; =============== S U B R O U T I N E =======================================


Check_PlayerAttack:
		btst	#Status_Invincible,status_secondary(a1)
		bne.s	loc_85822
		cmpi.b	#9,anim(a1)
		beq.s	loc_85822
		cmpi.b	#2,anim(a1)
		beq.s	loc_85822
		moveq	#0,d0
		move.b	character_id(a1),d0
		add.w	d0,d0
		move.w	.Index(pc,d0.w),d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w Check_SonicAttack-.Index
		dc.w Check_TailsAttack-.Index
		dc.w Check_KnuxAttack-.Index
; ---------------------------------------------------------------------------

Check_SonicAttack:
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

Check_TailsAttack:
		tst.b	double_jump_flag(a1)
		beq.s	Check_SonicAttack		; If Tails is not flying, branch
		btst	#6,status(a1)
		bne.s	Check_SonicAttack		; If Tails is underwater, branch
		move.w	x_pos(a1),d1
		move.w	y_pos(a1),d2
		sub.w	x_pos(a0),d1
		sub.w	y_pos(a0),d2
		jsr	(GetArcTan).l		; Get angle between Tails and object
		subi.b	#$20,d0
		cmpi.b	#$40,d0
		bhs.s	Check_SonicAttack		; If Tails is between 20-60 degrees off object (directly below), then he is attacking

loc_85822:
		moveq	#1,d0
		rts
; End of function Check_PlayerAttack

; ---------------------------------------------------------------------------

Check_KnuxAttack:
		cmpi.b	#1,double_jump_flag(a1)
		beq.s	loc_85822
		cmpi.b	#3,double_jump_flag(a1)
		beq.s	loc_85822				; If Knux is gliding or sliding, then he's attacking
		bra.s	Check_SonicAttack

; =============== S U B R O U T I N E =======================================


Check_LRControllerShake:
		subq.b	#1,$3D(a0)
		bpl.s	loc_8584A
		move.b	#5,$3C(a0)
		move.b	#60,$3D(a0)

loc_8584A:
		movea.w	$3E(a0),a2
		move.w	(a2),d0
		andi.w	#$C,d0
		beq.s	locret_8586E
		move.w	$3A(a0),d1
		move.w	d0,$3A(a0)
		andi.w	#$C,d1
		eor.w	d1,d0
		beq.s	locret_8586E
		subq.b	#1,$3C(a0)
		bmi.s	locret_8586E
		moveq	#0,d0

locret_8586E:
		rts
; End of function Check_LRControllerShake


; =============== S U B R O U T I N E =======================================


Check_PlayerCollision:
		move.b	collision_property(a0),d0
		beq.s	locret_8588E
		clr.b	collision_property(a0)
		andi.w	#3,d0
		add.w	d0,d0
		lea	word_85890(pc),a1
		movea.w	(a1,d0.w),a1
		move.w	a1,$44(a0)
		moveq	#1,d1

locret_8588E:
		rts
; End of function Check_PlayerCollision

; ---------------------------------------------------------------------------
word_85890:
		dc.w Player_1
		dc.w Player_1
		dc.w Player_2
		dc.w Player_2

; =============== S U B R O U T I N E =======================================


Check_InTheirRange:
		move.w	x_pos(a0),d0
		move.w	x_pos(a1),d1
		add.w	(a2)+,d1
		cmp.w	d1,d0
		blt.s	loc_858C4
		add.w	(a2)+,d1
		cmp.w	d1,d0
		bge.s	loc_858C4
		move.w	y_pos(a0),d0
		move.w	y_pos(a1),d1
		add.w	(a2)+,d1
		cmp.w	d1,d0
		blt.s	loc_858C4
		add.w	(a2)+,d1
		cmp.w	d1,d0
		bge.s	loc_858C4
		moveq	#1,d0
		rts
; ---------------------------------------------------------------------------

loc_858C4:
		moveq	#0,d0
		rts
; End of function Check_InTheirRange


; =============== S U B R O U T I N E =======================================


Check_InMyRange:
		move.w	x_pos(a0),d0
		move.w	x_pos(a1),d1
		add.w	(a2)+,d0
		cmp.w	d0,d1
		blt.s	loc_858F4
		add.w	(a2)+,d0
		cmp.w	d0,d1
		bge.s	loc_858F4
		move.w	y_pos(a0),d0
		move.w	y_pos(a1),d1
		add.w	(a2)+,d0
		cmp.w	d0,d1
		blt.s	loc_858F4
		add.w	(a2)+,d0
		cmp.w	d0,d1
		bge.s	loc_858F4
		moveq	#1,d0
		rts
; ---------------------------------------------------------------------------

loc_858F4:
		moveq	#0,d0
		rts
; End of function Check_InMyRange


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
		bsr.w	sub_8592C
		swap	d0
		lea	(Player_1).w,a2
		move.w	x_pos(a2),d1
		move.w	y_pos(a2),d2
; End of function Check_PlayerInRange


; =============== S U B R O U T I N E =======================================


sub_8592C:
		cmp.w	d3,d1
		blo.s	locret_8593E
		cmp.w	d5,d1
		bhs.s	locret_8593E
		cmp.w	d4,d2
		blo.s	locret_8593E
		cmp.w	d6,d2
		bhs.s	locret_8593E
		move.w	a2,d0

locret_8593E:
		rts
; End of function sub_8592C


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
		beq.s	locret_85988
		bclr	#p1_standing_bit,status(a0)
		beq.s	loc_85970
		lea	(Player_1).w,a1
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)

loc_85970:
		bclr	#p2_standing_bit,status(a0)
		beq.s	locret_85988
		lea	(Player_2).w,a1
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)

locret_85988:
		rts
; End of function Displace_PlayerOffObject


; =============== S U B R O U T I N E =======================================


Run_PalRotationScript:
		tst.b	(Palette_rotation_disable).w
		bne.s	locret_85A00
		lea	(Palette_rotation_data).w,a1

loc_85994:
		move.w	(a1),d0					; load palette displacement to d0
		beq.s	locret_85A00				; if 0, return
		subq.b	#1,2(a1)				; decrement delay
		bpl.s	loc_859CA				; if still positive, go to next entry
		movea.l	4(a1),a2				; load palette script address to a2
		movea.w	(a2),a3					; load destination address to a3
		movea.l	a2,a4					; copy script address to a4
		adda.w	d0,a4					; skip to palette data
		move.w	(a4),d1					; load the first entry to d1
		bpl.s	loc_859B0				; if positive, it is a normal entry
		bsr.w	sub_859CE				; this is a command

loc_859B0:
		moveq	#0,d2
		move.b	2(a2),d2				; load number of colors to d2

loc_859B6:
		move.w	(a4)+,(a3)+				; copy the next color into destination
		dbf	d2,loc_859B6				; loop for every color
		move.w	(a4)+,d0				; load next delay
		move.b	d0,2(a1)				; save the delay
		move.l	a4,d0					; copy current script position into d0
		move.l	a2,d1					; copy palette script origin to d1
		sub.l	d1,d0					; calculate the current displacement
		move.w	d0,(a1)					; store it back

loc_859CA:
		addq.w	#8,a1					; go to next script
		bra.s	loc_85994				; run the code again
; End of function Run_PalRotationScript


; =============== S U B R O U T I N E =======================================


sub_859CE:
		move.b	3(a2),d2				; load additional parameter to d2
		beq.s	loc_859FC
		neg.w	d1
		jmp	.table-8(pc,d1.w)
; ---------------------------------------------------------------------------

.table
		bra.w	loc_859E2
		bra.w	loc_85A02
; ---------------------------------------------------------------------------

loc_859E2:
		addq.b	#1,3(a1)		; Add one to counter
		cmp.b	3(a1),d2		; Compare with max counter
		bhi.s	loc_859FC
		move.w	2(a4),d2
		adda.w	d2,a2
		move.l	a2,4(a1)		; Load new script after counter has finished
		movea.w	(a2),a3
		clr.w	2(a1)

loc_859FC:
		movea.l	a2,a4			; Start from the beginning of the rotation
		addq.l	#4,a4

locret_85A00:
		rts
; End of function sub_859CE

; ---------------------------------------------------------------------------

loc_85A02:
		addq.b	#1,3(a1)
		cmp.b	3(a1),d2
		bhi.s	loc_859FC		; Wait for counter to finish
		movea.l	(Palette_rotation_custom).w,a2
		move.l	a1,-(sp)
		jsr	(a2)				; Run custom routine
		movea.l	(sp)+,a1
		addq.w	#4,sp
		bra.s	loc_859CA

; =============== S U B R O U T I N E =======================================


Run_PalRotationScript2:
		tst.b	(Palette_rotation_disable).w
		bne.s	locret_85A58
		subq.b	#1,$3A(a0)
		bpl.s	locret_85A58
		movea.l	(a1)+,a3		; Address of Palette animation data
		move.w	(a1)+,d0		; Number of colors to replace
		moveq	#0,d1
		move.b	$3B(a0),d1
		addq.b	#2,d1
		moveq	#0,d2
		move.b	(a1,d1.w),d2
		bpl.s	loc_85A3E
		moveq	#0,d1
		move.b	(a1),d2

loc_85A3E:
		move.b	d1,$3B(a0)
		move.b	1(a1,d1.w),$3A(a0)
		add.w	d2,d2
		move.w	(a3,d2.w),d2
		lea	(a3,d2.w),a3

loc_85A52:
		move.w	(a3)+,(a2)+
		dbf	d0,loc_85A52

locret_85A58:
		rts
; End of function Run_PalRotationScript2


; =============== S U B R O U T I N E =======================================


Child_GetPriority:
		movea.w	parent3(a0),a1
		bclr	#7,art_tile(a0)
		btst	#7,art_tile(a1)
		beq.s	loc_85A72
		bset	#7,art_tile(a0)

loc_85A72:
		move.w	priority(a1),priority(a0)
		rts
; End of function Child_GetPriority


; =============== S U B R O U T I N E =======================================


Child_GetPriorityOnce:
		movea.w	parent3(a0),a1
		btst	#7,art_tile(a1)
		beq.s	locret_85A8E
		bset	#7,art_tile(a0)
		move.l	(sp),(a0)

locret_85A8E:
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
		move.l	#loc_85AD2,(a0)

loc_85AD2:
		tst.b	render_flags(a0)
		bmi.s	loc_85B02
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	loc_85AF0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_85AF0:
		move.w	respawn_addr(a0),d0
		beq.s	loc_85AFC
		movea.w	d0,a2
		bclr	#7,(a2)

loc_85AFC:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_85B02:
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
		move.l	#loc_85B1E,(a0)

loc_85B1E:
		subq.w	#1,$2E(a0)
		bpl.w	locret_8405E
		bsr.w	Restore_LevelMusic
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_Song_Fade_Transition:
		move.w	#90,$2E(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.l	#loc_85B44,(a0)

loc_85B44:
		subq.w	#1,$2E(a0)
		bpl.w	locret_8405E
		move.b	subtype(a0),d0
		move.b	d0,(Current_music+1).w
		jsr	(Play_Music).l
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


Restore_LevelMusic:
		moveq	#0,d0
		lea	(Apparent_zone_and_act).w,a1
		move.b	(a1)+,d0
		add.b	d0,d0
		add.b	(a1),d0
		lea	(LevelMusic_Playlist).l,a2
		move.b	(a2,d0.w),d0
		move.w	d0,(Current_music).w
		btst	#Status_Invincible,(Player_1+status_secondary).w
		beq.s	loc_85B84
		moveq	#signextendB(mus_Invincibility),d0		; If invincible, play invincibility

loc_85B84:
		jmp	(Play_Music).l
; End of function Restore_LevelMusic


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
		bset	#4,$38(a0)
		move.w	#(2*60)-1,$2E(a0)
		move.l	#Obj_EndSignControlDoSign,$34(a0)
		rts
; End of function Obj_EndSignControl

; ---------------------------------------------------------------------------
PLC_EndSignStuff: plrlistheader
		plreq $69E, ArtNem_SignpostStub
		plreq ArtTile_Monitors, ArtNem_Monitors
PLC_EndSignStuff_End
; ---------------------------------------------------------------------------

Obj_EndSignControlWait:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

Obj_EndSignControlDoSign:
		move.l	#Obj_EndSignControlAwaitStart,(a0)
		clr.b	(Boss_flag).w
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
		bne.w	locret_8405E
		move.l	#Obj_EndSignControlDoStart,(a0)
		jsr	Restore_PlayerControl(pc)
		lea	(Player_2).w,a1
		jmp	Restore_PlayerControl2(pc)
; ---------------------------------------------------------------------------

Obj_EndSignControlDoStart:
		tst.b	(End_of_level_flag).w		; Wait for title card to finish
		beq.w	locret_8405E
		jsr	Change_Act2Sizes(pc)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
		jsr	Displace_PlayerOffObject(pc)
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


Check_CameraInRange:
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(a1)+,d0
		blo.s	loc_85C74
		cmp.w	(a1)+,d0
		bhi.s	loc_85C74
		move.w	(Camera_X_pos).w,d1
		cmp.w	(a1)+,d1
		blo.s	loc_85C74
		cmp.w	(a1)+,d1
		bhi.s	loc_85C74
		bclr	#7,$27(a0)
		cmp.w	(a1),d0
		bls.s	loc_85C5E
		bset	#7,$27(a0)

loc_85C5E:
		bclr	#6,$27(a0)
		cmp.w	4(a1),d1
		bls.s	loc_85C70
		bset	#6,$27(a0)

loc_85C70:
		move.l	(sp),(a0)
		rts
; ---------------------------------------------------------------------------

loc_85C74:
		jsr	(Delete_Sprite_If_Not_In_Range).l
		addq.w	#4,sp
		rts
; End of function Check_CameraInRange

; ---------------------------------------------------------------------------

loc_85C7E:
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		move.w	(Camera_target_max_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		blo.s	locret_85CA2
		move.w	d0,(Camera_min_Y_pos).w
		move.w	$3A(a0),d0
		cmp.w	(Camera_X_pos).w,d0
		bhi.s	locret_85CA2
		movea.l	$34(a0),a1
		jsr	(a1)

locret_85CA2:
		rts
; ---------------------------------------------------------------------------

loc_85CA4:
		btst	#0,$27(a0)
		bne.s	loc_85CC6
		subq.w	#1,$2E(a0)
		bpl.s	loc_85CC6
		move.b	$26(a0),d0
		move.b	d0,(Current_music+1).w
		jsr	(Play_Music).l
		bset	#0,$27(a0)

loc_85CC6:
		btst	#1,$27(a0)
		bne.s	loc_85D06
		move.w	(Camera_Y_pos).w,d0
		tst.b	$27(a0)
		bmi.s	loc_85CE6
		cmp.w	(_unkFAB0).w,d0
		bhs.s	loc_85CF2
		move.w	d0,(Camera_min_Y_pos).w
		bra.w	loc_85D06
; ---------------------------------------------------------------------------

loc_85CE6:
		move.w	(_unkFAB2).w,d1
		addi.w	#$60,d1
		cmp.w	d1,d0
		bhi.s	loc_85D06

loc_85CF2:
		bset	#1,$27(a0)
		move.w	(_unkFAB0).w,(Camera_min_Y_pos).w
		move.w	(_unkFAB2).w,d0
		move.w	d0,(Camera_target_max_Y_pos).w

loc_85D06:
		btst	#2,$27(a0)
		bne.s	loc_85D48
		move.w	(Camera_X_pos).w,d0
		btst	#6,$27(a0)
		bne.s	loc_85D28
		cmp.w	(_unkFAB4).w,d0
		bhs.s	loc_85D36
		move.w	d0,(Camera_min_X_pos).w
		bra.w	loc_85D48
; ---------------------------------------------------------------------------

loc_85D28:
		cmp.w	(_unkFAB6).w,d0
		bls.s	loc_85D36
		move.w	d0,(Camera_max_X_pos).w
		bra.w	loc_85D48
; ---------------------------------------------------------------------------

loc_85D36:
		bset	#2,$27(a0)
		move.w	(_unkFAB4).w,(Camera_min_X_pos).w
		move.w	(_unkFAB6).w,(Camera_max_X_pos).w

loc_85D48:
		move.b	$27(a0),d0
		andi.b	#7,d0
		cmpi.b	#7,d0
		bne.w	locret_8405E
		clr.b	$27(a0)
		clr.w	$1C(a0)
		clr.b	$26(a0)
		movea.l	$34(a0),a1
		jmp	(a1)

; =============== S U B R O U T I N E =======================================


sub_85D6A:
		move.b	#1,(Boss_flag).w

loc_85D70:
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.w	#2*60,$2E(a0)

loc_85D7E:
		move.w	(Camera_min_Y_pos).w,(Camera_stored_min_Y_pos).w
		move.w	(Camera_target_max_Y_pos).w,(Camera_stored_max_Y_pos).w
		move.w	(Camera_min_X_pos).w,(Camera_stored_min_X_pos).w
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w
		move.w	(a1)+,(_unkFAB0).w
		move.w	(a1)+,(_unkFAB2).w
		move.w	(a1)+,(_unkFAB4).w
		move.w	(a1)+,(_unkFAB6).w
		rts
; End of function sub_85D6A


; =============== S U B R O U T I N E =======================================


Change_Act2Sizes:
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		cmpi.b	#8,d0
		beq.w	locret_8405E		; SOZ1 has a special event leading to SOZ2, so don't mess around there
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
		beq.w	locret_8405E		; If we're in HCZ, don't immediately apply these changes. There's another event to do.
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
; ---------------------------------------------------------------------------
		lea	(Current_zone_and_act).w,a1		; Unused
		moveq	#0,d0
		moveq	#0,d1
		move.b	(a1)+,d0
		lsl.w	#4,d0
		tst.b	(a1)+
		beq.s	loc_85E0E
		addq.w	#8,d1

loc_85E0E:
		add.w	d1,d0
		lea	(LevelSizes).l,a1
		lea	(a1,d0.w),a1
		move.w	(a1)+,(Camera_stored_min_X_pos).w
		move.w	(a1)+,(Camera_stored_max_X_pos).w
		move.w	(a1)+,(Camera_stored_min_Y_pos).w
		move.w	(a1)+,d1
		move.w	d1,(Camera_stored_max_Y_pos).w
		move.w	d1,(Camera_target_max_Y_pos).w
		lea	(Child7_ChangeLevSize).l,a2
		jmp	CreateChild7_Normal2(pc)

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
		bne.w	locret_8405E
		jmp	(Play_SFX).l
; End of function Play_SFX_Continuous

; ---------------------------------------------------------------------------

loc_85E64:
		move.b	#7,$39(a0)
		move.l	#loc_85E74,(a0)
		st	(Palette_rotation_disable).w

loc_85E74:
		subq.w	#1,$2E(a0)
		bpl.s	locret_85EA8
		move.w	$3A(a0),$2E(a0)
		lea	(Normal_palette).w,a1
		moveq	#$40-1,d0

loc_85E86:
		bsr.w	sub_85EB4
		dbf	d0,loc_85E86
		subq.b	#1,$39(a0)
		bmi.s	loc_85E96
		rts
; ---------------------------------------------------------------------------

loc_85E96:
		tst.b	subtype(a0)
		beq.s	loc_85EAA
		move.l	#loc_85EE6,(a0)
		bset	#5,$38(a0)

locret_85EA8:
		rts
; ---------------------------------------------------------------------------

loc_85EAA:
		clr.b	(Palette_rotation_disable).w
		jmp	(Go_Delete_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_85EB4:
		moveq	#$E,d2
		move.b	(a1),d3
		and.b	d2,d3
		cmp.b	d2,d3
		bhs.s	loc_85EC2
		addq.b	#2,d3
		move.b	d3,(a1)

loc_85EC2:
		addq.w	#1,a1
		move.b	(a1),d3
		move.b	d3,d4
		andi.b	#$E0,d3
		andi.b	#$E,d4
		cmpi.b	#$E0,d3
		bhs.s	loc_85EDA
		addi.b	#$20,d3

loc_85EDA:
		cmp.b	d2,d4
		bhs.s	loc_85EE0
		addq.b	#2,d4

loc_85EE0:
		or.b	d3,d4
		move.b	d4,(a1)+
		rts
; End of function sub_85EB4

; ---------------------------------------------------------------------------

loc_85EE6:
		move.b	#7,$39(a0)
		move.w	#3,$2E(a0)
		move.l	#loc_85EF8,(a0)

loc_85EF8:
		subq.w	#1,$2E(a0)
		bpl.w	locret_8405E
		move.w	#3,$2E(a0)
		lea	(Normal_palette).w,a1
		lea	(Target_palette).w,a2
		moveq	#$40-1,d0

loc_85F10:
		bsr.w	sub_85F2A
		dbf	d0,loc_85F10
		subq.b	#1,$39(a0)
		bpl.w	locret_8405E
		clr.b	(Palette_rotation_disable).w
		jmp	(Go_Delete_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_85F2A:
		move.b	(a2)+,d2
		andi.b	#$E,d2
		move.b	(a1),d3
		cmp.b	d2,d3
		bls.s	loc_85F3A
		subq.b	#2,d3
		move.b	d3,(a1)

loc_85F3A:
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
		bls.s	loc_85F5C
		subi.b	#$20,d4

loc_85F5C:
		cmp.b	d3,d5
		bls.s	loc_85F62
		subq.b	#2,d5

loc_85F62:
		or.b	d4,d5
		move.b	d5,(a1)+
		rts
; End of function sub_85F2A

; ---------------------------------------------------------------------------
loc_85F68:	; used in S3, unused in S3&K
		move.w	(Player_mode).w,d0
		cmpi.w	#2,d0
		beq.s	loc_85F7E
		cmpi.w	#7,(Emerald_counts).w
		beq.s	loc_85F82
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_85F7E:
		moveq	#1,d0
		rts
; ---------------------------------------------------------------------------

loc_85F82:
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
		movea.l	.Index(pc,d0.w),a1
		jsr	(a1)
		movea.l	(sp)+,a0
		rts
; End of function Player_Load_PLC

; ---------------------------------------------------------------------------
.Index:
		dc.l Sonic_Load_PLC
		dc.l Tails_Load_PLC
		dc.l Knuckles_Load_PLC

; =============== S U B R O U T I N E =======================================


Player_Load_PLC2:
		move.l	a0,-(sp)
		movea.l	a1,a0
		tst.l	(a0)
		beq.s	.skip
		moveq	#0,d0
		move.b	character_id(a0),d0
		lsl.w	#2,d0
		movea.l	Player_Load_PLC.Index(pc,d0.w),a1
		jsr	(a1)

.skip:
		movea.l	(sp)+,a0
		rts
; End of function Player_Load_PLC2


; =============== S U B R O U T I N E =======================================


PLCLoad_AnimalsAndExplosion:
		lea	PLC_Explosion(pc),a1
		jsr	(Load_PLC_Raw).l
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		add.w	d0,d0
		move.w	.Index(pc,d0.w),d0
		lea	.Index(pc,d0.w),a1
		jmp	(Load_PLC_Raw).l
; End of function PLCLoad_AnimalsAndExplosion

; ---------------------------------------------------------------------------
.Index:
		dc.w PLC_Animals_AIZ-.Index
		dc.w PLC_Animals_HCZ-.Index
		dc.w PLC_Animals_MGZ-.Index
		dc.w PLC_Animals_CNZ-.Index
		dc.w PLC_Animals_FBZ-.Index
		dc.w PLC_Animals_ICZ-.Index
		dc.w PLC_Animals_LBZ-.Index
		dc.w PLC_Animals_MHZ-.Index
		dc.w PLC_Animals_SOZ-.Index
		dc.w PLC_Animals_LRZ-.Index
		dc.w PLC_Animals_SSZ-.Index
		dc.w PLC_Animals_DEZ-.Index
		dc.w PLC_Animals_DDZ-.Index
		dc.w PLC_Animals_LRZ3-.Index
		dc.w PLC_Animals_LRZ3-.Index
		dc.w PLC_Animals_LRZ3-.Index
		dc.w PLC_Animals_LRZ3-.Index
		dc.w PLC_Animals_LRZ3-.Index
		dc.w PLC_Animals_LRZ3-.Index
		dc.w PLC_Animals_LRZ3-.Index
		dc.w PLC_Animals_LRZ3-.Index
		dc.w PLC_Animals_LRZ3-.Index
		dc.w PLC_Animals_LRZ3-.Index
		dc.w PLC_Animals_LRZ3-.Index
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
		plreq $580, ArtNem_BlueFlicky
		plreq $592, ArtNem_Chicken
PLC_Animals_LBZ_End

PLC_Animals_MHZ: plrlistheader
		plreq $580, ArtNem_Squirrel
		plreq $592, ArtNem_Chicken
PLC_Animals_MHZ_End

PLC_Animals_SOZ: plrlistheader
		plreq $580, ArtNem_Rabbit
		plreq $592, ArtNem_Chicken
PLC_Animals_SOZ_End

PLC_Animals_LRZ: plrlistheader
		plreq $580, ArtNem_BlueFlicky
		plreq $592, ArtNem_Chicken
PLC_Animals_LRZ_End

PLC_Animals_SSZ: plrlistheader
		plreq $580, ArtNem_Rabbit
		plreq $592, ArtNem_Chicken
PLC_Animals_SSZ_End

PLC_Animals_DEZ: plrlistheader
		plreq $580, ArtNem_Squirrel
		plreq $592, ArtNem_Chicken
PLC_Animals_DEZ_End

PLC_Animals_DDZ: plrlistheader
		plreq $580, ArtNem_Squirrel
		plreq $592, ArtNem_Chicken
PLC_Animals_DDZ_End

PLC_Animals_LRZ3: plrlistheader
		plreq $580, ArtNem_BlueFlicky
		plreq $592, ArtNem_Chicken
PLC_Animals_LRZ3_End
; ---------------------------------------------------------------------------

AddRings:
		lea	(Ring_count).w,a2
		lea	(Update_HUD_ring_count).w,a3
		lea	(Extra_life_flags).w,a4
		lea	(Total_ring_count).w,a5
		move.w	#999,d1
		add.w	d0,(a5)
		cmp.w	(a5),d1
		bhs.s	loc_8610E
		move.w	d1,(a5)

loc_8610E:
		add.w	d0,(a2)
		cmp.w	(a2),d1
		bhs.s	loc_86116
		move.w	d1,(a2)

loc_86116:
		ori.b	#1,(a3)
		cmpi.w	#100,(a2)
		blo.s	loc_86132
		bset	#1,(a4)
		beq.s	loc_8613A
		cmpi.w	#200,(a2)
		blo.s	loc_86132
		bset	#2,(a4)
		beq.s	loc_8613A

loc_86132:
		moveq	#signextendB(sfx_RingRight),d0
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------

loc_8613A:
		addq.w	#1,(Monitors_broken).w		; Add an extra life
		addq.b	#1,(Life_count).w
		addq.b	#1,(Update_HUD_life_count).w
		moveq	#signextendB(mus_ExtraLife),d0
		jmp	(Play_Music).l

; =============== S U B R O U T I N E =======================================


Perform_Art_Scaling:
		clr.w	(_unkF740).w
		move.l	a0,-(sp)
		jsr	Init_ArtScaling
		movea.l	(sp)+,a0
		move.l	a0,-(sp)
		move.w	art_tile(a0),d0
		jsr	(sub_2468A).l
		movea.l	(sp)+,a0
		move.w	(_unkF740).w,d3
		lsl.w	#4,d3
		move.l	#Kos_decomp_buffer,d1
		move.w	$3A(a0),d2
		jmp	(Add_To_DMA_Queue).l
; End of function Perform_Art_Scaling


; =============== S U B R O U T I N E =======================================


sub_86180:
		move.w	x_vel(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$30(a0)
		move.w	y_vel(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$34(a0)
		rts
; End of function sub_86180


; =============== S U B R O U T I N E =======================================


sub_8619A:
		move.w	$30(a0),d2
		move.w	$34(a0),d3
		moveq	#0,d0
		move.b	$40(a0),d0
		addq.w	#4,d0
		move.l	#$100,d4
		divu.w	d0,d4
		sub.w	d4,d2
		sub.w	d4,d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		rts
; End of function sub_8619A

; ---------------------------------------------------------------------------

loc_861C0:
		lea	(Player_1).w,a1
		moveq	#0,d0
		move.w	x_pos(a1),d0
		moveq	#0,d1
		move.w	y_pos(a1),d1

; =============== S U B R O U T I N E =======================================


sub_861D0:
		sub.w	x_pos(a0),d0
		smi	d2
		bpl.s	loc_861DA
		neg.w	d0

loc_861DA:
		sub.w	y_pos(a0),d1
		smi	d3
		bpl.s	loc_861E4
		neg.w	d1

loc_861E4:
		cmp.w	d1,d0
		scs	d4
		beq.s	loc_8621A
		bcc.s	loc_861EE
		exg	d0,d1

loc_861EE:
		swap	d1
		divu.w	d0,d1

loc_861F2:
		move.w	#$100,d0
		lsl.w	d5,d0
		moveq	#8,d6
		sub.w	d5,d6
		lsr.w	d6,d1

loc_861FE:
		tst.b	d4
		beq.s	loc_86204
		exg	d0,d1

loc_86204:
		tst.b	d2
		beq.s	loc_8620A
		neg.w	d0

loc_8620A:
		tst.b	d3
		beq.s	loc_86210
		neg.w	d1

loc_86210:
		move.w	d0,x_vel(a0)
		move.w	d1,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_8621A:
		tst.w	d0
		beq.s	loc_861F2
		move.w	#$100,d0
		lsl.w	d5,d0
		move.w	#$100,d1
		lsl.w	d5,d1
		bra.s	loc_861FE
; End of function sub_861D0


; =============== S U B R O U T I N E =======================================


sub_8622C:
		moveq	#0,d0
		moveq	#0,d1
		moveq	#0,d2
		moveq	#0,d3
		moveq	#0,d4
		move.w	x_pos(a2),d0
		move.w	y_pos(a2),d1
		sub.w	x_pos(a1),d0
		bpl.s	loc_86248
		neg.w	d0
		moveq	#8,d2

loc_86248:
		sub.w	y_pos(a1),d1
		bpl.s	loc_86252
		neg.w	d1
		moveq	#4,d3

loc_86252:
		cmp.w	d0,d1
		bhs.s	loc_8625A
		exg	d0,d1
		moveq	#2,d4

loc_8625A:
		tst.w	d1
		beq.s	locret_8627E
		lsl.w	#5,d0
		divu.w	d1,d0
		add.w	d2,d3
		add.w	d3,d4
		move.w	off_8626E(pc,d4.w),d4
		jmp	off_8626E(pc,d4.w)
; ---------------------------------------------------------------------------
off_8626E:
		dc.w locret_8627E-off_8626E
		dc.w loc_86280-off_8626E
		dc.w loc_86288-off_8626E
		dc.w loc_86290-off_8626E
		dc.w loc_86296-off_8626E
		dc.w loc_8629A-off_8626E
		dc.w loc_862A0-off_8626E
		dc.w loc_862A6-off_8626E
; ---------------------------------------------------------------------------

locret_8627E:
		rts
; End of function sub_8622C

; ---------------------------------------------------------------------------

loc_86280:
		subi.w	#$40,d0
		neg.w	d0
		rts
; ---------------------------------------------------------------------------

loc_86288:
		subi.w	#$80,d0
		neg.w	d0
		rts
; ---------------------------------------------------------------------------

loc_86290:
		addi.w	#$40,d0
		rts
; ---------------------------------------------------------------------------

loc_86296:
		neg.w	d0
		rts
; ---------------------------------------------------------------------------

loc_8629A:
		addi.w	#$C0,d0
		rts
; ---------------------------------------------------------------------------

loc_862A0:
		addi.w	#$80,d0
		rts
; ---------------------------------------------------------------------------

loc_862A6:
		subi.w	#$C0,d0
		neg.w	d0
		rts
; ---------------------------------------------------------------------------

Obj_SpriteMask:
		bset	#2,render_flags(a0)

loc_862B4:
		clr.w	art_tile(a0)
		move.l	#Map_SpriteMask,mappings(a0)
		move.b	#$20,width_pixels(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.l	#loc_862FE,(a0)
		btst	#3,d0
		beq.s	loc_862DE
		move.l	#loc_86308,(a0)

loc_862DE:
		move.w	d0,d1
		andi.w	#$F0,d0
		lsr.w	#2,d0
		move.b	d0,height_pixels(a0)
		lsr.w	#2,d0
		move.b	d0,mapping_frame(a0)
		andi.w	#7,d1
		add.w	d1,d1
		move.w	word_86324(pc,d1.w),priority(a0)
		rts
; ---------------------------------------------------------------------------

loc_862FE:
		st	(Spritemask_flag).w
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_86308:
		st	(Spritemask_flag).w
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.s	loc_8631E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8631E:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
word_86324:
		dc.w      0,   $80,  $100,  $180,  $200,  $280,  $300,  $380
; ---------------------------------------------------------------------------

loc_86334:
		move.w	#(button_right_mask<<8)|button_right_mask,d0
		tst.w	$2E(a0)
		beq.s	loc_86346
		subq.w	#1,$2E(a0)
		move.w	#((button_A_mask|button_right_mask)<<8)|button_right_mask,d0

loc_86346:
		btst	#5,(Player_1+status).w
		beq.s	loc_86358
		move.w	#$1F,$2E(a0)
		move.w	#((button_A_mask|button_right_mask)<<8)|(button_A_mask|button_right_mask),d0

loc_86358:
		move.w	d0,(Ctrl_1_logical).w
		rts

; =============== S U B R O U T I N E =======================================


sub_8635E:
		move.w	d0,y_vel(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		clr.b	spin_dash_flag(a1)
		move.b	#$10,anim(a1)
		move.b	#2,routine(a1)
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; End of function sub_8635E


; =============== S U B R O U T I N E =======================================


sub_8638A:
		lea	(Player_1).w,a1
		bsr.w	sub_8639C
		lea	(Player_2).w,a1
		tst.b	render_flags(a1)
		bpl.s	locret_863BE
; End of function sub_8638A


; =============== S U B R O U T I N E =======================================


sub_8639C:
		move.w	x_pos(a0),d0
		bclr	#0,render_flags(a1)
		bclr	#Status_Facing,status(a1)
		cmp.w	x_pos(a1),d0
		bhs.s	locret_863BE
		bset	#0,render_flags(a1)
		bset	#Status_Facing,status(a1)

locret_863BE:
		rts
; End of function sub_8639C

; ---------------------------------------------------------------------------

loc_863C0:
		tst.l	(Player_2).w
		beq.s	loc_863E6
		move.b	#1,(Ctrl_2_locked).w
		clr.w	(Tails_CPU_idle_timer).w
		move.l	#loc_863D6,(a0)

loc_863D6:
		tst.b	(Ctrl_2_locked).w
		beq.s	loc_863E2
		clr.w	(Ctrl_2_logical).w
		rts
; ---------------------------------------------------------------------------

loc_863E2:
		clr.w	(Ctrl_2).w

loc_863E6:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_StartNewLevel:
		lea	(Player_1).w,a1
		lea	word_86426(pc),a2
		jsr	(Check_InMyRange).l
		beq.w	locret_8405E
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_86418
		cmpi.b	#9,(Current_zone).w
		bne.s	loc_86418
		st	(SRAM_mask_interrupts_flag).w
		jsr	(SaveGame).l

loc_86418:
		moveq	#0,d0
		move.w	subtype(a0),d0
		lsr.w	#1,d0
		rol.b	#1,d0
		jmp	StartNewLevel(pc)
; ---------------------------------------------------------------------------
word_86426:
		dc.w   -$10,   $20,  -$80,  $100
; ---------------------------------------------------------------------------

loc_8642E:
		st	(Screen_shake_flag).w
		move.l	#loc_86438,(a0)

loc_86438:
		tst.w	(Screen_shake_flag).w
		beq.s	loc_86452
		move.b	(V_int_run_count+3).w,d1
		andi.b	#$F,d1
		bne.w	locret_8405E
		moveq	#signextendB(sfx_Rumble2),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

loc_86452:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_86458:
		lea	sub2_x_pos(a0),a2
		move.w	mainspr_childsprites(a0),d0
		subq.w	#1,d0
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3

loc_8646A:
		move.b	(a1)+,d1
		ext.w	d1
		btst	#0,render_flags(a0)
		beq.s	loc_86478
		neg.w	d1

loc_86478:
		add.w	d2,d1
		move.w	d1,(a2)+
		move.b	(a1)+,d1
		ext.w	d1
		add.w	d3,d1
		move.w	d1,(a2)+
		addq.w	#2,a2
		dbf	d0,loc_8646A
		rts
; End of function sub_86458

; ---------------------------------------------------------------------------

Ending_Give_SuperSonic:
		addi.w	#50,(Ring_count).w
		move.b	#1,(Super_palette_status).w
		move.b	#$F,(Palette_timer).w
		move.b	#1,(Super_Sonic_Knux_flag).w
		move.w	#60,(Super_frame_count).w
		move.w	#$800,(Max_speed).w
		move.w	#$18,(Acceleration).w
		move.w	#$C0,(Deceleration).w
		move.b	#$1F,(Player_1+anim).w
		cmpi.w	#2,(Player_mode).w
		bne.s	.notTails

		move.b	#0,(Super_Sonic_Knux_flag).w
		move.b	#1,(Super_Tails_flag).w
		move.b	#$29,(Player_1+anim).w
		move.w	#$800,(Max_speed_P2).w
		move.w	#$18,(Acceleration_P2).w
		move.w	#$C0,(Deceleration_P2).w
		move.l	#Obj_SuperTailsBirds,(Invincibility_stars).w
		bra.s	.continued
; ---------------------------------------------------------------------------

	.notTails:
		bhs.s	.hyperKnuckles
		move.l	#Map_SuperSonic,(Player_1+mappings).w
		move.b	#-1,(Super_Sonic_Knux_flag).w
		move.w	#$A00,(Max_speed).w
		move.w	#$30,(Acceleration).w
		move.w	#$100,(Deceleration).w
		move.l	#Obj_HyperSonic_Stars,(Invincibility_stars).w
		; Bug: Sonic turns Hyper after the credits no matter which emeralds he has
		; Note that he doesn't get his Hyper after-images even when he should
		;move.l	#Obj_HyperSonicKnux_Trail,(Super_stars).w
		bra.s	.continued
; ---------------------------------------------------------------------------

	.hyperKnuckles:
		; Bug: Knuckles gets his Hyper after-images, but isn't actually marked as Hyper
		;move.b	#-1,(Super_Sonic_Knux_flag).w		; Hyper
		move.l	#Obj_HyperSonicKnux_Trail,(Super_stars).w

	.continued:
		move.b	#$81,(Player_1+object_control).w
		move.b	#0,(Player_1+invincibility_timer).w
		bset	#Status_Invincible,(Player_1+status_secondary).w
		rts
