Obj_GameOver:
		tst.l	(Nem_decomp_queue).w
		beq.s	loc_2C9B4
		rts
; ---------------------------------------------------------------------------

loc_2C9B4:
		move.w	#$50,x_pos(a0)
		btst	#0,mapping_frame(a0)
		beq.s	loc_2C9C8
		move.w	#$1F0,x_pos(a0)

loc_2C9C8:
		move.w	#$F0,y_pos(a0)
		move.l	#Map_GameOver,mappings(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,1),art_tile(a0)
		move.w	#0,priority(a0)
		move.l	#loc_2C9E8,(a0)

loc_2C9E8:
		moveq	#$10,d1
		cmpi.w	#$120,x_pos(a0)
		beq.s	loc_2CA00
		bcs.s	loc_2C9F6
		neg.w	d1

loc_2C9F6:
		add.w	d1,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2CA00:
		move.w	#8*60,anim_frame_timer(a0)
		move.l	#loc_2CA0E,(a0)
		rts
; ---------------------------------------------------------------------------

loc_2CA0E:
		move.w	#0,(Collision_response_list).w
		btst	#0,mapping_frame(a0)
		bne.w	loc_2CA60
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask|button_start_mask,d0
		bne.s	loc_2CA3C
		tst.w	anim_frame_timer(a0)
		beq.s	loc_2CA3C
		subq.w	#1,anim_frame_timer(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2CA3C:
		tst.b	(Time_over_flag).w
		bne.s	loc_2CA56
		move.b	#$14,(Game_mode).w
		tst.b	(Continue_count).w
		bne.s	loc_2CA60
		move.b	#0,(Game_mode).w
		bra.s	loc_2CA60
; ---------------------------------------------------------------------------

loc_2CA56:
		clr.l	(Saved_timer).w
		move.w	#1,(Restart_level_flag).w

loc_2CA60:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCard:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	TitleCard_Index(pc,d0.w),d1
		jmp	TitleCard_Index(pc,d1.w)
; ---------------------------------------------------------------------------
TitleCard_Index:
		dc.w Obj_TitleCardInit-TitleCard_Index
		dc.w Obj_TitleCardCreate-TitleCard_Index
		dc.w Obj_TitleCardWait-TitleCard_Index
		dc.w Obj_TitleCardWait2-TitleCard_Index
; ---------------------------------------------------------------------------

Obj_TitleCardInit:
		cmpi.b	#$E,(Current_zone).w
		blo.s	loc_2CA96			; If in any of the 2P stages, don't show title card
		cmpi.b	#$12,(Current_zone).w
		bhi.s	loc_2CA96
		st	$44(a0)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2CA96:
		lea	(ArtKosM_TitleCardRedAct).l,a1
		move.w	#tiles_to_bytes($500),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_TitleCardNum1).l,a1
		tst.b	(Apparent_act).w
		beq.s	loc_2CAB8
		lea	(ArtKosM_TitleCardNum2).l,a1

loc_2CAB8:
		move.w	#tiles_to_bytes($53D),d2
		jsr	(Queue_Kos_Module).l
		lea	TitleCard_LevelGfx(pc),a1
		moveq	#0,d0
		move.b	(Apparent_zone).w,d0
		lsl.w	#2,d0
		movea.l	(a1,d0.w),a1
		move.w	#tiles_to_bytes($54D),d2
		jsr	(Queue_Kos_Module).l
		move.w	#90,$2E(a0)			; Set wait value
		clr.w	$32(a0)
		st	$48(a0)
		addq.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

Obj_TitleCardCreate:
		tst.b	(Kos_modules_left).w
		bne.w	locret_2CB76		; Wait for KosM queue to clear
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_2CB76
		lea	ObjArray_TtlCardBonus(pc),a2
		moveq	#1,d1
		cmpi.b	#$13,(Current_zone).w
		bhs.s	loc_2CB20
		lea	ObjArray_TtlCard(pc),a2
		moveq	#3,d1
		tst.b	$44(a0)
		beq.s	loc_2CB20
		lea	ObjArray_TtlCard2(pc),a2
		moveq	#0,d1

loc_2CB20:
		addq.w	#1,$30(a0)
		move.l	(a2)+,(a1)
		move.w	(a2)+,$46(a1)
		move.w	(a2)+,x_pos(a1)
		move.w	(a2)+,y_pos(a1)
		move.b	(a2)+,mapping_frame(a1)
		move.b	(a2)+,width_pixels(a1)
		move.w	(a2)+,d2
		move.b	d2,$28(a1)
		move.b	#$40,render_flags(a1)
		move.l	#Map_TitleCard,mappings(a1)
		move.w	a0,parent2(a1)
		jsr	(CreateNewSprite4).l
		dbne	d1,loc_2CB20
		tst.b	$3E(a0)
		beq.s	loc_2CB72
		cmpi.b	#6,(Apparent_zone).w
		bne.s	loc_2CB72
		moveq	#$25,d0			; If title card is mid-level and it's in LBZ, load the LBZ 2 misc art
		jsr	(Load_PLC).l

loc_2CB72:
		addq.b	#2,routine(a0)

locret_2CB76:
		rts
; ---------------------------------------------------------------------------

Obj_TitleCardWait:
		tst.w	$34(a0)
		beq.s	loc_2CB84
		clr.w	$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_2CB84:
		tst.w	$3E(a0)
		beq.s	loc_2CBC0
		clr.l	(Timer).w			; If using in-level title card
		clr.w	(Ring_count).w			; Reset HUD rings and timer
		clr.w	(Total_ring_count).w		; Reset number of collected rings
		clr.b	(Extra_life_flags).w		; Reset extra life ring flag
		clr.l	(Timer_P2).w
		clr.w	(Ring_count_P2).w		; Reset actual rings and timer values
		clr.w	(Total_ring_count_P2).w
		st	(Update_HUD_timer).w
		st	(Update_HUD_ring_count).w	; Start updating timer and rings again
		move.b	#30,(Player_1+air_left).w
		move.b	#30,(Player_2+air_left).w	; Reset air
		jsr	(Restore_LevelMusic).l		; Play music

