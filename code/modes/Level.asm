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
		dc.b mus_SSZ,		mus_SSZ		; SKY SANCTUARY ZONE
		dc.b mus_DEZ1,		mus_DEZ2	; DEATH EGG ZONE
		dc.b mus_DDZ,		mus_DDZ		; DOOMSDAY ZONE
		dc.b mus_SpecialStage,	mus_SSZ		; AIZ INTRO & ENDING
		dc.b mus_ALZ,		mus_ALZ		; AZURE LAKE ZONE
		dc.b mus_BPZ,		mus_BPZ		; BALLOON PARK ZONE
		dc.b mus_DPZ,		mus_DPZ		; DESERT PALACE ZONE
		dc.b mus_CGZ,		mus_CGZ		; CHROME GADGET ZONE
		dc.b mus_EMZ,		mus_EMZ		; ENDLESS MINE ZONE
		dc.b mus_Gumball,	mus_Gumball	; GUMBALL
		dc.b mus_Pachinko,	mus_Pachinko	; PACHINKO
		dc.b mus_Slots,		mus_Slots	; SLOTS
		dc.b mus_EndBoss,	mus_LRZ2	; LAVA REEF ZONE BOSS & HIDDEN PALACE ZONE
		dc.b mus_DEZ2,		mus_LRZ2	; FINAL BOSS & SPECIAL STAGE HUB
		even
; ---------------------------------------------------------------------------

Level:
		bset	#7,(Game_mode).w		; Set bit 7 of F600 is indicate that we're loading the level
		tst.w	(Demo_mode_flag).w
		bmi.s	loc_5FC4
		moveq	#signextendB(mus_FadeOut),d0		; If a demo
		bsr.w	Play_SFX

loc_5FC4:
		clr.w	(Ending_running_flag).w
		clr.w	(Kos_decomp_queue_count).w
		clearRAM	Kos_decomp_stored_registers,$6C	; Clear the KosM bytes
		bsr.w	Clear_Nem_Queue				; Clear PLCs
		cmpi.w	#$D01,(Current_zone_and_act).w
		beq.s	loc_5FFC
		tst.b	(Respawn_table_keep).w
		beq.s	loc_5FF6
		cmpi.w	#$1701,(Current_zone_and_act).w
		beq.s	loc_5FFC

loc_5FF6:
		bsr.w	Pal_FadeToBlack			; If any normal level
		bra.s	loc_6000
; ---------------------------------------------------------------------------

loc_5FFC:
		bsr.w	Pal_FadeToWhite			; If level being loaded is the special stage arena or an ending

loc_6000:
		tst.w	(Demo_mode_flag).w
		bmi.w	loc_60DE					; Skip ahead if negative (?)
		move	#$2700,sr
		bsr.w	Clear_DisplayData		; Clear the screen
		move	#$2300,sr
		moveq	#0,d0
		move.w	d0,(Level_frame_counter).w
		tst.b	(Last_star_post_hit).w
		beq.s	loc_6040				; If no lampost was set, branch
		tst.b	(Special_bonus_entry_flag).w
		bne.s	loc_6034				; Otherwise, ensure that the proper level ID is set to account for levels that use multiple ones in an act
		move.w	(Saved_zone_and_act).w,(Current_zone_and_act).w
		move.w	(Saved_apparent_zone_and_act).w,(Apparent_zone_and_act).w
		bra.s	loc_6040
; ---------------------------------------------------------------------------

loc_6034:
		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
		move.w	(Saved2_apparent_zone_and_act).w,(Apparent_zone_and_act).w

loc_6040:
		move.w	(Current_zone_and_act).w,d0

		; Useless code. Player_mode has not been set yet, and level $D00 has the same PLCs as level 0
		bne.s	loc_6058
		cmpi.w	#2,(Player_mode).w		; If level is Angel Island 1
		bhs.s	loc_6054
		tst.b	(Last_star_post_hit).w			; If character is Sonic
		beq.s	loc_6058				; And no lamppost is set

loc_6054:
		move.w	#$D00,d0				; Set the level ID to skip the intro

loc_6058:
		cmpi.w	#$401,(Current_zone_and_act).w		; If level is Flying Battery 2...
		bne.s	loc_6068
		cmpi.b	#6,(Last_star_post_hit).w		; ...and lamppost is 6 or above (the one before the rising floor at the end)...
		beq.s	loc_6088				; ...don't bother loading level PLCs

loc_6068:
		ror.b	#1,d0
		lsr.w	#4,d0
		andi.w	#$1F8,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d0,d1
		lea	(LevelLoadBlock).l,a2
		moveq	#0,d0
		move.b	(a2,d1.w),d0			; Get the first PLC number for the level
		beq.s	loc_6088
		bsr.w	Load_PLC

loc_6088:
		bsr.w	LevelLoad_ActiveCharacter
		tst.b	(Last_star_post_hit).w
		bne.w	loc_60B4
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	loc_60B4
		cmpi.w	#2,(Player_mode).w
		bhs.s	loc_60B4
		moveq	#1,d0					; If in AIZ intro
		jsr	(Load_PLC_2).l
		moveq	#$A,d0
		bsr.w	Load_PLC					; Load the AIZ Intro graphics
		bra.s	loc_60DE
; ---------------------------------------------------------------------------

loc_60B4:
		moveq	#6,d0
		tst.w	(Competition_mode).w
		bne.s	loc_60DA
		moveq	#5,d0
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_60DA
		moveq	#1,d0
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_60DA
		moveq	#7,d0
		tst.b	(Graphics_flags).w
		bmi.s	loc_60DA
		moveq	#$52,d0

loc_60DA:
		bsr.w	Load_PLC

loc_60DE:
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clearRAM	Lag_frame_count,$58
		clearRAM	Tails_CPU_interact,$100
		clearRAM	Oscillating_table,(AIZ_vine_angle-Oscillating_table)
		clearRAM	_unkFA80,$80
		jsr	(Init_SpriteTable).l
		lea	(VDP_control_port).l,a6
		move.w	#$8B03,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$857C,(a6)
		move.w	#$9001,(a6)
		move.w	#$8004,(a6)
		move.w	#$9200,(a6)
		move.w	#$8720,(a6)
		move.w	#$8C81,(a6)
		tst.b	(Debug_cheat_flag).w
		beq.s	loc_6182
		btst	#button_A,(Ctrl_1).w
		beq.s	loc_6182
		move.b	#1,(Debug_mode_flag).w

loc_6182:
		move.w	#$8AFF,(H_int_counter_command).w
		tst.w	(Competition_mode).w
		beq.s	loc_61BE
		move.w	#$4EF9,(H_int_jump).w
		move.l	#HInt,(H_int_addr).w
		move.w	#$8014,(a6)
		move.w	#$8220,(a6)
		move.w	#$8405,(a6)
		move.w	#$8A6B,(H_int_counter_command).w
		move.w	#$9003,(a6)
		cmpi.b	#$F,(Current_zone).w
		bne.s	loc_61BE
		move.w	#$9011,(a6)

loc_61BE:
		move.w	(H_int_counter_command).w,(a6)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		moveq	#3,d0
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_61DA
		moveq	#5,d0

loc_61DA:
		bsr.w	LoadPalette_Immediate
		bsr.w	CheckLevelForWater
		clearRAM	Water_palette_line_2,$60
		tst.b	(Water_flag).w
		beq.s	loc_61FC
		move.w	#$8014,(a6)

loc_61FC:
		tst.w	(Demo_mode_flag).w
		bmi.w	loc_6310
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#7,d0
		lea	(LevelMusic_Playlist).l,a1
		move.b	(a1,d0.w),d0
		cmpi.w	#1,(Current_zone_and_act).w
		bne.s	loc_622A
		cmpi.b	#3,(Last_star_post_hit).w
		bne.s	loc_622A
		moveq	#signextendB(mus_AIZ1),d0

