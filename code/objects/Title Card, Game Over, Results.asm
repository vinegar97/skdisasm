Obj_GameOver:
		tst.l	(Nem_decomp_queue).w
		beq.s	+ ;loc_2D5CE
		rts
; ---------------------------------------------------------------------------

+ ;loc_2D5CE:
		tst.b	mapping_frame(a0)
		bne.s	+ ;loc_2D5DE
		st	(SRAM_mask_interrupts_flag).w
		jsr	(SaveGame_LivesContinues).l

+ ;loc_2D5DE:
		move.w	#$50,x_pos(a0)
		btst	#0,mapping_frame(a0)
		beq.s	+ ;loc_2D5F2
		move.w	#$1F0,x_pos(a0)

+ ;loc_2D5F2:
		move.w	#$F0,y_pos(a0)
		move.l	#Map_GameOver,mappings(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,1),art_tile(a0)
		move.w	#0,priority(a0)
		move.l	#loc_2D612,(a0)

loc_2D612:
		moveq	#$10,d1
		cmpi.w	#$120,x_pos(a0)
		beq.s	++ ;loc_2D62A
		bcs.s	+ ;loc_2D620
		neg.w	d1

+ ;loc_2D620:
		add.w	d1,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2D62A:
		move.w	#8*60,anim_frame_timer(a0)
		move.l	#loc_2D638,(a0)
		rts
; ---------------------------------------------------------------------------

loc_2D638:
		move.w	#0,(Collision_response_list).w
		btst	#0,mapping_frame(a0)
		bne.w	+++ ;loc_2D68A
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask|button_start_mask,d0
		bne.s	+ ;loc_2D666
		tst.w	anim_frame_timer(a0)
		beq.s	+ ;loc_2D666
		subq.w	#1,anim_frame_timer(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2D666:
		tst.b	(Time_over_flag).w
		bne.s	+ ;loc_2D680
		move.b	#$14,(Game_mode).w
		tst.b	(Continue_count).w
		bne.s	++ ;loc_2D68A
		move.b	#0,(Game_mode).w
		bra.s	++ ;loc_2D68A
; ---------------------------------------------------------------------------

+ ;loc_2D680:
		clr.l	(Saved_timer).w
		move.w	#1,(Restart_level_flag).w

+ ;loc_2D68A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCard:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w .Init-.Index
		dc.w .Create-.Index
		dc.w .Wait-.Index
		dc.w .Wait2-.Index
; ---------------------------------------------------------------------------

.Init:
		cmpi.w	#$D01,(Current_zone_and_act).w
		beq.s	+ ;loc_2D6C2			; if we're in the ending, don't show title card
		cmpi.b	#$E,(Current_zone).w
		blo.s	++ ;loc_2D6C8			; If in any of the 2P stages, don't show title card
		cmpi.b	#$12,(Current_zone).w
		bhi.s	++ ;loc_2D6C8
		st	$44(a0)

+ ;loc_2D6C2:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2D6C8:
		lea	(ArtKosM_TitleCardRedAct).l,a1
		move.w	#tiles_to_bytes($500),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_TitleCardSKZone).l,a1
		tst.w	(SK_alone_flag).w
		bne.s	+ ;loc_2D6EA
		lea	(ArtKosM_TitleCardS3KZone).l,a1

+ ;loc_2D6EA:
		move.w	#tiles_to_bytes($510),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_TitleCardNum2).l,a1
		cmpi.w	#$1600,(Current_zone_and_act).w
		beq.s	+ ;loc_2D716
		cmpi.w	#$1700,(Current_zone_and_act).w
		beq.s	+ ;loc_2D716		; Death Egg Boss and LRZ Boss show act 2
		tst.b	(Apparent_act).w
		bne.s	+ ;loc_2D716
		lea	(ArtKosM_TitleCardNum1).l,a1

+ ;loc_2D716:
		move.w	#tiles_to_bytes($53D),d2
		jsr	(Queue_Kos_Module).l
		lea	TitleCard_LevelGfx(pc),a1
		moveq	#9,d0
		cmpi.w	#$1600,(Current_zone_and_act).w	; If in LRZ's boss, set it to Lava Reef's card
		beq.s	+ ;loc_2D746
		moveq	#$D,d0
		cmpi.w	#$1601,(Current_zone_and_act).w	; If in Hidden Palace, set it to its card
		beq.s	+ ;loc_2D746
		moveq	#$B,d0
		cmpi.w	#$1700,(Current_zone_and_act).w	; If in Death Egg boss, set it to Death Egg's card
		beq.s	+ ;loc_2D746
		move.b	(Apparent_zone_and_act).w,d0		; Otherwise, just use current zone

+ ;loc_2D746:
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

Obj_TitleCard.Create:
		tst.b	(Kos_modules_left).w
		bne.w	locret_2D802		; Wait for KosM queue to clear
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	locret_2D802
		cmpi.b	#$16,(Current_zone).w
		beq.s	+ ;loc_2D79A
		cmpi.w	#$1700,(Current_zone_and_act).w
		beq.s	+ ;loc_2D79A
		lea	ObjArray_TtlCardBonus(pc),a2
		moveq	#1,d1
		cmpi.b	#$13,(Current_zone).w
		bhs.s	++ ;loc_2D7AC

+ ;loc_2D79A:
		lea	ObjArray_TtlCard(pc),a2
		moveq	#3,d1
		tst.b	$44(a0)
		beq.s	+ ;loc_2D7AC
		lea	ObjArray_TtlCard2(pc),a2
		moveq	#0,d1

/ ;loc_2D7AC:
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
		dbne	d1,- ;loc_2D7AC
		tst.b	$3E(a0)
		beq.s	+ ;loc_2D7FE
		cmpi.b	#6,(Current_zone).w
		bne.s	+ ;loc_2D7FE
		moveq	#$25,d0			; If title card is mid-level and it's in LBZ, load the LBZ 2 misc art
		jsr	(Load_PLC).l

+ ;loc_2D7FE:
		addq.b	#2,routine(a0)

locret_2D802:
		rts
; ---------------------------------------------------------------------------

