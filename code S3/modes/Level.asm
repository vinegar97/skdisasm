LevelMusic_Playlist:
		dc.b mus_AIZ1,		mus_AIZ2	; ANGEL ISLAND ZONE
		dc.b mus_HCZ1,		mus_HCZ2	; HYDROCITY ZONE
		dc.b mus_MGZ1,		mus_MGZ2	; MARBLE GARDEN ZONE
		dc.b mus_CNZ1,		mus_CNZ2	; CARNIVAL NIGHT ZONE
		dc.b mus_FBZ1,		mus_FBZ2	; FLYING BATTERY ZONE
		dc.b mus_ICZ1,		mus_ICZ2	; ICECAP ZONE
		dc.b mus_LBZ1,		mus_LBZ2	; LAUNCH BASE ZONE
		dc.b mus_MHZ1,		mus_MHZ2	; MUSHROOM HILL ZONE
		dc.b mus_SOZ1,		mus_SOZ2	; SANDOPOLIS ZONE
		dc.b mus_LRZ1,		mus_LRZ2	; LAVA REEF ZONE
		dc.b mus_SSZ,		mus_DEZ1	; SKY SANCTUARY ZONE
		dc.b mus_DEZ2,		mus_DEZ2	; DEATH EGG ZONE
		dc.b mus_DDZ,		mus_DDZ		; DOOMSDAY ZONE
		dc.b mus_SpecialStage,	mus_SpecialStage; AIZ INTRO & ENDING
		dc.b mus_ALZ,		mus_ALZ		; AZURE LAKE ZONE
		dc.b mus_BPZ,		mus_BPZ		; BALLOON PARK ZONE
		dc.b mus_DPZ,		mus_DPZ		; DESERT PALACE ZONE
		dc.b mus_CGZ,		mus_CGZ		; CHROME GADGET ZONE
		dc.b mus_EMZ,		mus_EMZ		; ENDLESS MINE ZONE
		dc.b mus_Gumball,	mus_Gumball	; GUMBALL
		dc.b mus_Slots,		mus_Slots	; PACHINKO
		dc.b mus_Gumball,	mus_Gumball	; SLOTS
		dc.b mus_SpecialStage,	mus_SpecialStage; LAVA REEF ZONE BOSS & HIDDEN PALACE ZONE
		dc.b mus_SpecialStage,	mus_SpecialStage; FINAL BOSS & SPECIAL STAGE HUB
		even
; ---------------------------------------------------------------------------

Level:
		bset	#7,(Game_mode).w		; Set bit 7 of F600 is indicate that we're loading the level
		tst.w	(Demo_mode_flag).w
		bmi.s	loc_46C2
		moveq	#signextendB(mus_FadeOut),d0		; If a demo
		bsr.w	Play_SFX

loc_46C2:
		clr.w	(Kos_decomp_queue_count).w
		clearRAM	Kos_decomp_stored_registers,$6C	; Clear the KosM bytes
		bsr.w	Clear_Nem_Queue				; Clear PLCs
		bsr.w	Pal_FadeToBlack
		tst.w	(Demo_mode_flag).w
		bmi.w	loc_479A			; Skip ahead if negative (?)
		move	#$2700,sr
		bsr.w	Clear_DisplayData		; Clear the screen
		move	#$2300,sr
		moveq	#0,d0
		move.w	d0,(Level_frame_counter).w
		tst.b	(Last_star_post_hit).w
		beq.s	loc_471E				; If no lampost was set, branch
		tst.b	(Special_bonus_entry_flag).w
		bne.s	loc_4712				; Otherwise, ensure that the proper level ID is set to account for levels that use multiple ones in an act
		move.w	(Saved_zone_and_act).w,(Current_zone_and_act).w
		move.w	(Saved_apparent_zone_and_act).w,(Apparent_zone_and_act).w
		bra.s	loc_471E
; ---------------------------------------------------------------------------

loc_4712:
		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
		move.w	(Saved2_apparent_zone_and_act).w,(Apparent_zone_and_act).w

loc_471E:
		move.w	(Current_zone_and_act).w,d0

		; Useless code. Player_mode has not been set yet, and level $D00 has the same PLCs as level 0
		bne.s	loc_4736
		cmpi.w	#2,(Player_mode).w		; If level is Angel Island 1
		beq.s	loc_4732
		tst.b	(Last_star_post_hit).w			; If character is Sonic
		beq.s	loc_4736				; And no lamppost is set

loc_4732:
		move.w	#$D00,d0				; Set the level ID to skip the intro

loc_4736:
		ror.b	#1,d0
		lsr.w	#4,d0
		andi.w	#$1F8,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d0,d1
		lea	(LevelLoadBlock).l,a2
		moveq	#0,d0
		move.b	(a2,d1.w),d0			; Get the first PLC number for the level
		beq.s	loc_4756
		bsr.w	Load_PLC

loc_4756:
		bsr.w	LevelLoad_ActiveCharacter
		tst.b	(Last_star_post_hit).w
		bne.w	loc_4782
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	loc_4782
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_4782
		moveq	#1,d0					; If in AIZ intro
		jsr	(Load_PLC_2).l
		moveq	#$A,d0
		bsr.w	Load_PLC					; Load the AIZ Intro graphics
		bra.s	loc_479A
; ---------------------------------------------------------------------------

loc_4782:
		moveq	#6,d0
		tst.w	(Competition_mode).w
		bne.s	loc_4796
		moveq	#1,d0
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_4796
		moveq	#7,d0

loc_4796:
		bsr.w	Load_PLC

loc_479A:
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clearRAM	Lag_frame_count,$58
		clearRAM	Tails_CPU_interact,$100
		clearRAM	Oscillating_table,(AIZ_vine_angle-Oscillating_table)
		clearRAM	_unkFA80,$80
		jsr	(Init_SpriteTable).l
		lea	(VDP_control_port).l,a6
		move.w	#$8B03,(a6)			; Command $8B03 - Vscroll full, HScroll line-based
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
		move.w	#$857C,(a6)
		move.w	#$9001,(a6)
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$9200,(a6)			; Command $9200 - Window V position at default
		move.w	#$8720,(a6)
		move.w	#$8C81,(a6)			; Command $8C81 - 40cell screen size, no interlacing, no s/h
		tst.b	(Debug_cheat_flag).w
		beq.s	loc_484A
		btst	#button_C,(Ctrl_1_held).w
		beq.s	loc_483C
		move.w	#$8C89,(a6)

loc_483C:
		btst	#button_A,(Ctrl_1_held).w
		beq.s	loc_484A
		move.b	#1,(Debug_mode_flag).w

loc_484A:
		move.w	#$8AFF,(H_int_counter_command).w
		tst.w	(Competition_mode).w
		beq.s	loc_4886
		move.w	#$4EF9,(H_int_jump).w
		move.l	#HInt,(H_int_addr).w
		move.w	#$8014,(a6)
		move.w	#$8220,(a6)
		move.w	#$8405,(a6)
		move.w	#$8A6B,(H_int_counter_command).w
		move.w	#$9003,(a6)
		cmpi.b	#$F,(Current_zone).w
		bne.s	loc_4886
		move.w	#$9011,(a6)			; 128-cell hScroll table size: 64x64

loc_4886:
		move.w	(H_int_counter_command).w,(a6)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		moveq	#3,d0
		bsr.w	LoadPalette_Immediate
		bsr.w	CheckLevelForWater
		clearRAM	Water_palette_line_2,$60
		tst.b	(Water_flag).w
		beq.s	loc_48BA
		move.w	#$8014,(a6)

loc_48BA:
		tst.w	(Demo_mode_flag).w
		bmi.w	loc_4942
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#7,d0
		lea	(LevelMusic_Playlist).l,a1
		move.b	(a1,d0.w),d0
		move.w	d0,(Current_music).w
		bsr.w	Play_Music
		tst.w	(Current_zone_and_act).w
		bne.s	loc_48F2
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_48F2
		tst.b	(Last_star_post_hit).w
		beq.s	loc_4934

loc_48F2:
		cmpi.b	#$15,(Current_zone).w
		bhi.s	loc_4934
		move.l	#Obj_TitleCard,(Dynamic_object_RAM+(object_size*5)).w