loc_622A:
		cmpi.w	#$700,(Current_zone_and_act).w
		bne.s	loc_6248
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_6248
		tst.w	(SK_alone_flag).w
		beq.s	loc_6248
		tst.b	(Last_star_post_hit).w
		bne.s	loc_6248
		moveq	#signextendB(mus_Knuckles),d0

loc_6248:
		move.w	d0,(Current_music).w
		bsr.w	Play_Music
		tst.w	(Current_zone_and_act).w
		bne.s	loc_6268
		cmpi.w	#2,(Player_mode).w
		bhs.s	loc_62B6
		tst.b	(Last_star_post_hit).w
		beq.w	loc_62FE
		bra.s	loc_62B6
; ---------------------------------------------------------------------------

loc_6268:
		cmpi.w	#$700,(Current_zone_and_act).w
		bne.s	loc_62B6
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_62B6
		tst.w	(SK_alone_flag).w
		beq.s	loc_62B6
		tst.b	(Last_star_post_hit).w
		bne.s	loc_62B6
		move	#$2700,sr
		move.l	#vdpComm(tiles_to_bytes($580),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_Squirrel).l,a0
		jsr	(Nem_Decomp).l
		move.l	#vdpComm(tiles_to_bytes($592),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_Chicken).l,a0
		jsr	(Nem_Decomp).l
		bra.s	loc_62FE
; ---------------------------------------------------------------------------

loc_62B6:
		cmpi.w	#$1701,(Current_zone_and_act).w
		beq.s	loc_62FE
		tst.b	(Act3_flag).w
		bne.s	loc_62FE
		move.l	#Obj_TitleCard,(Dynamic_object_RAM+(object_size*5)).w

loc_62CC:
		move.b	#$C,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		tst.w	(Dynamic_object_RAM+(object_size*5)+objoff_48).w
		bne.s	loc_62CC
		tst.l	(Nem_decomp_queue).w
		bne.s	loc_62CC

loc_62FE:
		clr.b	(Act3_flag).w
		move	#$2700,sr
		jsr	(HUD_DrawInitial).l
		move	#$2300,sr

loc_6310:
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
		beq.s	loc_63A4
		cmpi.b	#1,(Current_zone).w
		beq.s	loc_638E
		cmpi.b	#1,(Current_zone).w
		bne.s	loc_63A4

loc_638E:
		move.l	#Obj_HCZWaveSplash,(Wave_Splash).w
		move.l	#Obj_HCZWaterSplash,(Dynamic_object_RAM+(object_size*2)).w
		move.b	#1,(Dynamic_object_RAM+(object_size*2)+subtype).w

loc_63A4:
		cmpi.b	#7,(Current_zone).w
		bne.s	loc_63B4
		move.l	#Obj_MHZ_Pollen_Spawner,(Dynamic_object_RAM+object_size).w

loc_63B4:
		moveq	#0,d0
		tst.b	(Last_star_post_hit).w
		bne.s	loc_6404
		move.w	d0,(Ring_count).w
		move.l	d0,(Timer).w
		move.b	d0,(Extra_life_flags).w
		move.w	d0,(Ring_count_P2).w
		move.l	d0,(Timer_P2).w
		move.b	d0,(Saved_status_secondary).w
		cmpi.w	#$1600,(Current_zone_and_act).w
		beq.s	loc_6400
		cmpi.w	#$1700,(Current_zone_and_act).w
		beq.s	loc_6400
		cmpi.w	#$1701,(Current_zone_and_act).w
		beq.s	loc_6404
		cmpi.b	#$16,(Current_zone).w
		bhs.s	loc_63FC
		cmpi.b	#$13,(Current_zone).w
		bhs.s	loc_6404

loc_63FC:
		move.b	d0,(Saved2_status_secondary).w

loc_6400:
		move.b	d0,(Respawn_table_keep).w

loc_6404:
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
		move.b	d0,(Super_Sonic_Knux_flag).w
		bsr.w	OscillateNumInit
		move.b	#1,(Update_HUD_score).w
		move.b	#1,(Update_HUD_ring_count).w
		move.b	#1,(Update_HUD_timer).w
		move.b	#1,(Level_started_flag).w
		cmpi.w	#$D01,(Current_zone_and_act).w
		beq.s	loc_6460
		cmpi.w	#$1701,(Current_zone_and_act).w
		bne.s	loc_6468

loc_6460:
		clr.b	(Update_HUD_timer).w
		clr.b	(Level_started_flag).w

loc_6468:
		bsr.w	SpawnLevelMainSprites
		jsr	(Load_Sprites).l
		jsr	(Load_Rings).l
		jsr	(Draw_LRZ_Special_Rock_Sprites).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		jsr	(Animate_Tiles).l
		move.w	#1800,(Demo_timer).w
		bsr.w	LoadWaterPalette
		clearRAM	Water_palette_line_2,$60
		move.b	#0,(Ctrl_1_locked).w
		move.b	#0,(Ctrl_2_locked).w
		jsr	GetDemoPtr(pc)
		tst.w	(Competition_mode).w
		bne.w	loc_663A
		tst.w	(Current_zone_and_act).w
		bne.s	loc_64CE
		tst.b	(Last_star_post_hit).w
		beq.s	loc_64DC

loc_64CE:
		cmpi.b	#$E,(Current_zone).w
		bhs.s	loc_64DC
		jsr	(PLCLoad_AnimalsAndExplosion).l

loc_64DC:
		move.w	#$2030-1,(Palette_fade_info).w
		jsr	(Pal_FillBlack).l
		move.w	#$16,(Palette_fade_timer).w
		move.w	#$16,(Dynamic_object_RAM+(object_size*5)+objoff_2E).w
		move.w	#$7F<<8,(Ctrl_1).w
		move.w	#$7F<<8,(Ctrl_2).w
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
		jsr	(Load_Sprites).l
		jsr	(Process_Sprites).l
		tst.w	(Restart_level_flag).w
		bne.w	Level
		jsr	(DeformBgLayer).l
		jsr	(ScreenEvents).l
		bsr.w	Handle_Onscreen_Water_Height
		jsr	(Load_Rings).l
		cmpi.b	#9,(Current_zone).w
		bne.s	Level_NotLRZ
		jsr	(Draw_LRZ_Special_Rock_Sprites).l

Level_NotLRZ:
		jsr	(Animate_Tiles).l
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		bsr.w	OscillateNumDo
		bsr.w	ChangeRingFrame
		jsr	(Render_Sprites).l
		cmpi.b	#$15,(Current_zone).w
		bne.s	Level_NotSlots
		jsr	(Slots_RenderLayout).l
		jsr	(Slots_CycleOptions).l

Level_NotSlots:
		cmpi.b	#8,(Game_mode).w
		beq.s	DemoMode
		cmpi.b	#$C,(Game_mode).w
		beq.w	LevelLoop
		rts
; ---------------------------------------------------------------------------

DemoMode:
		tst.w	(Restart_level_flag).w
		bne.s	loc_65D0
		tst.w	(Demo_timer).w
		beq.s	loc_65D0
		cmpi.b	#8,(Game_mode).w
		beq.w	LevelLoop
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_65D0:
		cmpi.b	#8,(Game_mode).w
		bne.s	loc_65E0
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_65E0:
		move.w	#60,(Demo_timer).w
		move.w	#$40-1,(Palette_fade_info).w
		clr.w	(Pal_fade_delay).w