Obj_TitleCard.Wait:
		tst.w	$34(a0)
		beq.s	+ ;loc_2D810
		clr.w	$34(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2D810:
		tst.w	$3E(a0)
		beq.s	+ ;loc_2D84C
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

+ ;loc_2D84C:
		clr.w	$48(a0)
		addq.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

Obj_TitleCard.Wait2:
		tst.w	$2E(a0)
		beq.s	+ ;loc_2D862
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2D862:
		tst.w	$30(a0)
		beq.s	+ ;loc_2D86E
		addq.w	#1,$32(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2D86E:
		tst.b	$44(a0)
		bne.s	loc_2D8DC
		cmpi.w	#$801,(Current_zone_and_act).w
		bne.s	+ ;loc_2D88A
		jsr	(AllocateObject).l
		bne.s	+ ;loc_2D88A
		move.l	#Obj_SOZGhosts,(a1)	; If new level is Sandopolis 2, then load the ghosts

+ ;loc_2D88A:
		cmpi.b	#$16,(Current_zone).w
		beq.s	+ ;loc_2D8A2
		cmpi.w	#$1700,(Current_zone_and_act).w
		beq.s	+ ;loc_2D8A2
		cmpi.b	#$13,(Current_zone).w
		bhs.s	loc_2D8DC

+ ;loc_2D8A2:
		tst.w	$3E(a0)
		beq.s	+ ;loc_2D8AE
		st	(End_of_level_flag).w	; If in-level, set end of title card flag. No need to reload PLCs
		bra.s	++ ;loc_2D8CA
; ---------------------------------------------------------------------------

+ ;loc_2D8AE:
		cmpi.b	#$C,(Current_zone).w
		beq.s	loc_2D8DC
		cmpi.w	#$1700,(Current_zone_and_act).w
		beq.s	loc_2D8DC
		lea	(PLC_SpikesSprings).l,a1	; Reload spikes in all but DEZ boss and Doomsday
		jsr	(Load_PLC_Raw).l

+ ;loc_2D8CA:
		cmpi.w	#$1700,(Current_zone_and_act).w
		beq.s	loc_2D8DC
		jsr	LoadEnemyArt(pc)		; Load animals and enemies in all but DEZ boss
		jsr	(PLCLoad_AnimalsAndExplosion).l

loc_2D8DC:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCardRedBanner:
		movea.w	parent2(a0),a1
		move.w	$32(a1),d0
		beq.s	++ ;loc_2D90A
		tst.b	render_flags(a0)
		bmi.s	+ ;loc_2D8FC
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2D8FC:
		cmp.b	$28(a0),d0
		blo.s	++ ;loc_2D920
		subi.w	#$20,y_pos(a0)
		bra.s	++ ;loc_2D920
; ---------------------------------------------------------------------------

+ ;loc_2D90A:
		move.w	y_pos(a0),d0
		cmp.w	$46(a0),d0
		beq.s	+ ;loc_2D920
		addi.w	#$10,d0
		move.w	d0,y_pos(a0)
		st	$34(a1)

+ ;loc_2D920:
		move.b	#$70,height_pixels(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCardName:
		move.b	(Apparent_zone).w,d0
		add.b	d0,mapping_frame(a0)
		moveq	#$D,d0
		cmpi.w	#$1600,(Current_zone_and_act).w
		beq.s	+ ;loc_2D952
		moveq	#$11,d0
		cmpi.w	#$1601,(Current_zone_and_act).w
		beq.s	+ ;loc_2D952
		moveq	#$F,d0
		cmpi.w	#$1700,(Current_zone_and_act).w
		bne.s	++ ;loc_2D956

+ ;loc_2D952:
		move.b	d0,mapping_frame(a0)

+ ;loc_2D956:
		move.l	#Obj_TitleCardElement,(a0)

Obj_TitleCardElement:
		movea.w	parent2(a0),a1
		move.w	$32(a1),d0
		beq.s	++ ;loc_2D984
		tst.b	render_flags(a0)
		bmi.s	+ ;loc_2D976
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2D976:
		cmp.b	$28(a0),d0
		blo.s	++ ;loc_2D99A
		addi.w	#$20,x_pos(a0)
		bra.s	++ ;loc_2D99A
; ---------------------------------------------------------------------------

+ ;loc_2D984:
		move.w	x_pos(a0),d0
		cmp.w	$46(a0),d0
		beq.s	+ ;loc_2D99A
		subi.w	#$10,d0
		move.w	d0,x_pos(a0)
		st	$34(a1)

+ ;loc_2D99A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCardAct:
		move.l	#Obj_TitleCardElement,(a0)
		cmpi.b	#$A,(Current_zone).w
		beq.s	+ ;loc_2D9BE
		cmpi.b	#$C,(Current_zone).w
		beq.s	+ ;loc_2D9BE
		cmpi.w	#$1601,(Current_zone_and_act).w
		bne.s	Obj_TitleCardElement

+ ;loc_2D9BE:
		movea.w	parent2(a0),a1		; Sky Sanctuary, Doomsday, and Hidden Palace do not have act numbers
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleCardElement2:
		clr.b	render_flags(a0)	; I'm not entirely sure what this is used for
		movea.w	parent2(a0),a1
		move.w	$32(a1),d0
		beq.s	++ ;loc_2D9FA
		cmpi.w	#$20C,x_pos(a0)
		blo.s	+ ;loc_2D9EC
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2D9EC:
		cmp.b	$28(a0),d0
		blo.s	++ ;loc_2DA10
		addi.w	#$20,x_pos(a0)
		bra.s	++ ;loc_2DA10
; ---------------------------------------------------------------------------

+ ;loc_2D9FA:
		move.w	x_pos(a0),d0
		cmp.w	$46(a0),d0
		beq.s	+ ;loc_2DA10
		subi.w	#$10,d0
		move.w	d0,x_pos(a0)
		st	$34(a1)

+ ;loc_2DA10:
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
		dc.l ArtKosM_MHZTitleCard
		dc.l ArtKosM_SOZTitleCard
		dc.l ArtKosM_LRZTitleCard
		dc.l ArtKosM_SSZTitleCard
		dc.l ArtKosM_DEZTitleCard
		dc.l ArtKosM_DDZTitleCard
		dc.l ArtKosM_HPZTitleCard
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
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_LevelResultsInit-.Index
		dc.w Obj_LevelResultsCreate-.Index
		dc.w Obj_LevelResultsWait-.Index
		dc.w Obj_LevelResultsWait2-.Index
; ---------------------------------------------------------------------------

Obj_LevelResultsInit:
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l				; Fade music
		lea	(ArtKosM_ResultsGeneral).l,a1
		move.w	#tiles_to_bytes($520),d2
		jsr	(Queue_Kos_Module).l			; General art for
		lea	(ArtKosM_TitleCardNum2).l,a1
		moveq	#-1,d0
		cmpi.w	#$1600,(Current_zone_and_act).w
		beq.s	+ ;loc_2DB1C				; If this is the LRZ2 boss, use the 2 digit
		tst.b	(Apparent_act).w
		bne.s	+ ;loc_2DB1C
		lea	(ArtKosM_TitleCardNum1).l,a1	; Otherwise, use the 1 digit if internal act number is 0
		moveq	#0,d0

+ ;loc_2DB1C:
		move.w	d0,subtype(a0)
		move.w	#tiles_to_bytes($568),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_ResultsSONIC).l,a1		; Select character name to use based on character of course
		cmpi.w	#1,(Player_mode).w
		bls.s	+ ;loc_2DB58
		lea	(ArtKosM_ResultsKNUCKLES).l,a1
		cmpi.w	#3,(Player_mode).w
		beq.s	+ ;loc_2DB58
		lea	(ArtKosM_ResultsMILES).l,a1
		tst.b	(Graphics_flags).w
		bpl.s	+ ;loc_2DB58
		lea	(ArtKosM_ResultsTAILS).l,a1

+ ;loc_2DB58:
		move.w	#tiles_to_bytes($578),d2
		tst.w	subtype(a0)
		beq.s	+ ;loc_2DB66
		move.w	#tiles_to_bytes(ArtTile_Explosion),d2

+ ;loc_2DB66:
		jsr	(Queue_Kos_Module).l		; Load character name graphics
		clr.b	(Update_HUD_timer).w		; Ensure timer isn't being updated currently
		moveq	#0,d0
		move.b	(Timer_minute).w,d0
		mulu.w	#60,d0
		moveq	#0,d1
		move.b	(Timer_second).w,d1
		add.w	d1,d0
		cmpi.w	#600-1,d0
		bne.s	+ ;loc_2DB90
		move.w	#10000,(Time_bonus_countdown).w	; If clock is at 9:59, give an automatic 100000 point time bonus
		bra.s	+++ ;loc_2DBA8
; ---------------------------------------------------------------------------

+ ;loc_2DB90:
		divu.w	#30,d0		; Divide time by 30
		moveq	#7,d1
		cmp.w	d1,d0		; If result is above 7, make it 7
		blo.s	+ ;loc_2DB9C
		move.w	d1,d0

+ ;loc_2DB9C:
		add.w	d0,d0
		lea	TimeBonus(pc),a1
		move.w	(a1,d0.w),(Time_bonus_countdown).w	; Get the time bonus

+ ;loc_2DBA8:
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
		bne.s	locret_2DC34		; Don't load the objects until the art has been loaded
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_2DC34
		lea	ObjArray_LevResults(pc),a2
		moveq	#$C-1,d1		; Make 12 objects

- ;loc_2DBDE:
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
		dbne	d1,- ;loc_2DBDE
		addq.b	#2,routine(a0)
		tst.b	(Apparent_act).w
		bne.s	locret_2DC34		; If this is act 2, branch
		move.b	(Apparent_zone).w,d0
		beq.s	locret_2DC34		; If this is Angel Island, branch
		cmpi.b	#5,d0
		beq.s	locret_2DC34		; If this is Ice Cap Zone, branch
		st	(Events_fg_5).w		; Set the background event flag for the given level (presumably for transitions)

locret_2DC34:
		rts
; ---------------------------------------------------------------------------

Obj_LevelResultsWait:
		tst.w	$2E(a0)
		beq.s	+ ;loc_2DC5C
		subq.w	#1,$2E(a0)
		cmpi.w	#289,$2E(a0)
		bne.s	locret_2DC9E			; Play after eh, a second or so
		move.b	#30,(Player_1+air_left).w	; Reset air for Hydrocity
		move.b	#30,(Player_2+air_left).w
		moveq	#signextendB(mus_GotThroughAct),d0
		jmp	(Play_Music).l			; Play level complete theme
; ---------------------------------------------------------------------------

+ ;loc_2DC5C:
		moveq	#0,d0
		tst.w	(Time_bonus_countdown).w
		beq.s	+ ;loc_2DC6E
		addi.w	#10,d0
		subi.w	#10,(Time_bonus_countdown).w	; Get 100 points from the time bonus

+ ;loc_2DC6E:
		tst.w	(Ring_bonus_countdown).w
		beq.s	+ ;loc_2DC7E
		addi.w	#10,d0
		subi.w	#10,(Ring_bonus_countdown).w	; Get 100 points from the ring bonus

+ ;loc_2DC7E:
		add.w	d0,(Total_bonus_countup).w	; Add to total score for level
		tst.w	d0
		beq.s	+ ;loc_2DCA0			; Branch once score has finished counting down
		jsr	(HUD_AddToScore).l		; Add to actual score
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		bne.s	locret_2DC9E
		moveq	#signextendB(sfx_Switch),d0	; Every four frames, play the score countdown sound
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

locret_2DC9E:
		rts
; ---------------------------------------------------------------------------

+ ;loc_2DCA0:
		moveq	#signextendB(sfx_Register),d0	; Play the cash register sound
		jsr	(Play_SFX).l
		cmpi.w	#$A00,(Current_zone_and_act).w
		beq.s	+ ;loc_2DCB6
		tst.w	subtype(a0)
		beq.s	++ ;loc_2DCC0

+ ;loc_2DCB6:
		st	(SRAM_mask_interrupts_flag).w	; If in act 2 or Sky Sanctuary, save the game
		jsr	(SaveGame).l

+ ;loc_2DCC0:
		move.w	#90,$2E(a0)	; Set wait amount
		addq.b	#2,routine(a0)

Obj_LevelResultsWait2:
		tst.w	$2E(a0)
		beq.s	+ ;loc_2DCD6
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2DCD6:
		tst.w	$30(a0)			; Wait for title screen objects to disappear
		beq.s	+ ;loc_2DCE2
		addq.w	#1,$32(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2DCE2:
		move.b	(Current_zone).w,d0
		cmpi.b	#$A,d0
		beq.s	+ ;loc_2DCF8
		cmpi.b	#$16,d0
		beq.s	+ ;loc_2DCF8
		tst.b	(Apparent_act).w
		beq.s	++ ;loc_2DD06

+ ;loc_2DCF8:
		clr.b	(_unkFAA8).w		; Act 2 (or Sky Sanctuary or LRZ boss)
		st	(End_of_level_flag).w	; Stop level results flag and set title card finished flag
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2DD06:
		move.b	#1,(Apparent_act).w	; Change to act 2 if in act 1
		clr.b	(Last_star_post_hit).w
		clr.b	(Special_bonus_entry_flag).w
		clr.b	(_unkFAA8).w
		cmpi.b	#8,(Current_zone).w
		beq.s	+ ;loc_2DD38
		cmpi.b	#$B,(Current_zone).w
		beq.s	+ ;loc_2DD38			; Neither Sandopolis 1 nor Death Egg 1 immediately show title cards
		move.l	#Obj_TitleCard,(a0)	; Change current object to title card
		clr.b	routine(a0)
		st	$3E(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2DD38:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_LevResultsCharName:
		cmpi.w	#2,(Player_mode).w
		beq.s	+ ;loc_2DD62
		cmpi.w	#3,(Player_mode).w
		bne.s	++ ;loc_2DD7E
		addq.b	#3,mapping_frame(a0)	; Knuckles frame
		moveq	#$30,d0
		sub.w	d0,x_pos(a0)
		sub.w	d0,$46(a0)		; Sprite is offset slightly to the left
		add.b	d0,width_pixels(a0)	; Increase width by said amount
		bra.s	++ ;loc_2DD7E
; ---------------------------------------------------------------------------

+ ;loc_2DD62:
		addq.b	#1,mapping_frame(a0)	; Miles frame
		tst.b	(Graphics_flags).w
		bpl.s	+ ;loc_2DD7E
		addq.b	#1,mapping_frame(a0)	; Tails frame
		moveq	#8,d0
		add.w	d0,x_pos(a0)
		add.w	d0,$46(a0)
		sub.b	d0,width_pixels(a0)	; Offset like above

+ ;loc_2DD7E:
		moveq	#0,d0
		movea.w	parent2(a0),a1
		tst.w	subtype(a1)
		beq.s	+ ;loc_2DD8E
		move.w	#$28,d0

+ ;loc_2DD8E:
		move.w	d0,art_tile(a0)		; Offset VRAM depending on act number
		move.l	#Obj_LevResultsGeneral,(a0)

Obj_LevResultsGeneral:
		jsr	LevelResults_MoveElement(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_LevelResultsTimeBonus:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Time_bonus_countdown).w,d0
		bra.s	+ ;loc_2DDBE
; ---------------------------------------------------------------------------

Obj_LevelResultsRingBonus:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Ring_bonus_countdown).w,d0
		bra.s	+ ;loc_2DDBE
; ---------------------------------------------------------------------------

Obj_LevelResultsTotal:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Total_bonus_countup).w,d0

