Obj_SSZFloatingPlatform:
		move.l	#loc_44AA0,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$11,height_pixels(a0)
		move.b	#$20,width_pixels(a0)
		move.w	#$180,priority(a0)
		move.w	#make_art_tile($2D4,2,0),art_tile(a0)
		move.l	#Map_SSZFloatingPlatform,mappings(a0)
		move.b	#1,mapping_frame(a0)
		move.w	y_pos(a0),$1A(a0)

loc_44AA0:
		move.w	$2E(a0),d0
		move.b	status(a0),d1
		andi.w	#standing_mask,d1
		bne.s	loc_44AB6
		tst.w	d0
		beq.s	loc_44ABE
		subq.w	#1,d0
		bra.s	loc_44ABE
; ---------------------------------------------------------------------------

loc_44AB6:
		cmpi.w	#4,d0
		bhs.s	loc_44ABE
		addq.w	#1,d0

loc_44ABE:
		move.w	d0,$2E(a0)
		add.w	$1A(a0),d0
		move.w	d0,y_pos(a0)
		moveq	#$2B,d1
		moveq	#$11,d2
		moveq	#$11,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_SSZCollapsingColumn:
		move.l	#loc_44B30,(a0)
		move.b	#4,render_flags(a0)
		move.b	#1,routine(a0)
		move.b	#$21,height_pixels(a0)
		move.b	#$10,width_pixels(a0)
		move.w	#$180,priority(a0)
		move.w	#make_art_tile($2E4,3,1),art_tile(a0)
		move.l	#Map_SSZFloatingPlatform,mappings(a0)
		move.b	#2,mapping_frame(a0)
		move.w	y_pos(a0),$1A(a0)
		jsr	(Random_Number).l
		andi.w	#$1FFF,d0
		addi.w	#$800,d0
		move.w	d0,$30(a0)

loc_44B30:
		move.b	status(a0),d0
		andi.w	#standing_mask,d0
		beq.s	loc_44B90
		clr.b	routine(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_44B7E
		lea	word_46618(pc),a2
		move.w	x_pos(a0),d1
		moveq	#8-1,d2

loc_44B50:
		move.l	#loc_44BCC,(a1)
		move.w	a0,$2E(a1)
		move.w	(a2)+,d3
		add.w	d1,d3
		move.w	d3,x_pos(a1)
		move.w	(a2)+,$30(a1)
		move.w	(a2)+,$32(a1)
		move.w	(a2)+,d3
		move.b	d3,mapping_frame(a1)
		addq.b	#1,routine(a0)
		jsr	(CreateNewSprite4).l
		dbne	d2,loc_44B50

loc_44B7E:
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		clr.b	mapping_frame(a0)
		move.l	#loc_44B90,(a0)

loc_44B90:
		tst.b	routine(a0)
		beq.s	loc_44B98
		bpl.s	loc_44B9E

loc_44B98:
		move.w	#$7FFF,x_pos(a0)

loc_44B9E:
		move.l	#$2800,d0
		move.l	#$80,d1
		jsr	Gradual_SwingOffset(pc)
		add.w	$1A(a0),d0
		move.w	d0,y_pos(a0)
		moveq	#$1B,d1
		moveq	#$21,d2
		moveq	#$21,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_44BCC:
		move.l	#loc_44BF8,(a0)
		move.b	#$84,render_flags(a0)
		move.b	#8,height_pixels(a0)
		move.b	#8,width_pixels(a0)
		move.w	#$200,priority(a0)
		move.w	#make_art_tile($2E4,3,1),art_tile(a0)
		move.l	#Map_SSZFloatingPlatform,mappings(a0)

loc_44BF8:
		movea.w	$2E(a0),a1
		tst.b	render_flags(a0)
		bmi.s	loc_44C14
		tst.w	$32(a0)
		beq.s	loc_44C0E
		bmi.s	loc_44C0E
		subq.b	#1,routine(a1)

loc_44C0E:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_44C14:
		subq.w	#1,$32(a0)
		bpl.s	loc_44C2C
		move.w	y_pos(a0),d0
		addi.l	#$3800,$34(a0)
		add.w	$34(a0),d0
		bra.s	loc_44C3A
; ---------------------------------------------------------------------------

loc_44C2C:
		bne.s	loc_44C32
		subq.b	#1,routine(a1)

loc_44C32:
		move.w	y_pos(a1),d0
		add.w	$30(a0),d0

loc_44C3A:
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SSZCollapsingBridge:
		move.l	#loc_44C76,(a0)
		bset	#2,render_flags(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#$20,width_pixels(a0)
		move.w	#$180,priority(a0)
		move.w	#make_art_tile($2F4,2,1),art_tile(a0)
		move.l	#Map_SSZCollapsingBridge,mappings(a0)
		bset	#7,status(a0)

loc_44C76:
		moveq	#$20,d1
		moveq	#$10,d2
		moveq	#9,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		tst.b	subtype(a0)
		bmi.s	loc_44C96
		move.b	status(a0),d0
		andi.w	#standing_mask,d0
		bne.s	loc_44C9C

loc_44C96:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_44C9C:
		lea	(Player_1).w,a1
		btst	#p1_standing_bit,d0
		bne.s	loc_44CAA
		lea	(Player_2).w,a1

loc_44CAA:
		moveq	#$18,d1
		moveq	#$10,d2
		move.w	#$102,d3
		move.w	x_pos(a0),d4
		cmp.w	x_pos(a1),d4
		scc	$2E(a0)
		bcs.s	loc_44CC6
		neg.w	d1
		neg.w	d2
		ror.w	#8,d3

loc_44CC6:
		add.w	d4,d1
		btst	#0,render_flags(a0)
		beq.s	loc_44CD2
		ror.w	#8,d3

loc_44CD2:
		moveq	#6,d4
		moveq	#4-1,d5
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_44D0E

loc_44CDE:
		move.l	#loc_45052,(a1)
		move.b	render_flags(a0),render_flags(a1)
		move.w	d1,x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	d3,mapping_frame(a1)
		move.w	d4,$2E(a1)
		sub.w	d2,d1
		ror.w	#8,d3
		addi.w	#6,d4
		jsr	(CreateNewSprite4).l
		dbne	d5,loc_44CDE

loc_44D0E:
		move.l	#loc_44D22,(a0)
		move.w	#6,$30(a0)
		move.w	#$20,$32(a0)
		rts
; ---------------------------------------------------------------------------

loc_44D22:
		subq.w	#1,$30(a0)
		bne.s	loc_44D48
		move.w	#6,$30(a0)
		subq.w	#8,$32(a0)
		bne.s	loc_44D3A
		move.w	#$7FFF,x_pos(a0)

loc_44D3A:
		moveq	#8,d0
		tst.b	$2E(a0)
		bne.s	loc_44D44
		neg.w	d0

loc_44D44:
		add.w	d0,x_pos(a0)

loc_44D48:
		move.w	$32(a0),d1
		moveq	#$10,d2
		moveq	#9,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		jmp	(Delete_Sprite_If_Not_In_Range).l
; ---------------------------------------------------------------------------

Obj_SSZCollapsingBridgeDiagonal:
		move.l	#loc_44D98,(a0)
		ori.b	#$44,render_flags(a0)
		move.b	#$20,height_pixels(a0)
		move.b	#$40,width_pixels(a0)
		move.w	#$180,priority(a0)
		move.w	#make_art_tile($2F4,2,1),art_tile(a0)
		move.l	#Map_SSZCollapsingBridge,mappings(a0)
		move.b	#3,mapping_frame(a0)
		bset	#7,status(a0)

loc_44D98:
		move.b	status(a0),d0
		move.w	d0,-(sp)
		moveq	#$40,d1
		lea	byte_46658(pc),a2
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTopSloped2).l
		move.w	(sp)+,d0
		btst	#p1_standing_bit,d0
		beq.s	loc_44DCE
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		beq.s	loc_44DCE
		tst.b	jumping(a1)
		bne.s	loc_44DCE
		bclr	#Status_InAir,status(a1)

loc_44DCE:
		btst	#p2_standing_bit,d0
		beq.s	loc_44DEC
		lea	(Player_2).w,a1
		btst	#Status_InAir,status(a1)
		beq.s	loc_44DEC
		tst.b	jumping(a1)
		bne.s	loc_44DEC
		bclr	#Status_InAir,status(a1)

loc_44DEC:
		tst.b	subtype(a0)
		bmi.s	loc_44DFC
		move.b	status(a0),d0
		andi.w	#standing_mask,d0
		bne.s	loc_44E02

loc_44DFC:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_44E02:
		lea	(Player_1).w,a1
		btst	#p1_standing_bit,d0
		bne.s	loc_44E10
		lea	(Player_2).w,a1

loc_44E10:
		moveq	#$38,d1
		moveq	#$10,d2
		move.w	#$405,d3
		moveq	#-8,d6
		move.w	x_pos(a0),d4
		cmp.w	x_pos(a1),d4
		scc	$2E(a0)
		bcs.s	loc_44E30
		neg.w	d1
		neg.w	d2
		ror.w	#8,d3
		neg.l	d6

loc_44E30:
		add.w	d4,d1
		btst	#0,render_flags(a0)
		beq.s	loc_44E3E
		ror.w	#8,d3
		neg.l	d6

loc_44E3E:
		tst.l	d6
		bmi.s	loc_44E44
		addq.l	#8,d6

loc_44E44:
		moveq	#6,d4
		moveq	#8-1,d5
		swap	d7
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_44E9C

