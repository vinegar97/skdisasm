Obj_AIZEndBoss:
		move.w	#$4880,d0
		cmp.w	(Camera_X_pos).w,d0
		bls.s	loc_470BE			; Only branch if Sonic has reached the boss area
		rts
; ---------------------------------------------------------------------------

loc_470BE:
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		move.l	#Obj_Wait,(a0)			; Set up object to wait $78 frames
		move.w	#2*60,$2E(a0)
		move.l	#Obj_AIZEndBossMusic,$34(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.b	#1,(Boss_flag).w		; Lock the screen
		clr.b	(_unkFAA3).w
		moveq	#$6B,d0
		jsr	(Load_PLC).l					; Load Robotnik's ship and explosions
		lea	(ArtKosM_AIZEndBoss).l,a1
		move.w	#tiles_to_bytes($180),d2
		jsr	(Queue_Kos_Module).l		; Load the AIZ boss ship
		lea	Pal_AIZEndBoss(pc),a1
		jmp	(PalLoad_Line1).l				; Load the AIZ boss palette
; ---------------------------------------------------------------------------

Obj_AIZEndBossMusic:
		move.l	#Obj_AIZEndBossMain,(a0)
		moveq	#signextendB(mus_EndBoss),d0					; Play the boss music
		jsr	(Play_Music).l
		rts
; ---------------------------------------------------------------------------

Obj_AIZEndBossMain:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	AIZ_EndBossIndex(pc,d0.w),d1
		jsr	AIZ_EndBossIndex(pc,d1.w)
		btst	#6,$38(a0)
		bne.w	locret_47246			; Only draw and touch when boss has revealed itself
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
AIZ_EndBossIndex:
		dc.w Obj_AIZEndBossInit-AIZ_EndBossIndex
		dc.w loc_471C2-AIZ_EndBossIndex
		dc.w loc_4720C-AIZ_EndBossIndex
		dc.w loc_47248-AIZ_EndBossIndex
		dc.w loc_472C2-AIZ_EndBossIndex
		dc.w loc_471C2-AIZ_EndBossIndex
		dc.w loc_47328-AIZ_EndBossIndex
		dc.w loc_47348-AIZ_EndBossIndex
; ---------------------------------------------------------------------------

Obj_AIZEndBossInit:
		lea	ObjDat_AIZEndBoss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#8,collision_property(a0)	; 8 hits defeats it
		bset	#0,render_flags(a0)
		lea	(Child1_MakeRoboShip).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	loc_47176
		move.b	#8,subtype(a1)

loc_47176:
		lea	ChildObjDat_47B6E(pc),a2
		jsr	(CreateChild1_Normal).l

loc_47180:
		move.b	#2,routine(a0)
		moveq	#signextendB(sfx_WaterfallSplash),d0
		jsr	(Play_SFX).l
		ori.b	#$48,$38(a0)
		move.l	#loc_471E2,$34(a0)
		clr.b	collision_flags(a0)
		bsr.w	sub_47AEA
		bclr	#0,render_flags(a0)
		cmpi.w	#8,angle(a0)
		bhs.s	loc_471B8
		bset	#0,render_flags(a0)

