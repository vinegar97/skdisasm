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
		beq.s	+ ;loc_19162
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

+ ;loc_19162:
		lea	(Sprite_table).w,a0
; End of function Init_SpriteTable


; =============== S U B R O U T I N E =======================================


Init_SpriteTable2:
		moveq	#0,d0
		moveq	#1,d1
		moveq	#$50-1,d7

- ;.loop:
		move.w	d0,(a0)
		move.b	d1,3(a0)
		addq.w	#1,d1
		addq.w	#8,a0
		dbf	d7,- ;.loop
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
		bne.s	locret_191D0
		lea	(Object_RAM).w,a0
		tst.w	(Competition_mode).w
		bne.s	+ ;loc_191BE
		cmpi.b	#$C,(Player_1+routine).w
		beq.s	+ ;loc_191BE
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	+++ ;loc_191D2

+ ;loc_191BE:
		moveq	#(Object_RAM_end-Object_RAM)/object_size-1,d7
; End of function Process_Sprites


; =============== S U B R O U T I N E =======================================


sub_191C0:
		move.l	(a0),d0
		beq.s	+ ;loc_191C8
		movea.l	d0,a1
		jsr	(a1)

+ ;loc_191C8:
		lea	next_object(a0),a0
		dbf	d7,sub_191C0

locret_191D0:
		rts
; End of function sub_191C0

; ---------------------------------------------------------------------------

+ ;loc_191D2:	; this is broken?
		moveq	#((Dynamic_object_RAM+object_size)-Object_RAM)/object_size-1,d7
		bsr.s	sub_191C0
		moveq	#((Level_object_RAM+object_size)-(Dynamic_object_RAM+object_size))/object_size-1,d7
		bsr.s	sub_191DE
		moveq	#(Object_RAM_end-(Level_object_RAM+object_size))/object_size-1,d7
		bra.s	sub_191C0

; =============== S U B R O U T I N E =======================================


sub_191DE:
		move.l	(a0),d0
		beq.s	+ ;loc_191EC
		tst.b	render_flags(a0)
		bpl.s	+ ;loc_191EC
		jsr	Draw_Sprite(pc)

+ ;loc_191EC:
		lea	next_object(a0),a0
		dbf	d7,sub_191DE
		rts
; End of function sub_191DE

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


Delete_Current_Sprite:
		movea.l	a0,a1
; End of function Delete_Current_Sprite


; =============== S U B R O U T I N E =======================================


Delete_Referenced_Sprite:
		moveq	#bytesToLcnt(object_size-2),d0
		moveq	#0,d1

- ;.loop:
		move.l	d1,(a1)+
		dbf	d0,- ;.loop
		move.w	d1,(a1)+
		rts
; End of function Delete_Referenced_Sprite


; =============== S U B R O U T I N E =======================================


Draw_Sprite:
		lea	(Sprite_table_input).w,a1
		adda.w	priority(a0),a1
		cmpi.w	#$7E,(a1)
		bcc.s	locret_19254
		addq.w	#2,(a1)
		adda.w	(a1),a1
		move.w	a0,(a1)

locret_19254:
		rts
; End of function Draw_Sprite


; =============== S U B R O U T I N E =======================================


Animate_Sprite:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	+ ;loc_1926E
		move.b	d0,prev_anim(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)

+ ;loc_1926E:
		subq.b	#1,anim_frame_timer(a0)
		bcc.s	locret_192A4
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),anim_frame_timer(a0)
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		bmi.s	+ ;loc_192A6

loc_1928A:
		move.b	d0,mapping_frame(a0)
		move.b	status(a0),d1
		andi.b	#3,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		addq.b	#1,anim_frame(a0)

locret_192A4:
		rts
; ---------------------------------------------------------------------------

+ ;loc_192A6:
		addq.b	#1,d0			; Code FF - Repeat animation from beginning
		bne.s	+ ;loc_192B6
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	loc_1928A
; ---------------------------------------------------------------------------

