Obj_FBZEndBoss:
		move.l	#Obj_Wait,(a0)
		move.b	#1,(Boss_flag).w
		move.w	#(2*60)-1,$2E(a0)
		move.l	#loc_70632,$34(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		jsr	(AllocateObject).l
		bne.s	+ ;loc_70620
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_EndBoss,subtype(a1)

+ ;loc_70620:
		moveq	#$6F,d0
		jsr	(Load_PLC).l
		lea	Pal_FBZEndBoss(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_70632:
		move.l	#loc_7063A,(a0)

locret_70638:
		rts
; ---------------------------------------------------------------------------

loc_7063A:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	FBZEndBoss_Index(pc,d0.w),d1
		jsr	FBZEndBoss_Index(pc,d1.w)
		bsr.w	sub_70E10
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
FBZEndBoss_Index:
		dc.w loc_7065C-FBZEndBoss_Index
		dc.w loc_706AC-FBZEndBoss_Index
		dc.w loc_706E2-FBZEndBoss_Index
		dc.w loc_7071A-FBZEndBoss_Index
		dc.w loc_707BC-FBZEndBoss_Index
; ---------------------------------------------------------------------------

loc_7065C:
		lea	ObjDat_FBZEndBoss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#8,collision_property(a0)
		move.b	#$80,$3C(a0)
		move.w	(Camera_X_pos_copy).w,d0
		addi.w	#$A0,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$60,d0
		move.w	d0,y_pos(a0)
		lea	(Child1_MakeFBZRoboShip).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	+ ;loc_706A2
		move.b	#$B,subtype(a1)
		move.w	a1,$3E(a0)

+ ;loc_706A2:
		lea	ChildObjDat_70EE0(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_706AC:
		jsr	(MoveSprite).l
		move.w	#$690,d0
		subi.w	#$48,d0
		cmp.w	y_pos(a0),d0
		bls.s	+ ;loc_706C2
		rts
; ---------------------------------------------------------------------------

+ ;loc_706C2:
		move.w	d0,y_pos(a0)
		move.b	#4,routine(a0)
		bset	#7,$38(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_70700,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_706E2:
		bsr.w	sub_70C72
		addq.b	#4,$3C(a0)
		lea	(FBZEndBoss_CircleLookup1).l,a2
		jsr	(MoveSprite_AngleYLookup).l
		bsr.w	sub_70DC8
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_70700:
		move.b	#6,routine(a0)
		bset	#3,$38(a0)
		move.w	#$3F,$2E(a0)
		move.b	#9,$39(a0)
		rts
; ---------------------------------------------------------------------------

loc_7071A:
		bsr.w	sub_70DAC
		jsr	(Find_SonicTails).l
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	+ ;loc_70736
		bset	#1,$38(a0)
		bra.w	++ ;loc_7075A
; ---------------------------------------------------------------------------

+ ;loc_70736:
		btst	#1,$38(a0)
		bne.s	locret_70788
		btst	#0,$38(a0)
		bne.s	+ ;loc_7075A
		cmpi.w	#$18,d2
		bhs.s	+ ;loc_7075A
		btst	#Status_InAir,status(a1)
		bne.s	+ ;loc_7075A
		ori.b	#3,$38(a0)

+ ;loc_7075A:
		subq.w	#1,$2E(a0)
		bpl.s	locret_70788
		move.w	#$1F,$2E(a0)
		bclr	#0,$38(a0)
		subq.b	#1,$39(a0)
		bmi.s	+ ;loc_7078A
		bset	#3,$38(a0)
		bclr	#0,render_flags(a0)
		tst.w	d0
		bne.s	locret_70788
		bset	#0,render_flags(a0)

locret_70788:
		rts
; ---------------------------------------------------------------------------

+ ;loc_7078A:
		move.b	#8,routine(a0)
		bset	#2,$38(a0)
		move.l	#loc_707EC,$34(a0)
		moveq	#2,d0
		move.w	#$1FF,d1
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	+ ;loc_707B2
		moveq	#2,d0
		move.w	#$FF,d1

+ ;loc_707B2:
		move.b	d0,$40(a0)
		move.w	d1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_707BC:
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	+ ;loc_707CA
		bset	#1,$38(a0)

+ ;loc_707CA:
		bsr.w	sub_70C72
		move.b	$40(a0),d0
		add.b	d0,$3C(a0)
		lea	(FBZEndBoss_CircleLookup1).l,a2
		jsr	(MoveSprite_AngleYLookup).l
		bsr.w	sub_70DC8
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_707EC:
		bclr	#2,$38(a0)
		bra.w	loc_70700
; ---------------------------------------------------------------------------

loc_707F6:
		tst.b	$3C(a0)
		beq.s	loc_7081A
		move.b	$40(a0),d0
		add.b	d0,$3C(a0)
		lea	(FBZEndBoss_CircleLookup1).l,a2
		jsr	(MoveSprite_AngleYLookup).l
		bsr.w	sub_70DC8
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7081A:
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.w	#$200,priority(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_70836,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_70836:
		move.l	#Obj_Wait,(a0)
		bset	#4,$38(a0)
		move.l	#loc_70854,$34(a0)
		lea	ChildObjDat_70F0A(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_70854:
		move.l	#Obj_Wait,(a0)
		bclr	#7,render_flags(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_70870,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_70870:
		move.l	#loc_708AA,(a0)
		st	(_unkFAA8).w
		clr.b	(Boss_flag).w
		jsr	(AllocateObject).l
		bne.s	+ ;loc_70898
		move.l	#Obj_EggCapsule,(a1)
		move.w	#$307C,x_pos(a1)
		move.w	#$660,y_pos(a1)

+ ;loc_70898:
		move.w	#$2FDC,(Camera_stored_max_X_pos).w
		lea	(Child6_IncLevX).l,a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_708AA:
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		tst.b	(_unkFAA8).w
		bne.w	locret_70638
		move.l	#loc_7092A,(a0)
		jsr	(Restore_PlayerControl).l
		clr.w	(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		clr.w	$2E(a0)
		lea	(Player_2).w,a1
		jsr	(Restore_PlayerControl2).l
		jsr	(Restore_LevelMusic).l
		jsr	(AllocateObject).l
		bne.s	+ ;loc_708EE
		move.l	#loc_863C0,(a1)

+ ;loc_708EE:
		move.w	#$1000,(Camera_target_max_Y_pos).w
		move.w	#$3738,(Camera_stored_max_X_pos).w
		lea	(Child6_IncLevX).l,a2
		jsr	(CreateChild6_Simple).l
		lea	PLCKosM_FBZEndBoss_Exit(pc),a6
		move.w	(a6)+,d6

- ;loc_7090C:
		movea.l	(a6)+,a1
		move.w	(a6)+,d2
		jsr	(Queue_Kos_Module).l
		dbf	d6,- ;loc_7090C
		rts
; ---------------------------------------------------------------------------
PLCKosM_FBZEndBoss_Exit: plrlistheader
		plreq $3E5, ArtKosM_FBZExitDoor
		plreq $3F4, ArtKosM_FBZExitHall
PLCKosM_FBZEndBoss_Exit_End
; ---------------------------------------------------------------------------

loc_7092A:
		cmpi.w	#$720,(Camera_Y_pos).w
		bhs.s	+ ;loc_70938
		jmp	(loc_86334).l
; ---------------------------------------------------------------------------

+ ;loc_70938:
		move.w	#$800,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_70948:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_7095C(pc,d0.w),d1
		jsr	off_7095C(pc,d1.w)
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_7095C:
		dc.w loc_70966-off_7095C
		dc.w loc_70990-off_7095C
		dc.w loc_709A8-off_7095C
		dc.w loc_70A0C-off_7095C
		dc.w loc_70A28-off_7095C
; ---------------------------------------------------------------------------

loc_70966:
		lea	word_70E98(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		lea	ChildObjDat_70EF4(pc),a2
		jsr	(CreateChild1_Normal).l
		movea.w	parent3(a0),a1
		tst.b	subtype(a0)
		bne.s	+ ;loc_7098A
		move.w	a0,$44(a1)
		rts
; ---------------------------------------------------------------------------

+ ;loc_7098A:
		move.w	a0,parent3(a1)
		rts
; ---------------------------------------------------------------------------

loc_70990:
		movea.w	parent3(a0),a1
		btst	#7,$38(a1)
		bne.s	+ ;loc_709A2
		jmp	(Refresh_ChildPosition).l
; ---------------------------------------------------------------------------

+ ;loc_709A2:
		move.b	#4,routine(a0)

loc_709A8:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	+++ ;loc_709EC
		btst	#3,$38(a1)
		bne.s	+ ;loc_709BE
		rts
; ---------------------------------------------------------------------------

+ ;loc_709BE:
		move.b	#6,routine(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		btst	#0,render_flags(a1)
		beq.s	+ ;loc_709D6
		addq.w	#8,d0

+ ;loc_709D6:
		lea	word_709FC(pc,d0.w),a1
		move.w	(a1)+,x_vel(a0)
		move.w	(a1)+,$2E(a0)
		move.l	#loc_70A12,$34(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_709EC:
		lea	ChildObjDat_70F24(pc),a2
		jsr	(CreateChild1_Normal).l
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------
word_709FC:
		dc.w   $100,     7
		dc.w   $100,     0
		dc.w  -$100,     0
		dc.w  -$100,     7
; ---------------------------------------------------------------------------

loc_70A0C:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_70A12:
		move.b	#8,routine(a0)
		move.w	#7,$2E(a0)
		move.l	#loc_70A34,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_70A28:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_70A34:
		move.b	#4,routine(a0)
		movea.w	parent3(a0),a1
		bclr	#3,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_70A46:
		lea	word_70E9E(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_70A76,(a0)
		movea.w	parent3(a0),a1
		tst.b	subtype(a1)
		beq.s	+ ;loc_70A66
		bset	#0,render_flags(a0)

+ ;loc_70A66:
		move.w	parent3(a1),$44(a0)
		lea	ChildObjDat_70EFC(pc),a2
		jsr	(CreateChild3_NormalRepeated).l

loc_70A76:
		movea.w	$44(a0),a1
		move.b	$3C(a1),$3C(a0)
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		lea	(FBZEndBoss_CircleLookup2).l,a2
		jsr	(MoveSprite_AngleYLookup).l
		bsr.w	sub_70DFA
		moveq	#0,d0
		jmp	(Child_Draw_Sprite2_FlickerMove).l
; ---------------------------------------------------------------------------

loc_70AA2:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_70AB8(pc,d0.w),d1
		jsr	off_70AB8(pc,d1.w)
		moveq	#8,d0
		jmp	(Child_Draw_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------
off_70AB8:
		dc.w loc_70ABC-off_70AB8
		dc.w loc_70AF2-off_70AB8
; ---------------------------------------------------------------------------

loc_70ABC:
		lea	word_70E9E(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		movea.w	parent3(a0),a1
		moveq	#-$1C,d0
		btst	#0,render_flags(a1)
		beq.s	+ ;loc_70ADC
		bset	#0,render_flags(a0)
		neg.w	d0

+ ;loc_70ADC:
		movea.w	parent3(a1),a1
		move.w	parent3(a1),$44(a0)
		move.b	d0,child_dx(a0)
		move.b	#2,child_dy(a0)
		rts
; ---------------------------------------------------------------------------

loc_70AF2:
		jsr	(Child_GetPriority).l
		bra.w	loc_70C8E
; ---------------------------------------------------------------------------

loc_70AFC:
		lea	word_70EA4(pc),a1
		jsr	(SetUp_ObjAttributes3).l

loc_70B06:
		move.l	#loc_70B18,(a0)
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_70B18:
		jsr	(Child_GetPriority).l
		btst	#7,status(a1)
		bne.s	++ ;loc_70B58
		btst	#1,$38(a1)
		beq.s	+ ;loc_70B4C
		move.l	#loc_70B74,(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_70B06,$34(a0)
		lea	ChildObjDat_70F04(pc),a2
		jsr	(CreateChild6_Simple).l

+ ;loc_70B4C:
		jsr	(Refresh_ChildPosition).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_70B58:
		move.l	#loc_70B80,(a0)
		move.w	$3E(a1),$46(a0)
		subq.b	#4,child_dy(a0)
		jsr	(Refresh_ChildPosition).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_70B74:
		jsr	(Child_GetPriority).l
		jmp	(Refresh_ChildPosWait).l
; ---------------------------------------------------------------------------

loc_70B80:
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_70B8C:
		bsr.w	sub_70D10
		move.l	#Obj_Wait,(a0)
		move.l	#loc_70BA0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_70BA0:
		move.l	#loc_70BB0,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_70BB0:
		moveq	#signextendB(sfx_FlamethrowerQuiet),d0
		jsr	(Play_SFX_Continuous).l
		jsr	(Child_GetPriority).l
		jsr	(Refresh_ChildPosition).l
		jsr	(Animate_RawMultiDelay).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_70BD0:
		lea	word_70EAA(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		jsr	(Refresh_ChildPositionAdjusted).l
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		addi.b	#8,d0
		move.b	d0,mapping_frame(a0)
		moveq	#$34,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

loc_70BFE:
		lea	word_70EAA(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		jsr	(Refresh_ChildPositionAdjusted).l
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		addi.b	#$C,d0
		move.b	d0,mapping_frame(a0)
		moveq	#8,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

Obj_FBZExitDoor:
		lea	ObjDat_FBZExitDoor(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_70C3C,(a0)

loc_70C3C:
		jsr	(Check_PlayerCollision).l
		bne.s	+ ;loc_70C4A
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_70C4A:
		move.l	#loc_70C66,(a0)
		move.w	#$800,x_vel(a0)
		lea	(Player_1).w,a1
		subq.w	#8,x_pos(a1)
		moveq	#signextendB(sfx_FloorThump),d0
		jsr	(Play_SFX).l

loc_70C66:
		jsr	(MoveSprite_LightGravity).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_70C72:
		cmpi.w	#4,$2E(a0)
		blo.s	locret_70C8C
		move.b	$3C(a0),d0
		andi.b	#$7F,d0
		bne.s	locret_70C8C
		moveq	#signextendB(sfx_SpikeBalls),d0
		jsr	(Play_SFX).l

locret_70C8C:
		rts
; End of function sub_70C72

; ---------------------------------------------------------------------------

loc_70C8E:
		movea.w	$44(a0),a1
		movea.w	parent3(a0),a2
		move.w	x_pos(a1),d0
		move.b	child_dx(a0),d1
		ext.w	d1
		add.w	d0,d1
		move.w	x_pos(a2),d2
		sub.w	d2,d1
		moveq	#$10,d3
		moveq	#0,d4
		move.b	subtype(a0),d4
		bsr.w	sub_70CE4
		move.w	y_pos(a1),d0
		move.b	child_dy(a0),d1
		ext.w	d1
		add.w	d0,d1
		move.w	y_pos(a2),d2
		sub.w	d2,d1
		moveq	#$14,d3
		bsr.w	sub_70CE4
		tst.b	$3C(a2)
		beq.s	locret_70CDA
		bmi.s	locret_70CDA
		move.w	word_70CDC(pc,d4.w),priority(a0)

locret_70CDA:
		rts
; ---------------------------------------------------------------------------
word_70CDC:
		dc.w   $180
		dc.w   $100
		dc.w    $80
		dc.w      0

; =============== S U B R O U T I N E =======================================


sub_70CE4:
		move.w	off_70CEC(pc,d4.w),d5
		jmp	off_70CEC(pc,d5.w)
; End of function sub_70CE4

; ---------------------------------------------------------------------------
off_70CEC:
		dc.w loc_70CF4-off_70CEC
		dc.w loc_70CFA-off_70CEC
		dc.w loc_70D00-off_70CEC
		dc.w loc_70D08-off_70CEC
; ---------------------------------------------------------------------------

loc_70CF4:
		asr.w	#2,d1
		bra.w	loc_70D08
; ---------------------------------------------------------------------------

loc_70CFA:
		asr.w	#1,d1
		bra.w	loc_70D08
; ---------------------------------------------------------------------------

loc_70D00:
		asr.w	#1,d1
		move.w	d1,d0
		asr.w	#1,d1
		add.w	d0,d1

loc_70D08:
		add.w	d1,d2
		move.w	d2,(a0,d3.w)
		rts

; =============== S U B R O U T I N E =======================================


sub_70D10:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_70D40(pc,d0.w),$2E(a0)
		move.w	byte_70D52(pc,d0.w),child_dx(a0)	; and child_dy
		add.w	d0,d0
		move.l	off_70D64(pc,d0.w),$30(a0)
		movea.l	off_70D88(pc,d0.w),a1
		jsr	(SetUp_ObjAttributes).l
		bset	#4,shield_reaction(a0)
		jmp	(Refresh_ChildPosition).l
; End of function sub_70D10

; ---------------------------------------------------------------------------
word_70D40:
		dc.w    $50
		dc.w    $4D
		dc.w    $4A
		dc.w    $47
		dc.w    $44
		dc.w    $41
		dc.w    $3E
		dc.w    $3B
		dc.w      0
byte_70D52:
		dc.b    0,-$68
		dc.b    8,-$5C
		dc.b   -8,-$5C
		dc.b    0,-$4C
		dc.b    0,-$3C
		dc.b    0,-$2C
		dc.b    0,-$1C
		dc.b    0, -$C
		dc.b    0,-$10
off_70D64:
		dc.l byte_70F70
		dc.l byte_70F70
		dc.l byte_70F70
		dc.l byte_70F61
		dc.l byte_70F61
		dc.l byte_70F61
		dc.l byte_70F61
		dc.l byte_70F61
		dc.l byte_70F3E
off_70D88:
		dc.l ObjDat3_70EC8
		dc.l ObjDat3_70EC8
		dc.l ObjDat3_70EC8
		dc.l ObjDat3_70EBC
		dc.l ObjDat3_70EBC
		dc.l ObjDat3_70EBC
		dc.l ObjDat3_70EBC
		dc.l ObjDat3_70EBC
		dc.l ObjDat3_70EB0

; =============== S U B R O U T I N E =======================================


sub_70DAC:
		movea.w	$44(a0),a1
		movea.w	parent3(a0),a2
		move.w	x_pos(a1),d0
		move.w	x_pos(a2),d1
		sub.w	d0,d1
		asr.w	#1,d1
		add.w	d1,d0
		move.w	d0,x_pos(a0)
		rts
; End of function sub_70DAC


; =============== S U B R O U T I N E =======================================


sub_70DC8:
		tst.b	$3C(a0)
		beq.s	loc_70DEC
		bmi.s	loc_70DDE
		bset	#7,art_tile(a0)
		move.w	#0,priority(a0)
		rts
; ---------------------------------------------------------------------------

loc_70DDE:
		bclr	#7,art_tile(a0)
		move.w	#$300,priority(a0)
		rts
; ---------------------------------------------------------------------------

loc_70DEC:
		bset	#7,art_tile(a0)
		move.w	#$300,priority(a0)
		rts
; End of function sub_70DC8


; =============== S U B R O U T I N E =======================================


sub_70DFA:
		tst.b	$3C(a0)
		beq.s	loc_70DEC
		bmi.s	loc_70DDE
		bset	#7,art_tile(a0)
		move.w	#$200,priority(a0)
		rts
; End of function sub_70DFA


; =============== S U B R O U T I N E =======================================


sub_70E10:
		tst.l	(a0)
		beq.s	locret_70E66
		tst.b	collision_flags(a0)
		bne.s	locret_70E66
		tst.b	collision_property(a0)
		beq.s	+++ ;loc_70E68
		tst.b	$20(a0)
		bne.s	+ ;loc_70E34
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

+ ;loc_70E34:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	+ ;loc_70E46
		addq.w	#2*4,d0

+ ;loc_70E46:
		lea	word_70E74(pc),a1
		lea	word_70E7C(pc,d0.w),a2
		jsr	(CopyWordData_4).l
		subq.b	#1,$20(a0)
		bne.s	locret_70E66
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_70E66:
		rts
; ---------------------------------------------------------------------------

+ ;loc_70E68:
		move.l	#loc_707F6,(a0)
		jmp	(BossDefeated_StopTimer).l
; End of function sub_70E10

; ---------------------------------------------------------------------------
word_70E74:
		dc.w Normal_palette_line_2+$06, Normal_palette_line_2+$08, Normal_palette_line_2+$12, Normal_palette_line_2+$1C
word_70E7C:
		dc.w    $2A,   $26,   $20,  $644
		dc.w   $888,  $AAA,  $EEE,  $AAA
ObjDat_FBZEndBoss:
		dc.l Map_FBZEndBoss
		dc.w make_art_tile($400,1,1)
		dc.w   $200
		dc.b  $28, $18,   0, $16
word_70E98:
		dc.w   $280
		dc.b  $10, $20,   1, $A3
word_70E9E:
		dc.w   $200
		dc.b    8,   8,   2,   0
word_70EA4:
		dc.w   $180
		dc.b   $C,   8,   3,   0
word_70EAA:
		dc.w    $80
		dc.b  $14, $10,   8,   0
ObjDat3_70EB0:
		dc.l Map_FBZEndBoss
		dc.w make_art_tile($400,0,1)
		dc.w      0
		dc.b    4,   8,   4, $8B
ObjDat3_70EBC:
		dc.l Map_BossExplosion
		dc.w make_art_tile($500,0,1)
		dc.w      0
		dc.b  $10, $10,   0, $8B
ObjDat3_70EC8:
		dc.l Map_FBZEndBossFlame
		dc.w make_art_tile($450,0,1)
		dc.w      0
		dc.b  $10, $10,   0, $8B
ObjDat_FBZExitDoor:
		dc.l Map_FBZExitDoor
		dc.w make_art_tile($3E5,2,0)
		dc.w    $80
		dc.b    8, $20,   0, $D7
ChildObjDat_70EE0:
		dc.w 3-1
		dc.l loc_70948
		dc.b -$30, $48
		dc.l loc_70948
		dc.b  $30, $48
		dc.l loc_70AFC
		dc.b    0,-$28
ChildObjDat_70EF4:
		dc.w 1-1
		dc.l loc_70A46
		dc.b    0,-$20
ChildObjDat_70EFC:
		dc.w 4-1
		dc.l loc_70AA2
		dc.b    0,   0
ChildObjDat_70F04:
		dc.w 9-1
		dc.l loc_70B8C
ChildObjDat_70F0A:
		dc.w 4-1
		dc.l loc_70BD0
		dc.b -$14,   8
		dc.l loc_70BD0
		dc.b  $14,   8
		dc.l loc_70BD0
		dc.b -$10, $20
		dc.l loc_70BD0
		dc.b  $10, $20
ChildObjDat_70F24:
		dc.w 4-1
		dc.l loc_70BFE
		dc.b   -8,-$10
		dc.l loc_70BFE
		dc.b    8,-$10
		dc.l loc_70BFE
		dc.b   -8, $10
		dc.l loc_70BFE
		dc.b    8, $10
byte_70F3E:
		dc.b    4,   3
		dc.b    4,   3
		dc.b    5,   3
		dc.b    6,   3
		dc.b    7,   3
		dc.b    4,   3
		dc.b    5,   3
		dc.b    6,   3
		dc.b    7,   3
		dc.b    4,   3
		dc.b    5,   3
		dc.b    6,   3
		dc.b    7,   3
		dc.b    4,   3
		dc.b    5,   3
		dc.b    6,   3
		dc.b    7,   3
		dc.b  $F4
byte_70F61:
		dc.b    0,   2
		dc.b    0,   2
		dc.b    1,   2
		dc.b    2,   3
		dc.b    3,   4
		dc.b    4,   5
		dc.b    5,   6
		dc.b  $F4
byte_70F70:
		dc.b    0,   2
		dc.b    0,   2
		dc.b    1,   3
		dc.b    2,   4
		dc.b    3,   5
		dc.b    4,   6
		dc.b  $F4
		even
Map_FBZExitDoor:
		include "Levels/FBZ/Misc Object Data/Map - Exit Door.asm"
Pal_FBZEndBoss:
		binclude "Levels/FBZ/Palettes/FBZ End Boss.bin"
		even
Map_FBZEndBoss:
		include "Levels/FBZ/Misc Object Data/Map - End Boss.asm"
Map_FBZEndBossFlame:
		include "Levels/FBZ/Misc Object Data/Map - End Boss Flame.asm"
FBZEndBoss_CircleLookup1:
		dc.b    0,   2,   4,   5,   7,   9,  $B,  $C,  $E, $10, $11, $13, $15, $17, $18, $1A, $1C, $1D, $1F, $20
		dc.b  $22, $23, $25, $27, $28, $29, $2B, $2C, $2E, $2F, $30, $32, $33, $34, $35, $37, $38, $39, $3A, $3B
		dc.b  $3C, $3D, $3E, $3F, $3F, $40, $41, $42, $43, $43, $44, $44, $45, $45, $46, $46, $47, $47, $47, $47
		dc.b  $48, $48, $48, $48
FBZEndBoss_CircleLookup2:
		dc.b    0,   1,   2,   2,   3,   4,   5,   5,   6,   7,   8,   9,   9,  $A,  $B,  $C,  $C,  $D,  $E,  $E
		dc.b   $F, $10, $10, $11, $12, $12, $13, $14, $14, $15, $15, $16, $17, $17, $18, $18, $19, $19, $1A, $1A
		dc.b  $1B, $1B, $1B, $1C, $1C, $1D, $1D, $1D, $1E, $1E, $1E, $1E, $1F, $1F, $1F, $1F, $1F, $20, $20, $20
		dc.b  $20, $20, $20, $20
		even