loc_44E52:
		move.l	#loc_45052,(a1)
		move.b	render_flags(a0),d7
		andi.w	#$BF,d7
		move.b	d7,render_flags(a1)
		move.w	d1,x_pos(a1)
		move.w	y_pos(a0),d7
		add.w	d6,d7
		move.w	d7,y_pos(a1)
		move.b	d3,mapping_frame(a1)
		move.w	d4,object_control(a1)
		sub.w	d2,d1
		ror.w	#8,d3
		addi.w	#6,d4
		btst	#0,d5
		bne.s	loc_44E92
		tst.l	d6
		bmi.s	loc_44E90
		subq.w	#8,d6
		bra.s	loc_44E92
; ---------------------------------------------------------------------------

loc_44E90:
		addq.w	#8,d6

loc_44E92:
		jsr	(CreateNewSprite4).l
		dbne	d5,loc_44E52

loc_44E9C:
		swap	d7
		move.l	#loc_44EBA,(a0)
		move.w	#6,$30(a0)
		move.w	#$40,$32(a0)
		move.l	#byte_46658,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_44EBA:
		subq.w	#1,$30(a0)
		bne.s	loc_44EF6
		move.w	#6,$30(a0)
		addq.l	#4,$34(a0)
		subq.w	#8,$32(a0)
		bne.s	loc_44ED6
		move.w	#$7FFF,x_pos(a0)

loc_44ED6:
		moveq	#8,d0
		moveq	#2,d1
		tst.b	$2E(a0)
		bne.s	loc_44EE4
		neg.w	d0
		neg.w	d1

loc_44EE4:
		add.w	d0,x_pos(a0)
		btst	#0,render_flags(a0)
		beq.s	loc_44EF2
		neg.w	d1

loc_44EF2:
		sub.w	d1,y_pos(a0)

loc_44EF6:
		move.b	status(a0),d0
		move.w	d0,-(sp)
		move.w	$32(a0),d1
		movea.l	$34(a0),a2
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTopSloped2).l
		move.w	(sp)+,d0
		btst	#p1_standing_bit,d0
		beq.s	loc_44F2E
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		beq.s	loc_44F2E
		tst.b	jumping(a1)
		bne.s	loc_44F2E
		bclr	#Status_InAir,status(a1)

loc_44F2E:
		btst	#p2_standing_bit,d0
		beq.s	loc_44F4C
		lea	(Player_2).w,a1
		btst	#Status_InAir,status(a1)
		beq.s	loc_44F4C
		tst.b	jumping(a1)
		bne.s	loc_44F4C
		bclr	#Status_InAir,status(a1)

loc_44F4C:
		jmp	(Delete_Sprite_If_Not_In_Range).l
; ---------------------------------------------------------------------------

Obj_SSZCutsceneBridge:
		move.b	#$44,render_flags(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#$60,width_pixels(a0)
		move.w	#$180,priority(a0)
		move.w	#make_art_tile($2F4,2,1),art_tile(a0)
		move.l	#Map_SSZCollapsingBridge,mappings(a0)
		move.w	x_pos(a0),$12(a0)
		move.w	#3,mainspr_childsprites(a0)
		bset	#7,status(a0)
		move.w	#$C0,$2E(a0)
		lea	loc_44FA2(pc),a1
		tst.b	(Last_star_post_hit).w
		beq.s	loc_44F9E
		lea	loc_4501A(pc),a1

loc_44F9E:
		move.l	a1,(a0)
		jmp	(a1)
; ---------------------------------------------------------------------------

loc_44FA2:
		move.w	$2E(a0),d1
		tst.w	(Events_bg+$08).w
		beq.s	loc_45006
		cmpi.w	#$68,d1
		bne.s	loc_44FBA
		moveq	#signextendB(sfx_DoorOpen),d0
		jsr	(Play_SFX).l

loc_44FBA:
		subq.w	#2,d1
		move.w	d1,$2E(a0)
		bne.s	loc_45006
		clr.b	(Events_bg+$05).w
		clr.w	(Camera_min_X_pos).w
		move.w	#$19A0,(Camera_max_X_pos).w
		move.w	#-$100,(Camera_min_Y_pos).w
		move.w	#$1000,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$140,(Saved_X_pos).w
		move.w	#$C6C,(Saved_Y_pos).w
		move.b	#1,(Last_star_post_hit).w
		jsr	(Save_Level_Data).l
		clr.l	(Saved_timer).w
		moveq	#0,d1
		move.l	#loc_4501A,(a0)

loc_45006:
		add.w	$12(a0),d1
		move.w	x_pos(a0),d4
		move.w	d1,x_pos(a0)
		bsr.s	sub_45026
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4501A:
		move.w	x_pos(a0),d4
		bsr.s	sub_45026
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_45026:
		moveq	#$60,d1
		moveq	#$10,d2
		moveq	#9,d3
		jsr	(SolidObjectTop).l
		lea	sub2_x_pos(a0),a1
		move.w	x_pos(a0),d0
		subi.w	#$40,d0
		moveq	#2,d1

loc_45040:
		move.w	d0,(a1)+
		move.w	y_pos(a0),(a1)+
		addq.w	#2,a1
		addi.w	#$40,d0
		dbf	d1,loc_45040
		rts
; End of function sub_45026

; ---------------------------------------------------------------------------

loc_45052:
		move.l	#loc_4507E,(a0)
		bset	#7,render_flags(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#8,width_pixels(a0)
		move.w	#$200,priority(a0)
		move.w	#make_art_tile($2F4,2,1),art_tile(a0)
		move.l	#Map_SSZCollapsingBridge,mappings(a0)

loc_4507E:
		tst.b	render_flags(a0)
		bmi.s	loc_4508A
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4508A:
		move.w	$2E(a0),d0
		beq.s	loc_45098
		subq.w	#1,d0
		move.w	d0,$2E(a0)
		bra.s	loc_4509E
; ---------------------------------------------------------------------------

loc_45098:
		jsr	(MoveSprite).l

loc_4509E:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SSZBouncyCloud:
		move.l	#loc_450EC,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#$20,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile($3D6,3,1),art_tile(a0)
		move.l	#Map_SSZBouncyCloud,mappings(a0)
		clr.b	$2D(a0)
		move.w	y_pos(a0),$1A(a0)
		jsr	(Random_Number).l
		andi.w	#$FFF,d0
		addi.w	#$C00,d0
		move.w	d0,$30(a0)

loc_450EC:
		move.l	#$1C00,d0
		move.l	#$80,d1
		jsr	Gradual_SwingOffset(pc)
		add.w	$1A(a0),d0
		move.b	$3E(a0),d1
		move.b	$46(a0),d2
		move.b	d1,d3
		or.b	d2,d3
		beq.s	loc_4511A
		cmp.b	d2,d1
		bhs.s	loc_45114
		exg	d1,d2

loc_45114:
		ext.w	d1
		add.w	d1,d0
		bra.s	loc_45134
; ---------------------------------------------------------------------------

loc_4511A:
		move.b	$39(a0),d1
		move.b	$3F(a0),d2
		move.b	$41(a0),d3
		move.b	$47(a0),d4
		cmp.b	d3,d1
		bhs.s	loc_45130
		exg	d2,d4

loc_45130:
		ext.w	d2
		add.w	d2,d0

loc_45134:
		move.w	d0,y_pos(a0)
		tst.b	routine(a0)
		beq.s	loc_45142
		subq.b	#1,routine(a0)

loc_45142:
		move.b	$2D(a0),anim(a0)
		lea	(Player_1).w,a1
		lea	$38(a0),a2
		moveq	#p1_standing_bit,d6
		bsr.s	sub_45170
		lea	(Player_2).w,a1
		lea	$40(a0),a2
		moveq	#p2_standing_bit,d6
		bsr.s	sub_45170
		lea	Ani_SSZBouncyCloud(pc),a1
		jsr	(Animate_Sprite).l
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_45170:
		moveq	#$20,d1
		moveq	#$10,d2
		moveq	#0,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop_1P).l
		tst.b	(a2)
		bne.s	loc_451C2
		btst	d6,status(a0)
		beq.s	locret_451C0
		move.w	x_vel(a1),2(a2)
		move.w	ground_vel(a1),4(a2)
		clr.w	x_vel(a1)
		clr.w	ground_vel(a1)
		move.b	#1,anim(a0)
		move.b	#1,flip_type(a0)
		move.b	routine(a0),d0
		bne.s	loc_451B6
		moveq	#7,d0
		move.b	d0,routine(a0)

loc_451B6:
		move.b	d0,(a2)
		move.b	(byte_4669F).l,6(a2)

locret_451C0:
		rts
; ---------------------------------------------------------------------------

loc_451C2:
		bmi.w	loc_4527A
		subq.b	#1,(a2)
		beq.s	loc_451DC
		move.b	(a2),d0
		ext.w	d0
		lea	byte_46698(pc),a3
		move.b	(a3,d0.w),6(a2)
		bra.w	locret_45278
; ---------------------------------------------------------------------------

loc_451DC:
		moveq	#signextendB(sfx_Bouncy),d0
		jsr	(Play_SFX).l
		move.w	2(a2),x_vel(a1)
		move.w	4(a2),ground_vel(a1)
		move.w	#-$700,y_vel(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		clr.b	spin_dash_flag(a1)
		move.b	#2,routine(a1)
		clr.b	anim(a1)
		st	(a2)
		moveq	#-$1C,d0
		btst	#0,status(a1)
		bne.s	loc_45226
		neg.w	d0
		bclr	#0,(a2)

loc_45226:
		move.b	d0,angle(a1)
		clr.b	$2D(a0)
		clr.b	6(a2)
		move.b	#$26,1(a2)
		lea	word_466C8(pc),a3
		move.w	x_pos(a1),d1
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_45278
		moveq	#4-1,d2