loc_4902:
		move.b	#$C,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		tst.w	(Dynamic_object_RAM+(object_size*5)+objoff_48).w
		bne.s	loc_4902
		tst.l	(Nem_decomp_queue).w
		bne.s	loc_4902

loc_4934:
		move	#$2700,sr
		jsr	(HUD_DrawInitial).l
		move	#$2300,sr

loc_4942:
		moveq	#3,d0
		bsr.w	LoadPalette
		jsr	(Get_LevelSizeStart).l
		jsr	(DeformBgLayer).l
		bsr.w	LoadLevelLoadBlock
		jsr	(LoadLevelLoadBlock2).l
		move	#$2700,sr
		jsr	(j_LevelSetup).l
		move	#$2300,sr
		jsr	(Animate_Init).l
		jsr	(ConvertCollisionArray).l
		bsr.w	LoadSolids
		bsr.w	Handle_Onscreen_Water_Height
		move.w	(Ctrl_2).w,(_unkFF7C).w
		move.w	#0,(Ctrl_1_logical).w
		move.w	#0,(Ctrl_2_logical).w
		move.w	#0,(Ctrl_1).w
		move.w	#0,(Ctrl_2).w
		move.b	#1,(Ctrl_1_locked).w
		move.b	#1,(Ctrl_2_locked).w
		move.b	#0,(Level_started_flag).w
		tst.b	(Water_flag).w
		beq.s	loc_49DC
		cmpi.b	#1,(Current_zone).w
		beq.s	loc_49C6
		cmpi.b	#1,(Current_zone).w
		bne.s	loc_49DC

loc_49C6:
		move.l	#Obj_HCZWaveSplash,(Wave_Splash).w
		move.l	#Obj_HCZWaterSplash,(Dynamic_object_RAM+(object_size*2)).w
		move.b	#1,(Dynamic_object_RAM+(object_size*2)+subtype).w

loc_49DC:
		moveq	#0,d0
		tst.b	(Last_star_post_hit).w
		bne.s	loc_4A0C
		move.w	d0,(Ring_count).w
		move.l	d0,(Timer).w
		move.b	d0,(Extra_life_flags).w
		move.w	d0,(Ring_count_P2).w
		move.l	d0,(Timer_P2).w
		move.b	d0,(Saved2_status_secondary).w
		move.b	d0,(Saved_status_secondary).w
		cmpi.b	#$13,(Current_zone).w
		bhs.s	loc_4A0C
		move.b	d0,(Respawn_table_keep).w

loc_4A0C:
		move.b	d0,(Time_over_flag).w
		move.w	d0,(Debug_placement_mode).w
		move.w	d0,(Restart_level_flag).w
		move.b	d0,(Teleport_active_timer).w
		move.b	d0,(Teleport_active_flag).w
		move.w	d0,(Total_ring_count).w
		move.w	d0,(Total_ring_count_P2).w
		move.w	d0,(Monitors_broken).w
		move.w	d0,(Monitors_broken_P2).w
		move.w	d0,(Loser_time_left).w
		move.b	d0,(LRZ_rocks_routine).w
		bsr.w	OscillateNumInit
		move.b	#1,(Update_HUD_score).w
		move.b	#1,(Update_HUD_ring_count).w
		move.b	#1,(Update_HUD_timer).w
		move.b	#1,(Level_started_flag).w
		bsr.w	SpawnLevelMainSprites
		jsr	(Load_Sprites).l
		jsr	(Load_Rings).l
		jsr	(S2_SpecialCNZBumpers).l
		jsr	(Draw_LRZ_Special_Rock_Sprites).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		jsr	(Animate_Tiles).l
		move.w	#1800,(Demo_timer).w
		tst.w	(Demo_mode_flag).w
		bpl.s	loc_4AA2
		move.w	#540,(Demo_timer).w
		cmpi.w	#4,(Ending_demo_number).w
		bne.s	loc_4AA2
		move.w	#510,(Demo_timer).w

loc_4AA2:
		bsr.w	LoadWaterPalette
		clearRAM	Water_palette_line_2,$60
		move.b	#0,(Ctrl_1_locked).w
		move.b	#0,(Ctrl_2_locked).w
		jsr	GetDemoPtr(pc)
		tst.w	(Competition_mode).w
		bne.w	loc_4C1C
		tst.w	(Current_zone_and_act).w
		bne.s	loc_4ADA
		tst.b	(Last_star_post_hit).w
		beq.s	loc_4AE8

loc_4ADA:
		cmpi.b	#$E,(Current_zone).w
		bhs.s	loc_4AE8
		jsr	(PLCLoad_AnimalsAndExplosion).l

loc_4AE8:
		move.w	#$2030-1,(Palette_fade_info).w
		jsr	(Pal_FillBlack).l
		move.w	#$16,(Palette_fade_timer).w
		move.w	#$16,(Dynamic_object_RAM+(object_size*5)+objoff_2E).w
		andi.b	#$7F,(Last_star_post_hit).w
		bclr	#7,(Game_mode).w

LevelLoop:
		bsr.w	Pause_Game
		move.b	#8,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		addq.w	#1,(Level_frame_counter).w
		bsr.w	Demo_PlayRecord
		jsr	(Animate_Palette).l
		jsr	(SpecialEvents).l
		jsr	(Process_Sprites).l
		tst.w	(Restart_level_flag).w
		bne.w	Level
		jsr	(DeformBgLayer).l
		jsr	(ScreenEvents).l
		bsr.w	Handle_Onscreen_Water_Height
		bsr.w	UpdateWaterSurface
		jsr	(Load_Rings).l
		jsr	(Animate_Tiles).l
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		bsr.w	OscillateNumDo
		bsr.w	ChangeRingFrame
		jsr	(Render_Sprites).l
		jsr	(Load_Sprites).l
		cmpi.b	#8,(Game_mode).w
		beq.s	DemoMode
		cmpi.b	#$C,(Game_mode).w
		beq.w	LevelLoop
		rts
; ---------------------------------------------------------------------------

DemoMode:
		tst.w	(Restart_level_flag).w
		bne.s	loc_4BB2
		tst.w	(Demo_timer).w
		beq.s	loc_4BB2
		cmpi.b	#8,(Game_mode).w
		beq.w	LevelLoop
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_4BB2:
		cmpi.b	#8,(Game_mode).w
		bne.s	loc_4BC2
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_4BC2:
		move.w	#60,(Demo_timer).w
		move.w	#$40-1,(Palette_fade_info).w
		clr.w	(Pal_fade_delay).w

loc_4BD2:
		move.b	#8,(V_int_routine).w
		bsr.w	Wait_VSync
		bsr.w	Demo_PlayRecord
		jsr	(Process_Sprites).l
		jsr	(DeformBgLayer).l
		jsr	(ScreenEvents).l
		jsr	(Render_Sprites).l
		jsr	(Load_Sprites).l
		jsr	(Process_Kos_Module_Queue).l
		subq.w	#1,(Pal_fade_delay).w
		bpl.s	loc_4C14
		move.w	#2,(Pal_fade_delay).w
		bsr.w	Pal_ToBlack

loc_4C14:
		tst.w	(Demo_timer).w
		bne.s	loc_4BD2
		rts
; ---------------------------------------------------------------------------

loc_4C1C:
		move.w	#0,(_unkFF7E).w
		tst.b	(Debug_cheat_flag).w
		beq.s	loc_4C3C
		move.b	(_unkFF7C).w,d0
		cmpi.b	#$A0,d0
		bne.s	loc_4C3C
		move.w	(Sound_test_sound).w,d0
		lsl.w	#8,d0
		move.w	d0,(_unkFF7E).w

loc_4C3C:
		move.w	#$40-1,(Palette_fade_info).w
		jsr	(Pal_FillBlack).l
		move.w	#$16,(Palette_fade_timer).w
		move.w	#0,(_unkFF7C).w
		bclr	#7,(Game_mode).w

loc_4C5A:
		bsr.w	Pause_Game
		move.b	#8,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		addq.w	#1,(Level_frame_counter).w
		move.w	#4,-(sp)
		bra.s	loc_4CBC
; ---------------------------------------------------------------------------

