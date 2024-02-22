Obj_LRZEndBoss:
		move.w	a0,(_unkFAA4).w
		move.l	#loc_797C6,(a0)
		lea	(ArtKosM_LRZEndBoss).l,a1
		move.w	#tiles_to_bytes($3CC),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_LRZ3PlatformDebris).l,a1
		move.w	#tiles_to_bytes($487),d2
		jsr	(Queue_Kos_Module).l
		lea	(PLC_BossExplosion).l,a1
		jsr	(Load_PLC_Raw).l
		lea	Pal_LRZEndBoss(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_797C6:
		btst	#0,(_unkFA88).w
		beq.w	locret_797F8
		move.b	#1,(Boss_flag).w
		move.l	#Obj_Wait,(a0)
		move.w	#2*60,$2E(a0)
		move.l	#loc_797EC,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_797EC:
		move.l	#loc_797FA,(a0)
		move.b	#mus_EndBoss,(Current_music+1).w

locret_797F8:
		rts
; ---------------------------------------------------------------------------

loc_797FA:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_79812(pc,d0.w),d1
		jsr	off_79812(pc,d1.w)
		bsr.w	sub_79F58
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_79812:
		dc.w loc_7981E-off_79812
		dc.w loc_79858-off_79812
		dc.w loc_798B8-off_79812
		dc.w loc_7990A-off_79812
		dc.w loc_79936-off_79812
		dc.w loc_79958-off_79812
; ---------------------------------------------------------------------------

loc_7981E:
		lea	ObjDat_LRZEndBoss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.w	#$B10,x_pos(a0)
		move.w	#$640,y_pos(a0)
		move.b	#$E,collision_property(a0)
		move.w	#-$12,angle(a0)
		move.w	#-$580,y_vel(a0)
		moveq	#signextendB(sfx_BossMagma),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_7A18C(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_79858:
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	locret_7986E
		move.w	#$600,d0
		cmp.w	y_pos(a0),d0
		bls.s	loc_79870

locret_7986E:
		rts
; ---------------------------------------------------------------------------

loc_79870:
		move.w	d0,y_pos(a0)
		move.b	#4,routine(a0)
		move.b	#3,$39(a0)
		move.w	#$7F,d0
		move.w	d0,$2E(a0)
		move.w	d0,$3A(a0)
		move.l	#loc_798C6,$34(a0)
		moveq	#1,d0
		btst	#0,render_flags(a0)
		bne.s	loc_798A0
		moveq	#-1,d0

loc_798A0:
		move.w	d0,(_unkFAA2).w
		move.w	d0,(Events_bg+$08).w
		jsr	(AllocateObject).l
		bne.s	locret_798B6
		move.l	#loc_79A54,(a1)

locret_798B6:
		rts
; ---------------------------------------------------------------------------

loc_798B8:
		addq.w	#1,(_unkFA84).w
		bsr.w	sub_79F30
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_798C6:
		subq.b	#1,$39(a0)
		bmi.s	loc_798EA
		subi.w	#$10,$3A(a0)
		move.w	$3A(a0),$2E(a0)
		moveq	#signextendB(sfx_BossProjectile),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_7A19A(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_798EA:
		move.w	#$F7,$2E(a0)
		move.l	#loc_798FA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_798FA:
		move.b	#6,routine(a0)
		clr.b	(Events_bg+$09).w
		clr.w	(_unkFA84).w
		rts
; ---------------------------------------------------------------------------

loc_7990A:
		bsr.w	sub_79F30
		tst.w	(Events_bg+$0A).w
		bne.w	locret_797F8
		move.b	#8,routine(a0)
		clr.b	(_unkFAA3).w
		move.w	#$100,y_vel(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_79942,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_79936:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_79942:
		move.b	#$A,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_7995E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_79958:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7995E:
		move.b	#2,routine(a0)
		move.w	#-$580,y_vel(a0)
		move.w	#$A30,d1
		bchg	#0,render_flags(a0)
		beq.s	loc_7997A
		move.w	#$B10,d1

loc_7997A:
		move.w	d1,x_pos(a0)
		moveq	#signextendB(sfx_BossMagma),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_79988:
		subq.w	#1,$2E(a0)
		bmi.s	loc_79998
		addq.w	#1,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_79998:
		move.l	#loc_799E0,(a0)
		ori.b	#$30,$38(a0)
		bclr	#7,render_flags(a0)
		st	(_unkFAA8).w
		clr.b	(Boss_flag).w
		jsr	(AllocateObject).l
		bne.s	loc_799C6
		move.l	#Obj_EggCapsule,(a1)
		bset	#1,render_flags(a1)

loc_799C6:
		jsr	(AllocateObject).l
		bne.s	loc_799D4
		move.l	#loc_7A100,(a1)

loc_799D4:
		lea	(PLC_EggCapsule).l,a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

loc_799E0:
		tst.b	(_unkFAA8).w
		bne.w	locret_797F8
		move.l	#locret_79A52,(a0)
		bset	#1,(_unkFA88).w
		jsr	(AllocateObject).l
		bne.s	loc_79A08
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_LRZ2,subtype(a1)

loc_79A08:
		jsr	(Restore_PlayerControl).l
		lea	(Player_2).w,a1
		jsr	(Restore_PlayerControl2).l
		clr.w	(Ctrl_1_logical).w
		move.w	#$EC0,(Camera_stored_max_X_pos).w
		jsr	(AllocateObject).l
		bne.s	loc_79A30
		move.l	#Obj_IncLevEndXGradual,(a1)

loc_79A30:
		jsr	(AllocateObject).l
		bne.s	locret_79A50
		move.l	#Obj_StartNewLevel,(a1)
		move.b	#$2D,subtype(a1)
		move.w	#$FE8,x_pos(a1)
		move.w	#$5E0,y_pos(a1)

locret_79A50:
		rts
; ---------------------------------------------------------------------------

locret_79A52:
		rts
; ---------------------------------------------------------------------------

loc_79A54:
		move.l	#loc_79A70,(a0)
		move.w	#$9E0,d0
		tst.b	(_unkFAA3).w
		bmi.s	loc_79A68
		move.w	#$B60,d0

loc_79A68:
		move.w	d0,x_pos(a0)
		bsr.w	sub_79A8E

loc_79A70:
		tst.b	(_unkFAA3).w
		beq.s	loc_79AA8
		movea.w	$44(a0),a1
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		bpl.s	loc_79A86
		neg.w	d0

loc_79A86:
		cmpi.w	#$80,d0
		blo.w	locret_797F8

; =============== S U B R O U T I N E =======================================


sub_79A8E:
		jsr	(AllocateObject).l
		bne.s	locret_79AA6
		move.l	#loc_79E5A,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	a1,$44(a0)

locret_79AA6:
		rts
; End of function sub_79A8E

; ---------------------------------------------------------------------------

loc_79AA8:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_79AAE:
		lea	word_7A14C(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_79AC4,(a0)
		move.w	#-$800,y_vel(a0)

loc_79AC4:
		bsr.w	sub_79EB6
		tst.w	y_vel(a0)
		bmi.s	loc_79B02
		move.l	#loc_79B22,(a0)
		move.w	#$100,priority(a0)
		moveq	#$40,d0
		movea.w	parent3(a0),a1
		btst	#0,render_flags(a1)
		beq.s	loc_79AEC
		move.w	#$140,d0

loc_79AEC:
		move.w	d0,d1
		addi.w	#$9E0,d0
		move.w	d0,x_pos(a0)
		lsr.w	#1,d1
		lea	(HScroll_table+$100).w,a1
		adda.w	d1,a1
		move.w	a1,$44(a0)

loc_79B02:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#3,d0
		bne.s	loc_79B16
		lea	ChildObjDat_7A1A8(pc),a2
		jsr	(CreateChild1_Normal).l

loc_79B16:
		jsr	(MoveSprite_LightGravity).l
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

loc_79B22:
		bsr.w	sub_79EB6
		jsr	(MoveSprite_LightGravity).l
		movea.w	$44(a0),a1
		moveq	#0,d0
		move.b	(a1),d0
		subi.w	#$30,d0
		neg.w	d0
		addi.w	#$612,d0
		cmp.w	y_pos(a0),d0
		bls.s	loc_79B4A
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

loc_79B4A:
		move.l	#loc_79B54,(a0)
		clr.w	y_vel(a0)

loc_79B54:
		bsr.w	sub_79EB6
		tst.b	(_unkFAA3).w
		bne.s	loc_79B66
		tst.b	render_flags(a0)
		bpl.w	loc_79AA8

loc_79B66:
		bsr.w	sub_79F14
		jsr	(MoveSprite2).l
		bsr.w	sub_79F30
		bsr.w	loc_79EC4
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

loc_79B7E:
		lea	word_7A152(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_79B96,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)

loc_79B96:
		jsr	(Refresh_ChildPosition).l
		lea	byte_7A1C7(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_79BAC:
		lea	word_7A158(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_79BCA,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		move.w	#$100,y_vel(a0)

loc_79BCA:
		lea	byte_7A1D8(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		addi.w	#-$10,y_vel(a0)
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_79BE6:
		lea	word_7A15E(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_79BF6,(a0)

loc_79BF6:
		jsr	(Refresh_ChildPosition).l
		lea	byte_7A1C2(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_79C0C:
		lea	word_7A164(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_79C1C,(a0)

loc_79C1C:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		move.b	#$F,mapping_frame(a0)
		btst	#6,status(a1)
		beq.s	loc_79C3E
		move.b	#$10,mapping_frame(a0)
		bra.w	loc_79C4C
; ---------------------------------------------------------------------------

loc_79C3E:
		btst	#7,status(a1)
		beq.s	loc_79C4C
		move.b	#$11,mapping_frame(a0)

loc_79C4C:
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

Obj_LRZ3Platform:
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsl.w	#2,d0
		jmp	LRZ3Platform_Index(pc,d0.w)
; ---------------------------------------------------------------------------

LRZ3Platform_Index:
		bra.w	loc_79C72
; ---------------------------------------------------------------------------
		bra.w	loc_79CCE
; ---------------------------------------------------------------------------
		bra.w	loc_79CCE
; ---------------------------------------------------------------------------
		bra.w	loc_79CDE
; ---------------------------------------------------------------------------
		bra.w	loc_79CF8
; ---------------------------------------------------------------------------

loc_79C72:
		bsr.w	sub_7A040
		beq.w	locret_797F8
		move.l	#loc_79C9E,(a0)
		lea	ChildObjDat_7A1B0(pc),a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_79C9E
		addi.w	#$C0,y_pos(a1)
		move.b	subtype(a0),subtype(a1)
		move.w	#$37F,$2E(a1)

loc_79C9E:
		tst.w	(_unkFAA4).w
		bne.w	loc_79DB6
		subq.w	#1,$2E(a0)
		bpl.w	locret_797F8
		move.w	#$17F,$2E(a0)

; =============== S U B R O U T I N E =======================================


sub_79CB4:
		lea	ChildObjDat_7A1B0(pc),a2
		jsr	(CreateChild6_Simple).l
		bne.s	locret_79CCC
		move.b	subtype(a0),subtype(a1)
		move.w	#$4FF,$2E(a1)

locret_79CCC:
		rts
; End of function sub_79CB4

; ---------------------------------------------------------------------------

loc_79CCE:
		bsr.w	sub_7A040
		beq.w	locret_797F8
		bsr.s	sub_79CB4
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_79CDE:
		lea	ObjDat3_7A16C(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_79CEE,(a0)

loc_79CEE:
		bsr.w	sub_7A064
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------

loc_79CF8:
		lea	ObjDat3_7A178(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_79D08,(a0)

loc_79D08:
		lea	byte_7A1E9(pc),a1
		jsr	(Animate_RawNoSST).l
		moveq	#$2B,d1
		moveq	#$18,d2
		moveq	#$19,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------

loc_79D28:
		lea	ObjDat3_7A16C(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_79D44,(a0)
		move.w	#-$80,y_vel(a0)
		move.w	#$20,$3A(a0)

loc_79D44:
		subq.w	#1,$3A(a0)
		bmi.s	loc_79D52
		bsr.w	sub_7A064
		bra.w	loc_79D82
; ---------------------------------------------------------------------------

loc_79D52:
		move.l	#loc_79D6E,(a0)
		move.w	#$180,priority(a0)
		move.w	#$80,y_vel(a0)
		lea	ChildObjDat_7A1B6(pc),a2
		jsr	(CreateChild6_Simple).l

loc_79D6E:
		bsr.w	sub_7A064
		move.b	subtype(a0),d0
		cmpi.b	#1,d0
		beq.s	loc_79DB0
		subq.w	#1,$2E(a0)
		bmi.s	loc_79DB6

loc_79D82:
		tst.w	(_unkFAA4).w
		beq.s	loc_79DAA
		tst.b	render_flags(a0)
		bpl.s	loc_79DB6
		tst.b	d0
		bne.s	loc_79DAA
		tst.b	(_unkFAA9).w
		bne.s	loc_79DAA
		cmpi.w	#$612,y_pos(a0)
		bhi.s	loc_79DAA
		move.l	#loc_79DC2,(a0)
		st	(_unkFAA9).w

loc_79DAA:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_79DB0:
		tst.b	render_flags(a0)
		bmi.s	loc_79DAA

loc_79DB6:
		jsr	(Displace_PlayerOffObject).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_79DC2:
		bsr.w	sub_7A064
		cmpi.w	#$612,y_pos(a0)
		blo.s	loc_79DAA
		move.l	#loc_79DEA,(a0)
		bset	#0,(_unkFA88).w
		clr.w	y_vel(a0)
		bset	#7,status(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_79DEA:
		bsr.w	sub_79FFE
		tst.b	(_unkFAA3).w
		bne.s	loc_79DFC
		tst.b	render_flags(a0)
		bpl.w	loc_79DB6

loc_79DFC:
		bsr.w	sub_79F14
		bsr.w	sub_7A064
		bsr.w	sub_79F30
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------
		move.l	#loc_79E34,(a0)
		move.w	#$80,x_vel(a0)
		move.w	#$40,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#8,$40(a0)
		bclr	#0,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_79E34:
		jsr	(Swing_UpAndDown).l
		cmpi.w	#$B60,x_pos(a0)
		blo.s	loc_79E50
		move.l	#loc_79E50,(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)

loc_79E50:
		bsr.w	sub_7A064
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------

loc_79E5A:
		lea	ObjDat3_7A16C(pc),a1
		jsr	(SetUp_ObjAttributes).l
		lea	loc_79DEA(pc),a1
		move.l	a1,(a0)
		jmp	(a1)
; ---------------------------------------------------------------------------

loc_79E6C:
		lea	word_7A184(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_79E7C,(a0)

loc_79E7C:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		lea	byte_7A1E5(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_79E9C:
		lea	ObjDat3_7960E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#Obj_FlickerMove,(a0)
		bsr.w	sub_7A07C
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_79EB6:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_79EE6
		rts
; ---------------------------------------------------------------------------

loc_79EC4:
		movea.w	parent3(a0),a1
		btst	#6,status(a1)
		bne.w	locret_797F8
		lea	word_79F0C(pc),a2
		jsr	(Check_InTheirRange).l
		beq.w	locret_797F8
		bset	#6,status(a1)

loc_79EE6:
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_79EFA
		move.b	#6,subtype(a1)

loc_79EFA:
		jsr	(Delete_Current_Sprite).l
		moveq	#signextendB(sfx_ThumpBoss),d0
		jsr	(Play_SFX).l
		addq.w	#4,sp
		rts
; End of function sub_79EB6

; ---------------------------------------------------------------------------
word_79F0C:
		dc.w   -$30,   $60,  -$30,   $60
; =============== S U B R O U T I N E =======================================


sub_79F14:
		move.w	(Events_bg+$0A).w,d0
		move.w	(_unkFA84).w,d1
		lsr.w	#2,d1
		add.w	d1,d0
		add.w	d0,d0
		tst.b	(_unkFAA2).w
		bne.s	loc_79F2A
		neg.w	d0

loc_79F2A:
		move.w	d0,x_vel(a0)
		rts
; End of function sub_79F14


; =============== S U B R O U T I N E =======================================


sub_79F30:
		move.w	x_pos(a0),d0
		subi.w	#$9E0,d0
		lsr.w	#1,d0
		lea	(HScroll_table+$100).w,a1
		moveq	#0,d1
		move.b	(a1,d0.w),d1
		subi.w	#$30,d1
		neg.w	d1
		addi.w	#$612,d1
		add.w	angle(a0),d1
		move.w	d1,y_pos(a0)
		rts
; End of function sub_79F30


; =============== S U B R O U T I N E =======================================


sub_79F58:
		btst	#6,status(a0)
		beq.s	locret_79F98
		tst.b	$20(a0)
		bne.s	loc_79F7A
		subq.b	#1,collision_property(a0)
		beq.s	loc_79F9A
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

loc_79F7A:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_79F88
		addi.w	#2*4,d0

loc_79F88:
		bsr.w	sub_79FD8
		subq.b	#1,$20(a0)
		bne.s	locret_79F98
		bclr	#6,status(a0)

locret_79F98:
		rts
; ---------------------------------------------------------------------------

loc_79F9A:
		move.l	#loc_79988,(a0)
		bset	#7,status(a0)
		clr.b	(_unkFAA3).w
		clr.w	(_unkFA84).w
		st	(Events_fg_5).w
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_79FC6
		move.b	#4,subtype(a1)

loc_79FC6:
		clr.b	(Events_bg+$09).w
		jsr	(BossDefeated_StopTimer).l
		move.w	#$7F,$2E(a0)
		rts
; End of function sub_79F58


; =============== S U B R O U T I N E =======================================


sub_79FD8:
		lea	word_79FE6(pc),a1
		lea	word_79FEE(pc,d0.w),a2
		jmp	(CopyWordData_4).l
; End of function sub_79FD8

; ---------------------------------------------------------------------------
word_79FE6:
		dc.w Normal_palette_line_2+$08, Normal_palette_line_2+$18, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_79FEE:
		dc.w   $406,  $646,  $424,     0
		dc.w   $EEE,  $EEE,  $EEE,  $EEE

; =============== S U B R O U T I N E =======================================


sub_79FFE:
		movea.w	(_unkFAA4).w,a1
		tst.w	(a1)
		beq.w	locret_797F8
		lea	word_7A038(pc),a2
		jsr	(Check_InTheirRange).l
		beq.w	locret_797F8
		lea	ChildObjDat_7A1BC(pc),a2
		jsr	(CreateChild6_Simple).l
		jsr	(Go_Delete_Sprite).l
		jsr	(Displace_PlayerOffObject).l
		moveq	#signextendB(sfx_Clank),d0
		jsr	(Play_SFX).l
		addq.w	#4,sp
		rts
; End of function sub_79FFE

; ---------------------------------------------------------------------------
word_7A038:
		dc.w   -$40,   $80,  -$40,   $80

; =============== S U B R O U T I N E =======================================


sub_7A040:
		move.w	x_pos(a0),d0
		sub.w	(Camera_X_pos).w,d0
		cmpi.w	#$140,d0
		bhs.s	loc_7A060
		move.w	y_pos(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		cmpi.w	#$E0,d0
		bhs.s	loc_7A060
		moveq	#1,d0
		rts
; ---------------------------------------------------------------------------

loc_7A060:
		moveq	#0,d0
		rts
; End of function sub_7A040


; =============== S U B R O U T I N E =======================================


sub_7A064:
		move.w	x_pos(a0),-(sp)
		jsr	(MoveSprite2).l
		moveq	#$23,d1
		moveq	#$10,d2
		moveq	#$D,d3
		move.w	(sp)+,d4
		jmp	(SolidObjectTop).l
; End of function sub_7A064


; =============== S U B R O U T I N E =======================================


sub_7A07C:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,d1
		lsr.w	#1,d0
		move.b	RawAni_7A0BA(pc,d0.w),mapping_frame(a0)
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d2
		move.w	y_pos(a1),d3
		lea	byte_7A0C4(pc,d1.w),a2
		move.b	(a2)+,d0
		ext.w	d0
		add.w	d0,d2
		move.b	(a2)+,d0
		ext.w	d0
		add.w	d0,d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		add.w	d1,d1
		move.l	word_7A0D8(pc,d1.w),x_vel(a0)	; and y_vel
		rts
; End of function sub_7A07C

; ---------------------------------------------------------------------------
RawAni_7A0BA:
		dc.b    1,   1,   1,   1,   1,   3,   2,   3,   2,   3
		even
byte_7A0C4:
		dc.b -$10,  -8
		dc.b    0,  -8
		dc.b  $10,  -8
		dc.b   -8,   8
		dc.b    8,   8
		dc.b  -$C,  -4
		dc.b   $C,  -4
		dc.b -$14,   8
		dc.b  $14,   8
		dc.b    0,  $C
word_7A0D8:
		dc.w  -$280, -$300
		dc.w    $80, -$380
		dc.w   $280, -$300
		dc.w  -$200, -$280
		dc.w   $200, -$280
		dc.w  -$300, -$300
		dc.w   $300, -$280
		dc.w  -$300, -$380
		dc.w   $300, -$380
		dc.w   -$80, -$400
; ---------------------------------------------------------------------------

loc_7A100:
		tst.b	(_unkFACD).w
		beq.w	locret_797F8
		move.l	#loc_7A12A,(a0)
		lea	word_78EAA(pc),a1
		lea	(Palette_rotation_data).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		clr.w	(a2)
		move.l	#loc_7A138,(Palette_rotation_custom).w
		move.w	#$7FFF,(Palette_cycle_counter1).w

loc_7A12A:
		jsr	(Run_PalRotationScript).l

loc_7A130:
		move.w	#$7FFF,(Palette_cycle_counter1).w
		rts
; ---------------------------------------------------------------------------

loc_7A138:
		move.l	#loc_7A130,(a0)
		rts
; ---------------------------------------------------------------------------
ObjDat_LRZEndBoss:
		dc.l Map_LRZEndBoss
		dc.w make_art_tile($3CC,1,0)
		dc.w   $280
		dc.b  $28, $2C,   0, $B8
word_7A14C:
		dc.w   $280
		dc.b  $10, $10,   4, $9A
word_7A152:
		dc.w   $280
		dc.b  $10, $10,   5,   0
word_7A158:
		dc.w   $280
		dc.b    8,   8,  $A,   0
word_7A15E:
		dc.w   $200
		dc.b  $28,   4,   1,   0
word_7A164:
		dc.w make_art_tile($3CC,0,0)
		dc.w   $200
		dc.b   $C,   8,  $F,   0
ObjDat3_7A16C:
		dc.l Map_LRZ3Platform
		dc.w make_art_tile($001,3,0)
		dc.w   $280
		dc.b  $18, $10,   1,   0
ObjDat3_7A178:
		dc.l Map_LRZ3Platform
		dc.w make_art_tile($001,3,0)
		dc.w   $280
		dc.b  $20, $18,   4,   0
word_7A184:
		dc.w make_art_tile($001,2,0)
		dc.w   $100
		dc.b  $20,   8,   2,   0
ChildObjDat_7A18C:
		dc.w 2-1
		dc.l loc_79BE6
		dc.b    0,-$12
		dc.l loc_79C0C
		dc.b -$15,   1
ChildObjDat_7A19A:
		dc.w 2-1
		dc.l loc_79AAE
		dc.b    0,-$18
		dc.l loc_79B7E
		dc.b    0,-$37
ChildObjDat_7A1A8:
		dc.w 1-1
		dc.l loc_79BAC
		dc.b    0, $10
ChildObjDat_7A1B0:
		dc.w 1-1
		dc.l loc_79D28
ChildObjDat_7A1B6:
		dc.w 1-1
		dc.l loc_79E6C
ChildObjDat_7A1BC:
		dc.w $A-1
		dc.l loc_79E9C
byte_7A1C2:
		dc.b    2,   1,   2,   3, $FC
byte_7A1C7:
		dc.b    5,   0
		dc.b    5,   0
		dc.b    6,   1
		dc.b    5,   0
		dc.b    6,   1
		dc.b    7,   3
		dc.b    8,   4
		dc.b    9,   5
		dc.b  $F4
byte_7A1D8:
		dc.b   $A,   2
		dc.b   $A,   2
		dc.b   $B,   3
		dc.b   $C,   4
		dc.b   $D,   5
		dc.b   $E,   5
		dc.b  $F4
byte_7A1E5:
		dc.b    3,   2,   3, $FC
byte_7A1E9:
		dc.b    7,   4,   5, $FC
		even
Pal_LRZEndBoss:
		binclude "Levels/LRZ/Palettes/End Boss.bin"
		even
; ---------------------------------------------------------------------------