loc_4524A:
		move.l	#loc_452DA,(a1)
		move.w	a0,$2E(a1)
		move.w	(a3)+,d3
		add.w	d1,d3
		move.w	d3,x_pos(a1)
		move.w	(a3)+,d3
		add.w	y_pos(a0),d3
		move.w	d3,y_pos(a1)
		move.w	(a3)+,x_vel(a1)
		move.w	(a3)+,y_vel(a1)
		jsr	(CreateNewSprite4).l
		dbne	d2,loc_4524A

locret_45278:
		rts
; ---------------------------------------------------------------------------

loc_4527A:
		tst.b	$2E(a1)
		bne.s	loc_452D6
		move.b	status(a1),d0
		btst	#1,d0
		beq.s	loc_452D6
		andi.w	#$28,d0
		bne.s	loc_452D6
		move.b	1(a2),d0
		ext.w	d0
		lea	byte_466A0(pc),a3
		move.b	(a3,d0.w),7(a2)
		subq.b	#1,d0
		bmi.s	loc_452A8
		move.b	d0,1(a2)

loc_452A8:
		move.b	angle(a1),d0
		move.l	#$60002,d1
		btst	#0,(a2)
		bne.s	loc_452C4
		tst.b	d0
		bmi.s	loc_452BE
		swap	d1

loc_452BE:
		add.b	d1,d0
		bcc.s	loc_452D0
		bra.s	loc_452CE
; ---------------------------------------------------------------------------

loc_452C4:
		tst.b	d0
		bpl.s	loc_452CA
		swap	d1

loc_452CA:
		sub.b	d1,d0
		bcc.s	loc_452D0

loc_452CE:
		moveq	#0,d0

loc_452D0:
		move.b	d0,angle(a1)
		bne.s	locret_452D8

loc_452D6:
		clr.b	(a2)

locret_452D8:
		rts
; End of function sub_45170

; ---------------------------------------------------------------------------

loc_452DA:
		movea.w	$2E(a0),a1
		move.w	x_pos(a1),d0
		tst.w	x_vel(a0)
		bpl.s	loc_452F4
		subi.w	#$18,d0
		cmp.w	x_pos(a0),d0
		bls.s	loc_45304
		bra.s	loc_452FE
; ---------------------------------------------------------------------------

loc_452F4:
		addi.w	#$18,d0
		cmp.w	x_pos(a0),d0
		bhs.s	loc_45304

loc_452FE:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_45304:
		move.l	#loc_45336,(a0)
		move.b	#4,render_flags(a0)
		move.b	#4,height_pixels(a0)
		move.b	#4,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile($3D6,3,1),art_tile(a0)
		move.l	#Map_SSZBouncyCloud,mappings(a0)
		move.b	#2,anim(a0)

loc_45336:
		lea	Ani_SSZBouncyCloud(pc),a1
		jsr	(Animate_SpriteIrregularDelay).l
		tst.b	routine(a0)
		beq.s	loc_4534C
		move.l	#Delete_Current_Sprite,(a0)

loc_4534C:
		jsr	(MoveSprite2).l
		lea	x_vel(a0),a1
		bsr.s	sub_45364
		lea	y_vel(a0),a1
		bsr.s	sub_45364
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_45364:
		move.w	(a1),d0
		asr.w	#2,d0
		sub.w	d0,(a1)
		rts
; End of function sub_45364

; ---------------------------------------------------------------------------

Obj_SSZElevatorBar:
		move.l	#loc_4539E,(a0)
		move.b	#4,render_flags(a0)
		move.b	#4,height_pixels(a0)
		move.b	#$30,width_pixels(a0)
		move.w	#$180,priority(a0)
		move.w	#make_art_tile($348,2,0),art_tile(a0)
		move.l	#Map_SSZElevatorBar,mappings(a0)
		move.w	y_pos(a0),$1A(a0)

loc_4539E:
		move.l	#$18000,d0
		move.l	#$480,d1
		jsr	Gradual_SwingOffset(pc)
		add.w	$1A(a0),d0
		move.w	d0,y_pos(a0)
		lea	(Player_1).w,a1
		lea	$38(a0),a2
		move.w	(Ctrl_1_logical).w,d0
		moveq	#$14,d1
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_453CE
		moveq	#$11,d1

loc_453CE:
		bsr.s	sub_453E6
		lea	(Player_2).w,a1
		lea	$39(a0),a2
		move.w	(Ctrl_2_logical).w,d0
		moveq	#$11,d1
		bsr.s	sub_453E6
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_453E6:
		tst.b	(a2)
		bne.w	loc_4548A
		tst.b	2(a2)
		beq.s	loc_45400
		subq.b	#1,2(a2)
		bne.w	locret_45526
		move.w	#$180,priority(a0)

loc_45400:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#$28,d0
		cmpi.w	#$50,d0
		bhs.w	locret_45526
		move.w	y_pos(a1),d0
		sub.w	y_pos(a0),d0
		cmpi.w	#$18,d0
		bhs.w	locret_45526
		tst.b	object_control(a1)
		bne.w	locret_45526
		cmpi.b	#4,routine(a1)
		bhs.w	locret_45526
		tst.w	(Debug_placement_mode).w
		bne.w	locret_45526
		moveq	#signextendB(sfx_Grab),d0
		jsr	(Play_SFX).l
		st	(a2)
		move.w	y_pos(a0),y_pos(a1)
		add.w	d1,y_pos(a1)
		clr.w	x_vel(a1)
		clr.w	ground_vel(a1)
		clr.b	spin_dash_flag(a1)
		move.b	#3,object_control(a1)
		andi.b	#$FC,render_flags(a1)
		clr.b	anim(a1)
		move.w	#$E5,d0
		btst	#Status_Facing,status(a1)
		beq.s	loc_4547C
		addq.w	#4,d0

loc_4547C:
		move.b	d0,mapping_frame(a1)
		jsr	(Perform_Player_DPLC).l
		bra.w	locret_45526
; ---------------------------------------------------------------------------

loc_4548A:
		move.w	y_pos(a0),y_pos(a1)
		add.w	d1,y_pos(a1)
		cmpi.b	#4,routine(a1)
		blo.s	loc_454AA
		clr.b	object_control(a1)
		clr.b	(a2)
		move.b	#60,2(a2)
		bra.s	locret_45526
; ---------------------------------------------------------------------------

loc_454AA:
		move.w	d0,d1
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d1
		beq.s	locret_45526
		clr.b	object_control(a1)
		clr.b	(a2)
		move.b	#30,2(a2)
		move.w	#$80,priority(a0)
		move.w	#-$200,d1
		move.w	#-$400,d2
		btst	#button_left+8,d0
		bne.s	loc_454EA
		move.w	#$180,priority(a0)
		neg.w	d1
		btst	#button_right+8,d0
		bne.s	loc_454EA
		moveq	#0,d1
		btst	#button_down+8,d0
		beq.s	loc_454EA
		moveq	#0,d2

loc_454EA:
		move.w	d1,x_vel(a1)
		move.l	$2E(a0),d0
		asr.l	#8,d0
		add.w	d2,d0
		move.w	d0,y_vel(a1)
		bset	#Status_InAir,status(a1)
		move.b	#1,jumping(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l

locret_45526:
		rts
; End of function sub_453E6

; ---------------------------------------------------------------------------

Obj_SSZHPZTeleporter:
		move.l	#loc_455CC,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#$180,priority(a0)
		move.w	#make_art_tile($35C,0,0),art_tile(a0)
		move.l	#Map_SSZHPZTeleporter,mappings(a0)
		move.w	y_pos(a0),$16(a0)
		move.b	subtype(a0),d0
		bpl.s	loc_45574
		lea	(Events_bg+$00).w,a1
		add.b	d0,d0
		bpl.s	loc_4556A
		addq.w	#2,a1

loc_4556A:
		tst.b	(a1)
		bmi.s	loc_45574
		move.w	#$20,$1A(a0)

loc_45574:
		cmpi.w	#$1701,(Current_zone_and_act).w
		beq.s	loc_455AC
		cmpi.b	#$16,(Current_zone).w
		bne.s	loc_455BA
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_45596
		move.l	#loc_45B94,(a1)
		move.w	a0,$2E(a1)

loc_45596:
		move.w	#make_art_tile($52E,0,0),art_tile(a0)
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_455B2
		move.b	#$4A,subtype(a0)
		bra.s	loc_455B2
; ---------------------------------------------------------------------------

loc_455AC:
		move.w	#make_art_tile($488,0,0),art_tile(a0)

loc_455B2:
		move.b	#$A,mapping_frame(a0)
		bra.s	loc_455CC
; ---------------------------------------------------------------------------

loc_455BA:
		cmpi.w	#$1A00,x_pos(a0)
		blo.s	loc_455CC
		cmpi.w	#$680,y_pos(a0)
		blo.w	loc_45A66

loc_455CC:
		cmpi.b	#$16,(Current_zone).w
		bne.s	loc_455F8
		tst.b	render_flags(a0)
		bpl.s	loc_455EE
		tst.b	$38(a0)
		bne.s	loc_455F8
		move.l	#$40C0408,(Normal_palette_line_4+$2).w
		st	(Palette_cycle_counters+$00).w
		bra.s	loc_455F8
; ---------------------------------------------------------------------------

loc_455EE:
		tst.b	$38(a0)
		bne.s	loc_455F8
		clr.b	(Palette_cycle_counters+$00).w

loc_455F8:
		move.w	$16(a0),d0
		add.w	$1A(a0),d0
		move.w	d0,y_pos(a0)
		jsr	sub_45866(pc)
		tst.b	subtype(a0)
		bne.s	loc_45616
		tst.b	(Events_bg+$04).w
		bne.w	loc_456EE

loc_45616:
		tst.w	$1A(a0)
		bne.s	loc_4562C
		moveq	#$23,d1
		lea	byte_466E8(pc),a2
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTopSloped2).l