+ ;loc_2DDBE:
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

- ;loc_2DDE6:
		move.w	d2,(a1)+
		move.w	d3,(a1)+
		addq.w	#1,a1
		rol.l	#4,d1
		move.w	d1,d0
		andi.w	#$F,d0
		beq.s	+ ;loc_2DDF8
		moveq	#1,d4

+ ;loc_2DDF8:
		add.w	d4,d0
		move.b	d0,(a1)+
		addq.w	#8,d2
		dbf	d5,- ;loc_2DDE6
		rts
; End of function LevResults_DisplayScore


; =============== S U B R O U T I N E =======================================


LevelResults_MoveElement:
		movea.w	parent2(a0),a1
		move.w	$32(a1),d0
		beq.s	+++ ;loc_2DE38
		tst.b	render_flags(a0)
		bmi.s	+ ;loc_2DE20
		subq.w	#1,$30(a1)			; If offscreen, subtract from number of elements and delete
		addq.w	#4,sp
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2DE20:
		cmp.b	$28(a0),d0		; Level element moving out. Test if value of parent queue matches given queue value
		blo.s	locret_2DE4E
		move.w	#-$20,d0		; If so, move out
		tst.b	routine(a0)
		beq.s	+ ;loc_2DE32
		neg.w	d0				; Change direction depending on where it came from

+ ;loc_2DE32:
		add.w	x_pos(a0),d0
		bra.s	+++ ;loc_2DE4A
; ---------------------------------------------------------------------------

+ ;loc_2DE38:
		moveq	#$10,d1			; Level element moving in
		move.w	x_pos(a0),d0
		cmp.w	$46(a0),d0
		beq.s	++ ;loc_2DE4A		; If X position has reached destination, don't do anything else
		blt.s	+ ;loc_2DE48		; See which direction it needs to go
		neg.w	d1

+ ;loc_2DE48:
		add.w	d1,d0			; Add speed to X amount

+ ;loc_2DE4A:
		move.w	d0,x_pos(a0)

locret_2DE4E:
		rts
; End of function LevelResults_MoveElement


; =============== S U B R O U T I N E =======================================


LevResults_GetDecimalScore:
		clr.l	(_unkEF40_1).w
		lea	TimeBonus(pc),a1
		moveq	#$10-1,d2

- ;loc_2DE5A:
		ror.w	#1,d0
		bcs.s	+ ;loc_2DE62
		subq.w	#3,a1
		bra.s	++ ;loc_2DE70
; ---------------------------------------------------------------------------

+ ;loc_2DE62:
		lea	(_unkEF44_2).w,a2
		addi.w	#0,d0
		abcd	-(a1),-(a2)
		abcd	-(a1),-(a2)
		abcd	-(a1),-(a2)

+ ;loc_2DE70:
		dbf	d2,- ;loc_2DE5A
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

locret_2DF62:
		rts
; ---------------------------------------------------------------------------

SpecialStage_Results:
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.b	(Current_special_stage).w,d0
		move.b	d0,(Current_special_stage_2).w
		move.b	(HPZ_current_special_stage).w,d1
		beq.s	+ ;loc_2DF82
		andi.b	#$7F,d1
		move.b	d1,d0
		bra.s	++ ;loc_2DF8C
; ---------------------------------------------------------------------------

+ ;loc_2DF82:
		addq.b	#1,d0
		cmpi.b	#7,d0
		blo.s	+ ;loc_2DF8C
		moveq	#0,d0

