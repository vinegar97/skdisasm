Obj_SOZMiniboss:
		move.l	#Obj_Wait,(a0)
		move.w	#$439D,x_pos(a0)
		move.w	#$9F7,y_pos(a0)
		lea	(Pal_SOZMinibossFade).l,a1
		lea	(Normal_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

- ;loc_76A30:
		move.l	(a1)+,(a2)+
		dbf	d6,- ;loc_76A30
		lea	(Pal_SOZMinibossMain).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

- ;loc_76A42:
		move.l	(a1)+,(a2)+
		dbf	d6,- ;loc_76A42
		move.l	#loc_76A8A,$34(a0)
		move.w	#2*60,$2E(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		lea	(ArtKosM_SOZMiniboss).l,a1
		move.w	#tiles_to_bytes($3B5),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_SOZSand).l,a1
		move.w	#tiles_to_bytes($4F3),d2
		jsr	(Queue_Kos_Module).l
		lea	(PLC_BossExplosion).l,a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

loc_76A8A:
		move.l	#loc_76A92,(a0)
		rts
; ---------------------------------------------------------------------------

loc_76A92:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_76AAE(pc,d0.w),d1
		jsr	off_76AAE(pc,d1.w)
		bsr.w	sub_772F6
		bsr.w	sub_770EA
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_76AAE:
		dc.w loc_76AC8-off_76AAE
		dc.w loc_76B2A-off_76AAE
		dc.w loc_76B44-off_76AAE
		dc.w loc_76B80-off_76AAE
		dc.w loc_76BAA-off_76AAE
		dc.w loc_76BF4-off_76AAE
		dc.w loc_76C36-off_76AAE
		dc.w loc_76CCE-off_76AAE
		dc.w loc_76D08-off_76AAE
		dc.w loc_76D28-off_76AAE
		dc.w loc_76D7C-off_76AAE
		dc.w loc_76DB0-off_76AAE
		dc.w locret_76E08-off_76AAE
; ---------------------------------------------------------------------------

loc_76AC8:
		lea	ObjDat_SOZMiniboss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.w	priority(a0),$3C(a0)
		move.b	#$3B,y_radius(a0)
		move.l	#loc_76B30,$34(a0)
		moveq	#signextendB(mus_Miniboss),d0
		jsr	(Play_Music).l
		move.b	#mus_Miniboss,(Current_music+1).w
		move.w	#$3F,$2E(a0)
		move.l	#loc_76B30,$34(a0)
		jsr	(AllocateObject).l
		bne.s	locret_76B28
		move.l	#Obj_FadeSelectedFromBlack,(a1)
		move.w	#3,$3A(a1)
		move.w	#$F,$3C(a1)
		move.w	#Normal_palette_line_2,$30(a1)
		move.w	#Target_palette_line_2,$32(a1)

locret_76B28:
		rts
; ---------------------------------------------------------------------------

loc_76B2A:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_76B30:
		move.b	#4,routine(a0)
		st	(Events_bg+$02).w
		lea	ChildObjDat_773E6(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_76B44:
		jsr	(Find_SonicTails).l
		cmpi.w	#$60,d2
		blo.s	+ ;loc_76B52
		rts
; ---------------------------------------------------------------------------

+ ;loc_76B52:
		move.b	#6,routine(a0)
		bclr	#0,render_flags(a0)
		tst.w	d0
		beq.s	+ ;loc_76B68
		bset	#0,render_flags(a0)

+ ;loc_76B68:
		move.w	#$3E,$2E(a0)
		move.l	#loc_76B86,$34(a0)
		lea	ChildObjDat_773DE(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_76B80:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_76B86:
		move.b	#8,routine(a0)
		move.w	#-$100,y_vel(a0)
		move.w	#7,$2E(a0)
		move.l	#loc_76BB6,$34(a0)
		lea	ChildObjDat_773D6(pc),a2
		jmp	(CreateChild3_NormalRepeated).l
; ---------------------------------------------------------------------------

loc_76BAA:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_76BB6:
		clr.w	y_vel(a0)
		move.w	#7,$2E(a0)
		move.l	#loc_76BCA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_76BCA:
		move.w	#$80,y_vel(a0)
		move.w	#$F,$2E(a0)
		move.l	#loc_76BE0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_76BE0:
		move.b	#$A,routine(a0)
		move.l	#loc_76C26,$34(a0)
		clr.w	y_vel(a0)

locret_76BF2:
		rts
; ---------------------------------------------------------------------------

loc_76BF4:
		jsr	(MoveSprite2).l
		lea	byte_7745D(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		tst.w	d2
		beq.s	locret_76C24
		bmi.s	locret_76C24
		move.b	mapping_frame(a0),$39(a0)
		cmpi.b	#7,mapping_frame(a0)
		bne.s	+ ;loc_76C1E
		move.w	#-$700,y_vel(a0)

+ ;loc_76C1E:
		move.b	#0,mapping_frame(a0)

locret_76C24:
		rts
; ---------------------------------------------------------------------------

loc_76C26:
		move.b	#$C,routine(a0)
		move.l	#loc_76C5E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_76C36:
		tst.w	x_vel(a0)
		bmi.s	+ ;loc_76C48
		cmpi.w	#$4438,x_pos(a0)
		blo.s	+ ;loc_76C48
		clr.w	x_vel(a0)

+ ;loc_76C48:
		moveq	#$60,d1
		jsr	(MoveSprite_CustomGravity).l
		tst.w	y_vel(a0)
		bmi.w	locret_76BF2
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_76C5E:
		move.b	#$E,routine(a0)
		move.b	#0,$3A(a0)
		move.l	#loc_76CF0,$34(a0)

loc_76C72:
		move.l	#byte_7746A,$30(a0)
		move.w	#$14,(Screen_shake_flag).w
		moveq	#signextendB(sfx_BossHitFloor),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_77402(pc),a2
		jmp	(CreateChild3_NormalRepeated).l
; ---------------------------------------------------------------------------

loc_76C92:
		move.b	#$E,routine(a0)
		move.l	#loc_76D14,$34(a0)
		bra.s	loc_76C72
; ---------------------------------------------------------------------------

loc_76CA2:
		move.b	#4,routine(a0)
		move.b	#$3B,y_radius(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#8,(Screen_shake_flag).w
		moveq	#signextendB(sfx_Crash),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_7740A(pc),a2
		jmp	(CreateChild3_NormalRepeated).l
; ---------------------------------------------------------------------------

loc_76CCE:
		jsr	(Animate_RawMultiDelay).l
		tst.w	d2
		beq.s	locret_76CEE
		bmi.s	locret_76CEE
		move.b	mapping_frame(a0),$39(a0)
		move.b	$3A(a0),mapping_frame(a0)
		lea	byte_772E2(pc),a1
		bsr.w	sub_772BE

locret_76CEE:
		rts
; ---------------------------------------------------------------------------

loc_76CF0:
		move.b	#$10,routine(a0)
		move.l	#byte_7747D,$30(a0)
		move.l	#loc_76D0E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_76D08:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_76D0E:
		bset	#1,$38(a0)

loc_76D14:
		move.b	#$12,routine(a0)
		move.b	#1,$3A(a0)
		move.w	#$60,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_76D28:
		subq.w	#1,$2E(a0)
		bmi.s	+++ ;loc_76D5C
		jsr	(Find_SonicTails).l
		btst	#0,render_flags(a0)
		beq.s	+ ;loc_76D3E
		subq.w	#2,d0

+ ;loc_76D3E:
		tst.w	d0
		bne.s	+ ;loc_76D44
		rts
; ---------------------------------------------------------------------------

+ ;loc_76D44:
		move.b	#$14,routine(a0)
		move.l	#byte_77452,$30(a0)
		move.l	#loc_76DA8,$34(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_76D5C:
		move.b	#$16,routine(a0)
		move.l	#byte_77482,$30(a0)
		move.l	#loc_76DE6,$34(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_76D7C:
		subq.w	#1,$2E(a0)
		jsr	(Animate_RawMultiDelayFlipX).l
		tst.w	d2
		beq.s	locret_76DA6
		bmi.s	locret_76DA6
		move.b	mapping_frame(a0),d0
		move.b	d0,$39(a0)
		move.b	#1,mapping_frame(a0)
		cmpi.b	#9,d0
		bne.s	locret_76DA6
		move.b	#$19,mapping_frame(a0)

locret_76DA6:
		rts
; ---------------------------------------------------------------------------

loc_76DA8:
		move.b	#$12,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_76DB0:
		jsr	(MoveSprite2).l
		jsr	(Animate_RawMultiDelay).l
		tst.w	d2
		beq.s	locret_76DE4
		bmi.s	locret_76DE4
		move.b	mapping_frame(a0),$39(a0)
		cmpi.b	#7,mapping_frame(a0)
		bne.s	+ ;loc_76DD6
		move.w	#-$700,y_vel(a0)

+ ;loc_76DD6:
		move.b	$3A(a0),mapping_frame(a0)
		lea	byte_772E2(pc),a1
		bsr.w	sub_772BE

locret_76DE4:
		rts
; ---------------------------------------------------------------------------

loc_76DE6:
		move.b	#$C,routine(a0)
		move.l	#loc_76C92,$34(a0)
		move.w	#$180,d0
		btst	#0,render_flags(a0)
		bne.s	+ ;loc_76E02
		neg.w	d0

+ ;loc_76E02:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

locret_76E08:
		rts
; ---------------------------------------------------------------------------

loc_76E0A:
		subq.w	#1,$2E(a0)
		bmi.s	+ ;loc_76E1C
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_76E1C:
		bset	#5,$38(a0)
		bset	#7,status(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		move.w	d0,x_pos(a0)
		bclr	#7,render_flags(a0)
		jsr	(AllocateObject).l
		bne.s	+ ;loc_76E48
		move.l	#loc_76E4E,(a1)

+ ;loc_76E48:
		jmp	(Obj_EndSignControl).l
; ---------------------------------------------------------------------------

loc_76E4E:
		tst.b	(_unkFAA8).w
		beq.w	locret_76BF2
		move.l	#loc_76E5C,(a0)

loc_76E5C:
		tst.b	(_unkFAA8).w
		bne.w	locret_76BF2
		move.l	#loc_76E94,(a0)
		lea	ChildObjDat_773F4(pc),a2
		jsr	(CreateChild1_Normal).l
		st	(Ctrl_1_locked).w
		jsr	(AllocateObject).l
		bne.s	+ ;loc_76E86
		move.l	#loc_863C0,(a1)

+ ;loc_76E86:
		cmpi.w	#$43A0,(Player_1+x_pos).w
		blo.s	loc_76E94
		bset	#3,$38(a0)

loc_76E94:
		lea	(Ctrl_1_logical).w,a1
		lea	(Player_1).w,a2
		move.w	#$43A0,d0
		tst.w	x_vel(a0)
		btst	#3,$38(a0)
		bne.s	++ ;loc_76EC8
		cmp.w	x_pos(a2),d0
		bls.s	loc_76EE4
		moveq	#0,d1
		btst	#Status_Push,status(a2)
		beq.s	+ ;loc_76EC0
		ori.w	#(button_A_mask<<8)|button_A_mask,d1

+ ;loc_76EC0:
		ori.w	#(button_right_mask<<8)|button_right_mask,d1
		move.w	d1,(a1)
		rts
; ---------------------------------------------------------------------------

+ ;loc_76EC8:
		cmp.w	x_pos(a2),d0
		bhs.s	loc_76EE4
		moveq	#0,d1
		btst	#Status_Push,status(a2)
		beq.s	+ ;loc_76EDC
		ori.w	#(button_A_mask<<8)|button_A_mask,d1

+ ;loc_76EDC:
		ori.w	#(button_left_mask<<8)|button_left_mask,d1
		move.w	d1,(a1)
		rts
; ---------------------------------------------------------------------------

loc_76EE4:
		move.w	d0,x_pos(a2)
		clr.w	(a1)
		bclr	#0,render_flags(a2)
		bclr	#Status_Facing,status(a2)
		clr.w	x_vel(a2)
		clr.w	y_vel(a2)
		clr.w	ground_vel(a2)
		move.w	#$55,(Events_fg_5).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_76F0E:
		lea	word_773B8(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.w	priority(a0),$3C(a0)
		move.l	#loc_76F24,(a0)

loc_76F24:
		bsr.w	sub_770EA
		movea.w	parent3(a0),a1
		moveq	#8,d0
		btst	#6,status(a1)
		bne.s	+ ;loc_76F40
		bsr.w	sub_7710C
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_76F40:
		jmp	(loc_849D8).l
; ---------------------------------------------------------------------------

loc_76F46:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_76F60(pc,d0.w),d1
		jsr	off_76F60(pc,d1.w)
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------
off_76F60:
		dc.w loc_76F6A-off_76F60
		dc.w locret_76F86-off_76F60
		dc.w loc_76F88-off_76F60
		dc.w loc_76FA6-off_76F60
		dc.w loc_7701C-off_76F60
; ---------------------------------------------------------------------------

loc_76F6A:
		lea	word_773C4(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		tst.b	subtype(a0)
		bne.s	locret_76F84
		clr.b	collision_flags(a0)
		move.b	#4,routine(a0)

locret_76F84:
		rts
; ---------------------------------------------------------------------------

locret_76F86:
		rts
; ---------------------------------------------------------------------------

loc_76F88:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		beq.s	locret_76FA4
		move.b	#6,routine(a0)
		move.b	#$D7,collision_flags(a0)
		clr.b	collision_property(a0)

locret_76FA4:
		rts
; ---------------------------------------------------------------------------

loc_76FA6:
		jsr	(Check_PlayerCollision).l
		beq.s	locret_76FF8
		jsr	(Check_PlayerAttack).l
		bne.s	+ ;loc_76FC2
		tst.b	invulnerability_timer(a1)
		bne.s	locret_76FF8
		jmp	(HurtCharacter_Directly).l
; ---------------------------------------------------------------------------

+ ;loc_76FC2:
		neg.w	x_vel(a1)
		neg.w	y_vel(a1)
		neg.w	ground_vel(a1)
		move.b	#8,routine(a0)
		move.l	#byte_77495,$30(a0)
		move.l	#loc_76FFA,$34(a0)
		movea.w	parent3(a0),a2
		move.w	a1,$44(a2)
		bset	#6,status(a2)
		bset	#7,$38(a2)

locret_76FF8:
		rts
; ---------------------------------------------------------------------------

loc_76FFA:
		move.b	#$1A,mapping_frame(a0)
		movea.w	parent3(a0),a1
		bclr	#6,status(a1)
		bclr	#1,$38(a1)
		move.b	#4,routine(a0)
		clr.b	collision_flags(a0)
		rts
; ---------------------------------------------------------------------------

loc_7701C:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_77022:
		lea	word_773BE(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.w	priority(a0),$3C(a0)
		movea.w	parent3(a0),a1
		bclr	#0,render_flags(a0)
		btst	#0,render_flags(a1)
		beq.s	+ ;loc_7704A
		bset	#0,render_flags(a0)

+ ;loc_7704A:
		move.l	#loc_77062,(a0)
		move.w	#-$100,y_vel(a0)
		move.w	#$3F,$2E(a0)
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------

loc_77062:
		bsr.w	sub_770EA
		jmp	(MoveDraw_SpriteTimed).l
; ---------------------------------------------------------------------------

loc_7706C:
		lea	ObjDat3_773CA(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_770C4,(a0)
		movea.w	parent3(a0),a1
		move.b	child_dx(a0),d0
		btst	#0,render_flags(a1)
		beq.s	+ ;loc_7708E
		neg.b	d0

+ ;loc_7708E:
		ext.w	d0
		move.w	x_pos(a1),d1
		add.w	d0,d1
		moveq	#0,d0
		move.b	subtype(a0),d0
		lea	byte_770B8(pc,d0.w),a2
		move.b	(a2)+,d0
		bmi.s	+ ;loc_770AA
		bset	#0,render_flags(a0)

+ ;loc_770AA:
		ext.w	d0
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.b	(a2)+,$2E(a0)
		rts
; ---------------------------------------------------------------------------
byte_770B8:
		dc.b -$18,  $B
		dc.b  $18,  $B
		dc.b -$10,   5
		dc.b  $10,   5
		dc.b   -8, $FF
		dc.b    8, $FF
; ---------------------------------------------------------------------------

loc_770C4:
		subq.b	#1,$2E(a0)
		bpl.s	locret_770D8
		move.l	#loc_770DA,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)

locret_770D8:
		rts
; ---------------------------------------------------------------------------

loc_770DA:
		lea	byte_7749B(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_770EA:
		bset	#7,art_tile(a0)
		move.w	$3C(a0),d0
		cmpi.w	#$4200,x_pos(a0)
		bhs.s	+ ;loc_77106
		move.w	#$80,d0
		bclr	#7,art_tile(a0)

+ ;loc_77106:
		move.w	d0,priority(a0)
		rts
; End of function sub_770EA


; =============== S U B R O U T I N E =======================================


sub_7710C:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	off_7716E(pc,d0.w),d1
		lea	off_7716E(pc,d1.w),a1
		movea.w	parent3(a0),a2
		moveq	#0,d1
		move.b	$39(a2),d1
		andi.b	#$3F,d1
		lsl.w	#2,d1
		adda.w	d1,a1
		move.b	(a1)+,d2
		ext.w	d2
		move.b	(a1)+,d3
		ext.w	d3
		move.b	(a1)+,mapping_frame(a0)
		bclr	#0,render_flags(a0)
		btst	#0,render_flags(a2)
		beq.s	+ ;loc_7714E
		bset	#0,render_flags(a0)
		neg.w	d2

+ ;loc_7714E:
		tst.b	(a1)
		beq.s	+ ;loc_77158
		bchg	#0,render_flags(a0)

+ ;loc_77158:
		move.w	x_pos(a2),d1
		add.w	d2,d1
		move.w	d1,x_pos(a0)
		move.w	y_pos(a2),d1
		add.w	d3,d1
		move.w	d1,y_pos(a0)
		rts
; End of function sub_7710C

; ---------------------------------------------------------------------------
off_7716E:
		dc.w byte_7717E-off_7716E
		dc.w byte_771A6-off_7716E
		dc.w byte_771CE-off_7716E
		dc.w byte_771F6-off_7716E
		dc.w byte_7721E-off_7716E
		dc.w byte_77246-off_7716E
		dc.w byte_7726E-off_7716E
		dc.w byte_77296-off_7716E
byte_7717E:
		dc.b    0,  -8, $15,   0
		dc.b    0,  -8, $15,   0
		dc.b    0,  -8, $15,   0
		dc.b    0,  -8, $15,   0
		dc.b    0,  -8, $15,   0
		dc.b   -1, -$9, $15,   0
		dc.b   -2, -$A, $15,   0
		dc.b   -3, -$B, $15,   0
		dc.b   -4, -$C, $15,   0
		dc.b    0,  -8, $16,   0
byte_771A6:
		dc.b  -$C, $14,   6,   0
		dc.b  -$C, $14,   6,   0
		dc.b  -$C, $14,   6,   0
		dc.b  -$C, $14,   6,   0
		dc.b  -$B, $14,   6,   0
		dc.b -$14,  $D,   7,   0
		dc.b -$20,   0,   8,   0
		dc.b -$1C, -$A,   9,   0
		dc.b -$20,-$14,  $A,   0
		dc.b   -8, $14,  $B,   0
byte_771CE:
		dc.b    0,   4, $17,   0
		dc.b    0,   4, $17,   0
		dc.b    0,   4, $17,   0
		dc.b    0,   4, $17,   0
		dc.b    1,   4, $17,   0
		dc.b   -4,   2, $17,   0
		dc.b   -8,   0, $17,   0
		dc.b  -$C,  -2, $17,   0
		dc.b -$10,  -8, $17,   0
		dc.b    0,   4, $17,   0
byte_771F6:
		dc.b    0, $28,  $C,   1
		dc.b   -1, $28,  $C,   1
		dc.b   -8, $20,  $C,   1
		dc.b  -$D, $1A,  $C,   1
		dc.b  -$E, $19,  $C,   1
		dc.b  -$D, $1A,  $C,   1
		dc.b   -8, $20,  $C,   1
		dc.b   -1, $28,  $C,   1
		dc.b    0, $28,  $C,   1
		dc.b    0, $28,  $F,   1
byte_7721E:
		dc.b    0, $14,  $C,   0
		dc.b    2, $14,  $C,   0
		dc.b   -4, $10,  $D,   0
		dc.b   -2,  $E,  $E,   0
		dc.b   -2,  $E,  $E,   0
		dc.b   -2,  $E,  $E,   0
		dc.b   -4, $10,  $D,   0
		dc.b    2, $14,  $C,   0
		dc.b    0, $14,  $C,   0
		dc.b    0, $14,  $F,   0
byte_77246:
		dc.b   -8, $1C, $17,   0
		dc.b   -6, $1C, $17,   0
		dc.b  -$A, $14, $17,   0
		dc.b  -$E,  $E, $17,   0
		dc.b  -$E,  $E, $17,   0
		dc.b  -$E,  $E, $17,   0
		dc.b  -$A, $14, $17,   0
		dc.b   -6, $1C, $17,   0
		dc.b   -8, $1C, $17,   0
		dc.b   -4, $1C, $17,   0
byte_7726E:
		dc.b   -4, $34, $10,   0
		dc.b   -5, $34, $10,   0
		dc.b  -$C, $2C, $10,   0
		dc.b -$11, $26, $10,   0
		dc.b -$12, $25, $10,   0
		dc.b -$11, $26, $10,   0
		dc.b  -$C, $2C, $10,   0
		dc.b   -5, $34, $10,   0
		dc.b   -4, $34, $10,   0
		dc.b   -4, $34, $11,   0
byte_77296:
		dc.b    0, $14,   3,   0
		dc.b    2, $14,   3,   0
		dc.b    2, $14,   3,   0
		dc.b    2, $14,   3,   0
		dc.b    2, $14,   3,   0
		dc.b    2, $14,   3,   0
		dc.b    2, $14,   3,   0
		dc.b    2, $14,   3,   0
		dc.b    0, $14,   3,   0
		dc.b    0, $14,   3,   0
		even

; =============== S U B R O U T I N E =======================================


sub_772BE:
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		adda.w	d0,a1
		move.b	(a1)+,d0
		ext.w	d0
		btst	#0,render_flags(a0)
		beq.s	+ ;loc_772D4
		neg.w	d0

+ ;loc_772D4:
		add.w	d0,x_pos(a0)
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d0,y_pos(a0)
		rts
; End of function sub_772BE

; ---------------------------------------------------------------------------
byte_772E2:
		dc.b    0,   0
		dc.b    1,   0
		dc.b    7,   8
		dc.b    5,   6
		dc.b    1,   1
		dc.b   -1,  -1
		dc.b   -5,  -6
		dc.b   -7,  -8
		dc.b   -1,   0
		dc.b    0,   0
		even

; =============== S U B R O U T I N E =======================================


sub_772F6:
		cmpi.w	#$A10,y_pos(a0)
		bhs.s	++ ;loc_77364
		btst	#6,status(a0)
		beq.w	locret_773AA
		bclr	#7,$38(a0)
		beq.w	locret_773AA
		move.b	#$C,routine(a0)
		move.l	#loc_76CA2,$34(a0)
		move.b	#8,y_radius(a0)
		moveq	#0,d0
		move.b	d0,mapping_frame(a0)
		move.b	d0,anim_frame(a0)
		move.b	d0,anim_frame_timer(a0)
		move.b	d0,$3A(a0)
		move.b	d0,$39(a0)
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		movea.w	$44(a0),a1
		move.w	#$200,d0
		move.w	x_pos(a1),d1
		cmp.w	x_pos(a0),d1
		blo.s	+ ;loc_77358
		neg.w	d0

+ ;loc_77358:
		move.w	d0,x_vel(a0)
		move.w	#-$200,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_77364:
		move.l	#loc_76E0A,(a0)
		clr.w	x_vel(a0)
		move.w	#$40,y_vel(a0)
		move.w	#$BF,$2E(a0)
		clr.b	(Update_HUD_timer).w
		move.w	(Camera_min_X_pos).w,(Camera_stored_min_X_pos).w
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		move.w	(Camera_X_pos).w,(Camera_max_X_pos).w
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	locret_773AA
		move.b	#4,subtype(a1)

locret_773AA:
		rts
; End of function sub_772F6

; ---------------------------------------------------------------------------
ObjDat_SOZMiniboss:
		dc.l Map_SOZMiniboss
		dc.w make_art_tile($3B5,1,1)
		dc.w   $300
		dc.b  $24, $34,   0,   0
word_773B8:
		dc.w   $280
		dc.b  $14, $14,   0,   0
word_773BE:
		dc.w   $280
		dc.b  $34, $34, $18,   0
word_773C4:
		dc.w   $280
		dc.b   $C, $10, $1A, $A8
ObjDat3_773CA:
		dc.l Map_SOZMinibossDust
		dc.w make_art_tile($4F3,2,1)
		dc.w   $180
		dc.b    8,   8,   0,   0
ChildObjDat_773D6:
		dc.w 8-1
		dc.l loc_76F0E
		dc.b    0,   0
ChildObjDat_773DE:
		dc.w 1-1
		dc.l loc_77022
		dc.b   0, $40
ChildObjDat_773E6:
		dc.w 2-1
		dc.l loc_76F46
		dc.b  -$C,-$1C
		dc.l loc_76F46
		dc.b    0,   0
ChildObjDat_773F4:
		dc.w 2-1
		dc.l Obj_DecLevStartXGradual
		dc.b    0,   0
		dc.l Obj_IncLevEndXGradual
		dc.b    0,   0
ChildObjDat_77402:
		dc.w 6-1
		dc.l loc_7706C
		dc.b   -4, $38
ChildObjDat_7740A:
		dc.w 6-1
		dc.l loc_7706C
		dc.b    0,   4
Pal_SOZMinibossFade:
		binclude "Levels/SOZ/Palettes/Miniboss Fade.bin"
		even
Pal_SOZMinibossMain:
		binclude "Levels/SOZ/Palettes/Miniboss Main.bin"
		even
byte_77452:
		dc.b      0,   9
		dc.b      0, $1F
		dc.b      9,   9
		dc.b  $40|9,   9
		dc.b      0,   9
		dc.b    $F4
byte_7745D:
		dc.b    0,   9
		dc.b    0,   9
		dc.b    5,   4
		dc.b    6,   4
		dc.b    7,   4
		dc.b    8,   1
		dc.b  $F4
byte_7746A:
		dc.b    8,   4
		dc.b    7,   4
		dc.b    6,   4
		dc.b    5,   4
		dc.b    4,   4
		dc.b    3,   9
		dc.b    2,   9
		dc.b    1,   9
		dc.b    0, $1F
		dc.b  $F4
byte_7747D:
		dc.b   $F,   0, $19,   1, $F4
byte_77482:
		dc.b    0,   4
		dc.b    1,   4
		dc.b    2,   4
		dc.b    3,   4
		dc.b    4,   4
		dc.b    5,   9
		dc.b    6,   9
		dc.b    7,   5
		dc.b    8,   0
		dc.b  $F4
byte_77495:
		dc.b    3, $12, $12, $13, $14, $F4
byte_7749B:
		dc.b    0,   3
		dc.b    0,   3
		dc.b    1,   5
		dc.b    2,   5
		dc.b    3,   7
		dc.b  $F4
		even
Map_SOZMiniboss:
		include "Levels/SOZ/Misc Object Data/Map - Miniboss.asm"
Map_SOZMinibossDust:
		include "Levels/SOZ/Misc Object Data/Map - Miniboss Landing Dust.asm"
; ---------------------------------------------------------------------------
