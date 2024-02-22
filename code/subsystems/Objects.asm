; =============== S U B R O U T I N E =======================================


Init_SpriteTable:
		clr.w	(Spritemask_flag).w
	if Sprite_table_page_flip_pending<>(Current_sprite_table_page+2)
		clr.w	(Current_sprite_table_page).w
		clr.w	(Sprite_table_page_flip_pending).w
	else
		clr.l	(Current_sprite_table_page).w ; Clears both Current_sprite_table_page and Sprite_table_page_flip_pending!
	endif
		tst.w	(Competition_mode).w
		beq.s	loc_1AA9E
		lea	(Sprite_table).w,a0
		bsr.s	Init_SpriteTable2
		bsr.s	Init_SpriteTable_2Player
		lea	(Sprite_table_alternate).l,a0
		bsr.s	Init_SpriteTable2
		bsr.s	Init_SpriteTable_2Player
		lea	(Sprite_table_P2).l,a0
		bsr.s	Init_SpriteTable2
		lea	(Sprite_table_P2_alternate).l,a0
		bra.s	Init_SpriteTable2
; ---------------------------------------------------------------------------

loc_1AA9E:
		lea	(Sprite_table).w,a0
; End of function Init_SpriteTable


; =============== S U B R O U T I N E =======================================


Init_SpriteTable2:
		moveq	#0,d0
		moveq	#1,d1
		moveq	#$50-1,d7

.loop:
		move.w	d0,(a0)
		move.b	d1,3(a0)
		addq.w	#1,d1
		addq.w	#8,a0
		dbf	d7,.loop
		move.b	d0,-5(a0)
		rts
; End of function Init_SpriteTable2


; =============== S U B R O U T I N E =======================================


Init_SpriteTable_2Player:
		lea	-$280(a0),a0
		move.l	#$EB0301,(a0)+
		move.l	#1,(a0)+
		move.l	#$EB0302,(a0)+
		move.l	#0,(a0)
		rts
; End of function Init_SpriteTable_2Player


; =============== S U B R O U T I N E =======================================


Process_Sprites:
		tst.b	(Teleport_active_flag).w
		bne.s	locret_1AB0C
		lea	(Object_RAM).w,a0
		tst.w	(Competition_mode).w
		bne.s	loc_1AAFA
		cmpi.b	#$C,(Player_1+routine).w
		beq.s	loc_1AAFA
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	loc_1AB0E

loc_1AAFA:
		moveq	#(Object_RAM_end-Object_RAM)/object_size-1,d7
; End of function Process_Sprites


; =============== S U B R O U T I N E =======================================


sub_1AAFC:
		move.l	(a0),d0
		beq.s	loc_1AB04
		movea.l	d0,a1
		jsr	(a1)

loc_1AB04:
		lea	next_object(a0),a0
		dbf	d7,sub_1AAFC

locret_1AB0C:
		rts
; End of function sub_1AAFC

; ---------------------------------------------------------------------------

loc_1AB0E:	; this is broken?
		moveq	#((Dynamic_object_RAM+object_size)-Object_RAM)/object_size-1,d7
		bsr.s	sub_1AAFC
		moveq	#((Level_object_RAM+object_size)-(Dynamic_object_RAM+object_size))/object_size-1,d7
		bsr.s	sub_1AB1A
		moveq	#(Object_RAM_end-(Level_object_RAM+object_size))/object_size-1,d7
		bra.s	sub_1AAFC

; =============== S U B R O U T I N E =======================================


sub_1AB1A:
		move.l	(a0),d0
		beq.s	loc_1AB28
		tst.b	render_flags(a0)
		bpl.s	loc_1AB28
		jsr	Draw_Sprite(pc)

loc_1AB28:
		lea	next_object(a0),a0
		dbf	d7,sub_1AB1A
		rts
; End of function sub_1AB1A

; ---------------------------------------------------------------------------
; Subroutine to make an object move and fall downward increasingly fast
; This moves the object horizontally and vertically
; and also applies gravity to its speed
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================

MoveSprite:
		move.w	x_vel(a0),d0	; load x speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)	; add x speed to x position	; note this affects the subpixel position x_sub(a0) = 2+x_pos(a0)
		move.w	y_vel(a0),d0	; load y speed
		addi.w	#$38,y_vel(a0)	; increase vertical speed (apply gravity)
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)	; add old y speed to y position	; note this affects the subpixel position y_sub(a0) = 2+y_pos(a0)
		rts
; End of function MoveSprite

; ---------------------------------------------------------------------------
; Subroutine translating object speed to update object position
; This moves the object horizontally and vertically
; but does not apply gravity to it
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================