loc_4C78:
		move.w	(_unkFF7E).w,d0
		add.w	d0,(_unkFF7C).w
		bcc.s	loc_4CCC
		bsr.w	Pause_Game
		move.w	#$100,(Z80_bus_request).l	; stop the Z80
		bsr.w	Poll_Controllers
		startZ80
		move.w	#0,(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		lea	(Sprite_table_input).w,a5

loc_4CAC:
		move.w	#0,(a5)
		lea	$80(a5),a5
		cmpa.l	#Player_1,a5
		blo.s	loc_4CAC

loc_4CBC:
		bsr.w	Demo_PlayRecord
		jsr	(Process_Sprites).l
		jsr	(DeformBgLayer).l

loc_4CCC:
		subq.w	#1,(sp)
		bne.s	loc_4C78
		addq.w	#2,sp
		tst.w	(Restart_level_flag).w
		bne.w	Level
		jsr	(ScreenEvents).l
		jsr	(Animate_Tiles).l
		jsr	(Render_Sprites).l
		jsr	(Animate_Palette).l
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		cmpi.b	#8,(Game_mode).w
		beq.s	loc_4D10
		cmpi.b	#$C,(Game_mode).w
		beq.w	loc_4C5A
		rts
; ---------------------------------------------------------------------------

loc_4D10:
		tst.w	(Restart_level_flag).w
		bne.s	loc_4D2E
		tst.w	(Demo_timer).w
		beq.s	loc_4D2E
		cmpi.b	#8,(Game_mode).w
		beq.w	loc_4C5A
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_4D2E:
		cmpi.b	#8,(Game_mode).w
		bne.s	loc_4D3E
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_4D3E:
		move.w	#60,(Demo_timer).w
		move.w	#$40-1,(Palette_fade_info).w
		clr.w	(Pal_fade_delay).w

loc_4D4E:
		move.b	#8,(V_int_routine).w
		bsr.w	Wait_VSync
		bsr.w	Demo_PlayRecord
		jsr	(Process_Sprites).l
		jsr	(DeformBgLayer).l
		jsr	(ScreenEvents).l
		jsr	(Render_Sprites).l
		jsr	(Load_Sprites).l
		jsr	(Process_Kos_Module_Queue).l
		subq.w	#1,(Pal_fade_delay).w
		bpl.s	loc_4D90
		move.w	#2,(Pal_fade_delay).w
		bsr.w	Pal_ToBlack

loc_4D90:
		tst.w	(Demo_timer).w
		bne.s	loc_4D4E
		rts

; =============== S U B R O U T I N E =======================================


LevelLoad_ActiveCharacter:
		cmpi.b	#$88,(Game_mode).w
		beq.s	loc_4DAE
		tst.w	(Competition_mode).w
		bne.s	loc_4DAE
		move.w	(Player_option).w,(Player_mode).w		; Move selected character to active character
		rts
; ---------------------------------------------------------------------------

loc_4DAE:
		move.w	#0,(Player_mode).w
		rts
; End of function LevelLoad_ActiveCharacter


; =============== S U B R O U T I N E =======================================


SpawnLevelMainSprites:
		move.l	#Obj_ResetCollisionResponseList,(Reserved_object_3).w
		bsr.w	SpawnLevelMainSprites_SpawnPlayers
		bsr.w	SpawnLevelMainSprites_SpawnPowerup
		tst.b	(Last_star_post_hit).w
		bne.w	locret_4EC6
		tst.b	(Special_bonus_entry_flag).w
		bne.w	locret_4EC6
		lea	(Player_1).w,a1
		lea	(Player_2).w,a2
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	loc_4DFE
		cmpi.w	#2,(Player_mode).w
		beq.s	locret_4DFC
		move.l	#Obj_AIZPlaneIntro,(Dynamic_object_RAM+(object_size*2)).w
		clr.b	(Level_started_flag).w
		rts
; ---------------------------------------------------------------------------

locret_4DFC:
		rts
; ---------------------------------------------------------------------------

loc_4DFE:
		cmpi.w	#$100,(Current_zone_and_act).w
		bne.s	loc_4E36
		move.b	#$1B,anim(a1)
		bset	#Status_InAir,status(a1)
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_4E20
		move.b	#1,jumping(a1)

loc_4E20:
		tst.l	(a2)
		beq.s	loc_4E36
		move.b	#$1B,anim(a2)
		bset	#Status_InAir,status(a2)
		move.b	#1,jumping(a2)

loc_4E36:
		cmpi.w	#$200,(Current_zone_and_act).w
		bne.s	loc_4E5A
		move.b	#$1B,anim(a1)
		bset	#Status_InAir,status(a1)
		tst.l	(a2)
		beq.s	loc_4E5A
		move.b	#$1B,anim(a2)
		bset	#Status_InAir,status(a2)

loc_4E5A:
		cmpi.w	#$300,(Current_zone_and_act).w
		bne.s	loc_4E94
		cmpi.w	#1,(Player_mode).w
		bne.s	loc_4E86
		move.l	#Obj_Tails,(Player_2).w
		move.w	(Player_1+x_pos).w,(Player_2+x_pos).w
		move.w	(Player_1+y_pos).w,(Player_2+y_pos).w
		move.w	#0,(Tails_CPU_routine).w
		bra.s	loc_4E94
; ---------------------------------------------------------------------------

loc_4E86:
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_4E94
		move.w	#$20,(Tails_CPU_routine).w

loc_4E94:
		cmpi.w	#$500,(Current_zone_and_act).w
		bne.s	loc_4EB6
		cmpi.w	#2,(Player_mode).w
		blo.s	loc_4EAE
		move.l	#Obj_LevelIntroICZ1Tails,(Dynamic_object_RAM+(object_size*2)).w
		bra.s	loc_4EB6
; ---------------------------------------------------------------------------

loc_4EAE:
		move.l	#Obj_LevelIntroICZ1,(Dynamic_object_RAM+(object_size*2)).w

loc_4EB6:
		cmpi.w	#$600,(Current_zone_and_act).w
		bne.s	locret_4EC6
		move.l	#Obj_LevelIntro_PlayerLaunchFromGround,(Dynamic_object_RAM+(object_size*2)).w

locret_4EC6:
		rts
; End of function SpawnLevelMainSprites


; =============== S U B R O U T I N E =======================================


SpawnLevelMainSprites_SpawnPowerup:
		cmpi.b	#$E,(Current_zone).w
		bhs.s	locret_4EF0
		lea	(Player_1).w,a1
		move.b	(Saved_status_secondary).w,d0
		clr.b	(Saved_status_secondary).w
		andi.b	#(1<<Status_FireShield)|(1<<Status_LtngShield)|(1<<Status_BublShield),d0
		bne.s	loc_4EF2
		move.b	(Saved2_status_secondary).w,d0
		clr.b	(Saved2_status_secondary).w
		andi.b	#(1<<Status_FireShield)|(1<<Status_LtngShield)|(1<<Status_BublShield),d0
		bne.s	loc_4EF2

locret_4EF0:
		rts
; ---------------------------------------------------------------------------

loc_4EF2:
		btst	#Status_FireShield,d0
		beq.s	loc_4F18
		andi.b	#$8E,status_secondary(a1)
		bset	#Status_Shield,status_secondary(a1)
		bset	#Status_FireShield,status_secondary(a1)
		move.l	#Obj_FireShield,(Shield).w
		move.w	a1,(Shield+parent).w
		rts
; ---------------------------------------------------------------------------

loc_4F18:
		btst	#Status_LtngShield,d0
		beq.s	loc_4F3E
		andi.b	#$8E,status_secondary(a1)
		bset	#Status_Shield,status_secondary(a1)
		bset	#Status_LtngShield,status_secondary(a1)
		move.l	#Obj_LightningShield,(Shield).w
		move.w	a1,(Shield+parent).w
		rts
; ---------------------------------------------------------------------------

loc_4F3E:
		btst	#Status_BublShield,d0
		beq.s	locret_4F64
		andi.b	#$8E,status_secondary(a1)
		bset	#Status_Shield,status_secondary(a1)
		bset	#Status_BublShield,status_secondary(a1)
		move.l	#Obj_BubbleShield,(Shield).w
		move.w	a1,(Shield+parent).w
		rts
; ---------------------------------------------------------------------------

