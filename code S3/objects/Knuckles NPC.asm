Obj_CutsceneKnuckles:
		move.w	a0,(_unkFAA4).w
		moveq	#0,d0
		move.b	subtype(a0),d0
		movea.l	CutsceneKnuckles_Index(pc,d0.w),a1
		move.l	a1,(a0)
		jmp	(a1)
; ---------------------------------------------------------------------------
CutsceneKnuckles_Index:
		dc.l CutsceneKnux_AIZ1
		dc.l CutsceneKnux_AIZ2
		dc.l CutsceneKnux_HCZ2
		dc.l CutsceneKnux_CNZ2A
		dc.l CutsceneKnux_CNZ2B
		dc.l CutsceneKnux_LBZ1
		dc.l CutsceneKnux_LBZ2
; ---------------------------------------------------------------------------

CutsceneKnux_AIZ1:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_AIZ1_Index(pc,d0.w),d1
		jsr	CutsceneKnux_AIZ1_Index(pc,d1.w)
		lea	DPLCPtr_CutsceneKnux(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
CutsceneKnux_AIZ1_Index:
		dc.w loc_4474C-CutsceneKnux_AIZ1_Index
		dc.w loc_44782-CutsceneKnux_AIZ1_Index
		dc.w loc_447B2-CutsceneKnux_AIZ1_Index
		dc.w loc_447F2-CutsceneKnux_AIZ1_Index
		dc.w loc_44824-CutsceneKnux_AIZ1_Index
		dc.w loc_4486E-CutsceneKnux_AIZ1_Index
		dc.w loc_4489E-CutsceneKnux_AIZ1_Index
; ---------------------------------------------------------------------------

loc_4474C:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		bclr	#7,art_tile(a0)
		move.b	#$13,y_radius(a0)
		move.b	#8,mapping_frame(a0)
		move.w	#$1400,x_pos(a0)
		move.w	#$440,y_pos(a0)
		bsr.w	sub_456C6
		lea	ChildObjDat_45756(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_44782:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_44790
		rts
; ---------------------------------------------------------------------------

loc_44790:
		move.b	#4,routine(a0)
		bset	#7,status(a0)
		move.w	#-$600,y_vel(a0)
		move.w	#$80,x_vel(a0)
		lea	Pal_CutsceneKnux(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_447B2:
		lea	byte_4577B(pc),a1
		jsr	(Animate_RawNoSST).l
		jsr	(MoveSprite).l
		tst.l	d0
		bmi.s	locret_447D0
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_447D2

locret_447D0:
		rts
; ---------------------------------------------------------------------------

loc_447D2:
		move.b	#6,routine(a0)
		add.w	d1,y_pos(a0)
		move.b	#$16,mapping_frame(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_447F8,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_447F2:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_447F8:
		move.b	#8,routine(a0)
		bchg	#0,render_flags(a0)
		move.l	#byte_45775,$30(a0)
		move.w	#-$600,x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#$29,$2E(a0)
		move.l	#loc_44836,$34(a0)

loc_44824:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_44836:
		neg.w	x_vel(a0)
		bchg	#0,render_flags(a0)
		move.w	#$29,$2E(a0)
		move.l	#loc_44850,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_44850:
		move.b	#$A,routine(a0)
		move.b	#$16,mapping_frame(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_4487A,$34(a0)
		bra.w	loc_449E4
; ---------------------------------------------------------------------------

loc_4486E:
		jsr	(Animate_Raw).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4487A:
		move.b	#$C,routine(a0)
		move.l	#byte_45775,$30(a0)
		move.w	#$600,x_vel(a0)
		jsr	(AllocateObject).l
		bne.s	locret_4489C
		move.l	#Obj_Song_Fade_ToLevelMusic,(a1)

locret_4489C:
		rts
; ---------------------------------------------------------------------------

loc_4489E:
		tst.b	render_flags(a0)
		bpl.s	loc_448B0
		jsr	(Animate_Raw).l
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_448B0:
		clr.b	(Palette_cycle_counters+$00).w
		clr.b	(Ctrl_1_locked).w
		jsr	(AfterBoss_Cleanup).l
		jsr	(Remove_From_TrackingSlot).l
		jsr	(AllocateObject).l
		bne.s	loc_448D2
		move.l	#Obj_TitleCard,(a1)

loc_448D2:
		move.b	#$91,(Level_started_flag).w
		move.b	#$80,(Update_HUD_timer).w
		clr.l	(Timer).w
		move.b	#1,(Update_HUD_life_count).w
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_448EE:
		lea	ObjDat3_4571E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_448FE,(a0)

loc_448FE:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_44910
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_44910:
		lea	(word_29AF0).l,a4
		addq.b	#1,mapping_frame(a0)
		move.l	#loc_29838,(a0)
		jmp	(BreakObjectToPieces).l
; ---------------------------------------------------------------------------

CutsceneKnux_AIZ2:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_AIZ2_Index(pc,d0.w),d1
		jsr	CutsceneKnux_AIZ2_Index(pc,d1.w)
		lea	DPLCPtr_CutsceneKnux(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
CutsceneKnux_AIZ2_Index:
		dc.w loc_44950-CutsceneKnux_AIZ2_Index
		dc.w loc_449A2-CutsceneKnux_AIZ2_Index
		dc.w loc_449B0-CutsceneKnux_AIZ2_Index
		dc.w loc_449FC-CutsceneKnux_AIZ2_Index
		dc.w loc_44A38-CutsceneKnux_AIZ2_Index
		dc.w loc_44A72-CutsceneKnux_AIZ2_Index
; ---------------------------------------------------------------------------

loc_44950:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.w	#$4B8E,x_pos(a0)
		move.w	#$17D,y_pos(a0)
		bset	#0,render_flags(a0)
		bsr.w	sub_456C6
		move.w	#(2*60)-1,$2E(a0)
		move.l	#loc_449A8,$34(a0)
		lea	Pal_CutsceneKnux(pc),a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_4572A(pc),a2
		jsr	(CreateChild6_Simple).l
		bne.s	locret_449A0
		move.w	#$4B08,x_pos(a1)
		move.w	#$178,y_pos(a1)

locret_449A0:
		rts
; ---------------------------------------------------------------------------

loc_449A2:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_449A8:
		move.b	#4,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_449B0:
		move.w	x_pos(a0),d0
		subq.w	#2,d0
		cmpi.w	#$4B3C,d0
		blo.s	loc_449CA
		move.w	d0,x_pos(a0)
		lea	byte_4576B(pc),a1
		jmp	(Animate_RawNoSST).l
; ---------------------------------------------------------------------------

loc_449CA:
		move.b	#6,routine(a0)
		bclr	#0,render_flags(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_44A08,$34(a0)

loc_449E4:
		move.l	#byte_45785,$30(a0)
		clr.b	anim_frame_timer(a0)
		clr.b	anim_frame(a0)
		move.b	#$1C,mapping_frame(a0)

locret_449FA:
		rts
; ---------------------------------------------------------------------------

loc_449FC:
		jsr	(Animate_Raw).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_44A08:
		move.b	#8,routine(a0)

loc_44A0E:
		move.w	#-$100,x_vel(a0)
		move.w	#-$400,y_vel(a0)

loc_44A1A:
		move.l	#byte_4577B,$30(a0)
		clr.b	anim_frame_timer(a0)
		clr.b	anim_frame(a0)
		move.b	#8,mapping_frame(a0)
		move.b	#$13,y_radius(a0)
		rts
; ---------------------------------------------------------------------------

loc_44A38:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	locret_44A64
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	locret_44A64
		bset	#2,$38(a0)
		bne.s	loc_44A66
		neg.w	x_vel(a0)
		neg.w	y_vel(a0)

locret_44A64:
		rts
; ---------------------------------------------------------------------------

loc_44A66:
		addq.b	#2,routine(a0)
		add.w	d1,y_pos(a0)
		bra.w	loc_449E4
; ---------------------------------------------------------------------------

loc_44A72:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_44A78:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	CutsceneKnux_Delete
		move.b	#8,width_pixels(a0)
		moveq	#$13,d1
		move.w	#$20,d2
		move.w	#$40,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectFull2).l
; ---------------------------------------------------------------------------

CutsceneKnux_Delete:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

CutsceneKnux_HCZ2:
		lea	word_44ADA(pc),a1
		jsr	(Check_CameraInRange).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_HCZ2_Index(pc,d0.w),d1
		jsr	CutsceneKnux_HCZ2_Index(pc,d1.w)
		lea	DPLCPtr_CutsceneKnux(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Sprite_CheckDeleteTouchSlotted).l
; ---------------------------------------------------------------------------
CutsceneKnux_HCZ2_Index:
		dc.w loc_44AE2-CutsceneKnux_HCZ2_Index
		dc.w loc_44B00-CutsceneKnux_HCZ2_Index
		dc.w loc_449A2-CutsceneKnux_HCZ2_Index
		dc.w loc_44B6C-CutsceneKnux_HCZ2_Index
		dc.w loc_449A2-CutsceneKnux_HCZ2_Index
		dc.w loc_44A38-CutsceneKnux_HCZ2_Index
		dc.w loc_44BAE-CutsceneKnux_HCZ2_Index
word_44ADA:
		dc.w   $540,  $600, $3900, $3940
; ---------------------------------------------------------------------------

loc_44AE2:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.w	(Camera_min_Y_pos).w,(Camera_stored_min_Y_pos).w
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w
		move.w	#$3940,(Camera_max_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_44B00:
		lea	(Player_1).w,a1
		cmpi.w	#$3990,x_pos(a1)
		blo.s	loc_44B1A
		tst.b	object_control(a1)
		bne.s	loc_44B1A
		btst	#Status_OnObj,status(a1)
		bne.s	loc_44B28

loc_44B1A:
		move.w	(Camera_Y_pos).w,(Camera_min_Y_pos).w
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_44B28:
		move.b	#4,routine(a0)
		bsr.w	sub_456C6
		move.w	#(3*60)-1,$2E(a0)
		move.l	#loc_44B42,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_44B42:
		move.b	#6,routine(a0)
		bset	#0,render_flags(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_44B82,$34(a0)
		move.w	#$5C0,(Camera_min_Y_pos).w
		lea	Pal_CutsceneKnux(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_44B6C:
		subq.w	#4,x_pos(a0)
		lea	(byte_4576B).l,a1
		jsr	(Animate_RawNoSST).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_44B82:
		move.b	#8,routine(a0)
		move.b	#$20,mapping_frame(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_44B9E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_44B9E:
		move.b	#$A,routine(a0)
		bchg	#0,render_flags(a0)
		bra.w	loc_44A0E
; ---------------------------------------------------------------------------

loc_44BAE:
		jsr	(Animate_Raw).l
		tst.b	render_flags(a0)
		bmi.w	locret_449FA
		lea	(Pal_HCZ2).l,a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_44BEC(pc),a2
		jsr	(CreateChild1_Normal).l
		jsr	(AllocateObject).l
		bne.s	loc_44BE0
		move.l	#Obj_Song_Fade_ToLevelMusic,(a1)

loc_44BE0:
		jsr	(Remove_From_TrackingSlot).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------
ChildObjDat_44BEC:
		dc.w 2-1
		dc.l Obj_DecLevStartYGradual
		dc.b    0,   0
		dc.l Obj_IncLevEndXGradual
		dc.b    0,   0
; ---------------------------------------------------------------------------

CutsceneKnux_CNZ2A:
		lea	word_44C2E(pc),a1
		jsr	(Check_CameraInRange).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_CNZ2A_Index(pc,d0.w),d1
		jsr	CutsceneKnux_CNZ2A_Index(pc,d1.w)
		lea	DPLCPtr_CutsceneKnux(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
CutsceneKnux_CNZ2A_Index:
		dc.w loc_44C36-CutsceneKnux_CNZ2A_Index
		dc.w loc_44CA2-CutsceneKnux_CNZ2A_Index
		dc.w loc_44CC4-CutsceneKnux_CNZ2A_Index
		dc.w loc_44CEC-CutsceneKnux_CNZ2A_Index
		dc.w loc_44CC4-CutsceneKnux_CNZ2A_Index
		dc.w loc_44D6E-CutsceneKnux_CNZ2A_Index
word_44C2E:
		dc.w   $176,  $300, $1B00, $1D00
; ---------------------------------------------------------------------------

loc_44C36:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.l	#byte_4578B,$30(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.w	#2*60,$2E(a0)
		move.b	#mus_Knuckles,$26(a0)
		move.w	(Camera_min_Y_pos).w,(Camera_stored_min_Y_pos).w
		move.w	(Camera_target_max_Y_pos).w,(Camera_stored_max_Y_pos).w
		move.w	(Camera_min_X_pos).w,(Camera_stored_min_X_pos).w
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w
		move.w	#$280,(Camera_target_max_Y_pos).w
		move.w	#$1D00,$1C(a0)
		move.w	#$1D00,(Camera_max_X_pos).w
		move.l	#loc_44CAE,$34(a0)
		lea	Pal_CutsceneKnux(pc),a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_45730(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_44CA2:
		jsr	(Animate_Raw).l
		jmp	(loc_541C8).l
; ---------------------------------------------------------------------------

loc_44CAE:
		move.b	#4,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_44CD0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_44CC4:
		jsr	(Animate_Raw).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_44CD0:
		move.b	#6,routine(a0)
		bset	#0,render_flags(a0)
		move.w	#-$600,y_vel(a0)
		move.w	#$140,x_vel(a0)
		bra.w	loc_44A1A
; ---------------------------------------------------------------------------

loc_44CEC:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	locret_44D26
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	locret_44D26
		moveq	#0,d0
		move.b	$39(a0),d0
		cmpi.b	#8,d0
		bhs.s	loc_44D28
		move.l	word_44D4A(pc,d0.w),x_vel(a0)	; and y_vel
		addq.b	#4,d0
		move.b	d0,$39(a0)
		bchg	#0,render_flags(a0)

locret_44D26:
		rts
; ---------------------------------------------------------------------------

loc_44D28:
		move.b	#8,routine(a0)
		bclr	#0,render_flags(a0)
		add.w	d1,y_pos(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_44D52,$34(a0)
		bra.w	loc_449E4
; ---------------------------------------------------------------------------
word_44D4A:
		dc.w  -$100, -$400
		dc.w   $100, -$400
; ---------------------------------------------------------------------------

loc_44D52:
		move.b	#$A,routine(a0)
		bset	#0,render_flags(a0)
		move.w	#-$600,y_vel(a0)
		move.w	#$400,x_vel(a0)
		bra.w	loc_44A1A
; ---------------------------------------------------------------------------

loc_44D6E:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite).l
		tst.b	render_flags(a0)
		bmi.w	locret_449FA
		lea	(Pal_CNZ).l,a1
		jsr	(PalLoad_Line1).l
		lea	(PLC_Monitors).l,a1
		jsr	(Load_PLC_Raw).l
		lea	ChildObjDat_44DC4(pc),a2
		jsr	(CreateChild1_Normal).l
		move.w	(Camera_stored_max_Y_pos).w,(Camera_target_max_Y_pos).w
		jsr	(AllocateObject).l
		bne.s	loc_44DB8
		move.l	#Obj_Song_Fade_ToLevelMusic,(a1)

loc_44DB8:
		jsr	(Remove_From_TrackingSlot).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------
ChildObjDat_44DC4:
		dc.w 3-1
		dc.l Obj_DecLevStartYGradual
		dc.b    0,   0
		dc.l Obj_DecLevStartXGradual
		dc.b    0,   0
		dc.l Obj_IncLevEndXGradual
		dc.b    0,   0
; ---------------------------------------------------------------------------

loc_44DD8:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_44DFE
		move.b	#8,width_pixels(a0)
		moveq	#$13,d1
		move.w	#$100,d2
		move.w	#$200,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectFull2).l
; ---------------------------------------------------------------------------

loc_44DFE:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_44E04:
		subq.w	#1,$2E(a0)
		bpl.s	locret_44E3E
		moveq	#0,d0
		move.b	$39(a0),d0
		cmpi.b	#6,d0
		bhs.s	loc_44E40
		addq.b	#1,$39(a0)
		add.w	d0,d0
		move.w	word_44E54(pc,d0.w),$2E(a0)
		moveq	#0,d1
		btst	#1,d0
		beq.s	loc_44E2C
		moveq	#$40,d1

loc_44E2C:
		lea	Pal_CNZFlash(pc),a1
		adda.w	d1,a1

; =============== S U B R O U T I N E =======================================


sub_44E32:
		lea	(Normal_palette_line_3).w,a2
		moveq	#bytesToLcnt($40),d0

loc_44E38:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_44E38

locret_44E3E:
		rts
; End of function sub_44E32

; ---------------------------------------------------------------------------

loc_44E40:
		tst.b	subtype(a0)
		beq.s	loc_44E4E
		lea	(Pal_CNZ+$20).l,a1
		bsr.s	sub_44E32

loc_44E4E:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
word_44E54:
		dc.w      8
		dc.w      4
		dc.w      3
		dc.w      2
		dc.w      4
		dc.w      8
		dc.w      8
; ---------------------------------------------------------------------------

CutsceneKnux_CNZ2B:
		lea	word_44E9A(pc),a1
		jsr	(Check_CameraInRange).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_CNZ2B_Index(pc,d0.w),d1
		jsr	CutsceneKnux_CNZ2B_Index(pc,d1.w)
		lea	DPLCPtr_CutsceneKnux(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Sprite_CheckDeleteTouchSlotted).l
; ---------------------------------------------------------------------------
CutsceneKnux_CNZ2B_Index:
		dc.w loc_44EA2-CutsceneKnux_CNZ2B_Index
		dc.w loc_44EC8-CutsceneKnux_CNZ2B_Index
		dc.w loc_44EE6-CutsceneKnux_CNZ2B_Index
		dc.w loc_449A2-CutsceneKnux_CNZ2B_Index
		dc.w loc_44A38-CutsceneKnux_CNZ2B_Index
		dc.w loc_44F38-CutsceneKnux_CNZ2B_Index
		dc.w loc_44F5C-CutsceneKnux_CNZ2B_Index
		dc.w loc_44F94-CutsceneKnux_CNZ2B_Index
word_44E9A:
		dc.w   $720,  $A00, $45C0, $46E0
; ---------------------------------------------------------------------------

loc_44EA2:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		clr.w	(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		move.b	#$80,(Player_1+object_control).w
		bsr.w	sub_456C6
		lea	Pal_CutsceneKnux(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_44EC8:
		lea	(Player_1).w,a1
		cmpi.w	#$4728,x_pos(a1)
		blo.s	locret_44EDC
		btst	#Status_InAir,status(a1)
		bne.s	loc_44EDE

locret_44EDC:
		rts
; ---------------------------------------------------------------------------

loc_44EDE:
		move.b	#4,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_44EE6:
		move.w	#(button_right_mask<<8)+button_right_mask,(Ctrl_1_logical).w
		cmpi.w	#$4760,(Player_1+x_pos).w
		bhs.s	loc_44EF6
		rts
; ---------------------------------------------------------------------------

loc_44EF6:
		move.b	#6,routine(a0)
		clr.w	(Ctrl_1_logical).w
		lea	(Player_1).w,a1
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		clr.w	ground_vel(a1)
		move.w	#$1F,$2E(a0)
		move.l	#loc_44F20,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_44F20:
		move.b	#8,routine(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_44F44,$34(a0)
		bra.w	loc_44A0E
; ---------------------------------------------------------------------------

loc_44F38:
		jsr	(Animate_Raw).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_44F44:
		move.b	#$C,routine(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		move.l	#byte_4576B,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_44F5C:
		addq.w	#4,x_pos(a0)
		jsr	(Animate_Raw).l
		tst.b	render_flags(a0)
		bmi.w	locret_449FA
		move.b	#$E,routine(a0)
		clr.b	(Player_1+object_control).w
		lea	(Pal_CNZ).l,a1
		jsr	(PalLoad_Line1).l
		jsr	(AllocateObject).l
		bne.s	locret_44F92
		move.l	#Obj_Song_Fade_ToLevelMusic,(a1)

locret_44F92:
		rts
; ---------------------------------------------------------------------------

loc_44F94:
		move.w	#(button_left_mask<<8)+button_left_mask,(Ctrl_1_logical).w
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$160,d0
		cmp.w	y_pos(a0),d0
		blo.s	loc_44FAA
		rts
; ---------------------------------------------------------------------------

loc_44FAA:
		clr.b	(Ctrl_1_locked).w
		jsr	(Remove_From_TrackingSlot).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

CutsceneKnux_LBZ1:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_LBZ1_Index(pc,d0.w),d1
		jsr	CutsceneKnux_LBZ1_Index(pc,d1.w)
		lea	DPLCPtr_CutsceneKnux(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Sprite_CheckDeleteTouchSlotted).l
; ---------------------------------------------------------------------------
CutsceneKnux_LBZ1_Index:
		dc.w loc_44FE8-CutsceneKnux_LBZ1_Index
		dc.w loc_45022-CutsceneKnux_LBZ1_Index
		dc.w loc_449A2-CutsceneKnux_LBZ1_Index
		dc.w loc_4505E-CutsceneKnux_LBZ1_Index
		dc.w loc_449A2-CutsceneKnux_LBZ1_Index
		dc.w loc_44CC4-CutsceneKnux_LBZ1_Index
		dc.w loc_44CC4-CutsceneKnux_LBZ1_Index
		dc.w loc_450E8-CutsceneKnux_LBZ1_Index
; ---------------------------------------------------------------------------

loc_44FE8:
		move.w	(Player_1+x_pos).w,d0
		cmp.w	x_pos(a0),d0
		bhs.s	loc_4501C
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.b	#$16,mapping_frame(a0)
		move.w	#$A0,(Camera_min_Y_pos).w
		lea	Pal_CutsceneKnux(pc),a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_45738(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4501C:
		jmp	(Go_Delete_SpriteSlotted2).l
; ---------------------------------------------------------------------------

loc_45022:
		btst	#3,$38(a0)
		bne.s	loc_4502C
		rts
; ---------------------------------------------------------------------------

loc_4502C:
		move.b	#4,routine(a0)
		bsr.w	sub_456C6
		move.w	#60-1,$2E(a0)
		move.l	#loc_45046,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_45046:
		move.b	#6,routine(a0)
		move.l	#byte_4578F,$30(a0)
		move.l	#loc_45064,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4505E:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_45064:
		move.b	#8,routine(a0)
		move.w	#$F,$2E(a0)
		move.l	#loc_45096,$34(a0)
		moveq	#signextendB(sfx_MissileThrow),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_45740(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	(PLC_BossExplosion).l,a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

loc_45096:
		move.b	#$A,routine(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_450AE,$34(a0)
		bra.w	loc_449E4
; ---------------------------------------------------------------------------

loc_450AE:
		move.b	#$C,routine(a0)
		st	(Screen_shake_flag).w
		move.w	#$5F,$2E(a0)
		move.l	#loc_450D0,$34(a0)
		lea	ChildObjDat_45748(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_450D0:
		move.b	#$E,routine(a0)
		move.l	#byte_4576B,$30(a0)
		clr.b	anim_frame_timer(a0)
		clr.b	anim_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_450E8:
		tst.b	render_flags(a0)
		bpl.w	loc_450FA
		addq.w	#2,x_pos(a0)
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_450FA:
		clr.b	(_unkFAA9).w
		clr.b	(Player_1+object_control).w
		clr.b	(Player_2+object_control).w
		move.w	#$3B60,(Camera_stored_max_X_pos).w
		lea	(Child6_IncLevX).l,a2
		jsr	(CreateChild6_Simple).l
		move.w	#$148,(Camera_target_max_Y_pos).w
		jsr	(Remove_From_TrackingSlot).l
		lea	(Pal_LBZ1).l,a1
		jsr	(PalLoad_Line1).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_45136:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_4516E
		lea	word_45196(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.l	d0
		beq.s	locret_4516C
		tst.w	d0
		beq.s	loc_45162
		movea.w	parent3(a0),a2
		bset	#3,$38(a2)
		bsr.w	sub_45174

loc_45162:
		swap	d0
		tst.w	d0
		beq.s	locret_4516C
		bsr.w	sub_45174

locret_4516C:
		rts
; ---------------------------------------------------------------------------

loc_4516E:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_45174:
		st	(_unkFAA9).w
		movea.w	d0,a1
		cmpi.b	#6,routine(a1)
		bhs.s	locret_4516C
		move.b	#$81,object_control(a1)
		bclr	#0,render_flags(a1)
		bclr	#Status_Facing,status(a1)
		rts
; End of function sub_45174

; ---------------------------------------------------------------------------
word_45196:
		dc.w   -$40,   $80,  -$30,   $60
; ---------------------------------------------------------------------------

loc_4519E:
		lea	ObjDat3_456FA(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_451C2,(a0)
		move.w	#-$200,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		moveq	#signextendB(sfx_MissileThrow),d0
		jsr	(Play_SFX).l

loc_451C2:
		jsr	(MoveSprite_LightGravity).l
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------

loc_451CE:
		move.l	#loc_4520C,(a0)
		move.l	#Obj_NormalExpControl,$34(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		lea	word_451FC(pc,d0.w),a1
		move.w	(a1)+,x_pos(a0)
		move.w	(a1)+,y_pos(a0)
		move.b	#$A,subtype(a0)
		jmp	(loc_528BA).l
; ---------------------------------------------------------------------------
word_451FC:
		dc.w  $3BC0,  $1A0
		dc.w  $3B80,  $1A0
		dc.w  $3B40,  $1A0
		dc.w  $3B00,  $1A0
; ---------------------------------------------------------------------------

loc_4520C:
		subq.w	#4,y_pos(a0)
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

CutsceneKnux_LBZ2:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_LBZ2_Index(pc,d0.w),d1
		jsr	CutsceneKnux_LBZ2_Index(pc,d1.w)
		lea	DPLCPtr_CutsceneKnux(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Sprite_CheckDeleteTouchSlotted).l
; ---------------------------------------------------------------------------
CutsceneKnux_LBZ2_Index:
		dc.w loc_45242-CutsceneKnux_LBZ2_Index
		dc.w loc_45270-CutsceneKnux_LBZ2_Index
		dc.w loc_4528A-CutsceneKnux_LBZ2_Index
		dc.w loc_452A4-CutsceneKnux_LBZ2_Index
		dc.w loc_452C6-CutsceneKnux_LBZ2_Index
		dc.w loc_4530A-CutsceneKnux_LBZ2_Index
		dc.w loc_45322-CutsceneKnux_LBZ2_Index
; ---------------------------------------------------------------------------

loc_45242:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		bset	#0,render_flags(a0)
		move.b	#$20,mapping_frame(a0)
		bsr.w	sub_456C6
		lea	Pal_CutsceneKnux(pc),a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_4574E(pc),a2
		jmp	(CreateChild3_NormalRepeated).l
; ---------------------------------------------------------------------------

loc_45270:
		btst	#1,$38(a0)
		bne.s	loc_4527A
		rts
; ---------------------------------------------------------------------------

loc_4527A:
		move.b	#4,routine(a0)
		move.l	#loc_45294,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4528A:
		lea	byte_4579E(pc),a1
		jmp	(Animate_RawNoSSTMultiDelay).l
; ---------------------------------------------------------------------------

loc_45294:
		move.b	#6,routine(a0)
		bclr	#0,render_flags(a0)
		bra.w	loc_449E4
; ---------------------------------------------------------------------------

loc_452A4:
		tst.b	(Screen_shake_flag).w
		beq.s	loc_452C0
		move.b	#8,routine(a0)
		move.l	#byte_45766,$30(a0)
		clr.b	anim_frame_timer(a0)
		clr.b	anim_frame(a0)

loc_452C0:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_452C6:
		btst	#3,$38(a0)
		bne.s	loc_452DC
		move.w	(Events_bg+$14).w,d0
		add.w	d0,y_pos(a0)
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_452DC:
		move.b	#$A,routine(a0)
		bset	#0,render_flags(a0)
		move.b	#9,mapping_frame(a0)
		move.w	#$200,x_vel(a0)
		move.w	#-$100,y_vel(a0)
		jsr	(AllocateObject).l
		bne.s	locret_45308
		move.l	#Obj_Song_Fade_ToLevelMusic,(a1)

locret_45308:
		rts
; ---------------------------------------------------------------------------

loc_4530A:
		move.w	y_pos(a0),d0
		cmp.w	(Water_level).w,d0
		blo.s	loc_45322
		moveq	#signextendB(sfx_Splash),d0
		jsr	(Play_SFX).l
		move.b	#$C,routine(a0)

loc_45322:
		move.w	(Events_bg+$14).w,d0
		add.w	d0,y_pos(a0)
		jmp	(MoveSprite_LightGravity).l
; ---------------------------------------------------------------------------

loc_45330:
		lea	ObjDat3_45706(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_4536C,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		move.l	word_4535C(pc,d0.w),$3E(a0)
		lsl.w	#3,d0
		add.w	d0,y_pos(a0)
		move.w	x_pos(a0),$3A(a0)
		rts
; ---------------------------------------------------------------------------
word_4535C:
		dc.w   $100,   $10
		dc.w    $C0,    $C
		dc.w    $80,     8
		dc.w    $40,     4
; ---------------------------------------------------------------------------

loc_4536C:
		tst.b	(Screen_shake_flag).w
		beq.s	loc_45384
		move.l	#loc_4538A,(a0)
		move.w	$3E(a0),x_vel(a0)
		move.b	#6,$39(a0)

loc_45384:
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------

loc_4538A:
		move.w	(Events_bg+$14).w,d0
		add.w	d0,y_pos(a0)
		move.w	x_pos(a0),d0
		move.w	$40(a0),d1
		cmp.w	$3A(a0),d0
		scs	d2
		bcs.s	loc_453A4
		neg.w	d1

loc_453A4:
		add.w	d1,x_vel(a0)
		cmp.b	$3C(a0),d2
		beq.s	loc_453E4
		move.b	d2,$3C(a0)
		cmpi.b	#3,$39(a0)
		bne.s	loc_453CE
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		move.l	word_45400(pc,d0.w),$3E(a0)
		move.w	$3E(a0),x_vel(a0)

loc_453CE:
		subq.b	#1,$39(a0)
		bne.s	loc_453E4
		move.l	#loc_45410,(a0)
		movea.w	parent3(a0),a1
		bset	#3,$38(a1)

loc_453E4:
		jsr	(MoveSprite2).l
		tst.b	subtype(a0)
		bne.s	loc_453FA
		movea.w	parent3(a0),a1
		move.w	x_pos(a0),x_pos(a1)

loc_453FA:
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------
word_45400:
		dc.w   $200,   $20
		dc.w   $180,   $18
		dc.w   $100,   $10
		dc.w    $80,     8
; ---------------------------------------------------------------------------

loc_45410:
		move.w	(Events_bg+$14).w,d0
		add.w	d0,y_pos(a0)
		jsr	(MoveSprite_LightGravity).l
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------

Obj_LBZKnuxPillar:
		lea	ObjDat_LBZKnuxPillar(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#1,render_flags(a0)
		beq.s	loc_4543C
		bset	#7,art_tile(a0)

loc_4543C:
		bclr	#0,render_flags(a0)
		beq.s	loc_4544A
		move.w	#0,priority(a0)

loc_4544A:
		move.l	#loc_45450,(a0)

loc_45450:
		move.w	(Events_bg+$14).w,d0
		add.w	d0,y_pos(a0)
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
Map_LBZKnuxPillar:
		include "Levels/LBZ/Misc Object Data/Map - Knuckles Pillar.asm"
; ---------------------------------------------------------------------------

Obj_CutsceneButton:
		lea	ObjDat_CutsceneButton(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_454C2,(a0)
		addq.w	#4,y_pos(a0)
		lea	PLC_CutsceneButton(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------
PLC_CutsceneButton: plrlistheader
		plreq $456, ArtNem_GrayButton
PLC_CutsceneButton_End
; ---------------------------------------------------------------------------

loc_454C2:
		move.w	(_unkFAA4).w,d0
		beq.s	loc_45518
		movea.w	d0,a1
		lea	word_4551E(pc),a2
		move.w	x_pos(a0),d0
		move.w	x_pos(a1),d1
		add.w	(a2)+,d0
		cmp.w	d0,d1
		bcs.s	loc_45518
		add.w	(a2)+,d0
		cmp.w	d0,d1
		bcc.s	loc_45518
		move.w	y_pos(a0),d0
		move.w	y_pos(a1),d1
		add.w	(a2)+,d0
		cmp.w	d0,d1
		bcs.s	loc_45518
		add.w	(a2)+,d0
		cmp.w	d0,d1
		bcc.s	loc_45518
		move.l	#loc_4552E,(a0)
		move.b	#1,mapping_frame(a0)
		st	(_unkFAA9).w
		clr.w	respawn_addr(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	off_45526(pc,d0.w),d0
		jsr	off_45526(pc,d0.w)

loc_45518:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
word_4551E:
		dc.w   -$18,   $30,  -$18,   $30
off_45526:
		dc.w loc_45534-off_45526
		dc.w loc_45550-off_45526
		dc.w loc_45556-off_45526
		dc.w loc_4558A-off_45526
; ---------------------------------------------------------------------------

loc_4552E:
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------

loc_45534:
		clr.b	(Ctrl_1_locked).w
		move.w	#$1000,d0
		move.w	d0,(Camera_stored_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		lea	(Child6_IncLevY).l,a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_45550:
		st	(Level_trigger_array+8).w
		rts
; ---------------------------------------------------------------------------

loc_45556:
		move.w	#$14,(Screen_shake_flag).w
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$100,d0
		move.w	d0,(Mean_water_level).w
		move.w	#$350,(Target_water_level).w
		st	(_unkFAA3).w
		moveq	#signextendB(sfx_Geyser),d0
		jsr	(Play_SFX).l
		jsr	(AllocateObject).l
		bne.s	locret_45588
		move.l	#loc_44E04,(a1)

locret_45588:
		rts
; ---------------------------------------------------------------------------

loc_4558A:
		move.w	#$14,(Screen_shake_flag).w
		movea.w	(Level_layout_main+$40).w,a1
		lea	$8E(a1),a1
		move.w	(Level_layout_header).w,d0
		move.b	#$14,(a1)
		adda.w	d0,a1
		move.b	#$F,(a1)
		adda.w	d0,a1
		move.b	#$F,(a1)
		adda.w	d0,a1
		move.b	#$88,(a1)
		jsr	(AllocateObject).l
		bne.s	loc_455D2
		move.l	#Obj_CNZVacuumTube,(a1)
		move.w	#$4740,x_pos(a1)
		move.w	#$828,y_pos(a1)
		move.b	#$4C,subtype(a1)

loc_455D2:
		jsr	(AllocateObject).l
		bne.s	locret_455F2
		move.l	#Obj_CNZVacuumTube,(a1)
		move.w	#$4740,x_pos(a1)
		move.w	#$A28,y_pos(a1)
		move.b	#$20,subtype(a1)

locret_455F2:
		rts
; ---------------------------------------------------------------------------

Obj_CNZWaterLevelCorkFloor:
		jsr	(Obj_WaitOffscreen).l
		move.l	#loc_45624,(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_45624
		move.l	#Obj_CorkFloor,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	#1,subtype(a1)
		move.w	a1,$44(a0)

loc_45624:
		movea.w	$44(a0),a1
		cmpi.l	#loc_29838,(a1)
		beq.s	loc_45636
		jmp	(Delete_Sprite_If_Not_In_Range).l
; ---------------------------------------------------------------------------

loc_45636:
		tst.b	(_unkFAA2).w
		bne.s	loc_45646
		st	(_unkFAA2).w
		move.w	#$958,(Target_water_level).w

loc_45646:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_CNZWaterLevelButton:
		lea	ObjDat_CutsceneButton(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_4566A,(a0)
		addq.w	#4,y_pos(a0)
		lea	PLC_CutsceneButton(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

loc_4566A:
		move.w	#$1B,d1
		move.w	#4,d2
		move.w	#5,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		move.b	#0,mapping_frame(a0)
		move.b	status(a0),d0
		andi.b	#standing_mask,d0
		beq.s	loc_456C0
		move.b	#1,mapping_frame(a0)
		tst.b	(_unkFAA3).w
		beq.s	loc_456C0
		clr.b	(_unkFAA3).w
		move.w	#$A58,(Target_water_level).w
		moveq	#signextendB(sfx_Geyser),d0
		jsr	(Play_SFX).l
		jsr	(AllocateObject).l
		bne.s	loc_456C0
		move.l	#loc_44E04,(a1)
		st	subtype(a1)

loc_456C0:
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_456C6:
		jsr	(AllocateObject).l
		bne.s	locret_456DA
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_Knuckles,subtype(a1)

locret_456DA:
		rts
; End of function sub_456C6

; ---------------------------------------------------------------------------
ObjSlot_CutsceneKnux:
		dc.w 1-1
		dc.w make_art_tile(ArtTile_CutsceneKnux,1,1)
		dc.w    $2E,     0
		dc.l Map_CutsceneKnux
		dc.w   $180
		dc.b  $1C, $18, $16,   0
ObjDat_CutsceneButton:
		dc.l Map_Button
		dc.w make_art_tile($456,0,1)
		dc.w   $100
		dc.b  $10,   8,   0,   0
ObjDat3_456FA:
		dc.l Map_LBZKnuxBomb
		dc.w make_art_tile($4D6,1,1)
		dc.w    $80
		dc.b    8,   8,   0,   0
ObjDat3_45706:
		dc.l Map_LBZKnuxPillar
		dc.w make_art_tile(ArtTile_Explosion,2,0)
		dc.w   $280
		dc.b  $10, $10,   0,   0
ObjDat_LBZKnuxPillar:
		dc.l Map_LBZKnuxPillar
		dc.w make_art_tile(ArtTile_Explosion,2,0)
		dc.w   $280
		dc.b  $10, $80,   1,   0
ObjDat3_4571E:
		dc.l Map_AIZCorkFloor
		dc.w make_art_tile($001,2,0)
		dc.w   $180
		dc.b  $10, $18,   0,   0
ChildObjDat_4572A:
		dc.w 1-1
		dc.l loc_44A78
ChildObjDat_45730:
		dc.w 1-1
		dc.l loc_44DD8
		dc.b -$20,-$6C
ChildObjDat_45738:
		dc.w 1-1
		dc.l loc_45136
		dc.b -$40,   0
ChildObjDat_45740:
		dc.w 1-1
		dc.l loc_4519E
		dc.b   -8,-$10
ChildObjDat_45748:
		dc.w 4-1
		dc.l loc_451CE
ChildObjDat_4574E:
		dc.w 4-1
		dc.l loc_45330
		dc.b    2, $24
ChildObjDat_45756:
		dc.w 1-1
		dc.l loc_448EE
		dc.b    0, $18
DPLCPtr_CutsceneKnux:
		dc.l ArtUnc_CutsceneKnux
		dc.l DPLC_CutsceneKnux
byte_45766:
		dc.b    7,   1,   2,   3, $FC
byte_4576B:
		dc.b    5,  $A,  $B,  $C,  $D,  $E,  $F, $10, $11, $FC
byte_45775:
		dc.b    1, $12, $13, $14, $15, $FC
byte_4577B:
		dc.b    1,   8,   4,   8,   5,   8,   6,   8,   7, $FC
byte_45785:
		dc.b    7, $1C, $1C, $1D, $F8,   6
byte_4578B:
		dc.b    7, $1E, $1F, $FC
byte_4578F:
		dc.b  $16,   7
		dc.b  $16,   7
		dc.b  $17,   7
		dc.b  $18,   7
		dc.b  $19, $13
		dc.b  $1A,   7
		dc.b  $1B,   0
		dc.b  $F4
byte_4579E:
		dc.b  $20,   5
		dc.b  $21,   5
		dc.b  $22, $14
		dc.b  $23,   3
		dc.b  $24,  $F
		dc.b  $21,   5
		dc.b  $20,   5
		dc.b  $F4
		even
Pal_CutsceneKnux:
		binclude "General/Sprites/Knuckles/Cutscene/Pal.bin"
		even
Pal_CNZFlash:
		binclude "Levels/CNZ/Palettes/Flash.bin"
		even
; ---------------------------------------------------------------------------

Obj_AIZPlaneIntro:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	AIZPlaneIntro_Index(pc,d0.w),d1
		jsr	AIZPlaneIntro_Index(pc,d1.w)
		jsr	(Sonic_Load_PLC).l
		bsr.w	sub_45DE4
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
AIZPlaneIntro_Index:
		dc.w loc_45888-AIZPlaneIntro_Index
		dc.w loc_458F0-AIZPlaneIntro_Index
		dc.w loc_45912-AIZPlaneIntro_Index
		dc.w loc_4593C-AIZPlaneIntro_Index
		dc.w loc_45970-AIZPlaneIntro_Index
		dc.w loc_4599C-AIZPlaneIntro_Index
		dc.w loc_459F0-AIZPlaneIntro_Index
		dc.w loc_45A00-AIZPlaneIntro_Index
		dc.w loc_45A2A-AIZPlaneIntro_Index
		dc.w loc_45A50-AIZPlaneIntro_Index
		dc.w loc_45A88-AIZPlaneIntro_Index
		dc.w loc_45AA2-AIZPlaneIntro_Index
		dc.w loc_45AC4-AIZPlaneIntro_Index
		dc.w loc_45AE0-AIZPlaneIntro_Index
; ---------------------------------------------------------------------------

loc_45888:
		addq.b	#2,routine(a0)
		move.l	#Map_Sonic,mappings(a0)
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#$BA,mapping_frame(a0)
		move.b	#$40,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		move.w	#$60,x_pos(a0)
		move.w	#$30,y_pos(a0)
		move.w	#$40,$2E(a0)
		move.l	#loc_458F6,$34(a0)
		move.w	#8,$40(a0)
		move.w	#$E918,(Events_fg_1).w
		move.b	#-1,(Player_prev_frame).w
		lea	(Player_1).w,a1
		move.b	#0,mapping_frame(a1)
		move.b	#$53,object_control(a1)

locret_458EE:
		rts
; ---------------------------------------------------------------------------

loc_458F0:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_458F6:
		move.b	#4,routine(a0)
		move.w	#$300,x_vel(a0)
		move.w	#$600,y_vel(a0)
		lea	ChildObjDat_45E36(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_45912:
		subi.w	#$18,y_vel(a0)
		beq.s	loc_45920
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_45920:
		move.b	#6,routine(a0)
		clr.w	x_vel(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_4594E,$34(a0)
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_4593C:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4594E:
		move.b	#8,routine(a0)
		move.w	#$400,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		move.l	#byte_45E60,$30(a0)
		bset	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_45970:
		subi.w	#$40,x_vel(a0)
		jsr	(MoveSprite).l
		cmpi.w	#$130,y_pos(a0)
		bhs.s	loc_4598A
		jmp	(loc_45DFC).l
; ---------------------------------------------------------------------------

loc_4598A:
		move.b	#$A,routine(a0)
		move.w	#$130,y_pos(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_4599C:
		subi.w	#$40,x_vel(a0)
		jsr	(MoveSprite2).l
		cmpi.w	#$40,x_pos(a0)
		blo.s	loc_459B2
		rts
; ---------------------------------------------------------------------------

loc_459B2:
		move.b	#$C,routine(a0)
		move.w	#$40,x_pos(a0)
		move.w	#5,$2E(a0)
		move.l	#loc_459D6,$34(a0)
		move.w	#$3F,$3A(a0)
		bra.w	loc_45D72
; ---------------------------------------------------------------------------

loc_459D6:
		move.w	#5,$2E(a0)
		cmpi.w	#$80,x_pos(a0)
		blo.w	locret_458EE
		lea	ChildObjDat_45E4C(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_459F0:
		subq.w	#1,$3A(a0)
		bpl.w	locret_458EE
		move.b	#$E,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_45A00:
		bsr.w	sub_45D94
		jsr	(Obj_Wait).l
		move.w	x_pos(a0),d0
		addq.w	#4,d0
		move.w	d0,x_pos(a0)
		cmpi.w	#$200,d0
		bhs.s	loc_45A1C
		rts
; ---------------------------------------------------------------------------

loc_45A1C:
		move.b	#$10,routine(a0)
		move.w	#$1F,$3A(a0)
		rts
; ---------------------------------------------------------------------------

loc_45A2A:
		bsr.w	sub_45D94
		jsr	(Obj_Wait).l
		subq.w	#1,$3A(a0)
		bpl.w	locret_458EE
		move.b	#$12,routine(a0)
		bset	#2,$38(a0)
		move.w	#$C,$40(a0)
		rts
; ---------------------------------------------------------------------------

loc_45A50:
		bsr.w	sub_45D94
		jsr	(Obj_Wait).l
		move.w	x_pos(a0),d0
		subi.w	#4,d0
		move.w	d0,x_pos(a0)
		cmpi.w	#$120,d0
		bls.s	loc_45A6E
		rts
; ---------------------------------------------------------------------------

loc_45A6E:
		move.b	#$14,routine(a0)
		bset	#2,$38(a0)
		move.w	#$1F,$3A(a0)
		move.w	#$10,$40(a0)
		rts
; ---------------------------------------------------------------------------

loc_45A88:
		bsr.w	sub_45D94
		jsr	(Obj_Wait).l
		subq.w	#1,$3A(a0)
		bpl.w	locret_458EE
		move.b	#$16,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_45AA2:
		bsr.w	sub_45D94
		cmpi.w	#$918,(Player_1+x_pos).w
		bhs.s	loc_45AB4
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_45AB4:
		move.b	#$18,routine(a0)
		lea	ChildObjDat_45E54(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_45AC4:
		bsr.w	sub_45D94
		cmpi.w	#$1240,(Player_1+x_pos).w
		bhs.s	loc_45AD2
		rts
; ---------------------------------------------------------------------------

loc_45AD2:
		move.b	#$1A,routine(a0)
		subi.w	#$20,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_45AE0:
		bsr.w	sub_45D94
		cmpi.w	#$13D0,(Player_1+x_pos).w
		bhs.s	loc_45AEE
		rts
; ---------------------------------------------------------------------------

loc_45AEE:
		st	(Palette_cycle_counters+$00).w
		lea	(Player_1).w,a1
		move.b	#4,routine(a1)
		bset	#Status_InAir,status(a1)
		move.w	#-$400,y_vel(a1)
		move.w	#-$200,x_vel(a1)
		move.w	#0,ground_vel(a1)
		move.b	#$1A,anim(a1)
		clr.b	object_control(a1)
		clr.w	(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		clr.b	(Super_Sonic_Knux_flag).w
		move.b	#2,(Super_palette_status).w
		move.w	#$1E,(Palette_frame).w
		lea	Pal_AIZIntroEmeralds(pc),a1
		lea	(Normal_palette_line_4).w,a2
		moveq	#bytesToLcnt($20),d0

loc_45B40:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_45B40
		lea	ChildObjDat_45E5A(pc),a2
		jsr	(CreateChild6_Simple).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_45B56:
		move.l	#loc_45BAA,(a0)
		move.l	#Map_AIZIntroPlane,mappings(a0)
		move.w	#make_art_tile($529,0,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#$40,width_pixels(a0)
		move.b	#$20,width_pixels(a0)
		jsr	Swing_Setup1(pc)
		lea	(ArtKosM_AIZIntroPlane).l,a1
		move.w	#tiles_to_bytes($529),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_AIZIntroEmeralds).l,a1
		move.w	#tiles_to_bytes($5B1),d2
		jsr	(Queue_Kos_Module).l
		lea	ChildObjDat_45E3E(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_45BAA:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		beq.s	loc_45BC8
		move.l	#loc_45BDC,(a0)

loc_45BC8:
		btst	#3,$38(a1)
		bne.s	loc_45BD6
		jsr	(Refresh_ChildPosition).l

loc_45BD6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_45BDC:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		subq.w	#4,x_pos(a0)
		cmpi.w	#$20,x_pos(a0)
		blo.s	loc_45BFA
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_45BFA:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_45C00:
		move.l	#Map_AIZIntroPlane,mappings(a0)
		move.w	#make_art_tile($529,0,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#4,width_pixels(a0)
		move.b	#$C,width_pixels(a0)
		move.l	#loc_45C26,(a0)

loc_45C26:
		lea	(byte_45E6B).l,a1
		jsr	(Animate_RawNoSST).l
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_45C3E:
		move.l	#Map_AIZIntroPlane,mappings(a0)
		move.w	#make_art_tile($529,0,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#4,width_pixels(a0)
		move.b	#$C,width_pixels(a0)
		move.l	#loc_45C64,(a0)

loc_45C64:
		lea	(byte_45E73).l,a1
		jsr	(Animate_RawNoSST).l
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_45C7C:
		move.l	#loc_45CB6,(a0)
		move.l	#Map_AIZIntroWaves,mappings(a0)
		move.w	#make_art_tile($3D1,0,0),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$10,width_pixels(a0)
		bset	#0,render_flags(a0)
		movea.w	parent3(a0),a1
		move.l	#byte_45E77,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)

loc_45CB6:
		cmpi.w	#$60,x_pos(a0)
		blo.s	loc_45CD6
		movea.w	parent3(a0),a1
		move.w	$40(a1),d0
		sub.w	d0,x_pos(a0)
		jsr	(Animate_RawMultiDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_45CD6:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_45CDC:
		lea	ObjDat3_45E2A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	subtype(a0),d0
		lsr.b	#1,d0
		move.b	d0,mapping_frame(a0)
		move.l	#loc_45D14,(a0)
		move.b	#4,y_radius(a0)
		lea	(Player_1).w,a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		moveq	#$40,d0
		jsr	(Set_IndexedVelocity).l

loc_45D14:
		jsr	(MoveSprite).l
		tst.l	d0
		bmi.s	loc_45D32
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	loc_45D32
		add.w	d1,y_pos(a0)
		move.l	#loc_45D38,(a0)

loc_45D32:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_45D38:
		movea.w	(_unkFAA4).w,a1
		move.w	x_pos(a0),d0
		move.w	x_pos(a1),d1
		subq.w	#8,d0
		cmp.w	d0,d1
		blo.s	loc_45D52
		addi.w	#2*8,d0
		cmp.w	d0,d1
		blo.s	loc_45D58

loc_45D52:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_45D58:
		move.w	x_vel(a1),d0
		btst	#1,subtype(a0)
		beq.s	loc_45D66
		neg.w	d0

loc_45D66:
		tst.w	d0
		bmi.w	locret_458EE
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_45D72:
		move.l	#Map_SuperSonic,mappings(a0)
		move.b	#$21,mapping_frame(a0)
		move.b	#0,(Palette_timer).w
		move.w	#$24,(Palette_frame).w
		move.w	#$7FFF,(Super_frame_count).w
		rts

; =============== S U B R O U T I N E =======================================


sub_45D94:
		move.b	#1,(Super_Sonic_Knux_flag).w
		move.b	#$21,mapping_frame(a0)
		btst	#1,(V_int_run_count+3).w
		beq.s	loc_45DAE
		move.b	#$22,mapping_frame(a0)

loc_45DAE:
		subq.b	#1,(Palette_timer).w
		bpl.s	locret_45DE2
		move.b	#6,(Palette_timer).w
		lea	(PalCycle_SuperSonic).l,a1
		move.w	(Palette_frame).w,d0
		addq.w	#6,(Palette_frame).w
		cmpi.w	#$36,(Palette_frame).w
		blo.s	loc_45DD6
		move.w	#$24,(Palette_frame).w

loc_45DD6:
		lea	(Normal_palette+$4).w,a2
		move.l	(a1,d0.w),(a2)+
		move.w	4(a1,d0.w),(a2)

locret_45DE2:
		rts
; End of function sub_45D94


; =============== S U B R O U T I N E =======================================


sub_45DE4:
		move.w	$40(a0),d1
		move.w	(Events_fg_1).w,d0
		bpl.s	loc_45DF6
		add.w	d1,d0
		move.w	d0,(Events_fg_1).w
		rts
; ---------------------------------------------------------------------------

loc_45DF6:
		add.w	d1,(Player_1+x_pos).w
		rts
; End of function sub_45DE4

; ---------------------------------------------------------------------------

loc_45DFC:
		movea.l	$30(a0),a1
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_45E28
		move.b	(a1),anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#1,d0
		cmp.b	1(a1),d0
		blo.s	loc_45E1A
		moveq	#0,d0

loc_45E1A:
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	2(a1,d0.w),d1
		move.b	d1,mapping_frame(a0)

locret_45E28:
		rts
; ---------------------------------------------------------------------------
ObjDat3_45E2A:
		dc.l Map_AIZIntroEmeralds
		dc.w make_art_tile($5B1,3,0)
		dc.w   $280
		dc.b    4,   4,   1,   0
ChildObjDat_45E36:
		dc.w 1-1
		dc.l loc_45B56
		dc.b -$22, $2C
ChildObjDat_45E3E:
		dc.w 2-1
		dc.l loc_45C00
		dc.b  $38,   4
		dc.l loc_45C3E
		dc.b  $18, $18
ChildObjDat_45E4C:
		dc.w 1-1
		dc.l loc_45C7C
		dc.b    0, $18
ChildObjDat_45E54:
		dc.w 1-1
		dc.l Obj_CutsceneKnuckles
ChildObjDat_45E5A:
		dc.w 7-1
		dc.l loc_45CDC
byte_45E60:
		dc.b    3,   8
		dc.b  $97, $96
		dc.b  $98, $96
		dc.b  $99, $96
		dc.b  $9A, $96
		dc.b  $FC
byte_45E6B:
		dc.b    0,   1,   2,   3,   4,   3,   2, $FC
byte_45E73:
		dc.b    0,   5,   6, $FC
byte_45E77:
		dc.b    0,   1
		dc.b    0,   0
		dc.b    1,   1
		dc.b    2,   2
		dc.b    3,   2
		dc.b    4,   1
		dc.b    5,   1
		dc.b  $F4
		even
Pal_AIZIntroEmeralds:
		binclude "Levels/AIZ/Palettes/Intro Emeralds.bin"
		even
