Obj_SSZMTZBoss:
		move.l	#Obj_Wait,(a0)
		move.b	#1,(Boss_flag).w
		move.w	#$1F,$2E(a0)
		move.l	#loc_7A712,$34(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		jsr	(AllocateObject).l
		bne.s	+ ;loc_7A6DC
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_EndBoss,subtype(a1)

+ ;loc_7A6DC:
		clr.w	(_unkFA88).w
		moveq	#$7B,d0
		jsr	(Load_PLC).l
		lea	(ArtKosM_SSZMTZOrbs).l,a1
		move.w	#tiles_to_bytes($41F),d2
		jsr	(Queue_Kos_Module).l
		lea	(Normal_palette_line_2).w,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

- ;loc_7A702:
		move.l	(a1)+,(a2)+
		dbf	d6,- ;loc_7A702
		lea	Pal_SSZMTZOrbs(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_7A712:
		move.l	#loc_7A71A,(a0)

locret_7A718:
		rts
; ---------------------------------------------------------------------------

loc_7A71A:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_7A728(pc,d0.w),d1
		jmp	off_7A728(pc,d1.w)
; ---------------------------------------------------------------------------
off_7A728:
		dc.w loc_7A72C-off_7A728
		dc.w loc_7A7E2-off_7A728
; ---------------------------------------------------------------------------

loc_7A72C:
		move.l	#Map_RobotnikShip,mappings(a0)
		move.w	#make_art_tile($52E,0,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$180,priority(a0)
		move.w	#$1700,x_pos(a0)
		move.w	#$300,y_pos(a0)
		move.b	#$A,mapping_frame(a0)
		addq.b	#2,routine(a0)
		move.b	#$11,collision_flags(a0)
		move.b	#8,collision_property(a0)
		move.b	#7,$3C(a0)
		move.w	x_pos(a0),(SSZ_MTZ_boss_X_pos).w
		move.w	y_pos(a0),(SSZ_MTZ_boss_Y_pos).w
		move.w	#0,(SSZ_MTZ_boss_X_vel).w
		move.w	#$100,(SSZ_MTZ_boss_Y_vel).w
		move.b	#$20,width_pixels(a0)
		clr.b	$2E(a0)
		clr.b	$30(a0)
		move.b	#$40,$1D(a0)
		move.b	#$27,$38(a0)
		move.b	#$27,$3A(a0)
		lea	(Child1_MakeMechaHead).l,a2
		jsr	(CreateChild1_Normal).l
		jsr	(AllocateObject).l
		bne.s	+ ;loc_7A7C4
		move.l	#loc_7AD8A,(a1)
		move.l	a0,$34(a1)

+ ;loc_7A7C4:
		lea	(_unkFA82).w,a2
		move.b	#$10,(a2)+
		move.b	#0,(a2)+
		move.b	#3,(a2)+
		move.b	#0,(a2)+
		move.b	#1,(a2)+
		move.b	#0,(a2)+
		rts
; ---------------------------------------------------------------------------

loc_7A7E2:
		moveq	#0,d0
		move.b	$26(a0),d0
		move.w	off_7A7F0(pc,d0.w),d1
		jmp	off_7A7F0(pc,d1.w)
; ---------------------------------------------------------------------------
off_7A7F0:
		dc.w loc_7A800-off_7A7F0
		dc.w loc_7A874-off_7A7F0
		dc.w loc_7A8F4-off_7A7F0
		dc.w loc_7A93C-off_7A7F0
		dc.w loc_7A95A-off_7A7F0
		dc.w loc_7A98A-off_7A7F0
		dc.w loc_7A9D4-off_7A7F0
		dc.w loc_7AA44-off_7A7F0
; ---------------------------------------------------------------------------

loc_7A800:
		bsr.w	Boss_MoveObject
		move.w	(SSZ_MTZ_boss_Y_pos).w,$14(a0)
		cmpi.w	#$420,(SSZ_MTZ_boss_Y_pos).w
		blo.s	+ ;loc_7A84A
		addq.b	#2,$26(a0)
		move.w	#0,(SSZ_MTZ_boss_Y_vel).w
		move.w	#-$100,(SSZ_MTZ_boss_X_vel).w
		bclr	#7,$2E(a0)
		bclr	#0,render_flags(a0)
		move.w	(Player_1+x_pos).w,d0
		cmp.w	(SSZ_MTZ_boss_X_pos).w,d0
		blo.s	+ ;loc_7A84A
		move.w	#$100,(SSZ_MTZ_boss_X_vel).w
		bset	#7,$2E(a0)
		bset	#0,render_flags(a0)

+ ;loc_7A84A:
		bsr.w	sub_7AC06
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_7A85A:
		move.b	$1D(a0),d0
		jsr	(GetSineCosine).l
		asr.w	#6,d0
		add.w	(SSZ_MTZ_boss_Y_pos).w,d0
		move.w	d0,y_pos(a0)
		addq.b	#4,$1D(a0)
		rts
; End of function sub_7A85A

; ---------------------------------------------------------------------------

loc_7A874:
		bsr.w	Boss_MoveObject
		btst	#7,$2E(a0)
		bne.s	+ ;loc_7A8AE
		cmpi.w	#$1680,(SSZ_MTZ_boss_X_pos).w
		bhs.s	loc_7A8DA
		bchg	#7,$2E(a0)
		move.w	#$100,(SSZ_MTZ_boss_X_vel).w
		bset	#0,render_flags(a0)
		bset	#6,$2E(a0)
		beq.s	loc_7A8DA
		addq.b	#2,$26(a0)
		move.w	#-$100,(SSZ_MTZ_boss_Y_vel).w
		bra.s	loc_7A8DA
; ---------------------------------------------------------------------------

+ ;loc_7A8AE:
		cmpi.w	#$1780,(SSZ_MTZ_boss_X_pos).w
		blo.s	loc_7A8DA
		bchg	#7,$2E(a0)
		move.w	#-$100,(SSZ_MTZ_boss_X_vel).w
		bclr	#0,render_flags(a0)
		bset	#6,$2E(a0)
		beq.s	loc_7A8DA
		addq.b	#2,$26(a0)
		move.w	#-$100,(SSZ_MTZ_boss_Y_vel).w

loc_7A8DA:
		move.w	(SSZ_MTZ_boss_X_pos).w,x_pos(a0)
		bsr.w	sub_7A85A

loc_7A8E4:
		bsr.w	sub_7AC06
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7A8F4:
		bsr.w	Boss_MoveObject
		cmpi.w	#$3F0,(SSZ_MTZ_boss_Y_pos).w
		bhs.s	+ ;loc_7A906
		move.w	#0,(SSZ_MTZ_boss_Y_vel).w

+ ;loc_7A906:
		btst	#7,$2E(a0)
		bne.s	+ ;loc_7A91E
		cmpi.w	#$1700,(SSZ_MTZ_boss_X_pos).w
		bhs.s	++ ;loc_7A92C
		move.w	#0,(SSZ_MTZ_boss_X_vel).w
		bra.s	++ ;loc_7A92C
; ---------------------------------------------------------------------------

+ ;loc_7A91E:
		cmpi.w	#$1700,(SSZ_MTZ_boss_X_pos).w
		blo.s	+ ;loc_7A92C
		move.w	#0,(SSZ_MTZ_boss_X_vel).w

+ ;loc_7A92C:
		move.w	(SSZ_MTZ_boss_X_vel).w,d0
		or.w	(SSZ_MTZ_boss_Y_vel).w,d0
		bne.s	+ ;loc_7A93A
		addq.b	#2,$26(a0)

+ ;loc_7A93A:
		bra.s	loc_7A8DA
; ---------------------------------------------------------------------------

loc_7A93C:
		cmpi.b	#$68,$38(a0)
		bhs.s	+ ;loc_7A94E
		addq.b	#1,$38(a0)
		addq.b	#1,$3A(a0)
		bra.s	++ ;loc_7A958
; ---------------------------------------------------------------------------

+ ;loc_7A94E:
		subq.b	#1,$3A(a0)
		bne.s	+ ;loc_7A958
		addq.b	#2,$26(a0)

+ ;loc_7A958:
		bra.s	loc_7A8DA
; ---------------------------------------------------------------------------

loc_7A95A:
		cmpi.b	#$27,$38(a0)
		blo.s	+ ;loc_7A968
		subq.b	#1,$38(a0)
		bra.s	++ ;loc_7A986
; ---------------------------------------------------------------------------

+ ;loc_7A968:
		addq.b	#1,$3A(a0)
		cmpi.b	#$27,$3A(a0)
		blo.s	+ ;loc_7A986
		move.w	#$100,(SSZ_MTZ_boss_Y_vel).w
		move.b	#0,$26(a0)
		bclr	#6,$2E(a0)

+ ;loc_7A986:
		bra.w	loc_7A8DA
; ---------------------------------------------------------------------------

loc_7A98A:
		tst.b	$3A(a0)
		beq.s	+ ;loc_7A996
		subq.b	#1,$3A(a0)
		bra.s	++ ;loc_7A99C
; ---------------------------------------------------------------------------

+ ;loc_7A996:
		move.b	#-1,$3B(a0)

+ ;loc_7A99C:
		cmpi.b	#$27,$38(a0)
		blo.s	+ ;loc_7A9A8
		subq.b	#1,$38(a0)

+ ;loc_7A9A8:
		bsr.w	Boss_MoveObject
		cmpi.w	#$3B0,(SSZ_MTZ_boss_Y_pos).w
		bhs.s	+ ;loc_7A9BA
		move.w	#0,(SSZ_MTZ_boss_Y_vel).w

+ ;loc_7A9BA:
		tst.b	$30(a0)
		bne.s	loc_7A9D0
		tst.b	$3B(a0)
		beq.s	+ ;loc_7A9CC
		move.b	#$80,$3B(a0)

+ ;loc_7A9CC:
		addq.b	#2,$26(a0)

loc_7A9D0:
		bra.w	loc_7A8DA
; ---------------------------------------------------------------------------

loc_7A9D4:
		tst.b	$3C(a0)
		beq.s	++ ;loc_7AA02
		tst.b	$3B(a0)
		bne.s	loc_7AA40
		cmpi.b	#$27,$3A(a0)
		bhs.s	+ ;loc_7A9EE
		addq.b	#1,$3A(a0)
		bra.s	loc_7AA40
; ---------------------------------------------------------------------------

+ ;loc_7A9EE:
		move.w	#$100,(SSZ_MTZ_boss_Y_vel).w
		move.b	#0,$26(a0)
		bclr	#6,$2E(a0)
		bra.s	loc_7AA40
; ---------------------------------------------------------------------------

+ ;loc_7AA02:
		move.w	#-$180,(SSZ_MTZ_boss_Y_vel).w
		move.w	#-$100,(SSZ_MTZ_boss_X_vel).w
		bclr	#0,render_flags(a0)
		btst	#7,$2E(a0)
		beq.s	+ ;loc_7AA28
		move.w	#$100,(SSZ_MTZ_boss_X_vel).w
		bset	#0,render_flags(a0)

+ ;loc_7AA28:
		move.b	#$E,$26(a0)
		move.b	#0,$32(a0)
		bclr	#6,$2E(a0)
		move.b	#0,$33(a0)

loc_7AA40:
		bra.w	loc_7A8DA
; ---------------------------------------------------------------------------

loc_7AA44:
		tst.b	$33(a0)
		beq.s	+ ;loc_7AA52
		subq.b	#1,$33(a0)
		bra.w	loc_7A8E4
; ---------------------------------------------------------------------------

+ ;loc_7AA52:
		moveq	#0,d0
		move.b	$32(a0),d0
		move.w	off_7AA60(pc,d0.w),d1
		jmp	off_7AA60(pc,d1.w)
; ---------------------------------------------------------------------------
off_7AA60:
		dc.w loc_7AA66-off_7AA60
		dc.w loc_7AACE-off_7AA60
		dc.w loc_7AB1A-off_7AA60
; ---------------------------------------------------------------------------

loc_7AA66:
		bsr.w	Boss_MoveObject
		cmpi.w	#$3B0,(SSZ_MTZ_boss_Y_pos).w
		bhs.s	+ ;loc_7AA78
		move.w	#0,(SSZ_MTZ_boss_Y_vel).w

+ ;loc_7AA78:
		btst	#7,$2E(a0)
		bne.s	+ ;loc_7AAA6
		cmpi.w	#$16A0,(SSZ_MTZ_boss_X_pos).w
		bhs.s	++ ;loc_7AACA
		addq.b	#2,$32(a0)
		move.w	#$180,(SSZ_MTZ_boss_Y_vel).w
		move.b	#3,$31(a0)
		move.w	#$1E,(SSZ_MTZ_boss_laser_timer).w
		bset	#0,render_flags(a0)
		bra.s	++ ;loc_7AACA
; ---------------------------------------------------------------------------

+ ;loc_7AAA6:
		cmpi.w	#$1760,(SSZ_MTZ_boss_X_pos).w
		blo.s	+ ;loc_7AACA
		addq.b	#2,$32(a0)
		move.w	#$180,(SSZ_MTZ_boss_Y_vel).w
		move.b	#3,$31(a0)
		move.w	#$1E,(SSZ_MTZ_boss_laser_timer).w
		bclr	#0,render_flags(a0)

+ ;loc_7AACA:
		bra.w	loc_7A8DA
; ---------------------------------------------------------------------------

loc_7AACE:
		bsr.w	Boss_MoveObject
		cmpi.w	#$420,(SSZ_MTZ_boss_Y_pos).w
		blo.s	+ ;loc_7AAEC
		move.w	#-$180,(SSZ_MTZ_boss_Y_vel).w
		addq.b	#2,$32(a0)
		bchg	#7,$2E(a0)
		bra.s	+++ ;loc_7AB12
; ---------------------------------------------------------------------------

+ ;loc_7AAEC:
		btst	#7,$2E(a0)
		bne.s	+ ;loc_7AB04
		cmpi.w	#$1680,(SSZ_MTZ_boss_X_pos).w
		bhs.s	++ ;loc_7AB12
		move.w	#0,(SSZ_MTZ_boss_X_vel).w
		bra.s	++ ;loc_7AB12
; ---------------------------------------------------------------------------

+ ;loc_7AB04:
		cmpi.w	#$1780,(SSZ_MTZ_boss_X_pos).w
		blo.s	+ ;loc_7AB12
		move.w	#0,(SSZ_MTZ_boss_X_vel).w

+ ;loc_7AB12:
		bsr.w	sub_7AB56
		bra.w	loc_7A8DA
; ---------------------------------------------------------------------------

loc_7AB1A:
		bsr.w	Boss_MoveObject
		cmpi.w	#$3F0,(SSZ_MTZ_boss_Y_pos).w
		bhs.s	+ ;loc_7AB3A
		move.w	#$100,(SSZ_MTZ_boss_X_vel).w
		btst	#7,$2E(a0)
		bne.s	+ ;loc_7AB3A
		move.w	#-$100,(SSZ_MTZ_boss_X_vel).w

+ ;loc_7AB3A:
		cmpi.w	#$3B0,(SSZ_MTZ_boss_Y_pos).w
		bhs.s	+ ;loc_7AB4E
		move.w	#0,(SSZ_MTZ_boss_Y_vel).w
		move.b	#0,$32(a0)

+ ;loc_7AB4E:
		bsr.w	sub_7AB56
		bra.w	loc_7A8DA

; =============== S U B R O U T I N E =======================================


sub_7AB56:
		subi.w	#1,(SSZ_MTZ_boss_laser_timer).w
		bne.s	locret_7AB7E
		tst.b	$31(a0)
		beq.s	locret_7AB7E
		subq.b	#1,$31(a0)
		move.b	#$10,$33(a0)
		move.w	#$1E,(SSZ_MTZ_boss_laser_timer).w
		lea	ChildObjDat_7AB80(pc),a2
		jsr	(CreateChild1_Normal).l

locret_7AB7E:
		rts
; End of function sub_7AB56

; ---------------------------------------------------------------------------
ChildObjDat_7AB80:
		dc.w 2-1
		dc.l loc_7AB8E
		dc.b  -$C,  -4
		dc.l loc_7AB8E
		dc.b -$18,  -4
; ---------------------------------------------------------------------------

loc_7AB8E:
		lea	ObjDat3_7ABFA(pc),a1
		jsr	(SetUp_ObjAttributes).l
		movea.w	parent3(a0),a1
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		tst.b	subtype(a0)
		beq.s	+ ;loc_7ABB8
		moveq	#8,d0
		move.b	#$C,mapping_frame(a0)
		move.w	#$100,priority(a0)

+ ;loc_7ABB8:
		move.w	d0,$2E(a0)
		move.l	#loc_7ABC2,(a0)

loc_7ABC2:
		subq.w	#1,$2E(a0)
		bmi.s	+ ;loc_7ABCE
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_7ABCE:
		move.l	#loc_7ABEE,(a0)
		move.w	#-$400,d0
		btst	#0,render_flags(a0)
		beq.s	+ ;loc_7ABE2
		neg.w	d0

+ ;loc_7ABE2:
		move.w	d0,$18(a0)
		moveq	#signextendB(sfx_Laser),d0
		jsr	(Play_SFX).l

loc_7ABEE:
		jsr	(MoveSprite2).l
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------
ObjDat3_7ABFA:
		dc.l Map_SSZMTZOrbs
		dc.w make_art_tile($41F,1,1)
		dc.w   $280
		dc.b  $28,   8,  $D, $9C

; =============== S U B R O U T I N E =======================================


sub_7AC06:
		bsr.w	sub_7ACF2
		cmpi.b	#$1F,$1C(a0)
		bne.s	++ ;loc_7AC4A
		st	$39(a0)
		lea	(_unkFA82).w,a1
		andi.b	#$F0,2(a1)
		ori.b	#5,2(a1)
		tst.b	$3C(a0)
		beq.s	+ ;loc_7AC42
		move.b	#$A,$26(a0)
		move.w	#-$180,(SSZ_MTZ_boss_Y_vel).w
		subq.b	#1,$3C(a0)
		move.w	#0,(SSZ_MTZ_boss_X_vel).w

+ ;loc_7AC42:
		move.w	#0,(SSZ_MTZ_boss_X_vel).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_7AC4A:
		cmpi.b	#4,(Player_1+routine).w
		beq.s	+ ;loc_7AC5A
		cmpi.b	#4,(Player_2+routine).w
		bne.s	locret_7AC78

+ ;loc_7AC5A:
		lea	(_unkFA82).w,a1
		move.b	2(a1),d0
		andi.b	#$F,d0
		cmpi.b	#4,d0
		beq.s	locret_7AC78
		andi.b	#$F0,2(a1)
		ori.b	#4,2(a1)

locret_7AC78:
		rts
; End of function sub_7AC06

; ---------------------------------------------------------------------------

loc_7AC7A:
		move.l	#loc_7AC92,(a0)
		bset	#0,render_flags(a0)
		move.w	#$400,x_vel(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_7AC92:
		subq.w	#1,$2E(a0)
		bmi.s	+ ;loc_7ACA4
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_7ACA4:
		clr.b	(Boss_flag).w
		bset	#4,$38(a0)
		st	(_unkFA89).w
		st	(Events_bg+$02).w
		lea	(Target_palette_line_2).w,a1
		lea	(Normal_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

- ;loc_7ACC0:
		move.l	(a1)+,(a2)+
		dbf	d6,- ;loc_7ACC0
		moveq	#$32,d0
		jsr	(Load_PLC).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------
		move.b	$1D(a0),d0
		jsr	(GetSineCosine).l
		asr.w	#6,d0
		add.w	(SSZ_MTZ_boss_Y_pos).w,d0
		move.w	d0,y_pos(a0)
		move.w	(SSZ_MTZ_boss_X_pos).w,x_pos(a0)
		addq.b	#2,$1D(a0)

; =============== S U B R O U T I N E =======================================


sub_7ACF2:
		cmpi.b	#$10,$26(a0)
		bhs.s	locret_7AD38
		tst.b	collision_property(a0)
		beq.s	+++ ;loc_7AD3A
		tst.b	collision_flags(a0)
		bne.s	locret_7AD38
		tst.b	$1C(a0)
		bne.s	+ ;loc_7AD1A
		move.b	#$20,$1C(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

+ ;loc_7AD1A:
		moveq	#0,d0
		btst	#0,$1C(a0)
		bne.s	+ ;loc_7AD28
		; Bug: this should be 2*3
		addi.w	#2*2,d0

+ ;loc_7AD28:
		bsr.w	sub_7AD6A
		subq.b	#1,$1C(a0)
		bne.s	locret_7AD38
		move.b	#$F,collision_flags(a0)

locret_7AD38:
		rts
; ---------------------------------------------------------------------------

+ ;loc_7AD3A:
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.l	#loc_7AC7A,$34(a0)
		st	(_unkFA88).w
		clr.b	$38(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	+ ;loc_7AD64
		move.b	#4,subtype(a1)

+ ;loc_7AD64:
		jmp	(BossDefeated).l
; End of function sub_7ACF2


; =============== S U B R O U T I N E =======================================


sub_7AD6A:
		lea	word_7AD78(pc),a1
		lea	word_7AD7E(pc,d0.w),a2
		jmp	(CopyWordData_3).l
; End of function sub_7AD6A

; ---------------------------------------------------------------------------
word_7AD78:
		dc.w Normal_palette+$0E, Normal_palette+$1C, Normal_palette+$1E
word_7AD7E:
		dc.w      8,  $866,  $222
		dc.w   $888,  $CCC,  $EEE
; ---------------------------------------------------------------------------

loc_7AD8A:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_7AD98(pc,d0.w),d1
		jmp	off_7AD98(pc,d1.w)
; ---------------------------------------------------------------------------
off_7AD98:
		dc.w loc_7ADA2-off_7AD98
		dc.w loc_7AE22-off_7AD98
		dc.w loc_7AFA4-off_7AD98
		dc.w loc_7B02A-off_7AD98
		dc.w loc_7B116-off_7AD98
; ---------------------------------------------------------------------------

loc_7ADA2:
		movea.l	a0,a1
		moveq	#7-1,d3
		moveq	#0,d2
		bra.s	+ ;loc_7ADB2
; ---------------------------------------------------------------------------

- ;loc_7ADAA:
		jsr	(AllocateObject).l
		bne.s	locret_7AE12

+ ;loc_7ADB2:
		move.b	#$20,width_pixels(a1)
		move.l	$34(a0),$34(a1)
		move.l	#loc_7AD8A,(a1)
		move.l	#Map_SSZMTZOrbs,mappings(a1)
		move.w	#make_art_tile($41F,0,0),art_tile(a1)
		ori.b	#4,render_flags(a1)
		move.w	#$180,priority(a1)
		addq.b	#2,routine(a1)
		move.b	#0,mapping_frame(a1)
		move.b	byte_7AE14(pc,d2.w),$2E(a1)
		move.b	byte_7AE14(pc,d2.w),$41(a1)
		move.b	byte_7AE1B(pc,d2.w),$40(a1)
		move.b	#$40,$2F(a1)
		move.b	#$87,collision_flags(a1)
		move.b	#0,$42(a1)
		addq.w	#1,d2
		dbf	d3,- ;loc_7ADAA

locret_7AE12:
		rts
; ---------------------------------------------------------------------------
byte_7AE14:
		dc.b  $24, $6C, $B4, $FC, $48, $90, $D8
byte_7AE1B:
		dc.b    0,   1,   1,   0,   1,   1,   0
		even
; ---------------------------------------------------------------------------

loc_7AE22:
		movea.l	$34(a0),a1
		move.w	y_pos(a1),$30(a0)
		subi.w	#4,$30(a0)
		move.w	x_pos(a1),$3E(a0)
		tst.b	$39(a1)
		beq.s	loc_7AE9C
		move.b	#0,$39(a1)
		addi.b	#1,$30(a1)
		addq.b	#2,routine(a0)
		move.b	#$3C,$3C(a0)
		move.b	#2,anim(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#-$80,d1
		move.w	(Player_1+x_pos).w,d0
		sub.w	x_pos(a0),d0
		bpl.s	+ ;loc_7AE70
		neg.w	d1

+ ;loc_7AE70:
		cmpi.w	#$16A0,x_pos(a0)
		bhs.s	+ ;loc_7AE7C
		move.w	#$80,d1

+ ;loc_7AE7C:
		cmpi.w	#$1760,x_pos(a0)
		blo.s	+ ;loc_7AE88
		move.w	#-$80,d1

+ ;loc_7AE88:
		bclr	#0,render_flags(a0)
		tst.w	d1
		bmi.s	+ ;loc_7AE98
		bset	#0,render_flags(a0)

+ ;loc_7AE98:
		move.w	d1,x_vel(a0)

loc_7AE9C:
		bsr.w	sub_7AEB0
		bsr.w	sub_7AF5A
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_7AEB0:
		move.b	$2F(a0),d0
		jsr	(GetSineCosine).l
		move.w	d0,d3
		moveq	#0,d1
		move.b	$38(a1),d1
		muls.w	d1,d0
		move.w	d0,d5
		move.w	d0,d4
		move.b	$3A(a1),d2
		tst.b	$3B(a1)
		beq.s	+ ;loc_7AED6
		move.w	#$10,d2

+ ;loc_7AED6:
		muls.w	d3,d2
		move.w	$3E(a0),d6
		move.b	$2E(a0),d0
		jsr	(GetSineCosine).l
		muls.w	d0,d5
		swap	d5
		add.w	d6,d5
		move.w	d5,x_pos(a0)
		muls.w	d1,d4
		swap	d4
		move.w	d4,$3A(a0)
		move.w	$30(a0),d6
		move.b	$41(a0),d0
		tst.b	$3B(a1)
		beq.s	+ ;loc_7AF0A
		move.b	$42(a0),d0

+ ;loc_7AF0A:
		jsr	(GetSineCosine).l
		muls.w	d0,d2
		swap	d2
		add.w	d6,d2
		move.w	d2,y_pos(a0)
		addq.b	#4,$2E(a0)
		tst.b	$3B(a1)
		bne.s	+ ;loc_7AF2A
		addq.b	#8,$41(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_7AF2A:
		cmpi.b	#-1,$3B(a1)
		beq.s	++ ;loc_7AF4C
		cmpi.b	#$80,$3B(a1)
		bne.s	+ ;loc_7AF44
		subq.b	#2,$42(a0)
		bpl.s	locret_7AF58
		clr.b	$42(a0)

+ ;loc_7AF44:
		move.b	#0,$3B(a1)
		rts
; ---------------------------------------------------------------------------

+ ;loc_7AF4C:
		cmpi.b	#$40,$42(a0)
		bhs.s	locret_7AF58
		addq.b	#2,$42(a0)

locret_7AF58:
		rts
; End of function sub_7AEB0


; =============== S U B R O U T I N E =======================================


sub_7AF5A:
		move.w	$3A(a0),d0
		bmi.s	++ ;loc_7AF82
		cmpi.w	#$C,d0
		blt.s	+ ;loc_7AF74
		move.b	#0,mapping_frame(a0)
		move.w	#$80,priority(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_7AF74:
		move.b	#1,mapping_frame(a0)
		move.w	#$100,priority(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_7AF82:
		cmpi.w	#-$C,d0
		blt.s	+ ;loc_7AF96
		move.b	#1,mapping_frame(a0)
		move.w	#$300,priority(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_7AF96:
		move.b	#2,mapping_frame(a0)
		move.w	#$380,priority(a0)
		rts
; End of function sub_7AF5A

; ---------------------------------------------------------------------------

loc_7AFA4:
		tst.b	$3C(a0)
		bmi.s	+ ;loc_7AFB6
		subq.b	#1,$3C(a0)
		bpl.s	+ ;loc_7AFB6
		move.b	#$C6,collision_flags(a0)

+ ;loc_7AFB6:
		jsr	(MoveSprite).l
		subi.w	#$20,y_vel(a0)
		cmpi.w	#$180,y_vel(a0)
		blt.s	+ ;loc_7AFD0
		move.w	#$180,y_vel(a0)

+ ;loc_7AFD0:
		tst.w	y_vel(a0)
		bmi.s	+ ;loc_7AFF8
		cmpi.w	#$42C,y_pos(a0)
		blo.s	+ ;loc_7AFF8
		move.w	#$42C,y_pos(a0)
		move.w	#$42C,$38(a0)
		move.b	#1,$32(a0)
		addq.b	#2,routine(a0)
		bsr.w	sub_7B0A8

+ ;loc_7AFF8:
		bsr.w	sub_7B0C2

loc_7AFFC:
		lea	Ani_SSZMTZOrbs(pc),a1
		jsr	(Animate_Sprite).l
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		tst.b	collision_property(a0)
		beq.s	locret_7B028
		move.b	#$E,mapping_frame(a0)
		move.b	#6,anim(a0)
		addq.b	#2,routine(a0)

locret_7B028:
		rts
; ---------------------------------------------------------------------------

loc_7B02A:
		tst.b	$3C(a0)
		bmi.s	+ ;loc_7B03C
		subq.b	#1,$3C(a0)
		bpl.s	+ ;loc_7B03C
		move.b	#$DA,collision_flags(a0)

+ ;loc_7B03C:
		bsr.w	sub_7B0C2
		cmpi.b	#8,mapping_frame(a0)
		bne.s	loc_7AFFC
		move.b	$32(a0),d0
		jsr	(GetSineCosine).l
		neg.w	d0
		asr.w	#2,d0
		add.w	$38(a0),d0
		cmpi.w	#$42C,d0
		bhs.s	+++ ;loc_7B08C
		move.w	d0,y_pos(a0)
		addq.b	#1,$32(a0)
		btst	#0,$32(a0)
		beq.s	++ ;loc_7B080
		moveq	#-1,d0
		btst	#0,render_flags(a0)
		beq.s	+ ;loc_7B07C
		neg.w	d0

+ ;loc_7B07C:
		add.w	d0,x_pos(a0)

+ ;loc_7B080:
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_7B08C:
		move.w	#$42C,y_pos(a0)
		bsr.w	sub_7B0A8
		move.b	#1,$32(a0)
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_7B0A8:
		move.w	(Player_1+x_pos).w,d0
		sub.w	x_pos(a0),d0
		bpl.s	+ ;loc_7B0BA
		bclr	#0,render_flags(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_7B0BA:
		bset	#0,render_flags(a0)
		rts
; End of function sub_7B0A8


; =============== S U B R O U T I N E =======================================


sub_7B0C2:
		moveq	#0,d0
		move.b	collision_property(a0),d0
		bne.s	+ ;loc_7B0D2
		tst.b	(_unkFA88).w
		bne.s	++ ;loc_7B0F6
		rts
; ---------------------------------------------------------------------------

+ ;loc_7B0D2:
		clr.b	collision_property(a0)
		andi.b	#3,d0
		add.w	d0,d0
		movea.w	word_7B10E(pc,d0.w),a1
		tst.b	$34(a1)
		bne.w	locret_7A718
		jsr	(Check_PlayerAttack).l
		bne.s	+ ;loc_7B0F6
		jsr	(HurtCharacter_Directly).l

+ ;loc_7B0F6:
		clr.b	collision_flags(a0)
		move.b	#$E,mapping_frame(a0)
		move.b	#6,anim(a0)
		move.b	#8,routine(a0)
		rts
; End of function sub_7B0C2

; ---------------------------------------------------------------------------
word_7B10E:
		dc.w Player_1
		dc.w Player_1
		dc.w Player_2
		dc.w Player_2
; ---------------------------------------------------------------------------

loc_7B116:
		moveq	#signextendB(sfx_Balloon),d0
		jsr	(Play_SFX).l
		movea.l	$34(a0),a1
		subi.b	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================

; This routine comes from Sonic 2, and is used in Sky Sanctuary by Mecha
; Sonic cosplaying as the Metropolis Zone boss.
;sub_7B12E:
Boss_MoveObject:
		move.l	(SSZ_MTZ_boss_X_pos).w,d2
		move.l	(SSZ_MTZ_boss_Y_pos).w,d3
		move.w	(SSZ_MTZ_boss_X_vel).w,d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		move.w	(SSZ_MTZ_boss_Y_vel).w,d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d3
		move.l	d2,(SSZ_MTZ_boss_X_pos).w
		move.l	d3,(SSZ_MTZ_boss_Y_pos).w
		rts
; End of function Boss_MoveObject

; ---------------------------------------------------------------------------
		moveq	#0,d6
		movea.l	a1,a4
		lea	(_unkFA82).w,a2
		lea	mapping_frame(a0),a3
		tst.b	(a3)
		bne.s	+ ;loc_7B168
		addq.w	#2,a2
		bra.s	++ ;loc_7B16C
; ---------------------------------------------------------------------------

+ ;loc_7B168:
		bsr.w	sub_7B17A

+ ;loc_7B16C:
		moveq	#0,d6
		move.b	mainspr_childsprites(a0),d6
		subq.w	#1,d6
		bmi.s	locret_7B1E0
		lea	sub2_mapframe(a0),a3

; =============== S U B R O U T I N E =======================================


sub_7B17A:
		movea.l	a4,a1
		moveq	#0,d0
		moveq	#0,d1
		moveq	#0,d2
		moveq	#0,d4
		move.b	(a2)+,d0
		move.b	d0,d1
		lsr.b	#4,d1
		andi.b	#$F,d0
		move.b	d0,d2
		cmp.b	d0,d1
		beq.s	+ ;loc_7B196
		st	d4

+ ;loc_7B196:
		move.b	d0,d5
		lsl.b	#4,d5
		or.b	d0,d5
		move.b	(a2)+,d0
		move.b	d0,d1
		lsr.b	#4,d1
		tst.b	d4
		beq.s	+ ;loc_7B1AA
		moveq	#0,d0
		moveq	#0,d1

+ ;loc_7B1AA:
		andi.b	#$F,d0
		subi.b	#1,d0
		bpl.s	loc_7B1CC
		add.w	d2,d2
		adda.w	(a1,d2.w),a1
		move.b	(a1),d0
		move.b	1(a1,d1.w),d2
		bmi.s	+ ;loc_7B1E2

loc_7B1C2:
		andi.b	#$7F,d2
		move.b	d2,(a3)
		addi.b	#1,d1

loc_7B1CC:
		lsl.b	#4,d1
		or.b	d1,d0
		move.b	d0,-1(a2)
		move.b	d5,-2(a2)
		adda.w	#next_subspr,a3
		dbf	d6,sub_7B17A

locret_7B1E0:
		rts
; ---------------------------------------------------------------------------

+ ;loc_7B1E2:
		addq.b	#1,d2
		bne.s	+ ;loc_7B1F0
		move.b	#0,d1
		move.b	1(a1),d2
		bra.s	loc_7B1C2
; ---------------------------------------------------------------------------

+ ;loc_7B1F0:
		addq.b	#1,d2
		bne.s	loc_7B1FC
		addi.b	#2,$26(a0)
		rts
; ---------------------------------------------------------------------------

loc_7B1FC:
		addq.b	#1,d2
		bne.s	+ ;loc_7B20A
		andi.b	#$F0,d5
		or.b	2(a1,d1.w),d5
		bra.s	loc_7B1CC
; ---------------------------------------------------------------------------

+ ;loc_7B20A:
		addq.b	#1,d2
		bne.s	locret_7B21A
		moveq	#0,d3
		move.b	2(a1,d1.w),d1
		move.b	1(a1,d1.w),d2
		bra.s	loc_7B1C2
; ---------------------------------------------------------------------------

locret_7B21A:
		rts
; End of function sub_7B17A

; ---------------------------------------------------------------------------
Ani_SSZMTZOrbs:
		include "Levels/SSZ/Misc Object Data/Anim - MTZOrbs.asm"
Pal_SSZMTZOrbs:
		binclude "Levels/SSZ/Palettes/MTZOrbs.bin"
		even
; ---------------------------------------------------------------------------