locret_4F64:
		rts
; End of function SpawnLevelMainSprites_SpawnPowerup


; =============== S U B R O U T I N E =======================================


SpawnLevelMainSprites_SpawnPlayers:
		tst.w	(Competition_mode).w
		bne.w	loc_501A
		move.w	(Player_mode).w,d0
		bne.s	loc_4FC2
		move.l	#Obj_Sonic,(Player_1).w
		move.l	#Obj_DashDust,(Dust).w
		move.l	#Obj_InstaShield,(Shield).w
		move.w	#Player_1,(Shield+parent).w
		move.l	#Obj_Tails,(Player_2).w
		move.w	(Player_1+x_pos).w,(Player_2+x_pos).w
		move.w	(Player_1+y_pos).w,(Player_2+y_pos).w
		subi.w	#$20,(Player_2+x_pos).w
		addi.w	#4,(Player_2+y_pos).w
		move.l	#Obj_DashDust,(Dust_P2).w
		move.w	#0,(Tails_CPU_routine).w
		rts
; ---------------------------------------------------------------------------

loc_4FC2:
		subq.w	#1,d0
		bne.s	loc_4FE6
		move.l	#Obj_Sonic,(Player_1).w
		move.l	#Obj_DashDust,(Dust).w
		move.l	#Obj_InstaShield,(Shield).w
		move.w	#Player_1,(Shield+parent).w
		rts
; ---------------------------------------------------------------------------

loc_4FE6:
		subq.w	#1,d0
		bne.s	loc_5008
		move.l	#Obj_Tails,(Player_1).w
		move.l	#Obj_DashDust,(Dust_P2).w
		addi.w	#4,(Player_1+y_pos).w
		move.w	#0,(Tails_CPU_routine).w
		rts
; ---------------------------------------------------------------------------

loc_5008:
		move.l	#Obj_Sonic,(Player_1).w
		move.l	#Obj_DashDust,(Dust).w
		rts
; ---------------------------------------------------------------------------

loc_501A:
		move.b	(P1_character).w,d0
		bsr.s	sub_505E
		move.l	d1,(Player_1).w
		move.b	(P1_character).w,(Player_1+character_id).w
		move.w	(Player_1+x_pos).w,(Player_2+x_pos).w
		move.w	(Player_1+y_pos).w,(Player_2+y_pos).w
		move.l	#Obj_DashDust2P,(Dust).w
		tst.b	(Not_ghost_flag).w
		beq.s	loc_505C
		move.b	(P2_character).w,d0
		bsr.s	sub_505E
		move.l	d1,(Player_2).w
		move.b	(P2_character).w,(Player_2+character_id).w
		move.l	#Obj_DashDust2P,(Dust_P2).w

loc_505C:
		bra.s	loc_507C
; End of function SpawnLevelMainSprites_SpawnPlayers


; =============== S U B R O U T I N E =======================================


sub_505E:
		tst.b	d0
		bne.s	loc_5068
		move.l	#Obj_Sonic2P,d1

loc_5068:
		subq.b	#1,d0
		bne.s	loc_5074
		move.l	#Obj_Tails2P,d1
		rts
; ---------------------------------------------------------------------------

loc_5074:
		move.l	#Obj_Sonic2P,d1
		rts
; End of function sub_505E

; ---------------------------------------------------------------------------

loc_507C:
		lea	(Target_palette_line_2).w,a2
		lea	(Pal_Level_2P).l,a1
		move.w	#bytesToWcnt($20),d0

loc_508A:
		move.w	(a1)+,(a2)+
		dbf	d0,loc_508A
		rts
; ---------------------------------------------------------------------------
Pal_Level_2P:
		binclude "Levels/Misc/Palettes/2P Level Secondary.bin"
		even
; ---------------------------------------------------------------------------

Obj_ResetCollisionResponseList:
		move.w	#0,(Collision_response_list).w
		rts

; =============== S U B R O U T I N E =======================================


UpdateWaterSurface:
		rts
; ---------------------------------------------------------------------------
		tst.b	(Water_flag).w
		beq.s	locret_50DC
		move.w	(Camera_X_pos).w,d1
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc_50D2
		addi.w	#$20,d1

loc_50D2:
		move.w	d1,d0
		addi.w	#$60,d0
		addi.w	#$120,d1

locret_50DC:
		rts
; End of function UpdateWaterSurface


; =============== S U B R O U T I N E =======================================


Handle_Onscreen_Water_Height:
		tst.b	(Water_flag).w
		beq.w	loc_5146
		tst.b	(Deform_lock).w
		bne.s	loc_50FC
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	loc_50FC
		bsr.w	sub_539A
		bsr.w	DynamicWaterHeight

loc_50FC:
		clr.b	(Water_full_screen_flag).w
		moveq	#0,d0
		add.w	(Mean_water_level).w,d0
		move.w	d0,(Water_level).w
		cmpi.w	#$100,(Current_zone_and_act).w
		bne.s	loc_511A
		cmpi.w	#$900,(Camera_X_pos).w
		blo.s	loc_5130

loc_511A:
		move.w	(Water_level).w,d0
		sub.w	(Camera_Y_pos).w,d0
		beq.s	loc_512A
		bcc.s	loc_5138
		tst.w	d0
		bpl.s	loc_5138

loc_512A:
		move.b	#1,(Water_full_screen_flag).w

loc_5130:
		move.b	#-1,(H_int_counter).w
		rts
; ---------------------------------------------------------------------------

loc_5138:
		cmpi.w	#$DF,d0
		blo.s	loc_5142
		move.w	#$FF,d0

loc_5142:
		move.b	d0,(H_int_counter).w

loc_5146:
		bsr.w	sub_5598
		rts
; End of function Handle_Onscreen_Water_Height

; ---------------------------------------------------------------------------
		clr.b	(Water_full_screen_flag).w
		move.w	(Mean_water_level).w,(Water_level).w
		move.l	#HInt3,(H_int_addr).w
		cmpi.w	#$1000,(V_blank_cycles).w
		blo.s	loc_516E
		move.l	#HInt4,(H_int_addr).w

loc_516E:
		move.w	(Water_level).w,d0
		sub.w	(Camera_Y_pos).w,d0
		beq.s	loc_5186
		bcc.s	loc_51C2
		tst.w	d0
		bpl.s	loc_51C2
		addi.w	#$1E0,d0
		beq.s	loc_5186
		bcs.s	loc_5194

loc_5186:
		move.b	#1,(Water_full_screen_flag).w
		move.b	#-1,(H_int_counter).w
		rts
; ---------------------------------------------------------------------------

loc_5194:
		cmpi.w	#$DF,d0
		blo.s	loc_519E
		move.w	#$FF,d0

loc_519E:
		move.b	d0,(H_int_counter).w
		move.b	#1,(Water_full_screen_flag).w
		move.l	#HInt5,(H_int_addr).w
		cmpi.w	#$1000,(V_blank_cycles).w
		blo.s	loc_51C0
		move.l	#HInt_6,(H_int_addr).w

loc_51C0:
		bra.s	loc_51D0
; ---------------------------------------------------------------------------

loc_51C2:
		cmpi.w	#$DF,d0
		blo.s	loc_51CC
		move.w	#$FF,d0

loc_51CC:
		move.b	d0,(H_int_counter).w

loc_51D0:
		bsr.w	sub_5598
		rts
; ---------------------------------------------------------------------------
StartingWaterHeights:
		binclude "Levels/Misc/StartingWaterHeights.bin"
		even

; =============== S U B R O U T I N E =======================================


DynamicWaterHeight:
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#6,d0
		andi.w	#$FFFE,d0
		move.w	.Index(pc,d0.w),d0
		jsr	.Index(pc,d0.w)
		moveq	#0,d1
		move.b	(Water_speed).w,d1
		move.w	(Target_water_level).w,d0
		sub.w	(Mean_water_level).w,d0
		beq.s	.locret_5244
		bcc.s	loc_5240
		neg.w	d1

loc_5240:
		add.w	d1,(Mean_water_level).w

.locret_5244:
		rts
; End of function DynamicWaterHeight