loc_65F0:
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
		bpl.s	loc_6632
		move.w	#2,(Pal_fade_delay).w
		bsr.w	Pal_ToBlack

loc_6632:
		tst.w	(Demo_timer).w
		bne.s	loc_65F0
		rts
; ---------------------------------------------------------------------------

loc_663A:
		move.w	#0,(_unkFF7E).w
		tst.b	(Debug_cheat_flag).w
		beq.s	loc_665A
		move.b	(_unkFF7C).w,d0
		cmpi.b	#$A0,d0
		bne.s	loc_665A
		move.w	(Sound_test_sound).w,d0
		lsl.w	#8,d0
		move.w	d0,(_unkFF7E).w

loc_665A:
		move.w	#$40-1,(Palette_fade_info).w
		jsr	(Pal_FillBlack).l
		move.w	#$16,(Palette_fade_timer).w
		move.w	#0,(_unkFF7C).w
		bclr	#7,(Game_mode).w

loc_6678:
		bsr.w	Pause_Game
		move.b	#8,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		addq.w	#1,(Level_frame_counter).w
		move.w	#4,-(sp)
		bra.s	loc_66DA
; ---------------------------------------------------------------------------

loc_6696:
		move.w	(_unkFF7E).w,d0
		add.w	d0,(_unkFF7C).w
		bcc.s	loc_66EA
		bsr.w	Pause_Game
		move.w	#$100,(Z80_bus_request).l	; stop the Z80
		bsr.w	Poll_Controllers
		startZ80
		move.w	#0,(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		lea	(Sprite_table_input).w,a5

loc_66CA:
		move.w	#0,(a5)
		lea	$80(a5),a5
		cmpa.l	#Player_1,a5
		blo.s	loc_66CA

loc_66DA:
		bsr.w	Demo_PlayRecord
		jsr	(Process_Sprites).l
		jsr	(DeformBgLayer).l

loc_66EA:
		subq.w	#1,(sp)
		bne.s	loc_6696
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
		beq.s	loc_672E
		cmpi.b	#$C,(Game_mode).w
		beq.w	loc_6678
		rts
; ---------------------------------------------------------------------------

loc_672E:
		tst.w	(Restart_level_flag).w
		bne.s	loc_674C
		tst.w	(Demo_timer).w
		beq.s	loc_674C
		cmpi.b	#8,(Game_mode).w
		beq.w	loc_6678
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_674C:
		cmpi.b	#8,(Game_mode).w
		bne.s	loc_675C
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_675C:
		move.w	#60,(Demo_timer).w
		move.w	#$40-1,(Palette_fade_info).w
		clr.w	(Pal_fade_delay).w

loc_676C:
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
		bpl.s	loc_67AE
		move.w	#2,(Pal_fade_delay).w
		bsr.w	Pal_ToBlack

loc_67AE:
		tst.w	(Demo_timer).w
		bne.s	loc_676C
		rts

; =============== S U B R O U T I N E =======================================


LevelLoad_ActiveCharacter:
		cmpi.b	#$88,(Game_mode).w
		beq.s	loc_67CC
		tst.w	(Competition_mode).w
		bne.s	loc_67CC
		move.w	(Player_option).w,(Player_mode).w		; Move selected character to active character
		rts
; ---------------------------------------------------------------------------

loc_67CC:
		move.w	#3,(Player_mode).w			; If loading a demo OR 2P mode enabled (?)
		cmpi.b	#7,(Current_zone).w
		beq.s	locret_67EC
		move.w	#0,(Player_mode).w
		tst.w	(SK_alone_flag).w
		beq.s	locret_67EC
		move.w	#1,(Player_mode).w

locret_67EC:
		rts
; End of function LevelLoad_ActiveCharacter


; =============== S U B R O U T I N E =======================================


SpawnLevelMainSprites:
		move.l	#Obj_ResetCollisionResponseList,(Reserved_object_3).w
		bsr.w	SpawnLevelMainSprites_SpawnPlayers
		bsr.w	SpawnLevelMainSprites_SpawnPowerup
		tst.b	(Last_star_post_hit).w
		bne.w	locret_69B6
		tst.b	(Special_bonus_entry_flag).w
		bne.w	locret_69B6
		lea	(Player_1).w,a1
		lea	(Player_2).w,a2
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	loc_6834
		cmpi.w	#2,(Player_mode).w
		bhs.s	locret_6832
		move.l	#Obj_AIZPlaneIntro,(Dynamic_object_RAM+(object_size*2)).w
		clr.b	(Level_started_flag).w

locret_6832:
		rts
; ---------------------------------------------------------------------------

loc_6834:
		cmpi.w	#$100,(Current_zone_and_act).w
		bne.s	loc_6886
		move.b	#$1B,anim(a1)
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_685C
		move.w	#($21<<8)|$21,anim(a1)	; and prev_anim
		move.b	#1,anim_frame(a1)
		; Bug: this tries to clear Knuckles' anim_frame_timer, but Knuckles is in a1
		move.b	#0,anim_frame_timer(a0)

loc_685C:
		bset	#Status_InAir,status(a1)
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_6870
		move.b	#1,jumping(a1)

loc_6870:
		tst.l	(a2)
		beq.s	loc_6886
		move.b	#$1B,anim(a2)
		bset	#Status_InAir,status(a2)
		move.b	#1,jumping(a2)

loc_6886:
		cmpi.w	#$900,(Current_zone_and_act).w
		bne.s	loc_6896
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_68A6

loc_6896:
		cmpi.w	#$1600,(Current_zone_and_act).w
		beq.s	loc_68A6
		cmpi.w	#$200,(Current_zone_and_act).w
		bne.s	loc_68C2

loc_68A6:
		move.b	#$1B,anim(a1)
		bset	#Status_InAir,status(a1)
		tst.l	(a2)
		beq.s	loc_68C2
		move.b	#$1B,anim(a2)
		bset	#Status_InAir,status(a2)

loc_68C2:
		cmpi.w	#$700,(Current_zone_and_act).w
		bne.s	loc_68D0
		tst.w	(SK_alone_flag).w
		beq.s	loc_68D8

loc_68D0:
		cmpi.w	#$300,(Current_zone_and_act).w
		bne.s	loc_690A

loc_68D8:
		cmpi.w	#1,(Player_mode).w
		bne.s	loc_68FC
		move.l	#Obj_Tails,(Player_2).w
		move.w	(Player_1+x_pos).w,(Player_2+x_pos).w
		move.w	(Player_1+y_pos).w,(Player_2+y_pos).w
		move.w	#0,(Tails_CPU_routine).w
		bra.s	loc_690A
; ---------------------------------------------------------------------------

loc_68FC:
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_690A
		move.w	#$20,(Tails_CPU_routine).w

loc_690A:
		cmpi.w	#$500,(Current_zone_and_act).w
		bne.s	loc_692E
		cmpi.w	#2,(Player_mode).w
		blo.s	loc_6926
		bne.s	loc_692E
		move.l	#Obj_LevelIntroICZ1Tails,(Dynamic_object_RAM+(object_size*2)).w
		bra.s	loc_692E
; ---------------------------------------------------------------------------

loc_6926:
		move.l	#Obj_LevelIntroICZ1,(Dynamic_object_RAM+(object_size*2)).w

loc_692E:
		cmpi.w	#$600,(Current_zone_and_act).w
		bne.s	loc_693E
		move.l	#Obj_LevelIntro_PlayerLaunchFromGround,(Dynamic_object_RAM+(object_size*2)).w

loc_693E:
		cmpi.w	#$700,(Current_zone_and_act).w
		bne.s	loc_695A
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_695A
		move.b	#$1B,anim(a1)
		bset	#Status_InAir,status(a1)