+ ;loc_2DF8C:
		move.b	d0,(Current_special_stage).w
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$8B03,(a6)
		move.w	#$8C81,(a6)
		move.w	#$9001,(a6)
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(SRAM_mask_interrupts_flag).w
		jsr	(SaveGame_SpecialStage).l
		clr.w	(Competition_mode).w
		clr.w	(Plane_buffer).w
		clr.w	(Special_V_int_routine).w
		clr.b	(Update_HUD_timer).w
		clr.w	(Palette_fade_timer).w
		move.w	(Current_zone_and_act).w,(Special_stage_zone_and_act).w
		lea	PLC_SpecialResultsText(pc),a1
		jsr	(Load_PLC_Raw).l
		lea	(ArtKosM_ResultsGeneral).l,a1
		move.w	#tiles_to_bytes($5B8),d2
		jsr	(Queue_Kos_Module).l
		cmpi.w	#3,(Player_mode).w
		bne.s	+ ;loc_2E04E
		lea	(ArtKosM_SSResultsSUPERk).l,a1
		cmpi.b	#7,(Super_emerald_count).w
		blo.s	++ ;loc_2E06A
		lea	(ArtKosM_SSResultsHYPERk).l,a1
		bra.s	++ ;loc_2E06A
; ---------------------------------------------------------------------------

+ ;loc_2E04E:
		lea	(ArtKosM_SSResultsSUPER).l,a1
		cmpi.w	#2,(Player_mode).w
		beq.s	+ ;loc_2E06A
		cmpi.b	#7,(Super_emerald_count).w
		blo.s	+ ;loc_2E06A
		lea	(ArtKosM_SSResultsHYPER).l,a1

+ ;loc_2E06A:
		move.w	#tiles_to_bytes($50F),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_ResultsSONIC).l,a1
		cmpi.w	#1,(Player_mode).w
		bls.s	+ ;loc_2E0A2
		lea	(ArtKosM_ResultsKNUCKLES).l,a1
		cmpi.w	#3,(Player_mode).w
		beq.s	+ ;loc_2E0A2
		lea	(ArtKosM_ResultsMILES).l,a1
		tst.b	(Graphics_flags).w
		bpl.s	+ ;loc_2E0A2
		lea	(ArtKosM_ResultsTAILS).l,a1

+ ;loc_2E0A2:
		move.w	#tiles_to_bytes($4F1),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_SSResults).l,a1
		move.w	#tiles_to_bytes($523),d2
		jsr	(Queue_Kos_Module).l
		move.l	#locret_2DF62,(_unkEF44_1).w

loc_2E0C4:
		move.b	#$1E,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		jsr	(Wait_VSync).l
		jsr	(Process_Nem_Queue_Init).l
		jsr	(Process_Kos_Module_Queue).l
		tst.b	(Kos_modules_left).w
		bne.s	loc_2E0C4
		tst.l	(Nem_decomp_queue).w
		bne.s	loc_2E0C4
		jsr	(HUD_DrawInitial).l
		move.b	#1,(Update_HUD_score).w
		lea	Pal_Results(pc),a0
		lea	(Normal_palette).w,a1
		moveq	#bytesToLcnt($80),d0

- ;loc_2E104:
		move.l	(a0),(a1)+
		move.l	(a0)+,Target_palette-Normal_palette-4(a1)
		dbf	d0,- ;loc_2E104
		jsr	sub_2E2C0(pc)
		tst.w	(SK_alone_flag).w
		bne.w	+ ;loc_2E226
		tst.b	(SK_special_stage_flag).w
		beq.w	+ ;loc_2E226
		lea	Pal_Results(pc),a0
		lea	(Normal_palette).w,a1
		moveq	#bytesToLcnt($20),d0

- ;loc_2E12C:
		move.l	(a0)+,d1
		move.l	d1,Target_palette_line_2-Normal_palette(a1)
		move.l	d1,Normal_palette_line_2-Normal_palette(a1)
		move.l	d1,Target_palette-Normal_palette(a1)
		move.l	d1,(a1)+
		dbf	d0,- ;loc_2E12C
		jsr	sub_2E2C0(pc)
		lea	(Pal_HPZIntro+$20).l,a0
		lea	(Normal_palette_line_3).w,a1
		moveq	#bytesToLcnt($40),d0

- ;loc_2E150:
		move.l	#$CCC0CCC,(a1)+
		move.l	(a0)+,Target_palette_line_3-Normal_palette_line_3-4(a1)
		dbf	d0,- ;loc_2E150
		lea	(Layout_HPZ).l,a0
		lea	(Level_layout_header).w,a1
		move.w	#bytesToLcnt($1000),d0

- ;loc_2E16C:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_2E16C
		lea	(HPZ_128x128_Primary_Kos).l,a0
		lea	(RAM_start).l,a1
		jsr	(Kos_Decomp).l
		lea	(HPZ_128x128_Secondary_Kos).l,a0
		jsr	(Kos_Decomp).l
		lea	(HPZ_16x16_Primary_Kos).l,a0
		lea	(Block_table).w,a1
		jsr	(Kos_Decomp).l
		lea	(HPZ_16x16_Secondary_Kos).l,a0
		jsr	(Kos_Decomp).l
		lea	(ArtKosM_HPZ_Primary).l,a1
		move.w	(a1),d4
		move.w	#tiles_to_bytes($000),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_HPZ_Secondary).l,a1
		move.w	d4,d2
		jsr	(Queue_Kos_Module).l
		moveq	#$48,d0
		jsr	(Load_PLC).l
		move.w	#$1701,(Current_zone_and_act).w
		move.w	#$15A0,(Camera_X_pos).w
		move.w	#$240,(Camera_Y_pos).w
		clr.b	(Object_load_routine).w
		jsr	(Load_Sprites).l
		moveq	#0,d0
		move.b	(Current_special_stage_2).w,d0
		add.w	d0,d0
		lea	word_2E398(pc),a0
		move.w	(a0,d0.w),(Camera_X_pos).w
		move	#$2700,sr
		jsr	(j_LevelSetup).l
		move	#$2300,sr
		tst.w	(Special_stage_spheres_left).w
		bne.s	+ ;loc_2E226
		move.b	(Current_special_stage_2).w,d0
		ori.b	#$80,d0
		move.b	d0,(_unkFAC0).w
		st	(_unkFAC1).w

+ ;loc_2E226:
		jsr	(Init_SpriteTable).l
		move.w	#$98,(_unkEF68).w
		st	(HPZ_special_stage_completed).w
		move.l	#Obj_SpecialStage_Results,(Dynamic_object_RAM+(object_size*29)).w
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l

loc_2E24C:
		move.b	#8,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		move.w	(Emerald_flicker_flag).w,d1
		addq.w	#1,d1
		cmpi.w	#3,d1
		blo.s	+ ;loc_2E270
		moveq	#0,d1

+ ;loc_2E270:
		move.w	d1,(Emerald_flicker_flag).w
		jsr	(Process_Sprites).l
		tst.w	(SK_alone_flag).w
		bne.s	+ ;loc_2E28C
		tst.b	(SK_special_stage_flag).w
		beq.s	+ ;loc_2E28C
		jsr	(ScreenEvents).l

+ ;loc_2E28C:
		jsr	(Render_Sprites).l
		jsr	(Process_Nem_Queue_Init).l
		jsr	(Process_Kos_Module_Queue).l
		tst.w	(Palette_fade_timer).w
		beq.s	+ ;loc_2E2B0
		bmi.s	+ ;loc_2E2B0
		subq.w	#1,(Palette_fade_timer).w
		jsr	(Pal_FromWhite).l

+ ;loc_2E2B0:
		cmpi.b	#$48,(Game_mode).w
		beq.s	loc_2E24C
		move.w	(Special_stage_zone_and_act).w,(Current_zone_and_act).w
		rts

; =============== S U B R O U T I N E =======================================


sub_2E2C0:
		cmpi.w	#3,(Player_mode).w
		bne.s	++ ;loc_2E2F6
		lea	(Normal_palette+$4).w,a0
		move.l	#$84E040C,d0
		move.l	d0,Target_palette-Normal_palette(a0)
		move.l	d0,(a0)+
		move.l	#$2060080,d0
		tst.w	(SK_alone_flag).w
		bne.s	+ ;loc_2E2EE
		tst.b	(SK_special_stage_flag).w
		beq.s	+ ;loc_2E2EE
		move.w	#$EE,d0

+ ;loc_2E2EE:
		move.l	d0,Target_palette-Normal_palette(a0)
		move.l	d0,(a0)
		bra.s	locret_2E30E
; ---------------------------------------------------------------------------

+ ;loc_2E2F6:
		tst.w	(SK_alone_flag).w
		bne.s	locret_2E30E
		tst.b	(SK_special_stage_flag).w
		beq.s	locret_2E30E
		move.w	#$EE,(Normal_palette_line_2+$A).w
		move.w	#$EE,(Target_palette_line_2+$A).w

locret_2E30E:
		rts
; End of function sub_2E2C0

; ---------------------------------------------------------------------------
PLC_SpecialResultsText: plrlistheader
		plreq ArtTile_Ring, ArtNem_RingHUDText