; ---------------------------------------------------------------------------
.Index:
		dc.w DynamicWaterHeight_AIZ1-.Index
		dc.w DynamicWaterHeight_AIZ2-.Index
		dc.w DynamicWaterHeight_HCZ1-.Index
		dc.w DynamicWaterHeight_HCZ2-.Index
		dc.w DynamicWaterHeight_Null-.Index
		dc.w DynamicWaterHeight_Null-.Index
		dc.w DynamicWaterHeight_Null-.Index
		dc.w DynamicWaterHeight_Null-.Index
		dc.w DynamicWaterHeight_Null-.Index
		dc.w DynamicWaterHeight_Null-.Index
		dc.w DynamicWaterHeight_Null-.Index
		dc.w DynamicWaterHeight_Null-.Index
		dc.w DynamicWaterHeight_LBZ1-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Ending-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
		dc.w DynamicWaterHeight_Null2-.Index
; ---------------------------------------------------------------------------

DynamicWaterHeight_AIZ1:
		rts
; ---------------------------------------------------------------------------

DynamicWaterHeight_AIZ2:
		cmpi.w	#$820,(Camera_target_max_Y_pos).w
		beq.s	locret_5306
		cmpi.w	#$2440,(Camera_X_pos).w
		bhs.s	loc_52AE
		cmpi.w	#$618,(Target_water_level).w
		bne.s	locret_5306
		move.w	#$528,(Target_water_level).w
		move.b	#2,(Water_speed).w
		rts
; ---------------------------------------------------------------------------

loc_52AE:
		tst.b	(Level_trigger_array).w
		bne.s	loc_52C2
		cmpi.w	#$2850,(Camera_X_pos).w
		blo.s	locret_5306
		move.b	#1,(Level_trigger_array).w

loc_52C2:
		cmpi.w	#$618,(Target_water_level).w
		beq.s	locret_5306
		cmpi.w	#$2900,(Camera_X_pos).w
		bhs.s	loc_52EC
		move.w	#-1,(Screen_shake_flag).w
		jsr	(AllocateObject).l
		bne.s	loc_52EC
		move.l	#Obj_5308,(a1)
		move.b	#180,anim_frame_timer(a1)

loc_52EC:
		lea	(Level_layout_main+$1C).w,a3
		moveq	#4-1,d1

loc_52F2:
		movea.w	(a3),a1
		move.b	#0,$4E(a1)
		addq.w	#4,a3
		dbf	d1,loc_52F2
		move.w	#$618,(Target_water_level).w

locret_5306:
		rts
; ---------------------------------------------------------------------------

Obj_5308:
		subq.b	#1,anim_frame_timer(a0)
		beq.s	loc_5310
		rts
; ---------------------------------------------------------------------------

loc_5310:
		move.w	#0,(Screen_shake_flag).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

DynamicWaterHeight_HCZ1:
		lea	(word_5324).l,a1
		bra.s	loc_537C
; ---------------------------------------------------------------------------
word_5324:
		dc.w  $8500,  $900
		dc.w  $8680, $2A00
		dc.w  $8680, $3500
		dc.w  $86A0, $FFFF
; ---------------------------------------------------------------------------

DynamicWaterHeight_HCZ2:
		tst.b	(_unkFAA2).w
		beq.s	loc_533C
		rts
; ---------------------------------------------------------------------------

loc_533C:
		lea	(word_5344).l,a1
		bra.s	loc_537C
; ---------------------------------------------------------------------------
word_5344:
		dc.w   $700, $3E00
		dc.w   $7E0, $FFFF
; ---------------------------------------------------------------------------

DynamicWaterHeight_Null:
		rts
; ---------------------------------------------------------------------------

DynamicWaterHeight_LBZ1:
		lea	(word_5356).l,a1
		bra.s	loc_537C
; ---------------------------------------------------------------------------
word_5356:
		dc.w  $8B00,  $E00
		dc.w  $8A00, $1980
		dc.w  $8A00, $2340
		dc.w  $8AC8, $2C00
		dc.w  $8FF0, $FFFF
; ---------------------------------------------------------------------------

DynamicWaterHeight_Null2:
		rts
; ---------------------------------------------------------------------------

DynamicWaterHeight_Ending:
		cmpi.w	#$1DE0,(Camera_X_pos).w
		blo.s	locret_537A
		move.w	#$510,(Target_water_level).w

locret_537A:
		rts
; ---------------------------------------------------------------------------

loc_537C:
		move.w	(Camera_X_pos).w,d0

loc_5380:
		move.l	(a1)+,d1
		cmp.w	d1,d0
		bhi.s	loc_5380
		swap	d1
		tst.w	d1
		bpl.s	loc_5394
		andi.w	#$7FFF,d1
		move.w	d1,(Mean_water_level).w

loc_5394:
		move.w	d1,(Target_water_level).w
		rts

; =============== S U B R O U T I N E =======================================


sub_539A:
		tst.w	(Debug_placement_mode).w
		bne.w	locret_54A4
		cmpi.b	#1,(Current_zone).w
		bne.w	locret_54A4
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_53D2
		lea	(WindTunnel_flag).w,a3
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_held_logical).w,d6
		moveq	#0,d5
		bsr.s	HCZ_WaterTunnels
		addq.w	#1,a3
		lea	(Player_2).w,a1
		move.b	(Ctrl_2_held_logical).w,d6
		moveq	#1,d5
		bra.s	HCZ_WaterTunnels
; ---------------------------------------------------------------------------

loc_53D2:
		lea	(WindTunnel_flag_P2).w,a3
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_held_logical).w,d6
		moveq	#0,d5
; End of function sub_539A


; =============== S U B R O U T I N E =======================================


HCZ_WaterTunnels:
		lea	(HCZ1_WaterTunLocs).l,a2
		tst.b	(Current_act).w
		beq.s	loc_53F2
		lea	(HCZ2_WaterTunLocs).l,a2

loc_53F2:
		move.w	(a2)+,d2

loc_53F4:
		move.w	x_pos(a1),d0
		cmp.w	(a2),d0
		blo.w	loc_5490
		cmp.w	4(a2),d0
		bhs.w	loc_5490
		move.w	y_pos(a1),d1
		cmp.w	2(a2),d1
		blo.w	loc_5490
		cmp.w	6(a2),d1
		bhs.s	loc_5490
		cmpi.b	#4,routine(a1)
		bhs.w	loc_54A2
		btst	d5,(_unkF7C7).w
		bne.s	locret_5478
		tst.b	object_control(a1)
		bne.s	loc_54A2
		move.b	#1,(a3)
		move.w	8(a2),d0
		move.w	d0,x_vel(a1)
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,x_pos(a1)
		move.w	$A(a2),d1
		move.w	d1,y_vel(a1)
		ext.l	d1
		lsl.l	#8,d1
		add.l	d1,y_pos(a1)
		move.b	#$F,anim(a1)
		bset	#1,status(a1)
		tst.b	$C(a2)
		bne.s	loc_547A
		btst	#button_up,d6
		beq.s	loc_546E
		subq.w	#1,y_pos(a1)

loc_546E:
		btst	#button_down,d6
		beq.s	locret_5478
		addq.w	#1,y_pos(a1)

locret_5478:
		rts
; ---------------------------------------------------------------------------

loc_547A:
		btst	#button_left,d6
		beq.s	loc_5484
		subq.w	#1,x_pos(a1)

loc_5484:
		btst	#button_right,d6
		beq.s	locret_548E
		addq.w	#1,x_pos(a1)

locret_548E:
		rts
; ---------------------------------------------------------------------------

loc_5490:
		adda.w	#$E,a2
		dbf	d2,loc_53F4
		tst.b	(a3)
		beq.s	locret_54A4
		move.b	#$1A,anim(a1)

loc_54A2:
		clr.b	(a3)

locret_54A4:
		rts
; End of function HCZ_WaterTunnels