loc_695A:
		cmpi.w	#$800,(Current_zone_and_act).w
		bne.s	loc_6986
		move.l	#Obj_LevelIntro_PlayerFallIntoGround,(Dynamic_object_RAM+(object_size*2)).w
		move.b	#2,anim(a1)
		bset	#Status_InAir,status(a1)
		tst.l	(a2)
		beq.s	loc_6986
		move.b	#2,anim(a2)
		bset	#Status_InAir,status(a2)

loc_6986:
		cmpi.w	#$300,(Current_zone_and_act).w
		beq.s	loc_69A6
		cmpi.w	#$B00,(Current_zone_and_act).w
		beq.s	loc_69AE
		cmpi.w	#$1601,(Current_zone_and_act).w
		beq.s	loc_69AE
		cmpi.w	#$900,(Current_zone_and_act).w
		bne.s	locret_69B6

loc_69A6:
		cmpi.w	#3,(Player_mode).w
		bne.s	locret_69B6

loc_69AE:
		move.l	#Obj_LevelIntro_PlayerRun,(Dynamic_object_RAM+(object_size*2)).w

locret_69B6:
		rts
; End of function SpawnLevelMainSprites


; =============== S U B R O U T I N E =======================================


SpawnLevelMainSprites_SpawnPowerup:
		cmpi.w	#$D01,(Current_zone_and_act).w
		beq.s	locret_6A00
		cmpi.b	#$13,(Current_zone).w
		beq.s	loc_69E0
		cmpi.b	#$14,(Current_zone).w
		beq.s	loc_69E0
		cmpi.b	#$16,(Current_zone).w
		bhs.s	loc_69E0
		cmpi.b	#$E,(Current_zone).w
		bhs.s	locret_6A00

loc_69E0:
		lea	(Player_1).w,a1
		move.b	(Saved_status_secondary).w,d0
		clr.b	(Saved_status_secondary).w
		andi.b	#(1<<Status_FireShield)|(1<<Status_LtngShield)|(1<<Status_BublShield),d0
		bne.s	loc_6A02
		move.b	(Saved2_status_secondary).w,d0
		clr.b	(Saved2_status_secondary).w
		andi.b	#(1<<Status_FireShield)|(1<<Status_LtngShield)|(1<<Status_BublShield),d0
		bne.s	loc_6A02

locret_6A00:
		rts
; ---------------------------------------------------------------------------

loc_6A02:
		btst	#Status_FireShield,d0
		beq.s	loc_6A28
		andi.b	#$8E,status_secondary(a1)
		bset	#Status_Shield,status_secondary(a1)
		bset	#Status_FireShield,status_secondary(a1)
		move.l	#Obj_FireShield,(Shield).w
		move.w	a1,(Shield+parent).w
		rts
; ---------------------------------------------------------------------------

loc_6A28:
		btst	#Status_LtngShield,d0
		beq.s	loc_6A4E
		andi.b	#$8E,status_secondary(a1)
		bset	#Status_Shield,status_secondary(a1)
		bset	#Status_LtngShield,status_secondary(a1)
		move.l	#Obj_LightningShield,(Shield).w
		move.w	a1,(Shield+parent).w
		rts
; ---------------------------------------------------------------------------

loc_6A4E:
		btst	#Status_BublShield,d0
		beq.s	locret_6A74
		andi.b	#$8E,status_secondary(a1)
		bset	#Status_Shield,status_secondary(a1)
		bset	#Status_BublShield,status_secondary(a1)
		move.l	#Obj_BubbleShield,(Shield).w
		move.w	a1,(Shield+parent).w
		rts
; ---------------------------------------------------------------------------

locret_6A74:
		rts
; End of function SpawnLevelMainSprites_SpawnPowerup


; =============== S U B R O U T I N E =======================================


SpawnLevelMainSprites_SpawnPlayers:
		cmpi.w	#$1300,(Current_zone_and_act).w
		blo.s	loc_6A8A
		cmpi.w	#$1600,(Current_zone_and_act).w
		bhs.s	loc_6A8A
		clr.b	(Update_HUD_timer).w

loc_6A8A:
		cmpi.w	#$1400,(Current_zone_and_act).w
		bne.s	loc_6AB8
		move.l	#Obj_PachinkoEnergyTrap,(Dynamic_object_RAM+(object_size*2)).w
		move.w	#$78,(Dynamic_object_RAM+(object_size*2)+x_pos).w
		move.w	#$F30,(Dynamic_object_RAM+(object_size*2)+y_pos).w
		move.w	(Saved_ring_count).w,(Ring_count).w
		move.b	(Saved_extra_life_flags).w,(Extra_life_flags).w
		move.b	#1,(Update_HUD_ring_count).w

loc_6AB8:
		cmpi.b	#$15,(Current_zone).w
		beq.w	loc_6B76
		tst.w	(Competition_mode).w
		bne.w	loc_6B94
		move.w	(Player_mode).w,d0
		bne.s	loc_6B1E
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

loc_6B1E:
		subq.w	#1,d0
		bne.s	loc_6B42
		move.l	#Obj_Sonic,(Player_1).w
		move.l	#Obj_DashDust,(Dust).w
		move.l	#Obj_InstaShield,(Shield).w
		move.w	#Player_1,(Shield+parent).w
		rts
; ---------------------------------------------------------------------------

loc_6B42:
		subq.w	#1,d0
		bne.s	loc_6B64
		move.l	#Obj_Tails,(Player_1).w
		move.l	#Obj_DashDust,(Dust_P2).w
		addi.w	#4,(Player_1+y_pos).w
		move.w	#0,(Tails_CPU_routine).w
		rts
; ---------------------------------------------------------------------------

loc_6B64:
		move.l	#Obj_Knuckles,(Player_1).w
		move.l	#Obj_DashDust,(Dust).w
		rts
; ---------------------------------------------------------------------------

loc_6B76:
		moveq	#0,d0
		move.b	d0,(SStage_scalar_result_0+2).w
		move.w	d0,(SStage_scalar_result_0).w
		move.l	#Obj_Sonic_RotatingSlotBonus,(Player_1).w
		jsr	(sub_4B6AA).l
		st	(Deform_lock).w
		rts
; ---------------------------------------------------------------------------

loc_6B94:
		move.b	(P1_character).w,d0
		bsr.s	sub_6BD8
		move.l	d1,(Player_1).w
		move.b	(P1_character).w,(Player_1+character_id).w
		move.w	(Player_1+x_pos).w,(Player_2+x_pos).w
		move.w	(Player_1+y_pos).w,(Player_2+y_pos).w
		move.l	#Obj_DashDust2P,(Dust).w
		tst.b	(Not_ghost_flag).w
		beq.s	loc_6BD6
		move.b	(P2_character).w,d0
		bsr.s	sub_6BD8
		move.l	d1,(Player_2).w
		move.b	(P2_character).w,(Player_2+character_id).w
		move.l	#Obj_DashDust2P,(Dust_P2).w

loc_6BD6:
		bra.s	loc_6BF6
; End of function SpawnLevelMainSprites_SpawnPlayers


; =============== S U B R O U T I N E =======================================


sub_6BD8:
		tst.b	d0
		bne.s	loc_6BE2
		move.l	#Obj_Sonic2P,d1

loc_6BE2:
		subq.b	#1,d0
		bne.s	loc_6BEE
		move.l	#Obj_Tails2P,d1
		rts
; ---------------------------------------------------------------------------

loc_6BEE:
		move.l	#Obj_Sonic2P,d1
		rts
; End of function sub_6BD8

; ---------------------------------------------------------------------------

loc_6BF6:
		lea	(Target_palette_line_2).w,a2
		lea	(Pal_Level_2P).l,a1
		move.w	#bytesToWcnt($20),d0