loc_2CBC0:
		clr.w	$48(a0)
		addq.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

Obj_TitleCardWait2:
		tst.w	$2E(a0)
		beq.s	loc_2CBD6
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_2CBD6:
		tst.w	$30(a0)
		beq.s	loc_2CBE2
		addq.w	#1,$32(a0)
		rts
; ---------------------------------------------------------------------------

loc_2CBE2:
		tst.b	$44(a0)
		bne.s	loc_2CC12
		cmpi.b	#$13,(Current_zone).w
		bhs.s	loc_2CC12
		tst.w	$3E(a0)
		beq.s	loc_2CBFC
		st	(End_of_level_flag).w	; If in-level, set end of title card flag. No need to reload PLCs
		bra.s	loc_2CC08
; ---------------------------------------------------------------------------

loc_2CBFC:
		lea	(PLC_SpikesSprings).l,a1	; Reload spikes
		jsr	(Load_PLC_Raw).l

loc_2CC08:
		jsr	LoadEnemyArt(pc)		; Load animals and enemies
		jsr	(PLCLoad_AnimalsAndExplosion).l

loc_2CC12:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCardRedBanner:
		movea.w	parent2(a0),a1
		move.w	$32(a1),d0
		beq.s	loc_2CC40
		tst.b	render_flags(a0)
		bmi.s	loc_2CC32
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2CC32:
		cmp.b	$28(a0),d0
		blo.s	loc_2CC56
		subi.w	#$20,y_pos(a0)
		bra.s	loc_2CC56
; ---------------------------------------------------------------------------

loc_2CC40:
		move.w	y_pos(a0),d0
		cmp.w	$46(a0),d0
		beq.s	loc_2CC56
		addi.w	#$10,d0
		move.w	d0,y_pos(a0)
		st	$34(a1)

loc_2CC56:
		move.b	#$70,height_pixels(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCardName:
		move.b	(Apparent_zone).w,d0
		add.b	d0,mapping_frame(a0)
		move.l	#Obj_TitleCardElement,(a0)

Obj_TitleCardElement:
		movea.w	parent2(a0),a1
		move.w	$32(a1),d0
		beq.s	loc_2CC98
		tst.b	render_flags(a0)
		bmi.s	loc_2CC8A
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2CC8A:
		cmp.b	$28(a0),d0
		blo.s	loc_2CCAE
		addi.w	#$20,x_pos(a0)
		bra.s	loc_2CCAE
; ---------------------------------------------------------------------------

loc_2CC98:
		move.w	x_pos(a0),d0
		cmp.w	$46(a0),d0
		beq.s	loc_2CCAE
		subi.w	#$10,d0
		move.w	d0,x_pos(a0)
		st	$34(a1)

loc_2CCAE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCardAct:
		move.l	#Obj_TitleCardElement,(a0)
		move.b	(Apparent_zone).w,d0
		cmpi.b	#$A,d0
		beq.s	loc_2CCCA
		cmpi.b	#$C,d0
		bne.s	Obj_TitleCardElement

loc_2CCCA:
		movea.w	parent2(a0),a1		; Sky Sanctuary and Doomsday do not have act numbers
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCardElement2:
		clr.b	render_flags(a0)	; I'm not entirely sure what this is used for
		movea.w	parent2(a0),a1
		move.w	$32(a1),d0
		beq.s	loc_2CD06
		cmpi.w	#$20C,x_pos(a0)
		blo.s	loc_2CCF8
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2CCF8:
		cmp.b	$28(a0),d0
		blo.s	loc_2CD1C
		addi.w	#$20,x_pos(a0)
		bra.s	loc_2CD1C
; ---------------------------------------------------------------------------

loc_2CD06:
		move.w	x_pos(a0),d0
		cmp.w	$46(a0),d0
		beq.s	loc_2CD1C
		subi.w	#$10,d0
		move.w	d0,x_pos(a0)
		st	$34(a1)

loc_2CD1C:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
TitleCard_LevelGfx:
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_HCZTitleCard
		dc.l ArtKosM_MGZTitleCard
		dc.l ArtKosM_CNZTitleCard
		dc.l ArtKosM_FBZTitleCard
		dc.l ArtKosM_ICZTitleCard
		dc.l ArtKosM_LBZTitleCard
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_AIZTitleCard
		dc.l ArtKosM_ALZTitleCard
		dc.l ArtKosM_BPZTitleCard
		dc.l ArtKosM_CGZTitleCard
		dc.l ArtKosM_DPZTitleCard
		dc.l ArtKosM_EMZTitleCard
		dc.l ArtKosM_BonusTitleCard
		dc.l ArtKosM_BonusTitleCard
		dc.l ArtKosM_BonusTitleCard
ObjArray_TtlCard:
		dc.l Obj_TitleCardName
		dc.w   $120
		dc.w   $260
		dc.w    $E0
		dc.b    4
		dc.b  $80
		dc.w      3
		dc.l Obj_TitleCardElement
		dc.w   $17C
		dc.w   $2FC
		dc.w   $100
		dc.b    3
		dc.b  $24
		dc.w      5
		dc.l Obj_TitleCardAct
		dc.w   $184
		dc.w   $344
		dc.w   $120
		dc.b    2
		dc.b  $1C
		dc.w      7
		dc.l Obj_TitleCardRedBanner
		dc.w    $C0
		dc.w    $E0
		dc.w    $10
		dc.b    1
		dc.b    0
		dc.w      1
ObjArray_TtlCard2:
		dc.l Obj_TitleCardElement2
		dc.w   $15C
		dc.w   $21C
		dc.w    $BC
		dc.b  $12
		dc.b  $80
		dc.w      1