PLC_SpecialResultsText_End

Pal_Results:
		binclude "General/Special Stage/Palettes/Results.bin"
		even
word_2E398:
		dc.w  $15A0
		dc.w  $1540
		dc.w  $1600
		dc.w  $1500
		dc.w  $1640
		dc.w  $14B0
		dc.w  $1690
		dc.w  $15A0
		dc.w   $368
		dc.w   $3A0
		dc.w   $3A0
		dc.w   $350
		dc.w   $350
		dc.w   $390
		dc.w   $390
		dc.w   $368
; ---------------------------------------------------------------------------

Obj_SpecialStage_Results:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_2E3DA-.Index
		dc.w loc_2E410-.Index
		dc.w loc_2E4D6-.Index
		dc.w loc_2E512-.Index
		dc.w loc_2E5C0-.Index
		dc.w loc_2E5E0-.Index
		dc.w loc_2E5F4-.Index
		dc.w loc_2E616-.Index
		dc.w loc_2E746-.Index
		dc.w loc_2E7DA-.Index
; ---------------------------------------------------------------------------

loc_2E3DA:
		lea	next_object(a0),a1
		lea	ObjDat2_2E834(pc),a2
		moveq	#$13-1,d1
		jsr	sub_2E802(pc)
		move.w	(Special_stage_ring_count).w,d0
		mulu.w	#10,d0
		move.w	d0,(Ring_bonus_countdown).w
		clr.w	(Time_bonus_countdown).w
		tst.w	(Special_stage_rings_left).w
		bne.s	+ ;loc_2E404
		move.w	#5000,(Time_bonus_countdown).w

+ ;loc_2E404:
		move.w	#6*60,$2E(a0)
		addq.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_2E410:
		tst.w	$2E(a0)
		beq.s	++ ;loc_2E484
		subq.w	#1,$2E(a0)
		bne.s	+ ;loc_2E474
		tst.w	(SK_alone_flag).w
		bne.s	+ ;loc_2E474
		tst.b	(SK_special_stage_flag).w
		beq.s	+ ;loc_2E474
		tst.w	(Special_stage_spheres_left).w
		bne.s	+ ;loc_2E474
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$16,(Palette_fade_timer).w
		lea	(Normal_palette).w,a1
		move.w	#$EEE,$42(a1)
		move.w	#$EEE,$44(a1)
		move.w	#$EEE,$4C(a1)
		move.w	#$EEE,$62(a1)
		move.w	#$EEE,$66(a1)
		move.w	#$EEE,$6E(a1)
		move.w	#$EEE,$70(a1)
		move.w	#$EEE,$7C(a1)
		move.w	#$EEE,$7E(a1)

+ ;loc_2E474:
		cmpi.w	#289,$2E(a0)
		bne.s	locret_2E4C2
		moveq	#signextendB(mus_GotThroughAct),d0
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------

+ ;loc_2E484:
		moveq	#0,d0
		tst.w	(Time_bonus_countdown).w
		beq.s	+ ;loc_2E496
		addi.w	#10,d0
		subi.w	#10,(Time_bonus_countdown).w

+ ;loc_2E496:
		tst.w	(Ring_bonus_countdown).w
		beq.s	+ ;loc_2E4A6
		addi.w	#10,d0
		subi.w	#10,(Ring_bonus_countdown).w

+ ;loc_2E4A6:
		tst.w	d0
		beq.s	+ ;loc_2E4C4
		jsr	(HUD_AddToScore).l
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		bne.s	locret_2E4C2
		moveq	#signextendB(sfx_Switch),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

locret_2E4C2:
		rts
; ---------------------------------------------------------------------------

+ ;loc_2E4C4:
		moveq	#signextendB(sfx_Register),d0
		jsr	(Play_SFX).l
		move.w	#2*60,$2E(a0)
		addq.b	#2,routine(a0)

loc_2E4D6:
		cmpi.w	#50,(Special_stage_ring_count).w
		blo.s	++ ;loc_2E50E
		tst.w	$2E(a0)
		beq.s	+ ;loc_2E4EA
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2E4EA:
		clr.w	(SStage_results_object_addr).w
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	+ ;loc_2E50E
		move.w	a1,(SStage_results_object_addr).w
		move.l	#loc_2EBE8,(a1)
		move.w	#270,$2E(a0)
		moveq	#signextendB(sfx_Continue),d0
		jsr	(Play_SFX).l

+ ;loc_2E50E:
		addq.b	#2,routine(a0)

loc_2E512:
		tst.w	(SK_alone_flag).w
		bne.s	+ ;loc_2E534
		tst.b	(SK_special_stage_flag).w
		beq.s	+ ;loc_2E534
		tst.w	(Special_stage_spheres_left).w
		bne.s	+ ;loc_2E534
		move.w	#60,$2E(a0)
		move.b	#$E,routine(a0)
		bra.w	loc_2E616
; ---------------------------------------------------------------------------

+ ;loc_2E534:
		tst.w	$2E(a0)
		beq.s	+ ;loc_2E540
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2E540:
		tst.w	(Special_stage_spheres_left).w
		bne.s	loc_2E5B8
		cmpi.b	#7,(Chaos_emerald_count).w
		blo.s	loc_2E5B8
		cmpi.w	#3,(Player_mode).w
		beq.s	+ ;loc_2E570
		cmpi.w	#1,(Player_mode).w
		bls.s	+ ;loc_2E570
		cmpi.b	#4,(Special_stage_zone_and_act).w
		beq.s	++ ;loc_2E586
		cmpi.b	#7,(Special_stage_zone_and_act).w
		blo.s	loc_2E5B8
		bra.s	++ ;loc_2E586
; ---------------------------------------------------------------------------

+ ;loc_2E570:
		tst.w	(SK_alone_flag).w
		bne.s	++ ;loc_2E58C
		cmpi.b	#4,(Special_stage_zone_and_act).w
		beq.s	+ ;loc_2E586
		cmpi.b	#7,(Special_stage_zone_and_act).w
		blo.s	++ ;loc_2E58C

+ ;loc_2E586:
		move.b	#$A,routine(a0)

+ ;loc_2E58C:
		lea	(Dynamic_object_RAM+(object_size*44)).w,a1
		moveq	#4,d0

- ;loc_2E592:
		move.l	#loc_2EC1E,(a1)
		lea	next_object(a1),a1
		dbf	d0,- ;loc_2E592
		move.w	#4,(Dynamic_object_RAM+(object_size*46)+objoff_2E).w
		move.w	#4,(Dynamic_object_RAM+(object_size*48)+objoff_2E).w
		move.w	#5,$30(a0)
		addq.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_2E5B8:
		move.b	#$C,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_2E5C0:
		tst.w	$30(a0)
		bne.s	locret_2E5DE
		lea	(Dynamic_object_RAM+(object_size*44)).w,a1
		lea	ObjDat2_2E918(pc),a2
		moveq	#6-1,d1
		jsr	sub_2E802(pc)
		move.w	#4*60,$2E(a0)
		addq.b	#2,routine(a0)

locret_2E5DE:
		rts
; ---------------------------------------------------------------------------

loc_2E5E0:
		tst.w	$2E(a0)
		beq.s	+ ;loc_2E5EC
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2E5EC:
		move.b	#$C,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_2E5F4:
		tst.w	$30(a0)
		bne.s	locret_2E614
		lea	(Dynamic_object_RAM+(object_size*44)).w,a1
		lea	ObjDat2_2E960(pc),a2
		moveq	#3-1,d1
		jsr	sub_2E802(pc)
		move.w	#4*60,$2E(a0)
		move.b	#$A,routine(a0)

locret_2E614:
		rts
; ---------------------------------------------------------------------------

loc_2E616:
		tst.w	$2E(a0)
		beq.s	+ ;loc_2E622
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2E622:
		move.w	(Camera_Y_pos).w,d0
		cmpi.w	#$320,d0
		bhs.w	loc_2E6EA
		addq.w	#1,d0
		move.w	d0,(Camera_Y_pos).w
		cmpi.w	#$2A0,d0
		bne.w	locret_2E744
		moveq	#4,d0
		cmpi.w	#50,(Special_stage_ring_count).w
		blo.s	++ ;loc_2E65C
		move.w	(SStage_results_object_addr).w,d1
		beq.s	+ ;loc_2E65A
		movea.w	d1,a1
		move.l	#loc_2EC4A,(a1)
		move.w	#20,$2E(a1)

+ ;loc_2E65A:
		addq.w	#1,d0

+ ;loc_2E65C:
		move.w	d0,$30(a0)
		lea	(Dynamic_object_RAM+(object_size*30)).w,a1