loc_6C04:
		move.w	(a1)+,(a2)+
		dbf	d0,loc_6C04
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


Handle_Onscreen_Water_Height:
		tst.b	(Water_flag).w
		beq.w	loc_6C9C
		tst.b	(Deform_lock).w
		bne.s	loc_6C52
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	loc_6C52
		bsr.w	sub_6F4A
		bsr.w	DynamicWaterHeight

loc_6C52:
		clr.b	(Water_full_screen_flag).w
		moveq	#0,d0
		add.w	(Mean_water_level).w,d0
		move.w	d0,(Water_level).w
		cmpi.w	#$100,(Current_zone_and_act).w
		bne.s	loc_6C70
		cmpi.w	#$900,(Camera_X_pos).w
		blo.s	loc_6C86

loc_6C70:
		move.w	(Water_level).w,d0
		sub.w	(Camera_Y_pos).w,d0
		beq.s	loc_6C80
		bcc.s	loc_6C8E
		tst.w	d0
		bpl.s	loc_6C8E

loc_6C80:
		move.b	#1,(Water_full_screen_flag).w

loc_6C86:
		move.b	#-1,(H_int_counter).w
		rts
; ---------------------------------------------------------------------------

loc_6C8E:
		cmpi.w	#$DF,d0
		blo.s	loc_6C98
		move.w	#$FF,d0

loc_6C98:
		move.b	d0,(H_int_counter).w

loc_6C9C:
		bsr.w	sub_714E
		rts
; End of function Handle_Onscreen_Water_Height

; ---------------------------------------------------------------------------
		clr.b	(Water_full_screen_flag).w
		move.w	(Mean_water_level).w,(Water_level).w
		move.l	#HInt3,(H_int_addr).w
		cmpi.w	#$1000,(V_blank_cycles).w
		blo.s	loc_6CC4
		move.l	#HInt4,(H_int_addr).w

loc_6CC4:
		move.w	(Water_level).w,d0
		sub.w	(Camera_Y_pos).w,d0
		beq.s	loc_6CDC
		bcc.s	loc_6D18
		tst.w	d0
		bpl.s	loc_6D18
		addi.w	#$1E0,d0
		beq.s	loc_6CDC
		bcs.s	loc_6CEA

loc_6CDC:
		move.b	#1,(Water_full_screen_flag).w
		move.b	#-1,(H_int_counter).w
		rts
; ---------------------------------------------------------------------------

loc_6CEA:
		cmpi.w	#$DF,d0
		blo.s	loc_6CF4
		move.w	#$FF,d0

loc_6CF4:
		move.b	d0,(H_int_counter).w
		move.b	#1,(Water_full_screen_flag).w
		move.l	#HInt5,(H_int_addr).w
		cmpi.w	#$1000,(V_blank_cycles).w
		blo.s	loc_6D16
		move.l	#HInt_6,(H_int_addr).w

loc_6D16:
		bra.s	loc_6D26
; ---------------------------------------------------------------------------

loc_6D18:
		cmpi.w	#$DF,d0
		blo.s	loc_6D22
		move.w	#$FF,d0

loc_6D22:
		move.b	d0,(H_int_counter).w

loc_6D26:
		bsr.w	sub_714E
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
		beq.s	.locret_6D9A
		bcc.s	loc_6D96
		neg.w	d1

loc_6D96:
		add.w	d1,(Mean_water_level).w

.locret_6D9A:
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
		dc.w DynamicWaterHeight_LBZ2-.Index
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
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_6DF6
		cmpi.w	#$820,(Camera_target_max_Y_pos).w
		beq.s	locret_6E6C
		cmpi.w	#$3B60,(Camera_X_pos).w
		bhs.s	locret_6E6C

loc_6DF6:
		cmpi.w	#$2440,(Camera_X_pos).w
		bhs.s	loc_6E14
		cmpi.w	#$618,(Target_water_level).w
		bne.s	locret_6E6C
		move.w	#$528,(Target_water_level).w
		move.b	#2,(Water_speed).w
		rts
; ---------------------------------------------------------------------------

loc_6E14:
		tst.b	(Level_trigger_array).w
		bne.s	loc_6E28
		cmpi.w	#$2850,(Camera_X_pos).w
		blo.s	locret_6E6C
		move.b	#1,(Level_trigger_array).w

loc_6E28:
		cmpi.w	#$618,(Target_water_level).w
		beq.s	locret_6E6C
		cmpi.w	#$2900,(Camera_X_pos).w
		bhs.s	loc_6E52
		move.w	#-1,(Screen_shake_flag).w
		jsr	(AllocateObject).l
		bne.s	loc_6E52
		move.l	#Obj_6E6E,(a1)
		move.b	#180,anim_frame_timer(a1)

loc_6E52:
		lea	(Level_layout_main+$1C).w,a3
		moveq	#4-1,d1

loc_6E58:
		movea.w	(a3),a1
		move.b	#0,$4E(a1)
		addq.w	#4,a3
		dbf	d1,loc_6E58
		move.w	#$618,(Target_water_level).w

locret_6E6C:
		rts
; ---------------------------------------------------------------------------

Obj_6E6E:
		subq.b	#1,anim_frame_timer(a0)
		beq.s	loc_6E76
		rts
; ---------------------------------------------------------------------------

loc_6E76:
		move.w	#0,(Screen_shake_flag).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

DynamicWaterHeight_HCZ1:
		lea	(word_6E8C).l,a1
		bra.w	loc_6F2C
; ---------------------------------------------------------------------------
word_6E8C:
		dc.w  $8500,  $900
		dc.w  $8680, $2A00
		dc.w  $8680, $3500
		dc.w  $86A0, $FFFF
; ---------------------------------------------------------------------------

DynamicWaterHeight_HCZ2:
		tst.b	(_unkFAA2).w
		beq.s	loc_6EA4
		rts
; ---------------------------------------------------------------------------

loc_6EA4:
		lea	(word_6EBA).l,a1
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_6F2C
		lea	(word_6EC2).l,a1
		bra.s	loc_6F2C
; ---------------------------------------------------------------------------
word_6EBA:
		dc.w   $700, $3E00
		dc.w   $7E0, $FFFF
word_6EC2:
		dc.w   $700, $4100
		dc.w  $8360, $FFFF
; ---------------------------------------------------------------------------

DynamicWaterHeight_Null:
		rts
; ---------------------------------------------------------------------------

DynamicWaterHeight_LBZ1:
		lea	(word_6ED4).l,a1
		bra.s	loc_6F2C
; ---------------------------------------------------------------------------
word_6ED4:
		dc.w  $8B00,  $E00
		dc.w  $8A00, $1980
		dc.w  $8A00, $2340
		dc.w  $8AC8, $2C00
		dc.w  $8FF0, $FFFF
; ---------------------------------------------------------------------------

DynamicWaterHeight_LBZ2:
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_6EF2
		rts
; ---------------------------------------------------------------------------

loc_6EF2:
		tst.b	(_unkF7C2).w
		bne.s	loc_6F00
		lea	(word_6F12).l,a1
		bra.s	loc_6F2C
; ---------------------------------------------------------------------------

loc_6F00:
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(Mean_water_level).w,d0
		blo.s	locret_6F10
		move.w	#$660,(Mean_water_level).w

locret_6F10:
		rts
; ---------------------------------------------------------------------------
word_6F12:
		dc.w  $8FF0,  $D80
		dc.w  $8B20, $FFFF
; ---------------------------------------------------------------------------

DynamicWaterHeight_Null2:
		rts
; ---------------------------------------------------------------------------