+ ;loc_192B6:
		addq.b	#1,d0			; Code FE - Repeat animation from earlier point
		bne.s	+ ;loc_192CA
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_1928A
; ---------------------------------------------------------------------------

+ ;loc_192CA:
		addq.b	#1,d0			; Code FD - Start new animation
		bne.s	+ ;loc_192D6
		move.b	2(a1,d1.w),anim(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_192D6:
		addq.b	#1,d0			; Code FC - Increment routine counter
		bne.s	+ ;loc_192E8
		addq.b	#2,routine(a0)
		clr.b	anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_192E8:
		addq.b	#1,d0			; Code FB - Move offscreen
		bne.s	locret_192F4
		move.w	#$7F00,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

locret_192F4:
		rts
; End of function Animate_Sprite


; =============== S U B R O U T I N E =======================================


Animate_SpriteIrregularDelay:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	+ ;loc_1930E
		move.b	d0,prev_anim(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)

+ ;loc_1930E:
		subq.b	#1,anim_frame_timer(a0)
		bcc.s	locret_19348
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		add.w	d1,d1
		move.b	(a1,d1.w),d0
		bmi.s	+ ;loc_1934A

loc_19328:
		move.b	1(a1,d1.w),anim_frame_timer(a0)
		move.b	d0,mapping_frame(a0)
		move.b	status(a0),d1
		andi.b	#3,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		addq.b	#1,anim_frame(a0)

locret_19348:
		rts
; ---------------------------------------------------------------------------

+ ;loc_1934A:
		addq.b	#1,d0
		bne.s	+ ;loc_19358
		move.b	#0,anim_frame(a0)
		move.b	(a1),d0
		bra.s	loc_19328
; ---------------------------------------------------------------------------

+ ;loc_19358:
		addq.b	#1,d0
		bne.s	+ ;loc_1936E
		move.b	1(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		add.w	d0,d0
		sub.b	d0,d1
		move.b	(a1,d1.w),d0
		bra.s	loc_19328
; ---------------------------------------------------------------------------

+ ;loc_1936E:
		addq.b	#1,d0
		bne.s	+ ;loc_1937A
		move.b	1(a1,d1.w),anim(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_1937A:
		addq.b	#1,d0
		bne.s	locret_1938C
		addq.b	#2,routine(a0)
		clr.b	anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
		rts
; ---------------------------------------------------------------------------

locret_1938C:
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
		beq.s	loc_193B8
		jsr	(Render_HUD).l
		jsr	(Render_Rings).l

loc_193B8:
		tst.w	(a5)
		beq.w	Render_Sprites_NextLevel
		lea	2(a5),a4

loc_193C2:
		movea.w	(a4)+,a0	; a0=object
		andi.b	#$7F,render_flags(a0)	; clear on-screen flag
		move.b	render_flags(a0),d6
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		btst	#6,d6		; is the multi-draw flag set?
		bne.w	loc_194BA	; if it is, branch
		btst	#2,d6		; is this to be positioned by screen coordinates?
		beq.s	+ ;loc_19420	; if it is, branch
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

+ ;loc_19420:
		ori.b	#$80,render_flags(a0)	; set on-screen flag
		tst.w	d7
		bmi.s	Render_Sprites_NextObj
		movea.l	mappings(a0),a1
		moveq	#0,d4
		btst	#5,d6		; is the static mappings flag set?
		bne.s	+ ;loc_19446	; if it is, branch
		move.b	mapping_frame(a0),d4
		add.w	d4,d4
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4		; get number of pieces
		bmi.s	Render_Sprites_NextObj	; if there are 0 pieces, branch

+ ;loc_19446:
		move.w	art_tile(a0),d5
		jsr	sub_195CE(pc)

Render_Sprites_NextObj:
		subq.w	#2,(a5)		; decrement object count
		bne.w	loc_193C2	; if there are objects left, repeat

Render_Sprites_NextLevel:
		cmpa.l	#Sprite_table_input,a5
		bne.s	+ ;loc_1946A
		cmpi.w	#$900,(Current_zone_and_act).w	; LRZ Act 1?
		bne.s	+ ;loc_1946A
		jsr	(sub_1AF14).l

+ ;loc_1946A:
		lea	$80(a5),a5	; load next priority level
		cmpa.l	#Player_1,a5
		blo.w	loc_193B8
		move.w	d7,d6
		bmi.s	+ ;loc_19486
		moveq	#0,d0

- ;loc_1947E:
		move.w	d0,(a6)
		addq.w	#8,a6
		dbf	d7,- ;loc_1947E

+ ;loc_19486:
		subi.w	#$4F,d6
		neg.w	d6
		move.b	d6,(Sprites_drawn).w
		tst.w	(Spritemask_flag).w
		beq.s	locret_194B8
		clr.w	(Spritemask_flag).w
		lea	(Sprite_table-4).w,a0
		move.w	#$7C0,d0
		moveq	#$50-1,d1

- ;loc_194A4:
		addq.w	#8,a0
		cmp.w	(a0),d0
		dbeq	d1,- ;loc_194A4
		bne.s	locret_194B8
		move.w	#1,2(a0)
		clr.w	$A(a0)

locret_194B8:
		rts
; ---------------------------------------------------------------------------

loc_194BA:
		btst	#2,d6		; is this to be positioned by screen coordinates?
		bne.s	+ ;loc_19504	; if it is, branch
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
		bra.s	++ ;loc_19546
; ---------------------------------------------------------------------------

+ ;loc_19504:
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

+ ;loc_19546:
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.w	Render_Sprites_NextObj
		move.w	art_tile(a0),d5
		movea.l	mappings(a0),a2
		moveq	#0,d4
		move.b	mapping_frame(a0),d4
		beq.s	+ ;loc_1957E
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	+ ;loc_1957E
		move.w	d6,d3
		jsr	sub_196D2(pc)
		move.w	d3,d6
		tst.w	d7
		bmi.w	Render_Sprites_NextObj

+ ;loc_1957E:
		move.w	mainspr_childsprites(a0),d3
		subq.w	#1,d3
		bcs.w	Render_Sprites_NextObj
		lea	sub2_x_pos(a0),a0

- ;loc_1958C:
		move.w	(a0)+,d0
		move.w	(a0)+,d1
		btst	#2,d6
		beq.s	+ ;loc_195A8
		sub.w	(a3),d0
		addi.w	#128,d0
		sub.w	4(a3),d1
		addi.w	#128,d1
		and.w	(Screen_Y_wrap_value).w,d1

+ ;loc_195A8:
		addq.w	#1,a0
		moveq	#0,d4
		move.b	(a0)+,d4
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	+ ;loc_195C4
		move.w	d6,-(sp)
		jsr	sub_196D2(pc)
		move.w	(sp)+,d6

+ ;loc_195C4:
		tst.w	d7
		dbmi	d3,- ;loc_1958C
		bra.w	Render_Sprites_NextObj
; End of function Render_Sprites


; =============== S U B R O U T I N E =======================================


sub_195CE:
		lsr.b	#1,d6
		bcs.s	++ ;loc_19600
		lsr.b	#1,d6
		bcs.w	loc_1969A

- ;loc_195D8:
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
		bne.s	+ ;loc_195F6
		addq.w	#1,d2

+ ;loc_195F6:
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,- ;loc_195D8
		rts
; ---------------------------------------------------------------------------

+ ;loc_19600:
		lsr.b	#1,d6
		bcs.s	++ ;loc_1964A

- ;loc_19604:
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
		move.b	byte_1963A(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d0,d2
		andi.w	#$1FF,d2
		bne.s	+ ;loc_19630
		addq.w	#1,d2

+ ;loc_19630:
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,- ;loc_19604
		rts
; ---------------------------------------------------------------------------
byte_1963A:
		dc.b    8,   8,   8,   8
		dc.b  $10, $10, $10, $10
		dc.b  $18, $18, $18, $18
		dc.b  $20, $20, $20, $20
		even
; ---------------------------------------------------------------------------

/ ;loc_1964A:
		move.b	(a1)+,d2
		ext.w	d2
		neg.w	d2
		move.b	(a1),d6
		move.b	byte_1968A(pc,d6.w),d6
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
		move.b	byte_1963A(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d0,d2
		andi.w	#$1FF,d2
		bne.s	+ ;loc_19680
		addq.w	#1,d2

+ ;loc_19680:
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,- ;loc_1964A
		rts
; ---------------------------------------------------------------------------
byte_1968A:
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		even
; ---------------------------------------------------------------------------

loc_1969A:
		move.b	(a1)+,d2
		ext.w	d2
		neg.w	d2
		move.b	(a1)+,d6
		move.b	d6,2(a6)
		move.b	byte_1968A(pc,d6.w),d6
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
		bne.s	+ ;loc_196C8
		addq.w	#1,d2

+ ;loc_196C8:
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,loc_1969A
		rts
; End of function sub_195CE


; =============== S U B R O U T I N E =======================================


sub_196D2:
		lsr.b	#1,d6
		bcs.s	+++ ;loc_19724
		lsr.b	#1,d6
		bcs.w	loc_197FE

- ;loc_196DC:
		move.b	(a1)+,d2
		ext.w	d2
		add.w	d1,d2
		cmpi.w	#-32+128,d2
		bls.s	++ ;loc_1971C
		cmpi.w	#224+128,d2
		bhs.s	++ ;loc_1971C
		move.w	d2,(a6)+
		move.b	(a1)+,(a6)+
		addq.w	#1,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		add.w	d0,d2
		cmpi.w	#-32+128,d2
		bls.s	+ ;loc_19714
		cmpi.w	#320+128,d2
		bhs.s	+ ;loc_19714
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,- ;loc_196DC
		rts
; ---------------------------------------------------------------------------

+ ;loc_19714:
		subq.w	#6,a6
		dbf	d4,- ;loc_196DC
		rts
; ---------------------------------------------------------------------------

+ ;loc_1971C:
		addq.w	#5,a1
		dbf	d4,- ;loc_196DC
		rts
; ---------------------------------------------------------------------------

+ ;loc_19724:
		lsr.b	#1,d6
		bcs.s	+++ ;loc_1978E

- ;loc_19728:
		move.b	(a1)+,d2
		ext.w	d2
		add.w	d1,d2
		cmpi.w	#-32+128,d2
		bls.s	++ ;loc_19776
		cmpi.w	#224+128,d2
		bhs.s	++ ;loc_19776
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
		move.b	byte_1977E(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d0,d2
		cmpi.w	#-32+128,d2
		bls.s	+ ;loc_1976E
		cmpi.w	#320+128,d2
		bhs.s	+ ;loc_1976E
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,- ;loc_19728
		rts
; ---------------------------------------------------------------------------

+ ;loc_1976E:
		subq.w	#6,a6
		dbf	d4,- ;loc_19728
		rts
; ---------------------------------------------------------------------------

+ ;loc_19776:
		addq.w	#5,a1
		dbf	d4,- ;loc_19728
		rts
; ---------------------------------------------------------------------------
byte_1977E:
		dc.b    8,   8,   8,   8
		dc.b  $10, $10, $10, $10
		dc.b  $18, $18, $18, $18
		dc.b  $20, $20, $20, $20
		even
; ---------------------------------------------------------------------------

/ ;loc_1978E:
		move.b	(a1)+,d2
		ext.w	d2
		neg.w	d2
		move.b	(a1),d6
		move.b	byte_197EE(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d1,d2
		cmpi.w	#-32+128,d2
		bls.s	++ ;loc_197E6
		cmpi.w	#224+128,d2
		bhs.s	++ ;loc_197E6
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
		move.b	byte_1977E(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d0,d2
		cmpi.w	#-32+128,d2
		bls.s	+ ;loc_197DE
		cmpi.w	#320+128,d2
		bhs.s	+ ;loc_197DE
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,- ;loc_1978E
		rts
; ---------------------------------------------------------------------------

+ ;loc_197DE:
		subq.w	#6,a6
		dbf	d4,- ;loc_1978E
		rts
; ---------------------------------------------------------------------------

+ ;loc_197E6:
		addq.w	#5,a1
		dbf	d4,- ;loc_1978E
		rts
; ---------------------------------------------------------------------------
byte_197EE:
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		dc.b    8, $10, $18, $20
		even
; ---------------------------------------------------------------------------

loc_197FE:
		move.b	(a1)+,d2
		ext.w	d2
		neg.w	d2
		move.b	(a1)+,d6
		move.b	d6,2(a6)
		move.b	byte_197EE(pc,d6.w),d6
		sub.w	d6,d2
		add.w	d1,d2
		cmpi.w	#-32+128,d2
		bls.s	++ ;loc_1984E
		cmpi.w	#224+128,d2
		bhs.s	++ ;loc_1984E
		move.w	d2,(a6)+
		addq.w	#2,a6
		move.w	(a1)+,d2
		add.w	d5,d2
		eori.w	#$1000,d2
		move.w	d2,(a6)+
		move.w	(a1)+,d2
		add.w	d0,d2
		cmpi.w	#-32+128,d2
		bls.s	+ ;loc_19846
		cmpi.w	#320+128,d2
		bhs.s	+ ;loc_19846
		move.w	d2,(a6)+
		subq.w	#1,d7
		dbmi	d4,loc_197FE
		rts
; ---------------------------------------------------------------------------

+ ;loc_19846:
		subq.w	#6,a6
		dbf	d4,loc_197FE
		rts
; ---------------------------------------------------------------------------

+ ;loc_1984E:
		addq.w	#4,a1
		dbf	d4,loc_197FE
		rts
; End of function sub_196D2

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
		beq.s	+ ;loc_19872
		lea	(Sprite_table_alternate+$10).l,a6

+ ;loc_19872:
		tst.b	(Level_started_flag).w
		beq.s	loc_1987E
		jsr	(Render_HUD_P1).l

loc_1987E:
		move.b	1(a5),(a5)
		beq.w	+++ ;loc_1992A
		lea	2(a5),a4

loc_1988A:
		movea.w	(a4)+,a0
		andi.b	#$7F,render_flags(a0)
		move.b	render_flags(a0),d6
		btst	#4,d6
		bne.w	loc_19924
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		btst	#6,d6
		bne.w	loc_19A4E
		btst	#2,d6
		beq.s	+ ;loc_198F6
		moveq	#0,d2
		sub.w	(a3),d0
		move.b	width_pixels(a0),d2
		add.w	d2,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#320,d2
		cmp.w	d2,d0
		bhs.s	loc_19924
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
		bhs.s	loc_19924
		addi.w	#128,d1
		sub.w	d3,d1

+ ;loc_198F6:
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.s	loc_19924
		movea.l	mappings(a0),a1
		moveq	#0,d4
		btst	#5,d6
		bne.s	+ ;loc_1991C
		move.b	mapping_frame(a0),d4
		add.w	d4,d4
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	loc_19924

+ ;loc_1991C:
		move.w	art_tile(a0),d5
		jsr	sub_195CE(pc)

loc_19924:
		subq.b	#2,(a5)
		bne.w	loc_1988A

+ ;loc_1992A:
		lea	$80(a5),a5
		cmpa.l	#Player_1,a5
		blo.w	loc_1987E
		tst.w	d7
		bmi.s	+ ;loc_19946
		moveq	#0,d0

- ;loc_1993E:
		move.w	d0,(a6)
		addq.w	#8,a6
		dbf	d7,- ;loc_1993E

+ ;loc_19946:
		move.l	(Sprite_table_input+2+($80*2)).w,d0
		cmpi.l	#((Player_1&$FFFF)<<16)|(Player_2&$FFFF),d0
		bne.s	+ ;loc_19958
		swap	d0
		move.l	d0,(Sprite_table_input+2+($80*2)).w

+ ;loc_19958:
		moveq	#$50-1,d7
		lea	(Sprite_table_input).w,a5
		lea	(Camera_X_pos_P2_copy).w,a3
		; Unlike in Sonic 2, the sprite tables are page-flipped in two-player mode.
		; This fixes a race-condition where incomplete sprite tables can be uploaded
		; to the VDP on lag frames, causing corrupted sprites to appear.

		; Modify the back buffer.
		lea	(Sprite_table_P2).l,a6
		tst.w	(Current_sprite_table_page).w
		beq.s	+ ;loc_19974
		lea	(Sprite_table_P2_alternate).l,a6

+ ;loc_19974:
		tst.b	(Level_started_flag).w
		beq.s	loc_19980
		jsr	(Render_HUD_P2).l

loc_19980:
		tst.b	1(a5)
		beq.w	+++ ;loc_19A2C
		lea	2(a5),a4

loc_1998C:
		movea.w	(a4)+,a0
		move.b	render_flags(a0),d6
		btst	#3,d6
		bne.w	loc_19A24
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		btst	#6,d6
		bne.w	loc_19B1A
		btst	#2,d6
		beq.s	+ ;loc_199F2
		moveq	#0,d2
		sub.w	(a3),d0
		move.b	width_pixels(a0),d2
		add.w	d2,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#320,d2
		cmp.w	d2,d0
		bhs.s	loc_19A24
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
		bhs.s	loc_19A24
		addi.w	#128,d1
		sub.w	d3,d1

+ ;loc_199F2:
		addi.w	#224/2,d1
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.s	loc_19A24
		movea.l	mappings(a0),a1
		moveq	#0,d4
		btst	#5,d6
		bne.s	+ ;loc_19A1C
		move.b	mapping_frame(a0),d4
		add.w	d4,d4
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	loc_19A24

+ ;loc_19A1C:
		move.w	art_tile(a0),d5
		jsr	sub_195CE(pc)

loc_19A24:
		subq.b	#2,1(a5)
		bne.w	loc_1998C

+ ;loc_19A2C:
		lea	$80(a5),a5
		cmpa.l	#Player_1,a5
		blo.w	loc_19980
		tst.w	d7
		bmi.s	+ ;loc_19A48
		moveq	#0,d0

- ;loc_19A40:
		move.w	d0,(a6)
		addq.w	#8,a6
		dbf	d7,- ;loc_19A40

+ ;loc_19A48:
		; The new sprite tables are complete: signal a page flip to
		; allow them to be uploaded to the VDP!
		st.b	(Sprite_table_page_flip_pending).w
		rts
; ---------------------------------------------------------------------------

loc_19A4E:
		moveq	#0,d2
		sub.w	(a3),d0
		move.b	width_pixels(a0),d2
		add.w	d2,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#320,d2
		cmp.w	d2,d0
		bhs.w	loc_19924
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
		bhs.w	loc_19924
		addi.w	#128,d1
		sub.w	d3,d1
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.w	loc_19924
		move.w	art_tile(a0),d5
		movea.l	mappings(a0),a2
		moveq	#0,d4
		move.b	mapping_frame(a0),d4
		beq.s	+ ;loc_19ACC
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	+ ;loc_19ACC
		move.w	d6,d3
		jsr	sub_196D2(pc)
		move.w	d3,d6
		tst.w	d7
		bmi.w	loc_19924

+ ;loc_19ACC:
		move.w	mainspr_childsprites(a0),d3
		subq.w	#1,d3
		bcs.w	loc_19924
		lea	sub2_x_pos(a0),a0

- ;loc_19ADA:
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
		bmi.s	+ ;loc_19B10
		move.w	d6,-(sp)
		jsr	sub_196D2(pc)
		move.w	(sp)+,d6

+ ;loc_19B10:
		tst.w	d7
		dbmi	d3,- ;loc_19ADA
		bra.w	loc_19924
; ---------------------------------------------------------------------------

loc_19B1A:
		moveq	#0,d2
		sub.w	(a3),d0
		move.b	width_pixels(a0),d2
		add.w	d2,d0
		and.w	(Screen_X_wrap_value).w,d0
		move.w	d2,d3
		add.w	d2,d2
		addi.w	#320,d2
		cmp.w	d2,d0
		bhs.w	loc_19A24
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
		bhs.w	loc_19A24
		addi.w	#240,d1
		sub.w	d3,d1
		ori.b	#$80,render_flags(a0)
		tst.w	d7
		bmi.w	loc_19A24
		move.w	art_tile(a0),d5
		movea.l	mappings(a0),a2
		moveq	#0,d4
		move.b	mapping_frame(a0),d4
		beq.s	+ ;loc_19B98
		add.w	d4,d4
		lea	(a2),a1
		adda.w	(a1,d4.w),a1
		move.w	(a1)+,d4
		subq.w	#1,d4
		bmi.s	+ ;loc_19B98
		move.w	d6,d3
		jsr	sub_196D2(pc)
		move.w	d3,d6
		tst.w	d7
		bmi.w	loc_19A24

+ ;loc_19B98:
		move.w	mainspr_childsprites(a0),d3
		subq.w	#1,d3
		bcs.w	loc_19A24
		lea	sub2_x_pos(a0),a0

- ;loc_19BA6:
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
		bmi.s	+ ;loc_19BE0
		move.w	d6,-(sp)
		jsr	sub_196D2(pc)
		move.w	(sp)+,d6

+ ;loc_19BE0:
		tst.w	d7
		dbmi	d3,- ;loc_19BA6
		bra.w	loc_19A24
; ---------------------------------------------------------------------------

Sprite_OnScreen_Test:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	+ ;loc_19C02
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

+ ;loc_19C02:
		move.w	respawn_addr(a0),d0
		beq.s	+ ;loc_19C0E
		movea.w	d0,a2
		bclr	#7,(a2)

+ ;loc_19C0E:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

Sprite_OnScreen_Test2:
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	+ ;loc_19C26
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

+ ;loc_19C26:
		move.w	respawn_addr(a0),d0
		beq.s	+ ;loc_19C32
		movea.w	d0,a2
		bclr	#7,(a2)

+ ;loc_19C32:
		bra.w	Delete_Current_Sprite

; =============== S U B R O U T I N E =======================================


Delete_Sprite_If_Not_In_Range:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	+ ;loc_19C4C
		rts
; ---------------------------------------------------------------------------

+ ;loc_19C4C:
		move.w	respawn_addr(a0),d0
		beq.s	+ ;loc_19C58
		movea.w	d0,a2
		bclr	#7,(a2)

+ ;loc_19C58:
		bra.w	Delete_Current_Sprite
; End of function Delete_Sprite_If_Not_In_Range

; ---------------------------------------------------------------------------
		tst.w	(Competition_mode).w
		bne.s	+++ ;loc_19C8A
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	+ ;loc_19C7A
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

+ ;loc_19C7A:
		move.w	respawn_addr(a0),d0
		beq.s	+ ;loc_19C86
		movea.w	d0,a2
		bclr	#7,(a2)

+ ;loc_19C86:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

+ ;loc_19C8A:
		move.w	x_pos(a0),d0
		andi.w	#$FF00,d0
		move.w	d0,d1
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$300,d0
		bhi.w	+ ;loc_19CA4
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

+ ;loc_19CA4:
		sub.w	(_unkF7DC).w,d1
		cmpi.w	#$300,d1
		bhi.w	+ ;loc_19CB4
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

+ ;loc_19CB4:
		move.w	respawn_addr(a0),d0
		beq.s	+ ;loc_19CC0
		movea.w	d0,a2
		bclr	#7,(a2)

+ ;loc_19CC0:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouch3:
		move.w	x_pos(a0),d0

loc_19CC8:
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	+ ;loc_19CE2
		jsr	(Add_SpriteToCollisionResponseList).l
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

+ ;loc_19CE2:
		move.w	respawn_addr(a0),d0
		beq.s	+ ;loc_19CEE
		movea.w	d0,a2
		bclr	#7,(a2)

+ ;loc_19CEE:
		bra.w	Delete_Current_Sprite
