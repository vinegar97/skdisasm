Obj_HCZWaterWall:
		tst.b	subtype(a0)
		beq.s	loc_2FF04
		move.l	#loc_30294,(a0)
		rts
; ---------------------------------------------------------------------------

loc_2FF04:
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$500,d0
		bhs.s	loc_2FF14
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2FF14:
		lea	(ArtKosM_HCZGeyserHorz).l,a1
		move.w	#tiles_to_bytes($500),d2
		jsr	(Queue_Kos_Module).l
		move.l	#loc_2FF2A,(a0)

loc_2FF2A:
		tst.b	(Kos_modules_left).w
		beq.s	loc_2FF32
		rts
; ---------------------------------------------------------------------------

loc_2FF32:
		ori.b	#4,render_flags(a0)
		move.w	#$300,priority(a0)
		move.l	#Map_HCZWaterWall,mappings(a0)
		move.w	#make_art_tile($500,2,0),art_tile(a0)
		move.b	#$80,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		bset	#6,render_flags(a0)
		move.w	#1,mainspr_childsprites(a0)
		lea	sub2_x_pos(a0),a2
		move.w	x_pos(a0),(a2)+
		move.w	y_pos(a0),(a2)+
		move.w	#$20,$30(a0)
		move.l	#loc_2FF7C,(a0)

loc_2FF7C:
		move.w	(Player_1+x_pos).w,d0
		subi.w	#$60,d0
		cmp.w	x_pos(a0),d0
		blo.w	loc_30006
		move.l	#loc_3003C,(a0)
		moveq	#signextendB(sfx_Geyser),d0
		jsr	(Play_SFX).l
		lea	(byte_3000C).l,a3
		move.w	x_pos(a0),d2
		addi.w	#$60,d2
		move.w	y_pos(a0),d3
		moveq	#8-1,d1

loc_2FFAE:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_30006
		move.l	#loc_3011A,(a1)
		move.l	#Map_HCZWaterWallDebris,mappings(a1)
		move.w	#make_art_tile($558,2,0),art_tile(a1)
		move.b	#$84,render_flags(a1)
		move.b	(a3)+,d0
		ext.w	d0
		add.w	d2,d0
		move.w	d0,x_pos(a1)
		move.b	(a3)+,d0
		ext.w	d0
		add.w	d3,d0
		move.w	d0,y_pos(a1)
		move.w	#$380,priority(a1)
		move.b	#$18,width_pixels(a1)
		move.b	#$18,height_pixels(a1)
		move.w	(a3)+,x_vel(a1)
		move.w	(a3)+,y_vel(a1)
		move.b	d1,mapping_frame(a1)
		dbf	d1,loc_2FFAE

loc_30006:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
byte_3000C:
		dc.b    0,-$18
		dc.w   $400,  -$80
		dc.b    0,  -8
		dc.w   $600,  -$40
		dc.b    0,   8
		dc.w   $600,   $40
		dc.b    0, $18
		dc.w   $400,   $80
		dc.b    0,-$18
		dc.w   $300, -$380
		dc.b    0,  -8
		dc.w   $400, -$340
		dc.b    0,   8
		dc.w   $300,  $100
		dc.b    0, $18
		dc.w   $500, -$100
; ---------------------------------------------------------------------------

loc_3003C:
		tst.w	$30(a0)
		beq.s	loc_3004A
		subq.w	#1,$30(a0)
		addq.w	#8,x_pos(a0)

loc_3004A:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_300C8
		move.l	#loc_301DE,(a1)
		move.l	mappings(a0),mappings(a1)
		move.b	#$84,render_flags(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	(Level_frame_counter).w,d0
		jsr	(Random_Number).l
		move.w	d0,d1
		andi.w	#$F,d0
		lsl.w	#3,d0
		subi.w	#$50,d0
		add.w	d0,x_pos(a1)
		addi.w	#$18,y_pos(a1)
		move.w	#make_art_tile($530,2,0),art_tile(a1)
		lsr.w	#4,d1
		andi.w	#3,d1
		bne.s	loc_300A6
		move.w	#make_art_tile($45C,0,0),art_tile(a1)

loc_300A6:
		move.b	d1,anim(a1)
		move.w	#$380,priority(a1)
		move.b	#$18,width_pixels(a1)
		move.b	#$18,height_pixels(a1)
		move.w	#$400,x_vel(a1)
		move.w	#0,y_vel(a1)

loc_300C8:
		lea	sub2_x_pos(a0),a2
		move.w	x_pos(a0),(a2)+
		move.w	y_pos(a0),(a2)+
		tst.b	render_flags(a0)
		bmi.s	loc_30100
		clr.b	(Palette_cycle_counters+$00).w
		move.w	#signextendB(mus_MutePSG),d0
		jsr	(Play_SFX).l
		move.w	#signextendB(mus_StopSFX),d0
		jsr	(Play_SFX).l
		move.w	#150,$30(a0)
		move.l	#loc_30106,(a0)
		rts