ObjArray_TtlCardBonus:
		dc.l Obj_TitleCardElement
		dc.w    $C8
		dc.w   $188
		dc.w    $E8
		dc.b  $13
		dc.b  $80
		dc.w      1
		dc.l Obj_TitleCardElement
		dc.w   $128
		dc.w   $1E8
		dc.w    $E8
		dc.b  $14
		dc.b  $80
		dc.w      1
; ---------------------------------------------------------------------------

Obj_LevelResults:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	LevelResults_Index(pc,d0.w),d1
		jmp	LevelResults_Index(pc,d1.w)
; ---------------------------------------------------------------------------
LevelResults_Index:
		dc.w Obj_LevelResultsInit-LevelResults_Index
		dc.w Obj_LevelResultsCreate-LevelResults_Index
		dc.w Obj_LevelResultsWait-LevelResults_Index
		dc.w Obj_LevelResultsWait2-LevelResults_Index
; ---------------------------------------------------------------------------

Obj_LevelResultsInit:
		lea	(ArtKosM_ResultsGeneral).l,a1
		move.w	#tiles_to_bytes($520),d2
		jsr	(Queue_Kos_Module).l			; General art for
		lea	(ArtKosM_TitleCardNum1).l,a1
		tst.b	(Apparent_act).w
		beq.s	loc_2CE14
		lea	(ArtKosM_TitleCardNum2).l,a1

loc_2CE14:
		move.w	#tiles_to_bytes($570),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_ResultsSONIC).l,a1		; Select character name to use based on character of course
		cmpi.w	#1,(Player_mode).w
		bls.s	loc_2CE4C
		lea	(ArtKosM_ResultsKNUCKLES).l,a1
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_2CE4C
		lea	(ArtKosM_ResultsMILES).l,a1
		tst.b	(Graphics_flags).w
		bpl.s	loc_2CE4C
		lea	(ArtKosM_ResultsTAILS).l,a1

loc_2CE4C:
		move.w	#tiles_to_bytes($580),d2
		tst.b	(Apparent_act).w
		beq.s	loc_2CE5A
		move.w	#tiles_to_bytes(ArtTile_Explosion),d2

loc_2CE5A:
		jsr	(Queue_Kos_Module).l		; Load character name graphics
		moveq	#0,d0
		move.b	(Timer_minute).w,d0
		mulu.w	#60,d0
		moveq	#0,d1
		move.b	(Timer_second).w,d1
		add.w	d1,d0
		cmpi.w	#600-1,d0
		bne.s	loc_2CE80
		move.w	#10000,(Time_bonus_countdown).w	; If clock is at 9:59, give an automatic 100000 point time bonus
		bra.s	loc_2CE98
; ---------------------------------------------------------------------------

loc_2CE80:
		divu.w	#30,d0		; Divide time by 30
		moveq	#7,d1
		cmp.w	d1,d0		; If result is above 7, make it 7
		blo.s	loc_2CE8C
		move.w	d1,d0

loc_2CE8C:
		add.w	d0,d0
		lea	TimeBonus(pc),a1
		move.w	(a1,d0.w),(Time_bonus_countdown).w	; Get the time bonus

loc_2CE98:
		move.w	(Ring_count).w,d0
		mulu.w	#10,d0
		move.w	d0,(Ring_bonus_countdown).w	; Get the ring bonus
		clr.w	(Total_bonus_countup).w
		move.w	#6*60,$2E(a0)		; Wait 6 seconds before starting score counting sequence
		move.w	#$C,$30(a0)
		addq.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

Obj_LevelResultsCreate:
		tst.b	(Kos_modules_left).w
		bne.s	locret_2CF24		; Don't load the objects until the art has been loaded
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_2CF24
		lea	ObjArray_LevResults(pc),a2
		moveq	#$C-1,d1		; Make 12 objects

loc_2CECE:
		move.l	(a2)+,(a1)
		move.w	(a2)+,$46(a1)
		move.w	(a2)+,x_pos(a1)
		spl	routine(a1)
		move.w	(a2)+,y_pos(a1)
		move.b	(a2)+,mapping_frame(a1)
		move.b	(a2)+,width_pixels(a1)
		move.w	(a2)+,d2
		move.b	d2,$28(a1)
		move.b	#$40,render_flags(a1)
		move.l	#Map_Results,mappings(a1)
		move.w	a0,parent2(a1)
		jsr	(CreateNewSprite4).l
		dbne	d1,loc_2CECE
		addq.b	#2,routine(a0)
		tst.b	(Apparent_act).w
		bne.s	locret_2CF24		; If this is act 2, branch
		move.b	(Apparent_zone).w,d0
		beq.s	locret_2CF24		; If this is Angel Island, branch
		cmpi.b	#5,d0
		beq.s	locret_2CF24		; If this is Ice Cap Zone, branch
		st	(Events_fg_5).w		; Set the background event flag for the given level (presumably for transitions)

locret_2CF24:
		rts
; ---------------------------------------------------------------------------

Obj_LevelResultsWait:
		tst.w	$2E(a0)
		beq.s	loc_2CF4C
		subq.w	#1,$2E(a0)
		cmpi.w	#289,$2E(a0)
		bne.s	locret_2CF8E			; Play after eh, a second or so
		move.b	#30,(Player_1+air_left).w	; Reset air for Hydrocity
		move.b	#30,(Player_2+air_left).w
		moveq	#signextendB(mus_GotThroughAct),d0
		jmp	(Play_Music).l			; Play level complete theme
; ---------------------------------------------------------------------------

loc_2CF4C:
		moveq	#0,d0
		tst.w	(Time_bonus_countdown).w
		beq.s	loc_2CF5E
		addi.w	#10,d0
		subi.w	#10,(Time_bonus_countdown).w	; Get 100 points from the time bonus