; ---------------------------------------------------------------------------
HCZ1_WaterTunLocs:
		dc.w $F-1
		dc.w   $380,  $580,  $5A0,  $5C0,  $3F0,  -$20,     0	; Min X, Min Y, Max X, Max Y, X Velo, Y Velo, Player can influence which axis flag (Set = X, Clear = Y)
		dc.w   $5A0,  $560,  $A80,  $5C0,  $3F0,  -$10,     0
		dc.w  $1400,  $A80, $15A0,  $AC0,  $400,     0,     0
		dc.w  $15A0,  $A40, $1960,  $AC0,  $400,  -$40,     0
		dc.w  $1990,  $780, $19E0,  $7F0,     0, -$400,  $100
		dc.w  $1990,  $7F0, $19F0,  $878, -$140, -$400,  $100
		dc.w  $1990,  $878, $19F0,  $8FD,  $140, -$400,  $100
		dc.w  $1990,  $8FD, $19F0,  $978, -$140, -$400,  $100
		dc.w  $1990,  $978, $19F0,  $A10,  $100, -$400,  $100
		dc.w  $1960,  $A10, $19D0,  $A80,  $300, -$280,  $100
		dc.w  $2B00,  $800, $2C20,  $840,  $400,     0,     0
		dc.w  $2C20,  $7C0, $2EE0,  $840,  $400,  -$40,     0
		dc.w  $2EE0,  $790, $2F50,  $800,  $300, -$300,  $100
		dc.w  $2F00,  $700, $2F70,  $790,  $100, -$400,  $100
		dc.w  $2F30,  $680, $2F70,  $700,     0, -$400,  $100
HCZ2_WaterTunLocs:
		dc.w 2-1
		dc.w  $3980,  $800, $3AA0,  $840,  $400,     0,     0
		dc.w  $3AA0,  $7C0, $3F00,  $840,  $400,  -$40,     0

; =============== S U B R O U T I N E =======================================


sub_5598:
		cmpi.w	#$101,(Current_zone_and_act).w
		beq.s	loc_55AA
		cmpi.w	#$500,(Current_zone_and_act).w
		beq.s	loc_5612
		rts
; ---------------------------------------------------------------------------

loc_55AA:
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_held_logical).w,d2
		bsr.s	sub_55BC
		lea	(Player_2).w,a1
		move.b	(Ctrl_2_held_logical).w,d2
; End of function sub_5598


; =============== S U B R O U T I N E =======================================


sub_55BC:
		btst	#Status_InAir,status(a1)
		bne.s	loc_55F8
		cmpi.b	#$C,top_solid_bit(a1)
		beq.s	loc_55F8
		lea	(Level_layout_header).w,a2
		move.w	y_pos(a1),d0
		lsr.w	#5,d0
		and.w	(Layout_row_index_mask).w,d0
		move.w	8(a2,d0.w),d0
		move.w	x_pos(a1),d1
		lsr.w	#7,d1
		add.w	d1,d0
		movea.w	d0,a2
		move.b	(a2),d0
		lea	byte_574E(pc),a2
		moveq	#$A-1,d1

loc_55F0:
		cmp.b	-(a2),d0
		dbeq	d1,loc_55F0
		beq.s	loc_560C

loc_55F8:
		tst.b	status_secondary(a1)
		bpl.s	locret_560A
		move.w	#5,move_lock(a1)
		andi.b	#$7F,status_secondary(a1)

locret_560A:
		rts
; ---------------------------------------------------------------------------

loc_560C:
		moveq	#-8,d0
		bra.w	loc_567E
; End of function sub_55BC

; ---------------------------------------------------------------------------

loc_5612:
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_held_logical).w,d2
		bsr.s	sub_5624
		lea	(Player_2).w,a1
		move.b	(Ctrl_2_held_logical).w,d2

; =============== S U B R O U T I N E =======================================


sub_5624:
		btst	#Status_InAir,status(a1)
		bne.s	loc_5660
		btst	#Status_OnObj,status(a1)
		bne.s	loc_5660
		lea	(Level_layout_header).w,a2
		move.w	y_pos(a1),d0
		lsr.w	#5,d0
		and.w	(Layout_row_index_mask).w,d0
		move.w	8(a2,d0.w),d0
		move.w	x_pos(a1),d1
		lsr.w	#7,d1
		add.w	d1,d0
		movea.w	d0,a2
		move.b	(a2),d0
		lea	WaterTransition_AIZ1(pc),a2
		moveq	#$A-1,d1

loc_5658:
		cmp.b	-(a2),d0
		dbeq	d1,loc_5658
		beq.s	loc_5674

loc_5660:
		tst.b	status_secondary(a1)
		bpl.s	locret_5672
		move.w	#5,move_lock(a1)
		andi.b	#$7F,status_secondary(a1)

locret_5672:
		rts
; ---------------------------------------------------------------------------

loc_5674:
		lea	(byte_573A).l,a2
		move.b	(a2,d1.w),d0

loc_567E:
		beq.s	loc_56CA
		move.b	ground_vel(a1),d1
		tst.b	d0
		bpl.s	loc_5694
		cmp.b	d0,d1
		ble.s	loc_569E
		subi.w	#$40,ground_vel(a1)
		bra.s	loc_569E
; ---------------------------------------------------------------------------

loc_5694:
		cmp.b	d0,d1
		bge.s	loc_569E
		addi.w	#$40,ground_vel(a1)

loc_569E:
		bclr	#Status_Facing,status(a1)
		tst.b	d1
		bpl.s	loc_56AE
		bset	#Status_Facing,status(a1)

loc_56AE:
		move.b	#$1B,anim(a1)
		cmpi.b	#5,(Current_zone).w
		bne.s	loc_56C2
		move.b	#$19,anim(a1)

loc_56C2:
		ori.b	#$80,status_secondary(a1)
		rts
; ---------------------------------------------------------------------------

loc_56CA:
		move.w	#4,d1
		move.w	ground_vel(a1),d0
		btst	#button_left,d2
		beq.s	loc_56EC
		move.b	#0,anim(a1)
		bset	#Status_Facing,status(a1)
		sub.w	d1,d0
		tst.w	d0
		bpl.s	loc_56EC
		sub.w	d1,d0

loc_56EC:
		btst	#button_right,d2
		beq.s	loc_5706
		move.b	#0,anim(a1)
		bclr	#Status_Facing,status(a1)
		add.w	d1,d0
		tst.w	d0
		bmi.s	loc_5706
		add.w	d1,d0

loc_5706:
		move.w	#4,d1
		tst.w	d0
		beq.s	loc_572E
		bmi.s	loc_5720
		sub.w	d1,d0
		bhi.s	loc_571E
		move.w	#0,d0
		move.b	#5,anim(a1)

loc_571E:
		bra.s	loc_572E
; ---------------------------------------------------------------------------

loc_5720:
		add.w	d1,d0
		bhi.s	loc_572E
		move.w	#0,d0
		move.b	#5,anim(a1)

loc_572E:
		move.w	d0,ground_vel(a1)
		ori.b	#$80,status_secondary(a1)
		rts
; End of function sub_5624

; ---------------------------------------------------------------------------
byte_573A:
		dc.b  $F8, $F8,   8,   8, $F4, $F4, $F4,  $C,  $C,  $C
		dc.b  $1C, $72, $83, $84, $8B, $91, $9F, $A0, $A5, $A6
byte_574E:
		dc.b  $2E, $C6, $33, $C5, $24, $2A, $44, $1F, $27, $2B
		even
; ---------------------------------------------------------------------------
; Water palette transition tables

; These are used by HInt3 to load the water palette only a small bit at a time,
; this is to space out the CRAM writes to push the VDP dots offscreen.
;
; Each value is an offset into Water_palette.
; From there, 6 bytes, meaning 3 palette entries, are transferred to CRAM.
; ---------------------------------------------------------------------------

WaterTransition_AIZ1: watertransheader
		dc.w      2
		dc.w    $68
		dc.w    $62
		dc.w    $42
		dc.w    $48
		dc.w    $4E
		dc.w    $54
		dc.w      8
		dc.w     $E
		dc.w    $14
		dc.w    $1A
		dc.w    $34
		dc.w    $22
		dc.w    $3A
		dc.w    $2E
		dc.w    $28
WaterTransition_AIZ1_End

WaterTransition_AIZ2: watertransheader
		dc.w    $6E
		dc.w    $68
		dc.w      2
		dc.w    $48
		dc.w    $42
		dc.w    $4E
		dc.w    $5A
		dc.w    $54
		dc.w    $62
		dc.w    $74
		dc.w      8
		dc.w     $E
		dc.w    $14
		dc.w    $1A
		dc.w    $34
		dc.w    $22
		dc.w    $3A
		dc.w    $2E
		dc.w    $28