DynamicWaterHeight_Ending:
		cmpi.w	#$1DE0,(Camera_X_pos).w
		blo.s	locret_6F2A
		move.w	#$510,(Target_water_level).w

locret_6F2A:
		rts
; ---------------------------------------------------------------------------

loc_6F2C:
		move.w	(Camera_X_pos).w,d0

loc_6F30:
		move.l	(a1)+,d1
		cmp.w	d1,d0
		bhi.s	loc_6F30
		swap	d1
		tst.w	d1
		bpl.s	loc_6F44
		andi.w	#$7FFF,d1
		move.w	d1,(Mean_water_level).w

loc_6F44:
		move.w	d1,(Target_water_level).w
		rts

; =============== S U B R O U T I N E =======================================


sub_6F4A:
		tst.w	(Debug_placement_mode).w
		bne.w	locret_705A
		cmpi.b	#1,(Current_zone).w
		bne.w	locret_705A
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_6F82
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

loc_6F82:
		lea	(WindTunnel_flag_P2).w,a3
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_held_logical).w,d6
		moveq	#0,d5
; End of function sub_6F4A


; =============== S U B R O U T I N E =======================================


HCZ_WaterTunnels:
		lea	(HCZ1_WaterTunLocs).l,a2
		tst.b	(Current_act).w
		beq.s	loc_6FA2
		lea	(HCZ2_WaterTunLocs).l,a2

loc_6FA2:
		move.w	(a2)+,d2

loc_6FA4:
		move.w	x_pos(a1),d0
		cmp.w	(a2),d0
		blo.w	loc_7046
		cmp.w	4(a2),d0
		bhs.w	loc_7046
		move.w	y_pos(a1),d1
		cmp.w	2(a2),d1
		blo.w	loc_7046
		cmp.w	6(a2),d1
		bhs.s	loc_7046
		cmpi.b	#4,routine(a1)
		bhs.w	loc_7058
		btst	d5,(_unkF7C7).w
		bne.s	locret_702E
		tst.b	object_control(a1)
		bne.s	loc_7058
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
		move.b	#0,double_jump_flag(a1)
		tst.b	$C(a2)
		bne.s	loc_7030
		btst	#button_up,d6
		beq.s	loc_7024
		subq.w	#1,y_pos(a1)

loc_7024:
		btst	#button_down,d6
		beq.s	locret_702E
		addq.w	#1,y_pos(a1)

locret_702E:
		rts
; ---------------------------------------------------------------------------

loc_7030:
		btst	#button_left,d6
		beq.s	loc_703A
		subq.w	#1,x_pos(a1)

loc_703A:
		btst	#button_right,d6
		beq.s	locret_7044
		addq.w	#1,x_pos(a1)

locret_7044:
		rts
; ---------------------------------------------------------------------------

loc_7046:
		adda.w	#$E,a2
		dbf	d2,loc_6FA4
		tst.b	(a3)
		beq.s	locret_705A
		move.b	#$1A,anim(a1)

loc_7058:
		clr.b	(a3)

locret_705A:
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


sub_714E:
		cmpi.w	#$101,(Current_zone_and_act).w
		beq.s	loc_716A
		cmpi.w	#$500,(Current_zone_and_act).w
		beq.s	loc_71D2
		cmpi.b	#8,(Current_zone).w
		beq.w	loc_72FA
		rts
; ---------------------------------------------------------------------------

loc_716A:
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_held_logical).w,d2
		bsr.s	sub_717C
		lea	(Player_2).w,a1
		move.b	(Ctrl_2_held_logical).w,d2
; End of function sub_714E


; =============== S U B R O U T I N E =======================================


sub_717C:
		btst	#Status_InAir,status(a1)
		bne.s	loc_71B8
		cmpi.b	#$C,top_solid_bit(a1)
		beq.s	loc_71B8
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
		lea	byte_7498(pc),a2
		moveq	#$A-1,d1

loc_71B0:
		cmp.b	-(a2),d0
		dbeq	d1,loc_71B0
		beq.s	loc_71CC

loc_71B8:
		tst.b	status_secondary(a1)
		bpl.s	locret_71CA
		move.w	#5,move_lock(a1)
		andi.b	#$7F,status_secondary(a1)

locret_71CA:
		rts
; ---------------------------------------------------------------------------

loc_71CC:
		moveq	#-8,d0
		bra.w	loc_723E
; End of function sub_717C

; ---------------------------------------------------------------------------

loc_71D2:
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_held_logical).w,d2
		bsr.s	sub_71E4
		lea	(Player_2).w,a1
		move.b	(Ctrl_2_held_logical).w,d2

; =============== S U B R O U T I N E =======================================


sub_71E4:
		btst	#Status_InAir,status(a1)
		bne.s	loc_7220
		btst	#Status_OnObj,status(a1)
		bne.s	loc_7220
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
		lea	byte_74A2(pc),a2
		moveq	#$A-1,d1

loc_7218:
		cmp.b	-(a2),d0
		dbeq	d1,loc_7218
		beq.s	loc_7234

loc_7220:
		tst.b	status_secondary(a1)
		bpl.s	locret_7232
		move.w	#5,move_lock(a1)
		andi.b	#$7F,status_secondary(a1)

locret_7232:
		rts
; ---------------------------------------------------------------------------

loc_7234:
		lea	(byte_74A2).l,a2
		move.b	(a2,d1.w),d0

loc_723E:
		beq.s	loc_728A
		move.b	ground_vel(a1),d1
		tst.b	d0
		bpl.s	loc_7254
		cmp.b	d0,d1
		ble.s	loc_725E
		subi.w	#$40,ground_vel(a1)
		bra.s	loc_725E
; ---------------------------------------------------------------------------

loc_7254:
		cmp.b	d0,d1
		bge.s	loc_725E
		addi.w	#$40,ground_vel(a1)

loc_725E:
		bclr	#Status_Facing,status(a1)
		tst.b	d1
		bpl.s	loc_726E
		bset	#Status_Facing,status(a1)

loc_726E:
		move.b	#$1B,anim(a1)
		cmpi.b	#5,(Current_zone).w
		bne.s	loc_7282
		move.b	#$19,anim(a1)

loc_7282:
		ori.b	#$80,status_secondary(a1)
		rts
; ---------------------------------------------------------------------------

loc_728A:
		move.w	#4,d1
		move.w	ground_vel(a1),d0
		btst	#button_left,d2
		beq.s	loc_72AC
		move.b	#0,anim(a1)
		bset	#Status_Facing,status(a1)
		sub.w	d1,d0
		tst.w	d0
		bpl.s	loc_72AC
		sub.w	d1,d0

loc_72AC:
		btst	#button_right,d2
		beq.s	loc_72C6
		move.b	#0,anim(a1)
		bclr	#Status_Facing,status(a1)
		add.w	d1,d0
		tst.w	d0
		bmi.s	loc_72C6
		add.w	d1,d0

loc_72C6:
		move.w	#4,d1
		tst.w	d0
		beq.s	loc_72EE
		bmi.s	loc_72E0
		sub.w	d1,d0
		bhi.s	loc_72DE
		move.w	#0,d0
		move.b	#5,anim(a1)

loc_72DE:
		bra.s	loc_72EE
; ---------------------------------------------------------------------------

loc_72E0:
		add.w	d1,d0
		bhi.s	loc_72EE
		move.w	#0,d0
		move.b	#5,anim(a1)

loc_72EE:
		move.w	d0,ground_vel(a1)
		ori.b	#$80,status_secondary(a1)
		rts
; End of function sub_71E4

; ---------------------------------------------------------------------------

loc_72FA:
		lea	(Player_1).w,a1
		move.b	(Ctrl_1_logical).w,d2
		bsr.s	sub_730C
		lea	(Player_2).w,a1
		move.b	(Ctrl_2_logical).w,d2