- ;loc_2E664:
		move.l	#loc_2EC1E,(a1)
		lea	next_object(a1),a1
		dbf	d0,- ;loc_2E664
		moveq	#2,d0
		cmpi.b	#7,(Super_emerald_count).w
		blo.s	+ ;loc_2E67E
		addq.w	#2,d0

+ ;loc_2E67E:
		add.w	d0,$30(a0)
		lea	(Dynamic_object_RAM+(object_size*44)).w,a1

- ;loc_2E686:
		move.l	#loc_2EC1E,(a1)
		lea	next_object(a1),a1
		dbf	d0,- ;loc_2E686
		addq.w	#2,$30(a0)
		lea	(Dynamic_object_RAM+(object_size*30)).w,a1
		move.w	#8,$2E(a1)
		move.w	#12,next_object+$2E(a1)
		move.w	#12,(next_object*2)+$2E(a1)
		move.w	#16,(next_object*3)+$2E(a1)
		move.w	#16,(next_object*4)+$2E(a1)
		cmpi.w	#50,(Special_stage_ring_count).w
		blo.s	+ ;loc_2E6C8
		move.w	#20,(next_object*5)+$2E(a1)

+ ;loc_2E6C8:
		clr.w	(next_object*2)+mainspr_childsprites(a1)
		clr.w	(next_object*4)+mainspr_childsprites(a1)
		lea	(Dynamic_object_RAM+(object_size*44)).w,a1
		move.w	#4,(next_object*2)+$2E(a1)
		cmpi.b	#7,(Super_emerald_count).w
		blo.s	+ ;loc_2E6E8
		move.w	#4,(next_object*4)+$2E(a1)

+ ;loc_2E6E8:
		bra.s	locret_2E744
; ---------------------------------------------------------------------------

loc_2E6EA:
		move.l	#ArtUnc_Invincibility,d1
		move.w	#tiles_to_bytes(ArtTile_Shield),d2
		move.w	#$200,d3
		jsr	(Add_To_DMA_Queue).l
		jsr	(AllocateObject).l
		bne.s	+ ;loc_2E72E
		moveq	#0,d1
		moveq	#0,d2
		moveq	#7,d3

- ;loc_2E70C:
		move.l	#loc_2ECD0,(a1)
		move.w	d1,$2E(a1)
		move.w	d2,$30(a1)
		move.w	a0,$34(a1)
		addi.w	#$10,d1
		addq.w	#1,d2
		jsr	(CreateNewSprite4).l
		dbne	d3,- ;loc_2E70C

+ ;loc_2E72E:
		move.w	#30,$2E(a0)
		clr.w	$30(a0)
		addq.b	#2,routine(a0)
		moveq	#signextendB(sfx_Signpost),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

locret_2E744:
		rts
; ---------------------------------------------------------------------------

loc_2E746:
		tst.w	$30(a0)
		beq.w	locret_2E7D8
		bmi.s	+ ;loc_2E75C
		st	$30(a0)
		moveq	#signextendB(sfx_SuperEmerald),d0
		jsr	(Play_SFX).l

+ ;loc_2E75C:
		cmpi.b	#7,(Super_emerald_count).w
		bhs.s	+ ;loc_2E772
		move.w	#60,$2E(a0)
		move.b	#$A,routine(a0)
		bra.s	locret_2E7D8
; ---------------------------------------------------------------------------

+ ;loc_2E772:
		tst.w	$2E(a0)
		beq.s	+ ;loc_2E77E
		subq.w	#1,$2E(a0)
		bra.s	locret_2E7D8
; ---------------------------------------------------------------------------

+ ;loc_2E77E:
		moveq	#1,d0
		cmpi.w	#$15A0,(Camera_X_pos).w
		beq.s	++ ;loc_2E792
		bcs.s	+ ;loc_2E78C
		neg.w	d0

+ ;loc_2E78C:
		add.w	d0,(Camera_X_pos).w
		bra.s	locret_2E7D8
; ---------------------------------------------------------------------------

+ ;loc_2E792:
		jsr	(AllocateObject).l
		bne.s	+ ;loc_2E7C6
		moveq	#0,d1
		moveq	#0,d2
		moveq	#7,d3

- ;loc_2E7A0:
		move.l	#loc_2ECD0,(a1)
		move.w	d1,$2E(a1)
		move.w	d2,$30(a1)
		move.w	a0,$34(a1)
		st	$36(a1)
		addi.w	#$10,d1
		addq.w	#1,d2
		jsr	(CreateNewSprite4).l
		dbne	d3,- ;loc_2E7A0

+ ;loc_2E7C6:
		move.w	#2*60,$2E(a0)
		addq.b	#2,routine(a0)
		moveq	#signextendB(sfx_Signpost),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

locret_2E7D8:
		rts
; ---------------------------------------------------------------------------

loc_2E7DA:
		tst.w	$2E(a0)
		beq.s	+ ;loc_2E7E6
		subq.w	#1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2E7E6:
		lea	(Dynamic_object_RAM+(object_size*61)).w,a1
		lea	ObjDat2_2E984(pc),a2
		moveq	#7-1,d1
		jsr	sub_2E802(pc)
		move.w	#6*60,$2E(a0)
		move.b	#$A,routine(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_2E802:
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
		dbf	d1,sub_2E802
		rts
; End of function sub_2E802

; ---------------------------------------------------------------------------
ObjDat2_2E834:
		dc.l loc_2EA1E
		dc.w   $120,  $4E0,  $100
		dc.b  $17, $60
		dc.l loc_2EA1E
		dc.w    $C0,  $4C0,  $118
		dc.b  $18, $58
		dc.l loc_2EA5A
		dc.w   $178,  $578,  $118
		dc.b    1, $40
		dc.l loc_2EA1E
		dc.w    $C0,  $500,  $128
		dc.b  $19, $40
		dc.l loc_2EA64
		dc.w   $178,  $5B8,  $128
		dc.b    1, $40
		dc.l loc_2EA7C
		dc.w    $C0,  $540,  $138
		dc.b  $1A, $48
		dc.l loc_2EAA6
		dc.w   $120,  $120,   $D0
		dc.b  $1B,   0
		dc.l loc_2EAA6
		dc.w   $110,  $110,   $E8
		dc.b  $1C,   1
		dc.l loc_2EAA6
		dc.w   $130,  $130,   $E8
		dc.b  $1D,   2
		dc.l loc_2EAA6
		dc.w   $100,  $100,   $D0
		dc.b  $1E,   3
		dc.l loc_2EAA6
		dc.w   $140,  $140,   $D0
		dc.b  $1F,   4
		dc.l loc_2EAA6
		dc.w    $F0,   $F0,   $E8
		dc.b  $20,   5
		dc.l loc_2EAA6
		dc.w   $150,  $150,   $E8
		dc.b  $21,   6
		dc.l loc_2EAC8
		dc.w   $120,  $460,   $A0
		dc.b  $22, $60
		dc.l loc_2EAD8
		dc.w    $D4,  $394,   $98
		dc.b  $13, $48
		dc.l loc_2EB30
		dc.w   $124,  $3E4,   $98
		dc.b  $23, $48
		dc.l loc_2EB64
		dc.w   $120,  $460,   $B0
		dc.b  $24, $64
		dc.l loc_2EBA4
		dc.w   $114,  $3D4,   $98
		dc.b  $25, $20
		dc.l loc_2EBCC
		dc.w   $118,  $458,   $B0
		dc.b  $26, $10
ObjDat2_2E918:
		dc.l loc_2EA10
		dc.w    $C0,  $3C0,   $98
		dc.b  $27, $38
		dc.l loc_2EAF6
		dc.w   $100,  $400,   $98
		dc.b  $13, $48
		dc.l loc_2EA3E
		dc.w   $150,  $450,   $98
		dc.b  $3A, $30
		dc.l loc_2EA10
		dc.w    $C0,  $440,   $B0
		dc.b  $28, $20
		dc.l loc_2E9F6
		dc.w    $E8,  $468,   $B0
		dc.b  $12, $50
		dc.l loc_2EAF6
		dc.w   $138,  $4B8,   $B0
		dc.b  $13, $48
ObjDat2_2E960:
		dc.l loc_2EAF6
		dc.w    $B8,  $3B8,   $98
		dc.b  $13, $48
		dc.l loc_2EA3E
		dc.w   $148,  $448,   $98
		dc.b  $2E, $40
		dc.l loc_2EA50
		dc.w   $120,  $4A0,   $B0
		dc.b  $2F, $60