loc_2CF5E:
		tst.w	(Ring_bonus_countdown).w
		beq.s	loc_2CF6E
		addi.w	#10,d0
		subi.w	#10,(Ring_bonus_countdown).w	; Get 100 points from the ring bonus

loc_2CF6E:
		add.w	d0,(Total_bonus_countup).w	; Add to total score for level
		tst.w	d0
		beq.s	loc_2CF90			; Branch once score has finished counting down
		jsr	(HUD_AddToScore).l		; Add to actual score
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		bne.s	locret_2CF8E
		moveq	#signextendB(sfx_Switch),d0	; Every four frames, play the score countdown sound
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

locret_2CF8E:
		rts
; ---------------------------------------------------------------------------

loc_2CF90:
		moveq	#signextendB(sfx_Register),d0	; Play the cash register sound
		jsr	(Play_SFX).l
		jsr	(SaveGame).l
		move.w	#90,$2E(a0)	; Set wait amount
		addq.b	#2,routine(a0)

Obj_LevelResultsWait2:
		tst.w	$2E(a0)
		beq.s	loc_2CFB4
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_2CFB4:
		tst.w	$30(a0)			; Wait for title screen objects to disappear
		beq.s	loc_2CFC0
		addq.w	#1,$32(a0)
		rts
; ---------------------------------------------------------------------------

loc_2CFC0:
		tst.b	(Apparent_act).w
		beq.s	loc_2CFD4
		clr.b	(_unkFAA8).w		; Act 2
		st	(End_of_level_flag).w	; Stop level results flag and set title card finished flag
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2CFD4:
		move.b	#1,(Apparent_act).w	; Change to act 2 if in act 1
		clr.b	(Last_star_post_hit).w
		clr.b	(Special_bonus_entry_flag).w
		clr.b	(_unkFAA8).w
		move.l	#Obj_TitleCard,(a0)	; Change current object to title card
		clr.b	routine(a0)
		st	$3E(a0)
		rts
; ---------------------------------------------------------------------------

Obj_LevResultsCharName:
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_2D01A
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_2D036
		addq.b	#3,mapping_frame(a0)	; Knuckles frame
		moveq	#$30,d0
		sub.w	d0,x_pos(a0)
		sub.w	d0,$46(a0)		; Sprite is offset slightly to the left
		add.b	d0,width_pixels(a0)	; Increase width by said amount
		bra.s	loc_2D036
; ---------------------------------------------------------------------------

loc_2D01A:
		addq.b	#1,mapping_frame(a0)	; Miles frame
		tst.b	(Graphics_flags).w
		bpl.s	loc_2D036
		addq.b	#1,mapping_frame(a0)	; Tails frame
		moveq	#8,d0
		add.w	d0,x_pos(a0)
		add.w	d0,$46(a0)
		sub.b	d0,width_pixels(a0)	; Offset like above

loc_2D036:
		moveq	#0,d0
		tst.b	(Apparent_act).w
		beq.s	loc_2D042
		move.w	#$20,d0

loc_2D042:
		move.w	d0,art_tile(a0)		; Offset VRAM depending on act number
		move.l	#Obj_LevResultsGeneral,(a0)

Obj_LevResultsGeneral:
		jsr	LevelResults_MoveElement(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_LevelResultsTimeBonus:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Time_bonus_countdown).w,d0
		bra.s	loc_2D072
; ---------------------------------------------------------------------------

Obj_LevelResultsRingBonus:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Ring_bonus_countdown).w,d0
		bra.s	loc_2D072
; ---------------------------------------------------------------------------

Obj_LevelResultsTotal:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Total_bonus_countup).w,d0

loc_2D072:
		bsr.s	LevResults_DisplayScore
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


LevResults_DisplayScore:
		move.w	#7,mainspr_childsprites(a0)
		jsr	LevResults_GetDecimalScore(pc)
		rol.l	#4,d1
		lea	sub2_x_pos(a0),a1
		move.w	x_pos(a0),d2
		subi.w	#$38,d2
		move.w	y_pos(a0),d3
		moveq	#0,d4
		moveq	#7-1,d5

loc_2D09A:
		move.w	d2,(a1)+
		move.w	d3,(a1)+
		addq.w	#1,a1
		rol.l	#4,d1
		move.w	d1,d0
		andi.w	#$F,d0
		beq.s	loc_2D0AC
		moveq	#1,d4

loc_2D0AC:
		add.w	d4,d0
		move.b	d0,(a1)+
		addq.w	#8,d2
		dbf	d5,loc_2D09A
		rts
; End of function LevResults_DisplayScore


; =============== S U B R O U T I N E =======================================


LevelResults_MoveElement:
		movea.w	parent2(a0),a1
		move.w	$32(a1),d0
		beq.s	loc_2D0EC
		tst.b	render_flags(a0)
		bmi.s	loc_2D0D4
		subq.w	#1,$30(a1)			; If offscreen, subtract from number of elements and delete
		addq.w	#4,sp
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2D0D4:
		cmp.b	$28(a0),d0		; Level element moving out. Test if value of parent queue matches given queue value
		blo.s	locret_2D102
		move.w	#-$20,d0		; If so, move out
		tst.b	routine(a0)
		beq.s	loc_2D0E6
		neg.w	d0				; Change direction depending on where it came from

loc_2D0E6:
		add.w	x_pos(a0),d0
		bra.s	loc_2D0FE
; ---------------------------------------------------------------------------

loc_2D0EC:
		moveq	#$10,d1			; Level element moving in
		move.w	x_pos(a0),d0
		cmp.w	$46(a0),d0
		beq.s	loc_2D0FE		; If X position has reached destination, don't do anything else
		blt.s	loc_2D0FC		; See which direction it needs to go
		neg.w	d1

loc_2D0FC:
		add.w	d1,d0			; Add speed to X amount

loc_2D0FE:
		move.w	d0,x_pos(a0)

locret_2D102:
		rts
; End of function LevelResults_MoveElement


; =============== S U B R O U T I N E =======================================


