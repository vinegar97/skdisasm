Obj_LBZFinalBoss1:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		bsr.w	sub_734FA
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_729DE-.Index
		dc.w loc_72A54-.Index
		dc.w loc_72A70-.Index
		dc.w locret_72AEC-.Index
		dc.w loc_72AEE-.Index
		dc.w loc_72B04-.Index
; ---------------------------------------------------------------------------

loc_729DE:
		lea	ObjDat_LBZFinalBoss1(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#9,collision_property(a0)
		move.b	#1,(Boss_flag).w
		move.l	#loc_72A5A,$34(a0)
		cmpi.b	#2,(Player_1+character_id).w
		beq.s	+ ;loc_72A2A
		move.w	#$7F,$2E(a0)
		st	(Update_HUD_timer).w
		moveq	#$71,d0
		jsr	(Load_PLC).l
		jsr	(AllocateObject).l
		bne.s	+ ;loc_72A2A
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_EndBoss,subtype(a1)

+ ;loc_72A2A:
		lea	(Child1_MakeRoboHead3).l,a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_737F0(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_73766(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_737E8(pc),a2
		jmp	(CreateChild3_NormalRepeated).l
; ---------------------------------------------------------------------------

loc_72A54:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_72A5A:
		move.b	#4,routine(a0)
		move.w	#-$100,y_vel(a0)
		lea	Pal_LBZFinalBoss1(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_72A70:
		move.w	y_pos(a0),d0
		move.w	(Camera_Y_pos).w,d1
		tst.w	y_vel(a0)
		bmi.s	+ ;loc_72A8C
		addi.w	#$118,d1
		cmp.w	d1,d0
		bhs.s	++ ;loc_72A9A
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

+ ;loc_72A8C:
		subi.w	#$B0,d1
		cmp.w	d1,d0
		bls.s	+ ;loc_72A9A
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

+ ;loc_72A9A:
		cmpi.b	#2,collision_property(a0)
		bls.s	+ ;loc_72AAA
		btst	#3,$38(a0)
		beq.s	locret_72AE6

+ ;loc_72AAA:
		jsr	(Random_Number).l
		swap	d0
		moveq	#0,d1
		bclr	#0,render_flags(a0)
		btst	#0,d0
		beq.s	+ ;loc_72AC8
		moveq	#2,d1
		bset	#0,render_flags(a0)

+ ;loc_72AC8:
		move.w	word_72AE8(pc,d1.w),d1
		move.w	(Camera_X_pos).w,d2
		add.w	d1,d2
		move.w	d2,x_pos(a0)
		move.w	#$100,d0
		tst.w	y_vel(a0)
		bmi.s	+ ;loc_72AE2
		neg.w	d0

+ ;loc_72AE2:
		move.w	d0,y_vel(a0)

locret_72AE6:
		rts
; ---------------------------------------------------------------------------
word_72AE8:
		dc.w   $110
		dc.w    $30
; ---------------------------------------------------------------------------

locret_72AEC:
		rts
; ---------------------------------------------------------------------------

loc_72AEE:
		subq.b	#1,$40(a0)
		bmi.s	+ ;loc_72AF6
		rts
; ---------------------------------------------------------------------------

+ ;loc_72AF6:
		move.b	#$A,routine(a0)
		move.b	#4,$40(a0)

locret_72B02:
		rts
; ---------------------------------------------------------------------------

loc_72B04:
		addq.w	#8,y_pos(a0)
		subq.b	#1,$40(a0)
		bmi.s	+ ;loc_72B10
		rts
; ---------------------------------------------------------------------------

+ ;loc_72B10:
		move.b	#6,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_72B18:
		move.w	y_pos(a0),d0
		addq.w	#1,d0
		move.w	(Camera_Y_pos).w,d1
		addi.w	#$140,d1
		cmp.w	d1,d0
		bhs.s	+ ;loc_72B34
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_72B34:
		move.l	#loc_72B46,(a0)
		move.w	#$3F,$2E(a0)
		st	(Ctrl_2_locked).w
		rts
; ---------------------------------------------------------------------------

loc_72B46:
		subq.w	#1,$2E(a0)
		bpl.s	locret_72B94
		lea	(Player_1).w,a1
		btst	#7,status(a1)
		bne.s	locret_72B94
		btst	#Status_InAir,status(a1)
		bne.s	locret_72B94
		cmpi.b	#6,routine(a1)
		bhs.s	locret_72B94
		move.l	#loc_72B96,(a0)
		jsr	(Set_PlayerEndingPose).l
		clr.b	(End_of_level_flag).w
		jsr	(AllocateObject).l
		bne.s	+ ;loc_72B86
		move.l	#Obj_LevelResults,(a1)

+ ;loc_72B86:
		jsr	(AllocateObject).l
		bne.s	locret_72B94
		move.l	#loc_72CFA,(a1)

locret_72B94:
		rts
; ---------------------------------------------------------------------------

loc_72B96:
		tst.b	(End_of_level_flag).w
		beq.w	locret_72B02
		move.l	#loc_72BBC,(a0)
		jsr	(Restore_LevelMusic).l
		move.w	#$1F,$2E(a0)
		lea	(PLC_BossExplosion).l,a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

loc_72BBC:
		subq.w	#1,$2E(a0)
		bpl.w	locret_72B02
		move.l	#loc_72C0A,(a0)
		bset	#5,$38(a0)
		move.w	a0,(_unkFAA4).w
		jsr	(Restore_PlayerControl).l
		lea	(Player_2).w,a1
		jsr	(Restore_PlayerControl2).l
		st	(Ctrl_1_locked).w
		clr.w	(Ctrl_1_logical).w
		jsr	(AllocateObject).l
		bne.s	+ ;loc_72BFA
		move.l	#loc_863C0,(a1)

+ ;loc_72BFA:
		lea	(ArtKosM_LBZ2DeathEggSmall).l,a1
		move.w	#tiles_to_bytes($4AE),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_72C0A:
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	locret_72C3A
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		sub.w	x_pos(a1),d0
		scs	d2
		bpl.s	+ ;loc_72C28
		neg.w	d0

+ ;loc_72C28:
		cmpi.w	#4,d0
		blo.s	++ ;loc_72C3C
		moveq	#button_right,d1
		tst.b	d2
		beq.s	+ ;loc_72C36
		moveq	#button_left,d1

+ ;loc_72C36:
		bset	d1,(Ctrl_1_held_logical).w

locret_72C3A:
		rts
; ---------------------------------------------------------------------------

+ ;loc_72C3C:
		move.l	#loc_72C68,(a0)
		clr.b	(_unkFA88).w
		jsr	(Stop_Object).l
		bclr	#0,render_flags(a1)
		bclr	#Status_Facing,status(a1)
		move.w	#(button_up_mask<<8)|button_up_mask,(Ctrl_1_logical).w
		lea	ChildObjDat_73806(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_72C68:
		btst	#0,(_unkFA88).w
		beq.s	locret_72C9C
		move.l	#loc_72C9E,(a0)
		move.l	#loc_72CBE,$34(a0)
		lea	(Player_1).w,a1
		bsr.w	sub_72C8E
		lea	(Player_2).w,a1
		; Bug: this tries to hide Tails' tails by clearing his anim, but Tails is
		; in a1. loc_72C9E fixes this, but only for player 2. Conversely, S3 only
		; clears player 1's anim here, as P2 is absent from the final boss.
		clr.b	anim(a0)

sub_72C8E:
		move.b	#$83,object_control(a1)
		clr.b	anim_frame_timer(a1)
		clr.b	anim_frame(a1)

locret_72C9C:
		rts
; ---------------------------------------------------------------------------

loc_72C9E:
		lea	(Player_1).w,a1
		lea	byte_7386A(pc),a2
		jsr	(Animate_ExternalPlayerSprite).l
		lea	(Player_2).w,a1
		clr.b	anim(a1)
		lea	byte_73874(pc),a2
		jmp	(Animate_ExternalPlayerSprite).l
; ---------------------------------------------------------------------------

loc_72CBE:
		move.l	#loc_72CC6,(a0)
		rts
; ---------------------------------------------------------------------------

loc_72CC6:
		btst	#1,(_unkFA88).w
		beq.s	locret_72CD8
		move.l	#loc_72CDA,(a0)
		st	(Events_fg_5).w

locret_72CD8:
		rts
; ---------------------------------------------------------------------------

loc_72CDA:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$120,d0
		cmp.w	(Player_1+y_pos).w,d0
		bhi.w	locret_72B02
		move.w	#$700,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_72CFA:
		lea	(Player_2).w,a1
		btst	#7,status(a1)
		bne.s	locret_72D16
		btst	#Status_InAir,status(a1)
		bne.s	locret_72D16
		cmpi.b	#6,routine(a1)
		blo.s	+ ;loc_72D18

locret_72D16:
		rts
; ---------------------------------------------------------------------------

+ ;loc_72D18:
		jsr	(Set_PlayerEndingPose).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_72D24:
		move.l	#loc_72D5A,(a0)
		move.w	#$4430,x_pos(a0)
		move.w	#$728,y_pos(a0)
		move.w	#$1010,$3A(a0)
		move.w	#$200,d0
		tst.b	subtype(a0)
		beq.s	+ ;loc_72D48
		neg.w	d0

+ ;loc_72D48:
		move.w	d0,x_vel(a0)
		move.w	#$41,$2E(a0)
		move.l	#loc_72D78,$34(a0)

loc_72D5A:
		subq.b	#1,$39(a0)
		bpl.s	+ ;loc_72D6C
		move.b	#3,$39(a0)
		jsr	(sub_83E84).l

+ ;loc_72D6C:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_72D78:
		clr.w	x_vel(a0)
		move.w	#-$200,y_vel(a0)
		move.w	#$57,$2E(a0)
		move.l	#loc_72D92,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_72D92:
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	+ ;loc_72DB2
		move.w	#$4430,x_pos(a1)
		move.w	#$678,y_pos(a1)
		move.b	#$C,subtype(a1)

+ ;loc_72DB2:
		tst.b	subtype(a0)
		bne.s	+ ;loc_72DE4
		jsr	(AllocateObject).l
		bne.s	+ ;loc_72DE4
		move.l	#loc_72DEA,(a1)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$D0,d0
		move.w	d0,x_pos(a1)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$20,d0
		move.w	d0,y_pos(a1)
		move.w	#5,$3A(a1)

+ ;loc_72DE4:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_72DEA:
		subq.w	#1,$2E(a0)
		bpl.s	locret_72E20
		addq.b	#1,$39(a0)
		cmpi.b	#8,$39(a0)
		bne.s	+ ;loc_72E00
		st	(Events_fg_5).w

+ ;loc_72E00:
		cmpi.b	#$18,$39(a0)
		bhs.s	+ ;loc_72E22
		move.w	$3A(a0),$2E(a0)
		addq.w	#1,$3A(a0)
		jsr	(AllocateObject).l
		bne.s	locret_72E20
		move.l	#loc_72E54,(a1)

locret_72E20:
		rts
; ---------------------------------------------------------------------------

+ ;loc_72E22:
		move.l	#loc_72E2E,(a0)
		move.w	#$17F,$2E(a0)

loc_72E2E:
		subq.w	#1,$2E(a0)
		bmi.s	+ ;loc_72E36
		rts
; ---------------------------------------------------------------------------

+ ;loc_72E36:
		bset	#0,(_unkFA88).w
		clr.b	$39(a0)
		clr.w	$2E(a0)
		lea	ChildObjDat_7380C(pc),a2
		jsr	(CreateChild1_Normal).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_72E54:
		lea	ObjDat3_73736(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#MoveChkDel,(a0)
		jsr	(Random_Number).l
		andi.w	#7,d0
		move.b	RawAni_72E96(pc,d0.w),mapping_frame(a0)
		swap	d0
		andi.w	#$FF,d0
		move.w	(Camera_X_pos).w,d1
		addi.w	#$20,d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$20,d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
RawAni_72E96:
		dc.b    7,   8,   9,  $A,  $B,   7,   8,   9
		even
; ---------------------------------------------------------------------------

loc_72E9E:
		lea	ObjDat3_73742(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_72EF8,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		beq.s	+ ;loc_72EBC
		move.l	#loc_72F40,(a0)

+ ;loc_72EBC:
		move.w	word_72EE8(pc,d0.w),y_vel(a0)
		lea	byte_72EDA(pc,d0.w),a1
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,d0
		or.b	d0,render_flags(a0)
		lea	Pal_LBZEnding(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------
byte_72EDA:
		dc.b    0,   0
		dc.b    1,   0
		dc.b    1,   0
		dc.b    2,   0
		dc.b    2,   1
		dc.b    2,   2
		dc.b    2,   3
word_72EE8:
		dc.w    $40
		dc.w    $38
		dc.w    $3C
		dc.w    $40
		dc.w    $44
		dc.w    $48
		dc.w    $4C
		dc.w    $50
; ---------------------------------------------------------------------------

loc_72EF8:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$F,d0
		bne.s	+ ;loc_72F2C
		lea	ChildObjDat_73838(pc),a2
		jsr	(CreateChild6_Simple).l
		jsr	(Random_Number).l
		andi.w	#$1F,d0
		subi.w	#$10,d0
		add.w	d0,x_pos(a1)
		swap	d0
		andi.w	#$1F,d0
		subi.w	#$10,d0
		add.w	d0,y_pos(a1)

+ ;loc_72F2C:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_72F40
		bset	#1,(_unkFA88).w

loc_72F40:
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_72F4C:
		lea	ObjDat3_7374E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_72F7A,(a0)
		move.w	#-$40,y_vel(a0)
		move.w	#$7F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		lea	ChildObjDat_7383E(pc),a2
		jsr	(CreateChild6_Simple).l

loc_72F7A:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#3,d0
		bne.s	+ ;loc_72FA0
		move.b	$39(a0),d0
		addq.b	#1,d0
		move.b	d0,$39(a0)
		andi.b	#3,d0
		move.b	render_flags(a0),d1
		andi.b	#$FC,d1
		or.b	d0,d1
		move.b	d1,render_flags(a0)

+ ;loc_72FA0:
		jsr	(MoveSprite2).l
		jsr	(Obj_Wait).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_72FB2:
		lea	ObjDat3_7375A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_72FD8,(a0)
		move.l	#byte_73864,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		move.w	#$40,y_vel(a0)

loc_72FD8:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
word_72FEA:
		dc.w      0,  $428, $4280, $4380
		dc.w   $328,  $328, $4300, $4300
; ---------------------------------------------------------------------------

Obj_LBZFinalBossKnux:
		lea	word_72FEA(pc),a1
		jsr	(Check_CameraInRange).l
		move.b	#mus_EndBoss,$26(a0)
		jsr	(sub_85D6A).l
		move.l	#loc_73046,(a0)
		move.l	#loc_7304C,$34(a0)
		clr.b	(_unkFAA2).w
		clr.b	(_unkFAA3).w
		moveq	#$71,d0
		jsr	(Load_PLC).l

; =============== S U B R O U T I N E =======================================


sub_7302E:
		lea	PLC_LBZFinalBoss_Extra(pc),a1
		jmp	(Load_PLC_Raw).l
; End of function sub_7302E

; ---------------------------------------------------------------------------
PLC_LBZFinalBoss_Extra: plrlistheader
		plreq $52E, ArtNem_RobotnikShip
		plreq $500, ArtNem_BossExplosion
PLC_LBZFinalBoss_Extra_End
; ---------------------------------------------------------------------------

loc_73046:
		jmp	(loc_85CA4).l
; ---------------------------------------------------------------------------

loc_7304C:
		move.l	#Obj_LBZFinalBoss1,(a0)
		rts
; ---------------------------------------------------------------------------

loc_73054:
		move.w	y_pos(a0),d0
		subq.w	#1,d0
		move.w	(Camera_Y_pos).w,d1
		subi.w	#$50,d1
		cmp.w	d1,d0
		blo.s	+ ;loc_73070
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_73070:
		move.w	d1,y_pos(a0)
		bset	#5,$38(a0)
		jsr	(AllocateObject).l
		bne.s	+ ;loc_73088
		move.l	#Obj_LBZFinalBoss2,(a1)

+ ;loc_73088:
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_7308E:
		lea	ObjDat3_736D8(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_730B0,(a0)
		move.l	#loc_730B0,$34(a0)
		lea	ChildObjDat_737BA(pc),a2
		jmp	(CreateChild3_NormalRepeated).l
; ---------------------------------------------------------------------------

loc_730B0:
		jsr	(Refresh_ChildPositionAdjusted).l
		bsr.w	sub_7361E
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_730C0:
		movea.w	parent3(a0),a1
		btst	#6,status(a1)
		bne.s	+ ;loc_730EC
		move.l	$34(a0),(a0)
		btst	#5,status(a1)
		beq.s	+ ;loc_730EC
		subi.b	#$28,child_dy(a0)
		cmpi.b	#4,subtype(a0)
		bne.s	+ ;loc_730EC
		bclr	#5,status(a1)

+ ;loc_730EC:
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_730F2:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_730F8:
		move.w	#1,$3C(a0)
		bra.s	loc_7308E
; ---------------------------------------------------------------------------

loc_73100:
		lea	ObjDat3_736E4(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_73128,(a0)
		move.l	#loc_73128,$34(a0)
		move.w	#2,$3C(a0)
		lea	ChildObjDat_737DA(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_73128:
		jsr	(Refresh_ChildPositionAdjusted).l
		bsr.w	sub_7361E
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_73138:
		lea	word_736F8(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_73152,(a0)
		move.w	#$60,$2E(a0)
		bsr.w	sub_73682

loc_73152:
		jsr	(MoveSprite).l
		jsr	(TimedSprite_ScreenLock).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_73164:
		move.l	#loc_73174,(a0)
		lea	ObjDat3_7371E(pc),a1
		jmp	(SetUp_ObjAttributes).l
; ---------------------------------------------------------------------------

loc_73174:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	+ ;loc_7318C
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_7318C:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_73192:
		lea	ObjDat3_7372A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_731B0,(a0)
		tst.b	subtype(a0)
		beq.s	locret_731AE
		move.b	#$22,mapping_frame(a0)

locret_731AE:
		rts
; ---------------------------------------------------------------------------

loc_731B0:
		movea.w	parent3(a0),a1
		btst	#6,status(a1)
		beq.s	+ ;loc_731C8
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_731C8:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_731CE:
		lea	word_736FE(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_731F4,(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		tst.b	subtype(a0)
		beq.s	loc_731F4
		move.b	#8,$39(a0)

loc_731F4:
		bsr.w	sub_733FC
		moveq	#4,d0
		jmp	(Child_Draw_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------
		movea.w	$44(a0),a1
		btst	#6,status(a1)
		bne.s	+ ;loc_73212
		move.l	#loc_731F4,(a0)

+ ;loc_73212:
		moveq	#4,d0
		jmp	(Child_Draw_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_7321A:
		lea	word_73704(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_73232,(a0)
		move.w	#8,$3A(a0)
		rts
; ---------------------------------------------------------------------------

loc_73232:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	++ ;loc_7326A
		jsr	(Refresh_ChildPositionAdjusted).l
		subq.w	#1,$2E(a0)
		bpl.w	locret_72B02
		move.w	$3A(a0),$2E(a0)
		subq.w	#1,$3A(a0)
		bpl.s	+ ;loc_73264
		move.l	#loc_73270,(a0)
		move.w	#$18,$2E(a0)

+ ;loc_73264:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_7326A:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_73270:
		jsr	(Refresh_ChildPositionAdjusted).l
		subq.w	#1,$2E(a0)
		bmi.s	+ ;loc_7328C
		btst	#0,$2F(a0)
		bne.w	locret_72B02
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_7328C:
		move.l	#loc_732A8,(a0)
		move.l	#byte_73849,$30(a0)
		move.l	#loc_732BA,$34(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_732A8:
		jsr	(Refresh_ChildPositionAdjusted).l
		jsr	(Animate_Raw).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_732BA:
		move.l	#loc_732F6,(a0)
		tst.b	render_flags(a0)
		bpl.s	loc_732CE
		moveq	#signextendB(sfx_Laser),d0
		jsr	(Play_SFX).l

loc_732CE:
		move.b	#$9C,collision_flags(a0)
		move.b	#$11,mapping_frame(a0)
		moveq	#-$2C,d0
		move.w	#-$800,d1
		btst	#0,render_flags(a0)
		beq.s	+ ;loc_732EC
		neg.w	d0
		neg.w	d1

+ ;loc_732EC:
		add.w	d0,x_pos(a0)
		move.w	d1,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_732F6:
		btst	#0,(V_int_run_count+3).w
		bne.s	+ ;loc_73318
		lea	ChildObjDat_737D2(pc),a2
		jsr	(CreateChild1_Normal).l
		move.l	#byte_73851,$30(a1)
		bsr.w	sub_734E4
		bra.w	++ ;loc_7332E
; ---------------------------------------------------------------------------

+ ;loc_73318:
		lea	ChildObjDat_737D2(pc),a2
		jsr	(CreateChild1_Normal).l
		move.l	#byte_73857,$30(a1)
		bsr.w	sub_734E4

+ ;loc_7332E:
		jsr	(MoveSprite2).l
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

loc_7333A:
		lea	word_7370C(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_73358,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		jsr	(Refresh_ChildPositionAdjusted).l

loc_73358:
		jsr	(Animate_Raw).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_73364:
		lea	word_736F0(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		bset	#4,shield_reaction(a0)
		move.l	#loc_73384,(a0)
		move.l	#byte_73844,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_73384:
		jsr	(Refresh_ChildPositionAdjusted).l
		jsr	(Animate_Raw).l
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------

loc_73396:
		lea	ObjDat3_73712(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_733CA,(a0)
		move.l	#byte_7385D,$30(a0)
		move.l	#loc_733E2,$34(a0)
		move.b	#-$14,child_dy(a0)
		tst.b	subtype(a0)
		beq.s	locret_733C8
		move.b	#$80,$3C(a0)

locret_733C8:
		rts
; ---------------------------------------------------------------------------

loc_733CA:
		jsr	(Animate_Raw).l
		addq.b	#1,$3C(a0)
		moveq	#3,d2
		jsr	(MoveSprite_CircularSimpleOffset).l
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------

loc_733E2:
		move.b	$39(a0),d0
		addq.b	#1,d0
		move.b	d0,$39(a0)
		andi.b	#3,d0
		andi.b	#$FC,render_flags(a0)
		or.b	d0,render_flags(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_733FC:
		moveq	#0,d0
		move.b	$39(a0),d0
		subq.w	#1,$2E(a0)
		bmi.s	+ ;loc_7340E
		add.w	d0,d0
		bra.w	loc_73484
; ---------------------------------------------------------------------------

+ ;loc_7340E:
		movea.w	$44(a0),a1
		btst	#0,render_flags(a1)
		sne	d2
		beq.s	+ ;loc_73426
		subq.b	#1,d0
		bpl.s	++ ;loc_73430
		moveq	#$B,d0
		bra.w	++ ;loc_73430
; ---------------------------------------------------------------------------

+ ;loc_73426:
		addq.b	#1,d0
		cmpi.b	#$C,d0
		blo.s	+ ;loc_73430
		moveq	#0,d0

+ ;loc_73430:
		move.b	d0,$39(a0)
		lea	byte_734AA(pc),a2
		move.b	(a2,d0.w),d1
		bset	#0,render_flags(a0)
		bclr	#7,d1
		bne.s	+ ;loc_73450
		bclr	#0,render_flags(a0)
		not.b	d2

+ ;loc_73450:
		bclr	#3,$38(a1)
		cmpi.b	#4,d1
		bne.s	+ ;loc_73478
		bset	#3,$38(a1)
		tst.b	d2
		beq.s	+ ;loc_73478
		movem.l	d0-d1,-(sp)
		lea	ChildObjDat_737C2(pc),a2
		jsr	(CreateChild1_Normal).l
		movem.l	(sp)+,d0-d1

+ ;loc_73478:
		move.b	d1,mapping_frame(a0)
		add.w	d0,d0
		move.w	word_734B6(pc,d0.w),$2E(a0)

loc_73484:
		lea	byte_734CE(pc,d0.w),a1
		movea.w	parent3(a0),a2
		move.b	(a1)+,d1
		ext.w	d1
		move.w	x_pos(a2),d2
		add.w	d1,d2
		move.w	d2,x_pos(a0)
		move.b	(a1)+,d1
		ext.w	d1
		move.w	y_pos(a2),d2
		add.w	d1,d2
		move.w	d2,y_pos(a0)
		rts
; End of function sub_733FC

; ---------------------------------------------------------------------------
byte_734AA:
		dc.b    3|$80
		dc.b    4|$80
		dc.b    5|$80
		dc.b    6|$80
		dc.b    7|$80
		dc.b    8|$80
		dc.b    7
		dc.b    6
		dc.b    5
		dc.b    4
		dc.b    3
		dc.b  $2D
		even
word_734B6:
		dc.w      7
		dc.w    $5F
		dc.w      7
		dc.w      7
		dc.w      7
		dc.w      7
		dc.w      7
		dc.w      7
		dc.w      7
		dc.w    $5F
		dc.w      7
		dc.w    $27
byte_734CE:
		dc.b  $27,  -8
		dc.b  $24,  -8
		dc.b  $24,  -8
		dc.b  $14,  -8
		dc.b   $C,  -8
		dc.b    0,  -8
		dc.b  -$C,  -8
		dc.b -$14,  -8
		dc.b -$24,  -8
		dc.b -$24,  -8
		dc.b -$27,  -8

; =============== S U B R O U T I N E =======================================


sub_734E4:
		jsr	(Random_Number).l
		swap	d0
		andi.b	#7,d0
		addi.b	#$18,d0
		move.b	d0,child_dx(a1)
		rts
; End of function sub_734E4


; =============== S U B R O U T I N E =======================================


sub_734FA:
		tst.b	collision_flags(a0)
		bne.w	locret_735B4
		tst.b	collision_property(a0)
		beq.w	loc_735B6
		tst.b	$20(a0)
		bne.s	+++ ;loc_73584
		move.b	routine(a0),$3A(a0)
		move.b	#6,routine(a0)
		move.b	#$20,$20(a0)
		bset	#6,status(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		move.w	y_vel(a0),d0
		asl.w	#1,d0
		cmpi.w	#-$800,d0
		blt.s	+ ;loc_73546
		cmpi.w	#$800,d0
		bgt.s	+ ;loc_73546
		move.w	d0,y_vel(a0)

+ ;loc_73546:
		cmpi.b	#5,collision_property(a0)
		beq.s	+ ;loc_7355C
		cmpi.b	#1,collision_property(a0)
		bne.s	++ ;loc_73584
		bset	#3,$38(a0)

+ ;loc_7355C:
		move.w	$3C(a0),d0
		bset	d0,$38(a0)
		addq.w	#1,$3C(a0)
		move.b	#8,routine(a0)
		move.b	#$F,$40(a0)
		bset	#5,status(a0)
		lea	ChildObjDat_737F8(pc),a2
		jsr	(CreateChild1_Normal).l

+ ;loc_73584:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_73592
		addi.w	#2*2,d0

loc_73592:
		bsr.w	sub_73604
		subq.b	#1,$20(a0)
		bne.s	locret_735B4
		move.b	$3A(a0),routine(a0)
		move.w	#$EEE,(Normal_palette_line_2+$2).w
		move.b	$25(a0),collision_flags(a0)
		bclr	#6,status(a0)

locret_735B4:
		rts
; ---------------------------------------------------------------------------

loc_735B6:
		jsr	(BossDefeated).l
		move.b	#5,mapping_frame(a0)
		bset	#6,status(a0)
		bset	#7,status(a0)
		clr.b	collision_flags(a0)
		move.w	$3C(a0),d0
		bset	d0,$38(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		move.b	#4,subtype(a1)
		cmpi.b	#2,(Player_1+character_id).w
		beq.s	+ ;loc_735FC
		move.l	#loc_72B18,(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_735FC:
		move.l	#loc_73054,(a0)
		rts
; End of function sub_734FA


; =============== S U B R O U T I N E =======================================


sub_73604:
		lea	word_73612(pc),a1
		lea	word_73616(pc,d0.w),a2
		jmp	(CopyWordData_2).l
; End of function sub_73604

; ---------------------------------------------------------------------------
word_73612:
		dc.w Normal_palette_line_2+$08, Normal_palette_line_2+$1C
word_73616:
		dc.w    $26,   $20
		dc.w   $EEE,  $EEE

; =============== S U B R O U T I N E =======================================


sub_7361E:
		movea.w	parent3(a0),a1
		move.w	$3C(a0),d0
		btst	d0,$38(a1)
		beq.s	++ ;loc_73672
		move.l	#byte_736C2,$3E(a0)
		bset	#7,status(a0)
		lea	(ChildObjDat_7377A).l,a2
		cmpi.w	#2,d0
		bne.s	+ ;loc_73654
		move.l	#byte_736C6,$3E(a0)
		lea	(ChildObjDat_73794).l,a2

+ ;loc_73654:
		move.w	#$10,$2E(a0)
		move.l	#loc_730F2,(a0)
		jsr	(CreateChild1_Normal).l
		lea	(Child6_CreateBossExplosion).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

+ ;loc_73672:
		btst	#6,status(a1)
		beq.s	locret_73680
		move.l	#loc_730C0,(a0)

locret_73680:
		rts
; End of function sub_7361E


; =============== S U B R O U T I N E =======================================


sub_73682:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,d1
		lsr.w	#1,d1
		movea.w	parent3(a0),a1
		movea.l	$3E(a1),a1
		move.b	(a1,d1.w),mapping_frame(a0)
		add.w	d0,d0
		lea	word_736AA(pc,d0.w),a1
		move.w	(a1)+,x_vel(a0)
		move.w	(a1)+,y_vel(a0)
		rts
; End of function sub_73682

; ---------------------------------------------------------------------------
word_736AA:
		dc.w  -$100, -$200
		dc.w   $100, -$200
		dc.w  -$200, -$100
		dc.w   $200, -$100
		dc.w  -$300, -$300
		dc.w   $300, -$300
byte_736C2:
		dc.b  $23
		dc.b  $25
		dc.b  $24
		dc.b  $26
byte_736C6:
		dc.b  $27
		dc.b  $29
		dc.b  $28
		dc.b  $2A
		dc.b  $2B
		dc.b  $2C
		even
ObjDat_LBZFinalBoss1:
		dc.l Map_RobotnikShip
		dc.w make_art_tile($52E,0,1)
		dc.w   $280
		dc.b  $20, $20,  $C,  $F
ObjDat3_736D8:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile($3AA,1,1)
		dc.w   $200
		dc.b  $20, $14,   0, $AD
ObjDat3_736E4:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile($3AA,1,1)
		dc.w   $200
		dc.b  $28, $18,   1, $AD
word_736F0:
		dc.w make_art_tile($3AA,0,1)
		dc.w   $280
		dc.b   $C, $18,   9, $89
word_736F8:
		dc.w   $200
		dc.b  $10, $10, $2A,   0
word_736FE:
		dc.w   $180
		dc.b   $C,  $C,   3,   0
word_73704:
		dc.w make_art_tile($3AA,0,1)
		dc.w   $100
		dc.b  $18,   8,  $F,   0
word_7370C:
		dc.w   $100
		dc.b    8,   8, $1C,   0
ObjDat3_73712:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile($3AA,1,1)
		dc.w   $300
		dc.b   $C,  $C,  $C, $97
ObjDat3_7371E:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile($3AA,1,1)
		dc.w   $200
		dc.b  $28,   8,   2,   0
ObjDat3_7372A:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile($3AA,1,1)
		dc.w   $280
		dc.b  $10,  $C, $10,   0
ObjDat3_73736:
		dc.l Map_LBZDeathEggSmall
		dc.w make_art_tile($4AE,2,0)
		dc.w   $300
		dc.b   $C,  $C,   7,   0
ObjDat3_73742:
		dc.l Map_LBZDeathEggSmall
		dc.w make_art_tile($4AE,1,0)
		dc.w   $380
		dc.b  $18, $18,   0,   0
ObjDat3_7374E:
		dc.l Map_LBZDeathEggSmall
		dc.w make_art_tile($4AE,1,0)
		dc.w   $300
		dc.b    4,   4,   3,   0
ObjDat3_7375A:
		dc.l Map_LBZDeathEggSmall
		dc.w make_art_tile($4AE,1,0)
		dc.w   $300
		dc.b    4,   4,   4,   0
ChildObjDat_73766:
		dc.w 3-1
		dc.l loc_7308E
		dc.b    0,   8
		dc.l loc_730F8
		dc.b    0, $30
		dc.l loc_73100
		dc.b    0, $5C
ChildObjDat_7377A:
		dc.w 4-1
		dc.l loc_73138
		dc.b -$10,  -4
		dc.l loc_73138
		dc.b  $10,  -4
		dc.l loc_73138
		dc.b -$10, $10
		dc.l loc_73138
		dc.b  $10, $10
ChildObjDat_73794:
		dc.w 6-1
		dc.l loc_73138
		dc.b -$10,  -8
		dc.l loc_73138
		dc.b  $10,  -8
		dc.l loc_73138
		dc.b -$10, $10
		dc.l loc_73138
		dc.b  $10, $10
		dc.l loc_73138
		dc.b -$14,-$20
		dc.l loc_73138
		dc.b  $14,-$20
ChildObjDat_737BA:
		dc.w 2-1
		dc.l loc_731CE
		dc.b    0,   0
ChildObjDat_737C2:
		dc.w 1-1
		dc.l loc_7321A
		dc.b   -8,   0
		dc.w 1-1
		dc.l loc_7321A
		dc.b    8,   0
ChildObjDat_737D2:
		dc.w 1-1
		dc.l loc_7333A
		dc.b  $20,   0
ChildObjDat_737DA:
		dc.w 2-1
		dc.l loc_73364
		dc.b -$14, $30
		dc.l loc_73364
		dc.b  $14, $30
ChildObjDat_737E8:
		dc.w 1-1
		dc.l loc_73396
		dc.b    0,   0
ChildObjDat_737F0:
		dc.w 1-1
		dc.l loc_73164
		dc.b    0,-$14
ChildObjDat_737F8:
		dc.w 2-1
		dc.l loc_73192
		dc.b -$10,   0
		dc.l loc_73192
		dc.b  $10,   0
ChildObjDat_73806:
		dc.w 2-1
		dc.l loc_72D24
ChildObjDat_7380C:
		dc.w 7-1
		dc.l loc_72E9E
		dc.b    0,   0
		dc.l loc_72E9E
		dc.b -$10, $28
		dc.l loc_72E9E
		dc.b -$70,   0
		dc.l loc_72E9E
		dc.b -$48, $28
		dc.l loc_72E9E
		dc.b  $18, $10
		dc.l loc_72E9E
		dc.b -$24,  -8
		dc.l loc_72E9E
		dc.b -$50, $1C
ChildObjDat_73838:
		dc.w 1-1
		dc.l loc_72F4C
ChildObjDat_7383E:
		dc.w 1-1
		dc.l loc_72FB2
byte_73844:
		dc.b    2,   9,  $A,  $B, $FC
byte_73849:
		dc.b    0, $17, $17, $18, $19, $1A, $1B, $F4
byte_73851:
		dc.b    0, $1C, $1C, $1D, $1E, $F4
byte_73857:
		dc.b    0, $1F, $1F, $20, $21, $F4
byte_7385D:
		dc.b    1,  $C,  $D,  $E,  $D,  $C, $F4
byte_73864:
		dc.b    2,   4,   4,   5,   6, $F4
byte_7386A:
		dc.b    5, $C4
		dc.b    0, $55
		dc.b    0, $59
		dc.b    1, $5A
		dc.b    1,   0
byte_73874:
		dc.b    5, $C4
		dc.b    0, $55
		dc.b    0, $59
		dc.b    1, $5A
		dc.b    1, $5A
		dc.b    1, $5A
		dc.b    1, $5A
		dc.b    1, $5A
		dc.b    1,   0
		even
Pal_LBZFinalBoss1:
		binclude "Levels/LBZ/Palettes/Final Boss 1.bin"
		even
Pal_LBZEnding:
		binclude "Levels/LBZ/Palettes/Ending.bin"
		even
