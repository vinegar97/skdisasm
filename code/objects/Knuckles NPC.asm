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
		dc.l CutsceneKnux_MHZ1
		dc.l CutsceneKnux_MHZ2
		dc.l CutsceneKnux_LRZ2
		dc.l CutsceneKnux_HPZ
		dc.l CutsceneKnux_SSZ
		dc.l CutsceneKnux_SKIntro
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
		dc.w loc_61DBE-CutsceneKnux_AIZ1_Index
		dc.w loc_61DF4-CutsceneKnux_AIZ1_Index
		dc.w loc_61E24-CutsceneKnux_AIZ1_Index
		dc.w loc_61E64-CutsceneKnux_AIZ1_Index
		dc.w loc_61E96-CutsceneKnux_AIZ1_Index
		dc.w loc_61EE0-CutsceneKnux_AIZ1_Index
		dc.w loc_61F10-CutsceneKnux_AIZ1_Index
; ---------------------------------------------------------------------------

loc_61DBE:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		bclr	#7,art_tile(a0)
		move.b	#$13,y_radius(a0)
		move.b	#8,mapping_frame(a0)
		move.w	#$1400,x_pos(a0)
		move.w	#$440,y_pos(a0)
		bsr.w	sub_65DD6
		lea	ChildObjDat_6659A(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_61DF4:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_61E02
		rts
; ---------------------------------------------------------------------------

loc_61E02:
		move.b	#4,routine(a0)
		bset	#7,status(a0)
		move.w	#-$600,y_vel(a0)
		move.w	#$80,x_vel(a0)
		lea	Pal_CutsceneKnux(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_61E24:
		lea	byte_666AF(pc),a1
		jsr	(Animate_RawNoSST).l
		jsr	(MoveSprite).l
		tst.l	d0
		bmi.s	locret_61E42
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_61E44

locret_61E42:
		rts
; ---------------------------------------------------------------------------

loc_61E44:
		move.b	#6,routine(a0)
		add.w	d1,y_pos(a0)
		move.b	#$16,mapping_frame(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_61E6A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_61E64:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_61E6A:
		move.b	#8,routine(a0)
		bchg	#0,render_flags(a0)
		move.l	#byte_666A9,$30(a0)
		move.w	#-$600,x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#$29,$2E(a0)
		move.l	#loc_61EA8,$34(a0)

loc_61E96:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_61EA8:
		neg.w	x_vel(a0)
		bchg	#0,render_flags(a0)
		move.w	#$29,$2E(a0)
		move.l	#loc_61EC2,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_61EC2:
		move.b	#$A,routine(a0)
		move.b	#$16,mapping_frame(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_61EEC,$34(a0)
		bra.w	loc_62056
; ---------------------------------------------------------------------------

loc_61EE0:
		jsr	(Animate_Raw).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_61EEC:
		move.b	#$C,routine(a0)
		move.l	#byte_666A9,$30(a0)
		move.w	#$600,x_vel(a0)
		jsr	(AllocateObject).l
		bne.s	locret_61F0E
		move.l	#Obj_Song_Fade_ToLevelMusic,(a1)

locret_61F0E:
		rts
; ---------------------------------------------------------------------------

loc_61F10:
		tst.b	render_flags(a0)
		bpl.s	loc_61F22
		jsr	(Animate_Raw).l
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_61F22:
		clr.b	(Palette_cycle_counters+$00).w
		clr.b	(Ctrl_1_locked).w
		jsr	(AfterBoss_Cleanup).l
		jsr	(Remove_From_TrackingSlot).l
		jsr	(AllocateObject).l
		bne.s	loc_61F44
		move.l	#Obj_TitleCard,(a1)

loc_61F44:
		move.b	#$91,(Level_started_flag).w
		move.b	#$80,(Update_HUD_timer).w
		clr.l	(Timer).w
		move.b	#1,(Update_HUD_life_count).w
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_61F60:
		lea	ObjDat3_66432(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_61F70,(a0)

loc_61F70:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_61F82
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_61F82:
		lea	(word_2A8B0).l,a4
		addq.b	#1,mapping_frame(a0)
		move.l	#loc_2A5F8,(a0)
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
		dc.w loc_61FC2-CutsceneKnux_AIZ2_Index
		dc.w loc_62014-CutsceneKnux_AIZ2_Index
		dc.w loc_62022-CutsceneKnux_AIZ2_Index
		dc.w loc_6206E-CutsceneKnux_AIZ2_Index
		dc.w loc_620AA-CutsceneKnux_AIZ2_Index
		dc.w loc_620E4-CutsceneKnux_AIZ2_Index
; ---------------------------------------------------------------------------

loc_61FC2:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.w	#$4B8E,x_pos(a0)
		move.w	#$17D,y_pos(a0)
		bset	#0,render_flags(a0)
		bsr.w	sub_65DD6
		move.w	#(2*60)-1,$2E(a0)
		move.l	#loc_6201A,$34(a0)
		lea	Pal_CutsceneKnux(pc),a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_6655A(pc),a2
		jsr	(CreateChild6_Simple).l
		bne.s	locret_62012
		move.w	#$4B08,x_pos(a1)
		move.w	#$178,y_pos(a1)

locret_62012:
		rts
; ---------------------------------------------------------------------------

loc_62014:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6201A:
		move.b	#4,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_62022:
		move.w	x_pos(a0),d0
		subq.w	#2,d0
		cmpi.w	#$4B3C,d0
		blo.s	loc_6203C
		move.w	d0,x_pos(a0)
		lea	byte_6669F(pc),a1
		jmp	(Animate_RawNoSST).l
; ---------------------------------------------------------------------------

loc_6203C:
		move.b	#6,routine(a0)
		bclr	#0,render_flags(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_6207A,$34(a0)

loc_62056:
		move.l	#byte_666B9,$30(a0)
		clr.b	anim_frame_timer(a0)
		clr.b	anim_frame(a0)
		move.b	#$1C,mapping_frame(a0)

locret_6206C:
		rts
; ---------------------------------------------------------------------------

loc_6206E:
		jsr	(Animate_Raw).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6207A:
		move.b	#8,routine(a0)

loc_62080:
		move.w	#-$100,x_vel(a0)
		move.w	#-$400,y_vel(a0)

loc_6208C:
		move.l	#byte_666AF,$30(a0)
		clr.b	anim_frame_timer(a0)
		clr.b	anim_frame(a0)
		move.b	#8,mapping_frame(a0)
		move.b	#$13,y_radius(a0)
		rts
; ---------------------------------------------------------------------------

loc_620AA:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	locret_620D6
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	locret_620D6
		bset	#2,$38(a0)
		bne.s	loc_620D8
		neg.w	x_vel(a0)
		neg.w	y_vel(a0)

locret_620D6:
		rts
; ---------------------------------------------------------------------------

loc_620D8:
		addq.b	#2,routine(a0)
		add.w	d1,y_pos(a0)
		bra.w	loc_62056
; ---------------------------------------------------------------------------

loc_620E4:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_620EA:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.w	CutsceneKnux_Delete
		move.b	#8,width_pixels(a0)
		moveq	#$13,d1
		move.w	#$20,d2
		move.w	#$40,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectFull2).l
; ---------------------------------------------------------------------------

CutsceneKnux_HCZ2:
		cmpi.b	#2,(Player_1+character_id).w
		beq.s	CutsceneKnux_Delete
		lea	word_62150(pc),a1
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
		dc.w loc_6215E-CutsceneKnux_HCZ2_Index
		dc.w loc_62194-CutsceneKnux_HCZ2_Index
		dc.w loc_62014-CutsceneKnux_HCZ2_Index
		dc.w loc_62200-CutsceneKnux_HCZ2_Index
		dc.w loc_62014-CutsceneKnux_HCZ2_Index
		dc.w loc_620AA-CutsceneKnux_HCZ2_Index
		dc.w loc_62242-CutsceneKnux_HCZ2_Index
word_62150:
		dc.w   $540,  $600, $3900, $3940
; ---------------------------------------------------------------------------

CutsceneKnux_Delete:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_6215E:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.w	(Camera_min_Y_pos).w,(Camera_stored_min_Y_pos).w
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w
		move.w	#$3940,(Camera_max_X_pos).w
		lea	ChildObjDat_665A2(pc),a2
		jsr	(CreateChild1_Normal).l
		bne.s	loc_6218C
		move.b	#2,subtype(a1)

loc_6218C:
		addi.w	#$9E,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_62194:
		lea	(Player_1).w,a1
		cmpi.w	#$3990,x_pos(a1)
		blo.s	loc_621AE
		tst.b	object_control(a1)
		bne.s	loc_621AE
		btst	#Status_OnObj,status(a1)
		bne.s	loc_621BC

loc_621AE:
		move.w	(Camera_Y_pos).w,(Camera_min_Y_pos).w
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_621BC:
		move.b	#4,routine(a0)
		bsr.w	sub_65DD6
		move.w	#(3*60)-1,$2E(a0)
		move.l	#loc_621D6,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_621D6:
		move.b	#6,routine(a0)
		bset	#0,render_flags(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_62216,$34(a0)
		move.w	#$5C0,(Camera_min_Y_pos).w
		lea	Pal_CutsceneKnux(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_62200:
		subq.w	#4,x_pos(a0)
		lea	(byte_6669F).l,a1
		jsr	(Animate_RawNoSST).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_62216:
		move.b	#8,routine(a0)
		move.b	#$20,mapping_frame(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_62232,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_62232:
		move.b	#$A,routine(a0)
		bchg	#0,render_flags(a0)
		bra.w	loc_62080
; ---------------------------------------------------------------------------

loc_62242:
		jsr	(Animate_Raw).l
		tst.b	render_flags(a0)
		bmi.w	locret_6206C
		lea	(Pal_HCZ2).l,a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_62280(pc),a2
		jsr	(CreateChild1_Normal).l
		jsr	(AllocateObject).l
		bne.s	loc_62274
		move.l	#Obj_Song_Fade_ToLevelMusic,(a1)

loc_62274:
		jsr	(Remove_From_TrackingSlot).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------
ChildObjDat_62280:
		dc.w 2-1
		dc.l Obj_DecLevStartYGradual
		dc.b    0,   0
		dc.l Obj_IncLevEndXGradual
		dc.b    0,   0
word_6228E:
		dc.w   $176,  $300, $1C00, $1E00
word_62296:
		dc.w   $280,  $280, $1D00, $1D00
; ---------------------------------------------------------------------------

CutsceneKnux_CNZ2A:
		cmpi.b	#2,(Player_1+character_id).w
		beq.w	CutsceneKnux_Delete
		lea	word_6228E(pc),a1
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
		dc.w loc_622E4-CutsceneKnux_CNZ2A_Index
		dc.w loc_62332-CutsceneKnux_CNZ2A_Index
		dc.w loc_62354-CutsceneKnux_CNZ2A_Index
		dc.w loc_6237C-CutsceneKnux_CNZ2A_Index
		dc.w loc_62354-CutsceneKnux_CNZ2A_Index
		dc.w loc_623FE-CutsceneKnux_CNZ2A_Index
word_622DC:	; used in S3, unused in S&K
		dc.w   $176,  $300, $1B00, $1D00
; ---------------------------------------------------------------------------

loc_622E4:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.l	#byte_666BF,$30(a0)
		move.l	#loc_6233E,$34(a0)
		lea	word_62296(pc),a1
		move.b	#mus_Knuckles,$26(a0)
		jsr	(loc_85D70).l
		lea	(Normal_palette_line_2).w,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_62318:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_62318
		lea	Pal_CutsceneKnux(pc),a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_66560(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_62332:
		jsr	(Animate_Raw).l
		jmp	(loc_85CA4).l
; ---------------------------------------------------------------------------

loc_6233E:
		move.b	#4,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_62360,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_62354:
		jsr	(Animate_Raw).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_62360:
		move.b	#6,routine(a0)
		bset	#0,render_flags(a0)
		move.w	#-$600,y_vel(a0)
		move.w	#$140,x_vel(a0)
		bra.w	loc_6208C
; ---------------------------------------------------------------------------

loc_6237C:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	locret_623B6
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	locret_623B6
		moveq	#0,d0
		move.b	$39(a0),d0
		cmpi.b	#8,d0
		bhs.s	loc_623B8
		move.l	word_623DA(pc,d0.w),x_vel(a0)	; and y_vel
		addq.b	#4,d0
		move.b	d0,$39(a0)
		bchg	#0,render_flags(a0)

locret_623B6:
		rts
; ---------------------------------------------------------------------------

loc_623B8:
		move.b	#8,routine(a0)
		bclr	#0,render_flags(a0)
		add.w	d1,y_pos(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_623E2,$34(a0)
		bra.w	loc_62056
; ---------------------------------------------------------------------------
word_623DA:
		dc.w  -$100, -$400
		dc.w   $100, -$400
; ---------------------------------------------------------------------------

loc_623E2:
		move.b	#$A,routine(a0)
		bset	#0,render_flags(a0)
		move.w	#-$600,y_vel(a0)
		move.w	#$400,x_vel(a0)
		bra.w	loc_6208C
; ---------------------------------------------------------------------------

loc_623FE:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite).l
		tst.b	render_flags(a0)
		bmi.w	locret_6206C
		lea	ChildObjDat_66568(pc),a2
		jsr	(CreateChild1_Normal).l
		move.w	(Camera_stored_max_Y_pos).w,(Camera_target_max_Y_pos).w

loc_62422:
		lea	(Target_palette_line_2).w,a1
		lea	(Normal_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_6242C:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_6242C
		lea	(PLC_Monitors).l,a1
		jsr	(Load_PLC_Raw).l
		jsr	(AllocateObject).l
		bne.s	loc_6244C
		move.l	#Obj_Song_Fade_ToLevelMusic,(a1)

loc_6244C:
		jsr	(Remove_From_TrackingSlot).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_62458:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.w	CutsceneKnux_Delete
		move.b	#8,width_pixels(a0)
		moveq	#$13,d1
		move.w	#$100,d2
		move.w	#$200,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectFull2).l
; ---------------------------------------------------------------------------

loc_62480:
		subq.w	#1,$2E(a0)
		bpl.s	locret_624BA
		moveq	#0,d0
		move.b	$39(a0),d0
		cmpi.b	#6,d0
		bhs.s	loc_624BC
		addq.b	#1,$39(a0)
		add.w	d0,d0
		move.w	word_624D0(pc,d0.w),$2E(a0)
		moveq	#0,d1
		btst	#1,d0
		beq.s	loc_624A8
		moveq	#$40,d1

loc_624A8:
		lea	Pal_CNZFlash(pc),a1
		adda.w	d1,a1

; =============== S U B R O U T I N E =======================================


sub_624AE:
		lea	(Normal_palette_line_3).w,a2
		moveq	#bytesToLcnt($40),d0

loc_624B4:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_624B4

locret_624BA:
		rts
; End of function sub_624AE

; ---------------------------------------------------------------------------

loc_624BC:
		tst.b	subtype(a0)
		beq.s	loc_624CA
		lea	(Pal_CNZ+$20).l,a1
		bsr.s	sub_624AE

loc_624CA:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
word_624D0:
		dc.w      8
		dc.w      4
		dc.w      3
		dc.w      2
		dc.w      4
		dc.w      8
		dc.w      8
; ---------------------------------------------------------------------------

CutsceneKnux_CNZ2B:
		cmpi.b	#2,(Player_1+character_id).w
		beq.w	CutsceneKnux_Delete
		lea	word_62520(pc),a1
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
		dc.w loc_62528-CutsceneKnux_CNZ2B_Index
		dc.w loc_6254E-CutsceneKnux_CNZ2B_Index
		dc.w loc_6256C-CutsceneKnux_CNZ2B_Index
		dc.w loc_62014-CutsceneKnux_CNZ2B_Index
		dc.w loc_620AA-CutsceneKnux_CNZ2B_Index
		dc.w loc_625BE-CutsceneKnux_CNZ2B_Index
		dc.w loc_625E2-CutsceneKnux_CNZ2B_Index
		dc.w loc_6261A-CutsceneKnux_CNZ2B_Index
word_62520:
		dc.w   $720,  $A00, $45C0, $46E0
; ---------------------------------------------------------------------------

loc_62528:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		clr.w	(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		move.b	#$80,(Player_1+object_control).w
		bsr.w	sub_65DD6
		lea	Pal_CutsceneKnux(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_6254E:
		lea	(Player_1).w,a1
		cmpi.w	#$4728,x_pos(a1)
		blo.s	locret_62562
		btst	#Status_InAir,status(a1)
		bne.s	loc_62564

locret_62562:
		rts
; ---------------------------------------------------------------------------

loc_62564:
		move.b	#4,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6256C:
		move.w	#(button_right_mask<<8)+button_right_mask,(Ctrl_1_logical).w
		cmpi.w	#$4760,(Player_1+x_pos).w
		bhs.s	loc_6257C
		rts
; ---------------------------------------------------------------------------

loc_6257C:
		move.b	#6,routine(a0)
		clr.w	(Ctrl_1_logical).w
		lea	(Player_1).w,a1
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		clr.w	ground_vel(a1)
		move.w	#$1F,$2E(a0)
		move.l	#loc_625A6,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_625A6:
		move.b	#8,routine(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_625CA,$34(a0)
		bra.w	loc_62080
; ---------------------------------------------------------------------------

loc_625BE:
		jsr	(Animate_Raw).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_625CA:
		move.b	#$C,routine(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		move.l	#byte_6669F,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_625E2:
		addq.w	#4,x_pos(a0)
		jsr	(Animate_Raw).l
		tst.b	render_flags(a0)
		bmi.w	locret_6206C
		move.b	#$E,routine(a0)
		clr.b	(Player_1+object_control).w
		lea	(Pal_CNZ).l,a1
		jsr	(PalLoad_Line1).l
		jsr	(AllocateObject).l
		bne.s	locret_62618
		move.l	#Obj_Song_Fade_ToLevelMusic,(a1)

locret_62618:
		rts
; ---------------------------------------------------------------------------

loc_6261A:
		move.w	#(button_left_mask<<8)+button_left_mask,(Ctrl_1_logical).w
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$160,d0
		cmp.w	y_pos(a0),d0
		blo.s	loc_62630
		rts
; ---------------------------------------------------------------------------

loc_62630:
		clr.b	(Ctrl_1_locked).w
		jsr	(Remove_From_TrackingSlot).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

CutsceneKnux_LBZ1:
		cmpi.b	#2,(Player_1+character_id).w
		beq.w	CutsceneKnux_Delete
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_LBZ1_Index(pc,d0.w),d1
		jsr	CutsceneKnux_LBZ1_Index(pc,d1.w)
		lea	DPLCPtr_CutsceneKnux(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Sprite_CheckDeleteTouchSlotted).l
; ---------------------------------------------------------------------------
CutsceneKnux_LBZ1_Index:
		dc.w loc_62678-CutsceneKnux_LBZ1_Index
		dc.w loc_626B2-CutsceneKnux_LBZ1_Index
		dc.w loc_62014-CutsceneKnux_LBZ1_Index
		dc.w loc_626EE-CutsceneKnux_LBZ1_Index
		dc.w loc_62014-CutsceneKnux_LBZ1_Index
		dc.w loc_62354-CutsceneKnux_LBZ1_Index
		dc.w loc_62354-CutsceneKnux_LBZ1_Index
		dc.w loc_62778-CutsceneKnux_LBZ1_Index
; ---------------------------------------------------------------------------

loc_62678:
		move.w	(Player_1+x_pos).w,d0
		cmp.w	x_pos(a0),d0
		bhs.s	loc_626AC
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.b	#$16,mapping_frame(a0)
		move.w	#$A0,(Camera_min_Y_pos).w
		lea	Pal_CutsceneKnux(pc),a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_6657C(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_626AC:
		jmp	(Go_Delete_SpriteSlotted2).l
; ---------------------------------------------------------------------------

loc_626B2:
		btst	#3,$38(a0)
		bne.s	loc_626BC
		rts
; ---------------------------------------------------------------------------

loc_626BC:
		move.b	#4,routine(a0)
		bsr.w	sub_65DD6
		move.w	#60-1,$2E(a0)
		move.l	#loc_626D6,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_626D6:
		move.b	#6,routine(a0)
		move.l	#byte_666C3,$30(a0)
		move.l	#loc_626F4,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_626EE:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_626F4:
		move.b	#8,routine(a0)
		move.w	#$F,$2E(a0)
		move.l	#loc_62726,$34(a0)
		moveq	#signextendB(sfx_MissileThrow),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_66584(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	(PLC_BossExplosion).l,a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

loc_62726:
		move.b	#$A,routine(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_6273E,$34(a0)
		bra.w	loc_62056
; ---------------------------------------------------------------------------

loc_6273E:
		move.b	#$C,routine(a0)
		st	(Screen_shake_flag).w
		move.w	#$5F,$2E(a0)
		move.l	#loc_62760,$34(a0)
		lea	ChildObjDat_6658C(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_62760:
		move.b	#$E,routine(a0)
		move.l	#byte_6669F,$30(a0)
		clr.b	anim_frame_timer(a0)
		clr.b	anim_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_62778:
		tst.b	render_flags(a0)
		bpl.w	loc_6278A
		addq.w	#2,x_pos(a0)
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_6278A:
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

loc_627C6:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.w	CutsceneKnux_Delete
		lea	word_62822(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.l	d0
		beq.s	locret_627FE
		tst.w	d0
		beq.s	loc_627F4
		movea.w	parent3(a0),a2
		bset	#3,$38(a2)
		bsr.w	sub_62800

loc_627F4:
		swap	d0
		tst.w	d0
		beq.s	locret_627FE
		bsr.w	sub_62800

locret_627FE:
		rts

; =============== S U B R O U T I N E =======================================


sub_62800:
		st	(_unkFAA9).w
		movea.w	d0,a1
		cmpi.b	#6,routine(a1)
		bhs.s	locret_627FE
		move.b	#$81,object_control(a1)
		bclr	#0,render_flags(a1)
		bclr	#Status_Facing,status(a1)
		rts
; End of function sub_62800

; ---------------------------------------------------------------------------
word_62822:
		dc.w   -$40,   $80,  -$30,   $60
; ---------------------------------------------------------------------------

loc_6282A:
		lea	ObjDat3_6640E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_6284E,(a0)
		move.w	#-$200,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		moveq	#signextendB(sfx_MissileThrow),d0
		jsr	(Play_SFX).l

loc_6284E:
		jsr	(MoveSprite_LightGravity).l
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------

loc_6285A:
		move.l	#loc_628A0,(a0)
		move.l	#Obj_BossExpControl1,$34(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		lea	word_62890(pc,d0.w),a1
		move.w	(a1)+,x_pos(a0)
		move.w	(a1)+,y_pos(a0)
		move.b	#$20,$39(a0)
		move.b	#$20,$3A(a0)
		move.b	#$20,$3B(a0)
		rts
; ---------------------------------------------------------------------------
word_62890:
		dc.w  $3BC0,  $1A0
		dc.w  $3B80,  $1A0
		dc.w  $3B40,  $1A0
		dc.w  $3B00,  $1A0
; ---------------------------------------------------------------------------

loc_628A0:
		subq.w	#4,y_pos(a0)
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

CutsceneKnux_LBZ2:
		cmpi.b	#2,(Player_1+character_id).w
		beq.w	CutsceneKnux_Delete
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_LBZ2_Index(pc,d0.w),d1
		jsr	CutsceneKnux_LBZ2_Index(pc,d1.w)
		lea	DPLCPtr_CutsceneKnux(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Sprite_CheckDeleteTouchSlotted).l
; ---------------------------------------------------------------------------
CutsceneKnux_LBZ2_Index:
		dc.w loc_628E0-CutsceneKnux_LBZ2_Index
		dc.w loc_6290E-CutsceneKnux_LBZ2_Index
		dc.w loc_62928-CutsceneKnux_LBZ2_Index
		dc.w loc_62942-CutsceneKnux_LBZ2_Index
		dc.w loc_62964-CutsceneKnux_LBZ2_Index
		dc.w loc_629A8-CutsceneKnux_LBZ2_Index
		dc.w loc_629C0-CutsceneKnux_LBZ2_Index
; ---------------------------------------------------------------------------

loc_628E0:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		bset	#0,render_flags(a0)
		move.b	#$20,mapping_frame(a0)
		bsr.w	sub_65DD6
		lea	Pal_CutsceneKnux(pc),a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_66592(pc),a2
		jmp	(CreateChild3_NormalRepeated).l
; ---------------------------------------------------------------------------

loc_6290E:
		btst	#1,$38(a0)
		bne.s	loc_62918
		rts
; ---------------------------------------------------------------------------

loc_62918:
		move.b	#4,routine(a0)
		move.l	#loc_62932,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_62928:
		lea	byte_666D2(pc),a1
		jmp	(Animate_RawNoSSTMultiDelay).l
; ---------------------------------------------------------------------------

loc_62932:
		move.b	#6,routine(a0)
		bclr	#0,render_flags(a0)
		bra.w	loc_62056
; ---------------------------------------------------------------------------

loc_62942:
		tst.b	(Screen_shake_flag).w
		beq.s	loc_6295E
		move.b	#8,routine(a0)
		move.l	#byte_6669A,$30(a0)
		clr.b	anim_frame_timer(a0)
		clr.b	anim_frame(a0)

loc_6295E:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_62964:
		btst	#3,$38(a0)
		bne.s	loc_6297A
		move.w	(Events_bg+$14).w,d0
		add.w	d0,y_pos(a0)
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_6297A:
		move.b	#$A,routine(a0)
		bset	#0,render_flags(a0)
		move.b	#9,mapping_frame(a0)
		move.w	#$200,x_vel(a0)
		move.w	#-$100,y_vel(a0)
		jsr	(AllocateObject).l
		bne.s	locret_629A6
		move.l	#Obj_Song_Fade_ToLevelMusic,(a1)

locret_629A6:
		rts
; ---------------------------------------------------------------------------

loc_629A8:
		move.w	y_pos(a0),d0
		cmp.w	(Water_level).w,d0
		blo.s	loc_629C0
		moveq	#signextendB(sfx_Splash),d0
		jsr	(Play_SFX).l
		move.b	#$C,routine(a0)

loc_629C0:
		move.w	(Events_bg+$14).w,d0
		add.w	d0,y_pos(a0)
		jmp	(MoveSprite_LightGravity).l
; ---------------------------------------------------------------------------

loc_629CE:
		lea	ObjDat3_6641A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_62A0A,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		move.l	word_629FA(pc,d0.w),$3E(a0)
		lsl.w	#3,d0
		add.w	d0,y_pos(a0)
		move.w	x_pos(a0),$3A(a0)
		rts
; ---------------------------------------------------------------------------
word_629FA:
		dc.w   $100,   $10
		dc.w    $C0,    $C
		dc.w    $80,     8
		dc.w    $40,     4
; ---------------------------------------------------------------------------

loc_62A0A:
		tst.b	(Screen_shake_flag).w
		beq.s	loc_62A22
		move.l	#loc_62A28,(a0)
		move.w	$3E(a0),x_vel(a0)
		move.b	#6,$39(a0)

loc_62A22:
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------

loc_62A28:
		move.w	(Events_bg+$14).w,d0
		add.w	d0,y_pos(a0)
		move.w	x_pos(a0),d0
		move.w	$40(a0),d1
		cmp.w	$3A(a0),d0
		scs	d2
		bcs.s	loc_62A42
		neg.w	d1

loc_62A42:
		add.w	d1,x_vel(a0)
		cmp.b	$3C(a0),d2
		beq.s	loc_62A82
		move.b	d2,$3C(a0)
		cmpi.b	#3,$39(a0)
		bne.s	loc_62A6C
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		move.l	word_62A9E(pc,d0.w),$3E(a0)
		move.w	$3E(a0),x_vel(a0)

loc_62A6C:
		subq.b	#1,$39(a0)
		bne.s	loc_62A82
		move.l	#loc_62AAE,(a0)
		movea.w	parent3(a0),a1
		bset	#3,$38(a1)

loc_62A82:
		jsr	(MoveSprite2).l
		tst.b	subtype(a0)
		bne.s	loc_62A98
		movea.w	parent3(a0),a1
		move.w	x_pos(a0),x_pos(a1)

loc_62A98:
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------
word_62A9E:
		dc.w   $200,   $20
		dc.w   $180,   $18
		dc.w   $100,   $10
		dc.w    $80,     8
; ---------------------------------------------------------------------------

loc_62AAE:
		move.w	(Events_bg+$14).w,d0
		add.w	d0,y_pos(a0)
		jsr	(MoveSprite_LightGravity).l
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------

Obj_LBZKnuxPillar:
		lea	ObjDat_LBZKnuxPillar(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#1,render_flags(a0)
		beq.s	loc_62ADA
		bset	#7,art_tile(a0)

loc_62ADA:
		bclr	#0,render_flags(a0)
		beq.s	loc_62AE8
		move.w	#0,priority(a0)

loc_62AE8:
		move.l	#loc_62AEE,(a0)

loc_62AEE:
		move.w	(Events_bg+$14).w,d0
		add.w	d0,y_pos(a0)
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
Map_LBZKnuxPillar:
		include "Levels/LBZ/Misc Object Data/Map - Knuckles Pillar.asm"
; ---------------------------------------------------------------------------

CutsceneKnux_MHZ1:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_MHZ1_Index(pc,d0.w),d1
		jsr	CutsceneKnux_MHZ1_Index(pc,d1.w)
		lea	DPLCPtr_CutsceneKnux(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Sprite_CheckDeleteTouchSlotted).l
; ---------------------------------------------------------------------------
CutsceneKnux_MHZ1_Index:
		dc.w loc_62B68-CutsceneKnux_MHZ1_Index
		dc.w loc_62BB2-CutsceneKnux_MHZ1_Index
		dc.w loc_62BC0-CutsceneKnux_MHZ1_Index
		dc.w loc_62BE4-CutsceneKnux_MHZ1_Index
		dc.w loc_62BF4-CutsceneKnux_MHZ1_Index
		dc.w loc_62C42-CutsceneKnux_MHZ1_Index
		dc.w loc_62C42-CutsceneKnux_MHZ1_Index
		dc.w loc_62C90-CutsceneKnux_MHZ1_Index
; ---------------------------------------------------------------------------

loc_62B68:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		bclr	#7,art_tile(a0)
		move.w	#(2*60)-1,$2E(a0)
		move.l	#byte_6669F,$30(a0)
		move.w	#$2B0,x_pos(a0)
		move.w	#$66C,y_pos(a0)
		move.w	#$200,x_vel(a0)
		lea	(Normal_palette_line_2).w,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_62BA2:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_62BA2
		lea	Pal_CutsceneKnux(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_62BB2:
		subq.w	#1,$2E(a0)
		bpl.s	locret_62BBE
		move.b	#4,routine(a0)

locret_62BBE:
		rts
; ---------------------------------------------------------------------------

loc_62BC0:
		cmpi.w	#$360,x_pos(a0)
		bhs.s	loc_62BD4
		jsr	(Animate_Raw).l
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_62BD4:
		move.b	#6,routine(a0)
		lea	ChildObjDat_665B0(pc),a2
		jsr	(CreateChild6_Simple).l

loc_62BE4:
		btst	#3,$38(a0)
		bne.s	loc_62BEE
		rts
; ---------------------------------------------------------------------------

loc_62BEE:
		move.b	#8,routine(a0)

loc_62BF4:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite2).l
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d0
		subi.w	#$28,d0
		cmp.w	x_pos(a0),d0
		bls.s	loc_62C14
		rts
; ---------------------------------------------------------------------------

loc_62C14:
		move.w	d0,x_pos(a0)
		move.b	#$A,routine(a0)
		move.b	#$17,y_radius(a0)
		move.w	#$100,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		move.l	#loc_62C5A,$34(a0)
		lea	byte_666AF(pc),a1
		jsr	(Set_Raw_Animation).l

loc_62C42:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite).l
		jsr	(ObjHitFloor_DoRoutine).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_62C5A:
		move.b	#$C,routine(a0)
		move.b	#$13,y_radius(a0)
		move.w	#-$300,y_vel(a0)
		move.l	#loc_62C76,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_62C76:
		move.b	#$E,routine(a0)
		move.w	#$200,x_vel(a0)
		clr.w	y_vel(a0)
		lea	byte_6669F(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_62C90:
		tst.b	render_flags(a0)
		bpl.w	loc_62422
		jsr	(Animate_Raw).l
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

Obj_MHZ1CutsceneKnuckles:
		cmpi.b	#2,(Player_1+character_id).w
		beq.w	CutsceneKnux_Delete
		tst.b	(Last_star_post_hit).w
		bne.w	CutsceneKnux_Delete
		tst.w	(SK_alone_flag).w
		bne.w	CutsceneKnux_Delete
		lea	(Player_1).w,a1
		moveq	#0,d0
		move.b	(_unkFAB8).w,d0
		move.w	MHZ1CutsceneKnuckles_Index(pc,d0.w),d0
		jmp	MHZ1CutsceneKnuckles_Index(pc,d0.w)
; ---------------------------------------------------------------------------
MHZ1CutsceneKnuckles_Index:
		dc.w loc_62CDE-MHZ1CutsceneKnuckles_Index
		dc.w loc_62CF8-MHZ1CutsceneKnuckles_Index
		dc.w loc_62D2C-MHZ1CutsceneKnuckles_Index
		dc.w loc_62D42-MHZ1CutsceneKnuckles_Index
		dc.w loc_62D5A-MHZ1CutsceneKnuckles_Index
		dc.w locret_62D6E-MHZ1CutsceneKnuckles_Index
		dc.w loc_62D70-MHZ1CutsceneKnuckles_Index
; ---------------------------------------------------------------------------

loc_62CDE:
		move.b	#2,(_unkFAB8).w
		tst.l	(Player_2).w
		beq.s	loc_62CF8
		jsr	(AllocateObject).l
		bne.s	loc_62CF8
		move.l	#loc_62DAC,(a1)

loc_62CF8:
		move.w	#$389,d0
		cmp.w	x_pos(a1),d0
		bls.s	loc_62D04
		rts
; ---------------------------------------------------------------------------

loc_62D04:
		move.w	d0,x_pos(a1)
		move.b	#4,(_unkFAB8).w
		bclr	#0,render_flags(a1)
		bclr	#0,status(a1)
		st	(Ctrl_1_locked).w
		clr.w	(Ctrl_1_logical).w
		jsr	(Stop_Object).l
		bra.w	sub_65DD6
; ---------------------------------------------------------------------------

loc_62D2C:
		btst	#Status_InAir,status(a1)
		beq.s	loc_62D36
		rts
; ---------------------------------------------------------------------------

loc_62D36:
		move.b	#6,(_unkFAB8).w
		move.w	#$20,$2E(a0)

loc_62D42:
		subq.w	#1,$2E(a0)
		bmi.s	loc_62D4A
		rts
; ---------------------------------------------------------------------------

loc_62D4A:
		move.b	#8,(_unkFAB8).w
		st	(Scroll_lock).w
		move.w	#(button_down_mask<<8)|button_down_mask,(Ctrl_1_logical).w

loc_62D5A:
		addq.w	#2,(Camera_Y_pos).w
		cmpi.w	#$5B0,(Camera_Y_pos).w
		bhs.s	loc_62D68
		rts
; ---------------------------------------------------------------------------

loc_62D68:
		move.b	#$A,(_unkFAB8).w

locret_62D6E:
		rts
; ---------------------------------------------------------------------------

loc_62D70:
		clr.b	(_unkFAB8).w
		clr.b	(Ctrl_1_locked).w
		clr.b	(Ctrl_2_locked).w
		clr.b	(Scroll_lock).w
		clr.w	(Ctrl_1_logical).w
		clr.w	(Ctrl_2_logical).w
		move.b	#5,(Player_2+anim).w
		move.b	#1,(Last_star_post_hit).w
		move.w	#$190,(Saved_X_pos).w
		move.w	#$56C,(Saved_Y_pos).w
		jsr	(Save_Level_Data).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_62DAC:
		lea	(Player_2).w,a1
		cmpi.b	#4,(_unkFAB8).w
		bhs.s	loc_62DC4
		move.w	#$371,d0
		cmp.w	x_pos(a1),d0
		bls.s	loc_62DC4
		rts
; ---------------------------------------------------------------------------

loc_62DC4:
		move.w	d0,x_pos(a0)
		move.l	#loc_62DDC,(a0)
		st	(Ctrl_2_locked).w
		clr.w	(Ctrl_2_logical).w
		jsr	(Stop_Object).l

loc_62DDC:
		lea	(Player_2).w,a1
		move.b	(_unkFAB8).w,d0
		beq.s	loc_62E1A
		cmpi.b	#4,(_unkFAB8).w
		blo.s	loc_62E04
		move.w	#$371,d0
		cmp.w	x_pos(a1),d0
		bhi.s	locret_62E18
		move.b	#8,anim(a1)
		jmp	(Stop_Object).l
; ---------------------------------------------------------------------------

loc_62E04:
		tst.b	render_flags(a1)
		bmi.s	locret_62E18
		move.l	#loc_62DAC,(a0)
		clr.b	(Ctrl_2_locked).w
		clr.w	(Ctrl_2_logical).w

locret_62E18:
		rts
; ---------------------------------------------------------------------------

loc_62E1A:
		clr.b	(Ctrl_2_locked).w
		clr.w	(Ctrl_2_logical).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_MHZ1CutsceneButton:
		lea	ObjDat_MHZ1CutsceneButton(pc),a1
		jsr	(SetUp_ObjAttributes).l
		lea	ChildObjDat_665B6(pc),a2
		jsr	(CreateChild6_Simple).l
		move.l	#loc_62F0A,(a0)
		tst.b	(Last_star_post_hit).w
		bne.s	loc_62E56
		cmpi.b	#2,(Player_1+character_id).w
		beq.s	loc_62E56
		move.l	#loc_62E5C,(a0)

loc_62E56:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_62E5C:
		cmpi.b	#$A,(_unkFAB8).w
		bhs.s	loc_62E6A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_62E6A:
		move.l	#loc_62E92,(a0)
		lea	(ArtKosM_MHZKnuxPeer).l,a1
		move.w	#tiles_to_bytes($500),d2
		jsr	(Queue_Kos_Module).l
		lea	ChildObjDat_665AA(pc),a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_62E92
		move.b	#$1C,subtype(a1)

loc_62E92:
		move.w	(_unkFAA4).w,d0
		beq.s	loc_62ECA
		movea.w	d0,a1
		lea	word_65C48(pc),a2
		jsr	(Check_InMyRange).l
		beq.s	loc_62ECA
		move.l	#loc_62ED0,(a0)
		move.w	#1,$2E(a0)
		move.b	#1,mapping_frame(a0)
		bset	#1,$38(a0)
		st	(_unkFAA9).w
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l

loc_62ECA:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_62ED0:
		bclr	#1,$38(a0)
		subq.w	#1,$2E(a0)
		bpl.s	loc_62EF6
		move.l	#Wait_Draw,(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_62EFC,$34(a0)
		move.b	#0,mapping_frame(a0)

loc_62EF6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_62EFC:
		move.b	#$C,(_unkFAB8).w
		move.l	#loc_62F0A,(a0)
		rts
; ---------------------------------------------------------------------------

loc_62F0A:
		bsr.w	sub_65DEC
		move.b	status(a0),d1
		andi.b	#standing_mask,d1
		beq.s	loc_62F46
		move.l	#loc_62F4C,(a0)
		move.b	#1,mapping_frame(a0)
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l
		btst	#2,$38(a0)
		bne.s	loc_62F46
		bset	#1,$38(a0)
		not.b	(_unkFAA9).w
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l

loc_62F46:
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------

loc_62F4C:
		bclr	#1,$38(a0)
		bsr.w	sub_65DEC
		move.b	status(a0),d0
		andi.b	#standing_mask,d0
		bne.s	loc_62F6C
		move.l	#loc_62F0A,(a0)
		move.b	#0,mapping_frame(a0)

loc_62F6C:
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------

loc_62F72:
		lea	ObjDat3_6643E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_62FA2,(a0)
		move.w	#$374,x_pos(a0)
		move.w	#$66C,y_pos(a0)
		move.w	#$200,x_vel(a0)
		move.w	#7,$2E(a0)
		move.l	#loc_62FB4,$34(a0)

loc_62FA2:
		jsr	(MoveSprite2).l
		jsr	(Obj_Wait).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_62FB4:
		move.l	#loc_62FCA,(a0)
		move.l	#loc_62FDA,$34(a0)
		bset	#7,art_tile(a0)
		rts
; ---------------------------------------------------------------------------

loc_62FCA:
		lea	byte_666E1(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_62FDA:
		move.l	#loc_62FA2,(a0)
		move.w	#-$400,x_vel(a0)
		move.w	#$F,$2E(a0)
		move.l	#loc_62FFC,$34(a0)
		bclr	#7,art_tile(a0)
		rts
; ---------------------------------------------------------------------------

loc_62FFC:
		movea.w	parent3(a0),a1
		bset	#3,$38(a1)
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_6300C:
		lea	ObjDat3_66462(pc),a1
		jsr	(SetUp_ObjAttributes).l
		movea.w	parent3(a0),a1
		move.w	a0,$44(a1)
		move.l	#loc_6303C,(a0)
		move.w	#$390,x_pos(a0)
		move.w	#$620,y_pos(a0)
		tst.b	(_unkFAA9).w
		beq.s	loc_6303C
		addi.w	#$40,y_pos(a0)

loc_6303C:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	loc_63078
		jsr	(sub_65E4C).l
		lea	(Player_1).w,a1
		jsr	(Find_OtherObject).l
		tst.b	(_unkFAA9).w
		beq.s	loc_6306E
		tst.w	d0
		bne.s	loc_6306E
		cmpi.w	#$40,d2
		bhs.s	loc_6306E
		cmpi.w	#$60,d3
		blo.s	loc_63074

loc_6306E:
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_63074:
		clr.b	(_unkFAA9).w

loc_63078:
		move.l	#loc_630A6,(a0)
		movea.w	parent3(a0),a1
		bset	#2,$38(a1)
		move.w	#$100,d0
		tst.b	(_unkFAA9).w
		bne.s	loc_63094
		neg.w	d0

loc_63094:
		move.w	d0,y_vel(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_630BE,$34(a0)

loc_630A6:
		jsr	(MoveSprite2).l
		jsr	(sub_65E4C).l
		jsr	(Obj_Wait).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_630BE:
		move.l	#loc_6303C,(a0)
		movea.w	parent3(a0),a1
		bclr	#2,$38(a1)
		rts
; ---------------------------------------------------------------------------
word_630D0:
		dc.w   $648,  $848
		dc.w   $2D0,  $4D0
		dc.w   $748,  $748
word_630DC:
		dc.w   $3D0,  $3D0
; ---------------------------------------------------------------------------

CutsceneKnux_MHZ2:
		cmpi.b	#2,(Player_1+character_id).w
		beq.s	loc_6311A
		cmpi.b	#7,(Last_star_post_hit).w
		bhs.w	CutsceneKnux_Delete
		lea	word_630D0(pc),a1
		jsr	(Check_CameraInRange).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_MHZ2_Index(pc,d0.w),d1
		jsr	CutsceneKnux_MHZ2_Index(pc,d1.w)
		lea	DPLCPtr_MHZKnuxPress(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Sprite_CheckDeleteTouchSlotted).l
; ---------------------------------------------------------------------------

loc_6311A:
		lea	ChildObjDat_665BC(pc),a2
		jsr	(CreateChild1_Normal).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------
CutsceneKnux_MHZ2_Index:
		dc.w loc_63134-CutsceneKnux_MHZ2_Index
		dc.w loc_63170-CutsceneKnux_MHZ2_Index
		dc.w loc_631A4-CutsceneKnux_MHZ2_Index
		dc.w loc_63220-CutsceneKnux_MHZ2_Index
		dc.w loc_632AE-CutsceneKnux_MHZ2_Index
; ---------------------------------------------------------------------------

loc_63134:
		lea	ObjSlot_CutsceneKnux_MHZ2(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.l	#loc_63182,$34(a0)
		move.w	(Camera_min_X_pos).w,(Camera_stored_min_X_pos).w
		move.w	(word_630DC).l,(_unkFAB4).w
		bsr.w	sub_65DD6
		st	(Events_bg+$16).w
		lea	Pal_CutsceneKnux(pc),a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_665BC(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_63170:
		move.w	(Camera_X_pos).w,d0
		move.w	(_unkFAB4).w,d1
		cmp.w	d1,d0
		bhs.s	loc_63182
		move.w	d0,(Camera_min_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_63182:
		move.w	d1,(Camera_min_X_pos).w
		move.b	#4,routine(a0)
		move.w	#60-1,$2E(a0)
		st	(Ctrl_1_locked).w
		st	(Ctrl_2_locked).w
		clr.w	(Ctrl_1_logical).w
		clr.w	(Ctrl_2_logical).w
		rts
; ---------------------------------------------------------------------------

loc_631A4:
		subi.w	#1,$2E(a0)
		bmi.s	loc_631E0
		moveq	#0,d0
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	loc_631BE
		bset	#0,d0

loc_631BE:
		lea	(Player_2).w,a2
		tst.l	(a2)
		beq.s	loc_631D4
		tst.b	render_flags(a2)
		bpl.s	loc_631D4
		btst	#Status_InAir,status(a2)
		bne.s	loc_631D8

loc_631D4:
		bset	#1,d0

loc_631D8:
		cmpi.b	#3,d0
		beq.s	loc_631E0

locret_631DE:
		rts
; ---------------------------------------------------------------------------

loc_631E0:
		move.b	#6,routine(a0)
		move.l	#loc_63280,$34(a0)
		move.w	#$10,$3E(a0)
		clr.w	$2E(a0)
		move.b	#1,$39(a0)
		lea	(Player_1).w,a1
		bsr.w	sub_6320E
		lea	(Player_2).w,a1
		tst.l	(a1)
		beq.s	locret_631DE

; =============== S U B R O U T I N E =======================================


sub_6320E:
		move.b	#$81,object_control(a1)
		move.b	#5,anim(a1)
		jmp	(Stop_Object).l
; End of function sub_6320E

; ---------------------------------------------------------------------------

loc_63220:
		bsr.w	sub_65E62
		cmpi.b	#8,anim_frame(a0)
		blo.s	loc_63238
		moveq	#signextendB(sfx_LeafBlower),d0
		jsr	(Play_SFX_Continuous).l
		bsr.w	sub_65EB4

loc_63238:
		lea	byte_666F6(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		beq.s	locret_6327E
		cmpi.b	#$C,anim_frame(a0)
		bne.s	loc_63266
		lea	(Player_1).w,a1
		move.b	#$14,anim(a1)
		lea	(Player_2).w,a1
		tst.b	render_flags(a1)
		bpl.s	loc_63266
		move.b	#$14,anim(a1)

loc_63266:
		cmpi.b	#2,mapping_frame(a0)
		bne.s	locret_6327E
		addq.b	#1,$39(a0)
		subq.w	#4,$3E(a0)
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l

locret_6327E:
		rts
; ---------------------------------------------------------------------------

loc_63280:
		move.b	#8,routine(a0)
		jsr	(AllocateObject).l
		bne.s	loc_63294
		move.l	#loc_6338E,(a1)

loc_63294:
		tst.b	(Player_2+render_flags).w
		bpl.s	loc_632AE
		jsr	(AllocateObject).l
		bne.s	loc_632AE
		move.l	#loc_6338E,(a1)
		move.b	#2,subtype(a1)

loc_632AE:
		tst.b	render_flags(a0)
		bpl.w	loc_62422
		bra.w	sub_65EB4
; ---------------------------------------------------------------------------
		lea	(Pal_MHZ2).l,a1
		jsr	(PalLoad_Line1).l
		bra.w	loc_62422
; ---------------------------------------------------------------------------

loc_632CA:
		lea	ObjDat3_66456(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_63308,(a0)
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	loc_632F8
		move.l	#Sprite_OnScreen_Test,(a0)
		move.w	#make_art_tile($528,0,1),art_tile(a0)
		movea.w	parent3(a0),a1
		move.w	respawn_addr(a1),respawn_addr(a0)

loc_632F8:
		lea	(ArtKosM_MHZKnuxSwitch).l,a1
		move.w	#tiles_to_bytes($528),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_63308:
		movea.w	parent3(a0),a1
		clr.b	mapping_frame(a0)
		cmpi.b	#2,mapping_frame(a1)
		bne.s	loc_6331E
		move.b	#1,mapping_frame(a0)

loc_6331E:
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_63324:
		lea	ObjDat3_6646E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_63372,(a0)
		jsr	(Random_Number).l
		andi.w	#$1FF,d0
		cmpi.w	#$140,d0
		blo.s	loc_6334A
		andi.w	#$3F,d0
		lsl.w	#2,d0

loc_6334A:
		move.w	(Camera_X_pos_copy).w,d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.w	(Camera_Y_pos_copy).w,d1
		addi.w	#$E8,d1
		move.w	d1,y_pos(a0)
		moveq	#0,d1
		movea.w	parent3(a0),a1
		move.b	$39(a1),d1
		add.w	d1,d1
		neg.w	d1
		move.w	d1,y_vel(a0)

loc_63372:
		move.w	y_vel(a0),d0
		add.w	d0,y_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		subq.w	#8,d0
		cmp.w	y_pos(a0),d0
		bhs.w	CutsceneKnux_Delete
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6338E:
		lea	(Player_1).w,a1
		tst.b	subtype(a0)
		beq.s	loc_6339C
		lea	(Player_2).w,a1

loc_6339C:
		move.l	#loc_633D6,(a0)
		move.w	a1,$44(a0)
		move.w	#-$1000,y_vel(a0)
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.b	#$81,object_control(a1)
		move.b	#$F,anim(a1)
		bclr	#1,render_flags(a1)
		bset	#7,art_tile(a1)
		st	(Fast_V_scroll_flag).w
		rts
; ---------------------------------------------------------------------------

loc_633D6:
		moveq	#signextendB(sfx_LeafBlower),d0
		jsr	(Play_SFX_Continuous).l
		jsr	(MoveSprite_LightGravity).l
		movea.w	$44(a0),a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		tst.w	y_vel(a0)
		bmi.w	locret_6206C
		clr.b	(Ctrl_1_locked).w
		clr.b	(Ctrl_2_locked).w
		clr.w	(Ctrl_1_logical).w
		clr.w	(Ctrl_2_logical).w
		clr.b	object_control(a1)
		bclr	#7,art_tile(a1)
		clr.b	anim(a1)
		move.w	#$10,ground_vel(a1)
		clr.b	(Fast_V_scroll_flag).w
		clr.b	(Events_bg+$16).w
		move.b	#7,(Last_star_post_hit).w
		move.w	#$52A,(Saved_X_pos).w
		move.w	#$5AC,(Saved_Y_pos).w
		jsr	(Save_Level_Data).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

CutsceneKnux_SKIntro:
		cmpi.b	#2,(Player_1+character_id).w
		bne.w	CutsceneKnux_Delete
		tst.b	(Last_star_post_hit).w
		bne.w	CutsceneKnux_Delete
		tst.w	(SK_alone_flag).w
		beq.w	CutsceneKnux_Delete
		move.l	#loc_63466,(a0)

loc_63466:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_63486(pc,d0.w),d1
		jsr	off_63486(pc,d1.w)
		move.w	$42(a0),d0
		move.w	off_63494(pc,d0.w),d0
		jsr	off_63494(pc,d0.w)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_63486:
		dc.w loc_634CA-off_63486
		dc.w loc_63526-off_63486
		dc.w loc_63562-off_63486
		dc.w loc_6358E-off_63486
		dc.w loc_635C8-off_63486
		dc.w loc_635F6-off_63486
		dc.w loc_63620-off_63486
off_63494:
		dc.w loc_6349A-off_63494
		dc.w loc_634AC-off_63494
		dc.w loc_634B8-off_63494
; ---------------------------------------------------------------------------

loc_6349A:
		move.l	#Map_KnuxIntroLay,mappings(a0)
		lea	DPLCPtr_KnuxIntroLay(pc),a2
		jmp	(Perform_DPLC).l
; ---------------------------------------------------------------------------

loc_634AC:
		move.l	#Map_Knuckles,mappings(a0)
		bra.w	Knuckles_Load_PLC_6618A
; ---------------------------------------------------------------------------

loc_634B8:
		move.l	#Map_HPZKnucklesGrab,mappings(a0)
		lea	DPLCPtr_HPZKnucklesGrab(pc),a2
		jmp	(Perform_DPLC).l
; ---------------------------------------------------------------------------

loc_634CA:
		lea	ObjSlot_KnuxIntroLay(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.w	#$EF,$2E(a0)
		move.b	#$83,(Player_1+object_control).w
		move.w	#$560,(Camera_X_pos).w
		move.w	#$948,(Camera_Y_pos).w
		st	(Scroll_lock).w
		move.l	(V_int_run_count).w,(RNG_seed).w
		clr.b	(Level_started_flag).w
		jsr	(AllocateObject).l
		bne.s	loc_63508
		move.l	#Obj_SkipIntro,(a1)

loc_63508:
		lea	ChildObjDat_66656(pc),a2
		jsr	(CreateChild6_Simple).l
		lea	(Pal_SKIntroBomb).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_6351E:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_6351E
		rts
; ---------------------------------------------------------------------------

loc_63526:
		btst	#0,(_unkFAB8).w
		bne.s	loc_6354C
		subq.w	#1,$2E(a0)
		bne.s	loc_63542
		jsr	(AllocateObject).l
		bne.s	loc_63542
		move.l	#loc_63790,(a1)

loc_63542:
		lea	byte_668C3(pc),a1
		jmp	(Animate_RawNoSST).l
; ---------------------------------------------------------------------------

loc_6354C:
		move.b	#4,routine(a0)
		move.b	#4,mapping_frame(a0)
		lea	byte_668C7(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_63562:
		btst	#1,(_unkFAB8).w
		bne.s	loc_63570
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_63570:
		move.b	#6,routine(a0)
		move.w	#2,$42(a0)
		move.b	#$8D,mapping_frame(a0)
		move.w	#-$100,x_vel(a0)
		move.w	#-$100,y_vel(a0)

loc_6358E:
		btst	#2,(_unkFAB8).w
		bne.s	loc_635A2
		addi.w	#8,y_vel(a0)
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_635A2:
		move.b	#8,routine(a0)
		move.w	#4,$42(a0)
		move.b	#3,mapping_frame(a0)
		subq.w	#8,y_pos(a0)
		move.b	#$13,y_radius(a0)
		move.w	#-$100,x_vel(a0)
		clr.w	y_vel(a0)

loc_635C8:
		jsr	(MoveSprite_LightGravity).l
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.w	locret_6206C
		add.w	d1,y_pos(a0)
		move.b	#$A,routine(a0)
		move.l	#loc_635FC,$34(a0)
		lea	byte_668D0(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_635F6:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_635FC:
		move.b	#$C,routine(a0)
		move.w	#2,$42(a0)
		move.b	#7,mapping_frame(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		lea	byte_6682F(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_63620:
		move.w	x_vel(a0),d0
		addi.w	#$C,d0
		cmpi.w	#$400,d0
		bhi.s	loc_63632
		move.w	d0,x_vel(a0)

loc_63632:
		jsr	(MoveSprite2).l
		jsr	(Animate_RawCheckResult).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$180,d0
		cmp.w	x_pos(a0),d0
		bhs.w	locret_6206C

loc_6364E:
		move.b	#1,(Last_star_post_hit).w
		move.w	#$6F4,(Saved_X_pos).w
		move.w	#$9EC,(Saved_Y_pos).w
		jsr	(Save_Level_Data).l
		clr.l	(Saved_timer).w
		move.w	#$700,d0
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		move.w	#1,(Restart_level_flag).w
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

Obj_SkipIntro:
		btst	#button_start,(Ctrl_1_pressed).w
		bne.s	loc_6364E
		btst	#button_start,(Ctrl_2_pressed).w
		bne.s	loc_6364E
		rts
; ---------------------------------------------------------------------------

loc_63694:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_636F4(pc,d0.w),x_pos(a0)
		move.w	#$9F4,y_pos(a0)
		moveq	#0,d1
		cmpi.w	#8,d0
		blo.s	loc_636B0
		moveq	#4,d1

loc_636B0:
		move.l	word_63704(pc,d1.w),$3A(a0)
		lea	off_6370C(pc),a1
		move.b	#$C,y_radius(a0)
		andi.w	#2,d0
		beq.s	loc_636D0
		adda.w	#$A,a1
		move.b	#$A,y_radius(a0)

loc_636D0:
		move.l	(a1)+,(a0)
		move.l	(a1)+,mappings(a0)
		move.w	(a1)+,art_tile(a0)
		bset	#2,render_flags(a0)
		move.w	#$200,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		rts
; ---------------------------------------------------------------------------
word_636F4:
		dc.w   $5F0
		dc.w   $600
		dc.w   $610
		dc.w   $620
		dc.w   $660
		dc.w   $670
		dc.w   $680
		dc.w   $690
word_63704:
		dc.w   $5E8
		dc.w   $628
		dc.w   $658
		dc.w   $698
off_6370C:
		dc.l loc_63720
		dc.l Map_Animals2
		dc.w make_art_tile($580,0,0)
		dc.l loc_63750
		dc.l Map_Animals1
		dc.w make_art_tile($592,0,0)
; ---------------------------------------------------------------------------

loc_63720:
		jsr	(MoveSprite).l
		move.b	#1,mapping_frame(a0)
		tst.w	y_vel(a0)
		bmi.s	loc_6374A
		move.b	#0,mapping_frame(a0)
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	loc_6374A
		add.w	d1,y_pos(a0)
		bsr.w	sub_65E02

loc_6374A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_63750:
		jsr	(MoveSprite2).l
		addi.w	#$18,y_vel(a0)
		tst.w	y_vel(a0)
		bmi.s	loc_63774
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	loc_63774
		add.w	d1,y_pos(a0)
		bsr.w	sub_65E02

loc_63774:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_6378A
		move.b	#1,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		andi.b	#1,mapping_frame(a0)

loc_6378A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_63790:
		lea	ObjDat3_66486(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_637EC,(a0)
		move.b	#$10,y_radius(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$40,d0
		move.w	d0,y_pos(a0)
		moveq	#signextendB(sfx_MissileThrow),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_6665C(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	(PLC_BossExplosion).l,a1
		jsr	(Load_PLC_Raw).l
		lea	(ArtKosM_KnuxIntroBomb).l,a1
		move.w	#tiles_to_bytes($52E),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_637EC:
		jsr	(MoveSprite).l
		tst.b	render_flags(a0)
		bpl.s	loc_63840
		tst.w	y_vel(a0)
		bmi.s	loc_63840
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	loc_63840
		add.w	d1,y_pos(a0)
		bset	#0,(_unkFAB8).w
		moveq	#signextendB(sfx_FloorThump),d0
		jsr	(Play_SFX).l
		move.w	y_vel(a0),d0
		asr.w	#2,d0
		neg.w	d0
		move.w	d0,y_vel(a0)
		cmpi.w	#-$100,d0
		blt.s	loc_63840
		move.l	#loc_63846,(a0)
		move.w	#(2*60)-1,$2E(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l

loc_63840:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_63846:
		subq.w	#1,$2E(a0)
		bpl.s	loc_6389C
		move.l	#loc_638A2,(a0)
		bset	#7,status(a0)
		bset	#1,(_unkFAB8).w
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l
		lea	(Normal_palette).w,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToLcnt($20),d6

loc_63870:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_63870
		jsr	(AllocateObject).l
		bne.s	loc_6389C
		move.w	a1,$44(a0)
		move.l	#loc_85E64,(a1)
		move.w	#7,$3A(a1)
		st	subtype(a1)
		lea	ChildObjDat_66650(pc),a2
		jsr	(CreateChild6_Simple).l

loc_6389C:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_638A2:
		movea.w	$44(a0),a1
		btst	#5,$38(a1)
		beq.w	locret_6206C
		bset	#2,(_unkFAB8).w
		jsr	(AllocateObject).l
		bne.s	loc_638C4
		move.l	#loc_639C8,(a1)

loc_638C4:
		lea	(Pal_SSZ1).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_638D0:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_638D0
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_638DC:
		move.l	#loc_638EC,(a0)
		lea	word_66492(pc),a1
		jmp	(SetUp_ObjAttributes3).l
; ---------------------------------------------------------------------------

loc_638EC:
		lea	byte_66905(pc),a1
		jsr	(Animate_RawNoSST).l
		jsr	(Refresh_ChildPosition).l
		move.b	(V_int_run_count+3).w,d0
		andi.b	#7,d0
		bne.s	loc_63910
		lea	ChildObjDat_66664(pc),a2
		jsr	(CreateChild6_Simple).l

loc_63910:
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_63916:
		lea	word_66498(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_63946,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		jsr	(Random_Number).l
		andi.w	#$7F,d0
		subi.w	#$3F,d0
		move.w	d0,x_vel(a0)
		move.w	#-$100,y_vel(a0)

loc_63946:
		jsr	(MoveSprite2).l
		lea	byte_6690B(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6395C:
		lea	(ObjDat_BossExplosion1).l,a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#Go_Delete_Sprite,$34(a0)
		moveq	#signextendB(sfx_Explode),d0
		jsr	(Play_SFX).l
		moveq	#0,d0
		move.b	subtype(a0),d0
		lea	byte_639A2(pc,d0.w),a1
		lsr.w	#1,d0
		move.w	d0,$2E(a0)
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d0,x_pos(a0)
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d0,y_pos(a0)
		lea	(loc_639B6).l,a1
		move.l	a1,(a0)
		jmp	(a1)
; ---------------------------------------------------------------------------
byte_639A2:
		dc.b    0,   0
		dc.b    8,  -8
		dc.b   -6, -$C
		dc.b  -$A,   4
		dc.b    8,  $A
		dc.b    0, $18
		dc.b    8,-$18
		dc.b  -$C,-$20
		dc.b -$16,  -4
		dc.b  $18,   0
		even
; ---------------------------------------------------------------------------

loc_639B6:
		subq.w	#1,$2E(a0)
		bpl.w	locret_6206C
		lea	(Obj_BossExplosionAnim).l,a1
		move.l	a1,(a0)
		jmp	(a1)
; ---------------------------------------------------------------------------

loc_639C8:
		lea	(ObjDat3_919A6).l,a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_63A16,(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$110,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$60,d0
		move.w	d0,y_pos(a0)
		moveq	#signextendB(mus_EndBoss),d0
		jsr	(Play_Music).l
		lea	(ChildObjDat_919D0).l,a2
		jsr	(CreateChild1_Normal).l
		lea	(ArtKosM_EggRoboBadnik).l,a1
		move.w	#tiles_to_bytes($500),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_63A16:
		addq.w	#1,y_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$40,d0
		cmp.w	y_pos(a0),d0
		bge.s	loc_63A3A
		move.l	#loc_63A46,(a0)
		move.w	#$7F,$2E(a0)
		jsr	(Swing_Setup1).l

loc_63A3A:
		jsr	(sub_91988).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_63A46:
		subq.w	#1,$2E(a0)
		bne.s	loc_63A52
		move.w	#$400,x_vel(a0)

loc_63A52:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jsr	(sub_91988).l
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------

CutsceneKnux_LRZ2:
		cmpi.b	#2,(Player_1+character_id).w
		beq.w	CutsceneKnux_Delete
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_LRZ2_Index(pc,d0.w),d1
		jsr	CutsceneKnux_LRZ2_Index(pc,d1.w)
		bsr.w	Knuckles_Load_PLC_661E0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
CutsceneKnux_LRZ2_Index:
		dc.w loc_63A96-CutsceneKnux_LRZ2_Index
		dc.w loc_63ACA-CutsceneKnux_LRZ2_Index
		dc.w loc_63AE8-CutsceneKnux_LRZ2_Index
		dc.w loc_63B10-CutsceneKnux_LRZ2_Index
		dc.w locret_63B20-CutsceneKnux_LRZ2_Index
; ---------------------------------------------------------------------------

loc_63A96:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		bset	#0,render_flags(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#$56,mapping_frame(a0)
		move.w	#$3A38,x_pos(a0)
		move.w	#$EC,y_pos(a0)
		lea	Pal_CutsceneKnux(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_63ACA:
		btst	#1,(_unkFAB8).w
		beq.w	locret_6206C
		move.b	#4,routine(a0)
		move.b	#$DE,mapping_frame(a0)
		move.l	#loc_63AF2,$34(a0)

loc_63AE8:
		lea	byte_66891(pc),a1
		jmp	(Animate_Raw2NoSSTMultiDelay).l
; ---------------------------------------------------------------------------

loc_63AF2:
		move.b	#6,routine(a0)
		bset	#2,(_unkFAB8).w
		move.l	#loc_63B1A,$34(a0)
		lea	byte_668A7(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_63B10:
		lea	byte_668A7(pc),a1
		jmp	(Animate_Raw2NoSSTMultiDelay).l
; ---------------------------------------------------------------------------

loc_63B1A:
		move.b	#8,routine(a0)

locret_63B20:
		rts
; ---------------------------------------------------------------------------

Obj_LRZ2CutsceneKnuckles:
		cmpi.b	#2,(Player_1+character_id).w
		beq.w	CutsceneKnux_Delete
		move.l	#loc_63B40,(a0)
		jsr	(AllocateObject).l
		bne.s	loc_63B40
		move.l	#loc_863C0,(a1)

loc_63B40:
		lea	(Player_1).w,a1
		lea	word_63B94(pc),a2
		jsr	(Check_InMyRange).l
		beq.w	locret_6206C
		move.l	#loc_63B9C,(a0)
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		jsr	(AllocateObject).l
		bne.s	loc_63B72
		move.l	#Obj_CutsceneKnuckles,(a1)
		move.b	#$24,subtype(a1)

loc_63B72:
		bsr.w	sub_65DD6
		jsr	(AllocateObject).l
		bne.s	loc_63B84
		move.l	#loc_63C3E,(a1)

loc_63B84:
		lea	(ArtKosM_LRZKnuxBoulder).l,a1
		move.w	#tiles_to_bytes($500),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------
word_63B94:
		dc.w   -$10,   $10, -$240,  $240
; ---------------------------------------------------------------------------

loc_63B9C:
		lea	(Player_1).w,a1
		cmpi.w	#$39B0,x_pos(a1)
		blo.s	locret_63BBC
		move.l	#loc_63BBE,(a0)
		st	(Ctrl_1_locked).w
		jsr	(Stop_Object).l
		clr.w	(Ctrl_1_logical).w

locret_63BBC:
		rts
; ---------------------------------------------------------------------------

loc_63BBE:
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.w	locret_6206C
		move.l	#loc_63BF4,(a0)
		bset	#0,(_unkFAB8).w
		move.w	#0,(Camera_min_X_pos).w
		st	(Scroll_lock).w
		clr.b	(Ctrl_1_locked).w
		move.b	#$81,object_control(a1)
		move.b	#7,anim(a1)
		rts
; ---------------------------------------------------------------------------

loc_63BF4:
		move.w	(Camera_Y_pos).w,d0
		subq.w	#2,d0
		move.w	d0,(Camera_Y_pos).w
		cmpi.w	#$90,d0
		bhi.w	locret_6206C
		move.l	#loc_63C14,(a0)
		bset	#1,(_unkFAB8).w
		rts
; ---------------------------------------------------------------------------

loc_63C14:
		cmpi.w	#$4C0,(Player_1+y_pos).w
		blo.w	locret_6206C
		st	(Act3_flag).w
		move.w	(Ring_count).w,(Act3_ring_count).w
		move.l	(Timer).w,(Act3_timer).w
		move.b	(Player_1+status_secondary).w,(Saved2_status_secondary).w
		move.w	#$1600,d0
		jmp	(StartNewLevel).l
; ---------------------------------------------------------------------------

loc_63C3E:
		lea	ObjDat3_6647A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_63C66,(a0)
		move.w	#$3A08,x_pos(a0)
		move.w	#$E2,y_pos(a0)
		move.b	#$1F,y_radius(a0)
		move.w	a0,$46(a0)
		rts
; ---------------------------------------------------------------------------

loc_63C66:
		btst	#2,(_unkFAB8).w
		beq.s	loc_63C7A
		move.l	#loc_63C80,(a0)
		move.w	#-$200,x_vel(a0)

loc_63C7A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_63C80:
		moveq	#signextendB(sfx_PushBlock),d0
		jsr	(Play_SFX_Continuous).l
		bsr.w	sub_65ED4
		bsr.w	sub_65EFE
		jsr	(MoveSprite2).l
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_63CA6
		move.l	#loc_63CAC,(a0)

loc_63CA6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_63CAC:
		moveq	#signextendB(sfx_PushBlock),d0
		jsr	(Play_SFX_Continuous).l
		bsr.w	sub_65ED4
		bsr.w	sub_65EFE
		jsr	(MoveSprite_LightGravity).l
		tst.w	y_vel(a0)
		bmi.s	loc_63CE6
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	loc_63CE6
		move.w	#-$100,y_vel(a0)
		move.w	#$14,(Screen_shake_flag).w
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l

loc_63CE6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
word_63CEC:
		dc.w   $180,  $480,  $FE0, $11E0
		dc.w   $380,  $380, $10E0, $10E0
; ---------------------------------------------------------------------------

CutsceneKnux_HPZ:
		movea.l	a0,a1
		move.l	#loc_63D1A,(a1)
		lea	(Dynamic_object_RAM+(object_size*45)).w,a2
		move.w	a2,(_unkFAA4).w
		moveq	#bytesToWcnt(object_size),d0

loc_63D0E:
		move.w	(a1)+,(a2)+
		dbf	d0,loc_63D0E
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_63D1A:
		cmpi.b	#2,(Player_1+character_id).w
		beq.w	CutsceneKnux_Delete
		lea	word_63CEC(pc),a1
		jsr	(Check_CameraInRange).l
		jsr	(sub_85D6A).l
		jsr	(AllocateObject).l
		bne.s	loc_63D5C
		move.l	#loc_85CA4,(a1)
		move.l	#loc_63DD4,$34(a1)
		move.b	#mus_Knuckles,$26(a1)
		move.w	#2*60,$2E(a1)
		move.b	$27(a0),$27(a1)

loc_63D5C:
		move.l	#loc_63DE0,(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.w	#make_art_tile(ArtTile_CutsceneKnux,1,0),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#$13,y_radius(a0)
		move.b	#9,x_radius(a0)
		move.b	#4,render_flags(a0)
		bset	#0,render_flags(a0)
		move.b	#$D8,mapping_frame(a0)
		move.b	#8,collision_property(a0)
		move.l	#byte_66771,$30(a0)
		clr.w	$44(a0)
		lea	(Normal_palette_line_2).w,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_63DBC:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_63DBC
		lea	Pal_CutsceneKnux(pc),a1
		jsr	(PalLoad_Line1).l
		move.w	#$88,(Normal_palette_line_2+$C).w
		rts
; ---------------------------------------------------------------------------

loc_63DD4:
		bset	#0,(_unkFAB8).w
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_63DE0:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_63E1E(pc,d0.w),d1
		jsr	off_63E1E(pc,d1.w)
		move.w	$44(a0),d0
		move.w	off_63E00(pc,d0.w),d0
		jsr	off_63E00(pc,d0.w)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_63E00:
		dc.w loc_63E06-off_63E00
		dc.w loc_63E0A-off_63E00
		dc.w loc_63E14-off_63E00
; ---------------------------------------------------------------------------

loc_63E06:
		bra.w	Knuckles_Load_PLC_661E0
; ---------------------------------------------------------------------------

loc_63E0A:
		lea	DPLCPtr_HPZKnucklesGrab(pc),a2
		jmp	(Perform_DPLC).l
; ---------------------------------------------------------------------------

loc_63E14:
		lea	DPLCPtr_SSZKnucklesTired(pc),a2
		jmp	(Perform_DPLC).l
; ---------------------------------------------------------------------------
off_63E1E:
		dc.w loc_63E7C-off_63E1E
		dc.w loc_63EDA-off_63E1E
		dc.w loc_63F3C-off_63E1E
		dc.w loc_63FD8-off_63E1E
		dc.w loc_64016-off_63E1E
		dc.w loc_6403A-off_63E1E
		dc.w loc_64090-off_63E1E
		dc.w loc_64102-off_63E1E
		dc.w loc_6414C-off_63E1E
		dc.w loc_64184-off_63E1E
		dc.w loc_641EC-off_63E1E
		dc.w loc_64258-off_63E1E
		dc.w loc_642F0-off_63E1E
		dc.w loc_64350-off_63E1E
		dc.w loc_6438A-off_63E1E
		dc.w loc_643BE-off_63E1E
		dc.w loc_643EA-off_63E1E
		dc.w loc_64422-off_63E1E
		dc.w loc_64460-off_63E1E
		dc.w loc_6451E-off_63E1E
		dc.w loc_64574-off_63E1E
		dc.w loc_64594-off_63E1E
		dc.w loc_645D4-off_63E1E
		dc.w loc_64610-off_63E1E
		dc.w loc_64668-off_63E1E
		dc.w loc_64692-off_63E1E
		dc.w loc_646F6-off_63E1E
		dc.w loc_64758-off_63E1E
		dc.w loc_647C6-off_63E1E
		dc.w loc_6480A-off_63E1E
		dc.w loc_64846-off_63E1E
		dc.w loc_6487C-off_63E1E
		dc.w loc_648B2-off_63E1E
		dc.w loc_648E2-off_63E1E
		dc.w loc_648F2-off_63E1E
		dc.w loc_64952-off_63E1E
		dc.w loc_64984-off_63E1E
		dc.w loc_649AE-off_63E1E
		dc.w loc_649D6-off_63E1E
		dc.w loc_64A00-off_63E1E
		dc.w loc_64A36-off_63E1E
		dc.w loc_64A6E-off_63E1E
		dc.w loc_64AC0-off_63E1E
		dc.w loc_64B10-off_63E1E
		dc.w loc_64B6A-off_63E1E
		dc.w loc_64BB8-off_63E1E
		dc.w loc_64BFA-off_63E1E
; ---------------------------------------------------------------------------

loc_63E7C:
		jsr	(Animate_Raw2MultiDelay).l
		tst.w	d2
		bpl.s	loc_63EA0
		btst	#0,(_unkFAB8).w
		beq.s	loc_63EA0
		move.b	$39(a0),d0
		addq.b	#1,d0
		cmpi.b	#2,d0
		bhs.w	loc_641C4
		move.b	d0,$39(a0)

loc_63EA0:
		jsr	(Find_SonicTails).l
		bsr.w	sub_66094
		cmpi.w	#$40,d3
		bhs.w	locret_6206C
		cmpi.w	#$30,d2
		bhs.w	locret_6206C
		bra.w	loc_63F20
; ---------------------------------------------------------------------------

loc_63EBE:
		move.b	#0,routine(a0)
		clr.b	$39(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		lea	byte_66771(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_63EDA:
		jsr	(Animate_RawCheckResult).l
		jsr	(Find_SonicTails).l
		bsr.w	sub_66094
		cmpi.w	#$10,d3
		bhs.s	loc_63F00
		cmpi.w	#$20,d2
		bhs.s	loc_63F00
		cmpi.b	#2,anim(a1)
		bne.w	loc_63FF8

loc_63F00:
		subq.w	#1,$2E(a0)
		bmi.w	loc_64066
		lea	off_63F10(pc),a3
		bra.w	loc_660BE
; ---------------------------------------------------------------------------
off_63F10:
		dc.l loc_63F7A
		dc.l loc_63FF8
		dc.l loc_6429E
		dc.l loc_660A6
; ---------------------------------------------------------------------------

loc_63F20:
		move.b	#2,routine(a0)
		move.b	#$DA,mapping_frame(a0)
		move.w	#(2*60)-1,$2E(a0)
		lea	byte_667AD(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_63F3C:
		jsr	(sub_6615A).l
		move.w	x_vel(a0),d0
		beq.s	loc_63F58
		move.w	$40(a0),d1
		add.w	d1,d0
		move.w	d0,x_vel(a0)
		jsr	(MoveSprite2).l

loc_63F58:
		jsr	(Animate_Raw2MultiDelay).l
		bmi.w	locret_6206C
		lea	off_63F6A(pc),a3
		bra.w	loc_660BE
; ---------------------------------------------------------------------------
off_63F6A:
		dc.l loc_63F7A
		dc.l loc_660A6
		dc.l loc_6429E
		dc.l loc_660A6
; ---------------------------------------------------------------------------

loc_63F7A:
		move.b	#4,routine(a0)
		move.l	#loc_63EBE,$34(a0)
		move.w	#$2C0,d3
		move.w	#-$20,d4
		btst	#0,render_flags(a0)
		bne.s	loc_63F9C
		neg.w	d3
		neg.w	d4

loc_63F9C:
		move.w	d3,x_vel(a0)
		move.w	d4,$40(a0)
		move.w	x_vel(a1),d0
		move.w	#$100,d1
		move.w	#-$100,d2
		cmp.w	d2,d0
		blt.s	loc_63FC0
		cmp.w	d1,d0
		bge.s	loc_63FC0
		tst.w	d0
		bpl.s	loc_63FBE
		move.w	d2,d1

loc_63FBE:
		move.w	d1,d0

loc_63FC0:
		neg.w	d0
		move.w	d0,x_vel(a1)
		neg.w	y_vel(a1)
		neg.w	ground_vel(a1)
		lea	byte_667B4(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_63FD8:
		subq.w	#1,$2E(a0)
		bmi.w	loc_63EBE
		lea	off_63FE8(pc),a3
		bra.w	loc_660BE
; ---------------------------------------------------------------------------
off_63FE8:
		dc.l loc_660A6
		dc.l loc_660A6
		dc.l loc_6429E
		dc.l loc_660A6
; ---------------------------------------------------------------------------

loc_63FF8:
		tst.b	$34(a1)
		bne.w	locret_6206C
		move.b	#6,routine(a0)
		move.b	#$DE,mapping_frame(a0)
		move.w	#7,$2E(a0)
		bra.w	loc_660AE
; ---------------------------------------------------------------------------

loc_64016:
		jmp	(Animate_RawCheckResult).l
; ---------------------------------------------------------------------------

loc_6401C:
		move.b	#$A,routine(a0)
		move.w	#-$600,y_vel(a0)
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l
		lea	byte_667C1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_6403A:
		jsr	(Animate_RawCheckResult).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bpl.w	loc_640DC
		lea	off_64056(pc),a3
		bra.w	loc_660BE
; ---------------------------------------------------------------------------
off_64056:
		dc.l loc_660A6
		dc.l loc_660A6
		dc.l loc_660A6
		dc.l loc_660A6
; ---------------------------------------------------------------------------

loc_64066:
		move.b	#8,routine(a0)
		jsr	(Find_SonicTails).l
		bsr.w	sub_66094
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.l	#loc_6401C,$34(a0)
		lea	byte_667CC(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64090:
		jsr	(sub_6615A).l
		jsr	(MoveSprite2).l
		tst.w	x_vel(a0)
		beq.w	loc_64132
		jsr	(Find_SonicTails).l
		cmpi.w	#$30,d2
		blo.s	loc_640C4
		btst	#0,render_flags(a0)
		sne	d4
		tst.w	d0
		beq.s	loc_640BE
		not.b	d4

loc_640BE:
		tst.b	d4
		beq.w	loc_64132

loc_640C4:
		lea	off_640CC(pc),a3
		bra.w	loc_660BE
; ---------------------------------------------------------------------------
off_640CC:
		dc.l loc_660A6
		dc.l loc_660A6
		dc.l loc_6429E
		dc.l loc_660A6
; ---------------------------------------------------------------------------

loc_640DC:
		move.b	#$C,routine(a0)
		move.b	#$C0,mapping_frame(a0)
		move.w	#$400,d0
		btst	#0,render_flags(a0)
		beq.s	loc_640F6
		neg.w	d0

loc_640F6:
		move.w	d0,x_vel(a0)
		move.w	#$80,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_64102:
		jsr	(Animate_Raw2MultiDelay).l
		jsr	(MoveSprite).l
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.w	loc_64164
		lea	off_64122(pc),a3
		bra.w	loc_660BE
; ---------------------------------------------------------------------------
off_64122:
		dc.l loc_6429E
		dc.l loc_660A6
		dc.l loc_6429E
		dc.l loc_660A6
; ---------------------------------------------------------------------------

loc_64132:
		move.b	#$E,routine(a0)
		bchg	#0,render_flags(a0)
		clr.w	x_vel(a0)
		lea	byte_667D4(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_6414C:
		jsr	(Animate_RawCheckResult).l
		jsr	(Find_SonicTails).l
		bsr.w	sub_66094
		lea	off_63F10(pc),a3
		bra.w	loc_660BE
; ---------------------------------------------------------------------------

loc_64164:
		add.w	d1,y_pos(a0)
		move.b	#$10,routine(a0)
		clr.w	y_vel(a0)
		move.l	#loc_63EBE,$34(a0)
		lea	byte_667E0(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64184:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$F,d0
		bne.s	loc_64196
		moveq	#signextendB(sfx_Roll),d0
		jsr	(Play_SFX).l

loc_64196:
		jsr	(Animate_RawCheckResult).l
		subq.w	#1,$2E(a0)
		bmi.w	loc_64222
		cmpi.w	#43,$2E(a0)
		bne.s	loc_641BC
		bclr	#0,$38(a0)
		lea	ChildObjDat_665FC(pc),a2
		jsr	(CreateChild6_Simple).l

loc_641BC:
		lea	off_64056(pc),a3
		bra.w	loc_660BE
; ---------------------------------------------------------------------------

loc_641C4:
		move.b	#$12,routine(a0)
		jsr	(Find_SonicTails).l
		bsr.w	sub_66094
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#60-1,$2E(a0)
		lea	byte_667F5(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_641EC:
		jsr	(Animate_RawCheckResult).l
		jsr	(sub_6615A).l
		tst.w	x_vel(a0)
		bne.s	loc_6420C
		bchg	#0,render_flags(a0)
		subq.w	#4,y_pos(a0)
		bra.w	loc_63EBE
; ---------------------------------------------------------------------------

loc_6420C:
		move.w	$40(a0),d0
		add.w	d0,x_vel(a0)
		jsr	(MoveSprite2).l
		lea	off_64056(pc),a3
		bra.w	loc_660BE
; ---------------------------------------------------------------------------

loc_64222:
		move.b	#$14,routine(a0)
		bset	#0,$38(a0)
		move.w	#$800,d0
		move.w	#-$10,d1
		btst	#0,render_flags(a0)
		beq.s	loc_64242
		neg.w	d0
		neg.w	d1

loc_64242:
		move.w	d0,x_vel(a0)
		move.w	d1,$40(a0)
		addq.w	#4,y_pos(a0)
		lea	byte_667C1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64258:
		jsr	(Animate_RawCheckResult).l
		jsr	(sub_6615A).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.w	locret_6206C
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.w	locret_6206C
		add.w	d1,y_pos(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		sub.w	x_pos(a0),d0
		bpl.s	loc_64292
		neg.w	d0

loc_64292:
		cmpi.w	#$60,d0
		blo.w	loc_641C4
		bra.w	loc_64066
; ---------------------------------------------------------------------------

loc_6429E:
		bset	#0,$38(a0)
		moveq	#signextendB(sfx_FloorThump),d0
		jsr	(Play_SFX).l
		move.w	#$300,d3
		move.w	x_pos(a1),d1
		sub.w	x_pos(a0),d1
		bcs.s	loc_642BC
		neg.w	d3

loc_642BC:
		move.w	d3,x_vel(a0)
		move.w	#-$300,y_vel(a0)
		subq.b	#1,collision_property(a0)
		beq.s	loc_64310
		move.b	#$16,routine(a0)
		move.w	#0,$44(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#$8D,mapping_frame(a0)
		lea	byte_667BC(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_642F0:
		jsr	(sub_6615A).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.w	locret_6206C
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_64356
		rts
; ---------------------------------------------------------------------------

loc_64310:
		move.b	#$18,routine(a0)
		clr.b	(Update_HUD_timer).w
		move.w	#2,$44(a0)
		move.l	#Map_HPZKnucklesGrab,mappings(a0)
		move.b	#2,mapping_frame(a0)
		bset	#4,$38(a0)
		move.b	#mus_LRZ2,(Current_music+1).w
		jsr	(AllocateObject).l
		bne.s	locret_6434E
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_LRZ2,subtype(a1)

locret_6434E:
		rts
; ---------------------------------------------------------------------------

loc_64350:
		jmp	(Animate_Raw2MultiDelay).l
; ---------------------------------------------------------------------------

loc_64356:
		add.w	d1,y_pos(a0)
		move.b	#$1A,routine(a0)
		move.l	#loc_643A4,$34(a0)
		moveq	#signextendB(sfx_DoorMove),d0
		jsr	(Play_SFX).l
		lea	byte_6680A(pc),a1
		jsr	(Set_Raw_Animation).l
		lea	(ArtKosM_HPZKnuxDizzy).l,a1
		move.w	#tiles_to_bytes($500),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_6438A:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$1F,d0
		bne.s	loc_6439C
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l

loc_6439C:
		subq.w	#1,$2E(a0)
		bmi.s	loc_643C6
		rts
; ---------------------------------------------------------------------------

loc_643A4:
		move.b	#$1C,routine(a0)
		move.w	#$7F,$2E(a0)
		st	(Screen_shake_flag).w
		lea	ChildObjDat_66602(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_643BE:
		subq.w	#1,$2E(a0)
		bmi.s	loc_643F2
		rts
; ---------------------------------------------------------------------------

loc_643C6:
		move.b	#$1E,routine(a0)
		move.b	#6,mapping_frame(a0)
		move.w	#$F,$2E(a0)
		lea	ChildObjDat_66644(pc),a2
		jsr	(CreateChild6_Simple).l
		bne.s	locret_643E8
		st	subtype(a1)

locret_643E8:
		rts
; ---------------------------------------------------------------------------

loc_643EA:
		subq.w	#1,$2E(a0)
		bmi.s	loc_64450
		rts
; ---------------------------------------------------------------------------

loc_643F2:
		move.b	#$20,routine(a0)
		move.w	#0,$44(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#$56,mapping_frame(a0)
		bclr	#0,render_flags(a0)
		move.w	#7,$2E(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_64422:
		jsr	(Animate_RawCheckResult).l
		move.w	x_vel(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$400,d0
		bhs.s	loc_6443A
		move.w	d0,x_vel(a0)

loc_6443A:
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$180,d0
		cmp.w	x_pos(a0),d0
		blo.s	loc_64472
		rts
; ---------------------------------------------------------------------------

loc_64450:
		move.b	#$22,routine(a0)
		lea	byte_66824(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64460:
		jsr	(Animate_RawCheckResult).l
		btst	#0,(_unkFAB8).w
		bne.w	loc_6453C
		rts
; ---------------------------------------------------------------------------

loc_64472:
		move.b	#$24,routine(a0)
		move.w	#2,$44(a0)
		move.l	#Map_HPZKnucklesGrab,mappings(a0)
		move.b	#$A,mapping_frame(a0)
		lea	byte_6687B(pc),a1
		jsr	(Set_Raw_Animation).l
		bset	#7,art_tile(a0)
		move.w	#$1620,x_pos(a0)
		move.w	#$3AC,y_pos(a0)
		clr.b	(_unkFAB8).w
		clr.w	(Screen_shake_flag).w
		jsr	(AllocateObject).l
		bne.s	loc_644BE
		move.l	#loc_64C70,(a1)

loc_644BE:
		jsr	(AllocateObject).l
		bne.s	loc_644CC
		move.l	#loc_64E88,(a1)

loc_644CC:
		jsr	(AllocateObject).l
		bne.s	loc_644DA
		move.l	#Obj_IncLevEndXGradual,(a1)


loc_644DA:
		jsr	(AllocateObject).l
		bne.s	loc_644E8
		move.l	#Obj_DecLevStartYGradual,(a1)

loc_644E8:
		move.w	(Camera_stored_max_Y_pos).w,(Camera_target_max_Y_pos).w
		jsr	(AllocateObject).l
		bne.s	loc_644FC
		move.l	#Obj_IncLevEndYGradual,(a1)

loc_644FC:
		lea	(ArtKosM_KnuxFinalBossCrane).l,a1
		move.w	#tiles_to_bytes($4A7),d2
		jsr	(Queue_Kos_Module).l
		lea	PLC_KnuxHPZCutsceneShip(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------
PLC_KnuxHPZCutsceneShip: plrlistheader
		plreq $52E, ArtNem_RobotnikShip
PLC_KnuxHPZCutsceneShip_End
; ---------------------------------------------------------------------------

loc_6451E:
		jsr	(Animate_RawCheckResult).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	locret_6453A
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_6457C

locret_6453A:
		rts
; ---------------------------------------------------------------------------

loc_6453C:
		move.b	#$26,routine(a0)
		move.w	#0,$44(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#$9A,mapping_frame(a0)
		move.w	#$C0,x_vel(a0)
		move.w	#-$600,y_vel(a0)
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l
		lea	byte_667C1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64574:
		subq.w	#1,$2E(a0)
		bmi.s	loc_645B0
		rts
; ---------------------------------------------------------------------------

loc_6457C:
		add.w	d1,y_pos(a0)
		move.b	#$28,routine(a0)
		move.b	#$D6,mapping_frame(a0)
		move.w	#8,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_64594:
		jsr	(Animate_RawCheckResult).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	locret_645AE
		cmpi.w	#$339,y_pos(a0)
		bhs.s	loc_645E0

locret_645AE:
		rts
; ---------------------------------------------------------------------------

loc_645B0:
		move.b	#$2A,routine(a0)
		move.w	#-$C0,x_vel(a0)
		move.w	#-$500,y_vel(a0)
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l
		lea	byte_667C1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_645D4:
		subq.w	#1,$2E(a0)
		bmi.s	loc_6463C
		jmp	(Animate_RawCheckResult).l
; ---------------------------------------------------------------------------

loc_645E0:
		move.b	#$2C,routine(a0)
		move.w	#$339,y_pos(a0)
		move.w	#2,$44(a0)
		move.l	#Map_HPZKnucklesGrab,mappings(a0)
		move.b	#$A,mapping_frame(a0)
		move.w	#$7F,$2E(a0)
		lea	byte_66880(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64610:
		jsr	(Animate_RawCheckResult).l
		move.w	x_vel(a0),d0
		addi.w	#$C,d0
		cmpi.w	#$300,d0
		bls.s	loc_64628
		move.w	#$300,d0

loc_64628:
		move.w	d0,x_vel(a0)
		jsr	(MoveSprite2).l
		cmpi.w	#$1660,x_pos(a0)
		bhs.s	loc_64670
		rts
; ---------------------------------------------------------------------------

loc_6463C:
		move.b	#$2E,routine(a0)
		move.w	#0,$44(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#7,mapping_frame(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		lea	byte_6682F(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64668:
		subq.w	#1,$2E(a0)
		bmi.s	loc_646B8
		rts
; ---------------------------------------------------------------------------

loc_64670:
		move.b	#$30,routine(a0)
		move.w	#2,$44(a0)
		move.l	#Map_HPZKnucklesGrab,mappings(a0)
		move.b	#$D,mapping_frame(a0)
		move.w	#30-1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_64692:
		jsr	(Animate_RawCheckResult).l
		jsr	(MoveSprite).l
		movea.w	(_unkFAAE).w,a1
		lea	word_646B0(pc),a2
		jsr	(Check_InTheirRange).l
		bne.s	loc_6471A
		rts
; ---------------------------------------------------------------------------
word_646B0:
		dc.w   -$20,   $40,  -$20,   $40
; ---------------------------------------------------------------------------

loc_646B8:
		move.b	#$32,routine(a0)
		bset	#1,(_unkFAB8).w
		move.w	#0,$44(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#$9A,mapping_frame(a0)
		move.w	#$300,x_vel(a0)
		move.w	#-$500,y_vel(a0)
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l
		lea	byte_667C1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_646F6:
		jsr	(Animate_RawCheckResult).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	locret_64710
		cmpi.w	#$3AB,y_pos(a0)
		bhs.s	loc_6478E

locret_64710:
		rts
; ---------------------------------------------------------------------------
		dc.w   -$20,   $40,  -$20,   $40
; ---------------------------------------------------------------------------

loc_6471A:
		bset	#6,status(a1)
		move.b	#$34,routine(a0)
		move.w	#0,$44(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#$9A,mapping_frame(a0)
		move.w	#-$200,x_vel(a0)
		move.w	#-$200,y_vel(a0)
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l
		lea	byte_667C1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64758:
		jsr	(Animate_RawCheckResult).l
		move.w	x_vel(a0),d0
		addi.w	#$C,d0
		cmpi.w	#$300,d0
		bls.s	loc_64770
		move.w	#$300,d0

loc_64770:
		move.w	d0,x_vel(a0)
		jsr	(MoveSprite2).l
		movea.w	(_unkFABA).w,a1
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		cmpi.w	#$30,d0
		blo.s	loc_647EC
		rts
; ---------------------------------------------------------------------------

loc_6478E:
		move.w	#$3AB,y_pos(a0)
		move.b	#$36,routine(a0)
		bclr	#7,art_tile(a0)
		move.w	#0,$44(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#7,mapping_frame(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		lea	byte_6682F(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_647C6:
		jsr	(Animate_RawCheckResult).l
		jsr	(MoveSprite).l
		movea.w	(_unkFABA).w,a1
		lea	word_647E4(pc),a2
		jsr	(Check_InTheirRange).l
		bne.s	loc_6482A
		rts
; ---------------------------------------------------------------------------
word_647E4:
		dc.w   -$10,   $60,     0,   $10
; ---------------------------------------------------------------------------

loc_647EC:
		move.b	#$38,routine(a0)
		move.w	#-$600,y_vel(a0)
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l
		lea	byte_667C1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_6480A:
		btst	#4,(_unkFAB8).w
		bne.s	loc_6486E

loc_64812:
		movea.w	(_unkFABA).w,a1
		move.w	x_pos(a1),d0
		subi.w	#$C,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_6482A:
		move.b	#$3A,routine(a0)
		move.w	#2,$44(a0)
		move.l	#Map_HPZKnucklesGrab,mappings(a0)
		move.b	#0,mapping_frame(a0)
		bra.s	loc_64812
; ---------------------------------------------------------------------------

loc_64846:
		subq.w	#1,$2E(a0)
		bmi.s	loc_6489E
		moveq	#0,d0
		move.b	(V_int_run_count+3).w,d1
		btst	#0,d1
		beq.s	loc_6485A
		moveq	#1,d0

loc_6485A:
		move.b	d0,mapping_frame(a0)
		andi.b	#3,d1
		beq.s	loc_6486C
		moveq	#signextendB(sfx_GravityMachine),d0
		jsr	(Play_SFX).l

loc_6486C:
		bra.s	loc_64812
; ---------------------------------------------------------------------------

loc_6486E:
		move.b	#$3C,routine(a0)
		move.w	#60-1,$2E(a0)
		bra.s	loc_64812
; ---------------------------------------------------------------------------

loc_6487C:
		moveq	#0,d0
		btst	#0,(V_int_run_count+3).w
		beq.s	loc_64888
		moveq	#1,d0

loc_64888:
		move.b	d0,mapping_frame(a0)
		jsr	(MoveSprite_LightGravity).l
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_648B8
		rts
; ---------------------------------------------------------------------------

loc_6489E:
		move.b	#$3E,routine(a0)
		move.w	#-$100,x_vel(a0)
		move.w	#-$100,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_648B2:
		jmp	(Animate_Raw2MultiDelay).l
; ---------------------------------------------------------------------------

loc_648B8:
		add.w	d1,y_pos(a0)
		move.b	#$40,routine(a0)
		bset	#5,(_unkFAB8).w
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.l	#loc_648EA,$34(a0)
		lea	byte_667E7(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_648E2:
		tst.b	(_unkFAAC).w
		bne.s	loc_648FA
		rts
; ---------------------------------------------------------------------------

loc_648EA:
		move.b	#$42,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_648F2:
		subq.w	#1,$2E(a0)
		bmi.s	loc_64964
		rts
; ---------------------------------------------------------------------------

loc_648FA:
		move.b	#$44,routine(a0)
		move.w	#$10,$2E(a0)
		clr.b	(Scroll_lock).w
		move.w	#$5C0,d0
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	d0,(Camera_stored_max_Y_pos).w
		moveq	#signextendB(sfx_BigRumble),d0
		jsr	(Play_SFX).l
		jsr	(AllocateObject).l
		bne.s	loc_6492C
		move.l	#Obj_IncLevEndYGradual,(a1)

loc_6492C:
		bsr.w	loc_64930

loc_64930:
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	locret_64950
		move.b	#$14,subtype(a1)
		move.w	#$1880,x_pos(a1)
		move.w	#$3D0,y_pos(a1)

locret_64950:
		rts
; ---------------------------------------------------------------------------

loc_64952:
		jsr	(MoveSprite).l
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_6498A
		rts
; ---------------------------------------------------------------------------

loc_64964:
		move.b	#$46,routine(a0)
		move.b	#2,mapping_frame(a0)
		st	(Events_fg_4).w
		move.w	#$14,(Screen_shake_flag).w
		lea	ChildObjDat_6663E(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_64984:
		jmp	(Animate_Raw2MultiDelay).l
; ---------------------------------------------------------------------------

loc_6498A:
		add.w	d1,y_pos(a0)
		move.b	#$48,routine(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.l	#loc_649B4,$34(a0)
		lea	byte_6680A(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_649AE:
		jmp	(Animate_Raw2MultiDelay).l
; ---------------------------------------------------------------------------

loc_649B4:
		move.b	#$4A,routine(a0)
		move.l	#loc_649DE,$34(a0)
		lea	byte_6684F(pc),a1
		jsr	(Set_Raw_Animation).l
		lea	ChildObjDat_66644(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_649D6:
		subq.w	#1,$2E(a0)
		bmi.s	loc_64A1C
		rts
; ---------------------------------------------------------------------------

loc_649DE:
		move.b	#$4C,routine(a0)
		move.w	#0,$44(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#$56,mapping_frame(a0)
		move.w	#7,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_64A00:
		jsr	(Animate_RawCheckResult).l
		subi.w	#$C,x_vel(a0)
		jsr	(MoveSprite2).l
		cmpi.w	#$1810,x_pos(a0)
		bls.s	loc_64A3C
		rts
; ---------------------------------------------------------------------------

loc_64A1C:
		move.b	#$4E,routine(a0)
		bset	#0,render_flags(a0)
		clr.w	x_vel(a0)
		lea	byte_6682F(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64A36:
		jmp	(Animate_Raw2MultiDelay).l
; ---------------------------------------------------------------------------

loc_64A3C:
		move.b	#$50,routine(a0)
		bclr	#0,render_flags(a0)
		move.w	#2,$44(a0)
		move.l	#Map_HPZKnucklesGrab,mappings(a0)
		move.b	#$E,mapping_frame(a0)
		move.l	#loc_64A8E,$34(a0)
		lea	byte_668AF(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64A6E:
		jsr	(Animate_Raw2MultiDelay).l
		beq.s	locret_64A8C
		cmpi.b	#6,anim_frame(a0)
		bne.w	locret_64A8C
		st	(_unkFAA2).w
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l

locret_64A8C:
		rts
; ---------------------------------------------------------------------------

loc_64A8E:
		move.b	#$52,routine(a0)
		bset	#0,render_flags(a0)
		move.l	#loc_64AE2,$34(a0)
		move.w	#0,$44(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#$56,mapping_frame(a0)
		lea	byte_66885(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64AC0:
		jsr	(Animate_RawCheckResult).l
		subi.w	#$C,x_vel(a0)
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		subi.w	#$40,d0
		cmp.w	x_pos(a0),d0
		bhs.s	loc_64B22
		rts
; ---------------------------------------------------------------------------

loc_64AE2:
		move.b	#$54,routine(a0)
		bset	#0,render_flags(a0)
		move.w	#0,$44(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#7,mapping_frame(a0)
		clr.w	x_vel(a0)
		lea	byte_6682F(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64B10:
		jsr	(Animate_RawMultiDelay).l
		btst	#6,(_unkFAB8).w
		bne.w	loc_64B80
		rts
; ---------------------------------------------------------------------------

loc_64B22:
		move.b	#$56,routine(a0)
		move.w	#4,$44(a0)
		move.l	#Map_SSZKnucklesTired,mappings(a0)
		clr.b	mapping_frame(a0)
		bclr	#0,render_flags(a0)
		move.w	#$161C,x_pos(a0)
		move.w	#$62C,y_pos(a0)
		move.w	#$1520,(Camera_stored_min_X_pos).w
		jsr	(AllocateObject).l
		bne.s	loc_64B60
		move.l	#Obj_DecLevStartXGradual,(a1)

loc_64B60:
		lea	byte_6671F(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64B6A:
		jsr	(Animate_RawCheckResult).l
		jsr	(MoveSprite).l
		cmpi.w	#$15C0,x_pos(a0)
		bls.s	loc_64BC6
		rts
; ---------------------------------------------------------------------------

loc_64B80:
		move.b	#$58,routine(a0)
		move.w	#0,$44(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#$9A,mapping_frame(a0)
		move.w	#-$1E0,x_vel(a0)
		move.w	#-$600,y_vel(a0)
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l
		lea	byte_667C1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64BB8:
		btst	#7,(_unkFAB8).w
		bne.s	loc_64C00
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_64BC6:
		move.b	#$5A,routine(a0)
		move.w	#$15C0,x_pos(a0)
		move.w	#$600,y_pos(a0)
		move.w	#4,$44(a0)
		move.l	#Map_SSZKnucklesTired,mappings(a0)
		clr.b	mapping_frame(a0)
		bclr	#0,render_flags(a0)
		lea	byte_6671F(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64BFA:
		jmp	(Animate_RawCheckResult).l
; ---------------------------------------------------------------------------

loc_64C00:
		move.b	#$5C,routine(a0)
		move.w	#0,$44(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#$9A,mapping_frame(a0)
		lea	byte_667C1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_64C24:
		lea	ObjDat3_664E2(pc),a1
		jsr	(SetUp_ObjAttributes).l
		movea.w	parent3(a0),a1
		btst	#0,$38(a1)
		bne.w	CutsceneKnux_Delete
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		bclr	#0,render_flags(a0)
		btst	#0,render_flags(a1)
		beq.s	loc_64C5C
		bset	#0,render_flags(a0)

loc_64C5C:
		lea	byte_6683A(pc),a1
		jsr	(Animate_RawNoSST).l
		bsr.w	sub_66236
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_64C70:
		lea	(Player_1).w,a1
		cmpi.w	#$14D0,x_pos(a1)
		blo.s	locret_64CA4
		move.l	#loc_64CA6,(a0)
		jsr	(Stop_Object).l
		st	(Ctrl_1_locked).w
		clr.w	(Ctrl_1_logical).w
		jsr	(AllocateObject).l
		bne.s	loc_64C9E
		move.l	#loc_863C0,(a1)

loc_64C9E:
		move.w	#$300,(Camera_target_max_Y_pos).w

locret_64CA4:
		rts
; ---------------------------------------------------------------------------

loc_64CA6:
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.w	locret_6206C
		move.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_1_logical).w
		cmpi.w	#$15A8,x_pos(a1)
		blo.w	locret_6206C
		move.l	#loc_64D1A,(a0)
		st	(Scroll_lock).w
		jsr	(AllocateObject).l
		bne.s	loc_64CE2
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_Miniboss,subtype(a1)

loc_64CE2:
		lea	(Player_1).w,a1
		clr.b	(Ctrl_1_locked).w
		move.b	#$83,object_control(a1)
		move.b	#$C4,mapping_frame(a1)
		cmpi.b	#1,character_id(a1)
		bne.s	loc_64D04
		move.b	#$B0,mapping_frame(a1)

loc_64D04:
		move.b	#7,anim(a1)
		clr.w	(Ctrl_1_logical).w
		jsr	(Stop_Object).l
		jmp	(Player_Load_PLC).l
; ---------------------------------------------------------------------------

loc_64D1A:
		move.w	(Camera_X_pos).w,d0
		addq.w	#2,d0
		move.w	d0,(Camera_X_pos).w
		cmpi.w	#$1580,d0
		blo.s	locret_64D36
		move.l	#loc_64D38,(a0)
		bset	#0,(_unkFAB8).w

locret_64D36:
		rts
; ---------------------------------------------------------------------------

loc_64D38:
		btst	#1,(_unkFAB8).w
		beq.s	locret_64D5A
		move.l	#loc_64D5C,(a0)
		lea	(Player_1).w,a1
		move.b	#0,object_control(a1)
		st	(Ctrl_1_locked).w
		move.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_1_logical).w

locret_64D5A:
		rts
; ---------------------------------------------------------------------------

loc_64D5C:
		lea	(Player_1).w,a1
		move.w	x_vel(a1),d0
		cmpi.w	#$300,d0
		bls.s	loc_64D6E
		move.w	#$300,d0

loc_64D6E:
		move.w	d0,x_vel(a1)
		move.w	d0,ground_vel(a1)
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,(Camera_X_pos).w
		move.w	#$17D0,d0
		cmp.w	(Camera_X_pos).w,d0
		bhi.s	locret_64DA8
		move.l	#loc_64DAA,(a0)
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		move.w	(Camera_max_Y_pos).w,(Camera_min_Y_pos).w
		clr.b	(Ctrl_1_locked).w
		clr.b	(Ctrl_2_locked).w

locret_64DA8:
		rts
; ---------------------------------------------------------------------------

loc_64DAA:
		btst	#5,(_unkFAB8).w
		beq.s	locret_64DCA
		move.l	#loc_64DCC,(a0)
		st	(Ctrl_1_locked).w
		jsr	(AllocateObject).l
		bne.s	locret_64DCA
		move.l	#loc_863C0,(a1)

locret_64DCA:
		rts
; ---------------------------------------------------------------------------

loc_64DCC:
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	locret_64DDE
		move.l	#loc_64DE0,(a0)

locret_64DDE:
		rts
; ---------------------------------------------------------------------------

loc_64DE0:
		lea	(Player_1).w,a1
		move.w	#(button_right_mask<<8)|button_right_mask,d0
		move.w	x_pos(a1),d1
		subi.w	#$1892,d1
		bcs.s	loc_64DF6
		move.w	#(button_left_mask<<8)|button_left_mask,d0

loc_64DF6:
		move.w	d0,(Ctrl_1_logical).w
		tst.w	d1
		bpl.s	loc_64E00
		neg.w	d1

loc_64E00:
		cmpi.w	#4,d1
		bhi.w	locret_6206C
		move.l	#loc_64E28,(a0)
		move.w	#$3F,$2E(a0)
		st	(_unkFAAC).w
		clr.w	(Ctrl_1_logical).w
		jsr	(Stop_Object).l
		jmp	(Player_Load_PLC).l
; ---------------------------------------------------------------------------

loc_64E28:
		subq.w	#1,$2E(a0)
		bpl.s	locret_64E44
		move.l	#loc_64E46,(a0)
		lea	(Player_1).w,a1
		bset	#0,render_flags(a1)
		bset	#Status_Facing,status(a1)

locret_64E44:
		rts
; ---------------------------------------------------------------------------

loc_64E46:
		lea	(Player_1).w,a1
		cmpi.w	#$580,y_pos(a1)
		blo.s	locret_64E6A
		btst	#Status_InAir,status(a1)
		bne.s	locret_64E6A
		move.l	#loc_64E6C,(a0)
		clr.b	(Ctrl_1_locked).w
		move.w	#$5C0,(Camera_min_Y_pos).w

locret_64E6A:
		rts
; ---------------------------------------------------------------------------

loc_64E6C:
		lea	(Player_1).w,a1
		cmpi.w	#$1660,x_pos(a1)
		bhs.w	locret_6206C
		move.l	#locret_64E86,(a0)
		clr.b	(Ctrl_2_locked).w
		rts
; ---------------------------------------------------------------------------

locret_64E86:
		rts
; ---------------------------------------------------------------------------

loc_64E88:
		lea	ObjDat3_664EE(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.w	a0,(_unkFAAE).w
		move.l	#loc_64EC4,(a0)
		bset	#0,render_flags(a0)
		move.w	#$1640,x_pos(a0)
		move.w	#$2D0,y_pos(a0)
		lea	(Child1_MakeRoboHead4).l,a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_66608(pc),a2
		jsr	(CreateChild1_Normal).l

loc_64EC4:
		btst	#2,$38(a0)
		beq.s	loc_64EEC
		move.l	#loc_64EF2,(a0)
		move.w	#$100,x_vel(a0)
		move.w	#$180,y_vel(a0)
		move.w	#$40,$2E(a0)
		move.l	#loc_64F04,$34(a0)

loc_64EEC:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_64EF2:
		jsr	(MoveSprite2).l
		jsr	(Obj_Wait).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_64F04:
		move.l	#loc_64F20,(a0)
		clr.w	x_vel(a0)
		jsr	(Swing_Setup1).l
		lea	(Child1_MakeRoboShipFlame).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_64F20:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		btst	#6,status(a0)
		bne.s	loc_64F38
		addq.w	#2,x_pos(a0)

loc_64F38:
		cmpi.w	#$1890,x_pos(a0)
		blo.s	loc_64F66
		move.l	#loc_64F70,(a0)
		bset	#4,$38(a0)
		clr.w	x_vel(a0)
		move.b	#$F,collision_flags(a0)
		move.b	#-1,collision_property(a0)
		lea	ChildSpriteDat_66624(pc),a2
		jsr	(CreateChild3_NormalRepeated).l

loc_64F66:
		bsr.w	sub_66348
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_64F70:
		move.b	(_unkFAB8).w,d0
		andi.b	#$C,d0
		cmpi.b	#$C,d0
		bne.s	loc_64F8A
		move.l	#loc_64FA0,(a0)
		bset	#4,(_unkFAB8).w

loc_64F8A:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		bsr.w	sub_66372
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_64FA0:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		btst	#5,(_unkFAB8).w
		beq.s	loc_64FD2
		move.l	#loc_64FDC,(a0)
		move.w	#$190,x_vel(a0)
		bclr	#4,$38(a0)
		lea	(Child1_MakeRoboShipFlame).l,a2
		jsr	(CreateChild1_Normal).l

loc_64FD2:
		bsr.w	sub_66372
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_64FDC:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$200,d0
		cmp.w	x_pos(a0),d0
		blo.s	loc_65000
		bsr.w	sub_66372
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_65000:
		ori.b	#$30,$38(a0)
		movea.w	(_unkFABA).w,a1
		jsr	(Delete_Referenced_Sprite).l
		clr.w	(_unkFABA).w
		clr.w	(Palette_cycle_counter1).w
		lea	(ArtKosM_Teleporter).l,a1
		move.w	#tiles_to_bytes($52E),d2
		jsr	(Queue_Kos_Module).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_6502E:
		lea	ObjDat3_664FA(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_65048,(a0)
		lea	ChildObjDat_66610(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_65048:
		btst	#0,(_unkFAB8).w
		bne.s	loc_6505C
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6505C:
		move.l	#loc_65068,(a0)
		move.b	child_dy(a0),$3A(a0)

loc_65068:
		move.w	(_unkFABA).w,d0
		beq.s	loc_6509A
		movea.w	d0,a1
		move.w	y_pos(a1),d0
		subi.w	#$18,d0
		cmp.w	y_pos(a0),d0
		bls.s	loc_650A6
		move.w	y_vel(a0),d0
		addi.w	#$80,d0
		bmi.s	loc_6508C
		move.w	d0,y_vel(a0)

loc_6508C:
		move.b	y_vel(a0),d2
		move.b	$3A(a0),d3
		add.b	d2,d3
		move.b	d3,child_dy(a0)

loc_6509A:
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_650A6:
		move.l	#loc_650D4,(a0)
		move.b	#2,mapping_frame(a0)
		move.w	#$14,(Screen_shake_flag).w
		moveq	#signextendB(sfx_BigRumble),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_6661E(pc),a2
		jsr	(CreateChild6_Simple).l
		lea	ChildObjDat_66638(pc),a2
		jsr	(CreateChild6_Simple).l

loc_650D4:
		move.w	y_vel(a0),d2
		subi.w	#$80,d2
		bpl.s	loc_650FA
		move.l	#loc_6510C,(a0)
		moveq	#0,d2
		movea.w	parent3(a0),a1
		bset	#2,$38(a1)
		movea.w	(_unkFABA).w,a2
		bset	#7,art_tile(a2)

loc_650FA:
		move.w	d2,y_vel(a0)
		move.b	y_vel(a0),d2
		move.b	$3A(a0),d3
		add.b	d2,d3
		move.b	d3,child_dy(a0)

loc_6510C:
		jsr	(Refresh_ChildPositionAdjusted).l
		move.w	(_unkFABA).w,d0
		beq.s	loc_65132
		movea.w	d0,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),d0
		move.b	(_unkFABD).w,d1
		ext.w	d1
		neg.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a1)

loc_65132:
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_65138:
		lea	word_66506(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_65148,(a0)

loc_65148:
		jsr	(Refresh_ChildPositionAdjusted).l
		move.b	mapping_frame(a1),d0
		addq.b	#1,d0
		move.b	d0,mapping_frame(a0)
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6515E:
		lea	word_6650C(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_6516E,(a0)

loc_6516E:
		movea.w	parent3(a0),a1
		move.b	y_vel(a1),d0
		lsr.b	#4,d0
		addq.b	#4,d0
		move.b	d0,mapping_frame(a0)
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6518A:
		lea	ObjDat3_66512(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_651AC,(a0)
		addi.w	#$30,y_pos(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		move.w	d0,$2E(a0)

loc_651AC:
		subq.w	#1,$2E(a0)
		bmi.s	loc_651B4
		rts
; ---------------------------------------------------------------------------

loc_651B4:
		move.l	#loc_651E2,(a0)
		jsr	(Random_Number).l
		andi.w	#$3F,d0
		subi.w	#$20,d0
		add.w	d0,x_pos(a0)
		swap	d0
		andi.w	#$3F,d0
		subi.w	#$20,d0
		add.w	d0,y_pos(a0)
		move.l	#loc_651F2,$34(a0)

loc_651E2:
		lea	byte_66843(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_651F2:
		move.l	#loc_6520A,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_6520A:
		lea	byte_6684A(pc),a1
		jsr	(Animate_RawNoSST).l
		subi.w	#$80,y_vel(a0)
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_65226:
		lea	ObjDat3_6651E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_65276,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,d1
		move.w	byte_65262(pc,d0.w),child_dx(a0)	; and child_dy
		move.w	word_6526C(pc,d0.w),$2E(a0)
		lsr.w	#1,d1
		move.b	RawAni_6525C(pc,d1.w),mapping_frame(a0)
		move.l	#loc_65288,$34(a0)
		rts
; ---------------------------------------------------------------------------
RawAni_6525C:
		dc.b  $1C, $1B, $1A, $19, $18
		even
byte_65262:
		dc.b    4, $2C
		dc.b   -2, $2A
		dc.b    6, $22
		dc.b   -8, $24
		dc.b   -2, $1C
word_6526C:
		dc.w   $20
		dc.w   $30
		dc.w   $40
		dc.w   $50
		dc.w   $60
; ---------------------------------------------------------------------------

loc_65276:
		jsr	(Refresh_ChildPosition).l
		jsr	(Obj_Wait).l
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------

loc_65288:
		move.l	#loc_65296,(a0)
		bset	#7,art_tile(a0)
		rts
; ---------------------------------------------------------------------------

loc_65296:
		jsr	(MoveSprite).l
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------

loc_652A2:
		move.l	#loc_652FE,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lea	byte_652DE(pc,d0.w),a1
		move.w	(Camera_X_pos).w,d1
		addi.w	#$140,d1
		move.w	(Camera_Y_pos).w,d2
		addi.w	#$C0,d2
		move.b	(a1)+,d3
		ext.w	d3
		add.w	d3,d1
		move.w	d1,x_pos(a0)
		move.b	(a1)+,d3
		ext.w	d3
		add.w	d3,d2
		move.w	d2,y_pos(a0)
		lsl.w	#2,d0
		move.w	d0,$2E(a0)
		rts
; ---------------------------------------------------------------------------
byte_652DE:
		dc.b  -$10, -$58
		dc.b  -$18, -$30
		dc.b    -8, -$10
		dc.b  -$10, -$70
		dc.b  -$20, -$60
		dc.b    -8, -$38
		dc.b  -$20, -$10
		dc.b  -$20, -$40
		dc.b  -$40, -$58
		dc.b  -$30, -$30
		dc.b  -$40,   -8
		dc.b  -$48, -$38
		dc.b  -$38, -$20
		dc.b  -$60, -$40
		dc.b  -$58, -$20
		dc.b  -$70,   -8
		even
; ---------------------------------------------------------------------------

loc_652FE:
		subq.w	#1,$2E(a0)
		bpl.w	locret_6206C
		lea	(Obj_Explosion).l,a1
		move.l	a1,(a0)
		move.b	#2,routine(a0)
		jsr	(a1)
		bset	#7,art_tile(a0)
		rts
; ---------------------------------------------------------------------------

loc_6531E:
		lea	ObjDat3_6652A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_65348,(a0)
		move.w	#4*60,$2E(a0)
		lea	ChildObjDat3_6662C(pc),a2
		tst.b	subtype(a0)
		beq.s	loc_65342
		lea	ChildObjDat3_66632(pc),a2

loc_65342:
		jmp	(CreateChild8_TreeListRepeated).l
; ---------------------------------------------------------------------------

loc_65348:
		subq.w	#1,$2E(a0)
		bne.s	loc_65354
		bset	#7,$38(a0)

loc_65354:
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_65360:
		bset	#3,$38(a0)
		move.b	#$40,$3C(a0)
		move.b	#1,$40(a0)
		bra.w	loc_65382
; ---------------------------------------------------------------------------

loc_65376:
		move.b	#-$40,$3C(a0)
		move.b	#-1,$40(a0)

loc_65382:
		lea	word_66536(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_653F2,(a0)
		move.b	$3C(a0),$26(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,d1
		lsr.w	#1,d1
		btst	#3,$38(a0)
		beq.s	loc_653AE
		addi.w	#$A,d1

loc_653AE:
		move.b	byte_653DE(pc,d1.w),$31(a0)
		cmpi.b	#$12,d0
		bne.s	loc_653C0
		bset	#2,$38(a0)

loc_653C0:
		move.w	d0,d1
		addi.b	#$10,d1
		add.b	d1,d1
		move.b	d1,$30(a0)
		lsl.w	#2,d0
		subi.w	#$48,d0
		neg.w	d0
		move.w	d0,$2E(a0)
		move.w	d0,$32(a0)
		rts
; ---------------------------------------------------------------------------
byte_653DE:
		dc.b -$30
		dc.b -$2C
		dc.b -$28
		dc.b -$20
		dc.b -$18
		dc.b  -$C
		dc.b   -8
		dc.b   -4
		dc.b    0
		dc.b  $40
		dc.b  $30
		dc.b  $28
		dc.b  $20
		dc.b  $18
		dc.b  $10
		dc.b    8
		dc.b -$10
		dc.b -$18
		dc.b -$20
		dc.b -$40
		even
; ---------------------------------------------------------------------------

loc_653F2:
		subi.w	#1,$2E(a0)
		bmi.s	loc_65404
		bsr.w	sub_6628C
		jmp	(MoveSprite_Circular).l
; ---------------------------------------------------------------------------

loc_65404:
		move.l	#loc_6540A,(a0)

loc_6540A:
		move.w	$3A(a0),d0
		addi.w	#$20,d0
		cmpi.w	#$800,d0
		blo.s	loc_65432
		btst	#2,$38(a0)
		beq.s	loc_65426
		cmpi.w	#$C00,d0
		blo.s	loc_65432

loc_65426:
		move.l	#loc_65452,(a0)
		move.w	$32(a0),$2E(a0)

loc_65432:
		move.w	d0,$3A(a0)
		bsr.w	sub_6628C
		jsr	(MoveSprite_Circular).l
		btst	#2,$38(a0)
		beq.s	loc_6544C
		bsr.w	sub_662A6

loc_6544C:
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_65452:
		bsr.w	sub_6628C
		movea.w	$44(a0),a1
		btst	#7,$38(a1)
		beq.s	loc_6546E
		subq.w	#1,$2E(a0)
		bpl.s	loc_6546E
		move.l	#loc_6549A,(a0)

loc_6546E:
		btst	#2,$38(a0)
		bne.s	loc_65484
		moveq	#5,d2
		jsr	(MoveSprite_CircularSimple).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_65484:
		bsr.w	sub_662A6
		lea	(AngleLookup_1).l,a2
		jsr	(MoveSprite_AtAngleLookup).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6549A:
		move.b	$3C(a0),d0
		moveq	#4,d1
		move.b	$31(a0),d2
		sub.b	d0,d2
		beq.s	loc_654C2
		sgt	d3
		bpl.s	loc_654AE
		neg.b	d2

loc_654AE:
		cmpi.b	#4,d2
		blo.s	loc_654C2
		tst.b	d3
		bne.s	loc_654BA
		neg.b	d1

loc_654BA:
		add.b	d1,d0
		move.b	d0,$3C(a0)
		bra.s	loc_6546E
; ---------------------------------------------------------------------------

loc_654C2:
		move.l	#loc_654E2,(a0)
		tst.b	subtype(a0)
		bne.s	loc_654E0
		movea.w	$44(a0),a1
		moveq	#2,d0
		tst.b	subtype(a1)
		beq.s	loc_654DC
		moveq	#3,d0

loc_654DC:
		bset	d0,(_unkFAB8).w

loc_654E0:
		bra.s	loc_6546E
; ---------------------------------------------------------------------------

loc_654E2:
		btst	#4,(_unkFAB8).w
		beq.s	loc_654F6
		move.l	#loc_654FA,(a0)
		move.w	#60-1,$2E(a0)

loc_654F6:
		bra.w	loc_6546E
; ---------------------------------------------------------------------------

loc_654FA:
		btst	#2,$38(a0)
		bne.s	loc_6550E
		moveq	#5,d2
		jsr	(MoveSprite_CircularSimple).l
		bra.w	loc_65538
; ---------------------------------------------------------------------------

loc_6550E:
		moveq	#0,d0
		movea.w	$44(a0),a1
		tst.b	subtype(a1)
		beq.s	loc_6551C
		addq.w	#2,d0

loc_6551C:
		btst	#0,(V_int_run_count+3).w
		beq.s	loc_65526
		addq.w	#1,d0

loc_65526:
		move.b	RawAni_65550(pc,d0.w),mapping_frame(a0)
		lea	(AngleLookup_1).l,a2
		jsr	(MoveSprite_AtAngleLookup).l

loc_65538:
		subq.w	#1,$2E(a0)
		bpl.s	loc_6554A
		move.l	#loc_65554,(a0)
		move.w	$32(a0),$2E(a0)

loc_6554A:
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------
RawAni_65550:
		dc.b  $15, $1C, $19, $1B
		even
; ---------------------------------------------------------------------------

loc_65554:
		subq.w	#1,$2E(a0)
		bpl.s	loc_65560
		move.l	#loc_65564,(a0)

loc_65560:
		bra.w	loc_6546E
; ---------------------------------------------------------------------------

loc_65564:
		move.b	$3C(a0),d0
		moveq	#2,d1
		move.b	$26(a0),d2
		sub.b	d0,d2
		beq.s	loc_6558C
		sgt	d3
		bpl.s	loc_65578
		neg.b	d2

loc_65578:
		subq.b	#1,d2
		beq.s	loc_6558C
		tst.b	d3
		bne.s	loc_65582
		neg.b	d1

loc_65582:
		add.b	d1,d0
		move.b	d0,$3C(a0)
		bra.w	loc_6546E
; ---------------------------------------------------------------------------

loc_6558C:
		move.l	#loc_655AA,(a0)
		clr.b	$39(a0)
		moveq	#1,d0
		btst	#3,$38(a0)
		bne.s	loc_655A2
		neg.w	d0

loc_655A2:
		move.b	d0,$40(a0)
		bra.w	loc_6546E
; ---------------------------------------------------------------------------

loc_655AA:
		bsr.w	sub_6628C
		bra.w	loc_6546E
; ---------------------------------------------------------------------------

loc_655B2:
		lea	ObjDat3_6653C(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_655CE,(a0)
		move.w	#$17F0,x_pos(a0)
		move.w	#$660,y_pos(a0)

loc_655CE:
		moveq	#$1B,d1
		moveq	#$20,d2
		moveq	#$20,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		tst.b	(_unkFAA2).w
		beq.s	loc_655F4
		lea	ChildObjDat_6664A(pc),a2
		jsr	(CreateChild6_Simple).l
		jsr	(Go_Delete_Sprite).l

loc_655F4:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
		dc.w   -$18,   $30,  -$20,   $40
; ---------------------------------------------------------------------------

loc_65602:
		lea	word_66548(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_6561C,(a0)
		bset	#7,render_flags(a0)
		bra.w	loc_662C0
; ---------------------------------------------------------------------------

loc_6561C:
		tst.b	render_flags(a0)
		bpl.s	loc_6562E
		jsr	(MoveSprite_LightGravity).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6562E:
		jsr	(Displace_PlayerOffObject).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_6563A:
		lea	ObjDat3_6654E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_65662,(a0)
		move.w	#$63,$2E(a0)
		tst.b	subtype(a0)
		beq.w	locret_6206C
		move.l	#Wait_Draw,(a0)
		bra.w	loc_65692
; ---------------------------------------------------------------------------

loc_65662:
		subq.w	#1,$2E(a0)
		bmi.s	loc_65678
		lea	byte_66875(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_65678:
		move.l	#Wait_Draw,(a0)
		clr.b	mapping_frame(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_65692,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_65692:
		move.b	#5,mapping_frame(a0)
		move.w	#$B,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

Obj_HPZPaletteControl:
		move.w	$3A(a0),d0
		moveq	#0,d1
		cmpi.w	#$460,(Camera_X_pos).w
		blo.s	loc_656B8
		moveq	#4,d1

loc_656B8:
		move.w	d1,$3A(a0)
		cmp.w	d0,d1
		beq.s	locret_656D0
		movea.l	HPZPaletteControl_PalIndex(pc,d1.w),a1
		lea	(Normal_palette_line_2).w,a2
		moveq	#bytesToLcnt($60),d0

loc_656CA:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_656CA

locret_656D0:
		rts
; ---------------------------------------------------------------------------
HPZPaletteControl_PalIndex:
		dc.l Pal_HPZIntro
		dc.l Pal_HPZ
; ---------------------------------------------------------------------------

CutsceneKnux_SSZ:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	CutsceneKnux_SSZ_Index(pc,d0.w),d1
		jsr	CutsceneKnux_SSZ_Index(pc,d1.w)
		btst	#6,$38(a0)
		bne.s	loc_65702
		move.l	#Map_Knuckles,mappings(a0)
		bsr.w	Knuckles_Load_PLC_661E0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_65702:
		move.l	#Map_SSZKnucklesTired,mappings(a0)
		lea	DPLCPtr_SSZKnucklesTired(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
CutsceneKnux_SSZ_Index:
		dc.w loc_65730-CutsceneKnux_SSZ_Index
		dc.w loc_6575E-CutsceneKnux_SSZ_Index
		dc.w loc_65794-CutsceneKnux_SSZ_Index
		dc.w loc_657CE-CutsceneKnux_SSZ_Index
		dc.w loc_657FE-CutsceneKnux_SSZ_Index
		dc.w loc_65826-CutsceneKnux_SSZ_Index
		dc.w loc_6584C-CutsceneKnux_SSZ_Index
		dc.w loc_65876-CutsceneKnux_SSZ_Index
		dc.w loc_658BA-CutsceneKnux_SSZ_Index
		dc.w loc_658F2-CutsceneKnux_SSZ_Index
		dc.w loc_6594A-CutsceneKnux_SSZ_Index
; ---------------------------------------------------------------------------

loc_65730:
		lea	ObjSlot_CutsceneKnux(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		clr.b	(_unkFAB8).w
		move.w	#$80,priority(a0)
		lea	(Normal_palette_line_2).w,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_6574E:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_6574E
		lea	Pal_CutsceneKnux(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_6575E:
		lea	byte_667C1(pc),a1
		jsr	(Animate_RawNoSSTCheckResult).l
		btst	#0,(_unkFAB8).w
		beq.w	locret_6206C
		move.b	#4,routine(a0)
		move.b	#$56,mapping_frame(a0)
		move.b	#$33,y_radius(a0)
		lea	(ArtKosM_SSZDeathEggSmall).l,a1
		move.w	#tiles_to_bytes($500),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_65794:
		jsr	(MoveSprite_LightGravity).l
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.w	locret_6206C
		add.w	d1,y_pos(a0)
		move.b	#6,routine(a0)
		move.w	#5,$2E(a0)
		jsr	(AllocateObject).l
		bne.s	loc_657C4
		move.l	#loc_66072,(a1)

loc_657C4:
		lea	ChildObjDat_665F6(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_657CE:
		moveq	#signextendB(sfx_DeathEggRiseQuiet),d0
		jsr	(Play_SFX_Continuous).l
		subq.w	#1,$2E(a0)
		bpl.w	locret_6206C
		move.b	#8,routine(a0)
		bset	#0,render_flags(a0)
		bset	#6,$38(a0)
		clr.b	mapping_frame(a0)
		lea	byte_66719(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_657FE:
		moveq	#signextendB(sfx_DeathEggRiseQuiet),d0
		jsr	(Play_SFX_Continuous).l
		btst	#1,(_unkFAB8).w
		bne.s	loc_65814
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_65814:
		move.b	#$A,routine(a0)
		clr.b	mapping_frame(a0)
		move.w	#5,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_65826:
		subq.w	#1,$2E(a0)
		bpl.s	locret_6584A
		move.b	#$C,routine(a0)
		bclr	#0,render_flags(a0)
		bclr	#6,$38(a0)
		move.b	#$56,mapping_frame(a0)
		move.w	#5,$2E(a0)

locret_6584A:
		rts
; ---------------------------------------------------------------------------

loc_6584C:
		subq.w	#1,$2E(a0)
		bpl.w	locret_6206C
		move.b	#$E,routine(a0)
		move.b	#$13,y_radius(a0)
		move.w	#$200,x_vel(a0)
		move.w	#-$300,y_vel(a0)
		lea	byte_667C1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_65876:
		jsr	(Animate_RawCheckResult).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.w	locret_6206C
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.w	locret_6206C
		add.w	d1,y_pos(a0)
		move.b	#$10,routine(a0)
		move.w	#$300,x_vel(a0)
		clr.w	y_vel(a0)
		bclr	#0,render_flags(a0)
		lea	byte_66824(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_658BA:
		jsr	(Animate_RawCheckResult).l
		jsr	(MoveSprite2).l
		cmpi.w	#$2A8,x_pos(a0)
		blo.w	locret_6206C
		move.b	#$12,routine(a0)
		move.b	#$1B,y_radius(a0)
		move.w	#$480,x_vel(a0)
		move.w	#-$600,y_vel(a0)
		lea	byte_667C1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_658F2:
		jsr	(Animate_RawCheckResult).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.w	locret_6206C
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.w	locret_6206C
		add.w	d1,y_pos(a0)
		move.b	#$14,routine(a0)
		move.w	#$200,priority(a0)
		bclr	#0,render_flags(a0)
		bset	#6,$38(a0)
		move.b	#1,mapping_frame(a0)
		st	(Events_bg+$08).w
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l
		lea	byte_6671F(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_6594A:
		bsr.w	sub_65FDE
		jsr	(Animate_RawMultiDelay).l
		move.w	(Camera_X_pos).w,d0
		subi.w	#$80,d0
		cmp.w	x_pos(a0),d0
		bgt.s	loc_65976
		move.w	y_pos(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmpi.w	#$200,d0
		bls.w	locret_6206C

loc_65976:
		move.b	#1,(Last_star_post_hit).w
		move.w	#$140,(Saved_X_pos).w
		move.w	#$C6C,(Saved_Y_pos).w
		jsr	(Save_Level_Data).l
		lea	(Target_palette_line_2).w,a1
		lea	(Normal_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_65998:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_65998
		lea	(PLC_Monitors).l,a1
		jsr	(Load_PLC_Raw).l
		jsr	(Remove_From_TrackingSlot).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

Obj_SSZCutsceneButton:
		lea	ObjDat_SSZCutsceneButton(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_659C6,(a0)

loc_659C6:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_659CC:
		lea	ObjDat3_664AA(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_65A30,(a0)
		move.w	#$200,x_pos(a0)
		move.w	#$C68,d0
		move.w	d0,y_pos(a0)
		move.w	d0,y_vel(a0)
		move.w	#-$40,$40(a0)
		move.w	#$100,$2E(a0)
		move.l	(V_int_run_count).w,(RNG_seed).w
		lea	ChildObjDat_665C4(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	(Normal_palette_line_4).w,a1
		lea	(Target_palette_line_4).w,a2
		moveq	#bytesToLcnt($20),d6

loc_65A14:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_65A14
		lea	Pal_KnuxSSZEnd(pc),a1
		lea	(Normal_palette_line_4).w,a2
		moveq	#bytesToWcnt($20),d0

loc_65A24:
		move.w	(a1)+,d1
		beq.s	loc_65A2A
		move.w	d1,(a2)

loc_65A2A:
		addq.w	#2,a2
		dbf	d0,loc_65A24

loc_65A30:
		jsr	(MoveSprite_SSZBGAdjust).l
		jsr	(Draw_Sprite).l
		subq.w	#1,$2E(a0)
		bpl.s	locret_65A48
		move.l	#loc_65A4A,(a0)

locret_65A48:
		rts
; ---------------------------------------------------------------------------

loc_65A4A:
		bsr.w	sub_66054
		jsr	(MoveSprite_SSZBGAdjust).l
		jsr	(Draw_Sprite).l
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$38,d0
		cmp.w	y_pos(a0),d0
		bls.w	locret_6206C
		bset	#5,$38(a0)
		bset	#1,(_unkFAB8).w
		lea	(Target_palette_line_4).w,a1
		lea	(Normal_palette_line_4).w,a2
		moveq	#bytesToLcnt($20),d6

loc_65A80:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_65A80
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_65A8C:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_65AB0(pc,d0.w),d1
		jsr	off_65AB0(pc,d1.w)
		jsr	(MoveSprite_SSZBGAdjust).l
		lea	DPLCPtr_SSZDeathEggCloud(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_65AB0:
		dc.w loc_65AB6-off_65AB0
		dc.w loc_65AD4-off_65AB0
		dc.w loc_65AF6-off_65AB0
; ---------------------------------------------------------------------------

loc_65AB6:
		lea	ObjSlot_664B6(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.l	#byte_66739,$30(a0)
		move.w	y_pos(a0),y_vel(a0)
		move.w	#$190,$2E(a0)

loc_65AD4:
		jsr	(Animate_RawMultiDelay).l
		subq.w	#1,$2E(a0)
		bpl.w	locret_6206C
		move.b	#4,routine(a0)
		move.w	#$10,$40(a0)
		move.w	#$180,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_65AF6:
		subq.w	#1,$2E(a0)
		bmi.s	loc_65B02
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_65B02:
		jsr	(Remove_From_TrackingSlot).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_65B0E:
		lea	ObjDat3_664C8(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_65B24,(a0)
		move.w	y_pos(a0),y_vel(a0)

loc_65B24:
		st	(Spritemask_flag).w
		btst	#2,(_unkFAB8).w
		bne.s	loc_65B3C
		jsr	(MoveSprite_SSZBGAdjust).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_65B3C:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_65B42:
		lea	word_664D4(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_65B5A,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)

loc_65B5A:
		jsr	(Refresh_ChildPosition).l
		lea	byte_66760(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_65B70:
		lea	word_664DA(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_65BAE,(a0)
		jsr	(Random_Number).l
		move.w	#$100,d1
		andi.w	#$3F,d0
		subi.w	#$20,d0
		bpl.s	loc_65B96
		neg.w	d1

loc_65B96:
		move.w	d1,x_vel(a0)
		add.w	d0,x_pos(a0)
		swap	d0
		andi.w	#$1F,d0
		add.w	d0,y_pos(a0)
		move.w	#$100,y_vel(a0)

loc_65BAE:
		move.b	#4,mapping_frame(a0)
		btst	#0,(V_int_run_count+3).w
		beq.s	loc_65BC2
		move.b	#5,mapping_frame(a0)

loc_65BC2:
		addi.w	#-$10,y_vel(a0)
		jsr	(MoveSprite2).l
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------

Obj_CutsceneButton:
		cmpi.b	#2,(Player_1+character_id).w
		beq.w	CutsceneKnux_Delete
		lea	ObjDat_CutsceneButton(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_65C04,(a0)
		addq.w	#4,y_pos(a0)
		lea	PLC_CutsceneButton(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------
PLC_CutsceneButton: plrlistheader
		plreq $456, ArtNem_GrayButton
PLC_CutsceneButton_End
; ---------------------------------------------------------------------------

loc_65C04:
		move.w	(_unkFAA4).w,d0
		beq.s	loc_65C3A
		movea.w	d0,a1
		lea	word_65C48(pc),a2
		jsr	(Check_InMyRange).l
		beq.s	loc_65C3A
		move.l	#loc_65C50,(a0)
		move.b	#1,mapping_frame(a0)
		st	(_unkFAA9).w
		clr.w	respawn_addr(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	off_65C40(pc,d0.w),d0
		jsr	off_65C40(pc,d0.w)

loc_65C3A:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
off_65C40:
		dc.w loc_65C56-off_65C40
		dc.w loc_65C72-off_65C40
		dc.w loc_65C78-off_65C40
		dc.w loc_65CAC-off_65C40
word_65C48:
		dc.w   -$18,   $30,  -$18,   $30
; ---------------------------------------------------------------------------

loc_65C50:
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------

loc_65C56:
		clr.b	(Ctrl_1_locked).w
		move.w	#$1000,d0
		move.w	d0,(Camera_stored_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		lea	(Child6_IncLevY).l,a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_65C72:
		st	(Level_trigger_array+8).w
		rts
; ---------------------------------------------------------------------------

loc_65C78:
		move.w	#$14,(Screen_shake_flag).w
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$100,d0
		move.w	d0,(Mean_water_level).w
		move.w	#$350,(Target_water_level).w
		st	(_unkFAA3).w
		moveq	#signextendB(sfx_Geyser),d0
		jsr	(Play_SFX).l
		jsr	(AllocateObject).l
		bne.s	locret_65CAA
		move.l	#loc_62480,(a1)

locret_65CAA:
		rts
; ---------------------------------------------------------------------------

loc_65CAC:
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
		bne.s	loc_65CF4
		move.l	#Obj_CNZVacuumTube,(a1)
		move.w	#$4740,x_pos(a1)
		move.w	#$828,y_pos(a1)
		move.b	#$4C,subtype(a1)

loc_65CF4:
		jsr	(AllocateObject).l
		bne.s	locret_65D14
		move.l	#Obj_CNZVacuumTube,(a1)
		move.w	#$4740,x_pos(a1)
		move.w	#$A28,y_pos(a1)
		move.b	#$20,subtype(a1)

locret_65D14:
		rts
; ---------------------------------------------------------------------------

Obj_CNZWaterLevelCorkFloor:
		jsr	(Obj_WaitOffscreen).l
		move.l	#loc_65D46,(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_65D46
		move.l	#Obj_CorkFloor,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	#1,subtype(a1)
		move.w	a1,$44(a0)

loc_65D46:
		movea.w	$44(a0),a1
		cmpi.l	#loc_2A5F8,(a1)
		beq.s	loc_65D58
		jmp	(Delete_Sprite_If_Not_In_Range).l
; ---------------------------------------------------------------------------

loc_65D58:
		tst.b	(_unkFAA2).w
		bne.s	loc_65D68
		st	(_unkFAA2).w
		move.w	#$958,(Target_water_level).w

loc_65D68:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_CNZWaterLevelButton:
		lea	ObjDat_CutsceneButton(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_65D8C,(a0)
		addq.w	#4,y_pos(a0)
		lea	PLC_CutsceneButton(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

loc_65D8C:
		bsr.w	sub_65DEC
		move.b	#0,mapping_frame(a0)
		move.b	status(a0),d0
		andi.b	#standing_mask,d0
		beq.s	loc_65DD0
		move.b	#1,mapping_frame(a0)
		tst.b	(_unkFAA3).w
		beq.s	loc_65DD0
		clr.b	(_unkFAA3).w
		move.w	#$A58,(Target_water_level).w
		moveq	#signextendB(sfx_Geyser),d0
		jsr	(Play_SFX).l
		jsr	(AllocateObject).l
		bne.s	loc_65DD0
		move.l	#loc_62480,(a1)
		st	subtype(a1)

loc_65DD0:
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_65DD6:
		jsr	(AllocateObject).l
		bne.s	locret_65DEA
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_Knuckles,subtype(a1)

locret_65DEA:
		rts
; End of function sub_65DD6


; =============== S U B R O U T I N E =======================================


sub_65DEC:
		move.w	#$1B,d1
		move.w	#4,d2
		move.w	#5,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectFull).l
; End of function sub_65DEC


; =============== S U B R O U T I N E =======================================


sub_65E02:
		jsr	(Random_Number).l
		andi.w	#$1FF,d0
		addi.w	#$100,d0
		neg.w	d0
		move.w	d0,y_vel(a0)
		swap	d0
		move.w	#$100,d1
		btst	#2,(_unkFAB8).w
		bne.s	loc_65E3E
		bclr	#0,render_flags(a0)
		move.w	x_pos(a0),d2
		cmp.w	$3A(a0),d2
		blo.s	loc_65E46
		cmp.w	$3C(a0),d2
		bhi.s	loc_65E3E
		tst.w	d0
		bpl.s	loc_65E46

loc_65E3E:
		neg.w	d1
		bset	#0,render_flags(a0)

loc_65E46:
		move.w	d1,x_vel(a0)
		rts
; End of function sub_65E02


; =============== S U B R O U T I N E =======================================


sub_65E4C:
		move.w	#$1B,d1
		move.w	#$20,d2
		move.w	#$20,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectFull).l
; End of function sub_65E4C


; =============== S U B R O U T I N E =======================================


sub_65E62:
		lea	(Player_1).w,a1
		bsr.w	sub_65E72
		lea	(Player_2).w,a1
		tst.l	(a1)
		beq.s	locret_65EAE
; End of function sub_65E62


; =============== S U B R O U T I N E =======================================


sub_65E72:
		move.b	#5,anim(a1)
		cmpi.b	#$C,anim_frame(a0)
		blo.s	locret_65EAE
		move.b	#$83,object_control(a1)
		move.b	#0,anim(a1)
		bset	#1,render_flags(a1)
		moveq	#0,d0
		btst	#1,(V_int_run_count+3).w
		beq.s	loc_65E9E
		moveq	#2,d0

loc_65E9E:
		add.b	character_id(a1),d0
		move.b	RawAni_65EB0(pc,d0.w),mapping_frame(a1)
		jsr	(Player_Load_PLC2).l

locret_65EAE:
		rts
; End of function sub_65E72

; ---------------------------------------------------------------------------
RawAni_65EB0:
		dc.b  $B4, $A7, $B5, $A8
		even

; =============== S U B R O U T I N E =======================================


sub_65EB4:
		subq.w	#1,$2E(a0)
		bpl.s	locret_65ED2
		move.w	$3E(a0),$2E(a0)
		jsr	(AllocateObject).l
		bne.s	locret_65ED2
		move.l	#loc_63324,(a1)
		move.w	a0,parent3(a1)

locret_65ED2:
		rts
; End of function sub_65EB4


; =============== S U B R O U T I N E =======================================


sub_65ED4:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_65EFC
		move.b	#4,anim_frame_timer(a0)
		move.b	anim_frame(a0),d0
		addq.b	#1,d0
		move.b	d0,anim_frame(a0)
		andi.b	#3,d0
		move.b	render_flags(a0),d1
		andi.b	#$FC,d1
		or.b	d0,d1
		move.b	d1,render_flags(a0)

locret_65EFC:
		rts
; End of function sub_65ED4


; =============== S U B R O U T I N E =======================================


sub_65EFE:
		lea	(Player_1).w,a1
		moveq	#0,d2
		moveq	#$3C,d3
		moveq	#signextendB($8D),d4
		bsr.w	sub_65F84
		lea	(Player_2).w,a1
		moveq	#1,d2
		moveq	#$3D,d3
		moveq	#signextendB($8A),d4
		bsr.w	sub_65F84
		lea	(Player_1).w,a1
		moveq	#0,d2
		moveq	#$3C,d3
		bsr.w	sub_65F2E
		lea	(Player_2).w,a1
		moveq	#1,d2
		moveq	#$3D,d3
; End of function sub_65EFE


; =============== S U B R O U T I N E =======================================


sub_65F2E:
		btst	d2,$38(a0)
		beq.w	locret_65FD4
		subq.b	#1,anim_frame_timer(a1)
		bpl.s	loc_65F5C
		move.b	#8,anim_frame_timer(a1)
		move.b	anim_frame(a1),d0
		addq.b	#1,anim_frame(a1)
		andi.b	#3,d0
		move.b	render_flags(a1),d1
		andi.b	#$FC,d1
		or.b	d0,d1
		move.b	d1,render_flags(a1)

loc_65F5C:
		move.b	(a0,d3.w),d0
		addq.b	#2,(a0,d3.w)
		jsr	(GetSineCosine).l
		asr.w	#3,d0
		asr.w	#3,d1
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		add.w	d0,d2
		add.w	d1,d3
		move.w	d2,x_pos(a1)
		move.w	d3,y_pos(a1)
		rts
; End of function sub_65F2E


; =============== S U B R O U T I N E =======================================


sub_65F84:
		btst	d2,$38(a0)
		bne.s	locret_65FD4
		lea	word_65FD6(pc),a2
		jsr	(Check_InMyRange).l
		beq.s	locret_65FD4
		bset	d2,$38(a0)
		move.w	d3,-(sp)
		clr.b	(Scroll_lock).w
		clr.b	(Update_HUD_timer).w
		move.b	#$83,object_control(a1)
		move.b	d4,mapping_frame(a1)
		clr.b	anim(a1)
		clr.b	anim_frame_timer(a1)
		clr.b	anim_frame(a1)
		move.l	a1,-(sp)
		jsr	(Player_Load_PLC2).l
		movea.l	(sp)+,a1
		movea.l	a1,a2
		movea.l	a0,a1
		jsr	(sub_8622C).l
		move.w	(sp)+,d3
		move.b	d0,(a0,d3.w)

locret_65FD4:
		rts
; End of function sub_65F84

; ---------------------------------------------------------------------------
word_65FD6:
		dc.w   -$20,   $40,  -$20,   $40

; =============== S U B R O U T I N E =======================================


sub_65FDE:
		btst	#3,$38(a0)
		bne.w	locret_6206C
		lea	(Player_1).w,a1
		jsr	(Find_OtherObject).l
		cmpi.w	#$20,d3
		bhs.w	locret_6206C
		subi.w	#$30,d2
		cmpi.w	#$20,d2
		bhs.w	locret_6206C
		tst.w	d0
		beq.w	locret_6206C
		btst	#0,render_flags(a1)
		beq.w	locret_6206C
		cmpi.b	#8,anim(a1)
		bne.w	locret_6206C
		lea	byte_6672A(pc),a1
		jmp	(Set_Raw_Animation).l
; End of function sub_65FDE


; =============== S U B R O U T I N E =======================================


MoveSprite_SSZBGAdjust:
		move.w	(_unkFA84).w,d0
		add.w	d0,x_pos(a0)
		move.w	$40(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		move.l	y_vel(a0),d1
		add.l	d0,d1
		move.l	d1,y_vel(a0)
		swap	d1
		move.w	(_unkEE9C).w,d0
		asr.w	#2,d0
		sub.w	d0,d1
		move.w	d1,y_pos(a0)
		rts
; End of function MoveSprite_SSZBGAdjust


; =============== S U B R O U T I N E =======================================


sub_66054:
		move.b	(V_int_run_count+3).w,d0
		andi.w	#$1F,d0
		bne.w	locret_6206C
		moveq	#signextendB(sfx_MissileShoot),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_665F0(pc),a2
		jmp	(CreateChild6_Simple).l
; End of function sub_66054

; ---------------------------------------------------------------------------

loc_66072:
		move.w	(Camera_X_pos).w,$3A(a0)
		move.l	#loc_6607E,(a0)

loc_6607E:
		move.w	(Camera_X_pos).w,d0
		move.w	$3A(a0),d1
		move.w	d0,$3A(a0)
		sub.w	d1,d0
		asr.w	#1,d0
		move.w	d0,(_unkFA84).w
		rts

; =============== S U B R O U T I N E =======================================


sub_66094:
		bset	#0,render_flags(a0)
		tst.w	d0
		beq.s	locret_660A4
		bclr	#0,render_flags(a0)

locret_660A4:
		rts
; End of function sub_66094

; ---------------------------------------------------------------------------

loc_660A6:
		tst.b	$34(a1)
		bne.w	locret_6206C

loc_660AE:
		btst	#Status_InAir,status_secondary(a1)
		bne.w	locret_6206C
		jmp	(HurtCharacter_Directly).l
; ---------------------------------------------------------------------------

loc_660BE:
		lea	word_66152(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.l	d0
		beq.w	locret_6206C
		tst.w	d0
		beq.s	loc_660DA
		move.l	d0,-(sp)
		bsr.w	sub_660E2
		move.l	(sp)+,d0

loc_660DA:
		swap	d0
		tst.w	d0
		beq.w	locret_6206C

; =============== S U B R O U T I N E =======================================


sub_660E2:
		btst	#4,$38(a0)
		bne.w	locret_6206C
		movea.w	d0,a1
		btst	#0,render_flags(a0)
		sne	d4
		move.w	x_pos(a1),d1
		cmp.w	x_pos(a0),d1
		bhs.s	loc_66102
		not.b	d4

loc_66102:
		tst.b	d4
		bne.s	loc_66134
		move.w	y_pos(a1),d2
		sub.w	y_pos(a0),d2
		bpl.s	loc_66112
		neg.w	d2

loc_66112:
		cmpi.w	#$10,d2
		bhs.s	loc_66134
		cmpi.b	#2,anim(a1)
		beq.s	loc_6612A
		btst	#Status_Invincible,status_secondary(a1)
		bne.w	loc_6429E

loc_6612A:
		movea.l	(a3),a4
		jmp	(a4)
; ---------------------------------------------------------------------------
		movea.l	4(a3),a4
		jmp	(a4)
; ---------------------------------------------------------------------------

loc_66134:
		cmpi.b	#2,anim(a1)
		beq.s	loc_66146
		btst	#Status_Invincible,status_secondary(a1)
		bne.w	loc_6429E

loc_66146:
		movea.l	8(a3),a4
		jmp	(a4)
; ---------------------------------------------------------------------------
		movea.l	$C(a3),a4
		jmp	(a4)
; End of function sub_660E2

; ---------------------------------------------------------------------------
word_66152:
		dc.w   -$18,   $30,  -$18,   $30

; =============== S U B R O U T I N E =======================================


sub_6615A:
		tst.w	x_vel(a0)
		beq.s	locret_66188
		bmi.s	loc_66176
		move.w	(Camera_X_pos).w,d0
		addi.w	#$130,d0
		cmp.w	x_pos(a0),d0
		bhi.s	locret_66188
		clr.w	x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_66176:
		move.w	(Camera_X_pos).w,d0
		addi.w	#$10,d0
		cmp.w	x_pos(a0),d0
		blo.s	locret_66188
		clr.w	x_vel(a0)

locret_66188:
		rts
; End of function sub_6615A

; ---------------------------------------------------------------------------

Knuckles_Load_PLC_6618A:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	$3A(a0),d0
		beq.s	locret_661DE
		move.b	d0,$3A(a0)
		lea	(PLC_Knuckles).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_661DE
		move.w	#tiles_to_bytes(ArtTile_Player_2),d4
		move.l	#ArtUnc_Knux,d6

loc_661B6:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,loc_661B6

locret_661DE:
		rts

; =============== S U B R O U T I N E =======================================


Knuckles_Load_PLC_661E0:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	$3A(a0),d0
		beq.s	locret_66234
		move.b	d0,$3A(a0)
		lea	(PLC_Knuckles).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_66234
		move.w	#tiles_to_bytes(ArtTile_CutsceneKnux),d4
		move.l	#ArtUnc_Knux,d6

loc_6620C:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,loc_6620C

locret_66234:
		rts
; End of function Knuckles_Load_PLC_661E0


; =============== S U B R O U T I N E =======================================


sub_66236:
		move.l	#ArtUnc_DashDust,d6
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	$3A(a0),d0
		beq.s	locret_6628A
		move.b	d0,$3A(a0)
		lea	(DPLC_DashSplashDrown).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_6628A
		move.w	#tiles_to_bytes($500),d4

loc_66262:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,loc_66262

locret_6628A:
		rts
; End of function sub_66236


; =============== S U B R O U T I N E =======================================


sub_6628C:
		move.b	$40(a0),d0
		add.b	d0,$3C(a0)
		subq.b	#1,$39(a0)
		bpl.s	locret_662A4
		move.b	$30(a0),$39(a0)
		neg.b	$40(a0)

locret_662A4:
		rts
; End of function sub_6628C


; =============== S U B R O U T I N E =======================================


sub_662A6:
		moveq	#0,d0
		move.b	$3C(a0),d0
		addi.b	#$10,d0
		rol.b	#3,d0
		andi.b	#7,d0
		addi.b	#$13,d0
		move.b	d0,mapping_frame(a0)
		rts
; End of function sub_662A6

; ---------------------------------------------------------------------------

loc_662C0:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,d3
		lea	byte_66308(pc,d0.w),a1
		move.b	(a1)+,d1
		ext.w	d1
		add.w	d1,x_pos(a0)
		move.b	(a1)+,d2
		ext.w	d2
		add.w	d2,y_pos(a0)
		lsr.w	#1,d0
		addq.b	#7,d0
		move.b	d0,mapping_frame(a0)
		move.w	#-$200,d0
		lsl.w	#4,d3
		neg.w	d3
		add.w	d3,d0
		move.w	d0,x_vel(a0)
		lsl.w	#1,d3
		andi.w	#$180,d3
		addi.w	#$80,d3
		tst.w	d2
		bpl.s	loc_66302
		neg.w	d3

loc_66302:
		move.w	d3,y_vel(a0)
		rts
; ---------------------------------------------------------------------------
byte_66308:
		dc.b    8,   -8
		dc.b    8,    0
		dc.b    8, -$10
		dc.b    8,    8
		dc.b    8, -$18
		dc.b    8,  $10
		dc.b    8, -$20
		dc.b    8,  $18
		dc.b    0,   -8
		dc.b    0,    0
		dc.b    0, -$10
		dc.b    0,    8
		dc.b    0, -$18
		dc.b    0,  $10
		dc.b    0, -$20
		dc.b    0,  $18
		dc.b   -8,   -8
		dc.b   -8,    0
		dc.b   -8, -$10
		dc.b   -8,    8
		dc.b   -8, -$18
		dc.b   -8,  $10
		dc.b   -8, -$20
		dc.b   -8,  $18
		dc.b -$10,   -8
		dc.b -$10,    0
		dc.b -$10, -$10
		dc.b -$10,    8
		dc.b -$10, -$18
		dc.b -$10,  $10
		dc.b -$10, -$20
		dc.b -$10,  $18

; =============== S U B R O U T I N E =======================================


sub_66348:
		btst	#6,status(a0)
		beq.s	locret_66370
		tst.b	$20(a0)
		bne.s	loc_66364
		move.b	#$30,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

loc_66364:
		subq.b	#1,$20(a0)
		bne.s	locret_66370
		bclr	#6,status(a0)

locret_66370:
		rts
; End of function sub_66348


; =============== S U B R O U T I N E =======================================


sub_66372:
		tst.b	collision_flags(a0)
		bne.s	locret_663B8
		tst.b	$20(a0)
		bne.s	loc_66392
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		bset	#6,status(a0)

loc_66392:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_663A0
		; Bug: should be 2*3
		addi.w	#2*2,d0

loc_663A0:
		jsr	(sub_7A614).l
		subq.b	#1,$20(a0)
		bne.s	locret_663B8
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_663B8:
		rts
; End of function sub_66372

; ---------------------------------------------------------------------------
ObjSlot_CutsceneKnux:
		dc.w 1-1
		dc.w make_art_tile(ArtTile_CutsceneKnux,1,1)
		dc.w    $2E,     0
		dc.l Map_CutsceneKnux
		dc.w   $180
		dc.b  $1C, $18, $16,   0
ObjSlot_CutsceneKnux_MHZ2:
		dc.w 1-1
		dc.w make_art_tile(ArtTile_CutsceneKnux,1,1)
		dc.w    $2E,     0
		dc.l Map_MHZKnuxPullSwitch
		dc.w   $180
		dc.b  $1C, $18,   3,   0
ObjSlot_KnuxIntroLay:
		dc.w 1-1
		dc.w make_art_tile(ArtTile_Player_2,0,0)
		dc.w    $2E,     0
		dc.l Map_KnuxIntroLay
		dc.w   $180
		dc.b  $1C, $18,   0,   0
ObjSlot_HPZKnucklesGrab:	; unused
		dc.w 1-1
		dc.w make_art_tile($4DA,1,1)
		dc.w    $2E,     0
		dc.l Map_HPZKnucklesGrab
		dc.w   $180
		dc.b  $1C, $18,   2,   0
ObjDat_CutsceneButton:
		dc.l Map_Button
		dc.w make_art_tile($456,0,1)
		dc.w   $100
		dc.b  $10,   8,   0,   0
ObjDat3_6640E:
		dc.l Map_LBZKnuxBomb
		dc.w make_art_tile($4D6,1,1)
		dc.w    $80
		dc.b    8,   8,   0,   0
ObjDat3_6641A:
		dc.l Map_LBZKnuxPillar
		dc.w make_art_tile(ArtTile_Explosion,2,0)
		dc.w   $280
		dc.b  $10, $10,   0,   0
ObjDat_LBZKnuxPillar:
		dc.l Map_LBZKnuxPillar
		dc.w make_art_tile(ArtTile_Explosion,2,0)
		dc.w   $280
		dc.b  $10, $80,   1,   0
ObjDat3_66432:
		dc.l Map_AIZCorkFloor
		dc.w make_art_tile($001,2,0)
		dc.w   $180
		dc.b  $10, $18,   0,   0
ObjDat3_6643E:
		dc.l Map_MHZKnuxPeer
		dc.w make_art_tile($500,1,0)
		dc.w   $180
		dc.b  $10, $10,   4,   0
ObjDat_MHZ1CutsceneButton:
		dc.l Map_Button
		dc.w make_art_tile($341,0,0)
		dc.w   $100
		dc.b  $80, $80,   0,   0
ObjDat3_66456:
		dc.l Map_MHZKnuxSwitch
		dc.w make_art_tile($528,1,1)
		dc.w   $300
		dc.b  $10, $10,   0,   0
ObjDat3_66462:
		dc.l Map_MHZKnuxDoor
		dc.w make_art_tile($3C9,3,0)
		dc.w    $80
		dc.b  $10, $20,   0,   0
ObjDat3_6646E:
		dc.l Map_MHZKnuxLeaves
		dc.w make_art_tile($368,3,1)
		dc.w     0
		dc.b    4,   4,   0,   0
ObjDat3_6647A:
		dc.l Map_LRZKnuxBoulder
		dc.w make_art_tile($500,2,0)
		dc.w   $200
		dc.b  $20, $20,   0,   0
ObjDat3_66486:
		dc.l Map_KnuxIntroBomb
		dc.w make_art_tile($52E,1,0)
		dc.w   $180
		dc.b   $C, $10,   0,   0
word_66492:
		dc.w   $100
		dc.b    8,   8,   1,   0
word_66498:
		dc.w   $100
		dc.b    8,   8,   5,   0
ObjDat_SSZCutsceneButton:
		dc.l Map_Button
		dc.w make_art_tile($48E,0,0)
		dc.w   $180
		dc.b  $10,   8,   1,   0
ObjDat3_664AA:
		dc.l Map_SSZDeathEggSmall
		dc.w make_art_tile($500,3,0)
		dc.w   $380
		dc.b  $3C, $30,   0,   0
ObjSlot_664B6:
		dc.w 1-1
		dc.w make_art_tile($4C9,3,0)
		dc.w    $10,     2
		dc.l Map_SSZDeathEggCloud
		dc.w $280
		dc.b  $40, $10,   0,   0
ObjDat3_664C8:
		dc.l Map_SpriteMask
		dc.w make_art_tile($000,0,0)
		dc.w   $200
		dc.b  $40, $30,  $C,   0
word_664D4:
		dc.w   $300
		dc.b    4, $1C,   1,   0
word_664DA:
		dc.w make_art_tile($500,0,0)
		dc.w   $280
		dc.b    8,   8,   4,   0
ObjDat3_664E2:
		dc.l Map_DashDust
		dc.w make_art_tile($500,0,0)
		dc.w    $80
		dc.b  $10, $10,  $A,   0
ObjDat3_664EE:
		dc.l Map_RobotnikShip
		dc.w make_art_tile($52E,0,1)
		dc.w      0
		dc.b  $1C, $20,  $A,   0
ObjDat3_664FA:
		dc.l Map_KnuxFinalBossCrane
		dc.w make_art_tile($4A7,0,1)
		dc.w   $180
		dc.b  $14, $14,   0,   0
word_66506:
		dc.w   $280
		dc.b  $10,  $C,   1,   0
word_6650C:
		dc.w   $180
		dc.b    4, $80,   4,   0
ObjDat3_66512:
		dc.l Map_HPZEmeraldMisc
		dc.w make_art_tile($3B5,0,1)
		dc.w      0
		dc.b   $C,  $C, $12,   0
ObjDat3_6651E:
		dc.l Map_HPZEmeraldMisc
		dc.w make_art_tile($3B5,2,0)
		dc.w   $180
		dc.b    4,   8, $18,   0
ObjDat3_6652A:
		dc.l Map_KnuxFinalBossCrane
		dc.w make_art_tile($4A7,0,0)
		dc.w      0
		dc.b    8,   8, $12,   0
word_66536:
		dc.w      0
		dc.b    8,   8, $12,   0
ObjDat3_6653C:
		dc.l Map_LRZ3Platform
		dc.w make_art_tile($001,2,1)
		dc.w      0
		dc.b  $10, $20,   6,   0
word_66548:
		dc.w      0
		dc.b    4,   4,   7,   0
ObjDat3_6654E:
		dc.l Map_HPZKnuxDizzyStars
		dc.w make_art_tile($500,1,0)
		dc.w   $180
		dc.b   $C,   4,   1,   0
ChildObjDat_6655A:
		dc.w 1-1
		dc.l loc_620EA
ChildObjDat_66560:
		dc.w 1-1
		dc.l loc_62458
		dc.b -$20,-$6C
ChildObjDat_66568:
		dc.w 3-1
		dc.l Obj_DecLevStartYGradual
		dc.b    0,   0
		dc.l Obj_DecLevStartXGradual
		dc.b    0,   0
		dc.l Obj_IncLevEndXGradual
		dc.b    0,   0
ChildObjDat_6657C:
		dc.w 1-1
		dc.l loc_627C6
		dc.b -$40,   0
ChildObjDat_66584:
		dc.w 1-1
		dc.l loc_6282A
		dc.b   -8,-$10
ChildObjDat_6658C:
		dc.w 4-1
		dc.l loc_6285A
ChildObjDat_66592:
		dc.w 4-1
		dc.l loc_629CE
		dc.b    2, $24
ChildObjDat_6659A:
		dc.w 1-1
		dc.l loc_61F60
		dc.b    0, $18
ChildObjDat_665A2:
		dc.w 1-1
		dc.l Obj_CutsceneButton
		dc.b    0,  $C
ChildObjDat_665AA:
		dc.w 1-1
		dc.l Obj_CutsceneKnuckles
ChildObjDat_665B0:
		dc.w 1-1
		dc.l loc_62F72
ChildObjDat_665B6:
		dc.w 1-1
		dc.l loc_6300C
ChildObjDat_665BC:
		dc.w 1-1
		dc.l loc_632CA
		dc.b   -8,   0
ChildObjDat_665C4:
		dc.w 7-1
		dc.l loc_65B0E
		dc.b    0,   0
		dc.l loc_65A8C
		dc.b    0,-$33
		dc.l loc_65B42
		dc.b -$20, $1D
		dc.l loc_65B42
		dc.b -$10, $1D
		dc.l loc_65B42
		dc.b    8, $1D
		dc.l loc_65B42
		dc.b  $10, $1D
		dc.l loc_65B42
		dc.b  $28, $1D
ChildObjDat_665F0:
		dc.w 1-1
		dc.l loc_65B70
ChildObjDat_665F6:
		dc.w 1-1
		dc.l loc_659CC
ChildObjDat_665FC:
		dc.w 1-1
		dc.l loc_64C24
ChildObjDat_66602:
		dc.w $10-1
		dc.l loc_652A2
ChildObjDat_66608:
		dc.w 1-1
		dc.l loc_6502E
		dc.b    0, $23
ChildObjDat_66610:
		dc.w 2-1
		dc.l loc_65138
		dc.b    0,   0
		dc.l loc_6515E
		dc.b    0,-$30
ChildObjDat_6661E:
		dc.w $F-1
		dc.l loc_6518A
ChildSpriteDat_66624:
		dc.w 2-1
		dc.l loc_6531E
		dc.b    8,  -4
ChildObjDat3_6662C:
		dc.w $A-1
		dc.l loc_65376
ChildObjDat3_66632:
		dc.w $A-1
		dc.l loc_65360
ChildObjDat_66638:
		dc.w 5-1
		dc.l loc_65226
ChildObjDat_6663E:
		dc.w 1-1
		dc.l loc_655B2
ChildObjDat_66644:
		dc.w 1-1
		dc.l loc_6563A
ChildObjDat_6664A:
		dc.w $20-1
		dc.l loc_65602
ChildObjDat_66650:
		dc.w $A-1
		dc.l loc_6395C
ChildObjDat_66656:
		dc.w 8-1
		dc.l loc_63694
ChildObjDat_6665C:
		dc.w 1-1
		dc.l loc_638DC
		dc.b    0,-$14
ChildObjDat_66664:
		dc.w 1-1
		dc.l loc_63916
DPLCPtr_CutsceneKnux:
		dc.l ArtUnc_CutsceneKnux
		dc.l DPLC_CutsceneKnux
DPLCPtr_MHZKnuxPress:
		dc.l ArtUnc_MHZKnuxPress
		dc.l DPLC_MHZKnuxPress
DPLCPtr_KnuxIntroLay:
		dc.l ArtUnc_KnuxIntroLay
		dc.l DPLC_KnuxIntroLay
DPLCPtr_HPZKnucklesGrab:
		dc.l ArtUnc_HPZKnucklesGrab
		dc.l DPLC_HPZKnucklesGrab
DPLCPtr_SSZKnucklesTired:
		dc.l ArtUnc_SSZKnucklesTired
		dc.l DPLC_SSZKnucklesTired
DPLCPtr_SSZDeathEggCloud:
		dc.l ArtUnc_SSZDeathEggCloud
		dc.l DPLC_SSZDeathEggCloud
byte_6669A:
		dc.b    7,   1,   2,   3, $FC
byte_6669F:
		dc.b    4,  $A,  $B,  $C,  $D,  $E,  $F, $10, $11, $FC
byte_666A9:
		dc.b    1, $12, $13, $14, $15, $FC
byte_666AF:
		dc.b    1,   8,   4,   8,   5,   8,   6,   8,   7, $FC
byte_666B9:
		dc.b    7, $1C, $1C, $1D, $F8,   6
byte_666BF:
		dc.b    7, $1E, $1F, $FC
byte_666C3:
		dc.b  $16,   7
		dc.b  $16,   7
		dc.b  $17,   7
		dc.b  $18,   7
		dc.b  $19, $13
		dc.b  $1A,   7
		dc.b  $1B,   0
		dc.b  $F4
byte_666D2:
		dc.b  $20,   5
		dc.b  $21,   5
		dc.b  $22, $14
		dc.b  $23,   3
		dc.b  $24,  $F
		dc.b  $21,   5
		dc.b  $20,   5
		dc.b  $F4
byte_666E1:
		dc.b    0,   4
		dc.b    0,   9
		dc.b    1, $1D
		dc.b    0,   4
		dc.b    2,   4
		dc.b    3, $1D
		dc.b    2,   4
		dc.b    0,   4
		dc.b    1, $1D
		dc.b    0,   4
		dc.b  $F4
byte_666F6:
		dc.b    3,   7
		dc.b    3, $1F
		dc.b    0,   7
		dc.b    1, $1F
		dc.b    2,   7
		dc.b    1, $7F
		dc.b    2,   7
		dc.b    1, $1F
		dc.b    2,   7
		dc.b    1,  $F
		dc.b    2,   7
		dc.b    1,  $B
		dc.b    2,   7
		dc.b    1,   7
		dc.b    2,   7
		dc.b    1,   7
		dc.b    2,   7
		dc.b  $F4
byte_66719:
		dc.b    0,   7
		dc.b    0,   7
		dc.b  $F8,   6
byte_6671F:
		dc.b    1,  $B
		dc.b    2,   5
		dc.b    3,  $B
		dc.b    2,  $B
		dc.b    1,  $B
		dc.b  $FC
byte_6672A:
		dc.b    4,   7
		dc.b    4,   7
		dc.b    5,   7
		dc.b    6, $1F
		dc.b  $F8,  $A
		dc.b    5,  $F
		dc.b    6, $1F
		dc.b  $FC
byte_66739:
		dc.b    0,   5
		dc.b    0,   5
		dc.b    1,   7
		dc.b    2,   9
		dc.b    3,   9
		dc.b    4,  $B
		dc.b    5,  $C
		dc.b    6,  $D
		dc.b    7,  $E
		dc.b    8,  $F
		dc.b    9, $13
		dc.b   $A, $1D
		dc.b   $B, $27
		dc.b   $C, $63
		dc.b  $F8, $1E
		dc.b   $B, $3B
		dc.b   $A, $63
		dc.b   $B, $3B
		dc.b   $C, $63
		dc.b  $FC
byte_66760:
		dc.b    6,   0
		dc.b    6, $4D
		dc.b    1, $4D
		dc.b    1, $4D
		dc.b    1, $4D
		dc.b    1, $4D
		dc.b    2,   9
		dc.b    3,   9
		dc.b  $F4
byte_66771:
		dc.b  $D8,   4
		dc.b  $D9,   4
		dc.b  $DA,   4
		dc.b  $DB,   4
		dc.b  $D8,   4
		dc.b  $D9,   4
		dc.b  $DA,   4
		dc.b  $DB,   4
		dc.b  $D8,   4
		dc.b  $D9,   4
		dc.b  $DA,   4
		dc.b  $DB,   4
		dc.b  $D8,   4
		dc.b  $D9,   4
		dc.b  $DA,   4
		dc.b  $DB,   4
		dc.b  $D8,   4
		dc.b  $D9,   4
		dc.b  $DA,   4
		dc.b  $DB,   4
		dc.b  $D8,   4
		dc.b  $D9,   4
		dc.b  $DA,   4
		dc.b  $DB,   4
		dc.b  $DC,   4
		dc.b  $DD,   4
		dc.b  $DC,   4
		dc.b  $DD,   4
		dc.b  $DE,  $B
		dc.b  $FF, $FC
byte_667AD:
		dc.b    4, $D8, $D9, $DA, $DB, $FF, $FC
byte_667B4:
		dc.b  $DA,   5, $9B,   5, $9C,  $F, $FF, $F4
byte_667BC:
		dc.b    1,   0, $8D, $FF, $FC
byte_667C1:
		dc.b    1, $9A, $96, $9A, $97, $9A, $98, $9A, $99, $FF, $FC
byte_667CC:
		dc.b    3, $DA, $DA, $9B, $9C, $9B, $FF, $F4
byte_667D4:
		dc.b  $C0,   5
		dc.b  $CA,   5
		dc.b  $CB, $7F
		dc.b  $CB, $7F
		dc.b  $CB, $7F
		dc.b  $FF, $FC
byte_667E0:
		dc.b    5, $CC, $9B, $9C, $9B, $FF, $F4
byte_667E7:
		dc.b    2,   3
		dc.b    3,   3
		dc.b    4,   3
		dc.b    5,   3
		dc.b    4, $7F
		dc.b    4, $1F
		dc.b  $FF, $F4
byte_667F5:
		dc.b    3, $DA, $DA, $9B, $9C, $FF, $F8,   8
		dc.b    0, $86, $87, $86, $88, $86, $89, $86, $8A, $86, $8B, $FF, $FC
byte_6680A:
		dc.b    2,   3
		dc.b    3,   3
		dc.b    4,   3
		dc.b    5,   3
		dc.b    4, $3F
		dc.b  $FF, $F4
		dc.b    2,   3
		dc.b    3,   3
		dc.b    4,   3
		dc.b    5,   3
		dc.b    4, $7F
		dc.b    6,   3
		dc.b  $FF, $F4
byte_66824:
		dc.b    4,   7,   8,   1,   2,   3,   4,   5,   6, $FF, $FC
byte_6682F:
		dc.b    3,   7,   8,   1,   2,   3,   4,   5,   6, $FF, $FC
byte_6683A:
		dc.b    1,  $A,  $B,  $C,  $D,  $E,  $F, $10, $FC
byte_66843:
		dc.b    1, $12, $12, $13, $14, $15, $F4
byte_6684A:
		dc.b    3, $16, $16, $17, $F4
byte_6684F:
		dc.b    6, $3F
		dc.b    6, $3F
		dc.b    7,   2
		dc.b    8,   2
		dc.b    7,   2
		dc.b    6,   2
		dc.b    7,   2
		dc.b    8,   2
		dc.b    7,   2
		dc.b    6,   2
		dc.b    7,   2
		dc.b    8,   2
		dc.b    7,   2
		dc.b    6,   2
		dc.b    7,   2
		dc.b    8,   2
		dc.b    7,   2
		dc.b    6, $5F
		dc.b  $FF, $F4
byte_66875:
		dc.b    5,   1,   2,   3,   4, $FC
byte_6687B:
		dc.b    7,   9,  $A, $FF, $FC
byte_66880:
		dc.b    5,  $B,  $C, $FF, $FC
byte_66885:
		dc.b  $56,   7
		dc.b  $56, $1F
		dc.b  $DE,   0
		dc.b  $DE,  $F
		dc.b  $56, $3F
		dc.b  $FF, $F4
byte_66891:
		dc.b  $D8,   4
		dc.b  $D9,   4
		dc.b  $DA,   4
		dc.b  $DB,   4
		dc.b  $DC,   4
		dc.b  $DC,   4
		dc.b  $DD,   4
		dc.b  $DC,   4
		dc.b  $DD,   4
		dc.b  $DE,   0
		dc.b  $FF, $F4
byte_668A7:
		dc.b  $DE,   7
		dc.b  $DE,   7
		dc.b  $56,   0
		dc.b  $FF, $F4
byte_668AF:
		dc.b   $E, $59
		dc.b   $E, $77
		dc.b   $F, $07
		dc.b  $10, $1D
		dc.b  $11, $07
		dc.b  $12, $07
		dc.b  $11, $07
		dc.b  $12, $07
		dc.b   $F, $07
		dc.b  $FF, $F4
byte_668C3:
		dc.b  $13,   0,   1, $FC
byte_668C7:
		dc.b    4, $6F
		dc.b    4, $6F
		dc.b    2,   7
		dc.b    3, $7F
		dc.b  $FC
byte_668D0:
		dc.b    3,   3
		dc.b    3,   3
		dc.b    4,   3
		dc.b    5,   3
		dc.b    4, $5F
		dc.b    6, $1F
		dc.b    7,   2
		dc.b    8,   2
		dc.b    7,   2
		dc.b    6,   2
		dc.b    7,   2
		dc.b    8,   2
		dc.b    7,   2
		dc.b    6,  $F
		dc.b    9,   7
		dc.b   $A,   7
		dc.b    9,   7
		dc.b   $A,   7
		dc.b    9,   7
		dc.b   $A,   7
		dc.b    9,   7
		dc.b   $A,   7
		dc.b    9,   7
		dc.b   $A,   7
		dc.b    9,   7
		dc.b   $A,   7
		dc.b  $F4
byte_66905:
		dc.b    3,   1,   2,   3,   4, $FC
byte_6690B:
		dc.b    5,   5,   5,   6,   7,   8, $F4
		even
Pal_CutsceneKnux:
		binclude "General/Sprites/Knuckles/Cutscene/Pal.bin"
		even
Pal_CNZFlash:
		binclude "Levels/CNZ/Palettes/Flash.bin"
		even
Pal_KnuxSSZEnd:
		binclude "General/Sprites/Knuckles/Palettes/SSZ End.bin"
		even
Pal_HPZ:
		binclude "Levels/HPZ/Palettes/Main.bin"
		even
Pal_SKIntroBomb:
		binclude "General/Sprites/Knuckles/Cutscene/Intro Bomb Pal.bin"
		even
Map_MHZKnuxPeer:
		include "Levels/MHZ/Misc Object Data/Map - Knuckles Peering.asm"
Map_MHZKnuxDoor:
		include "Levels/MHZ/Misc Object Data/Map - Knuckles Switch Door.asm"
Map_MHZKnuxPullSwitch:
		include "General/Sprites/Knuckles/Cutscene/Map - MHZ2 Press.asm"
DPLC_MHZKnuxPress:
		include "General/Sprites/Knuckles/Cutscene/DPLC - MHZ Press.asm"
Map_MHZKnuxSwitch:
		include "General/Sprites/Knuckles/Cutscene/Map - Act 2 Knuckles Switch.asm"
Map_MHZKnuxLeaves:
		include "Levels/MHZ/Misc Object Data/Map - Act 2 Knuckles Leaves.asm"
Map_LRZKnuxBoulder:
		include "Levels/LRZ/Misc Object Data/Map - Knuckles Boulder.asm"
Map_SSZKnucklesTired:
		include "General/Sprites/Knuckles/Cutscene/Map - SSZ Tired.asm"
DPLC_SSZKnucklesTired:
		include "General/Sprites/Knuckles/Cutscene/DPLC - SSZ Tired.asm"
Map_SSZDeathEggSmall:
		include "Levels/SSZ/Misc Object Data/Map - Death Egg Small.asm"
Map_SSZDeathEggCloud:
		include "General/Sprites/SSZ Death Egg Cloud/Map - SSZ Death Egg Cloud.asm"
DPLC_SSZDeathEggCloud:
		include "General/Sprites/SSZ Death Egg Cloud/DPLC - SSZ Death Egg Cloud.asm"
Map_HPZKnucklesGrab:
		include "General/Sprites/Knuckles/Cutscene/Map - HPZ Grab.asm"
DPLC_HPZKnucklesGrab:
		include "General/Sprites/Knuckles/Cutscene/DPLC - HPZ Grab.asm"
Map_KnuxFinalBossCrane:
		include "General/Sprites/Robotnik/Map - Robotnik Ship Crane.asm"
Map_HPZKnuxDizzyStars:
		include "Levels/HPZ/Misc Object Data/Map - Knuckles Dizzy Stars.asm"
Map_KnuxIntroLay:
		include "General/Sprites/Knuckles/Cutscene/Map - Intro Laying.asm"
DPLC_KnuxIntroLay:
		include "General/Sprites/Knuckles/Cutscene/DPLC - Intro Laying.asm"
Map_KnuxIntroBomb:
		include "General/Sprites/Knuckles/Cutscene/Map - Intro Bomb.asm"
; ---------------------------------------------------------------------------

Obj_AIZPlaneIntro:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	AIZPlaneIntro_Index(pc,d0.w),d1
		jsr	AIZPlaneIntro_Index(pc,d1.w)
		jsr	(Sonic_Load_PLC).l
		bsr.w	sub_67A08
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
AIZPlaneIntro_Index:
		dc.w loc_674AC-AIZPlaneIntro_Index
		dc.w loc_67514-AIZPlaneIntro_Index
		dc.w loc_67536-AIZPlaneIntro_Index
		dc.w loc_67560-AIZPlaneIntro_Index
		dc.w loc_67594-AIZPlaneIntro_Index
		dc.w loc_675C0-AIZPlaneIntro_Index
		dc.w loc_67614-AIZPlaneIntro_Index
		dc.w loc_67624-AIZPlaneIntro_Index
		dc.w loc_6764E-AIZPlaneIntro_Index
		dc.w loc_67674-AIZPlaneIntro_Index
		dc.w loc_676AC-AIZPlaneIntro_Index
		dc.w loc_676C6-AIZPlaneIntro_Index
		dc.w loc_676E8-AIZPlaneIntro_Index
		dc.w loc_67704-AIZPlaneIntro_Index
; ---------------------------------------------------------------------------

loc_674AC:
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
		move.l	#loc_6751A,$34(a0)
		move.w	#8,$40(a0)
		move.w	#$E918,(Events_fg_1).w
		move.b	#-1,(Player_prev_frame).w
		lea	(Player_1).w,a1
		move.b	#0,mapping_frame(a1)
		move.b	#$53,object_control(a1)

locret_67512:
		rts
; ---------------------------------------------------------------------------

loc_67514:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6751A:
		move.b	#4,routine(a0)
		move.w	#$300,x_vel(a0)
		move.w	#$600,y_vel(a0)
		lea	ChildObjDat_67A5A(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_67536:
		subi.w	#$18,y_vel(a0)
		beq.s	loc_67544
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_67544:
		move.b	#6,routine(a0)
		clr.w	x_vel(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_67572,$34(a0)
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_67560:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_67572:
		move.b	#8,routine(a0)
		move.w	#$400,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		move.l	#byte_67A84,$30(a0)
		bset	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_67594:
		subi.w	#$40,x_vel(a0)
		jsr	(MoveSprite).l
		cmpi.w	#$130,y_pos(a0)
		bhs.s	loc_675AE
		jmp	(loc_67A20).l
; ---------------------------------------------------------------------------

loc_675AE:
		move.b	#$A,routine(a0)
		move.w	#$130,y_pos(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_675C0:
		subi.w	#$40,x_vel(a0)
		jsr	(MoveSprite2).l
		cmpi.w	#$40,x_pos(a0)
		blo.s	loc_675D6
		rts
; ---------------------------------------------------------------------------

loc_675D6:
		move.b	#$C,routine(a0)
		move.w	#$40,x_pos(a0)
		move.w	#5,$2E(a0)
		move.l	#loc_675FA,$34(a0)
		move.w	#$3F,$3A(a0)
		bra.w	loc_67996
; ---------------------------------------------------------------------------

loc_675FA:
		move.w	#5,$2E(a0)
		cmpi.w	#$80,x_pos(a0)
		blo.w	locret_67512
		lea	ChildObjDat_67A70(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_67614:
		subq.w	#1,$3A(a0)
		bpl.w	locret_67512
		move.b	#$E,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_67624:
		bsr.w	sub_679B8
		jsr	(Obj_Wait).l
		move.w	x_pos(a0),d0
		addq.w	#4,d0
		move.w	d0,x_pos(a0)
		cmpi.w	#$200,d0
		bhs.s	loc_67640
		rts
; ---------------------------------------------------------------------------

loc_67640:
		move.b	#$10,routine(a0)
		move.w	#$1F,$3A(a0)
		rts
; ---------------------------------------------------------------------------

loc_6764E:
		bsr.w	sub_679B8
		jsr	(Obj_Wait).l
		subq.w	#1,$3A(a0)
		bpl.w	locret_67512
		move.b	#$12,routine(a0)
		bset	#2,$38(a0)
		move.w	#$C,$40(a0)
		rts
; ---------------------------------------------------------------------------

loc_67674:
		bsr.w	sub_679B8
		jsr	(Obj_Wait).l
		move.w	x_pos(a0),d0
		subi.w	#4,d0
		move.w	d0,x_pos(a0)
		cmpi.w	#$120,d0
		bls.s	loc_67692
		rts
; ---------------------------------------------------------------------------

loc_67692:
		move.b	#$14,routine(a0)
		bset	#2,$38(a0)
		move.w	#$1F,$3A(a0)
		move.w	#$10,$40(a0)
		rts
; ---------------------------------------------------------------------------

loc_676AC:
		bsr.w	sub_679B8
		jsr	(Obj_Wait).l
		subq.w	#1,$3A(a0)
		bpl.w	locret_67512
		move.b	#$16,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_676C6:
		bsr.w	sub_679B8
		cmpi.w	#$918,(Player_1+x_pos).w
		bhs.s	loc_676D8
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_676D8:
		move.b	#$18,routine(a0)
		lea	ChildObjDat_67A78(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_676E8:
		bsr.w	sub_679B8
		cmpi.w	#$1240,(Player_1+x_pos).w
		bhs.s	loc_676F6
		rts
; ---------------------------------------------------------------------------

loc_676F6:
		move.b	#$1A,routine(a0)
		subi.w	#$20,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_67704:
		bsr.w	sub_679B8
		cmpi.w	#$13D0,(Player_1+x_pos).w
		bhs.s	loc_67712
		rts
; ---------------------------------------------------------------------------

loc_67712:
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

loc_67764:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_67764
		lea	ChildObjDat_67A7E(pc),a2
		jsr	(CreateChild6_Simple).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_6777A:
		move.l	#loc_677CE,(a0)
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
		lea	ChildObjDat_67A62(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_677CE:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		beq.s	loc_677EC
		move.l	#loc_67800,(a0)

loc_677EC:
		btst	#3,$38(a1)
		bne.s	loc_677FA
		jsr	(Refresh_ChildPosition).l

loc_677FA:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_67800:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		subq.w	#4,x_pos(a0)
		cmpi.w	#$20,x_pos(a0)
		blo.s	loc_6781E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6781E:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_67824:
		move.l	#Map_AIZIntroPlane,mappings(a0)
		move.w	#make_art_tile($529,0,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#4,width_pixels(a0)
		move.b	#$C,width_pixels(a0)
		move.l	#loc_6784A,(a0)

loc_6784A:
		lea	(byte_67A8F).l,a1
		jsr	(Animate_RawNoSST).l
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_67862:
		move.l	#Map_AIZIntroPlane,mappings(a0)
		move.w	#make_art_tile($529,0,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#4,width_pixels(a0)
		move.b	#$C,width_pixels(a0)
		move.l	#loc_67888,(a0)

loc_67888:
		lea	(byte_67A97).l,a1
		jsr	(Animate_RawNoSST).l
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_678A0:
		move.l	#loc_678DA,(a0)
		move.l	#Map_AIZIntroWaves,mappings(a0)
		move.w	#make_art_tile($3D1,0,0),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$10,width_pixels(a0)
		bset	#0,render_flags(a0)
		movea.w	parent3(a0),a1
		move.l	#byte_67A9B,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)

loc_678DA:
		cmpi.w	#$60,x_pos(a0)
		blo.s	loc_678FA
		movea.w	parent3(a0),a1
		move.w	$40(a1),d0
		sub.w	d0,x_pos(a0)
		jsr	(Animate_RawMultiDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_678FA:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_67900:
		lea	ObjDat3_67A4E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	subtype(a0),d0
		lsr.b	#1,d0
		move.b	d0,mapping_frame(a0)
		move.l	#loc_67938,(a0)
		move.b	#4,y_radius(a0)
		lea	(Player_1).w,a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		moveq	#$40,d0
		jsr	(Set_IndexedVelocity).l

loc_67938:
		jsr	(MoveSprite).l
		tst.l	d0
		bmi.s	loc_67956
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	loc_67956
		add.w	d1,y_pos(a0)
		move.l	#loc_6795C,(a0)

loc_67956:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6795C:
		movea.w	(_unkFAA4).w,a1
		move.w	x_pos(a0),d0
		move.w	x_pos(a1),d1
		subq.w	#8,d0
		cmp.w	d0,d1
		blo.s	loc_67976
		addi.w	#2*8,d0
		cmp.w	d0,d1
		blo.s	loc_6797C

loc_67976:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6797C:
		move.w	x_vel(a1),d0
		btst	#1,subtype(a0)
		beq.s	loc_6798A
		neg.w	d0

loc_6798A:
		tst.w	d0
		bmi.w	locret_67512
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_67996:
		move.l	#Map_SuperSonic,mappings(a0)
		move.b	#$21,mapping_frame(a0)
		move.b	#0,(Palette_timer).w
		move.w	#$24,(Palette_frame).w
		move.w	#$7FFF,(Super_frame_count).w
		rts

; =============== S U B R O U T I N E =======================================


sub_679B8:
		move.b	#1,(Super_Sonic_Knux_flag).w
		move.b	#$21,mapping_frame(a0)
		btst	#1,(V_int_run_count+3).w
		beq.s	loc_679D2
		move.b	#$22,mapping_frame(a0)

loc_679D2:
		subq.b	#1,(Palette_timer).w
		bpl.s	locret_67A06
		move.b	#6,(Palette_timer).w
		lea	(PalCycle_SuperSonic).l,a1
		move.w	(Palette_frame).w,d0
		addq.w	#6,(Palette_frame).w
		cmpi.w	#$36,(Palette_frame).w
		blo.s	loc_679FA
		move.w	#$24,(Palette_frame).w

loc_679FA:
		lea	(Normal_palette+$4).w,a2
		move.l	(a1,d0.w),(a2)+
		move.w	4(a1,d0.w),(a2)

locret_67A06:
		rts
; End of function sub_679B8


; =============== S U B R O U T I N E =======================================


sub_67A08:
		move.w	$40(a0),d1
		move.w	(Events_fg_1).w,d0
		bpl.s	loc_67A1A
		add.w	d1,d0
		move.w	d0,(Events_fg_1).w
		rts
; ---------------------------------------------------------------------------

loc_67A1A:
		add.w	d1,(Player_1+x_pos).w
		rts
; End of function sub_67A08

; ---------------------------------------------------------------------------

loc_67A20:
		movea.l	$30(a0),a1
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_67A4C
		move.b	(a1),anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#1,d0
		cmp.b	1(a1),d0
		blo.s	loc_67A3E
		moveq	#0,d0

loc_67A3E:
		move.b	d0,anim_frame(a0)
		moveq	#0,d1
		move.b	2(a1,d0.w),d1
		move.b	d1,mapping_frame(a0)

locret_67A4C:
		rts
; ---------------------------------------------------------------------------
ObjDat3_67A4E:
		dc.l Map_AIZIntroEmeralds
		dc.w make_art_tile($5B1,3,0)
		dc.w   $280
		dc.b    4,   4,   1,   0
ChildObjDat_67A5A:
		dc.w 1-1
		dc.l loc_6777A
		dc.b -$22, $2C
ChildObjDat_67A62:
		dc.w 2-1
		dc.l loc_67824
		dc.b  $38,   4
		dc.l loc_67862
		dc.b  $18, $18
ChildObjDat_67A70:
		dc.w 1-1
		dc.l loc_678A0
		dc.b    0, $18
ChildObjDat_67A78:
		dc.w 1-1
		dc.l Obj_CutsceneKnuckles
ChildObjDat_67A7E:
		dc.w 7-1
		dc.l loc_67900
byte_67A84:
		dc.b    3,   8
		dc.b  $97, $96
		dc.b  $98, $96
		dc.b  $99, $96
		dc.b  $9A, $96
		dc.b  $FC
byte_67A8F:
		dc.b    0,   1,   2,   3,   4,   3,   2, $FC
byte_67A97:
		dc.b    0,   5,   6, $FC
byte_67A9B:
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