loc_4562C:
		lea	(Events_bg+$00).w,a1
		move.b	subtype(a0),d0
		beq.w	loc_456EE
		bpl.s	loc_45660
		add.b	d0,d0
		bpl.s	loc_45640
		addq.w	#2,a1

loc_45640:
		tst.b	(a1)
		bpl.w	loc_456EE
		tst.w	$1A(a0)
		beq.s	loc_45660
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		bne.w	loc_456EE
		subq.w	#1,$1A(a0)
		bra.w	loc_456EE
; ---------------------------------------------------------------------------

loc_45660:
		btst	#p1_standing_bit,status(a0)
		beq.w	loc_456EE
		lea	(Player_1).w,a2
		move.w	x_pos(a2),d0
		sub.w	x_pos(a0),d0
		addi.w	#$C,d0
		cmpi.w	#$18,d0
		bhs.s	loc_456EE
		tst.b	object_control(a2)
		bne.w	loc_456EE
		cmpi.b	#4,routine(a2)
		bhs.w	loc_456EE
		tst.w	(Debug_placement_mode).w
		bne.w	loc_456EE
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_456EE
		move.w	a1,$3C(a0)
		move.l	#Obj_TeleporterBeam,(a1)
		move.w	a0,parent2(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		clr.w	x_vel(a2)
		clr.w	ground_vel(a2)
		move.w	#-1,y_vel(a2)
		clr.b	spin_dash_flag(a2)
		move.b	#1,object_control(a2)
		move.b	#5,anim(a2)
		move.l	#loc_456F4,(a0)
		move.w	#-$100,$38(a0)
		moveq	#signextendB(sfx_Charging),d0
		jsr	(Play_SFX).l

loc_456EE:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_456F4:
		jsr	sub_45856(pc)
		lea	(Player_1).w,a1
		movea.w	$3C(a0),a2
		cmpi.b	#8,$46(a2)
		blt.w	loc_457B8
		beq.w	loc_457A2
		cmpi.b	#$18,$46(a2)
		bhs.s	loc_45744
		btst	#0,(Level_frame_counter+1).w
		beq.w	loc_457B8
		subq.w	#1,y_pos(a1)
		btst	#1,(Level_frame_counter+1).w
		beq.w	loc_457B8
		moveq	#1,d1
		move.w	x_pos(a1),d0
		cmp.w	x_pos(a0),d0
		beq.s	loc_457B8
		bcs.s	loc_4573E
		neg.w	d1

loc_4573E:
		add.w	d1,x_pos(a1)
		bra.s	loc_457B8
; ---------------------------------------------------------------------------

loc_45744:
		move.l	#loc_457BE,(a0)
		move.b	subtype(a0),d0
		cmpi.b	#$16,(Current_zone).w
		beq.s	loc_4575A
		andi.w	#$3F,d0

loc_4575A:
		move.b	d0,$2D(a0)
		move.b	#3,object_control(a1)
		moveq	#0,d0
		move.b	d0,anim(a1)
		move.b	d0,mapping_frame(a1)
		cmpi.b	#$16,(Current_zone).w
		bne.s	loc_4577E
		move.w	#$AA0,(Camera_min_X_pos).w
		bra.s	loc_45790
; ---------------------------------------------------------------------------

loc_4577E:
		move.w	#-$100,(Camera_min_Y_pos).w
		move.w	#$1000,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w

loc_45790:
		clr.b	(Events_bg+$05).w
		moveq	#signextendB(sfx_Transporter),d0
		jsr	(Play_SFX).l
		st	(Scroll_lock).w
		bra.s	loc_457B8
; ---------------------------------------------------------------------------

loc_457A2:
		bclr	#Status_OnObj,status(a1)
		bset	#Status_Roll,status(a1)
		move.b	#2,anim(a1)
		st	(Events_bg+$04).w

loc_457B8:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_457BE:
		jsr	sub_45856(pc)
		lea	(Player_1).w,a1
		tst.b	$2D(a0)
		bne.s	loc_45804
		move.b	#1,object_control(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		move.w	y_pos(a1),$3E(a0)
		clr.l	$2E(a0)
		clr.l	$32(a0)
		clr.b	$36(a0)
		clr.b	(Scroll_lock).w
		movea.w	$3C(a0),a1
		st	routine(a1)
		move.l	#loc_4581C,(a0)
		rts
; ---------------------------------------------------------------------------

loc_45804:
		subi.w	#$10,y_pos(a1)
		subq.b	#1,$2D(a0)
		beq.s	loc_45816
		subi.w	#$10,(Camera_Y_pos).w

loc_45816:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4581C:
		jsr	sub_45856(pc)
		lea	(Player_1).w,a1
		move.l	#$20000,d0
		move.l	#$800,d1
		jsr	Gradual_SwingOffset(pc)
		add.w	$3E(a0),d0
		move.w	d0,y_pos(a1)
		tst.l	$2E(a0)
		bmi.s	locret_45854
		clr.b	object_control(a1)
		clr.b	anim(a1)
		clr.b	(Events_bg+$04).w
		move.l	#loc_455CC,(a0)

locret_45854:
		rts

; =============== S U B R O U T I N E =======================================


sub_45856:
		moveq	#$23,d1
		lea	byte_466E8(pc),a2
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTopSloped2).l
; End of function sub_45856


; =============== S U B R O U T I N E =======================================


sub_45866:
		tst.b	$39(a0)
		beq.s	loc_45872
		subq.b	#1,$39(a0)
		bra.s	locret_458B2
; ---------------------------------------------------------------------------

loc_45872:
		move.b	#3,$39(a0)
		move.w	$3A(a0),d0
		bne.s	loc_45884
		tst.b	$38(a0)
		beq.s	locret_458B2

loc_45884:
		addq.w	#4,d0
		cmpi.w	#$28,d0
		blo.s	loc_4588E
		moveq	#0,d0

loc_4588E:
		move.w	d0,$3A(a0)
		lea	word_4670C(pc),a1
		cmpi.b	#$A,(Current_zone).w
		bne.s	loc_458A6
		move.l	(a1,d0.w),(Normal_palette_line_3+$18).w
		bra.s	locret_458B2
; ---------------------------------------------------------------------------

loc_458A6:
		move.w	2(a1,d0.w),(Normal_palette_line_4+$2).w
		move.w	(a1,d0.w),(Normal_palette_line_4+$4).w

locret_458B2:
		rts
; End of function sub_45866

; ---------------------------------------------------------------------------

Obj_TeleporterBeam:
		move.l	#Obj_TeleporterBeamSpawn,(a0)
		move.b	#$44,render_flags(a0)		; Multisprite mode
		move.b	#$80,height_pixels(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile($35C,3,1),art_tile(a0)
		move.l	#Map_SSZHPZTeleporter,mappings(a0)
		move.w	#1,mainspr_childsprites(a0)
		move.w	y_pos(a0),$44(a0)
		subi.w	#$88,$44(a0)
		move.b	#$10,$47(a0)	; Wait 16 frames
		cmpi.b	#3,(Current_zone).w
		bne.s	loc_45908
		move.w	#$24EE,art_tile(a0)	; If in CNZ, use this VRAM offset
		bra.s	Obj_TeleporterBeamSpawn
; ---------------------------------------------------------------------------

loc_45908:
		cmpi.b	#$16,(Current_zone).w
		bne.s	Obj_TeleporterBeamSpawn
		move.w	#make_art_tile($52E,3,0),art_tile(a0)	; If in HPZ, use this VRAM offset

Obj_TeleporterBeamSpawn:
		tst.b	$47(a0)
		beq.s	loc_45922
		subq.b	#1,$47(a0)
		bra.s	locret_45990
; ---------------------------------------------------------------------------

loc_45922:
		btst	#0,(Level_frame_counter+1).w
		beq.s	locret_45990		; Do a flickering effect
		lea	sub2_x_pos(a0),a1		; Sprite attribute table to a1
		move.w	y_pos(a0),d0
		move.w	mainspr_childsprites(a0),d1
		subq.w	#1,d1

loc_45938:
		move.w	x_pos(a0),(a1)	; Same X coordinate for all sprites
		move.w	d0,sub2_y_pos-sub2_x_pos(a1)	; Different Y coordinate offset from base
		tst.w	d1
		bne.s	loc_45960
		eori.b	#-1,$46(a0)		; If the last listed sprite
		beq.s	loc_45954
		move.b	#1,sub2_mapframe-sub2_x_pos(a1)	; Use mapping 1 on the first frame
		bra.s	loc_4596C
; ---------------------------------------------------------------------------

loc_45954:
		move.b	#2,sub2_mapframe-sub2_x_pos(a1)	; Mapping 2 on the second frame + add new sprite
		addq.w	#1,mainspr_childsprites(a0)
		bra.s	loc_4596C
; ---------------------------------------------------------------------------

loc_45960:
		move.b	#2,sub2_mapframe-sub2_x_pos(a1)
		subi.w	#$20,d0
		addq.w	#next_subspr,a1

loc_4596C:
		dbf	d1,loc_45938
		cmpi.w	#7,mainspr_childsprites(a0)
		blo.s	loc_4598A
		tst.b	$46(a0)			; When seven sprites have been made, test $46
		bne.s	loc_4598A
		move.l	#Obj_TeleporterBeamWait,(a0)	; When last sprite uses mapping frame 2, go to next phase
		move.b	#$10,$47(a0)

loc_4598A:
		jsr	(Draw_Sprite).l

locret_45990:
		rts
; ---------------------------------------------------------------------------

Obj_TeleporterBeamWait:
		subq.b	#1,$47(a0)
		beq.s	loc_459A8
		btst	#0,(Level_frame_counter+1).w
		beq.s	locret_459A6
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_459A6:
		rts