; ---------------------------------------------------------------------------

loc_30100:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_30106:
		subq.w	#1,$30(a0)
		bmi.s	loc_3010E
		rts
; ---------------------------------------------------------------------------

loc_3010E:
		jsr	(LoadEnemyArt).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3011A:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_30130
		move.b	#2,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		andi.b	#7,mapping_frame(a0)

loc_30130:
		jsr	(MoveSprite2).l
		addi.w	#$38,y_vel(a0)
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_301A2
		move.w	#0,y_vel(a0)
		asr	x_vel(a0)
		asr	x_vel(a0)
		move.l	#loc_301A8,(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_301A2
		move.l	#loc_3023E,(a1)
		move.l	#Map_HCZWaterWall,mappings(a1)
		move.w	#make_art_tile($530,1,0),art_tile(a1)
		move.b	#$84,render_flags(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	(Water_level).w,y_pos(a1)
		move.w	#$200,priority(a1)
		move.b	#$18,width_pixels(a1)
		move.b	#$18,height_pixels(a1)
		move.b	#8,anim(a1)

loc_301A2:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_301A8:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_301BE
		move.b	#9,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		andi.b	#7,mapping_frame(a0)

loc_301BE:
		jsr	(MoveSprite2).l
		addi.w	#8,y_vel(a0)
		tst.b	render_flags(a0)
		bpl.w	loc_301D8
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_301D8:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_301DE:
		jsr	(MoveSprite2).l
		addi.w	#$28,y_vel(a0)
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_30202
		move.w	d0,y_pos(a0)
		move.l	#loc_3021C,(a0)
		addq.b	#4,anim(a0)

loc_30202:
		tst.b	render_flags(a0)
		bpl.w	loc_301D8
		lea	(Ani_HCZWaterWall).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_3021C:
		tst.b	render_flags(a0)
		bpl.w	loc_301D8
		lea	(Ani_HCZWaterWall).l,a1
		jsr	(Animate_Sprite).l
		tst.b	routine(a0)
		bne.w	loc_301D8
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_3023E:
		tst.b	render_flags(a0)
		bpl.w	loc_301D8
		lea	(Ani_HCZWaterWall).l,a1
		jsr	(Animate_SpriteIrregularDelay).l
		tst.b	routine(a0)
		bne.w	loc_301D8
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_HCZWaterWall:
		include "Levels/HCZ/Misc Object Data/Anim - Water Wall.asm"
; ---------------------------------------------------------------------------

loc_30294:
		move.w	(Player_1+x_pos).w,d0
		addi.w	#$30,d0
		sub.w	x_pos(a0),d0
		cmpi.w	#$60,d0
		bhs.s	loc_302B8
		move.w	(Player_1+y_pos).w,d0
		addi.w	#$40,d0
		sub.w	y_pos(a0),d0
		cmpi.w	#$10,d0
		blo.s	loc_302BE

loc_302B8:
		jmp	(Delete_Sprite_If_Not_In_Range).l
; ---------------------------------------------------------------------------

loc_302BE:
		lea	(ArtKosM_HCZGeyserVert).l,a1
		move.w	#tiles_to_bytes($500),d2
		jsr	(Queue_Kos_Module).l
		move.b	#1,mapping_frame(a0)
		move.b	#$81,(Player_1+object_control).w
		move.b	#$81,(Player_2+object_control).w
		move.l	#loc_302E6,(a0)

loc_302E6:
		tst.b	(Kos_modules_left).w
		beq.s	loc_302FA
		subi.w	#8,(Player_1+y_pos).w
		subi.w	#8,(Player_2+y_pos).w
		rts
; ---------------------------------------------------------------------------

loc_302FA:
		ori.b	#4,render_flags(a0)
		move.w	#$300,priority(a0)
		move.l	#Map_HCZWaterWall,mappings(a0)
		move.w	#make_art_tile($500,2,0),art_tile(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$60,height_pixels(a0)
		move.w	#$60,$30(a0)
		move.b	#$1C,(Player_1+anim).w
		move.b	#$1C,(Player_2+anim).w
		move.l	#loc_30338,(a0)

loc_30338:
		tst.w	$30(a0)
		beq.s	loc_30346
		subq.w	#1,$30(a0)
		subq.w	#8,y_pos(a0)

loc_30346:
		subi.w	#8,(Player_1+y_pos).w
		subi.w	#8,(Player_2+y_pos).w
		cmpi.w	#$28,$30(a0)
		bhi.w	locret_303E8
		move.b	#$1A,(Player_1+anim).w
		move.b	#$1A,(Player_2+anim).w
		move.l	#loc_3041A,(a0)
		moveq	#signextendB(sfx_Geyser),d0
		jsr	(Play_SFX).l
		move.b	#1,(Palette_cycle_counters+$00).w
		lea	(byte_303EA).l,a3
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		subi.w	#$80,d3
		moveq	#8-1,d1