LevResults_GetDecimalScore:
		clr.l	(_unkEF40_1).w
		lea	TimeBonus(pc),a1
		moveq	#$10-1,d2

loc_2D10E:
		ror.w	#1,d0
		bcs.s	loc_2D116
		subq.w	#3,a1
		bra.s	loc_2D124
; ---------------------------------------------------------------------------

loc_2D116:
		lea	(_unkEF44_2).w,a2
		addi.w	#0,d0
		abcd	-(a1),-(a2)
		abcd	-(a1),-(a2)
		abcd	-(a1),-(a2)

loc_2D124:
		dbf	d2,loc_2D10E
		move.l	(_unkEF40_1).w,d1
		rts
; End of function LevResults_GetDecimalScore

; ---------------------------------------------------------------------------
		tribyte $32768
		tribyte $16384
		tribyte  $8192
		tribyte  $4096
		tribyte  $2048
		tribyte  $1024
		tribyte   $512
		tribyte   $256
		tribyte   $128
		tribyte    $64
		tribyte    $32
		tribyte    $16
		tribyte      8
		tribyte      4
		tribyte      2
		tribyte      1
TimeBonus:
		dc.w 5000
		dc.w 5000
		dc.w 1000
		dc.w  500
		dc.w  400
		dc.w  300
		dc.w  100
		dc.w   10
ObjArray_LevResults:
		dc.l Obj_LevResultsCharName	; Object address
		dc.w    $E0			; X destination
		dc.w  -$220			; X position
		dc.w    $B8			; Y position
		dc.b  $13			; Mapping frame
		dc.b  $48			; Width
		dc.w      1			; Place in exit queue
		dc.l Obj_LevResultsGeneral
		dc.w   $130
		dc.w  -$1D0
		dc.w    $B8
		dc.b  $11
		dc.b  $30
		dc.w      1
		dc.l Obj_LevResultsGeneral
		dc.w    $E8
		dc.w   $468
		dc.w    $CC
		dc.b  $10
		dc.b  $70
		dc.w      3
		dc.l Obj_LevResultsGeneral
		dc.w   $160
		dc.w   $4E0
		dc.w    $BC
		dc.b   $F
		dc.b  $38
		dc.w      3
		dc.l Obj_LevResultsGeneral
		dc.w    $C0
		dc.w   $4C0
		dc.w    $F0
		dc.b   $E
		dc.b  $20
		dc.w      5
		dc.l Obj_LevResultsGeneral
		dc.w    $E8
		dc.w   $4E8
		dc.w    $F0
		dc.b   $C
		dc.b  $30
		dc.w      5
		dc.l Obj_LevelResultsTimeBonus
		dc.w   $178
		dc.w   $578
		dc.w    $F0
		dc.b    1
		dc.b  $40
		dc.w      5
		dc.l Obj_LevResultsGeneral
		dc.w    $C0
		dc.w   $500
		dc.w   $100
		dc.b   $D
		dc.b  $20
		dc.w      7
		dc.l Obj_LevResultsGeneral
		dc.w    $E8
		dc.w   $528
		dc.w   $100
		dc.b   $C
		dc.b  $30
		dc.w      7
		dc.l Obj_LevelResultsRingBonus
		dc.w   $178
		dc.w   $5B8
		dc.w   $100
		dc.b    1
		dc.b  $40
		dc.w      7
		dc.l Obj_LevResultsGeneral
		dc.w    $D4
		dc.w   $554
		dc.w   $11C
		dc.b   $B
		dc.b  $30
		dc.w      9
		dc.l Obj_LevelResultsTotal
		dc.w   $178
		dc.w   $5F8
		dc.w   $11C
		dc.b    1
		dc.b  $40
		dc.w      9
; ---------------------------------------------------------------------------

locret_2D216:
		rts
; ---------------------------------------------------------------------------

SpecialStage_Results:
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
		move.w	#$8B00,(a6)
		move.w	#$8C81,(a6)			; Command $8C81 - 40cell screen size, no interlacing, no s/h
		move.w	#$9011,(a6)			; 128-cell hScroll table size: 64x64
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		jsr	(SaveGame_SpecialStage).l
		clr.w	(Competition_mode).w
		clr.w	(Plane_buffer).w
		clr.w	(Special_V_int_routine).w
		clr.b	(Update_HUD_timer).w
		moveq	#0,d0
		jsr	(Load_PLC_2).l
		lea	(ArtKosM_ResultsGeneral).l,a1
		move.w	#tiles_to_bytes($520),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_ResultsSONIC).l,a1
		cmpi.w	#1,(Player_mode).w
		bls.s	loc_2D2DE
		lea	(ArtKosM_ResultsKNUCKLES).l,a1
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_2D2DE
		lea	(ArtKosM_ResultsMILES).l,a1
		tst.b	(Graphics_flags).w
		bpl.s	loc_2D2DE
		lea	(ArtKosM_ResultsTAILS).l,a1

loc_2D2DE:
		move.w	#tiles_to_bytes($580),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_SSResults).l,a1
		move.w	#tiles_to_bytes($001),d2
		jsr	(Queue_Kos_Module).l
		move.l	#locret_2D216,(_unkEF44_1).w

loc_2D300:
		move.b	#$1E,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		jsr	(Wait_VSync).l
		jsr	(Process_Nem_Queue_Init).l
		jsr	(Process_Kos_Module_Queue).l
		tst.b	(Kos_modules_left).w
		bne.s	loc_2D300
		tst.l	(Nem_decomp_queue).w
		bne.s	loc_2D300
		jsr	(HUD_DrawInitial).l
		move.b	#1,(Update_HUD_score).w
		lea	Pal_Results(pc),a0
		lea	(Normal_palette).w,a1
		moveq	#bytesToLcnt($80),d0

loc_2D340:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_2D340
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_2D35C
		move.l	#$84E040C,(Normal_palette+4).w
		move.w	#$206,(Normal_palette+8).w

