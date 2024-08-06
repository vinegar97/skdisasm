word_784E0:
		dc.w   $610,  $810, $2B00, $2D00
word_784E8:
		dc.w   $710,  $710, $2C00, $2C00
		even
; ---------------------------------------------------------------------------

Obj_LRZMiniboss:
		lea	word_784E0(pc),a1
		jsr	(Check_CameraInRange).l
		move.l	#loc_78522,(a0)
		move.l	#loc_78528,$34(a0)
		lea	word_784E8(pc),a1
		move.b	#mus_Miniboss,$26(a0)
		jsr	(sub_85D6A).l
		lea	Pal_LRZMiniboss1(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_78522:
		jmp	(loc_85CA4).l
; ---------------------------------------------------------------------------

loc_78528:
		move.l	#loc_78538,(a0)
		lea	Pal_LRZMiniboss2(pc),a1
		bsr.w	sub_78B38

locret_78536:
		rts
; ---------------------------------------------------------------------------

loc_78538:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_7854C(pc,d0.w),d1
		jsr	off_7854C(pc,d1.w)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_7854C:
		dc.w loc_78562-off_7854C
		dc.w loc_78592-off_7854C
		dc.w loc_785C2-off_7854C
		dc.w loc_785E4-off_7854C
		dc.w loc_785E4-off_7854C
		dc.w loc_78628-off_7854C
		dc.w loc_78666-off_7854C
		dc.w loc_785E4-off_7854C
		dc.w loc_786DA-off_7854C
		dc.w loc_7871A-off_7854C
		dc.w loc_78768-off_7854C
; ---------------------------------------------------------------------------

loc_78562:
		lea	ObjDat_LRZMiniboss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#6,collision_property(a0)
		move.w	#$7A8,(_unkFAB0).w
		move.w	y_pos(a0),(_unkFAB2).w
		lea	ChildObjDat_78D84(pc),a2
		jsr	(CreateChild8_TreeListRepeated).l
		lea	ChildObjDat_78D8A(pc),a2
		jmp	(CreateChild8_TreeListRepeated).l
; ---------------------------------------------------------------------------

loc_78592:
		tst.l	(Nem_decomp_queue).w
		bne.w	locret_78536
		move.b	#4,routine(a0)
		move.w	#$2F,$2E(a0)
		lea	(ArtKosM_LRZMiniboss).l,a1
		move.w	#tiles_to_bytes($3FB),d2
		jsr	(Queue_Kos_Module).l
		lea	(PLC_BossExplosion).l,a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

loc_785C2:
		subq.w	#1,$2E(a0)
		bpl.s	locret_785E2
		move.b	#6,routine(a0)
		bset	#3,$38(a0)
		move.w	#$15F,$2E(a0)
		move.l	#loc_785EA,$34(a0)

locret_785E2:
		rts
; ---------------------------------------------------------------------------

loc_785E4:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_785EA:
		move.b	#8,routine(a0)
		bclr	#3,$38(a0)
		move.w	#$4F,$2E(a0)
		move.l	#loc_78606,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_78606:
		move.b	#$A,routine(a0)
		clr.w	x_vel(a0)
		move.w	#-$400,y_vel(a0)
		moveq	#signextendB(sfx_BossHand),d0
		jsr	(Play_SFX).l
		lea	byte_78DE2(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_78628:
		jsr	(Animate_RawMultiDelay).l
		bsr.w	sub_7867C
		jsr	(MoveSprite2).l
		move.w	(_unkFAB0).w,d0
		cmp.w	y_pos(a0),d0
		blo.w	locret_78536
		move.w	d0,y_pos(a0)
		move.b	#$C,routine(a0)
		clr.w	y_vel(a0)
		move.w	#$BF,$2E(a0)
		move.l	#loc_786A6,$34(a0)
		jmp	(Swing_Setup1).l
; ---------------------------------------------------------------------------

loc_78666:
		jsr	(Swing_UpAndDown).l
		bsr.w	sub_7867C
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l

; =============== S U B R O U T I N E =======================================


sub_7867C:
		move.b	(V_int_run_count+3).w,d0
		andi.w	#$F,d0
		bne.s	locret_786A0
		lea	(Player_1).w,a1
		jsr	(Find_OtherObject).l
		clr.w	x_vel(a0)
		cmpi.w	#8,d2
		bls.s	locret_786A0
		move.w	word_786A2(pc,d0.w),x_vel(a0)

locret_786A0:
		rts
; End of function sub_7867C

; ---------------------------------------------------------------------------
word_786A2:
		dc.w  -$200,  $200
; ---------------------------------------------------------------------------

loc_786A6:
		move.b	#$E,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_786BC,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_786BC:
		move.b	#$10,routine(a0)
		move.b	#$B5,collision_flags(a0)
		move.l	#loc_786EA,$34(a0)
		lea	byte_78DF1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_786DA:
		addq.w	#4,y_pos(a0)
		jsr	(Animate_RawMultiDelay).l
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

loc_786EA:
		move.b	#$12,routine(a0)
		move.b	#5,mapping_frame(a0)
		move.b	#6,collision_flags(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_7873A,$34(a0)
		move.w	#$14,(Screen_shake_flag).w
		moveq	#signextendB(sfx_ThumpBoss),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_7871A:
		moveq	#$33,d1
		moveq	#4,d2
		moveq	#0,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		bsr.w	sub_78C14
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7873A:
		move.b	#$14,routine(a0)
		move.w	#$2F,$2E(a0)
		move.l	#loc_787AE,$34(a0)
		clr.w	x_vel(a0)
		move.w	#$400,y_vel(a0)
		lea	byte_78DF8(pc),a1
		jsr	(Set_Raw_Animation).l
		jmp	(Displace_PlayerOffObject).l
; ---------------------------------------------------------------------------

loc_78768:
		jsr	(Animate_RawMultiDelay).l
		cmpi.b	#6,anim_frame(a0)
		bhs.s	loc_78784
		bsr.w	sub_78C14
		jsr	(Add_SpriteToCollisionResponseList).l
		bra.w	loc_7878C
; ---------------------------------------------------------------------------

loc_78784:
		bsr.w	sub_78CCA
		clr.b	collision_flags(a0)

loc_7878C:
		jsr	(MoveSprite2).l
		jsr	(Obj_Wait).l
		move.w	(_unkFAB2).w,d0
		cmp.w	y_pos(a0),d0
		bhi.s	locret_787AC
		move.w	d0,y_pos(a0)
		move.b	#6,routine(a0)

locret_787AC:
		rts
; ---------------------------------------------------------------------------

loc_787AE:
		move.l	#loc_785EA,$34(a0)
		move.b	$38(a0),d0
		andi.b	#-$40,d0
		cmpi.b	#-$40,d0
		beq.s	loc_787D8
		move.w	#$15F,$2E(a0)
		bset	#3,$38(a0)
		bclr	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_787D8:
		move.w	#$1F,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_787E0:
		jsr	(AllocateObject).l
		bne.s	loc_787EE
		move.l	#loc_78AA8,(a1)

loc_787EE:
		lea	ChildObjDat_78D9E(pc),a2
		jsr	(CreateChild1_Normal).l
		jmp	(Obj_EndSignControl).l
; ---------------------------------------------------------------------------

loc_787FE:
		bset	#0,render_flags(a0)
		move.w	#$10,$2E(a0)

loc_7880A:
		moveq	#0,d0
		moveq	#0,d1
		move.b	subtype(a0),d1
		beq.s	loc_7881E
		cmpi.b	#$16,d1
		bne.s	loc_7881C
		addq.w	#4,d0

loc_7881C:
		addq.w	#4,d0

loc_7881E:
		movea.l	off_7882C(pc,d0.w),a1
		move.l	a1,(a0)
		add.w	d1,d1
		add.w	d1,$2E(a0)
		jmp	(a1)
; ---------------------------------------------------------------------------
off_7882C:
		dc.l loc_78838
		dc.l loc_788DE
		dc.l loc_78922
; ---------------------------------------------------------------------------

loc_78838:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_78850(pc,d0.w),d1
		jsr	off_78850(pc,d1.w)
		bsr.w	sub_78B46
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_78850:
		dc.w loc_7885A-off_78850
		dc.w loc_78868-off_78850
		dc.w loc_78890-off_78850
		dc.w loc_788A4-off_78850
		dc.w loc_78890-off_78850
; ---------------------------------------------------------------------------

loc_7885A:
		lea	word_78D66(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		bsr.w	sub_78BEE

loc_78868:
		movea.w	$44(a0),a1
		btst	#3,$38(a1)
		beq.s	locret_7888E
		move.b	#4,routine(a0)
		move.w	#-$200,y_vel(a0)
		move.w	#$6F,$2E(a0)
		move.l	#loc_7889C,$34(a0)

locret_7888E:
		rts
; ---------------------------------------------------------------------------

loc_78890:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7889C:
		move.b	#6,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_788A4:
		movea.w	$44(a0),a1
		btst	#3,$38(a1)
		bne.s	locret_788CA
		move.b	#8,routine(a0)
		move.w	#$200,y_vel(a0)
		move.w	#$6F,$2E(a0)
		move.l	#loc_788CC,$34(a0)

locret_788CA:
		rts
; ---------------------------------------------------------------------------

loc_788CC:
		move.b	#2,routine(a0)
		movea.w	$44(a0),a1
		bset	#2,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_788DE:
		lea	word_78D66(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		bsr.w	sub_78BD6
		move.l	#loc_788F4,(a0)
		rts
; ---------------------------------------------------------------------------

loc_788F4:
		move.b	$3C(a0),d0
		add.b	$40(a0),d0
		cmpi.b	#$70,d0
		blo.s	loc_78908
		cmpi.b	#-$70,d0
		bls.s	loc_7890C

loc_78908:
		neg.b	$40(a0)

loc_7890C:
		move.b	d0,$3C(a0)
		moveq	#4,d2
		jsr	(MoveSprite_CircularSimple).l
		bsr.w	sub_78B46
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_78922:
		lea	word_78D6C(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		bsr.w	sub_78BD6
		move.l	#loc_78946,(a0)
		move.l	#byte_78E05,$30(a0)
		move.b	#4,collision_property(a0)
		rts
; ---------------------------------------------------------------------------

loc_78946:
		movea.w	$44(a0),a1
		btst	#3,$38(a1)
		beq.s	loc_78976
		move.l	#loc_7897A,(a0)
		moveq	#$7F,d0
		btst	#0,render_flags(a0)
		beq.s	loc_78966
		move.w	#$DF,d0

loc_78966:
		move.w	d0,$2E(a0)
		move.l	#loc_789CA,$34(a0)
		clr.b	$39(a0)

loc_78976:
		bra.w	sub_78B46
; ---------------------------------------------------------------------------

loc_7897A:
		movea.w	$44(a0),a1
		btst	#2,$38(a1)
		beq.s	loc_7898C
		move.l	#loc_78946,(a0)

loc_7898C:
		jsr	(Animate_Raw).l
		lea	(AngleLookup_2).l,a2
		jsr	(MoveSprite_AtAngleLookup).l
		jsr	(Obj_Wait).l
		bsr.w	sub_78B46
		bsr.w	sub_78CF4
		move.b	$20(a0),d0
		beq.s	loc_789BE
		btst	#0,d0
		bne.w	locret_78536
		bra.w	loc_789C4
; ---------------------------------------------------------------------------

loc_789BE:
		jsr	(Add_SpriteToCollisionResponseList).l

loc_789C4:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_789CA:
		move.b	$39(a0),d0
		addq.b	#1,d0
		move.b	d0,$39(a0)
		move.w	#$13,$2E(a0)
		cmpi.b	#3,d0
		blo.s	loc_789E6
		move.w	#$FFF,$2E(a0)

loc_789E6:
		moveq	#signextendB(sfx_BossProjectile),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_78D90(pc),a2
		jsr	(CreateChild10_NormalAdjusted).l
		bne.s	locret_78A00
		move.b	$39(a0),subtype(a1)

locret_78A00:
		rts
; ---------------------------------------------------------------------------

loc_78A02:
		lea	word_78D72(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_78A1C,(a0)
		bset	#3,$2B(a0)
		bsr.w	sub_78BAA

loc_78A1C:
		jsr	(MoveSprite2).l
		jmp	(Sprite_CheckDeleteTouchXY).l
; ---------------------------------------------------------------------------

loc_78A28:
		lea	word_78D78(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_78A46,(a0)
		move.w	#$1F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)

loc_78A46:
		jsr	(Obj_Wait).l
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		btst	#7,status(a1)
		bne.s	loc_78A6A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_78A6A:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_78A70:
		lea	word_78D7E(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		move.b	RawAni_78A9C(pc,d0.w),mapping_frame(a0)
		moveq	#$5C,d0
		jsr	(Set_IndexedVelocity).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
RawAni_78A9C:
		dc.b   $C,  $C,  $C, $11, $11, $12, $13,  $D,  $E,  $F, $10
		even
; ---------------------------------------------------------------------------

loc_78AA8:
		tst.b	(End_of_level_flag).w
		beq.w	locret_78536
		move.l	#loc_78AE0,(a0)
		lea	word_78EAA(pc),a1
		lea	(Palette_rotation_data).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		clr.w	(a2)
		move.l	#loc_78B00,(Palette_rotation_custom).w
		move.w	#$7FFF,(Palette_cycle_counter1).w
		jsr	(AllocateObject).l
		bne.s	loc_78AE0
		move.l	#loc_78B08,(a1)

loc_78AE0:
		jsr	(Run_PalRotationScript).l

loc_78AE6:
		cmpi.w	#$940,(Camera_X_pos).w
		blo.w	locret_78536
		move.w	#$940,(Camera_min_X_pos).w
		clr.w	(Palette_cycle_counter1).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_78B00:
		move.l	#loc_78AE6,(a0)
		rts
; ---------------------------------------------------------------------------

loc_78B08:
		cmpi.w	#$2C0,(Camera_X_pos).w
		blo.w	locret_78536
		move.w	#$2C0,(Camera_min_X_pos).w
		lea	(Pal_LRZ2).l,a1
		lea	(Normal_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_78B24:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_78B24
		lea	Pal_LRZMiniboss3(pc),a1
		bsr.w	sub_78B38
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_78B38:
		lea	(Normal_palette_line_3).w,a2
		moveq	#bytesToLcnt($40),d0

loc_78B3E:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_78B3E
		rts
; End of function sub_78B38


; =============== S U B R O U T I N E =======================================


sub_78B46:
		movea.w	$44(a0),a1
		moveq	#6,d0
		btst	#0,render_flags(a0)
		beq.s	loc_78B56
		moveq	#7,d0

loc_78B56:
		btst	d0,$38(a1)
		beq.w	locret_78536
		move.l	#Wait_Draw,(a0)
		move.w	#$80,priority(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		move.w	#$2C,d1
		sub.w	d0,d1
		move.w	d1,$2E(a0)
		move.l	#loc_78B86,$34(a0)
		rts
; End of function sub_78B46

; ---------------------------------------------------------------------------

loc_78B86:
		move.w	#$F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	locret_78BA8
		move.b	#6,subtype(a1)

locret_78BA8:
		rts

; =============== S U B R O U T I N E =======================================


sub_78BAA:
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsl.w	#2,d0
		move.l	word_78BCA-4(pc,d0.w),x_vel(a0)	; and y_vel
		movea.w	parent3(a0),a1
		btst	#0,render_flags(a1)
		beq.s	locret_78BC8
		neg.w	x_vel(a0)

locret_78BC8:
		rts
; End of function sub_78BAA

; ---------------------------------------------------------------------------
word_78BCA:
		dc.w   $200,  $300
		dc.w   $200,  $200
		dc.w   $200,  $100

; =============== S U B R O U T I N E =======================================


sub_78BD6:
		move.l	(sp)+,$34(a0)
		move.l	#Wait_Draw,(a0)
		move.b	#$80,$3C(a0)
		move.b	#1,$40(a0)
		rts
; End of function sub_78BD6


; =============== S U B R O U T I N E =======================================


sub_78BEE:
		move.w	#$20,d0
		btst	#0,render_flags(a0)
		beq.s	loc_78BFE
		move.w	#$120,d0

loc_78BFE:
		add.w	(Camera_X_pos).w,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$1B8,d0
		move.w	d0,y_pos(a0)
		rts
; End of function sub_78BEE


; =============== S U B R O U T I N E =======================================


sub_78C14:
		tst.b	collision_flags(a0)
		bne.s	locret_78C5E
		move.b	collision_property(a0),d0
		beq.s	loc_78C60
		tst.b	$20(a0)
		bne.s	loc_78C3A
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		bset	#6,status(a0)

loc_78C3A:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_78C48
		; Bug: this should be 2*6
		addi.w	#2*2,d0

loc_78C48:
		bsr.w	sub_78C98
		subq.b	#1,$20(a0)
		bne.s	locret_78C5E
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_78C5E:
		rts
; ---------------------------------------------------------------------------

loc_78C60:
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.w	#$80,priority(a0)
		bset	#6,$38(a0)
		bset	#7,$38(a0)
		move.l	#loc_787E0,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		jsr	(Displace_PlayerOffObject).l
		jmp	(BossDefeated_StopTimer).l
; End of function sub_78C14


; =============== S U B R O U T I N E =======================================


sub_78C98:
		lea	word_78CA6(pc),a1
		lea	word_78CB2(pc,d0.w),a2
		jmp	(CopyWordData_6).l
; End of function sub_78C98

; ---------------------------------------------------------------------------
word_78CA6:
		dc.w Normal_palette_line_2+$06, Normal_palette_line_2+$08, Normal_palette_line_2+$10
		dc.w Normal_palette_line_2+$18, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_78CB2:
		dc.w    $2A,     6,     2,  $644,  $422,     0
		dc.w   $888,  $AAA,  $CCC,  $AAA,  $CCC,  $EEE

; =============== S U B R O U T I N E =======================================


sub_78CCA:
		tst.b	collision_property(a0)
		beq.s	loc_78C60
		tst.b	$20(a0)
		beq.s	locret_78CF2
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_78CE4
		addi.w	#4,d0

loc_78CE4:
		bsr.s	sub_78C98
		subq.b	#1,$20(a0)
		bne.s	locret_78CF2
		bclr	#6,status(a0)

locret_78CF2:
		rts
; End of function sub_78CCA


; =============== S U B R O U T I N E =======================================


sub_78CF4:
		tst.b	collision_flags(a0)
		bne.s	locret_78D2A
		move.b	collision_property(a0),d0
		beq.s	loc_78D2C
		tst.b	$20(a0)
		bne.s	loc_78D1E
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_78D98(pc),a2
		jsr	(CreateChild6_Simple).l

loc_78D1E:
		subq.b	#1,$20(a0)
		bne.s	locret_78D2A
		move.b	$25(a0),collision_flags(a0)

locret_78D2A:
		rts
; ---------------------------------------------------------------------------

loc_78D2C:
		movea.w	$44(a0),a1
		move.w	#6,d0
		btst	#0,render_flags(a0)
		beq.s	loc_78D40
		move.w	#7,d0

loc_78D40:
		bset	d0,$38(a1)
		move.b	$38(a1),d0
		andi.b	#$C0,d0
		cmpi.b	#$C0,d0
		bne.s	locret_78D2A
		move.w	#$1F,$2E(a1)
		rts
; End of function sub_78CF4

; ---------------------------------------------------------------------------
ObjDat_LRZMiniboss:
		dc.l Map_LRZMiniboss
		dc.w make_art_tile($3FB,1,1)
		dc.w      0
		dc.b  $30, $80,   1,   0
word_78D66:
		dc.w      0
		dc.b    8,   8,   8,   0
word_78D6C:
		dc.w      0
		dc.b  $10, $10,   6,   6
word_78D72:
		dc.w      0
		dc.b    4,   4,   9, $98
word_78D78:
		dc.w      0
		dc.b  $10, $10,  $A,   0
word_78D7E:
		dc.w    $80
		dc.b  $18, $14,  $C,   0
ChildObjDat_78D84:
		dc.w $C-1
		dc.l loc_7880A
ChildObjDat_78D8A:
		dc.w $C-1
		dc.l loc_787FE
ChildObjDat_78D90:
		dc.w 1-1
		dc.l loc_78A02
		dc.b    8,   0
ChildObjDat_78D98:
		dc.w 1-1
		dc.l loc_78A28
ChildObjDat_78D9E:
		dc.w $B-1
		dc.l loc_78A70
		dc.b    0, -$C
		dc.l loc_78A70
		dc.b -$19, -$C
		dc.l loc_78A70
		dc.b  $19, -$C
		dc.l loc_78A70
		dc.b  -$C, $22
		dc.l loc_78A70
		dc.b   $C, $22
		dc.l loc_78A70
		dc.b   -8, $36
		dc.l loc_78A70
		dc.b    8, $36
		dc.l loc_78A70
		dc.b -$12,   4
		dc.l loc_78A70
		dc.b  $12,   4
		dc.l loc_78A70
		dc.b -$12,  $C
		dc.l loc_78A70
		dc.b  $12,  $C
byte_78DE2:
		dc.b    5,   0
		dc.b    5,   5
		dc.b    4,   1
		dc.b    3,   2
		dc.b    2,   3
		dc.b    1, $7F
		dc.b    1, $7F
		dc.b  $FC
byte_78DF1:
		dc.b    3,   0
		dc.b    3,   0
		dc.b    4,   0
		dc.b  $F4
byte_78DF8:
		dc.b    4,   3
		dc.b    4,   3
		dc.b    3,   3
		dc.b    2,   3
		dc.b    1, $7F
		dc.b    1, $7F
		dc.b  $FC
byte_78E05:
		dc.b    1,   6,   7,  $B, $FC
		even
Pal_LRZMiniboss1:
		binclude "Levels/LRZ/Palettes/Miniboss 1.bin"
		even
Pal_LRZMiniboss2:
		binclude "Levels/LRZ/Palettes/Miniboss 2.bin"
		even
Pal_LRZMiniboss3:
		binclude "Levels/LRZ/Palettes/Miniboss 3.bin"
		even
word_78EAA:	palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_3+$02, 5, 2-1
.data	palscriptdata	4, $0EE, $0AE, $06E, $00E, $00A
	palscriptdata	4, $0CC, $08C, $04A, $00A, $008
	palscriptdata	4, $0AA, $06A, $026, $028, $006
	palscriptdata	4, $0CC, $08C, $04A, $00A, $008
	palscriptdata	16,$0EE, $0AE, $06E, $00E, $00A
	palscriptdata	4, $0CC, $0AC, $06C, $00C, $208
	palscriptdata	4, $0CC, $08C, $06C, $22A, $226
	palscriptdata	4, $0AA, $28A, $24A, $228, $224
	palscriptdata	4, $288, $268, $248, $424, $222
	palscriptdata	4, $266, $246, $226, $422, $222
	palscriptdata	4, $266, $244, $224, $422, $222
	palscriptdata	4, $244, $222, $224, $422, $222
	palscriptdata	8, $222, $222, $224, $422, $222
	palscriptrun
; ---------------------------------------------------------------------------