ObjDat2_2E984:
		dc.l loc_2EA10
		dc.w    $C0,  $3C0,  $124
		dc.b  $2C, $38
		dc.l loc_2EAF6
		dc.w   $100,  $400,  $124
		dc.b  $13, $48
		dc.l loc_2EA3E
		dc.w   $150,  $450,  $124
		dc.b  $2D, $30
		dc.l loc_2EA10
		dc.w    $C0,  $440,  $13C
		dc.b  $35, $20
		dc.l loc_2E9F6
		dc.w    $E8,  $468,  $13C
		dc.b  $12, $50
		dc.l loc_2EAF6
		dc.w   $138,  $4B8,  $13C
		dc.b  $13, $48
		dc.l loc_2E9D8
		dc.w      0,     0,     0
		dc.b    0,   0
; ---------------------------------------------------------------------------

loc_2E9D8:
		move.w	-$3A(a0),d0
		cmp.w	-4(a0),d0
		bne.s	locret_2E9F4
		clr.b	(_unkFAC1).w
		moveq	#signextendB(sfx_Perfect),d0
		jsr	(Play_SFX).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locret_2E9F4:
		rts
; ---------------------------------------------------------------------------

loc_2E9F6:
		tst.w	(SK_alone_flag).w
		bne.s	loc_2EA10
		tst.b	(SK_special_stage_flag).w
		beq.s	loc_2EA10
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_2EA10
		move.w	#make_art_tile($000,1,0),art_tile(a0)

loc_2EA10:
		jsr	sub_2EC80(pc)
		add.w	d0,x_pos(a0)
		add.w	d0,$46(a0)
		bra.s	loc_2EA4A
; ---------------------------------------------------------------------------

loc_2EA1E:
		tst.w	(SK_alone_flag).w
		bne.s	loc_2EA4A
		tst.b	(SK_special_stage_flag).w
		beq.s	loc_2EA4A
		addi.b	#$1A,mapping_frame(a0)
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_2EA4A
		addq.b	#5,mapping_frame(a0)
		bra.s	loc_2EA4A
; ---------------------------------------------------------------------------

loc_2EA3E:
		jsr	sub_2EC80(pc)
		sub.w	d0,x_pos(a0)
		sub.w	d0,$46(a0)

loc_2EA4A:
		move.l	#loc_2EA50,(a0)

loc_2EA50:
		jsr	LevelResults_MoveElement(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2EA5A:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Ring_bonus_countdown).w,d0
		bra.s	+ ;loc_2EA6C
; ---------------------------------------------------------------------------

loc_2EA64:
		jsr	LevelResults_MoveElement(pc)
		move.w	(Time_bonus_countdown).w,d0

+ ;loc_2EA6C:
		jsr	LevResults_DisplayScore(pc)
		move.w	(_unkEF68).w,art_tile(a0)			; this is not here in Sonic 3. _unkEF68 is always set to $98. What does this do?!?!?!
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2EA7C:
		cmpi.w	#50,(Special_stage_ring_count).w
		blo.w	loc_2EC7A
		tst.w	(SK_alone_flag).w
		bne.s	loc_2EA4A
		tst.b	(SK_special_stage_flag).w
		beq.s	loc_2EA4A
		addi.b	#$1A,mapping_frame(a0)
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_2EA4A
		addq.b	#5,mapping_frame(a0)
		bra.s	loc_2EA4A
; ---------------------------------------------------------------------------

loc_2EAA6:
		lea	(Collected_emeralds_array).w,a1
		moveq	#0,d0
		move.b	width_pixels(a0),d0
		cmpi.b	#1,(a1,d0.w)
		bne.w	loc_2EC7A
		tst.w	(Emerald_flicker_flag).w
		beq.s	locret_2EAC6
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_2EAC6:
		rts
; ---------------------------------------------------------------------------

loc_2EAC8:
		tst.w	(Special_stage_spheres_left).w
		beq.w	loc_2EC7A
		jsr	sub_2ECBC(pc)
		bra.w	loc_2EA50
; ---------------------------------------------------------------------------

loc_2EAD8:
		tst.w	(Special_stage_spheres_left).w
		bne.w	loc_2EC7A
		jsr	sub_2ECA8(pc)
		cmpi.b	#7,(a1)
		blo.s	loc_2EAF6
		subi.w	#$10,x_pos(a0)
		subi.w	#$10,$46(a0)

loc_2EAF6:
		jsr	sub_2EC80(pc)
		add.w	d0,x_pos(a0)
		add.w	d0,$46(a0)
		add.b	d1,mapping_frame(a0)
		move.w	#-$87,art_tile(a0)
		tst.w	(SK_alone_flag).w
		bne.w	loc_2EA4A
		tst.b	(SK_special_stage_flag).w
		beq.w	loc_2EA4A
		cmpi.w	#3,(Player_mode).w
		bne.w	loc_2EA4A
		addi.w	#palette_line_1,art_tile(a0)
		bra.w	loc_2EA4A
; ---------------------------------------------------------------------------

loc_2EB30:
		tst.w	(Special_stage_spheres_left).w
		bne.w	loc_2EC7A
		jsr	sub_2ECBC(pc)
		jsr	sub_2EC80(pc)
		sub.w	d0,x_pos(a0)
		sub.w	d0,$46(a0)
		jsr	sub_2ECA8(pc)
		cmpi.b	#7,(a1)
		blo.w	loc_2EA4A
		subi.w	#$10,x_pos(a0)
		subi.w	#$10,$46(a0)
		bra.w	loc_2EA4A
; ---------------------------------------------------------------------------

loc_2EB64:
		tst.w	(Special_stage_spheres_left).w
		bne.w	loc_2EC7A
		jsr	sub_2ECBC(pc)
		tst.w	(SK_alone_flag).w
		bne.s	+ ;loc_2EB7C
		tst.b	(SK_special_stage_flag).w
		bne.s	++ ;loc_2EB88

+ ;loc_2EB7C:
		cmpi.b	#7,(Chaos_emerald_count).w
		blo.w	loc_2EA4A
		bra.s	loc_2EB98
; ---------------------------------------------------------------------------

+ ;loc_2EB88:
		move.b	#$30,mapping_frame(a0)
		cmpi.b	#7,(Super_emerald_count).w
		blo.w	loc_2EA4A

loc_2EB98:
		subq.w	#8,x_pos(a0)
		subq.w	#8,$46(a0)
		bra.w	loc_2EA4A
; ---------------------------------------------------------------------------

loc_2EBA4:
		tst.w	(Special_stage_spheres_left).w
		bne.w	loc_2EC7A
		jsr	sub_2ECBC(pc)
		jsr	sub_2ECA8(pc)
		cmpi.b	#7,(a1)
		blo.w	loc_2EC7A
		jsr	sub_2EC80(pc)
		sub.w	d0,x_pos(a0)
		sub.w	d0,$46(a0)
		bra.w	loc_2EA4A
; ---------------------------------------------------------------------------

loc_2EBCC:
		tst.w	(Special_stage_spheres_left).w
		bne.w	loc_2EC7A
		jsr	sub_2ECBC(pc)
		jsr	sub_2ECA8(pc)
		cmpi.b	#7,(a1)
		blo.w	loc_2EC7A
		bra.w	loc_2EA50
; ---------------------------------------------------------------------------

loc_2EBE8:
		move.l	#Map_Results,mappings(a0)
		move.w	#$17C,x_pos(a0)
		move.w	#$14C,y_pos(a0)
		move.w	(Player_mode).w,d0
		subq.w	#1,d0
		bcc.s	+ ;loc_2EC06
		moveq	#0,d0

+ ;loc_2EC06:
		addi.w	#$29,d0
		move.b	d0,mapping_frame(a0)
		btst	#3,(Level_frame_counter+1).w
		beq.s	locret_2EC1C
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_2EC1C:
		rts
; ---------------------------------------------------------------------------

loc_2EC1E:
		tst.w	$2E(a0)
		beq.s	+ ;loc_2EC2A
		subq.w	#1,$2E(a0)
		bra.s	+++ ;loc_2EC44
; ---------------------------------------------------------------------------

+ ;loc_2EC2A:
		tst.b	render_flags(a0)
		bmi.s	+ ;loc_2EC3E
		movea.w	parent2(a0),a1
		subq.w	#1,$30(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2EC3E:
		addi.w	#$20,x_pos(a0)

+ ;loc_2EC44:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_2EC4A:
		tst.w	$2E(a0)
		beq.s	+ ;loc_2EC56
		subq.w	#1,$2E(a0)
		bra.s	+++ ;loc_2EC6A
; ---------------------------------------------------------------------------