loc_2D35C:
		jsr	(Init_SpriteTable).l
		move.l	#Obj_SpecialStage_Results,(Dynamic_object_RAM+object_size).w
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l

loc_2D378:
		move.b	#8,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		cmpi.b	#$48,(Game_mode).w
		beq.s	loc_2D378
		rts
; ---------------------------------------------------------------------------
Pal_Results:
		binclude "General/Special Stage/Palettes/Results S3.bin"
		even
; ---------------------------------------------------------------------------

Obj_SpecialStage_Results:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	SpecialStage_Results_Index(pc,d0.w),d1
		jmp	SpecialStage_Results_Index(pc,d1.w)
; ---------------------------------------------------------------------------
SpecialStage_Results_Index:
		dc.w loc_2D438-SpecialStage_Results_Index
		dc.w loc_2D49A-SpecialStage_Results_Index
		dc.w loc_2D506-SpecialStage_Results_Index
		dc.w loc_2D53A-SpecialStage_Results_Index
		dc.w loc_2D590-SpecialStage_Results_Index
		dc.w loc_2D5DC-SpecialStage_Results_Index
; ---------------------------------------------------------------------------

loc_2D438:
		lea	next_object(a0),a1
		lea	ObjDat2_2D5F0(pc),a2
		moveq	#$13-1,d1

loc_2D442:
		move.l	(a2)+,(a1)
		move.w	(a2)+,$46(a1)
		move.w	(a2)+,x_pos(a1)
		move.w	(a2)+,y_pos(a1)
		move.b	(a2)+,mapping_frame(a1)
		move.b	(a2)+,width_pixels(a1)
		move.b	#$40,render_flags(a1)
		move.l	#Map_Results,mappings(a1)
		move.w	a0,parent2(a1)
		lea	next_object(a1),a1
		dbf	d1,loc_2D442
		move.w	(Special_stage_ring_count).w,d0
		mulu.w	#10,d0
		move.w	d0,(Ring_bonus_countdown).w
		clr.w	(Time_bonus_countdown).w
		tst.w	(Special_stage_rings_left).w
		bne.s	loc_2D48E
		move.w	#5000,(Time_bonus_countdown).w

loc_2D48E:
		move.w	#6*60,$2E(a0)
		addq.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_2D49A:
		tst.w	$2E(a0)
		beq.s	loc_2D4B4
		subq.w	#1,$2E(a0)
		cmpi.w	#289,$2E(a0)
		bne.s	locret_2D4F2
		moveq	#signextendB(mus_GotThroughAct),d0
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------

loc_2D4B4:
		moveq	#0,d0
		tst.w	(Time_bonus_countdown).w
		beq.s	loc_2D4C6
		addi.w	#10,d0
		subi.w	#10,(Time_bonus_countdown).w

loc_2D4C6:
		tst.w	(Ring_bonus_countdown).w
		beq.s	loc_2D4D6
		addi.w	#10,d0
		subi.w	#10,(Ring_bonus_countdown).w

loc_2D4D6:
		tst.w	d0
		beq.s	loc_2D4F4
		jsr	(HUD_AddToScore).l
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		bne.s	locret_2D4F2
		moveq	#signextendB(sfx_Switch),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

locret_2D4F2:
		rts
; ---------------------------------------------------------------------------

loc_2D4F4:
		moveq	#signextendB(sfx_Register),d0
		jsr	(Play_SFX).l
		move.w	#2*60,$2E(a0)
		addq.b	#2,routine(a0)

loc_2D506:
		tst.w	$2E(a0)
		beq.s	loc_2D512
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_2D512:
		cmpi.w	#50,(Special_stage_ring_count).w
		blo.s	loc_2D536
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_2D536
		move.l	#loc_2D83C,(a1)
		move.w	#270,$2E(a0)
		moveq	#signextendB(sfx_Continue),d0
		jsr	(Play_SFX).l

loc_2D536:
		addq.b	#2,routine(a0)

loc_2D53A:
		tst.w	$2E(a0)
		beq.s	loc_2D546
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_2D546:
		cmpi.w	#1,(Player_mode).w
		bhi.s	loc_2D588
		tst.w	(Special_stage_spheres_left).w
		bne.s	loc_2D588
		cmpi.b	#7,(Chaos_emerald_count+1).w
		blo.s	loc_2D588
		lea	(Dynamic_object_RAM+(object_size*16)).w,a1
		moveq	#5-1,d0

loc_2D562:
		move.l	#loc_2D872,(a1)
		lea	next_object(a1),a1
		dbf	d0,loc_2D562
		move.w	#4,(Dynamic_object_RAM+(object_size*18)+objoff_2E).w
		move.w	#4,(Dynamic_object_RAM+(object_size*20)+objoff_2E).w
		move.w	#5,$30(a0)
		addq.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_2D588:
		move.b	#$C,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_2D590:
		tst.w	$30(a0)
		bne.s	locret_2D5DA
		lea	(Dynamic_object_RAM+(object_size*16)).w,a1
		lea	ObjDat2_2D6D4(pc),a2
		moveq	#5-1,d1

loc_2D5A0:
		move.l	(a2)+,(a1)
		move.w	(a2)+,$46(a1)
		move.w	(a2)+,x_pos(a1)
		move.w	(a2)+,y_pos(a1)
		move.b	(a2)+,mapping_frame(a1)
		move.b	(a2)+,width_pixels(a1)
		move.b	#$40,render_flags(a1)
		move.l	#Map_Results,mappings(a1)
		move.w	a0,parent2(a1)
		lea	next_object(a1),a1
		dbf	d1,loc_2D5A0
		move.w	#4*60,$2E(a0)
		addq.b	#2,routine(a0)

locret_2D5DA:
		rts
; ---------------------------------------------------------------------------

loc_2D5DC:
		tst.w	$2E(a0)
		beq.s	loc_2D5E8
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_2D5E8:
		move.b	#$C,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