WaterTransition_AIZ2_End

WaterTransition_CNZ2ICZ2: watertransheader
		dc.w    $6E
		dc.w    $68
		dc.w    $7A
		dc.w    $74
		dc.w    $62
		dc.w      2
		dc.w    $42
		dc.w    $48
		dc.w    $4E
		dc.w    $5A
		dc.w      8
		dc.w     $E
		dc.w    $14
		dc.w    $1A
		dc.w    $34
		dc.w    $22
		dc.w    $3A
		dc.w    $2E
		dc.w    $28
		dc.w    $54
WaterTransition_CNZ2ICZ2_End

; Hydrocity Zone doesn't use this?
WaterTransition_HCZLBZ1: watertransheader
		dc.w      2
		dc.w    $74
		dc.w    $62
		dc.w    $68
		dc.w    $6E
		dc.w    $42
		dc.w    $48
		dc.w    $7A
		dc.w    $5A
		dc.w    $54
		dc.w      8
		dc.w     $E
		dc.w    $14
		dc.w    $1A
		dc.w    $2E
		dc.w    $34
		dc.w    $28
		dc.w    $3A
		dc.w    $22
		dc.w    $4E
WaterTransition_HCZLBZ1_End

WaterTransition_LBZ2: watertransheader
		dc.w      2
		dc.w    $6E
		dc.w    $68
		dc.w    $7A
		dc.w    $62
		dc.w    $74
		dc.w    $42
		dc.w    $48
		dc.w    $5A
		dc.w    $54
		dc.w      8
		dc.w     $E
		dc.w    $14
		dc.w    $1A
		dc.w    $2E
		dc.w    $34
		dc.w    $28
		dc.w    $3A
		dc.w    $22
		dc.w    $4E
WaterTransition_LBZ2_End

; Unknown and unused
WaterTransition_Unk: watertransheader
		dc.w      2
		dc.w      8
		dc.w     $E
		dc.w    $14
		dc.w    $1A
		dc.w    $42
		dc.w    $48
		dc.w    $4E
		dc.w    $54
		dc.w    $5A
		dc.w    $62
		dc.w    $68
		dc.w    $6E
		dc.w    $74
		dc.w    $7A
		dc.w    $22
		dc.w    $28
		dc.w    $2E
		dc.w    $34
		dc.w    $3A
WaterTransition_Unk_End

; =============== S U B R O U T I N E =======================================


GetDemoPtr:
		move.w	(Next_demo_number).w,d0
		lsl.w	#2,d0
		move.l	DemoPtrs(pc,d0.w),(Demo_data_addr).w
		move.w	#button_start_mask<<8,(Ctrl_1).w
		move.w	#button_start_mask<<8,(Ctrl_2).w
		st	(Demo_start_button).w
		rts
; End of function GetDemoPtr

; ---------------------------------------------------------------------------
DemoPtrs:
		dc.l DemoDat_MGZ+1
		dc.l DemoDat_AIZ+1
		dc.l DemoDat_HCZ+1

; =============== S U B R O U T I N E =======================================


Demo_PlayRecord:
		tst.w	(Demo_mode_flag).w
		bne.s	loc_587C
		rts
; ---------------------------------------------------------------------------

loc_587C:
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_start_mask,d0
		beq.s	loc_5890
		move.b	#4,(Game_mode).w

loc_5890:
		movea.l	(Demo_data_addr).w,a0
		move.b	(Demo_start_button).w,d1
		andi.b	#button_start_mask,d1
		or.b	-1(a0),d1
		move.b	(Ctrl_1_held).w,d0
		andi.b	#button_start_mask,d0
		sne	(Demo_start_button).w
		or.b	(a0)+,d0
		move.l	a0,(Demo_data_addr).w
		move.b	d0,(Ctrl_1_held).w
		eor.b	d0,d1
		and.b	d0,d1
		move.b	d1,(Ctrl_1_pressed).w
		move.w	#(button_start_mask<<8)|button_start_mask,d0
		and.w	d0,(Ctrl_2).w
		rts
; End of function Demo_PlayRecord


; =============== S U B R O U T I N E =======================================


LoadSolids:
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#5,d0
		lea	(SolidIndexes).l,a1
		adda.l	d0,a1
		move.l	(a1),d0
		move.l	d0,(Primary_collision_addr).w
		addi.l	#$600,d0
		move.l	d0,(Secondary_collision_addr).w
		move.l	#Primary_collision_addr,(Collision_addr).w
		rts
; End of function LoadSolids


; =============== S U B R O U T I N E =======================================


OscillateNumInit:
		lea	(Oscillating_table).w,a1
		lea	(Osc_Data).l,a2
		moveq	#(Oscillating_table_end-Oscillating_table)/2-1,d1

Osc_Loop:
		move.w	(a2)+,(a1)+
		dbf	d1,Osc_Loop
		rts
; End of function OscillateNumInit

; ---------------------------------------------------------------------------
Osc_Data:
		dc.w %0000000001111101	; oscillation direction bitfield
		dc.w    $80,     0	; baseline values
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w    $80,     0
		dc.w  $3848,   $EE
		dc.w  $2080,   $B4
		dc.w  $3080,  $10E
		dc.w  $5080,  $1C2
		dc.w  $7080,  $276
		dc.w    $80,     0
		dc.w  $4000,   $FE

; =============== S U B R O U T I N E =======================================


OscillateNumDo:
		tst.w	(Competition_mode).w
		bne.s	loc_5958
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	OscillateNumDo_Return

loc_5958:
		lea	(Oscillating_table).w,a1
		lea	(Osc_Data2).l,a2
		move.w	(a1)+,d3
		moveq	#$10-1,d1

loc_5966:
		move.w	(a2)+,d2
		move.w	(a2)+,d4
		btst	d1,d3
		bne.s	loc_5982
		move.w	2(a1),d0
		add.w	d2,d0
		move.w	d0,2(a1)
		add.w	d0,(a1)
		cmp.b	(a1),d4
		bhi.s	loc_5994
		bset	d1,d3
		bra.s	loc_5994
; ---------------------------------------------------------------------------

loc_5982:
		move.w	2(a1),d0
		sub.w	d2,d0
		move.w	d0,2(a1)
		add.w	d0,(a1)
		cmp.b	(a1),d4
		bls.s	loc_5994
		bclr	d1,d3

loc_5994:
		addq.w	#4,a1
		dbf	d1,loc_5966
		move.w	d3,(Oscillating_table).w

OscillateNumDo_Return:
		rts
; End of function OscillateNumDo

; ---------------------------------------------------------------------------
Osc_Data2:
		dc.w    2, $10
		dc.w    2, $18
		dc.w    2, $20
		dc.w    2, $30
		dc.w    4, $20
		dc.w    8,   8
		dc.w    8, $40
		dc.w    4, $40
		dc.w    2, $38
		dc.w    2, $38
		dc.w    2, $20
		dc.w    3, $30
		dc.w    5, $50
		dc.w    7, $70
		dc.w    2, $40
		dc.w    2, $40

; =============== S U B R O U T I N E =======================================


ChangeRingFrame:
		subq.b	#1,(Rings_frame_timer).w
		bpl.s	loc_59F6
		move.b	#7,(Rings_frame_timer).w
		addq.b	#1,(Rings_frame).w
		andi.b	#3,(Rings_frame).w

loc_59F6:
		tst.b	(Ring_spill_anim_counter).w
		beq.s	loc_5A18
		moveq	#0,d0
		move.b	(Ring_spill_anim_counter).w,d0
		add.w	(Ring_spill_anim_accum).w,d0
		move.w	d0,(Ring_spill_anim_accum).w
		rol.w	#7,d0
		andi.w	#3,d0
		move.b	d0,(Ring_spill_anim_frame).w
		subq.b	#1,(Ring_spill_anim_counter).w

loc_5A18:
		addi.w	#$180,(AIZ_vine_angle).w
		rts
; End of function ChangeRingFrame

; ---------------------------------------------------------------------------
S2_DemoDat_AIZ:
		binclude "Levels/AIZ/Demodata/1 Proto.bin"
		even

