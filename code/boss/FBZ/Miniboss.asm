Obj_FBZMiniboss:
		lea	word_6EE98(pc),a1
		jsr	(Check_CameraInRange).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	FBZMiniboss_Index(pc,d0.w),d1
		jsr	FBZMiniboss_Index(pc,d1.w)
		bsr.w	sub_6F786
		bsr.w	sub_6F994
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
FBZMiniboss_Index:
		dc.w loc_6EEA8-FBZMiniboss_Index
		dc.w loc_6EF0E-FBZMiniboss_Index
		dc.w loc_6EF32-FBZMiniboss_Index
		dc.w loc_6EF5A-FBZMiniboss_Index
		dc.w loc_6EF76-FBZMiniboss_Index
word_6EE98:
		dc.w   $240,  $600, $2D20, $2F20
		dc.w   $540,  $540, $2E20, $2E20
; ---------------------------------------------------------------------------

loc_6EEA8:
		lea	ObjDat_FBZMiniboss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#6,collision_property(a0)
		move.b	#1,(Boss_flag).w
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w
		move.w	(Camera_max_Y_pos).w,(Camera_stored_max_Y_pos).w
		move.w	#$540,(Camera_target_max_Y_pos).w
		move.w	#$2E20,$3A(a0)
		move.l	#loc_6EF14,$34(a0)
		lea	(PLC_BossExplosion).l,a1
		jsr	(Load_PLC_Raw).l
		lea	(ArtKosM_FBZMiniboss).l,a1
		move.w	#tiles_to_bytes($52E),d2
		jsr	(Queue_Kos_Module).l
		lea	Pal_FBZMiniboss(pc),a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_6FA76(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6EF0E:
		jmp	(loc_85C7E).l
; ---------------------------------------------------------------------------

loc_6EF14:
		move.b	#4,routine(a0)
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w
		move.w	$3A(a0),d0
		move.w	d0,(Camera_min_X_pos).w
		addi.w	#$80,d0
		move.w	d0,(Camera_max_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_6EF32:
		btst	#0,$38(a0)
		bne.s	loc_6EF3C
		rts
; ---------------------------------------------------------------------------

loc_6EF3C:
		move.b	#6,routine(a0)
		move.l	#loc_6EF60,$34(a0)
		move.w	#2*60,$2E(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l

locret_6EF58:
		rts
; ---------------------------------------------------------------------------

loc_6EF5A:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6EF60:
		move.b	#8,routine(a0)
		moveq	#signextendB(mus_Miniboss),d0
		jsr	(Play_Music).l
		move.b	#mus_Miniboss,(Current_music+1).w
		rts
; ---------------------------------------------------------------------------

loc_6EF76:
		bclr	#7,$38(a0)
		beq.s	locret_6EF58
		lea	ChildObjDat_6FAA8(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6EF88:
		subq.w	#1,$2E(a0)
		bmi.s	loc_6EF98
		bsr.w	sub_6F786
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6EF98:
		bclr	#7,render_flags(a0)
		move.w	#(2*60)-1,$2E(a0)
		jsr	(AllocateObject).l
		bne.s	loc_6EFB2
		move.l	#Obj_Song_Fade_ToLevelMusic,(a1)

loc_6EFB2:
		jsr	(Obj_EndSignControl).l
		lea	ChildObjDat_6FAB0(pc),a2
		jsr	(CreateChild6_Simple).l
		lea	(ChildObjDat_89ED0).l,a2
		jsr	(CreateChild1_Normal).l
		lea	(ChildObjDat_86B7A).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6EFDA:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6EFF2(pc,d0.w),d1
		jsr	off_6EFF2(pc,d1.w)
		bsr.w	sub_6F796
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
off_6EFF2:
		dc.w loc_6EFF6-off_6EFF2
		dc.w loc_6F010-off_6EFF2
; ---------------------------------------------------------------------------

loc_6EFF6:
		lea	(ObjDat_FBZSpringPlunger).l,a1
		jsr	(SetUp_ObjAttributes).l
		move.w	#$280,priority(a0)
		move.w	y_pos(a0),$3E(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F010:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_6F04A
		move.w	$3E(a0),d0
		btst	#3,status(a0)
		bne.s	loc_6F03C
		btst	#2,$38(a1)
		bne.s	loc_6F03C
		bclr	#0,$38(a1)
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F03C:
		bset	#0,$38(a1)
		addq.w	#4,d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F04A:
		move.l	#loc_6F056,(a0)
		addq.w	#8,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F056:
		bsr.w	sub_6F796
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_6F060:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6F074(pc,d0.w),d1
		jsr	off_6F074(pc,d1.w)
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
off_6F074:
		dc.w loc_6F07C-off_6F074
		dc.w loc_6F086-off_6F074
		dc.w loc_6F0AA-off_6F074
		dc.w loc_6F0B8-off_6F074
; ---------------------------------------------------------------------------

loc_6F07C:
		lea	word_6FA58(pc),a1
		jmp	(SetUp_ObjAttributes3).l
; ---------------------------------------------------------------------------

loc_6F086:
		movea.w	parent3(a0),a1
		btst	#0,$38(a1)
		bne.s	loc_6F094
		rts
; ---------------------------------------------------------------------------

loc_6F094:
		move.b	#4,routine(a0)
		move.w	#$40,$2E(a0)
		move.l	#loc_6F0B0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F0AA:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6F0B0:
		move.b	#6,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F0B8:
		btst	#2,(V_int_run_count+3).w
		jsr	(Find_SonicTails8Way).l
		addi.w	#9,d4
		move.b	d4,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F0CE:
		lea	word_6FA5E(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_6F102,(a0)
		move.w	#$EEE,(Normal_palette_line_2+$1E).w
		lea	(word_6FAE0).l,a1
		lea	(Palette_rotation_data).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		clr.w	(a2)
		move.l	#Go_Delete_Sprite,(Palette_rotation_custom).w
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6F102:
		jsr	(Run_PalRotationScript).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6F10E:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6F122(pc,d0.w),d1
		jsr	off_6F122(pc,d1.w)
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
off_6F122:
		dc.w loc_6F12A-off_6F122
		dc.w loc_6F142-off_6F122
		dc.w loc_6F162-off_6F122
		dc.w locret_6F176-off_6F122
; ---------------------------------------------------------------------------

loc_6F12A:
		lea	word_6FA40(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.b	subtype(a0),d0
		lsr.b	#1,d0
		addq.b	#1,d0
		move.b	d0,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F142:
		movea.w	parent3(a0),a1
		btst	#0,$38(a1)
		bne.s	loc_6F150
		rts
; ---------------------------------------------------------------------------

loc_6F150:
		move.b	#4,routine(a0)
		move.l	#loc_6F16E,$34(a0)
		bra.w	loc_6F7A6
; ---------------------------------------------------------------------------

loc_6F162:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6F16E:
		move.b	#6,routine(a0)
		rts
; ---------------------------------------------------------------------------

locret_6F176:
		rts
; ---------------------------------------------------------------------------

loc_6F178:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6F190(pc,d0.w),d1
		jsr	off_6F190(pc,d1.w)
		bsr.w	sub_6FA14
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_6F190:
		dc.w loc_6F1A6-off_6F190
		dc.w loc_6F1D6-off_6F190
		dc.w loc_6F1F4-off_6F190
		dc.w loc_6F218-off_6F190
		dc.w loc_6F1F4-off_6F190
		dc.w loc_6F29E-off_6F190
		dc.w loc_6F338-off_6F190
		dc.w loc_6F1F4-off_6F190
		dc.w loc_6F378-off_6F190
		dc.w loc_6F384-off_6F190
		dc.w loc_6F1F4-off_6F190
; ---------------------------------------------------------------------------

loc_6F1A6:
		lea	word_6FA46(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.w	#-$140,d0
		subi.b	#$A,subtype(a0)
		beq.s	loc_6F1CA
		neg.w	d0
		bset	#0,render_flags(a0)
		move.w	#$3F,$2E(a0)

loc_6F1CA:
		move.w	d0,x_vel(a0)
		move.w	#-$D0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F1D6:
		movea.w	parent3(a0),a1
		btst	#0,$38(a1)
		bne.s	loc_6F1E4
		rts
; ---------------------------------------------------------------------------

loc_6F1E4:
		move.b	#4,routine(a0)
		move.l	#loc_6F1FA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F1F4:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6F1FA:
		move.b	#6,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6F224,$34(a0)
		lea	word_6FAA2(pc),a2
		jmp	(CreateChild4_LinkListRepeated).l
; ---------------------------------------------------------------------------

loc_6F218:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6F224:
		move.b	#8,routine(a0)
		bset	#3,$38(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6F240,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F240:
		move.b	#$A,routine(a0)
		bset	#2,$38(a0)
		bclr	#3,$38(a0)
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)
		bclr	#1,$38(a0)
		bclr	#6,$38(a1)
		bclr	#6,$38(a0)
		move.w	#2*60,$2E(a0)
		move.l	#loc_6F2A8,$34(a0)
		move.b	#-$60,$3C(a0)
		move.b	#2,$40(a0)
		btst	#0,render_flags(a0)
		beq.s	locret_6F29C
		move.b	#$60,$3C(a0)
		move.b	#-2,$40(a0)

locret_6F29C:
		rts
; ---------------------------------------------------------------------------

loc_6F29E:
		bsr.w	sub_6F7F2
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6F2A8:
		move.w	#$F0,$2E(a0)
		movea.w	parent3(a0),a1
		btst	#0,$38(a1)
		beq.s	loc_6F2E4
		btst	#1,$38(a1)
		bne.w	locret_6EF58
		move.b	#$C,routine(a0)
		bclr	#2,$38(a0)
		bset	#1,$38(a1)
		bset	#1,$38(a0)
		bset	#7,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_6F2E4:
		btst	#6,$38(a1)
		bne.w	locret_6EF58
		lea	(Player_1).w,a2
		tst.b	$40(a2)
		bne.w	locret_6EF58
		move.w	x_pos(a2),d0
		cmp.w	x_pos(a1),d0
		bhs.s	loc_6F30E
		btst	#0,render_flags(a0)
		beq.s	loc_6F318
		rts
; ---------------------------------------------------------------------------

loc_6F30E:
		btst	#0,render_flags(a0)
		beq.w	locret_6EF58

loc_6F318:
		move.b	#$12,routine(a0)
		bclr	#2,$38(a0)
		bset	#6,$38(a1)
		bset	#6,$38(a0)
		bset	#7,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_6F338:
		btst	#3,$38(a0)
		bne.s	loc_6F344
		bra.w	sub_6F830
; ---------------------------------------------------------------------------

loc_6F344:
		move.b	#$E,routine(a0)
		move.b	#2,$40(a0)
		move.w	#$60,$2E(a0)
		move.l	#loc_6F360,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F360:
		move.b	#$10,routine(a0)
		bclr	#3,$38(a0)
		movea.w	parent3(a0),a1
		bclr	#2,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_6F378:
		btst	#2,$38(a0)
		bne.w	loc_6F240
		rts
; ---------------------------------------------------------------------------

loc_6F384:
		bclr	#3,$38(a0)
		bne.s	loc_6F38E
		rts
; ---------------------------------------------------------------------------

loc_6F38E:
		move.b	#$14,routine(a0)
		move.w	#$10,$2E(a0)
		move.l	#loc_6F3A4,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F3A4:
		move.b	#$10,routine(a0)
		bset	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F3B2:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_6F3C4
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6F3C4:
		move.l	#Obj_FlickerMove,(a0)
		bset	#4,$38(a0)
		move.w	#$3F,$2E(a0)
		moveq	#0,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

loc_6F3DE:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6F3F6(pc,d0.w),d1
		jsr	off_6F3F6(pc,d1.w)
		bsr.w	sub_6FA14
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_6F3F6:
		dc.w loc_6F416-off_6F3F6
		dc.w loc_6F46A-off_6F3F6
		dc.w loc_6F4C0-off_6F3F6
		dc.w loc_6F4F6-off_6F3F6
		dc.w loc_6F53E-off_6F3F6
		dc.w loc_6F554-off_6F3F6
		dc.w loc_6F5B8-off_6F3F6
		dc.w loc_6F5E0-off_6F3F6
		dc.w loc_6F612-off_6F3F6
		dc.w loc_6F620-off_6F3F6
		dc.w loc_6F632-off_6F3F6
		dc.w loc_6F64E-off_6F3F6
		dc.w loc_6F67E-off_6F3F6
		dc.w loc_6F6A6-off_6F3F6
		dc.w loc_6F6E4-off_6F3F6
		dc.w loc_6F728-off_6F3F6
; ---------------------------------------------------------------------------

loc_6F416:
		addq.b	#2,subtype(a0)
		cmpi.b	#$A,subtype(a0)
		beq.s	loc_6F432
		lea	word_6FA4C(pc),a1
		move.w	#4,$3E(a0)
		jmp	(SetUp_ObjAttributes3).l
; ---------------------------------------------------------------------------

loc_6F432:
		lea	word_6FA52(pc),a1
		move.w	#3,$3E(a0)
		jsr	(SetUp_ObjAttributes3).l
		move.b	#$86,collision_flags(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a1
		movea.w	parent3(a1),a1
		movea.w	parent3(a1),a1
		movea.w	parent3(a1),a1
		move.w	a1,$44(a0)
		move.w	a1,$30(a1)
		move.w	a0,$32(a1)
		rts
; ---------------------------------------------------------------------------

loc_6F46A:
		jsr	(Refresh_ChildPosition).l
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	loc_6F47E
		rts
; ---------------------------------------------------------------------------

loc_6F47E:
		move.b	#4,routine(a0)
		bset	#3,$38(a0)
		bsr.w	sub_6F7D2
		move.w	#$F,$2E(a0)
		move.l	#loc_6F4CC,$34(a0)
		movea.w	parent3(a0),a1
		move.w	$30(a1),$30(a0)
		move.w	$32(a1),$32(a0)
		btst	#0,render_flags(a1)
		beq.s	locret_6F4BE
		bset	#0,render_flags(a0)
		neg.w	x_vel(a0)

locret_6F4BE:
		rts
; ---------------------------------------------------------------------------

loc_6F4C0:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6F4CC:
		move.b	#6,routine(a0)
		bclr	#3,$38(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#$80,priority(a0)
		cmpi.b	#$A,subtype(a0)
		beq.s	locret_6F4F4
		move.w	#$180,priority(a0)

locret_6F4F4:
		rts
; ---------------------------------------------------------------------------

loc_6F4F6:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		bne.s	loc_6F504
		rts
; ---------------------------------------------------------------------------

loc_6F504:
		move.b	#8,routine(a0)
		bset	#2,$38(a0)
		bclr	#3,$38(a0)
		bclr	#6,$38(a0)
		bclr	#1,$38(a0)
		move.b	$3C(a1),$3C(a0)
		move.b	$40(a1),$40(a0)
		move.b	subtype(a0),d0
		add.b	d0,d0
		move.b	d0,$3B(a0)
		move.b	d0,$3A(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F53E:
		subq.b	#1,$3B(a0)
		bpl.s	loc_6F54A
		move.b	#$A,routine(a0)

loc_6F54A:
		move.w	$3E(a0),d2
		jmp	(MoveSprite_CircularSimple).l
; ---------------------------------------------------------------------------

loc_6F554:
		bsr.w	sub_6F7F2
		move.w	$3E(a0),d2
		jsr	(MoveSprite_CircularSimple).l
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	loc_6F578
		btst	#6,$38(a1)
		bne.s	loc_6F58C
		rts
; ---------------------------------------------------------------------------

loc_6F578:
		move.b	#$C,routine(a0)
		bset	#1,$38(a0)
		bclr	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F58C:
		move.b	#$18,routine(a0)
		bset	#6,$38(a0)
		bclr	#2,$38(a0)
		cmpi.b	#$A,subtype(a0)
		bne.s	locret_6F5B6
		lea	(Player_1).w,a1
		move.w	x_pos(a1),$30(a0)
		move.w	y_pos(a1),$32(a0)

locret_6F5B6:
		rts
; ---------------------------------------------------------------------------

loc_6F5B8:
		bsr.w	sub_6F830
		beq.s	loc_6F5D6
		move.b	#$E,routine(a0)
		cmpi.b	#$A,subtype(a0)
		bne.s	loc_6F5D6
		movea.w	$44(a0),a1
		bset	#3,$38(a1)

loc_6F5D6:
		move.w	$3E(a0),d2
		jmp	(MoveSprite_CircularSimple).l
; ---------------------------------------------------------------------------

loc_6F5E0:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	loc_6F5F6
		move.w	$3E(a0),d2
		jmp	(MoveSprite_CircularSimple).l
; ---------------------------------------------------------------------------

loc_6F5F6:
		move.b	#$10,routine(a0)
		bset	#3,$38(a0)
		move.w	#$F,$2E(a0)
		move.l	#loc_6F618,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F612:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6F618:
		move.b	#$12,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F620:
		move.b	#$14,d4
		bsr.w	sub_6F85A
		move.w	$3E(a0),d2
		jmp	(MoveSprite_CircularSimple).l
; ---------------------------------------------------------------------------

loc_6F632:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.s	loc_6F640
		rts
; ---------------------------------------------------------------------------

loc_6F640:
		move.b	#$16,routine(a0)
		bclr	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F64E:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		bne.w	loc_6F504
		bsr.w	sub_6F8C8
		beq.s	loc_6F674
		cmpi.b	#$A,subtype(a0)
		bne.s	loc_6F674
		movea.w	$44(a0),a1
		bset	#2,$38(a1)

loc_6F674:
		move.w	$3E(a0),d2
		jmp	(MoveSprite_CircularSimple).l
; ---------------------------------------------------------------------------

loc_6F67E:
		bsr.w	sub_6F8F2
		beq.s	loc_6F69C
		move.b	#$1A,routine(a0)
		cmpi.b	#$A,subtype(a0)
		bne.s	loc_6F69C
		movea.w	$44(a0),a1
		bset	#3,$38(a1)

loc_6F69C:
		move.w	$3E(a0),d2
		jmp	(MoveSprite_CircularSimple).l
; ---------------------------------------------------------------------------

loc_6F6A6:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	loc_6F6BC
		move.w	$3E(a0),d2
		jmp	(MoveSprite_CircularSimple).l
; ---------------------------------------------------------------------------

loc_6F6BC:
		move.b	#$1C,routine(a0)
		bset	#3,$38(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6F702,$34(a0)
		cmpi.b	#$A,subtype(a0)
		bne.w	locret_6EF58
		bra.w	loc_6F91C
; ---------------------------------------------------------------------------

loc_6F6E4:
		cmpi.b	#$A,subtype(a0)
		beq.s	loc_6F6F6
		bsr.w	sub_6F93A
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6F6F6:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6F702:
		move.b	#$1E,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6F72E,$34(a0)
		moveq	#signextendB(sfx_MechaLand),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_6F720:
		move.b	#$16,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F728:
		jsr	(Obj_Wait).l

loc_6F72E:
		move.b	#$1C,routine(a0)
		neg.w	x_vel(a0)
		neg.w	y_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6F720,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F74C:
		lea	(ObjDat_FBZEggPrison).l,a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_6F764,(a0)
		move.b	#1,mapping_frame(a0)

loc_6F764:
		bsr.w	sub_6F786
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	loc_6F780
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6F780:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_6F786:
		moveq	#$23,d1
		moveq	#$20,d2
		moveq	#$1C,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectFull).l
; End of function sub_6F786


; =============== S U B R O U T I N E =======================================


sub_6F796:
		moveq	#$1B,d1
		moveq	#8,d2
		moveq	#$D,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectFull).l
; End of function sub_6F796

; ---------------------------------------------------------------------------

loc_6F7A6:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_6F7C0(pc,d0.w),$2E(a0)
		add.w	d0,d0
		lea	word_6F7C6(pc,d0.w),a1
		move.w	(a1)+,d1
		move.w	(a1)+,(a0,d1.w)
		rts
; ---------------------------------------------------------------------------
word_6F7C0:
		dc.w    $20
		dc.w    $20
		dc.w    $40
word_6F7C6:
		dc.w  x_vel,  -$40
		dc.w  x_vel,   $40
		dc.w  y_vel,   $40

; =============== S U B R O U T I N E =======================================


sub_6F7D2:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_6F7E6-2(pc,d0.w),d0
		move.w	d0,x_vel(a0)
		move.w	d0,y_vel(a0)
		rts
; End of function sub_6F7D2

; ---------------------------------------------------------------------------
word_6F7E6:
		dc.w  -$C0
		dc.w -$180
		dc.w -$240
		dc.w -$300
		dc.w -$3C0
		dc.w -$530

; =============== S U B R O U T I N E =======================================


sub_6F7F2:
		move.b	$3C(a0),d0
		moveq	#0,d1
		btst	#0,render_flags(a0)
		beq.s	loc_6F802
		addq.w	#2,d1

loc_6F802:
		move.b	$40(a0),d2
		bmi.s	loc_6F814
		move.b	byte_6F82C(pc,d1.w),d3
		cmp.b	d3,d0
		bhs.s	loc_6F81E
		bra.w	loc_6F820
; ---------------------------------------------------------------------------

loc_6F814:
		addq.w	#1,d1
		move.b	byte_6F82C(pc,d1.w),d3
		cmp.b	d3,d0
		bhi.s	loc_6F820

loc_6F81E:
		neg.b	d2

loc_6F820:
		move.b	d2,$40(a0)
		add.b	d2,d0
		move.b	d0,$3C(a0)
		rts
; End of function sub_6F7F2

; ---------------------------------------------------------------------------
byte_6F82C:
		dc.b  $B0
		dc.b  $80
		dc.b  $80
		dc.b  $50
		even

; =============== S U B R O U T I N E =======================================


sub_6F830:
		btst	#0,render_flags(a0)
		bne.s	loc_6F84A
		addq.b	#2,$3C(a0)
		moveq	#-$40,d0
		cmp.b	$3C(a0),d0
		bhi.s	loc_6F856

loc_6F844:
		move.b	d0,$3C(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F84A:
		subq.b	#2,$3C(a0)
		moveq	#$40,d0
		cmp.b	$3C(a0),d0
		bhs.s	loc_6F844

loc_6F856:
		moveq	#0,d0
		rts
; End of function sub_6F830


; =============== S U B R O U T I N E =======================================


sub_6F85A:
		move.b	$3C(a0),d0
		moveq	#0,d1
		move.b	subtype(a0),d1
		movea.w	parent3(a0),a1
		move.b	$40(a1),d2
		move.b	d2,$40(a0)
		lsr.w	#1,d1
		btst	#0,render_flags(a0)
		bne.s	loc_6F888
		move.b	byte_6F8BE-1(pc,d1.w),d3
		sub.b	d2,d0
		cmp.b	d3,d0
		bls.s	loc_6F892
		bra.w	loc_6F8B8
; ---------------------------------------------------------------------------

loc_6F888:
		move.b	byte_6F8C3-1(pc,d1.w),d3
		add.b	d2,d0
		cmp.b	d3,d0
		blo.s	loc_6F8B8

loc_6F892:
		move.b	d3,d0
		move.b	d4,routine(a0)
		addq.b	#2,$40(a0)
		cmpi.b	#$A,subtype(a0)
		bne.s	loc_6F8B8
		movea.w	$44(a0),a1
		movea.w	parent3(a1),a1
		bset	#2,$38(a1)
		bset	#6,$3A(a1)

loc_6F8B8:
		move.b	d0,$3C(a0)
		rts
; End of function sub_6F85A

; ---------------------------------------------------------------------------
byte_6F8BE:
		dc.b  $A0, $88, $60, $48, $38
byte_6F8C3:
		dc.b  $60, $78, $90, $B8, $CC
		even

; =============== S U B R O U T I N E =======================================


sub_6F8C8:
		btst	#0,render_flags(a0)
		bne.s	loc_6F8E2
		addq.b	#2,$3C(a0)
		moveq	#-$60,d0
		cmp.b	$3C(a0),d0
		bhi.s	loc_6F8EE

loc_6F8DC:
		move.b	d0,$3C(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F8E2:
		subq.b	#2,$3C(a0)
		moveq	#$60,d0
		cmp.b	$3C(a0),d0
		bhs.s	loc_6F8DC

loc_6F8EE:
		moveq	#0,d0
		rts
; End of function sub_6F8C8


; =============== S U B R O U T I N E =======================================


sub_6F8F2:
		btst	#0,render_flags(a0)
		bne.s	loc_6F90C
		subq.b	#2,$3C(a0)
		moveq	#-$80,d0
		cmp.b	$3C(a0),d0
		blo.s	loc_6F918

loc_6F906:
		move.b	d0,$3C(a0)
		rts
; ---------------------------------------------------------------------------

loc_6F90C:
		addq.b	#2,$3C(a0)
		moveq	#-$80,d0
		cmp.b	$3C(a0),d0
		blo.s	loc_6F906

loc_6F918:
		moveq	#0,d0
		rts
; End of function sub_6F8F2

; ---------------------------------------------------------------------------

loc_6F91C:
		move.w	$30(a0),d0
		sub.w	x_pos(a0),d0
		lsl.w	#3,d0
		move.w	d0,x_vel(a0)
		move.w	$32(a0),d0
		sub.w	y_pos(a0),d0
		lsl.w	#3,d0
		move.w	d0,y_vel(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_6F93A:
		movea.w	$32(a0),a1
		movea.w	$30(a0),a2
		moveq	#0,d2
		move.b	subtype(a0),d2
		lsr.w	#1,d2
		moveq	#0,d0
		move.w	x_pos(a1),d0
		move.w	x_pos(a2),d3
		sub.w	d3,d0
		smi	d1
		bpl.s	loc_6F95C
		neg.w	d0

loc_6F95C:
		divu.w	#5,d0
		mulu.w	d2,d0
		tst.b	d1
		beq.s	loc_6F968
		neg.w	d0

loc_6F968:
		add.w	d0,d3
		move.w	d3,x_pos(a0)
		moveq	#0,d0
		move.w	y_pos(a1),d0
		move.w	y_pos(a2),d3
		sub.w	d3,d0
		smi	d1
		bpl.s	loc_6F980
		neg.w	d0

loc_6F980:
		divu.w	#5,d0
		mulu.w	d2,d0
		tst.b	d1
		beq.s	loc_6F98C
		neg.w	d0

loc_6F98C:
		add.w	d0,d3
		move.w	d3,y_pos(a0)
		rts
; End of function sub_6F93A


; =============== S U B R O U T I N E =======================================


sub_6F994:
		btst	#6,$3A(a0)
		beq.s	locret_6F9DC
		tst.b	$20(a0)
		bne.s	loc_6F9B6
		subq.b	#1,collision_property(a0)
		beq.s	loc_6F9DE
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

loc_6F9B6:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_6F9C2
		addq.w	#2*4,d0

loc_6F9C2:
		lea	word_6F9FC(pc),a1
		lea	word_6FA04(pc,d0.w),a2
		jsr	(CopyWordData_4).l
		subq.b	#1,$20(a0)
		bne.s	locret_6F9DC
		bclr	#6,$3A(a0)

locret_6F9DC:
		rts
; ---------------------------------------------------------------------------

loc_6F9DE:
		move.l	#loc_6EF88,(a0)
		bset	#7,status(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		jmp	(BossDefeated_StopTimer).l
; End of function sub_6F994

; ---------------------------------------------------------------------------
word_6F9FC:
		dc.w Normal_palette_line_2+$04, Normal_palette_line_2+$08, Normal_palette_line_2+$16, Normal_palette_line_2+$1E
word_6FA04:
		dc.w   $222,  $644,  $222,   $44
		dc.w   $AAA,  $AAA,  $EEE,  $EEE

; =============== S U B R O U T I N E =======================================


sub_6FA14:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_6FA22
		rts
; ---------------------------------------------------------------------------

loc_6FA22:
		move.l	#loc_6F3B2,(a0)
		bset	#7,status(a0)
		clr.b	collision_flags(a0)
		rts
; End of function sub_6FA14

; ---------------------------------------------------------------------------
ObjDat_FBZMiniboss:
		dc.l Map_FBZMiniboss
		dc.w make_art_tile($52E,1,1)
		dc.w   $200
		dc.b  $20, $20,   0,   0
word_6FA40:
		dc.w   $100
		dc.b    8,   8,   1,   0
word_6FA46:
		dc.w   $300
		dc.b  $18, $10,   5,   0
word_6FA4C:
		dc.w   $280
		dc.b    8,   8,   6,   0
word_6FA52:
		dc.w   $200
		dc.b  $18, $18,   7,   0
word_6FA58:
		dc.w   $100
		dc.b  $10,   8,   8,   0
word_6FA5E:
		dc.w   $180
		dc.b  $10,   8, $11,   0
word_6FA64:	; used in S3, unused in S&K
		dc.w   $280
		dc.b  $10,   8,   4,   0
ObjDat3_6FA6A:	; unused
		dc.l Map_EggCapsule
		dc.w make_art_tile($494,0,1)
		dc.w   $100
		dc.b    8,   8,   0,   0
ChildObjDat_6FA76:
		dc.w 7-1
		dc.l loc_6F10E
		dc.b -$10,  -8
		dc.l loc_6F10E
		dc.b  $10,  -8
		dc.l loc_6F10E
		dc.b    0,  -8
		dc.l loc_6EFDA
		dc.b    0,-$24
		dc.l loc_6F060
		dc.b    0,  -8
		dc.l loc_6F178
		dc.b    0,   0
		dc.l loc_6F178
		dc.b    0,   0
word_6FAA2:
		dc.w 5-1
		dc.l loc_6F3DE
ChildObjDat_6FAA8:
		dc.w 1-1
		dc.l loc_6F0CE
		dc.b    0,  -8
ChildObjDat_6FAB0:
		dc.w 1-1
		dc.l loc_6F74C
		dc.b    3,   9,  $A,  $B,  $C,  $D,  $E,  $F, $10, $FC
		even
Pal_FBZMiniboss:
		binclude "Levels/FBZ/Palettes/FBZ Miniboss.bin"
		even
word_6FAE0:	palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_2+$1E, 1, 7-1
.data	palscriptdata	1, $EEE
	palscriptdata	4, $644
	palscriptrun

Map_FBZMiniboss:
		include "Levels/FBZ/Misc Object Data/Map - Miniboss.asm"
