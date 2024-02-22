Obj_HCZWaterWall:
		tst.b	subtype(a0)
		beq.s	loc_2E794
		move.l	#loc_2EB24,(a0)
		rts
; ---------------------------------------------------------------------------

loc_2E794:
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$500,d0
		bhs.s	loc_2E7A4
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2E7A4:
		lea	(ArtKosM_HCZGeyserHorz).l,a1
		move.w	#tiles_to_bytes($500),d2
		jsr	(Queue_Kos_Module).l
		move.l	#loc_2E7BA,(a0)

loc_2E7BA:
		tst.b	(Kos_modules_left).w
		beq.s	loc_2E7C2
		rts
; ---------------------------------------------------------------------------

loc_2E7C2:
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
		move.l	#loc_2E80C,(a0)

loc_2E80C:
		move.w	(Player_1+x_pos).w,d0
		subi.w	#$60,d0
		cmp.w	x_pos(a0),d0
		blo.w	loc_2E896
		move.l	#loc_2E8CC,(a0)
		moveq	#signextendB(sfx_Geyser),d0
		jsr	(Play_SFX).l
		lea	(byte_2E89C).l,a3
		move.w	x_pos(a0),d2
		addi.w	#$60,d2
		move.w	y_pos(a0),d3
		moveq	#8-1,d1

loc_2E83E:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_2E896
		move.l	#loc_2E9AA,(a1)
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
		dbf	d1,loc_2E83E

loc_2E896:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
byte_2E89C:
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

loc_2E8CC:
		tst.w	$30(a0)
		beq.s	loc_2E8DA
		subq.w	#1,$30(a0)
		addq.w	#8,x_pos(a0)

loc_2E8DA:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_2E958
		move.l	#loc_2EA6E,(a1)
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
		bne.s	loc_2E936
		move.w	#make_art_tile($45C,0,0),art_tile(a1)

loc_2E936:
		move.b	d1,anim(a1)
		move.w	#$380,priority(a1)
		move.b	#$18,width_pixels(a1)
		move.b	#$18,height_pixels(a1)
		move.w	#$400,x_vel(a1)
		move.w	#0,y_vel(a1)

loc_2E958:
		lea	sub2_x_pos(a0),a2
		move.w	x_pos(a0),(a2)+
		move.w	y_pos(a0),(a2)+
		tst.b	render_flags(a0)
		bmi.s	loc_2E990
		clr.b	(Palette_cycle_counters+$00).w
		move.w	#signextendB(mus_MutePSG),d0
		jsr	(Play_SFX).l
		move.w	#signextendB(mus_StopSFX),d0
		jsr	(Play_SFX).l
		move.w	#150,$30(a0)
		move.l	#loc_2E996,(a0)
		rts
; ---------------------------------------------------------------------------

loc_2E990:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_2E996:
		subq.w	#1,$30(a0)
		bmi.s	loc_2E99E
		rts
; ---------------------------------------------------------------------------

loc_2E99E:
		jsr	(LoadEnemyArt).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2E9AA:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_2E9C0
		move.b	#2,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		andi.b	#7,mapping_frame(a0)

loc_2E9C0:
		jsr	(MoveSprite2).l
		addi.w	#$38,y_vel(a0)
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_2EA32
		move.w	#0,y_vel(a0)
		asr	x_vel(a0)
		asr	x_vel(a0)
		move.l	#loc_2EA38,(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_2EA32
		move.l	#loc_2EACE,(a1)
		move.l	#Map_HCZWaterWall,mappings(a1)
		move.w	#make_art_tile($530,1,0),art_tile(a1)
		move.b	#$84,render_flags(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	(Water_level).w,y_pos(a1)
		move.w	#$200,priority(a1)
		move.b	#$18,width_pixels(a1)
		move.b	#$18,height_pixels(a1)
		move.b	#8,anim(a1)

loc_2EA32:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2EA38:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_2EA4E
		move.b	#9,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		andi.b	#7,mapping_frame(a0)

loc_2EA4E:
		jsr	(MoveSprite2).l
		addi.w	#8,y_vel(a0)
		tst.b	render_flags(a0)
		bpl.w	loc_2EA68
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2EA68:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2EA6E:
		jsr	(MoveSprite2).l
		addi.w	#$28,y_vel(a0)
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_2EA92
		move.w	d0,y_pos(a0)
		move.l	#loc_2EAAC,(a0)
		addq.b	#4,anim(a0)

loc_2EA92:
		tst.b	render_flags(a0)
		bpl.w	loc_2EA68
		lea	(Ani_HCZWaterWall).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2EAAC:
		tst.b	render_flags(a0)
		bpl.w	loc_2EA68
		lea	(Ani_HCZWaterWall).l,a1
		jsr	(Animate_Sprite).l
		tst.b	routine(a0)
		bne.w	loc_2EA68
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2EACE:
		tst.b	render_flags(a0)
		bpl.w	loc_2EA68
		lea	(Ani_HCZWaterWall).l,a1
		jsr	(Animate_SpriteIrregularDelay).l
		tst.b	routine(a0)
		bne.w	loc_2EA68
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_HCZWaterWall:
		include "Levels/HCZ/Misc Object Data/Anim - Water Wall.asm"
; ---------------------------------------------------------------------------