; =============== S U B R O U T I N E =======================================


LoadLevelLoadBlock:
		move.w	(Current_zone_and_act).w,d0
		bne.s	loc_5E38
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_5E34
		tst.b	(Last_star_post_hit).w
		beq.s	loc_5E38

loc_5E34:
		move.w	#$D00,d0

loc_5E38:
		ror.b	#1,d0
		lsr.w	#4,d0
		andi.w	#$1F8,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	(LevelLoadBlock).l,a4
		lea	(a4,d0.w),a4
		move.l	(a4)+,d0
		andi.l	#$FFFFFF,d0
		move.l	d0,d7
		movea.l	d0,a1
		move.w	(a1),d4
		move.w	#0,d2
		jsr	(Queue_Kos_Module).l
		move.l	(a4)+,d0
		andi.l	#$FFFFFF,d0
		cmp.l	d0,d7
		beq.s	loc_5E7E
		movea.l	d0,a1
		move.w	d4,d2
		jsr	(Queue_Kos_Module).l

loc_5E7E:
		move.b	#$C,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		tst.b	(Kos_modules_left).w
		bne.s	loc_5E7E
		rts
; End of function LoadLevelLoadBlock


; =============== S U B R O U T I N E =======================================


CheckLevelForWater:
		cmpi.b	#0,(Current_zone).w
		beq.s	loc_5EC8
		cmpi.b	#1,(Current_zone).w
		beq.s	loc_5EC8
		cmpi.w	#$301,(Current_zone_and_act).w
		beq.s	loc_5EC8
		cmpi.w	#$501,(Current_zone_and_act).w
		beq.s	loc_5EC8
		cmpi.w	#$601,(Current_zone_and_act).w
		bne.s	loc_5ED4

loc_5EC8:
		move.b	#1,(Water_flag).w
		move.w	#0,(Competition_mode).w

loc_5ED4:
		tst.b	(Water_flag).w
		beq.s	LoadWaterPalette
		move.w	#$4EF9,(H_int_jump).w
		move.l	#HInt2,(H_int_addr).w
		cmpi.b	#1,(Current_zone).w
		beq.s	loc_5F08
		move.l	#HInt3,(H_int_addr).w
		cmpi.w	#$1000,(V_blank_cycles).w
		blo.s	loc_5F08
		move.l	#HInt4,(H_int_addr).w

loc_5F08:
		move.l	#WaterTransition_AIZ1,(Water_palette_data_addr).w
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#6,d0
		andi.w	#$FFFE,d0
		lea	(StartingWaterHeights).l,a1
		move.w	(a1,d0.w),d0
		move.w	d0,(Water_level).w
		move.w	d0,(Mean_water_level).w
		move.w	d0,(Target_water_level).w
		clr.b	(Water_entered_counter).w
		clr.b	(Water_full_screen_flag).w
		move.b	#1,(Water_speed).w
; End of function CheckLevelForWater


; =============== S U B R O U T I N E =======================================


LoadWaterPalette:
		tst.b	(Water_flag).w
		beq.w	locret_5FEE
		moveq	#$2B,d0
		cmpi.w	#0,(Current_zone_and_act).w
		beq.w	loc_5FD6
		moveq	#$2C,d0
		move.l	#WaterTransition_AIZ2,(Water_palette_data_addr).w
		cmpi.w	#1,(Current_zone_and_act).w
		beq.s	loc_5FD6
		moveq	#$31,d0
		move.l	#WaterTransition_HCZLBZ1,(Water_palette_data_addr).w
		cmpi.w	#$100,(Current_zone_and_act).w
		beq.s	loc_5FD6
		moveq	#$32,d0
		move.l	#WaterTransition_HCZLBZ1,(Water_palette_data_addr).w
		cmpi.w	#$101,(Current_zone_and_act).w
		beq.s	loc_5FD6
		moveq	#$3A,d0
		move.l	#WaterTransition_CNZ2ICZ2,(Water_palette_data_addr).w
		cmpi.w	#$301,(Current_zone_and_act).w
		beq.s	loc_5FD6
		moveq	#$39,d0
		move.l	#WaterTransition_CNZ2ICZ2,(Water_palette_data_addr).w
		cmpi.w	#$501,(Current_zone_and_act).w
		beq.s	loc_5FD6
		moveq	#$2D,d0
		move.l	#WaterTransition_HCZLBZ1,(Water_palette_data_addr).w
		cmpi.w	#$600,(Current_zone_and_act).w
		beq.s	loc_5FD6
		moveq	#$2E,d0
		move.l	#WaterTransition_LBZ2,(Water_palette_data_addr).w
		cmpi.w	#$601,(Current_zone_and_act).w
		beq.s	loc_5FD6
		nop

loc_5FD6:
		move.w	d0,d1
		bsr.w	LoadPalette2
		move.w	d1,d0
		bsr.w	LoadPalette2_Immediate
		tst.b	(Last_star_post_hit).w
		beq.s	locret_5FEE
		move.b	(Saved_water_full_screen_flag).w,(Water_full_screen_flag).w

locret_5FEE:
		rts
; End of function LoadWaterPalette

; ---------------------------------------------------------------------------
		subq.w	#1,$24(a0)
		bpl.s	loc_6068
		move.w	#7,$24(a0)
		moveq	#0,d0
		move.b	$2E(a0),d0
		addq.b	#1,$2E(a0)
		move.b	byte_6074(pc,d0.w),d0
		bne.s	loc_6016
		move.b	#1,$2E(a0)
		move.b	byte_6074(pc),d0

loc_6016:
		lsl.w	#7,d0
		lea	(RAM_start).l,a1
		lea	(a1,d0.w),a1
		lea	(RAM_start+$200).l,a2
		move.w	#bytesToWcnt($100),d0

loc_602C:
		move.w	(a1)+,(a2)+
		dbf	d0,loc_602C
		moveq	#0,d0
		move.b	$2F(a0),d0
		addq.b	#1,$2F(a0)
		move.b	byte_608E(pc,d0.w),d0
		bne.s	loc_604C
		move.b	#1,$2F(a0)
		move.b	byte_608E(pc),d0

loc_604C:
		lsl.w	#7,d0
		lea	(RAM_start).l,a1
		lea	(a1,d0.w),a1
		lea	(RAM_start+$F00).l,a2
		move.w	#bytesToWcnt($80),d0

loc_6062:
		move.w	(a1)+,(a2)+
		dbf	d0,loc_6062

loc_6068:
		cmpi.w	#6,$24(a0)
		beq.w	loc_6110
		rts
; ---------------------------------------------------------------------------
byte_6074:
		dc.b    2, $12,   6, $14,   8, $16,  $A, $18,  $C, $18,  $A, $16,   8, $14,   6, $12
		dc.b    3, $1A,  $E, $1C, $10, $1C,  $E, $1A,   0,   0
byte_608E:
		dc.b    2, $1F, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D
		dc.b  $2E, $2F, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D
		dc.b  $3E, $3F, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D
		dc.b  $4E, $4D, $4C, $4B, $4A, $49, $48, $47, $46, $45, $44, $43, $42, $41, $40, $3F
		dc.b  $3E, $3D, $3C, $3B, $3A, $39, $38, $37, $36, $35, $34, $33, $32, $31, $30, $2F
		dc.b  $2E, $2D, $2C, $2B, $2A, $29, $28, $27, $26, $25, $24, $23, $22, $21, $20, $1F
		dc.b    2, $4F, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D
		dc.b  $5E, $5D, $5C, $5B, $5A, $59, $58, $57, $56, $55, $54, $53, $52, $51, $50, $4F
		dc.b    0,   0
		even
; ---------------------------------------------------------------------------

loc_6110:
		move	#$2700,sr
		movem.l	d0-a6,-(sp)
		lea	(Plane_buffer).w,a0
		lea	(Block_table).w,a2
		lea	(Level_layout_main).w,a3
		move.w	#$C000,d7
		move.w	(Camera_X_pos).w,d0
		move.w	d0,d1
		move.w	(Camera_Y_pos).w,d0
		andi.w	#$FF0,d0
		jsr	(Refresh_PlaneFull).l
		movem.l	(sp)+,d0-a6
		move	#$2300,sr
		rts