ObjDat2_2D5F0:
		dc.l loc_2D710
		dc.w   $120,  $4E0,  $100
		dc.b  $17, $60
		dc.l loc_2D710
		dc.w    $C0,  $4C0,  $118
		dc.b  $18, $58
		dc.l loc_2D71A
		dc.w   $178,  $578,  $118
		dc.b    1, $40
		dc.l loc_2D710
		dc.w    $C0,  $500,  $128
		dc.b  $19, $40
		dc.l loc_2D724
		dc.w   $178,  $5B8,  $128
		dc.b    1, $40
		dc.l loc_2D736
		dc.w    $C0,  $540,  $138
		dc.b  $1A, $48
		dc.l loc_2D74A
		dc.w   $120,  $120,   $D0
		dc.b  $1B,   0
		dc.l loc_2D74A
		dc.w   $110,  $110,   $E8
		dc.b  $1C,   1
		dc.l loc_2D74A
		dc.w   $130,  $130,   $E8
		dc.b  $1D,   2
		dc.l loc_2D74A
		dc.w   $100,  $100,   $D0
		dc.b  $1E,   3
		dc.l loc_2D74A
		dc.w   $140,  $140,   $D0
		dc.b  $1F,   4
		dc.l loc_2D74A
		dc.w    $F0,   $F0,   $E8
		dc.b  $20,   5
		dc.l loc_2D74A
		dc.w   $150,  $150,   $E8
		dc.b  $21,   6
		dc.l loc_2D76C
		dc.w   $120,  $460,   $A0
		dc.b  $22, $60
		dc.l loc_2D776
		dc.w    $D4,  $394,   $98
		dc.b  $13, $48
		dc.l loc_2D7AC
		dc.w   $124,  $3E4,   $98
		dc.b  $23, $48
		dc.l loc_2D7DE
		dc.w   $120,  $460,   $B0
		dc.b  $24, $64
		dc.l loc_2D800
		dc.w   $114,  $3D4,   $98
		dc.b  $25, $20
		dc.l loc_2D828
		dc.w   $118,  $458,   $B0
		dc.b  $26, $10
ObjDat2_2D6D4:
		dc.l loc_2D710
		dc.w   $120,  $420,   $98
		dc.b  $27, $60
		dc.l loc_2D710
		dc.w   $100,  $400,   $98
		dc.b  $13, $48
		dc.l loc_2D710
		dc.w    $C0,  $440,   $B0
		dc.b  $28, $20
		dc.l loc_2D710
		dc.w    $E8,  $468,   $B0
		dc.b  $12, $50
		dc.l loc_2D710
		dc.w   $138,  $4B8,   $B0
		dc.b  $13, $48
; ---------------------------------------------------------------------------

loc_2D710:
		jsr	LevelResults_MoveElement(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2D71A:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Ring_bonus_countdown).w,d0
		bra.s	loc_2D72C
; ---------------------------------------------------------------------------

loc_2D724:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Time_bonus_countdown).w,d0