; =============== S U B R O U T I N E =======================================


sub_730C:
		btst	#Status_InAir,status(a1)
		bne.s	loc_734A
		btst	#Status_OnObj,status(a1)
		bne.s	loc_734A
		lea	(Level_layout_header).w,a2
		moveq	#$14,d0
		add.w	y_pos(a1),d0
		lsr.w	#5,d0
		and.w	(Layout_row_index_mask).w,d0
		move.w	8(a2,d0.w),d0
		move.w	x_pos(a1),d1
		lsr.w	#7,d1
		add.w	d1,d0
		movea.w	d0,a2
		move.b	(a2),d0
		lea	byte_74BD(pc),a2
		moveq	#$10,d1

loc_7342:
		cmp.b	-(a2),d0
		dbeq	d1,loc_7342
		beq.s	loc_7384

loc_734A:
		tst.b	status_secondary(a1)
		bpl.s	locret_7382
		move.w	#5,move_lock(a1)
		andi.b	#$7F,status_secondary(a1)
		btst	#Status_InAir,status(a1)
		bne.s	locret_7382
		move.b	default_y_radius(a1),y_radius(a1)
		move.b	default_x_radius(a1),x_radius(a1)
		bclr	#Status_Roll,status(a1)
		bclr	#Status_RollJump,status(a1)
		move.b	#0,anim(a1)

locret_7382:
		rts
; ---------------------------------------------------------------------------

loc_7384:
		add.w	d1,d1
		lea	(byte_74BD).l,a2
		move.b	(a2,d1.w),d0
		move.b	1(a2,d1.w),d1
		bne.w	loc_7448

loc_7398:
		move.b	ground_vel(a1),d1
		tst.b	d0
		bpl.s	loc_73C8
		cmp.b	d0,d1
		ble.s	loc_73EE
		subi.w	#$40,ground_vel(a1)
		tst.b	status_secondary(a1)
		bmi.s	loc_73EE
		tst.w	ground_vel(a1)
		bmi.s	loc_73EE
		asr	ground_vel(a1)
		cmpi.b	#-8,d0
		bne.s	loc_73EE
		move.w	#0,ground_vel(a1)
		bra.s	loc_73EE
; ---------------------------------------------------------------------------

loc_73C8:
		cmp.b	d0,d1
		bge.s	loc_73EE
		addi.w	#$40,ground_vel(a1)
		tst.b	status_secondary(a1)
		bmi.s	loc_73EE
		tst.w	ground_vel(a1)
		bpl.s	loc_73EE
		asr	ground_vel(a1)
		cmpi.b	#8,d0
		bne.s	loc_73EE
		move.w	#0,ground_vel(a1)

loc_73EE:
		tst.b	d1
		beq.s	loc_7402
		bclr	#Status_Facing,status(a1)
		tst.b	d1
		bpl.s	loc_7402
		bset	#Status_Facing,status(a1)