MoveSprite2:
		move.w	x_vel(a0),d0	; load horizontal speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)	; add to x-axis position	; note this affects the subpixel position x_sub(a0) = 2+x_pos(a0)
		move.w	y_vel(a0),d0	; load vertical speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)	; add to y-axis position	; note this affects the subpixel position y_sub(a0) = 2+y_pos(a0)
		rts
; End of function MoveSprite2


; =============== S U B R O U T I N E =======================================

MoveSprite_TestGravity:
		tst.b	(Reverse_gravity_flag).w
		beq.s	MoveSprite

		move.w	x_vel(a0),d0	; load x speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)	; add x speed to x position	; note this affects the subpixel position x_sub(a0) = 2+x_pos(a0)
		move.w	y_vel(a0),d0	; load y speed
		addi.w	#$38,y_vel(a0)	; increase vertical speed (apply gravity)
		neg.w	d0		; reverse it
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)	; add old y speed to y position	; note this affects the subpixel position y_sub(a0) = 2+y_pos(a0)
		rts
; End of function MoveSprite_TestGravity


; =============== S U B R O U T I N E =======================================

MoveSprite_TestGravity2:
		tst.b	(Reverse_gravity_flag).w
		beq.s	MoveSprite2

		move.w	x_vel(a0),d0	; load horizontal speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)	; add to x-axis position	; note this affects the subpixel position x_sub(a0) = 2+x_pos(a0)
		move.w	y_vel(a0),d0	; load vertical speed
		neg.w	d0		; reverse it
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)	; add to y-axis position	; note this affects the subpixel position y_sub(a0) = 2+y_pos(a0)
		rts
; End of function MoveSprite_TestGravity2


; =============== S U B R O U T I N E =======================================


Delete_Current_Sprite:
		movea.l	a0,a1
; End of function Delete_Current_Sprite


; =============== S U B R O U T I N E =======================================


Delete_Referenced_Sprite:
		moveq	#bytesToLcnt(object_size-2),d0
		moveq	#0,d1

.loop:
		move.l	d1,(a1)+
		dbf	d0,.loop
		move.w	d1,(a1)+
		rts
; End of function Delete_Referenced_Sprite


; =============== S U B R O U T I N E =======================================


Draw_Sprite:
		lea	(Sprite_table_input).w,a1
		adda.w	priority(a0),a1

loc_1ABCE:
		cmpi.w	#$7E,(a1)
		bhs.s	loc_1ABDC
		addq.w	#2,(a1)
		adda.w	(a1),a1
		move.w	a0,(a1)

locret_1ABDA:
		rts
; ---------------------------------------------------------------------------

loc_1ABDC:
		cmpa.w	#Sprite_table_input+($80*7),a1
		beq.s	locret_1ABDA
		adda.w	#$80,a1
		bra.s	loc_1ABCE
; End of function Draw_Sprite


; =============== S U B R O U T I N E =======================================


Animate_Sprite:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	loc_1AC00
		move.b	d0,prev_anim(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)

loc_1AC00:
		subq.b	#1,anim_frame_timer(a0)
		bcc.s	locret_1AC36
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),anim_frame_timer(a0)
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		bmi.s	loc_1AC38

loc_1AC1C:
		move.b	d0,mapping_frame(a0)
		move.b	status(a0),d1
		andi.b	#3,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		addq.b	#1,anim_frame(a0)

locret_1AC36:
		rts
; ---------------------------------------------------------------------------

loc_1AC38:
		addq.b	#1,d0			; Code FF - Repeat animation from beginning
		bne.s	loc_1AC48
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	loc_1AC1C
; ---------------------------------------------------------------------------

loc_1AC48:
		addq.b	#1,d0			; Code FE - Repeat animation from earlier point
		bne.s	loc_1AC5C
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_1AC1C
; ---------------------------------------------------------------------------

loc_1AC5C:
		addq.b	#1,d0			; Code FD - Start new animation
		bne.s	loc_1AC68
		move.b	2(a1,d1.w),anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_1AC68:
		addq.b	#1,d0			; Code FC - Increment routine counter
		bne.s	loc_1AC7A
		addq.b	#2,routine(a0)
		clr.b	anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_1AC7A:
		addq.b	#1,d0			; Code FB - Move offscreen
		bne.s	locret_1AC86
		move.w	#$7F00,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

locret_1AC86:
		rts
; End of function Animate_Sprite


; =============== S U B R O U T I N E =======================================


Animate_SpriteIrregularDelay:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	loc_1ACA0
		move.b	d0,prev_anim(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)