loc_2D72C:
		jsr	LevResults_DisplayScore(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2D736:
		cmpi.w	#50,(Special_stage_ring_count).w
		blo.w	loc_2D89E
		jsr	LevelResults_MoveElement(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2D74A:
		lea	(Collected_emeralds_array).w,a1
		moveq	#0,d0
		move.b	width_pixels(a0),d0
		tst.b	(a1,d0.w)
		beq.w	loc_2D89E
		btst	#0,(Level_frame_counter+1).w
		beq.s	locret_2D76A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_2D76A:
		rts
; ---------------------------------------------------------------------------

loc_2D76C:
		tst.w	(Special_stage_spheres_left).w
		beq.w	loc_2D89E
		bra.s	loc_2D710
; ---------------------------------------------------------------------------

loc_2D776:
		tst.w	(Special_stage_spheres_left).w
		bne.w	loc_2D89E
		jsr	sub_2D8A4(pc)
		add.w	d0,x_pos(a0)
		add.w	d0,$46(a0)
		add.b	d1,mapping_frame(a0)
		cmpi.b	#7,(Chaos_emerald_count+1).w
		blo.s	loc_2D7A2
		subi.w	#$10,x_pos(a0)
		subi.w	#$10,$46(a0)

loc_2D7A2:
		lea	(loc_2D710).l,a1
		move.l	a1,(a0)
		jmp	(a1)
; ---------------------------------------------------------------------------

loc_2D7AC:
		tst.w	(Special_stage_spheres_left).w
		bne.w	loc_2D89E
		jsr	sub_2D8A4(pc)
		sub.w	d0,x_pos(a0)
		sub.w	d0,$46(a0)
		cmpi.b	#7,(Chaos_emerald_count+1).w
		blo.s	loc_2D7D4
		subi.w	#$10,x_pos(a0)
		subi.w	#$10,$46(a0)

loc_2D7D4:
		lea	(loc_2D710).l,a1
		move.l	a1,(a0)
		jmp	(a1)
; ---------------------------------------------------------------------------

loc_2D7DE:
		tst.w	(Special_stage_spheres_left).w
		bne.w	loc_2D89E
		cmpi.b	#7,(Chaos_emerald_count+1).w
		blo.s	loc_2D7F6
		subq.w	#8,x_pos(a0)
		subq.w	#8,$46(a0)

loc_2D7F6:
		lea	(loc_2D710).l,a1
		move.l	a1,(a0)
		jmp	(a1)
; ---------------------------------------------------------------------------

loc_2D800:
		tst.w	(Special_stage_spheres_left).w
		bne.w	loc_2D89E
		cmpi.b	#7,(Chaos_emerald_count+1).w
		blo.w	loc_2D89E
		jsr	sub_2D8A4(pc)
		sub.w	d0,x_pos(a0)
		sub.w	d0,$46(a0)
		lea	(loc_2D710).l,a1
		move.l	a1,(a0)
		jmp	(a1)
; ---------------------------------------------------------------------------

loc_2D828:
		tst.w	(Special_stage_spheres_left).w
		bne.w	loc_2D89E
		cmpi.b	#7,(Chaos_emerald_count+1).w
		blo.s	loc_2D89E
		bra.w	loc_2D710
; ---------------------------------------------------------------------------

loc_2D83C:
		move.l	#Map_Results,mappings(a0)
		move.w	#$17C,x_pos(a0)
		move.w	#$14C,y_pos(a0)
		move.w	(Player_mode).w,d0
		subq.w	#1,d0
		bcc.s	loc_2D85A
		moveq	#0,d0

loc_2D85A:
		addi.w	#$29,d0
		move.b	d0,mapping_frame(a0)
		btst	#3,(Level_frame_counter+1).w
		beq.s	locret_2D870
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_2D870:
		rts
; ---------------------------------------------------------------------------

loc_2D872:
		tst.w	$2E(a0)
		beq.s	loc_2D87E
		subq.w	#1,$2E(a0)
		bra.s	loc_2D898
; ---------------------------------------------------------------------------

loc_2D87E:
		tst.b	render_flags(a0)
		bmi.s	loc_2D892
		movea.w	parent2(a0),a1
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2D892:
		addi.w	#$20,x_pos(a0)

loc_2D898:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2D89E:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_2D8A4:
		moveq	#0,d0
		moveq	#0,d1
		cmpi.w	#1,(Player_mode).w
		bls.s	.return
		moveq	#-$18,d0
		moveq	#3,d1
		cmpi.w	#3,(Player_mode).w
		beq.s	.return
		moveq	#0,d0
		moveq	#1,d1
		tst.b	(Graphics_flags).w
		bpl.s	.return
		moveq	#4,d0
		moveq	#2,d1

.return:
		rts
; End of function sub_2D8A4

; ---------------------------------------------------------------------------
Map_GameOver:
		include "General/Sprites/Game Over/Map - Game Over.asm"
Map_TitleCard:
		include "General/Sprites/Title Card/Map - Title Card S3.asm"
Map_Results:
		include "General/Sprites/Results/Map - Results S3.asm"

; =============== S U B R O U T I N E =======================================


LoadEnemyArt:
		lea	Offs_LoadEnemyArt(pc),a6
		move.w	(Apparent_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#6,d0
		adda.w	(a6,d0.w),a6
		move.w	(a6)+,d6
		bmi.s	.return

.loop:
		movea.l	(a6)+,a1
		move.w	(a6)+,d2
		jsr	(Queue_Kos_Module).l
		dbf	d6,.loop

.return:
		rts
; End of function LoadEnemyArt

; ---------------------------------------------------------------------------
Offs_LoadEnemyArt:
		dc.w PLCKosM_AIZ-Offs_LoadEnemyArt
		dc.w PLCKosM_AIZ-Offs_LoadEnemyArt
		dc.w PLCKosM_HCZ1-Offs_LoadEnemyArt
		dc.w PLCKosM_HCZ2-Offs_LoadEnemyArt
		dc.w PLCKosM_MGZ1-Offs_LoadEnemyArt
		dc.w PLCKosM_MGZ2-Offs_LoadEnemyArt
		dc.w PLCKosM_CNZ-Offs_LoadEnemyArt
		dc.w PLCKosM_CNZ-Offs_LoadEnemyArt
		dc.w PLCKosM_FBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_FBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_ICZ-Offs_LoadEnemyArt
		dc.w PLCKosM_ICZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LBZ-Offs_LoadEnemyArt

PLCKosM_AIZ: plrlistheader
		plreq $548, ArtKosM_AIZ_MonkeyDude
		plreq $52A, ArtKosM_AIZ_Bloominator
		plreq $55F, ArtKosM_AIZ_CaterkillerJr
PLCKosM_AIZ_End

PLCKosM_HCZ1: plrlistheader
		plreq $539, ArtKosM_Blastoid
		plreq $500, ArtKosM_TurboSpiker
		plreq $54D, ArtKosM_MegaChopper
		plreq $559, ArtKosM_Pointdexter
PLCKosM_HCZ1_End

PLCKosM_HCZ2: plrlistheader
		plreq $539, ArtKosM_Jawz
		plreq $500, ArtKosM_TurboSpiker
		plreq $54D, ArtKosM_MegaChopper
		plreq $559, ArtKosM_Pointdexter
PLCKosM_HCZ2_End

PLCKosM_MGZ1: plrlistheader
		plreq $530, ArtKosM_Spiker
		plreq $54F, ArtKosM_MGZMiniboss
		plreq $570, ArtKosM_MGZEndBossDebris
PLCKosM_MGZ1_End

PLCKosM_MGZ2: plrlistheader
		plreq $530, ArtKosM_Spiker
		plreq $54F, ArtKosM_Mantis
PLCKosM_MGZ2_End

PLCKosM_CNZ: plrlistheader
		plreq $524, ArtKosM_Sparkle
		plreq $552, ArtKosM_Batbot
		plreq $570, ArtKosM_ClamerShot
		plreq $574, ArtKosM_CNZBalloon
PLCKosM_CNZ_End

PLCKosM_FBZ: plrlistheader
		plreq $500, ArtKosM_Blaster
		plreq $528, ArtKosM_Technosqueek
PLCKosM_FBZ_End

PLCKosM_ICZ: plrlistheader
		plreq $558, ArtKosM_ICZSnowdust
		plreq $548, ArtKosM_StarPointer
PLCKosM_ICZ_End

PLCKosM_LBZ: plrlistheader
		plreq $524, ArtKosM_SnaleBlaster
		plreq $56E, ArtKosM_Orbinaut
		plreq $547, ArtKosM_Ribot
		plreq $558, ArtKosM_Corkey
PLCKosM_LBZ_End

; ---------------------------------------------------------------------------