loc_471B8:
		lea	ChildObjDat_47B84(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_471C2:
		lea	byte_47BEE(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		bclr	#6,$38(a0)
		cmpi.b	#$2B,mapping_frame(a0)
		bne.s	locret_471E0
		bset	#6,$38(a0)

locret_471E0:
		rts
; ---------------------------------------------------------------------------

loc_471E2:
		move.b	#4,routine(a0)
		bclr	#6,$38(a0)
		bset	#7,art_tile(a0)
		move.b	#$16,collision_flags(a0)
		move.l	#loc_4721A,$34(a0)
		lea	ChildObjDat_47B8C(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4720C:
		lea	byte_47C09(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		bra.w	sub_47A20
; ---------------------------------------------------------------------------

loc_4721A:
		move.b	#6,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_4725E,$34(a0)
		move.w	#$C0,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#$10,$40(a0)
		bclr	#0,$38(a0)

locret_47246:
		rts
; ---------------------------------------------------------------------------

loc_47248:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jsr	(Obj_Wait).l
		bra.w	sub_47A20
; ---------------------------------------------------------------------------

loc_4725E:
		bset	#1,$38(a0)
		btst	#7,$38(a0)
		bne.s	loc_47282
		move.w	#4,angle(a0)
		move.w	#$2F,$2E(a0)
		move.l	#loc_472AE,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_47282:
		move.w	#$BF,$2E(a0)
		move.l	#loc_47292,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_47292:
		move.b	#8,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_472CC,$34(a0)
		andi.b	#$F5,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_472AE:
		st	(_unkFAA2).w
		move.w	#$8F,$2E(a0)
		move.l	#loc_47292,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_472C2:
		bsr.w	sub_47A20
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_472CC:
		move.b	#$A,routine(a0)
		moveq	#signextendB(sfx_WaterfallSplash),d0
		jsr	(Play_SFX).l
		move.l	#loc_472FC,$34(a0)
		clr.b	collision_flags(a0)
		bsr.w	sub_47AEA
		lea	ChildObjDat_47B84(pc),a2
		jsr	(CreateChild1_Normal).l
		move.b	#2,subtype(a1)
		rts
; ---------------------------------------------------------------------------

loc_472FC:
		move.b	#$C,routine(a0)
		bset	#7,$38(a0)
		beq.s	loc_47310
		move.b	#$E,routine(a0)

loc_47310:
		move.l	#loc_47354,$34(a0)
		bclr	#7,art_tile(a0)
		move.b	#0,mapping_frame(a0)
		bra.w	loc_478AC
; ---------------------------------------------------------------------------

loc_47328:
		move.w	(Camera_max_X_pos).w,d0
		addq.w	#2,d0
		cmpi.w	#$49A0,d0
		bcc.s	loc_47338
		move.w	d0,(Camera_max_X_pos).w

loc_47338:
		move.w	(Camera_min_X_pos).w,d0
		addq.w	#2,d0
		cmpi.w	#$48E0,d0
		bcc.s	loc_47348
		move.w	d0,(Camera_min_X_pos).w

loc_47348:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_47354:
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		bra.w	loc_47180
; ---------------------------------------------------------------------------

loc_47360:
		move.l	#loc_47390,$34(a0)
		st	(_unkFAA3).w
		move.l	#Obj_Wait,(a0)
		bset	#4,$38(a0)
		move.w	#$7F,$2E(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		lea	ChildObjDat_47BBC(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_47390:
		move.l	#loc_473C6,(a0)

loc_47396:
		st	(_unkFAA8).w
		clr.b	(Boss_flag).w
		jsr	(Restore_LevelMusic).l
		lea	(PLC_EggCapsule).l,a1
		jsr	(Load_PLC_Raw).l
		lea	ChildObjDat_47BE2(pc),a2
		jsr	(CreateChild6_Simple).l
		bset	#1,render_flags(a1)
		jmp	(PLCLoad_AnimalsAndExplosion).l
; ---------------------------------------------------------------------------

loc_473C6:
		tst.b	(_unkFAA8).w
		bne.w	locret_47246
		move.l	#loc_47402,(a0)
		clr.b	(_unkFAA8).w
		jsr	(Restore_PlayerControl).l
		lea	(Player_2).w,a1
		jsr	(Restore_PlayerControl2).l
		clr.w	(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		move.w	#$48E0+$158,(Camera_stored_max_X_pos).w
		lea	(Child6_IncLevX).l,a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_47402:
		move.b	#5,(Flying_picking_Sonic_timer).w
		lea	(Player_1).w,a1
		cmpi.w	#$48E0+$1F8,x_pos(a1)
		bcc.s	loc_4741C
		move.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_1_logical).w
		rts
; ---------------------------------------------------------------------------

loc_4741C:
		move.l	#loc_4744A,(a0)
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		clr.w	ground_vel(a1)
		lea	ChildObjDat_47BE8(pc),a2
		jsr	(CreateChild6_Simple).l
		move.b	#4,subtype(a1)
		lea	(PLC_Explosion).l,a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

loc_4744A:
		move.b	#5,(Flying_picking_Sonic_timer).w
		tst.b	(Ctrl_1_locked).w
		beq.s	loc_4745E
		move.w	#(button_up_mask<<8)|button_up_mask,(Ctrl_1_logical).w
		rts
; ---------------------------------------------------------------------------

loc_4745E:
		move.l	#loc_47466,(a0)
		rts
; ---------------------------------------------------------------------------

loc_47466:
		move.b	#5,(Flying_picking_Sonic_timer).w
		cmpi.w	#$15A+$1E6,(Player_1+y_pos).w
		bcc.s	loc_47476
		rts
; ---------------------------------------------------------------------------

loc_47476:
		move.w	#$100,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_47486:
		jsr	(Refresh_ChildPositionAdjusted).l
		bsr.w	Child_SyncDraw
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_474B2(pc,d0.w),d1
		jsr	off_474B2(pc,d1.w)
		btst	#6,$38(a0)
		bne.w	locret_47246
		bsr.w	sub_47AFA
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_474B2:
		dc.w loc_474BE-off_474B2
		dc.w loc_474E6-off_474B2
		dc.w loc_47518-off_474B2
		dc.w loc_4752E-off_474B2
		dc.w loc_47546-off_474B2
		dc.w loc_47568-off_474B2
; ---------------------------------------------------------------------------

loc_474BE:
		lea	word_47B36(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		moveq	#0,d0
		tst.b	subtype(a0)
		beq.s	loc_474DC
		move.b	#$2A,mapping_frame(a0)
		move.w	#$280,priority(a0)

loc_474DC:
		lea	ChildObjDat_47B7C(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_474E6:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	loc_474F4
		rts
; ---------------------------------------------------------------------------

loc_474F4:
		tst.b	subtype(a0)
		bne.s	loc_47510
		move.b	#4,routine(a0)
		move.w	#4,$2E(a0)
		move.l	#loc_4751E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_47510:
		move.b	#8,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_47518:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4751E:
		move.b	#6,routine(a0)
		move.l	#loc_4753E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4752E:
		bclr	#6,$38(a0)
		lea	byte_47C14(pc),a1
		jmp	(Animate_RawNoSSTMultiDelay).l
; ---------------------------------------------------------------------------

loc_4753E:
		move.b	#8,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_47546:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	loc_47554
		rts
; ---------------------------------------------------------------------------

loc_47554:
		move.b	#$A,routine(a0)
		bset	#1,$38(a0)
		move.w	angle(a1),angle(a0)
		rts
; ---------------------------------------------------------------------------

loc_47568:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		beq.s	loc_47576
		rts
; ---------------------------------------------------------------------------

loc_47576:
		move.b	#2,routine(a0)
		bclr	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_47584:
		move.l	#Obj_FlickerMove,(a0)
		move.b	#1,mapping_frame(a0)
		clr.b	collision_flags(a0)
		moveq	#$C,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

loc_4759C:
		bsr.w	Child_SyncDraw
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_475C4(pc,d0.w),d1
		jsr	off_475C4(pc,d1.w)
		jsr	(Refresh_ChildPositionAdjusted).l
		btst	#6,$38(a0)
		bne.w	locret_47246
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------
off_475C4:
		dc.w loc_475CC-off_475C4
		dc.w loc_475D8-off_475C4
		dc.w loc_47618-off_475C4
		dc.w loc_47664-off_475C4
; ---------------------------------------------------------------------------

loc_475CC:
		lea	word_47B3C(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		rts
; ---------------------------------------------------------------------------

loc_475D8:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	loc_475E6
		rts
; ---------------------------------------------------------------------------

loc_475E6:
		move.b	#4,routine(a0)
		move.b	#1,anim_frame(a0)
		bset	#1,$38(a0)
		move.l	#loc_47636,$34(a0)
		move.w	angle(a1),angle(a0)
		clr.w	$2E(a0)
		tst.b	subtype(a1)
		beq.s	locret_47616
		move.w	#$4F,$2E(a0)

locret_47616:
		rts
; ---------------------------------------------------------------------------

loc_47618:
		subq.w	#1,$2E(a0)
		bpl.s	locret_47634
		move.w	#3,$2E(a0)
		bsr.w	sub_47916
		subq.b	#1,anim_frame(a0)
		bpl.s	locret_47634
		movea.l	$34(a0),a1
		jsr	(a1)

locret_47634:
		rts
; ---------------------------------------------------------------------------

loc_47636:
		move.b	#6,routine(a0)
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)
		move.w	#$5F,$2E(a0)
		move.l	#loc_4766A,$34(a0)
		bra.w	loc_4799C
; ---------------------------------------------------------------------------

loc_47658:
		move.b	#2,routine(a0)
		clr.b	$39(a0)
		rts
; ---------------------------------------------------------------------------

loc_47664:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4766A:
		move.b	#4,routine(a0)
		move.b	#1,anim_frame(a0)
		bclr	#1,$38(a0)
		clr.w	$2E(a0)
		move.l	#loc_47658,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4768A:
		lea	word_47B42(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_476E4,(a0)
		bset	#4,shield_reaction(a0)
		move.l	#loc_47702,$34(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a2
		movea.w	parent3(a2),a2
		move.w	a2,$44(a0)
		move.w	angle(a1),d0
		move.w	d0,angle(a0)
		move.l	off_476D4(pc,d0.w),$30(a0)
		cmpi.w	#8,d0
		bhs.s	locret_476D2
		bset	#0,render_flags(a0)

locret_476D2:
		rts
; ---------------------------------------------------------------------------
off_476D4:
		dc.l byte_47C1F
		dc.l byte_47C49
		dc.l byte_47C49
		dc.l byte_47C1F
; ---------------------------------------------------------------------------

loc_476E4:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		bne.s	loc_4770C
		jsr	(Refresh_ChildPosition).l
		jsr	(Animate_Raw).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_47702:
		lea	ChildObjDat_47BAC(pc),a2
		jsr	(CreateChild1_Normal).l

loc_4770C:
		bset	#6,$38(a0)
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_47718:
		lea	word_47B48(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		bset	#4,shield_reaction(a0)
		moveq	#signextendB(sfx_Projectile),d0
		jsr	(Play_SFX).l
		move.b	#$C,y_radius(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_4774E,(a0)
		move.l	#loc_4778C,$34(a0)
		bra.w	loc_479B8
; ---------------------------------------------------------------------------

loc_4774E:
		tst.w	x_vel(a0)
		beq.s	loc_4775A
		jsr	(ObjHitFloor_DoRoutine).l

loc_4775A:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bmi.s	loc_47786
		move.b	(V_int_run_count+3).w,d0
		andi.b	#3,d0
		bne.s	loc_47780
		lea	ChildObjDat_47BB4(pc),a2
		jsr	(CreateChild1_Normal).l

loc_47780:
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_47786:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4778C:
		move.l	#loc_4775A,(a0)
		move.l	#byte_47C7F,$30(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_477A0:
		lea	word_47B4E(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_477D0,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		move.l	#byte_47C85,$30(a0)
		tst.w	x_vel(a0)
		bne.s	locret_477CE
		move.l	#byte_47C8E,$30(a0)

locret_477CE:
		rts
; ---------------------------------------------------------------------------

loc_477D0:
		jsr	(Animate_RawMultiDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_477DC:
		lea	ObjDat_AIZEndBoss2(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_477F6,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_477F6:
		lea	byte_47C97(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_47806:
		lea	word_47B54(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_47830,(a0)
		tst.b	subtype(a0)
		bne.s	loc_47826
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_47826:
		move.l	#loc_4784A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_47830:
		lea	byte_47CA0(pc),a1
		jsr	(Animate_RawNoSSTMultiDelayFlipX).l
		cmpi.b	#$2B,mapping_frame(a0)
		beq.w	locret_47246
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4784A:
		move.l	#loc_47860,(a0)
		move.w	#$800,y_vel(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_47860:
		jsr	(MoveSprite2).l
		lea	byte_47CBB(pc),a1
		jsr	(Animate_RawNoSSTMultiDelayFlipX).l
		cmpi.b	#$2B,mapping_frame(a0)
		beq.w	locret_47246
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_47880:
		lea	word_47B68(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#Obj_FlickerMove,(a0)
		move.b	subtype(a0),d0
		lsr.b	#1,d0
		addi.b	#$32,d0
		move.b	d0,mapping_frame(a0)
		moveq	#0,d0
		jsr	(Set_IndexedVelocity).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_478AC:
		jsr	(Random_Number).l
		andi.w	#$C,d0
		move.w	angle(a0),d1
		move.w	d0,angle(a0)
		cmp.w	d1,d0
		beq.s	loc_478AC
		lea	word_47906(pc,d0.w),a1
		moveq	#0,d2
		move.w	(a1)+,d2
		swap	d2
		sub.l	x_pos(a0),d2
		add.l	d2,d2
		swap	d2
		move.w	d2,x_vel(a0)
		moveq	#0,d3
		move.w	(a1)+,d3
		swap	d3
		sub.l	y_pos(a0),d3
		add.l	d3,d3
		swap	d3
		move.w	d3,y_vel(a0)
		move.w	#$7F,$2E(a0)
		tst.w	d2
		beq.s	locret_47904
		bclr	#0,render_flags(a0)
		tst.w	d2
		bmi.s	locret_47904
		bset	#0,render_flags(a0)

locret_47904:
		rts
; ---------------------------------------------------------------------------
word_47906:
		dc.w  $48E0+$058, $15A+$76
		dc.w  $48E0+$0A0, $15A+$46
		dc.w  $48E0+$160, $15A+$46
		dc.w  $48E0+$1A8, $15A+$76

; =============== S U B R O U T I N E =======================================


sub_47916:
		move.w	angle(a0),d0
		moveq	#0,d1
		eori.w	#$C,d0
		beq.s	loc_4792C
		cmpi.w	#$C,d0
		beq.s	loc_4792C
		addi.w	#$10,d1

loc_4792C:
		moveq	#0,d2
		move.b	$39(a0),d2
		add.w	d2,d1
		lea	byte_4794C(pc,d1.w),a1
		move.b	(a1)+,child_dx(a0)
		move.b	(a1)+,child_dy(a0)
		move.b	(a1)+,mapping_frame(a0)
		addq.b	#4,d2
		move.b	d2,$39(a0)
		rts
; End of function sub_47916

; ---------------------------------------------------------------------------
byte_4794C:
		dc.b -$18,   8,   5
		even
		dc.b -$18,   8,   5
		even
		dc.b -$1C,   0,   4
		even
		dc.b -$1C,   0,   4
		even
		dc.b -$18,   8,   5
		even
		dc.b -$10, $10,   6
		even
		dc.b -$18,   8,   5
		even
		dc.b -$1C,   0,   4
		even

; =============== S U B R O U T I N E =======================================


Child_SyncDraw:
		movea.w	parent3(a0),a1
		btst	#6,$38(a1)
		bne.s	loc_47994
		bclr	#6,$38(a0)
		bset	#7,art_tile(a0)
		btst	#7,art_tile(a1)
		bne.s	locret_47992
		bclr	#7,art_tile(a0)

locret_47992:
		rts
; ---------------------------------------------------------------------------

loc_47994:
		bset	#6,$38(a0)
		rts
; End of function Child_SyncDraw

; ---------------------------------------------------------------------------

loc_4799C:
		move.w	angle(a0),d0
		lsr.w	#1,d0
		move.w	off_479B0(pc,d0.w),d0
		lea	off_479B0(pc,d0.w),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------
off_479B0:
		dc.w ChildObjDat_47B94-off_479B0
		dc.w ChildObjDat_47B9C-off_479B0
		dc.w ChildObjDat_47B9C-off_479B0
		dc.w ChildObjDat_47BA4-off_479B0
; ---------------------------------------------------------------------------

loc_479B8:
		movea.w	parent3(a0),a1
		move.w	angle(a1),d0
		cmpi.w	#8,d0
		bhs.s	loc_479CC
		bset	#0,render_flags(a0)

loc_479CC:
		move.l	off_479F0(pc,d0.w),$30(a0)
		lea	word_47A00(pc,d0.w),a1
		move.w	(a1)+,d1
		add.w	d1,x_pos(a0)
		move.w	(a1)+,d1
		add.w	d1,y_pos(a0)
		lea	word_47A10(pc,d0.w),a1
		move.w	(a1)+,x_vel(a0)
		move.w	(a1)+,y_vel(a0)
		rts
; ---------------------------------------------------------------------------
off_479F0:
		dc.l byte_47C73
		dc.l byte_47C79
		dc.l byte_47C79
		dc.l byte_47C73
word_47A00:
		dc.w    $14,   $14
		dc.w      0,   $18
		dc.w      0,   $18
		dc.w   -$14,   $14
word_47A10:
		dc.w   $300,  $300
		dc.w      0,  $400
		dc.w      0,  $400
		dc.w  -$300,  $300

; =============== S U B R O U T I N E =======================================


sub_47A20:
		tst.b	collision_flags(a0)
		bne.s	locret_47A72
		tst.b	collision_property(a0)
		beq.s	loc_47A74
		tst.b	$20(a0)
		bne.s	loc_47A40
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

loc_47A40:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_47A54
		addi.w	#2*7,d0

loc_47A54:
		bsr.w	sub_47A9A
		subq.b	#1,$20(a0)
		bne.s	locret_47A72
		bclr	#6,status(a0)
		cmpi.b	#0,mapping_frame(a0)
		bne.s	locret_47A72
		move.b	$25(a0),collision_flags(a0)

locret_47A72:
		rts
; ---------------------------------------------------------------------------

loc_47A74:
		move.l	#Wait_Draw,(a0)
		bclr	#6,$38(a0)
		bset	#7,art_tile(a0)
		move.b	#0,mapping_frame(a0)
		move.l	#loc_47360,$34(a0)
		jmp	(BossDefeated_StopTimer).l
; End of function sub_47A20


; =============== S U B R O U T I N E =======================================


sub_47A9A:
		lea	word_47AC0(pc),a1
		lea	word_47ACE(pc,d0.w),a2
	rept 7
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
	endm
		rts
; End of function sub_47A9A

; ---------------------------------------------------------------------------
word_47AC0:
		dc.w Normal_palette_line_2+$08, Normal_palette_line_2+$0E, Normal_palette_line_2+$12, Normal_palette_line_2+$14
		dc.w Normal_palette_line_2+$16, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_47ACE:
		dc.w   $222,     8,   $4C,     6,   $20,  $A24,  $622
		dc.w   $AAA,  $AAA,  $AAA,  $CCC,  $EEE,  $666,  $888

; =============== S U B R O U T I N E =======================================


sub_47AEA:
		moveq	#0,d0
		bsr.s	sub_47A9A
		bclr	#6,status(a0)
		clr.b	$20(a0)
		rts
; End of function sub_47AEA


; =============== S U B R O U T I N E =======================================


sub_47AFA:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_47B08
		rts
; ---------------------------------------------------------------------------

loc_47B08:
		move.l	#Wait_Draw,(a0)
		bset	#7,status(a0)
		move.b	#1,mapping_frame(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_47584,$34(a0)
		rts
; End of function sub_47AFA

; ---------------------------------------------------------------------------
ObjDat_AIZEndBoss:
		dc.l Map_AIZEndBoss
		dc.w make_art_tile($180,1,1)	; VRAM
		dc.w   $280			; Priority
		dc.b  $28, $20,   0, $10	; Width, Height, Frame, Collision
word_47B36:
		dc.w   $200
		dc.b  $24, $14,   1,   0
word_47B3C:
		dc.w   $180
		dc.b   $C,  $C,   4,   0
word_47B42:
		dc.w   $100
		dc.b    8,   4,  $B, $97
word_47B48:
		dc.w   $100
		dc.b  $14, $18,  $F, $9A
word_47B4E:
		dc.w   $100
		dc.b    8,   8, $18,   0
word_47B54:
		dc.w make_art_tile($180,0,1)
		dc.w   $100
		dc.b  $30, $30, $24,   0
ObjDat_AIZEndBoss2:
		dc.l Map_AIZEndBoss
		dc.w make_art_tile($180,0,1)
		dc.w   $100
		dc.b  $18, $10, $21,   0
word_47B68:
		dc.w   $180
		dc.b  $10, $10,   0,   0
ChildObjDat_47B6E:
		dc.w 2-1
		dc.l loc_47486
		dc.b  $14,  -4
		dc.l loc_47486
		dc.b -$14,  -4
ChildObjDat_47B7C:
		dc.w 1-1
		dc.l loc_4759C
		dc.b -$1C,   0
ChildObjDat_47B84:
		dc.w 1-1
		dc.l loc_47806
		dc.b    0,   0
ChildObjDat_47B8C:
		dc.w 1-1
		dc.l loc_477DC
		dc.b    0,-$30
ChildObjDat_47B94:
		dc.w 1-1
		dc.l loc_4768A
		dc.b    3,   5
ChildObjDat_47B9C:
		dc.w 1-1
		dc.l loc_4768A
		dc.b    0,   7
ChildObjDat_47BA4:
		dc.w 1-1
		dc.l loc_4768A
		dc.b   -3,   5
ChildObjDat_47BAC:
		dc.w 1-1
		dc.l loc_47718
		dc.b    0,   0
ChildObjDat_47BB4:
		dc.w 1-1
		dc.l loc_477A0
		dc.b    0,   0
ChildObjDat_47BBC:
		dc.w 6-1
		dc.l loc_47880
		dc.b -$10,-$10
		dc.l loc_47880
		dc.b  $10,-$10
		dc.l loc_47880
		dc.b -$10,   8
		dc.l loc_47880
		dc.b  $10,   8
		dc.l loc_47880
		dc.b  -$C, $18
		dc.l loc_47880
		dc.b   $C, $18
ChildObjDat_47BE2:
		dc.w 1-1
		dc.l Obj_EggCapsule
ChildObjDat_47BE8:
		dc.w 1-1
		dc.l Obj_CutsceneKnuckles
byte_47BEE:
		dc.b  $2B,   0
		dc.b  $2B,   0
		dc.b  $2B,   0
		dc.b    0,   0
		dc.b  $2B,   0
		dc.b  $2B,   0
		dc.b    0,   0
		dc.b  $2B,   0
		dc.b  $2B,   0
		dc.b    0,   0
		dc.b  $2B,   0
		dc.b  $2B,   0
		dc.b    0,   0
		dc.b  $F4
byte_47C09:
		dc.b  $1B,   0
		dc.b  $1B,   4
		dc.b  $1C,   5
		dc.b  $1D,   6
		dc.b    0,   0
		dc.b  $F4
byte_47C14:
		dc.b  $1E,   0
		dc.b  $1E,   4
		dc.b  $1F,   5
		dc.b  $20,   6
		dc.b    1,   0
		dc.b  $F4
byte_47C1F:
		dc.b    0
		dc.b    7, $2B
		dc.b    7, $2B
		dc.b    8, $2B
		dc.b    8, $2B
		dc.b    9, $2B
		dc.b    9, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b  $F4
byte_47C49:
		dc.b    0
		dc.b   $B, $2B
		dc.b   $B, $2B
		dc.b   $C, $2B
		dc.b   $C, $2B
		dc.b   $D, $2B
		dc.b   $D, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b  $F4
byte_47C73:
		dc.b    1, $26, $27, $28, $29, $FC
byte_47C79:
		dc.b    1, $16, $17, $2F, $30, $FC
byte_47C7F:
		dc.b    1, $10, $11, $2D, $2E, $FC
byte_47C85:
		dc.b  $12,   0
		dc.b  $12,   9
		dc.b  $13,   2
		dc.b  $14,   2
		dc.b  $F4
byte_47C8E:
		dc.b  $18,   0
		dc.b  $18,   9
		dc.b  $19,   2
		dc.b  $1A,   2
		dc.b  $F4
byte_47C97:
		dc.b  $21,   0
		dc.b  $21,   4
		dc.b  $22,   5
		dc.b  $23,   6
		dc.b  $F4
byte_47CA0:
		dc.b  $2B|$00,   0
		dc.b  $24|$00,   0
		dc.b  $24|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $2C|$00,   0
		dc.b  $2C|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $24|$00,   0
		dc.b  $24|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $2C|$00,   0
		dc.b  $2C|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $F4
byte_47CBB:
		dc.b  $2B|$00,   0
		dc.b  $24|$00,   0
		dc.b  $24|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $2C|$00,   0
		dc.b  $2C|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $31|$00,   0
		dc.b  $31|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $31|$00,   0
		dc.b  $31|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $F4
		even
Pal_AIZEndBoss:
		binclude "Levels/AIZ/Palettes/End Boss.bin"
		even
; ---------------------------------------------------------------------------