; ---------------------------------------------------------------------------

loc_459A8:
		move.l	#Obj_TeleporterBeamExpand,(a0)
		move.w	#2,mainspr_childsprites(a0)	; Use two large sprites for the beam

Obj_TeleporterBeamExpand:
		btst	#0,(Level_frame_counter+1).w
		beq.w	locret_45A64
		move.w	$44(a0),d0
		move.w	d0,d1
		sub.w	(Camera_Y_pos).w,d1
		cmpi.w	#$68,d1
		ble.s	loc_459D6
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$68,d0			; Ensure that object base Y is always centered or above the screen

loc_459D6:
		move.w	d0,y_pos(a0)
		move.w	x_pos(a0),d1
		moveq	#0,d2
		move.b	$46(a0),d2		; $46 should be 0 starting out
		move.w	d2,d3
		cmpi.w	#$12,d2			; Maximum of $12
		blo.s	loc_459EE
		moveq	#$12,d2

loc_459EE:
		addq.w	#6,d2
		lsl.w	#3,d3
		lea	word_46734(pc),a1		; Use if in SSZ or HPZ
		cmpi.b	#$A,(Current_zone).w
		beq.s	loc_45A0A
		cmpi.b	#$16,(Current_zone).w
		beq.s	loc_45A0A
		lea	word_467FC(pc),a1		; Use if anywhere else

loc_45A0A:
		adda.w	d3,a1
		lea	sub2_x_pos(a0),a2
		move.w	d1,(a2)
		sub.w	d2,(a2)+
		move.w	(a1)+,(a2)
		add.w	d0,(a2)+
		move.w	(a1)+,(a2)+
		move.w	d1,(a2)
		add.w	d2,(a2)+
		move.w	(a1)+,(a2)
		add.w	d0,(a2)+
		move.w	(a1)+,(a2)+
		tst.b	routine(a0)
		beq.s	loc_45A4A
		subq.b	#1,$46(a0)		; Contract beam
		bpl.s	loc_45A5E		; Branch if beam is still in effect
		move.b	#9,mapping_frame(a0)	; Change main mapping
		clr.w	mainspr_childsprites(a0)		; No more sprites
		move.l	#Delete_Current_Sprite,(a0)		; Delete object
		movea.w	parent2(a0),a1
		clr.b	$38(a1)			; Set flag to parent indicating completion
		bra.s	loc_45A5E
; ---------------------------------------------------------------------------

loc_45A4A:
		btst	#1,(Level_frame_counter+1).w
		beq.s	loc_45A5E
		cmpi.b	#$18,$46(a0)
		bhs.s	loc_45A5E
		addq.b	#1,$46(a0)		; Expand beam

loc_45A5E:
		jsr	(Draw_Sprite).l

locret_45A64:
		rts
; ---------------------------------------------------------------------------

loc_45A66:
		move.l	#loc_45A72,(a0)
		addi.w	#high_priority,art_tile(a0)

loc_45A72:
		tst.w	$32(a0)
		beq.s	loc_45A84
		subq.w	#1,$32(a0)
		bne.s	loc_45AD0
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_45A84:
		tst.w	$2E(a0)
		bne.s	loc_45AB0
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	loc_45AD0
		jsr	(AllocateObject).l
		bne.s	loc_45AAE
		move.l	#Obj_SSZEndBoss,(a1)
		move.w	a1,(_unkFAA4).w
		move.w	a1,$30(a0)
		st	$2E(a0)

loc_45AAE:
		bra.s	loc_45AD0
; ---------------------------------------------------------------------------

loc_45AB0:
		movea.w	$30(a0),a1
		move.w	x_pos(a1),d0
		cmp.w	x_pos(a0),d0
		bhi.s	loc_45AD0
		move.w	#$20,$32(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l

