byte_254FA:
		dc.b  $20, $20,   0
		even
		dc.b  $18,  $C,   0
		even
		dc.b  $20, $14,   0
		even
; ---------------------------------------------------------------------------

Obj_FloatingPlatform:
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	+ ;loc_2551C
		move.l	#Map_AIZFloatingPlatform,mappings(a0)
		move.w	#make_art_tile($3F7,2,0),art_tile(a0)

+ ;loc_2551C:
		cmpi.w	#1,(Current_zone_and_act).w
		bne.s	+ ;loc_25532
		move.l	#Map_AIZFloatingPlatform,mappings(a0)
		move.w	#make_art_tile($440,2,0),art_tile(a0)

+ ;loc_25532:
		cmpi.b	#1,(Current_zone).w
		bne.s	+ ;loc_25548
		move.l	#Map_HCZFloatingPlatform,mappings(a0)
		move.w	#make_art_tile($41D,2,0),art_tile(a0)

+ ;loc_25548:
		cmpi.b	#2,(Current_zone).w
		bne.s	+ ;loc_2555E
		move.l	#Map_MGZFloatingPlatform,mappings(a0)
		move.w	#make_art_tile($001,2,0),art_tile(a0)

+ ;loc_2555E:
		move.b	#4,render_flags(a0)
		move.w	#$180,priority(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#2,d0
		andi.w	#$1C,d0
		lea	byte_254FA(pc,d0.w),a2
		move.b	(a2)+,width_pixels(a0)
		move.b	(a2)+,height_pixels(a0)
		move.b	(a2)+,mapping_frame(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	x_pos(a0),$32(a0)
		move.w	y_pos(a0),$34(a0)
		move.b	status(a0),$2E(a0)
		move.w	#$280,$42(a0)
		move.w	x_pos(a0),$44(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		andi.w	#$F,d0
		subq.w	#8,d0
		bcs.s	++ ;loc_255E0
		cmpi.w	#4,d0
		bhs.s	+ ;loc_255D4
		lsl.w	#2,d0
		lea	(Oscillating_table+$2C).w,a2
		lea	(a2,d0.w),a2
		tst.w	(a2)
		bpl.s	++ ;loc_255E0
		bchg	#0,$2E(a0)
		bra.s	++ ;loc_255E0
; ---------------------------------------------------------------------------

+ ;loc_255D4:
		move.w	#$380,$42(a0)
		addi.w	#$100,$44(a0)

+ ;loc_255E0:
		move.b	subtype(a0),d0
		andi.b	#$F,d0
		add.b	d0,d0
		move.b	d0,subtype(a0)
		move.l	#loc_255F4,(a0)

loc_255F4:
		move.w	x_pos(a0),-(sp)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lea	(FloatingPlatformIndex).l,a1
		move.w	(a1,d0.w),d1
		jsr	(a1,d1.w)
		move.w	(sp)+,d4
		tst.b	render_flags(a0)
		bpl.s	+ ;loc_25628
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		moveq	#0,d3
		move.b	height_pixels(a0),d3
		addq.w	#1,d3
		jsr	(SolidObjectTop).l

+ ;loc_25628:
		move.w	$44(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmp.w	$42(a0),d0
		bhi.w	+ ;loc_25642
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_25642:
		move.w	respawn_addr(a0),d0
		beq.s	+ ;loc_2564E
		movea.w	d0,a2
		bclr	#7,(a2)

+ ;loc_2564E:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
Map_MGZFloatingPlatform:
		include "Levels/MGZ/Misc Object Data/Map - Floating Platform.asm"
Map_HCZFloatingPlatform:
		include "Levels/HCZ/Misc Object Data/Map - Floating Platform.asm"
Map_AIZFloatingPlatform:
		include "Levels/AIZ/Misc Object Data/Map - Floating Platform.asm"
; ---------------------------------------------------------------------------

Obj_HCZSnakeBlocks:
		move.l	#Map_HCZFloatingPlatform,mappings(a0)
		move.w	#make_art_tile($028,0,0),art_tile(a0)
		move.b	#4,render_flags(a0)
		move.w	#$180,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#1,mapping_frame(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$34(a0)
		move.b	status(a0),$2E(a0)
		moveq	#1,d0
		move.b	subtype(a0),d1
		bpl.s	+ ;loc_25706
		neg.w	d0

+ ;loc_25706:
		move.b	d0,$40(a0)
		andi.b	#$7F,d1
		move.b	d1,angle(a0)
		move.w	#$280,$42(a0)
		move.w	x_pos(a0),$44(a0)
		move.l	#loc_25724,(a0)

loc_25724:
		bsr.s	sub_25770
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		move.w	$44(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmp.w	$42(a0),d0
		bhi.w	+ ;loc_2575E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2575E:
		move.w	respawn_addr(a0),d0
		beq.s	+ ;loc_2576A
		movea.w	d0,a2
		bclr	#7,(a2)

+ ;loc_2576A:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_25770:
		move.b	$40(a0),d0
		bpl.s	++ ;loc_2579A
		add.b	d0,angle(a0)
		bcs.s	+ ;loc_25786
		subq.b	#1,$2E(a0)
		andi.b	#3,$2E(a0)

+ ;loc_25786:
		move.w	#$40,d2
		move.b	angle(a0),d0
		cmpi.b	#$80,d0
		bhs.s	+++ ;loc_257BC
		move.b	#$80,d0
		bra.s	+++ ;loc_257BC
; ---------------------------------------------------------------------------

+ ;loc_2579A:
		add.b	d0,angle(a0)
		bne.s	+ ;loc_257AA
		addq.b	#1,$2E(a0)
		andi.b	#3,$2E(a0)

+ ;loc_257AA:
		move.w	#$40,d2
		move.b	angle(a0),d0
		cmpi.b	#$80,d0
		bhs.s	+ ;loc_257BC
		move.b	#$80,d0

+ ;loc_257BC:
		jsr	(GetSineCosine).l
		asr.w	#2,d1
		move.b	$2E(a0),d3
		andi.b	#3,d3
		bne.s	+ ;loc_257E2
		add.w	$30(a0),d1
		move.w	d1,x_pos(a0)
		neg.w	d2
		add.w	$34(a0),d2
		move.w	d2,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_257E2:
		subq.b	#1,d3
		bne.s	+ ;loc_257F8
		add.w	$34(a0),d1
		move.w	d1,y_pos(a0)
		add.w	$30(a0),d2
		move.w	d2,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_257F8:
		subq.b	#1,d3
		bne.s	+ ;loc_25810
		neg.w	d1
		add.w	$30(a0),d1
		move.w	d1,x_pos(a0)
		add.w	$34(a0),d2
		move.w	d2,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_25810:
		neg.w	d1
		add.w	$34(a0),d1
		move.w	d1,y_pos(a0)
		neg.w	d2
		add.w	$30(a0),d2
		move.w	d2,x_pos(a0)
		rts
; End of function sub_25770

; ---------------------------------------------------------------------------
byte_25826:
		dc.b $20, $20, 0
		even
		dc.b $20, $20, 1
		even
; ---------------------------------------------------------------------------

Obj_LRZSolidMovingPlatforms:
		move.l	#Map_LRZSolidMovingPlatforms,mappings(a0)
		move.w	#make_art_tile($090,2,0),art_tile(a0)
		move.b	#4,render_flags(a0)
		move.w	#$180,priority(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#2,d0
		andi.w	#$1C,d0
		lea	byte_25826(pc,d0.w),a2
		move.b	(a2)+,width_pixels(a0)
		move.b	(a2)+,height_pixels(a0)
		move.b	(a2)+,mapping_frame(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$34(a0)
		move.b	subtype(a0),d0
		andi.w	#$F,d0
		add.w	d0,d0
		move.w	off_258BC(pc,d0.w),d0
		lea	off_258BC(pc,d0.w),a1
		move.l	a1,$42(a0)
		move.l	#loc_2588C,(a0)

loc_2588C:
		move.w	x_pos(a0),-(sp)
		movea.l	$42(a0),a1
		jsr	(a1)
		move.w	(sp)+,d4
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		jsr	(SolidObjectFull).l
		move.w	$30(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------
off_258BC:
		dc.w locret_258CE-off_258BC
		dc.w loc_258D0-off_258BC
		dc.w loc_258DC-off_258BC
		dc.w loc_25924-off_258BC
		dc.w loc_258FA-off_258BC
		dc.w loc_25906-off_258BC
		dc.w loc_25938-off_258BC
		dc.w loc_2594C-off_258BC
		dc.w loc_25960-off_258BC
; ---------------------------------------------------------------------------

locret_258CE:
		rts
; ---------------------------------------------------------------------------

loc_258D0:
		moveq	#0,d0
		move.b	(Oscillating_table+$0A).w,d0
		subi.w	#$20,d0
		bra.s	+ ;loc_258E6
; ---------------------------------------------------------------------------

loc_258DC:
		moveq	#0,d0
		move.b	(Oscillating_table+$1E).w,d0
		subi.w	#$40,d0

+ ;loc_258E6:
		btst	#0,status(a0)
		beq.s	+ ;loc_258F0
		neg.w	d0

+ ;loc_258F0:
		add.w	$30(a0),d0
		move.w	d0,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_258FA:
		moveq	#0,d0
		move.b	(Oscillating_table+$0A).w,d0
		subi.w	#$20,d0
		bra.s	+ ;loc_25910
; ---------------------------------------------------------------------------

loc_25906:
		moveq	#0,d0
		move.b	(Oscillating_table+$1E).w,d0
		subi.w	#$40,d0

+ ;loc_25910:
		btst	#0,status(a0)
		beq.s	+ ;loc_2591A
		neg.w	d0

+ ;loc_2591A:
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_25924:
		move.w	#$5F,d2
		bsr.s	+ ;sub_25974
		subi.w	#$60,d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_25938:
		move.w	#$5F,d2
		bsr.s	+ ;sub_25974
		subi.w	#$60,d0
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_2594C:
		move.w	#$7F,d2
		bsr.s	+ ;sub_25974
		subi.w	#$80,d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_25960:
		move.w	#$7F,d2
		bsr.s	+ ;sub_25974
		subi.w	#$80,d0
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		rts

; =============== S U B R O U T I N E =======================================


+ ;sub_25974:
		tst.b	$3C(a0)
		bne.s	+ ;loc_25996
		move.w	$40(a0),d1
		addq.w	#4,d1
		move.w	d1,$40(a0)
		add.w	d1,$36(a0)
		cmp.b	$36(a0),d2
		bhi.s	++ ;loc_259B0
		move.b	#1,$3C(a0)
		bra.s	++ ;loc_259B0
; ---------------------------------------------------------------------------

+ ;loc_25996:
		move.w	$40(a0),d1
		subq.w	#4,d1
		move.w	d1,$40(a0)
		add.w	d1,$36(a0)
		cmp.b	$36(a0),d2
		bls.s	+ ;loc_259B0
		move.b	#0,$3C(a0)

+ ;loc_259B0:
		moveq	#0,d0
		move.b	$36(a0),d0
		btst	#0,status(a0)
		beq.s	locret_259C2
		neg.w	d0
		add.w	d2,d0

locret_259C2:
		rts
; End of function sub_25974

; ---------------------------------------------------------------------------
Map_LRZSolidMovingPlatforms:
		include "Levels/LRZ/Misc Object Data/Map - Solid Moving Platforms.asm"
; ---------------------------------------------------------------------------
		dc.b  $20, $10,   0
		even
; ---------------------------------------------------------------------------

Obj_DEZFloatingPlatform:
		move.l	#Map_DEZFloatingPlatform,mappings(a0)
		move.w	#make_art_tile($33A,1,0),art_tile(a0)
		move.b	#4,render_flags(a0)
		move.w	#$200,priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$34(a0)
		move.b	subtype(a0),d0
		andi.w	#$F,d0
		add.w	d0,d0
		move.w	word_25AB8(pc,d0.w),d0
		lea	word_25AB8(pc,d0.w),a1
		move.l	a1,$42(a0)
		move.l	#loc_25A7E,(a0)

loc_25A7E:
		move.w	x_pos(a0),-(sp)
		movea.l	$42(a0),a1
		jsr	(a1)
		move.w	(sp)+,d4
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		jsr	(SolidObjectFull).l
		addq.b	#1,mapping_frame(a0)
		andi.b	#1,mapping_frame(a0)
		move.w	$30(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------
word_25AB8:
		dc.w locret_258CE-word_25AB8
		dc.w loc_258D0-word_25AB8
		dc.w loc_258DC-word_25AB8
		dc.w loc_25924-word_25AB8
		dc.w loc_258FA-word_25AB8
		dc.w loc_25906-word_25AB8
		dc.w loc_25938-word_25AB8
		dc.w loc_2594C-word_25AB8
		dc.w loc_25960-word_25AB8
; ---------------------------------------------------------------------------
Map_DEZFloatingPlatform:
		include "Levels/DEZ/Misc Object Data/Map - Floating Platform.asm"
; ---------------------------------------------------------------------------