loc_7402:
		move.b	#$19,anim(a1)
		move.b	y_radius(a1),d0
		subi.b	#$E,d0
		ext.w	d0
		add.w	d0,y_pos(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		bclr	#Status_Roll,status(a1)
		bclr	#Status_RollJump,status(a1)
		ori.b	#$80,status_secondary(a1)
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$F,d0
		bne.s	locret_7446
		moveq	#signextendB(sfx_SlideSkidQuiet),d0
		jsr	(Play_SFX).l

locret_7446:
		rts
; ---------------------------------------------------------------------------

loc_7448:
		cmpi.b	#1,d1
		bne.s	loc_7462
		move.w	x_pos(a1),d1
		andi.w	#$7F,d1
		cmpi.w	#$40,d1
		blo.w	loc_7398
		bra.w	loc_734A
; ---------------------------------------------------------------------------

loc_7462:
		cmpi.b	#2,d1
		bne.s	loc_747C
		move.w	x_pos(a1),d1
		andi.w	#$7F,d1
		cmpi.w	#$40,d1
		bhs.w	loc_7398
		bra.w	loc_734A
; ---------------------------------------------------------------------------

loc_747C:
		moveq	#-8,d0
		cmpi.b	#$C,top_solid_bit(a1)
		beq.w	loc_7398
		moveq	#8,d0
		bra.w	loc_7398
; End of function sub_730C

; ---------------------------------------------------------------------------
		dc.b  $1C, $72, $83, $84, $8B, $91, $9F, $A0, $A5, $A6
byte_7498:
		dc.b  $2E, $C6, $33, $C5, $24, $2A, $44, $1F, $27, $2B
byte_74A2:
		dc.b  $F8, $F8,   8,   8, $F4, $F4, $F4,  $C,  $C,  $C,  $F, $13, $14, $15, $16, $17, $35, $6C, $6D, $76
		dc.b  $77, $7E, $7F, $85, $8A, $8C, $90
byte_74BD:
		dc.b  $F8,   0, $F8,   0, $FA,   1, $FA,   2, $F8,   0, $F8,   0, $F8,   0,   6,   1,   0,   3,   6,   2
		dc.b    8,   0,   8,   0,   8,   0,   8,   0,   8,   0,   0,   3, $F8,   0,   0
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
		move.w	(Demo_number).w,d0
		lsl.w	#2,d0
		movea.l	DemoPtrs(pc,d0.w),a0
		move.b	(a0)+,(Demo_hold_counter).w
		move.l	a0,(Demo_data_addr).w
		clr.b	(Demo_hold_buttons).w
		move.w	#button_start_mask<<8,(Ctrl_1).w
		move.w	#button_start_mask<<8,(Ctrl_2).w
		st	(Demo_start_button).w
		rts
; End of function GetDemoPtr

; ---------------------------------------------------------------------------
DemoPtrs:
		dc.l DemoDat_AIZ
		dc.l DemoDat_HCZ
		dc.l DemoDat_MGZ
		dc.l DemoDat_MHZ
		dc.l DemoDat_FBZ
		dc.l DemoDat_SOZ
		dc.l DemoDat_SpecialStage

; =============== S U B R O U T I N E =======================================


Demo_PlayRecord:
		tst.w	(Demo_mode_flag).w
		bne.s	loc_761E
		rts
; ---------------------------------------------------------------------------

loc_761E:
		move.b	(Ctrl_1_pressed).w,d0
		andi.b	#button_start_mask,d0
		beq.s	loc_762E
		move.b	#4,(Game_mode).w

loc_762E:
		movea.l	(Demo_data_addr).w,a0
		cmpi.b	#4,(Current_zone).w
		beq.s	loc_765E
		cmpi.b	#7,(Current_zone).w
		bhs.s	loc_765E
		move.b	(Demo_start_button).w,d1
		andi.b	#button_start_mask,d1
		or.b	-1(a0),d1
		move.b	(Ctrl_1_held).w,d0
		andi.b	#button_start_mask,d0
		sne	(Demo_start_button).w
		or.b	(a0)+,d0
		bra.s	loc_768C
; ---------------------------------------------------------------------------

loc_765E:
		move.b	(a0),d2
		subq.b	#1,(Demo_hold_counter).w
		bcc.s	loc_766E
		addq.w	#2,a0
		move.b	-1(a0),(Demo_hold_counter).w

loc_766E:
		move.b	(Demo_start_button).w,d1
		andi.b	#button_start_mask,d1
		or.b	(Demo_hold_buttons).w,d1
		move.b	d2,(Demo_hold_buttons).w
		move.b	(Ctrl_1).w,d0
		andi.b	#button_start_mask,d0
		sne	(Demo_start_button).w
		or.b	d2,d0

loc_768C:
		move.b	d0,(Ctrl_1).w
		eor.b	d0,d1
		and.b	d0,d1
		move.b	d1,(Ctrl_1_pressed).w
		move.w	#(button_start_mask<<8)|button_start_mask,d0
		and.w	d0,(Ctrl_2).w
		move.l	a0,(Demo_data_addr).w
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
	if Sonic3_Complete=0
		cmpi.l	#S3_Level_Solid_Data,d0
		blo.s	LoadSolids_SK_Interleaved_Format
	else
		bpl.s	LoadSolids_SK_Interleaved_Format
	endif
		addi.l	#$600,d0
		move.l	d0,(Secondary_collision_addr).w
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		rts
; ---------------------------------------------------------------------------

LoadSolids_SK_Interleaved_Format:
		addq.l	#1,d0
		move.l	d0,(Secondary_collision_addr).w
		move.l	(Primary_collision_addr).w,(Collision_addr).w
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
		bne.s	loc_774A
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	OscillateNumDo_Return

loc_774A:
		lea	(Oscillating_table).w,a1
		lea	(Osc_Data2).l,a2
		move.w	(a1)+,d3
		moveq	#$10-1,d1

loc_7758:
		move.w	(a2)+,d2
		move.w	(a2)+,d4
		btst	d1,d3
		bne.s	loc_7774
		move.w	2(a1),d0
		add.w	d2,d0
		move.w	d0,2(a1)
		add.w	d0,(a1)
		cmp.b	(a1),d4
		bhi.s	loc_7786
		bset	d1,d3
		bra.s	loc_7786
; ---------------------------------------------------------------------------

loc_7774:
		move.w	2(a1),d0
		sub.w	d2,d0
		move.w	d0,2(a1)
		add.w	d0,(a1)
		cmp.b	(a1),d4
		bls.s	loc_7786
		bclr	d1,d3

loc_7786:
		addq.w	#4,a1
		dbf	d1,loc_7758
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
		bpl.s	loc_77E8
		move.b	#7,(Rings_frame_timer).w
		addq.b	#1,(Rings_frame).w
		andi.b	#3,(Rings_frame).w

loc_77E8:
		tst.b	(Ring_spill_anim_counter).w
		beq.s	loc_780A
		moveq	#0,d0
		move.b	(Ring_spill_anim_counter).w,d0
		add.w	(Ring_spill_anim_accum).w,d0
		move.w	d0,(Ring_spill_anim_accum).w
		rol.w	#7,d0
		andi.w	#3,d0
		move.b	d0,(Ring_spill_anim_frame).w
		subq.b	#1,(Ring_spill_anim_counter).w

loc_780A:
		addi.w	#$180,(AIZ_vine_angle).w
		rts
; End of function ChangeRingFrame


; =============== S U B R O U T I N E =======================================


LoadLevelLoadBlock:
		move.w	(Current_zone_and_act).w,d0
		bne.s	loc_782A
		cmpi.w	#2,(Player_mode).w
		bhs.s	loc_7826
		tst.b	(Last_star_post_hit).w
		beq.s	loc_782A

loc_7826:
		move.w	#$D00,d0

loc_782A:
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
		beq.s	loc_7870
		movea.l	d0,a1
		move.w	d4,d2
		jsr	(Queue_Kos_Module).l

loc_7870:
		move.b	#$C,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		tst.b	(Kos_modules_left).w
		bne.s	loc_7870
		rts
; End of function LoadLevelLoadBlock


; =============== S U B R O U T I N E =======================================


CheckLevelForWater:
		cmpi.w	#0,(Current_zone_and_act).w
		beq.s	loc_78F2
		cmpi.w	#1,(Current_zone_and_act).w
		bne.s	loc_78B2
		cmpi.w	#1,(Apparent_zone_and_act).w
		bne.s	loc_78F2
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_78F2

loc_78B2:
		cmpi.b	#1,(Current_zone).w
		beq.s	loc_78F2
		cmpi.w	#$301,(Current_zone_and_act).w
		bne.s	loc_78CA
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_78F2

loc_78CA:
		cmpi.w	#$501,(Current_zone_and_act).w
		beq.s	loc_78F2
		cmpi.w	#$601,(Current_zone_and_act).w
		beq.s	loc_78F2
		move.w	#$1000,d0
		move.w	d0,(Water_level).w
		move.w	d0,(Mean_water_level).w
		move.w	d0,(Target_water_level).w
		move.b	#0,(Water_flag).w
		rts
; ---------------------------------------------------------------------------

loc_78F2:
		move.b	#1,(Water_flag).w
		move.w	#0,(Competition_mode).w
		tst.b	(Water_flag).w
		beq.s	LoadWaterPalette
		move.w	#$4EF9,(H_int_jump).w
		move.l	#HInt2,(H_int_addr).w
		cmpi.b	#1,(Current_zone).w
		beq.s	loc_7932
		move.l	#HInt3,(H_int_addr).w
		cmpi.w	#$1000,(V_blank_cycles).w
		blo.s	loc_7932
		move.l	#HInt4,(H_int_addr).w

loc_7932:
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
		beq.w	locret_7A20
		moveq	#$2B,d0
		cmpi.w	#0,(Current_zone_and_act).w
		beq.w	loc_7A00
		moveq	#$2C,d0
		move.l	#WaterTransition_AIZ2,(Water_palette_data_addr).w
		cmpi.w	#1,(Current_zone_and_act).w
		beq.s	loc_7A00
		moveq	#$31,d0
		move.l	#WaterTransition_HCZLBZ1,(Water_palette_data_addr).w
		cmpi.w	#$100,(Current_zone_and_act).w
		beq.s	loc_7A00
		moveq	#$32,d0
		move.l	#WaterTransition_HCZLBZ1,(Water_palette_data_addr).w
		cmpi.w	#$101,(Current_zone_and_act).w
		beq.s	loc_7A00
		moveq	#$3A,d0
		move.l	#WaterTransition_CNZ2ICZ2,(Water_palette_data_addr).w
		cmpi.w	#$301,(Current_zone_and_act).w
		beq.s	loc_7A00
		moveq	#$39,d0
		move.l	#WaterTransition_CNZ2ICZ2,(Water_palette_data_addr).w
		cmpi.w	#$501,(Current_zone_and_act).w
		beq.s	loc_7A00
		moveq	#$2D,d0
		move.l	#WaterTransition_HCZLBZ1,(Water_palette_data_addr).w
		cmpi.w	#$600,(Current_zone_and_act).w
		beq.s	loc_7A00
		moveq	#$2E,d0
		move.l	#WaterTransition_LBZ2,(Water_palette_data_addr).w
		cmpi.w	#$601,(Current_zone_and_act).w
		beq.s	loc_7A00
		nop

loc_7A00:
		move.w	d0,d1
		bsr.w	LoadPalette2
		move.w	d1,d0
		bsr.w	LoadPalette2_Immediate
		tst.b	(Last_star_post_hit).w
		beq.s	loc_7A18
		move.b	(Saved_water_full_screen_flag).w,(Water_full_screen_flag).w

loc_7A18:
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_7A22

locret_7A20:
		rts
; ---------------------------------------------------------------------------

loc_7A22:
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		add.w	d0,d0
		lea	Pal_WaterKnux(pc,d0.w),a1
		move.l	(a1),(Water_palette+$4).w
		move.w	4(a1),(Water_palette+$8).w
		move.l	(a1),(Target_water_palette+$4).w
		move.w	4(a1),(Target_water_palette+$8).w
		rts
; End of function LoadWaterPalette

; ---------------------------------------------------------------------------
Pal_WaterKnux:
		binclude "Levels/Misc/Palettes/Water Knuckles Patch.bin"
		even