loc_2EB24:
		move.w	(Player_1+x_pos).w,d0
		addi.w	#$30,d0
		sub.w	x_pos(a0),d0
		cmpi.w	#$60,d0
		bhs.s	loc_2EB48
		move.w	(Player_1+y_pos).w,d0
		addi.w	#$40,d0
		sub.w	y_pos(a0),d0
		cmpi.w	#$10,d0
		blo.s	loc_2EB4E

loc_2EB48:
		jmp	(Delete_Sprite_If_Not_In_Range).l
; ---------------------------------------------------------------------------

loc_2EB4E:
		lea	(ArtKosM_HCZGeyserVert).l,a1
		move.w	#tiles_to_bytes($500),d2
		jsr	(Queue_Kos_Module).l
		move.b	#1,mapping_frame(a0)
		move.b	#$81,(Player_1+object_control).w
		move.b	#$81,(Player_2+object_control).w
		move.l	#loc_2EB76,(a0)

loc_2EB76:
		tst.b	(Kos_modules_left).w
		beq.s	loc_2EB8A
		subi.w	#8,(Player_1+y_pos).w
		subi.w	#8,(Player_2+y_pos).w
		rts
; ---------------------------------------------------------------------------

loc_2EB8A:
		ori.b	#4,render_flags(a0)
		move.w	#$300,priority(a0)
		move.l	#Map_HCZWaterWall,mappings(a0)
		move.w	#make_art_tile($500,2,0),art_tile(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$60,height_pixels(a0)
		move.w	#$60,$30(a0)
		move.b	#$1C,(Player_1+anim).w
		move.b	#$1C,(Player_2+anim).w
		move.l	#loc_2EBC8,(a0)

loc_2EBC8:
		tst.w	$30(a0)
		beq.s	loc_2EBD6
		subq.w	#1,$30(a0)
		subq.w	#8,y_pos(a0)

loc_2EBD6:
		subi.w	#8,(Player_1+y_pos).w
		subi.w	#8,(Player_2+y_pos).w
		cmpi.w	#$28,$30(a0)
		bhi.w	locret_2EC78
		move.b	#$1A,(Player_1+anim).w
		move.b	#$1A,(Player_2+anim).w
		move.l	#loc_2ECAA,(a0)
		moveq	#signextendB(sfx_Geyser),d0
		jsr	(Play_SFX).l
		move.b	#1,(Palette_cycle_counters+$00).w
		lea	(byte_2EC7A).l,a3
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		subi.w	#$80,d3
		moveq	#8-1,d1

loc_2EC20:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_2EC78
		move.l	#loc_2E9AA,(a1)
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
		dbf	d1,loc_2EC20

locret_2EC78:
		rts
; ---------------------------------------------------------------------------
byte_2EC7A:
		dc.b -$18,   0
		dc.w  -$200, -$B00
		dc.b   -8,   0
		dc.w  -$100, -$C00
		dc.b -$18,   0
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

loc_2ECAA:
		tst.w	$30(a0)
		beq.s	loc_2ED00
		move.w	#-$A00,y_vel(a0)
		subq.w	#1,$30(a0)
		bne.s	loc_2ED00
		move.l	#loc_2EDBA,(a0)
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

loc_2ED00:
		subi.w	#$A,(Player_1+y_pos).w
		subi.w	#$A,(Player_2+y_pos).w
		jsr	(MoveSprite2).l
		addi.w	#$48,y_vel(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_2ED64
		jsr	(Random_Number).l
		move.w	d0,d1
		move.w	d0,d2
		bsr.s	sub_2ED6A
		addi.w	#$10,x_pos(a1)
		andi.w	#$F,d1
		lsl.w	#6,d1
		move.w	d1,x_vel(a1)
		move.w	#-$700,y_vel(a1)
		move.w	d0,d2
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_2ED64
		bsr.s	sub_2ED6A
		subi.w	#$10,x_pos(a1)
		neg.w	d1
		move.w	d1,x_vel(a1)
		move.w	#-$700,y_vel(a1)

loc_2ED64:
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_2ED6A:
		move.l	#loc_2EA6E,(a1)
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
		bne.s	loc_2EDB4
		move.w	#make_art_tile($45C,0,0),art_tile(a1)

loc_2EDB4:
		move.b	d2,anim(a1)
		rts
; End of function sub_2ED6A

; ---------------------------------------------------------------------------

loc_2EDBA:
		tst.b	render_flags(a0)
		bmi.s	loc_2EDFE
		move.w	#signextendB(mus_StopSFX),d0
		jsr	(Play_SFX).l
		move.w	#signextendB(mus_MutePSG),d0
		jsr	(Play_SFX).l		; this will actually never play... Why is any of this here?
		move.w	#signextendB(mus_StopSFX),d0
		jsr	(Play_SFX).l
		move.b	#0,(Palette_cycle_counters+$00).w
		move.w	respawn_addr(a0),d0
		beq.s	loc_2EDF0
		movea.w	d0,a2
		bclr	#7,(a2)

loc_2EDF0:
		move.w	#$1E,$30(a0)
		move.l	#loc_2E996,(a0)
		rts
; ---------------------------------------------------------------------------

loc_2EDFE:
		jsr	(MoveSprite2).l
		addi.w	#$48,y_vel(a0)
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
Map_HCZWaterWall:
		include "Levels/HCZ/Misc Object Data/Map - Waterfall.asm"
Map_HCZWaterWallDebris:
		include "Levels/HCZ/Misc Object Data/Map - Water Wall Debris.asm"
; ---------------------------------------------------------------------------