loc_45AD0:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_45AD6:
		jsr	sub_45866(pc)
		tst.b	routine(a0)
		beq.s	loc_45B16
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_45B16
		move.w	a1,$3C(a0)
		move.l	#Obj_TeleporterBeam,(a1)
		move.w	a0,parent2(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.l	#loc_45B1C,(a0)
		move.w	#-$100,$38(a0)
		moveq	#signextendB(sfx_Charging),d0
		jsr	(Play_SFX).l

loc_45B16:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_45B1C:
		jsr	sub_45866(pc)
		movea.w	(_unkFAA4).w,a1
		movea.w	$3C(a0),a2
		cmpi.b	#8,$46(a2)
		blt.w	loc_45B84
		beq.w	loc_45B7E
		cmpi.b	#$18,$46(a2)
		bhs.s	loc_45B6C
		btst	#0,(Level_frame_counter+1).w
		beq.w	loc_45B84
		subq.w	#1,y_pos(a1)
		btst	#1,(Level_frame_counter+1).w
		beq.w	loc_45B84
		moveq	#1,d1
		move.w	x_pos(a1),d0
		cmp.w	x_pos(a0),d0
		beq.s	loc_45B84
		bcs.s	loc_45B66
		neg.w	d1

loc_45B66:
		add.w	d1,x_pos(a1)
		bra.s	loc_45B84
; ---------------------------------------------------------------------------

loc_45B6C:
		clr.l	(a1)
		moveq	#signextendB(sfx_Transporter),d0
		jsr	(Play_SFX).l
		move.l	#loc_45B8A,(a0)
		bra.s	loc_45B84
; ---------------------------------------------------------------------------

loc_45B7E:
		bset	#7,(_unkFAB8).w

loc_45B84:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_45B8A:
		jsr	sub_45866(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_45B94:
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_45BC8
		cmpi.w	#$240,(Camera_Y_pos).w
		bhs.s	locret_45BF2
		cmpi.w	#$B00,(Player_1+x_pos).w
		blo.s	locret_45BF2
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		st	(SRAM_mask_interrupts_flag).w
		jsr	(SaveGame).l
		move.w	#$A01,d0
		jmp	(StartNewLevel).l
; ---------------------------------------------------------------------------

loc_45BC8:
		movea.w	$2E(a0),a1
		cmpi.w	#$1000,x_pos(a1)
		bhs.s	loc_45BDA
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_45BDA:
		move.l	#$40C0408,(Normal_palette_line_4+$2).w
		st	(Palette_cycle_counters+$00).w
		move.l	#loc_45AD6,(a1)
		move.l	#loc_45BF4,(a0)

locret_45BF2:
		rts
; ---------------------------------------------------------------------------

loc_45BF4:
		move.w	#$1600,d0
		cmp.w	(Camera_X_pos).w,d0
		blo.s	loc_45C0C
		cmp.w	(Camera_max_X_pos).w,d0
		beq.s	loc_45C0C
		move.w	d0,(Camera_max_X_pos).w
		clr.w	(Camera_min_Y_pos).w

loc_45C0C:
		lea	(Player_1).w,a1
		lea	(Ctrl_1_logical).w,a2
		lea	(Ctrl_1_locked).w,a3
		lea	$30(a0),a4
		lea	1(a4),a5
		moveq	#0,d6
		bsr.s	sub_45C8E
		tst.w	(Player_mode).w
		bne.s	loc_45C42
		lea	(Player_2).w,a1
		lea	(Ctrl_2_logical).w,a2
		lea	(Ctrl_2_locked).w,a3
		lea	$31(a0),a4
		lea	-1(a4),a5
		moveq	#1,d6
		bsr.s	sub_45C8E

loc_45C42:
		move.b	subtype(a0),d0
		beq.s	loc_45C72
		subq.b	#1,d0
		bne.s	loc_45C60
		subq.b	#1,$2D(a0)
		bne.s	loc_45C72
		bset	#6,(_unkFAB8).w
		move.w	#(2<<8)|60,subtype(a0)
		bra.s	loc_45C72
; ---------------------------------------------------------------------------

loc_45C60:
		subq.b	#1,$2D(a0)
		bne.s	loc_45C72
		movea.w	$2E(a0),a1
		st	routine(a1)
		clr.w	subtype(a0)

loc_45C72:
		tst.b	routine(a0)
		beq.s	locret_45C8C
		subq.w	#1,(Camera_X_pos).w
		btst	#0,routine(a0)
		beq.s	loc_45C88
		subq.w	#1,(Camera_Y_pos).w

loc_45C88:
		subq.b	#1,routine(a0)

locret_45C8C:
		rts

; =============== S U B R O U T I N E =======================================


sub_45C8E:
		move.b	(a4),d0
		bmi.w	locret_45DAC
		bne.s	loc_45CC0
		move.w	#$1628,d0
		tst.w	d6
		beq.s	loc_45CA2
		addi.w	#$10,d0

loc_45CA2:
		cmp.w	x_pos(a1),d0
		blo.w	locret_45DAC
		move.w	d0,x_pos(a1)
		clr.w	x_vel(a1)
		clr.w	ground_vel(a1)
		clr.w	(a2)
		st	(a3)
		addq.b	#1,(a4)
		bra.w	locret_45DAC
; ---------------------------------------------------------------------------

loc_45CC0:
		subq.b	#1,d0
		bne.s	loc_45CE4
		btst	#1,$2A(a1)
		bne.w	locret_45DAC
		move.b	#-$60,2(a4)
		tst.w	d6
		beq.s	loc_45CDE
		move.b	#-$24,2(a4)

loc_45CDE:
		addq.b	#1,(a4)
		bra.w	locret_45DAC
; ---------------------------------------------------------------------------

loc_45CE4:
		subq.b	#1,d0
		bne.s	loc_45D0C
		tst.w	(Player_mode).w
		bne.s	loc_45CF6
		tst.b	2(a5)
		beq.w	locret_45DAC

loc_45CF6:
		move.w	#(1<<8)|60,subtype(a0)
		move.b	#$48,routine(a0)
		st	(Scroll_lock).w
		addq.b	#1,(a4)
		bra.w	locret_45DAC
; ---------------------------------------------------------------------------

loc_45D0C:
		subq.b	#1,d0
		bne.s	loc_45D2E
		tst.w	subtype(a0)
		bne.w	locret_45DAC
		subq.b	#1,2(a4)
		bne.w	locret_45DAC
		move.w	#-$100,x_vel(a1)
		move.w	#$2424,(a2)
		addq.b	#1,(a4)
		bra.s	locret_45DAC
; ---------------------------------------------------------------------------

loc_45D2E:
		subq.b	#1,d0
		bne.s	loc_45D8A
		move.w	#$15C0,d0
		cmp.w	x_pos(a1),d0
		blo.s	loc_45D84
		move.w	d0,x_pos(a1)
		subi.w	#$80,y_pos(a1)
		clr.w	x_vel(a1)
		clr.w	ground_vel(a1)
		move.b	#3,$2E(a1)
		clr.b	anim(a1)
		clr.b	mapping_frame(a1)
		clr.w	(a2)
		moveq	#signextendB(sfx_Transporter),d0
		jsr	(Play_SFX).l
		tst.w	d6
		beq.s	loc_45D6E
		st	(a4)
		rts
; ---------------------------------------------------------------------------

loc_45D6E:
		move.b	#60,2(a4)
		tst.w	(Player_mode).w
		bne.s	loc_45D80
		move.b	#2*60,2(a4)

loc_45D80:
		addq.b	#1,(a4)
		bra.s	locret_45DAC
; ---------------------------------------------------------------------------

loc_45D84:
		move.w	#$2404,(a2)
		bra.s	locret_45DAC
; ---------------------------------------------------------------------------

loc_45D8A:
		subq.b	#1,2(a4)
		bne.s	locret_45DAC
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		st	(SRAM_mask_interrupts_flag).w
		jsr	(SaveGame).l
		move.w	#$A00,d0
		jmp	(StartNewLevel).l
; ---------------------------------------------------------------------------

locret_45DAC:
		rts
; End of function sub_45C8E

; ---------------------------------------------------------------------------

Obj_SSZRotatingPlatform:
		move.l	#loc_45DFE,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$20,height_pixels(a0)
		move.b	#$C,width_pixels(a0)
		move.w	#$100,priority(a0)
		move.w	#make_art_tile($37E,2,0),art_tile(a0)
		move.l	#Map_SSZRotatingPlatform,mappings(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_45DFE
		move.w	a1,$32(a0)
		move.l	#loc_45F10,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	subtype(a0),subtype(a1)

loc_45DFE:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bls.s	loc_45E2E
		move.w	$32(a0),d0
		beq.s	loc_45E1C
		movea.w	d0,a1
		st	routine(a1)

loc_45E1C:
		move.w	respawn_addr(a0),d0
		beq.s	loc_45E28
		movea.w	d0,a1
		bclr	#7,(a1)

loc_45E28:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_45E2E:
		lea	Ani_SSZRotatingPlatform(pc),a1
		jsr	(Animate_Sprite).l
		moveq	#$10,d1
		moveq	#$21,d2
		moveq	#$21,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		lea	(Player_1).w,a1
		lea	(Ctrl_1_logical).w,a2
		lea	$2E(a0),a3
		moveq	#p1_standing_bit,d6
		bsr.s	sub_45E6E
		lea	(Player_2).w,a1
		lea	(Ctrl_2_logical).w,a2
		lea	$30(a0),a3
		moveq	#p2_standing_bit,d6
		bsr.s	sub_45E6E
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_45E6E:
		tst.b	(a3)
		bne.s	loc_45E82
		btst	d6,status(a0)
		beq.w	locret_45F0E
		move.w	#$100,(a3)
		bra.w	locret_45F0E
; ---------------------------------------------------------------------------

loc_45E82:
		tst.b	(a3)
		bmi.s	loc_45E90
		btst	d6,status(a0)
		bne.s	loc_45E90
		clr.b	(a3)
		bra.s	locret_45F0E
; ---------------------------------------------------------------------------

loc_45E90:
		st	(a3)
		clr.w	x_vel(a1)
		clr.w	ground_vel(a1)
		clr.b	$3D(a1)
		clr.b	anim(a1)
		bclr	#Status_Roll,status(a1)
		move.b	#3,object_control(a1)
		move.w	(a2),d0
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	loc_45EEE
		clr.b	(a3)
		move.w	#-$680,y_vel(a1)
		clr.b	object_control(a1)
		bset	#Status_Roll,status(a1)
		bset	#Status_InAir,status(a1)
		move.b	#1,jumping(a1)
		move.b	#2,anim(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		moveq	#signextendB(sfx_Jump),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

loc_45EEE:
		moveq	#1,d1
		move.w	x_pos(a1),d0
		cmp.w	x_pos(a0),d0
		beq.s	loc_45F02
		bmi.s	loc_45EFE
		neg.w	d1

loc_45EFE:
		add.w	d1,x_pos(a1)

loc_45F02:
		addq.b	#2,1(a3)
		move.b	1(a3),d0
		jmp	loc_460A6(pc)
; ---------------------------------------------------------------------------

locret_45F0E:
		rts
; ---------------------------------------------------------------------------

loc_45F10:
		move.l	#loc_45F2E,(a0)
		addi.w	#$30,y_pos(a0)
		moveq	#$60,d0
		btst	#0,subtype(a0)
		beq.s	loc_45F2A
		move.w	#$A0,d0

loc_45F2A:
		move.b	d0,width_pixels(a0)

loc_45F2E:
		tst.b	routine(a0)
		beq.s	loc_45F3A
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_45F3A:
		moveq	#$B,d1
		add.b	width_pixels(a0),d1
		moveq	#$11,d2
		moveq	#$11,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		lea	(Player_1).w,a1
		lea	(Ctrl_1_logical).w,a2
		lea	$2E(a0),a3
		lea	$34(a0),a4
		moveq	#p1_standing_bit,d6
		bsr.s	loc_45F74
		lea	(Player_2).w,a1
		lea	(Ctrl_2_logical).w,a2
		lea	$34(a0),a3
		lea	$2E(a0),a4
		moveq	#p2_standing_bit,d6

loc_45F74:
		tst.b	(a3)
		bne.s	loc_45FD6
		btst	d6,status(a0)
		bne.s	loc_45FB8
		tst.b	1(a3)
		beq.s	locret_45FB6
		move.w	y_pos(a0),d0
		subi.w	#$64,d0
		cmp.w	y_pos(a1),d0
		bhs.s	loc_45FAC
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		add.w	d1,d0
		add.w	d1,d1
		cmp.w	d1,d0
		blo.s	locret_45FB6

loc_45FAC:
		clr.b	1(a3)
		move.w	#$100,priority(a1)

locret_45FB6:
		rts
; ---------------------------------------------------------------------------

loc_45FB8:
		move.w	#$1FF,(a3)
		moveq	#0,d1
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		bpl.s	loc_45FCC
		neg.w	d0
		moveq	#-$80,d1

loc_45FCC:
		move.w	d0,4(a3)
		move.b	d1,2(a3)
		rts
; ---------------------------------------------------------------------------

loc_45FD6:
		tst.b	(a3)
		bmi.s	loc_45FE4
		btst	d6,status(a0)
		bne.s	loc_45FE4
		clr.b	(a3)
		rts
; ---------------------------------------------------------------------------

loc_45FE4:
		st	(a3)
		clr.w	x_vel(a1)
		clr.w	ground_vel(a1)
		clr.b	spin_dash_flag(a1)
		clr.b	anim(a1)
		bclr	#Status_Roll,status(a1)
		move.b	#3,object_control(a1)
		move.w	(a2),d0
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	loc_46042
		clr.b	(a3)
		move.w	#-$680,y_vel(a1)
		clr.b	object_control(a1)
		bset	#Status_Roll,status(a1)
		bset	#Status_InAir,status(a1)
		move.b	#1,jumping(a1)
		move.b	#2,anim(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		moveq	#signextendB(sfx_Jump),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

loc_46042:
		addq.b	#2,2(a3)
		cmpi.w	#$14,4(a3)
		bhs.s	loc_46052
		addq.w	#1,4(a3)

loc_46052:
		move.b	2(a3),d0
		cmpi.b	#$80,d0
		blo.s	loc_46074
		move.w	#$180,d1
		tst.b	(a4)
		beq.s	loc_4608A
		move.w	4(a4),d2
		cmp.w	4(a3),d2
		bhs.s	loc_4608A
		move.w	#$200,d1
		bra.s	loc_4608A
; ---------------------------------------------------------------------------

loc_46074:
		move.w	#$100,d1
		tst.b	(a4)
		beq.s	loc_4608A
		move.w	4(a4),d2
		cmp.w	4(a3),d2
		bhs.s	loc_4608A
		move.w	#$80,d1

loc_4608A:
		move.w	d1,priority(a1)
		jsr	(GetSineCosine).l
		muls.w	4(a3),d1
		asr.l	#8,d1
		add.w	x_pos(a0),d1
		move.w	d1,x_pos(a1)
		move.b	2(a3),d0

loc_460A6:
		addi.w	#$A,d0
		andi.w	#$FF,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lsr.w	#5,d0
		andi.w	#$FFFE,d0
		lea	byte_468C4(pc),a2
		adda.w	d0,a2
		move.b	(a2)+,d0
		andi.b	#$FC,render_flags(a1)
		or.b	d0,render_flags(a1)
		move.b	(a2),d0
		move.b	d0,mapping_frame(a1)
		jmp	(Perform_Player_DPLC).l
; End of function sub_45E6E

; ---------------------------------------------------------------------------

Obj_SSZSwingingCarrier:
		move.l	#loc_46142,(a0)
		move.b	#4,render_flags(a0)
		move.b	#8,height_pixels(a0)
		move.w	#$180,priority(a0)
		move.w	#make_art_tile($348,2,0),art_tile(a0)
		move.l	#Map_SSZElevatorBar,mappings(a0)
		moveq	#$30,d0
		moveq	#1,d1
		tst.b	subtype(a0)
		bpl.s	loc_4610C
		moveq	#8,d0
		moveq	#4,d1

loc_4610C:
		move.b	d0,width_pixels(a0)
		move.b	d1,mapping_frame(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_46142
		move.w	a1,$38(a0)
		move.l	#loc_461A8,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	status(a0),status(a1)
		move.b	subtype(a0),subtype(a1)
		move.w	a0,parent2(a1)

loc_46142:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bls.s	loc_46172
		move.w	$38(a0),d0
		beq.s	loc_46160
		movea.w	d0,a1
		st	routine(a1)

loc_46160:
		move.w	respawn_addr(a0),d0
		beq.s	loc_4616C
		movea.w	d0,a1
		bclr	#7,(a1)

loc_4616C:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_46172:
		tst.b	subtype(a0)
		bmi.s	loc_46192
		move.l	#$20000,d0
		move.l	#$821,d1
		jsr	Gradual_SwingOffset(pc)
		addi.w	#$41,d0
		move.w	d0,$20(a0)
		bra.s	loc_461A2
; ---------------------------------------------------------------------------

loc_46192:
		moveq	#1,d0
		btst	#0,status(a0)
		beq.s	loc_4619E
		neg.w	d0

loc_4619E:
		add.w	d0,$20(a0)

loc_461A2:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_461A8:
		move.l	#loc_461FE,(a0)
		move.b	#$44,render_flags(a0)
		move.b	#$68,height_pixels(a0)
		move.b	#$68,width_pixels(a0)
		move.w	#make_art_tile($348,3,0),art_tile(a0)
		move.l	#Map_SSZElevatorBar,mappings(a0)
		move.b	subtype(a0),d0
		andi.w	#3,d0
		addq.w	#6,d0
		move.w	d0,mainspr_childsprites(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_461FE
		move.w	a1,$12(a0)
		move.l	#loc_46284,(a1)
		move.b	status(a0),status(a1)
		move.b	subtype(a0),subtype(a1)
		move.w	a0,$2E(a1)

loc_461FE:
		tst.b	routine(a0)
		beq.s	loc_46216
		move.w	$12(a0),d0
		beq.s	loc_46210
		movea.w	d0,a1
		st	routine(a1)

loc_46210:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_46216:
		movea.w	parent2(a0),a1
		move.w	#$180,d1
		move.w	$20(a1),d0
		subi.w	#$40,d0
		andi.w	#$FF,d0
		cmpi.w	#$80,d0
		blo.s	loc_46234
		move.w	#$100,d1

loc_46234:
		move.w	d1,priority(a0)
		move.w	$20(a1),d0
		jsr	(GetSineCosine).l
		swap	d1
		clr.w	d1
		asr.l	#4,d1
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	x_pos(a0),d3
		move.l	y_pos(a0),d2
		clr.w	d2
		move.w	mainspr_childsprites(a0),d4
		subq.w	#1,d4
		lea	sub2_x_pos(a0),a1

loc_46262:
		add.l	d1,d3
		add.l	d0,d2
		swap	d3
		swap	d2
		move.w	d3,(a1)+
		move.w	d2,(a1)+
		move.b	#2,1(a1)
		swap	d3
		swap	d2
		addq.w	#2,a1
		dbf	d4,loc_46262
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_46284:
		move.l	#loc_462B6,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$C,height_pixels(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile($348,3,0),art_tile(a0)
		move.l	#Map_SSZElevatorBar,mappings(a0)
		move.b	#3,mapping_frame(a0)

loc_462B6:
		tst.b	routine(a0)
		beq.s	loc_462C2
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_462C2:
		movea.w	$2E(a0),a1
		move.w	mainspr_childsprites(a1),d0
		subq.w	#1,d0
		add.w	d0,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		move.w	sub2_x_pos(a1,d0.w),x_pos(a0)
		move.w	sub2_y_pos(a1,d0.w),d0
		addi.w	#$C,d0
		move.w	d0,y_pos(a0)
		moveq	#$23,d1
		moveq	#8,d2
		moveq	#8,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		swap	d6
		move.w	d6,-(sp)
		lea	(Player_1).w,a1
		lea	(Ctrl_1_logical).w,a2
		lea	$30(a0),a3
		moveq	#p1_standing_bit,d5
		bsr.s	sub_46324
		move.w	(sp)+,d6
		lsr.w	#1,d6
		lea	(Player_2).w,a1
		lea	(Ctrl_2_logical).w,a2
		lea	$32(a0),a3
		moveq	#p2_standing_bit,d5
		bsr.s	sub_46324
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_46324:
		tst.b	(a3)
		bne.s	loc_4639A
		tst.b	object_control(a1)
		bne.s	locret_46348
		cmpi.b	#4,routine(a1)
		bhs.s	locret_46348
		btst	d5,status(a0)
		bne.s	loc_4634A
		andi.w	#5,d6
		beq.s	locret_46348
		jsr	(sub_24280).l

locret_46348:
		rts
; ---------------------------------------------------------------------------

loc_4634A:
		moveq	#signextendB(sfx_Roll),d0
		jsr	(Play_SFX).l
		st	(a3)
		move.b	#1,object_control(a1)
		clr.w	y_vel(a1)
		clr.w	x_vel(a1)
		clr.w	ground_vel(a1)
		clr.b	spin_dash_flag(a1)
		bset	#Status_Roll,status(a1)
		move.b	#2,anim(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		tst.b	subtype(a0)
		bpl.s	loc_4639A
		move.b	status(a0),d0
		andi.w	#1,d0
		andi.b	#$FE,status(a1)
		or.b	d0,status(a1)

loc_4639A:
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),d0
		subi.w	#$C,d0
		move.w	d0,y_pos(a1)
		tst.b	subtype(a0)
		bpl.s	loc_463FC
		movem.l	d5/a1-a3,-(sp)
		jsr	(SonicOnObjHitFloor).l
		movem.l	(sp)+,d5/a1-a3
		tst.w	d1
		bpl.s	loc_463FC
		add.w	d1,y_pos(a1)
		cmpi.w	#-$10,d1
		bgt.s	loc_463FC
		clr.b	(a3)
		bclr	d5,status(a0)
		clr.b	object_control(a1)
		bclr	#Status_OnObj,status(a1)
		move.w	#$800,d0
		btst	#0,status(a0)
		beq.s	loc_463EC
		neg.w	d0

loc_463EC:
		move.w	d0,x_vel(a1)
		move.w	d0,ground_vel(a1)
		moveq	#signextendB(sfx_Dash),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

loc_463FC:
		move.w	(a2),d0
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	locret_46424
		clr.b	(a3)
		move.w	#-$680,y_vel(a1)
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		move.b	#1,jumping(a1)
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l

locret_46424:
		rts
; End of function sub_46324

; ---------------------------------------------------------------------------

Obj_SSZRetractingSpring:
		move.l	#loc_46452,(a0)
		bset	#2,render_flags(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#$180,priority(a0)
		move.w	#make_art_tile($3A2,0,0),art_tile(a0)
		move.l	#Map_SSZRetractingSpring,mappings(a0)

loc_46452:
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc_464C6
		moveq	#0,d0
		move.w	y_pos(a0),d2
		addi.w	#$10,d2
		move.w	d2,d1
		subi.w	#$60,d1
		move.w	x_pos(a0),d3
		move.w	d3,d4
		subi.w	#$60,d3
		btst	#0,status(a0)
		beq.s	loc_46482
		addi.w	#2*$60,d3
		exg	d3,d4

loc_46482:
		lea	(Player_1).w,a1
		jsr	sub_46514(pc)
		lea	(Player_2).w,a1
		jsr	sub_46514(pc)
		move.b	mapping_frame(a0),d1
		tst.w	d0
		bne.s	loc_464AE
		tst.b	d1
		beq.s	loc_464C2
		clr.l	$2E(a0)
		subq.b	#1,d1
		cmpi.b	#3,d1
		blo.s	loc_464C2
		moveq	#2,d1
		bra.s	loc_464C2
; ---------------------------------------------------------------------------

loc_464AE:
		cmpi.b	#3,d1
		bhs.s	loc_464C2
		tst.b	d1
		bne.s	loc_464C0
		moveq	#signextendB(sfx_SpringLatch),d0
		jsr	(Play_SFX).l

loc_464C0:
		addq.b	#1,d1

loc_464C2:
		move.b	d1,mapping_frame(a0)

loc_464C6:
		move.w	x_pos(a0),$12(a0)
		cmpi.b	#2,mapping_frame(a0)
		bhs.s	loc_464DA
		move.w	#$7FFF,x_pos(a0)

loc_464DA:
		moveq	#$23,d1
		moveq	#$10,d2
		lea	byte_468DC(pc),a2
		move.w	x_pos(a0),d4
		jsr	(sub_1DD0E).l
		move.w	$12(a0),x_pos(a0)
		swap	d6
		move.w	d6,-(sp)
		lea	(Player_1).w,a1
		lea	$2E(a0),a2
		bsr.s	sub_46536
		move.w	(sp)+,d6
		lsr.w	#1,d6
		lea	(Player_2).w,a1
		lea	$30(a0),a2
		bsr.s	sub_46536
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_46514:
		tst.b	object_control(a1)
		bne.s	locret_46534
		cmp.w	y_pos(a1),d1
		bhi.s	locret_46534
		cmp.w	y_pos(a1),d2
		blo.s	locret_46534
		cmp.w	x_pos(a1),d3
		bhi.s	locret_46534
		cmp.w	x_pos(a1),d4
		blo.s	locret_46534
		addq.w	#1,d0

locret_46534:
		rts
; End of function sub_46514


; =============== S U B R O U T I N E =======================================


sub_46536:
		move.b	(a2),d0
		bne.s	loc_4656E
		lsr.w	#1,d6
		bcc.w	locret_465D4
		moveq	#8,d1
		move.w	x_pos(a1),d2
		sub.w	x_pos(a0),d2
		bmi.s	loc_46556
		btst	#0,status(a0)
		bne.s	loc_46560
		bra.s	locret_465D4
; ---------------------------------------------------------------------------

loc_46556:
		btst	#0,status(a0)
		bne.s	locret_465D4
		neg.w	d1

loc_46560:
		sub.w	d1,x_pos(a1)
		move.b	#4,mapping_frame(a0)
		addq.b	#1,(a2)
		bra.s	locret_465D4
; ---------------------------------------------------------------------------

loc_4656E:
		subq.b	#1,d0
		bne.s	loc_465B2
		move.w	#$C00,d1
		move.b	status(a0),d2
		andi.w	#1,d2
		eori.w	#1,d2
		beq.s	loc_46586
		neg.w	d1

loc_46586:
		move.w	d1,ground_vel(a1)
		move.w	d1,x_vel(a1)
		andi.b	#$FE,status(a1)
		or.b	d2,status(a1)
		andi.b	#$FE,render_flags(a1)
		or.b	d2,render_flags(a1)
		move.b	#3,mapping_frame(a0)
		addq.b	#1,(a2)
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

loc_465B2:
		subq.b	#1,d0
		bne.s	loc_465C6
		move.b	#5,mapping_frame(a0)
		move.b	#8,1(a2)
		addq.b	#1,(a2)
		bra.s	locret_465D4
; ---------------------------------------------------------------------------

loc_465C6:
		subq.b	#1,1(a2)
		bne.s	locret_465D4
		move.b	#3,mapping_frame(a0)
		clr.w	(a2)

locret_465D4:
		rts
; End of function sub_46536


; =============== S U B R O U T I N E =======================================


Gradual_SwingOffset:
		move.l	$2E(a0),d2
		tst.b	$36(a0)
		beq.s	loc_465F6
		neg.l	d1
		add.l	d2,$32(a0)		; Moving up and then down. Reset speed/direction when center point is reached going down
		bmi.s	loc_4660E
		move.l	d0,$2E(a0)		; Reset initial speed (positive) to move downwards
		clr.l	$32(a0)
		clr.b	$36(a0)
		bra.s	loc_46612
; ---------------------------------------------------------------------------

loc_465F6:
		add.l	d2,$32(a0)		; Moving down and then up. Reset speed/direction when center point is reached going up
		bmi.s	loc_465FE
		bne.s	loc_4660E

loc_465FE:
		neg.l	d0			; Reverse direction to move upwards when speed has reached
		move.l	d0,$2E(a0)	; Reset initial speed (negative)
		clr.l	$32(a0)
		st	$36(a0)
		bra.s	loc_46612
; ---------------------------------------------------------------------------

loc_4660E:
		sub.l	d1,$2E(a0)	; Apply speed

loc_46612:
		move.w	$32(a0),d0	; Get final offset for us by calling object
		rts
; End of function Gradual_SwingOffset

; ---------------------------------------------------------------------------
word_46618:
		dc.w     -8,  -$18,   $32,     3
		dc.w      8,  -$18,   $31,     4
		dc.w     -8,    -8,   $29,     3
		dc.w      8,    -8,   $2E,     4
		dc.w     -8,     8,   $22,     3
		dc.w      8,     8,   $19,     4
		dc.w     -8,   $18,     1,     5
		dc.w      8,   $18,    $E,     6
byte_46658:
		dc.b   -6,  -6
		dc.b   -5,  -5
		dc.b   -4,  -4
		dc.b   -3,  -3
		dc.b   -2,  -2
		dc.b   -1,  -1
		dc.b    0,   0
		dc.b    1,   1
		dc.b    2,   2
		dc.b    3,   3
		dc.b    4,   4
		dc.b    5,   5
		dc.b    6,   6
		dc.b    7,   7
		dc.b    8,   8
		dc.b    9,   9
		dc.b   $A,  $A
		dc.b   $B,  $B
		dc.b   $C,  $C
		dc.b   $D,  $D
		dc.b   $E,  $E
		dc.b   $F,  $F
		dc.b  $10, $10
		dc.b  $11, $11
		dc.b  $12, $12
		dc.b  $13, $13
		dc.b  $14, $14
		dc.b  $15, $15
		dc.b  $16, $16
		dc.b  $17, $17
		dc.b  $18, $18
		dc.b  $19, $19
byte_46698:
		dc.b    0
		dc.b   $A
		dc.b  $12
		dc.b  $16
		dc.b  $17
		dc.b  $16
		dc.b  $12
byte_4669F:
		dc.b   $A
byte_466A0:
		dc.b    0,  -1,  -1,   0,   1,   2,   2,   1
		dc.b    0,  -3,  -4,  -4,  -3,   0,   4,   6
		dc.b    6,   4,   0,  -5,  -8,  -9,  -8,  -5
		dc.b    0,   6,  $A,  $C,  $C,  $A,   6,   0
		dc.b   -7, -$C, -$F,-$10, -$F, -$C,  -7,   0
		even
word_466C8:
		dc.w    -$C
		dc.w   -$10
		dc.w  -$2C0
		dc.w  -$400
		dc.w     $C
		dc.w   -$10
		dc.w   $2C0
		dc.w  -$400
		dc.w   -$10
		dc.w    -$C
		dc.w  -$500
		dc.w  -$200
		dc.w    $10
		dc.w    -$C
		dc.w   $500
		dc.w  -$200
byte_466E8:
		dc.b    9,   9,   9,   9,   9,   9,   9,   9,   9,   9,   9,   9,  $B,  $D,  $F, $11, $11, $11, $11, $11
		dc.b  $11,  $F,  $D,  $B,   9,   9,   9,   9,   9,   9,   9,   9,   9,   9,   9,   9
		even
word_4670C:
		dc.w   $408,  $40C
		dc.w   $60A,  $60C
		dc.w   $80C,  $80E
		dc.w   $A0E,  $C0E
		dc.w   $C0E,  $E0E
		dc.w   $E0E,  $E0E
		dc.w   $C0E,  $E0E
		dc.w   $A0E,  $C0E
		dc.w   $80C,  $80E
		dc.w   $60A,  $60C
word_46734:
		dc.w     -6,     3,    -6,     4
		dc.w     -6,     3,    -6,     4
		dc.w     -5,     3,    -5,     4
		dc.w     -4,     3,    -4,     6
		dc.w     -2,     3,    -2,     6
		dc.w      0,     3,     0,     6
		dc.w      0,     3,     0,     6
		dc.w      0,     5,     0,     6
		dc.w      0,     5,     0,     6
		dc.w      0,     5,     0,     6
		dc.w      0,     5,     0,     6
		dc.w      0,     5,     0,     8
		dc.w      0,     5,     0,     8
		dc.w      0,     5,     0,     8
		dc.w      0,     5,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
word_467FC:
		dc.w      0,     3,     0,     4
		dc.w      0,     3,     0,     4
		dc.w      0,     3,     0,     4
		dc.w      0,     3,     0,     6
		dc.w      0,     3,     0,     6
		dc.w      0,     3,     0,     6
		dc.w      0,     3,     0,     6
		dc.w      0,     5,     0,     6
		dc.w      0,     5,     0,     6
		dc.w      0,     5,     0,     6
		dc.w      0,     5,     0,     6
		dc.w      0,     5,     0,     8
		dc.w      0,     5,     0,     8
		dc.w      0,     5,     0,     8
		dc.w      0,     5,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
		dc.w      0,     7,     0,     8
byte_468C4:
		dc.b    1, $55
		dc.b    0, $59
		dc.b    0, $5A
		dc.b    0, $5B
		dc.b    1, $5A
		dc.b    1, $59
		dc.b    0, $55
		dc.b    0, $56
		dc.b    0, $57
		dc.b    0, $58
		dc.b    1, $57
		dc.b    1, $56
byte_468DC:
		dc.b  $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $10, $10,  $F
		dc.b   $E,  $D,  $C,  $B,   9,   7,   5,   2,  -1,  -5, -$C, -$C, -$C, -$C, -$C, -$C
		even
Map_SSZFloatingPlatform:
		include "Levels/SSZ/Misc Object Data/Map - Floating Platform.asm"
Map_SSZCollapsingBridge:
		include "Levels/SSZ/Misc Object Data/Map - Collapsing Bridge.asm"
Map_SSZBouncyCloud:
		include "Levels/SSZ/Misc Object Data/Map - Bouncy Cloud.asm"
Ani_SSZBouncyCloud:
		include "Levels/SSZ/Misc Object Data/Anim - Bouncy Cloud.asm"
Map_SSZElevatorBar:
		include "Levels/SSZ/Misc Object Data/Map - Elevator Bar.asm"
Map_SSZHPZTeleporter:
		include "General/Sprites/Teleporter/Map - Teleporter.asm"
Map_SSZRotatingPlatform:
		include "Levels/SSZ/Misc Object Data/Map - Rotating Platform.asm"
Ani_SSZRotatingPlatform:
		include "Levels/SSZ/Misc Object Data/Anim - Rotating Platform.asm"
Map_SSZRetractingSpring:
		include "Levels/SSZ/Misc Object Data/Map - Retracting Spring.asm"
; ---------------------------------------------------------------------------