loc_30390:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_303E8
		move.l	#loc_3011A,(a1)
		move.l	#Map_HCZWaterWallDebris,mappings(a1)
		move.w	#make_art_tile($558,2,0),art_tile(a1)
		move.b	#$84,render_flags(a1)
		move.b	(a3)+,d0
		ext.w	d0
		add.w	d2,d0
		move.w	d0,x_pos(a1)
		move.b	(a3)+,d0
		ext.w	d0
		add.w	d3,d0
		move.w	d0,y_pos(a1)
		move.w	#$280,priority(a1)
		move.b	#$18,width_pixels(a1)
		move.b	#$18,height_pixels(a1)
		move.w	(a3)+,x_vel(a1)
		move.w	(a3)+,y_vel(a1)
		move.b	d1,mapping_frame(a1)
		dbf	d1,loc_30390

locret_303E8:
		rts
; ---------------------------------------------------------------------------
byte_303EA:
		dc.b -$18,   0
		dc.w  -$200, -$B00
		dc.b   -8,   0
		dc.w  -$100, -$C00
		dc.b -$18,  0
		dc.w  -$400, -$800
		dc.b   -8,   0
		dc.w  -$300, -$A00
		dc.b    8,   0
		dc.w   $300, -$C00
		dc.b  $18,   0
		dc.w   $400, -$B00
		dc.b    8,   0
		dc.w   $100, -$A00
		dc.b  $18,   0
		dc.w   $200, -$800
; ---------------------------------------------------------------------------

loc_3041A:
		tst.w	$30(a0)
		beq.s	loc_30470
		move.w	#-$A00,y_vel(a0)
		subq.w	#1,$30(a0)
		bne.s	loc_30470
		move.l	#loc_3052A,(a0)
		lea	(Player_1).w,a1
		move.b	#0,object_control(a1)
		move.w	#0,x_vel(a1)
		move.w	#-$C00,y_vel(a1)
		move.b	#0,jumping(a1)
		lea	(Player_2).w,a1
		move.b	#0,object_control(a1)
		move.w	#0,x_vel(a1)
		move.w	#-$C00,y_vel(a1)
		move.b	#0,jumping(a1)
		move.w	#-$800,y_vel(a0)

loc_30470:
		subi.w	#$A,(Player_1+y_pos).w
		subi.w	#$A,(Player_2+y_pos).w
		jsr	(MoveSprite2).l
		addi.w	#$48,y_vel(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_304D4
		jsr	(Random_Number).l
		move.w	d0,d1
		move.w	d0,d2
		bsr.s	sub_304DA
		addi.w	#$10,x_pos(a1)
		andi.w	#$F,d1
		lsl.w	#6,d1
		move.w	d1,x_vel(a1)
		move.w	#-$700,y_vel(a1)
		move.w	d0,d2
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_304D4
		bsr.s	sub_304DA
		subi.w	#$10,x_pos(a1)
		neg.w	d1
		move.w	d1,x_vel(a1)
		move.w	#-$700,y_vel(a1)

loc_304D4:
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_304DA:
		move.l	#loc_301DE,(a1)
		move.l	mappings(a0),mappings(a1)
		move.b	#$84,render_flags(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		subi.w	#$50,y_pos(a1)
		move.w	#$380,priority(a1)
		move.b	#$18,width_pixels(a1)
		move.b	#$18,height_pixels(a1)
		move.w	#make_art_tile($530,2,0),art_tile(a1)
		lsr.w	#4,d2
		andi.w	#3,d2
		bne.s	loc_30524
		move.w	#make_art_tile($45C,0,0),art_tile(a1)

loc_30524:
		move.b	d2,anim(a1)
		rts
; End of function sub_304DA

; ---------------------------------------------------------------------------

loc_3052A:
		tst.b	render_flags(a0)
		bmi.s	loc_3056E
		move.w	#signextendB(mus_StopSFX),d0
		jsr	(Play_SFX).l
		move.w	#signextendB(mus_MutePSG),d0
		jsr	(Play_SFX).l		; this will actually never play... Why is any of this here?
		move.w	#signextendB(mus_StopSFX),d0
		jsr	(Play_SFX).l
		move.b	#0,(Palette_cycle_counters+$00).w
		move.w	respawn_addr(a0),d0
		beq.s	loc_30560
		movea.w	d0,a2
		bclr	#7,(a2)

loc_30560:
		move.w	#$1E,$30(a0)
		move.l	#loc_30106,(a0)
		rts
; ---------------------------------------------------------------------------

loc_3056E:
		jsr	(MoveSprite2).l
		addi.w	#$48,y_vel(a0)
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