loc_1ACA0:
		subq.b	#1,anim_frame_timer(a0)
		bcc.s	locret_1ACDA
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		add.w	d1,d1
		move.b	(a1,d1.w),d0
		bmi.s	loc_1ACDC

loc_1ACBA:
		move.b	1(a1,d1.w),anim_frame_timer(a0)
		move.b	d0,mapping_frame(a0)
		move.b	status(a0),d1
		andi.b	#3,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		addq.b	#1,anim_frame(a0)

locret_1ACDA:
		rts
; ---------------------------------------------------------------------------

loc_1ACDC:
		addq.b	#1,d0
		bne.s	loc_1ACEA
		; Bug: S3 did not clear d1, making loc_1ACBA run a frame short with each loop.
		; This was fixed, but apart from the Blue Spheres title, the only other effect
		; is that the wink animation on the S3 title now runs a frame too long.
		moveq	#0,d1
		move.b	d1,anim_frame(a0)
		move.b	(a1),d0
		bra.s	loc_1ACBA
; ---------------------------------------------------------------------------

loc_1ACEA:
		addq.b	#1,d0
		bne.s	loc_1AD00
		move.b	1(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		add.w	d0,d0
		sub.b	d0,d1
		move.b	(a1,d1.w),d0
		bra.s	loc_1ACBA
; ---------------------------------------------------------------------------

loc_1AD00:
		addq.b	#1,d0
		bne.s	loc_1AD0C
		move.b	1(a1,d1.w),anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_1AD0C:
		addq.b	#1,d0
		bne.s	locret_1AD1E
		addq.b	#2,routine(a0)
		clr.b	anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
		rts
; ---------------------------------------------------------------------------

locret_1AD1E:
		rts
; End of function Animate_SpriteIrregularDelay


; =============== S U B R O U T I N E =======================================


Render_Sprites:
		tst.w	(Competition_mode).w
		bne.w	Render_Sprites_CompetitionMode
		moveq	#$50-1,d7
		moveq	#0,d6
		lea	(Sprite_table_input).w,a5
		lea	(Camera_X_pos_copy).w,a3
		lea	(Sprite_table).w,a6
		tst.b	(Level_started_flag).w
		beq.s	loc_1AD4A
		jsr	(Render_HUD).l
		jsr	(Render_Rings).l

loc_1AD4A:
		tst.w	(a5)
		beq.w	Render_Sprites_NextLevel
		lea	2(a5),a4

loc_1AD54:
		movea.w	(a4)+,a0	; a0=object
		andi.b	#$7F,render_flags(a0)	; clear on-screen flag
		move.b	render_flags(a0),d6
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		btst	#6,d6		; is the multi-draw flag set?
		bne.w	loc_1AE58	; if it is, branch
		btst	#2,d6		; is this to be positioned by screen coordinates?
		beq.s	loc_1ADB2	; if it is, branch
		moveq	#0,d2
		move.b	width_pixels(a0),d2
		sub.w	(a3),d0
		move.w	d0,d3
		add.w	d2,d3		; is the object right edge to the left of the screen?
		bmi.s	Render_Sprites_NextObj	; if it is, branch
		move.w	d0,d3
		sub.w	d2,d3
		cmpi.w	#320,d3		; is the object left edge to the right of the screen?
		bge.s	Render_Sprites_NextObj	; if it is, branch
		addi.w	#128,d0
		sub.w	4(a3),d1
		move.b	height_pixels(a0),d2
		add.w	d2,d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#224,d2
		cmp.w	d2,d1
		bhs.s	Render_Sprites_NextObj	; if the object is below the screen
		addi.w	#128,d1
		sub.w	d3,d1

loc_1ADB2:
		ori.b	#$80,render_flags(a0)	; set on-screen flag
		tst.w	d7
		bmi.s	Render_Sprites_NextObj
		movea.l	mappings(a0),a1
		moveq	#0,d4
		btst	#5,d6		; is the static mappings flag set?
		bne.s	loc_1ADD8	; if it is, branch
		move.b	mapping_frame(a0),d4
		add.w	d4,d4
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4		; get number of pieces
		bmi.s	Render_Sprites_NextObj	; if there are 0 pieces, branch

loc_1ADD8:
		move.w	art_tile(a0),d5
		jsr	sub_1AF6C(pc)

Render_Sprites_NextObj:
		subq.w	#2,(a5)		; decrement object count
		bne.w	loc_1AD54	; if there are objects left, repeat

Render_Sprites_NextLevel:
		cmpa.l	#Sprite_table_input,a5
		bne.s	loc_1ADFC
		cmpi.b	#9,(Current_zone).w	; LRZ?
		bne.s	loc_1ADFC
		jsr	(sub_1CB68).l

loc_1ADFC:
		lea	$80(a5),a5	; load next priority level
		cmpa.l	#Player_1,a5
		blo.w	loc_1AD4A
		move.w	d7,d6
		bmi.s	loc_1AE18
		moveq	#0,d0

loc_1AE10:
		move.w	d0,(a6)
		addq.w	#8,a6
		dbf	d7,loc_1AE10

loc_1AE18:
		subi.w	#$4F,d6
		neg.w	d6
		move.b	d6,(Sprites_drawn).w
		tst.w	(Spritemask_flag).w
		beq.s	locret_1AE56
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	loc_1AE34
		clr.w	(Spritemask_flag).w

loc_1AE34:
		lea	(Sprite_table-4).w,a0
		move.w	#$7C0,d0
		moveq	#$4F-1,d1

loc_1AE3E:
		addq.w	#8,a0
		cmp.w	(a0),d0
		dbeq	d1,loc_1AE3E
		bne.s	locret_1AE56
		move.w	#1,2(a0)
		clr.w	$A(a0)
		subq.w	#1,d1
		bpl.s	loc_1AE3E

locret_1AE56:
		rts
; ---------------------------------------------------------------------------

loc_1AE58:
		btst	#2,d6		; is this to be positioned by screen coordinates?
		bne.s	loc_1AEA2	; if it is, branch
		moveq	#0,d2

		; check if object is within X bounds
		move.b	width_pixels(a0),d2
		subi.w	#128,d0
		move.w	d0,d3
		add.w	d2,d3
		bmi.w	Render_Sprites_NextObj
		move.w	d0,d3
		sub.w	d2,d3
		cmpi.w	#320,d3
		bge.w	Render_Sprites_NextObj
		addi.w	#128,d0

		; check if object is within Y bounds
		move.b	height_pixels(a0),d2
		subi.w	#128,d1
		move.w	d1,d3
		add.w	d2,d3
		bmi.w	Render_Sprites_NextObj
		move.w	d1,d3
		sub.w	d2,d3
		cmpi.w	#224,d3
		bge.w	Render_Sprites_NextObj
		addi.w	#128,d1
		bra.s	loc_1AEE4
; ---------------------------------------------------------------------------

loc_1AEA2:
		moveq	#0,d2
		move.b	width_pixels(a0),d2
		sub.w	(a3),d0
		move.w	d0,d3
		add.w	d2,d3
		bmi.w	Render_Sprites_NextObj
		move.w	d0,d3
		sub.w	d2,d3
		cmpi.w	#320,d3
		bge.w	Render_Sprites_NextObj
		addi.w	#128,d0
		sub.w	4(a3),d1
		move.b	height_pixels(a0),d2
		add.w	d2,d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#224,d2
		cmp.w	d2,d1
		bhs.w	Render_Sprites_NextObj
		addi.w	#128,d1
		sub.w	d3,d1

loc_1AEE4:
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.w	Render_Sprites_NextObj
		move.w	art_tile(a0),d5
		movea.l	mappings(a0),a2
		moveq	#0,d4
		move.b	mapping_frame(a0),d4
		beq.s	loc_1AF1C
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	loc_1AF1C
		move.w	d6,d3
		jsr	sub_1B070(pc)
		move.w	d3,d6
		tst.w	d7
		bmi.w	Render_Sprites_NextObj

loc_1AF1C:
		move.w	mainspr_childsprites(a0),d3
		subq.w	#1,d3
		bcs.w	Render_Sprites_NextObj
		lea	sub2_x_pos(a0),a0

loc_1AF2A:
		move.w	(a0)+,d0
		move.w	(a0)+,d1
		btst	#2,d6
		beq.s	loc_1AF46
		sub.w	(a3),d0
		addi.w	#128,d0
		sub.w	4(a3),d1
		addi.w	#128,d1
		and.w	(Screen_Y_wrap_value).w,d1

loc_1AF46:
		addq.w	#1,a0
		moveq	#0,d4
		move.b	(a0)+,d4
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	loc_1AF62
		move.w	d6,-(sp)
		jsr	sub_1B070(pc)
		move.w	(sp)+,d6

loc_1AF62:
		tst.w	d7
		dbmi	d3,loc_1AF2A
		bra.w	Render_Sprites_NextObj
; End of function Render_Sprites


; =============== S U B R O U T I N E =======================================


sub_1AF6C:
		lsr.b	#1,d6
		bcs.s	loc_1AF9E
		lsr.b	#1,d6
		bcs.w	loc_1B038

loc_1AF76:
		move.b	(a1)+,d2
		ext.w	d2
		add.w	d1,d2
		move.w	d2,(a6)+
		move.b	(a1)+,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		add.w	d0,d2
		andi.w	#$1FF,d2
		bne.s	loc_1AF94
		addq.w	#1,d2

loc_1AF94:
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,loc_1AF76
		rts
; ---------------------------------------------------------------------------

loc_1AF9E:
		lsr.b	#1,d6
		bcs.s	loc_1AFE8

loc_1AFA2:
		move.b	(a1)+,d2
		ext.w	d2
		add.w	d1,d2
		move.w	d2,(a6)+
		move.b	(a1)+,d6
		move.b	d6,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$800,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		neg.w	d2
		move.b	byte_1AFD8(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d0,d2
		andi.w	#$1FF,d2
		bne.s	loc_1AFCE
		addq.w	#1,d2

loc_1AFCE:
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,loc_1AFA2
		rts
; ---------------------------------------------------------------------------
byte_1AFD8:
		dc.b    8,   8,   8,   8
		dc.b  $10, $10, $10, $10
		dc.b  $18, $18, $18, $18
		dc.b  $20, $20, $20, $20
		even
; ---------------------------------------------------------------------------

loc_1AFE8:
		move.b	(a1)+,d2
		ext.w	d2
		neg.w	d2
		move.b	(a1),d6
		move.b	byte_1B028(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d1,d2
		move.w	d2,(a6)+
		move.b	(a1)+,d6
		move.b	d6,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$1800,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		neg.w	d2
		move.b	byte_1AFD8(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d0,d2
		andi.w	#$1FF,d2
		bne.s	loc_1B01E
		addq.w	#1,d2

loc_1B01E:
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,loc_1AFE8
		rts
; ---------------------------------------------------------------------------
byte_1B028:
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		even
; ---------------------------------------------------------------------------

loc_1B038:
		move.b	(a1)+,d2
		ext.w	d2
		neg.w	d2
		move.b	(a1)+,d6
		move.b	d6,2(a6)
		move.b	byte_1B028(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d1,d2
		move.w	d2,(a6)+
		addq.w	#2,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$1000,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		add.w	d0,d2
		andi.w	#$1FF,d2
		bne.s	loc_1B066
		addq.w	#1,d2

loc_1B066:
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,loc_1B038
		rts
; End of function sub_1AF6C


; =============== S U B R O U T I N E =======================================


sub_1B070:
		lsr.b	#1,d6
		bcs.s	loc_1B0C2
		lsr.b	#1,d6
		bcs.w	loc_1B19C

loc_1B07A:
		move.b	(a1)+,d2
		ext.w	d2
		add.w	d1,d2
		cmpi.w	#-32+128,d2
		bls.s	loc_1B0BA
		cmpi.w	#224+128,d2
		bhs.s	loc_1B0BA
		move.w	d2,(a6)+
		move.b	(a1)+,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		add.w	d0,d2
		cmpi.w	#-32+128,d2
		bls.s	loc_1B0B2
		cmpi.w	#320+128,d2
		bhs.s	loc_1B0B2
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,loc_1B07A
		rts
; ---------------------------------------------------------------------------

loc_1B0B2:
		subq.w	#6,a6
		dbf	d4,loc_1B07A
		rts
; ---------------------------------------------------------------------------

loc_1B0BA:
		addq.w	#5,a1
		dbf	d4,loc_1B07A
		rts
; ---------------------------------------------------------------------------

loc_1B0C2:
		lsr.b	#1,d6
		bcs.s	loc_1B12C

loc_1B0C6:
		move.b	(a1)+,d2
		ext.w	d2
		add.w	d1,d2
		cmpi.w	#-32+128,d2
		bls.s	loc_1B114
		cmpi.w	#224+128,d2
		bhs.s	loc_1B114
		move.w	d2,(a6)+
		move.b	(a1)+,d6
		move.b	d6,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$800,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		neg.w	d2
		move.b	byte_1B11C(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d0,d2
		cmpi.w	#-32+128,d2
		bls.s	loc_1B10C
		cmpi.w	#320+128,d2
		bhs.s	loc_1B10C
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,loc_1B0C6
		rts
; ---------------------------------------------------------------------------

loc_1B10C:
		subq.w	#6,a6
		dbf	d4,loc_1B0C6
		rts
; ---------------------------------------------------------------------------

loc_1B114:
		addq.w	#5,a1
		dbf	d4,loc_1B0C6
		rts
; ---------------------------------------------------------------------------
byte_1B11C:
		dc.b    8,   8,   8,   8
		dc.b  $10, $10, $10, $10
		dc.b  $18, $18, $18, $18
		dc.b  $20, $20, $20, $20
		even
; ---------------------------------------------------------------------------

loc_1B12C:
		move.b	(a1)+,d2
		ext.w	d2
		neg.w	d2
		move.b	(a1),d6
		move.b	byte_1B18C(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d1,d2
		cmpi.w	#-32+128,d2
		bls.s	loc_1B184
		cmpi.w	#224+128,d2
		bhs.s	loc_1B184
		move.w	d2,(a6)+
		move.b	(a1)+,d6
		move.b	d6,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$1800,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		neg.w	d2
		move.b	byte_1B11C(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d0,d2
		cmpi.w	#-32+128,d2
		bls.s	loc_1B17C
		cmpi.w	#320+128,d2
		bhs.s	loc_1B17C
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,loc_1B12C
		rts
; ---------------------------------------------------------------------------

loc_1B17C:
		subq.w	#6,a6
		dbf	d4,loc_1B12C
		rts
; ---------------------------------------------------------------------------

loc_1B184:
		addq.w	#5,a1
		dbf	d4,loc_1B12C
		rts
; ---------------------------------------------------------------------------
byte_1B18C:
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		even
; ---------------------------------------------------------------------------

loc_1B19C:
		move.b	(a1)+,d2
		ext.w	d2
		neg.w	d2
		move.b	(a1)+,d6
		move.b	d6,2(a6)
		move.b	byte_1B18C(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d1,d2
		cmpi.w	#-32+128,d2
		bls.s	loc_1B1EC
		cmpi.w	#224+128,d2
		bhs.s	loc_1B1EC
		move.w	d2,(a6)+
		addq.w	#2,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$1000,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		add.w	d0,d2
		cmpi.w	#-32+128,d2
		bls.s	loc_1B1E4
		cmpi.w	#320+128,d2
		bhs.s	loc_1B1E4
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,loc_1B19C
		rts
; ---------------------------------------------------------------------------

loc_1B1E4:
		subq.w	#6,a6
		dbf	d4,loc_1B19C
		rts
; ---------------------------------------------------------------------------

loc_1B1EC:
		addq.w	#4,a1
		dbf	d4,loc_1B19C
		rts
; End of function sub_1B070

; ---------------------------------------------------------------------------

Render_Sprites_CompetitionMode:
		moveq	#($50-2)-1,d7
		moveq	#0,d6
		lea	(Sprite_table_input).w,a5
		lea	(Camera_X_pos_copy).w,a3
		; Unlike in Sonic 2, the sprite tables are page-flipped in two-player mode.
		; This fixes a race-condition where incomplete sprite tables can be uploaded
		; to the VDP on lag frames, causing corrupted sprites to appear.

		; Modify the back buffer.
		lea	(Sprite_table+$10).w,a6
		tst.w	(Current_sprite_table_page).w
		beq.s	loc_1B210
		lea	(Sprite_table_alternate+$10).l,a6

loc_1B210:
		tst.b	(Level_started_flag).w
		beq.s	loc_1B21C
		jsr	(Render_HUD_P1).l

loc_1B21C:
		move.b	1(a5),(a5)
		beq.w	loc_1B2C8
		lea	2(a5),a4

loc_1B228:
		movea.w	(a4)+,a0
		andi.b	#$7F,render_flags(a0)
		move.b	render_flags(a0),d6
		btst	#4,d6
		bne.w	loc_1B2C2
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		btst	#6,d6
		bne.w	loc_1B3EC
		btst	#2,d6
		beq.s	loc_1B294
		moveq	#0,d2
		sub.w	(a3),d0
		move.b	width_pixels(a0),d2
		add.w	d2,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#320,d2
		cmp.w	d2,d0
		bhs.s	loc_1B2C2
		addi.w	#128,d0
		sub.w	d3,d0
		moveq	#0,d2
		sub.w	4(a3),d1
		move.b	height_pixels(a0),d2
		add.w	d2,d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#224/2,d2
		cmp.w	d2,d1
		bhs.s	loc_1B2C2
		addi.w	#128,d1
		sub.w	d3,d1

loc_1B294:
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.s	loc_1B2C2
		movea.l	mappings(a0),a1
		moveq	#0,d4
		btst	#5,d6
		bne.s	loc_1B2BA
		move.b	mapping_frame(a0),d4
		add.w	d4,d4
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	loc_1B2C2

loc_1B2BA:
		move.w	art_tile(a0),d5
		jsr	sub_1AF6C(pc)

loc_1B2C2:
		subq.b	#2,(a5)
		bne.w	loc_1B228

loc_1B2C8:
		lea	$80(a5),a5
		cmpa.l	#Player_1,a5
		blo.w	loc_1B21C
		tst.w	d7
		bmi.s	loc_1B2E4
		moveq	#0,d0

loc_1B2DC:
		move.w	d0,(a6)
		addq.w	#8,a6
		dbf	d7,loc_1B2DC

loc_1B2E4:
		move.l	(Sprite_table_input+2+($80*2)).w,d0
		cmpi.l	#((Player_1&$FFFF)<<16)|(Player_2&$FFFF),d0
		bne.s	loc_1B2F6
		swap	d0
		move.l	d0,(Sprite_table_input+2+($80*2)).w

loc_1B2F6:
		moveq	#$50-1,d7
		lea	(Sprite_table_input).w,a5
		lea	(Camera_X_pos_P2_copy).w,a3
		; Unlike in Sonic 2, the sprite tables are page-flipped in two-player mode.
		; This fixes a race-condition where incomplete sprite tables can be uploaded
		; to the VDP on lag frames, causing corrupted sprites to appear.

		; Modify the back buffer.
		lea	(Sprite_table_P2).l,a6
		tst.w	(Current_sprite_table_page).w
		beq.s	loc_1B312
		lea	(Sprite_table_P2_alternate).l,a6

loc_1B312:
		tst.b	(Level_started_flag).w
		beq.s	loc_1B31E
		jsr	(Render_HUD_P2).l

loc_1B31E:
		tst.b	1(a5)
		beq.w	loc_1B3CA
		lea	2(a5),a4

loc_1B32A:
		movea.w	(a4)+,a0
		move.b	render_flags(a0),d6
		btst	#3,d6
		bne.w	loc_1B3C2
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		btst	#6,d6
		bne.w	loc_1B4B8
		btst	#2,d6
		beq.s	loc_1B390
		moveq	#0,d2
		sub.w	(a3),d0
		move.b	width_pixels(a0),d2
		add.w	d2,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#320,d2
		cmp.w	d2,d0
		bhs.s	loc_1B3C2
		addi.w	#128,d0
		sub.w	d3,d0
		moveq	#0,d2
		sub.w	4(a3),d1
		move.b	height_pixels(a0),d2
		add.w	d2,d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#224/2,d2
		cmp.w	d2,d1
		bhs.s	loc_1B3C2
		addi.w	#128,d1
		sub.w	d3,d1

loc_1B390:
		addi.w	#224/2,d1
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.s	loc_1B3C2
		movea.l	mappings(a0),a1
		moveq	#0,d4
		btst	#5,d6
		bne.s	loc_1B3BA
		move.b	mapping_frame(a0),d4
		add.w	d4,d4
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	loc_1B3C2

loc_1B3BA:
		move.w	art_tile(a0),d5
		jsr	sub_1AF6C(pc)

loc_1B3C2:
		subq.b	#2,1(a5)
		bne.w	loc_1B32A

loc_1B3CA:
		lea	$80(a5),a5
		cmpa.l	#Player_1,a5
		blo.w	loc_1B31E
		tst.w	d7
		bmi.s	loc_1B3E6
		moveq	#0,d0

loc_1B3DE:
		move.w	d0,(a6)
		addq.w	#8,a6
		dbf	d7,loc_1B3DE

loc_1B3E6:
		; The new sprite tables are complete: signal a page flip to
		; allow them to be uploaded to the VDP!
		st.b	(Sprite_table_page_flip_pending).w
		rts
; ---------------------------------------------------------------------------

loc_1B3EC:
		moveq	#0,d2
		sub.w	(a3),d0
		move.b	width_pixels(a0),d2
		add.w	d2,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#320,d2
		cmp.w	d2,d0
		bhs.w	loc_1B2C2
		addi.w	#128,d0
		sub.w	d3,d0
		moveq	#0,d2
		sub.w	4(a3),d1
		move.b	height_pixels(a0),d2
		add.w	d2,d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#224/2,d2
		cmp.w	d2,d1
		bhs.w	loc_1B2C2
		addi.w	#128,d1
		sub.w	d3,d1
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.w	loc_1B2C2
		move.w	art_tile(a0),d5
		movea.l	mappings(a0),a2
		moveq	#0,d4
		move.b	mapping_frame(a0),d4
		beq.s	loc_1B46A
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	loc_1B46A
		move.w	d6,d3
		jsr	sub_1B070(pc)
		move.w	d3,d6
		tst.w	d7
		bmi.w	loc_1B2C2

loc_1B46A:
		move.w	mainspr_childsprites(a0),d3
		subq.w	#1,d3
		bcs.w	loc_1B2C2
		lea	sub2_x_pos(a0),a0

loc_1B478:
		move.w	(a0)+,d0
		sub.w	(a3),d0
		addi.w	#128,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	(a0)+,d1
		sub.w	4(a3),d1
		addi.w	#128,d1
		and.w	(Screen_Y_wrap_value).w,d1
		addq.w	#1,a0
		moveq	#0,d4
		move.b	(a0)+,d4
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	loc_1B4AE
		move.w	d6,-(sp)
		jsr	sub_1B070(pc)
		move.w	(sp)+,d6

loc_1B4AE:
		tst.w	d7
		dbmi	d3,loc_1B478
		bra.w	loc_1B2C2
; ---------------------------------------------------------------------------

loc_1B4B8:
		moveq	#0,d2
		sub.w	(a3),d0
		move.b	width_pixels(a0),d2
		add.w	d2,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#320,d2
		cmp.w	d2,d0
		bhs.w	loc_1B3C2
		addi.w	#128,d0
		sub.w	d3,d0
		moveq	#0,d2
		sub.w	4(a3),d1
		move.b	height_pixels(a0),d2
		add.w	d2,d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#224/2,d2
		cmp.w	d2,d1
		bhs.w	loc_1B3C2
		addi.w	#240,d1
		sub.w	d3,d1
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.w	loc_1B3C2
		move.w	art_tile(a0),d5
		movea.l	mappings(a0),a2
		moveq	#0,d4
		move.b	mapping_frame(a0),d4
		beq.s	loc_1B536
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	loc_1B536
		move.w	d6,d3
		jsr	sub_1B070(pc)
		move.w	d3,d6
		tst.w	d7
		bmi.w	loc_1B3C2

loc_1B536:
		move.w	mainspr_childsprites(a0),d3
		subq.w	#1,d3
		bcs.w	loc_1B3C2
		lea	sub2_x_pos(a0),a0

loc_1B544:
		move.w	(a0)+,d0
		sub.w	(a3),d0
		addi.w	#128,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	(a0)+,d1
		sub.w	4(a3),d1
		addi.w	#128,d1
		and.w	(Screen_Y_wrap_value).w,d1
		addi.w	#224/2,d1
		addq.w	#1,a0
		moveq	#0,d4
		move.b	(a0)+,d4
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	loc_1B57E
		move.w	d6,-(sp)
		jsr	sub_1B070(pc)
		move.w	(sp)+,d6

loc_1B57E:
		tst.w	d7
		dbmi	d3,loc_1B544
		bra.w	loc_1B3C2
; ---------------------------------------------------------------------------

Sprite_OnScreen_Test:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_1B5A0
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

loc_1B5A0:
		move.w	respawn_addr(a0),d0
		beq.s	loc_1B5AC
		movea.w	d0,a2
		bclr	#7,(a2)

loc_1B5AC:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

Sprite_OnScreen_Test2:
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_1B5C4
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

loc_1B5C4:
		move.w	respawn_addr(a0),d0
		beq.s	loc_1B5D0
		movea.w	d0,a2
		bclr	#7,(a2)

loc_1B5D0:
		bra.w	Delete_Current_Sprite

; =============== S U B R O U T I N E =======================================


Delete_Sprite_If_Not_In_Range:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_1B5EA
		rts
; ---------------------------------------------------------------------------

loc_1B5EA:
		move.w	respawn_addr(a0),d0
		beq.s	loc_1B5F6
		movea.w	d0,a2
		bclr	#7,(a2)

loc_1B5F6:
		bra.w	Delete_Current_Sprite
; End of function Delete_Sprite_If_Not_In_Range

; ---------------------------------------------------------------------------
		tst.w	(Competition_mode).w
		bne.s	loc_1B628
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_1B618
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

loc_1B618:
		move.w	respawn_addr(a0),d0
		beq.s	loc_1B624
		movea.w	d0,a2
		bclr	#7,(a2)

loc_1B624:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

loc_1B628:
		move.w	x_pos(a0),d0
		andi.w	#$FF00,d0
		move.w	d0,d1
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$300,d0
		bhi.w	loc_1B642
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

loc_1B642:
		sub.w	(_unkF7DC).w,d1
		cmpi.w	#$300,d1
		bhi.w	loc_1B652
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

loc_1B652:
		move.w	respawn_addr(a0),d0
		beq.s	loc_1B65E
		movea.w	d0,a2
		bclr	#7,(a2)

loc_1B65E:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouch3:
		move.w	x_pos(a0),d0

loc_1B666:
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_1B680
		jsr	(Add_SpriteToCollisionResponseList).l
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

loc_1B680:
		move.w	respawn_addr(a0),d0
		beq.s	loc_1B68C
		movea.w	d0,a2
		bclr	#7,(a2)

loc_1B68C:
		bra.w	Delete_Current_Sprite