+ ;loc_2EC56:
		cmpi.w	#$1CC,x_pos(a0)
		blo.s	+ ;loc_2EC64
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2EC64:
		addi.w	#$20,x_pos(a0)

+ ;loc_2EC6A:
		btst	#3,(Level_frame_counter+1).w
		beq.s	locret_2EC78
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_2EC78:
		rts
; ---------------------------------------------------------------------------

loc_2EC7A:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_2EC80:
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
; End of function sub_2EC80


; =============== S U B R O U T I N E =======================================


sub_2ECA8:
		lea	(Chaos_emerald_count).w,a1
		tst.w	(SK_alone_flag).w
		bne.s	.return
		tst.b	(SK_special_stage_flag).w
		beq.s	.return
		addq.w	#1,a1

.return:
		rts
; End of function sub_2ECA8


; =============== S U B R O U T I N E =======================================


sub_2ECBC:
		tst.w	(SK_alone_flag).w
		bne.s	+ ;loc_2ECC8
		tst.b	(SK_special_stage_flag).w
		bne.s	locret_2ECCE

+ ;loc_2ECC8:
		move.w	#make_art_tile($000,3,0),art_tile(a0)

locret_2ECCE:
		rts
; End of function sub_2ECBC

; ---------------------------------------------------------------------------

loc_2ECD0:
		move.l	#loc_2ED2A,(a0)
		move.b	#$44,render_flags(a0)
		move.w	#make_art_tile($79C,0,1),art_tile(a0)
		move.l	#Map_Invincibility,mappings(a0)
		moveq	#0,d0
		move.b	(Current_special_stage_2).w,d0
		add.w	d0,d0
		lea	word_2E398(pc),a1
		move.w	(a1,d0.w),d1
		addi.w	#$A0,d1
		move.w	d1,x_pos(a0)
		move.w	$10(a1,d0.w),y_pos(a0)
		move.w	#2,mainspr_childsprites(a0)
		move.w	#-$2000,$32(a0)
		tst.w	$36(a0)
		beq.s	loc_2ED2A
		move.w	#$1640,x_pos(a0)
		move.w	#$340,y_pos(a0)
		clr.w	$32(a0)

loc_2ED2A:
		move.w	$2E(a0),d0
		jsr	(GetSineCosine).l
		move.w	$32(a0),d2
		tst.w	d1
		smi	d3
		bpl.s	+ ;loc_2ED40
		neg.w	d1

+ ;loc_2ED40:
		mulu.w	d2,d1
		swap	d1
		tst.b	d3
		beq.s	+ ;loc_2ED4A
		neg.w	d1

+ ;loc_2ED4A:
		tst.w	d0
		smi	d3
		bpl.s	+ ;loc_2ED52
		neg.w	d0

+ ;loc_2ED52:
		mulu.w	d2,d0
		swap	d0
		tst.b	d3
		beq.s	+ ;loc_2ED5C
		neg.w	d0

+ ;loc_2ED5C:
		move.w	$30(a0),d2
		addq.w	#1,d2
		cmpi.w	#8,d2
		bls.s	+ ;loc_2ED6A
		moveq	#0,d2

+ ;loc_2ED6A:
		move.w	d2,$30(a0)
		lea	sub2_x_pos(a0),a1
		move.w	x_pos(a0),d3
		add.w	d1,d3
		move.w	d3,(a1)+
		move.w	y_pos(a0),d3
		add.w	d0,d3
		move.w	d3,(a1)+
		move.w	d2,(a1)+
		neg.w	d1
		add.w	x_pos(a0),d1
		move.w	d1,(a1)+
		neg.w	d0
		add.w	y_pos(a0),d0
		move.w	d0,(a1)+
		move.w	d2,(a1)+
		addq.w	#2,$2E(a0)
		tst.w	$36(a0)
		bne.s	++ ;loc_2EDBC
		subi.w	#$100,$32(a0)
		bcs.s	+ ;loc_2EDAE
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2EDAE:
		movea.w	$34(a0),a1
		st	$31(a1)
		clr.b	(_unkFAC0).w
		bra.s	++ ;loc_2EDCA
; ---------------------------------------------------------------------------

+ ;loc_2EDBC:
		addi.w	#$100,$32(a0)
		bcs.s	+ ;loc_2EDCA
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2EDCA:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
Map_GameOver:
		include "General/Sprites/Game Over/Map - Game Over.asm"
Map_TitleCard:
		include "General/Sprites/Title Card/Map - Title Card.asm"
Map_Results:
		include "General/Sprites/Results/Map - Results.asm"

; =============== S U B R O U T I N E =======================================


LoadEnemyArt:
		lea	Offs_LoadEnemyArt(pc),a6
		move.w	#$D00,d0
		cmpi.b	#$16,(Current_zone).w
		beq.s	+ ;loc_2F798
		move.w	#$E00,d0
		cmpi.w	#$1700,(Current_zone_and_act).w
		bne.s	++ ;loc_2F79E

+ ;loc_2F798:
		move.b	(Current_act).w,d0
		bra.s	++ ;loc_2F7A2
; ---------------------------------------------------------------------------

+ ;loc_2F79E:
		move.w	(Current_zone_and_act).w,d0

+ ;loc_2F7A2:
		ror.b	#1,d0
		lsr.w	#6,d0
		adda.w	(a6,d0.w),a6
		move.w	(a6)+,d6
		bmi.s	.return

- ;.loop:
		movea.l	(a6)+,a1
		move.w	(a6)+,d2
		jsr	(Queue_Kos_Module).l
		dbf	d6,- ;.loop

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
		dc.w PLCKosM_MHZ1-Offs_LoadEnemyArt
		dc.w PLCKosM_MHZ2-Offs_LoadEnemyArt
		dc.w PLCKosM_SOZ-Offs_LoadEnemyArt
		dc.w PLCKosM_SOZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LRZ-Offs_LoadEnemyArt
		dc.w PLCKosM_LRZ-Offs_LoadEnemyArt
		dc.w PLCKosM_SSZ-Offs_LoadEnemyArt
		dc.w PLCKosM_SSZ-Offs_LoadEnemyArt
		dc.w PLCKosM_DEZ-Offs_LoadEnemyArt
		dc.w PLCKosM_DEZ-Offs_LoadEnemyArt
		dc.w PLCKosM_DDZ-Offs_LoadEnemyArt
		dc.w PLCKosM_DDZ-Offs_LoadEnemyArt
		dc.w PLCKosM_Pachinko-Offs_LoadEnemyArt
		dc.w PLCKosM_Pachinko-Offs_LoadEnemyArt
		dc.w PLCKosM_Slots-Offs_LoadEnemyArt
		dc.w PLCKosM_Slots-Offs_LoadEnemyArt

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
		plreq $506, ArtKosM_Blaster
		plreq $52E, ArtKosM_Technosqueek
		plreq $500, ArtKosM_FBZButton
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

PLCKosM_MHZ1: plrlistheader
		plreq $545, ArtKosM_Madmole
		plreq $56D, ArtKosM_Mushmeanie
		plreq $538, ArtKosM_Dragonfly
PLCKosM_MHZ1_End

PLCKosM_MHZ2: plrlistheader
		plreq $522, ArtKosM_CluckoidArrow
		plreq $545, ArtKosM_Madmole
		plreq $56D, ArtKosM_Mushmeanie
		plreq $538, ArtKosM_Dragonfly
PLCKosM_MHZ2_End

PLCKosM_SOZ: plrlistheader
		plreq $536, ArtKosM_Skorp
		plreq $557, ArtKosM_Sandworm
		plreq $500, ArtKosM_Rockn
PLCKosM_SOZ_End

PLCKosM_LRZ: plrlistheader
		plreq $512, ArtKosM_FirewormSegments
		plreq $530, ArtKosM_Iwamodoki
		plreq $562, ArtKosM_Toxomister
PLCKosM_LRZ_End

PLCKosM_SSZ: plrlistheader
		plreq $500, ArtKosM_EggRoboBadnik
PLCKosM_SSZ_End

PLCKosM_DEZ: plrlistheader
		plreq $500, ArtKosM_Spikebonker
		plreq $542, ArtKosM_Chainspike
PLCKosM_DEZ_End

PLCKosM_DDZ: plrlistheader
		plreq $500, ArtKosM_EggRoboBadnik
PLCKosM_DDZ_End

PLCKosM_Pachinko: plrlistheader
		plreq $52E, ArtKosM_Teleporter
PLCKosM_Pachinko_End

PLCKosM_Slots: plrlistheader
PLCKosM_Slots_End

; ---------------------------------------------------------------------------
