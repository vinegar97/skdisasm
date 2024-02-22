LevelSelect_S2Options:
		bsr.w	Pal_FadeToBlack
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		bsr.w	Clear_DisplayData
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8700,(a6)			; Command $8700 - BG color is Pal 0 Color 0
		move.w	#$8C81,(a6)			; Command $8C81 - 40cell screen size, no interlacing, no s/h
		move.w	#$9001,(a6)
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		move.l	#vdpComm(tiles_to_bytes($010),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_S22POptions).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($070),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_S2MenuBox).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($090),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_S2LevelSelectPics).l,a0
		bsr.w	Nem_Decomp
		lea	(RAM_start).l,a1
		lea	(MapEni_S22POptions).l,a0
		move.w	#make_art_tile($000,3,0),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l
		cmpi.b	#$24,(Game_mode).w
		beq.w	MenuScreen_Options
		cmpi.b	#$28,(Game_mode).w
		beq.w	MenuScreen_LevelSelect
		lea	(RAM_start).l,a1
		lea	(MapEni_S2LevSel2P).l,a0
		move.w	#make_art_tile($070,0,0),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start+$198).l,a1
		lea	(MapEni_S2LevSel2P).l,a0
		move.w	#make_art_tile($070,1,0),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start+$330).l,a1
		lea	(MapEni_S2LevSelIcon).l,a0
		move.w	#make_art_tile($090,0,0),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start+$498).l,a2
		moveq	#$10-1,d1

loc_626C:
		move.w	#make_art_tile($07B,1,0),(a2)+
		dbf	d1,loc_626C
		bsr.w	Update2PLevSelSelection
		addq.b	#1,(Current_zone_2P).w
		andi.b	#3,(Current_zone_2P).w
		bsr.w	ClearOld2PLevSelSelection
		addq.b	#1,(Current_zone_2P).w
		andi.b	#3,(Current_zone_2P).w
		bsr.w	ClearOld2PLevSelSelection
		addq.b	#1,(Current_zone_2P).w
		andi.b	#3,(Current_zone_2P).w
		bsr.w	ClearOld2PLevSelSelection
		addq.b	#1,(Current_zone_2P).w
		andi.b	#3,(Current_zone_2P).w
		clr.w	(Player_mode).w
		clr.b	(Current_act_2P).w
		clr.w	(Results_screen_2P).w
		clr.b	(Level_started_flag).w
		clr.w	(Anim_Counters).w
		clr.w	(_unkFF98).w
		lea	(AniPLC_SONICMILES).l,a2
		jsr	(AnimateTiles_DoAniPLC).l
		moveq	#4,d0
		bsr.w	LoadPalette
		lea	(Normal_palette_line_3).w,a1
		lea	(Target_palette_line_3).w,a2
		moveq	#bytesToLcnt($20),d1

loc_62E0:
		move.l	(a1),(a2)+
		clr.l	(a1)+
		dbf	d1,loc_62E0
		moveq	#signextendB(mus_DataSelect),d0
		bsr.w	Play_Music
		move.w	#(30*60)-1,(Demo_timer).w
		clr.w	(Competition_mode).w
		clr.l	(Camera_X_pos).w
		clr.l	(Camera_Y_pos).w
		move.b	#$16,(V_int_routine).w
		bsr.w	Wait_VSync
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		bsr.w	Pal_FadeFromBlack

LevelSelect2P_Main:
		move.b	#$16,(V_int_routine).w
		bsr.w	Wait_VSync
		move	#$2700,sr
		bsr.w	ClearOld2PLevSelSelection
		bsr.w	LevelSelect2P_Controls
		bsr.w	Update2PLevSelSelection
		move	#$2300,sr
		lea	(AniPLC_SONICMILES).l,a2
		jsr	(AnimateTiles_DoAniPLC).l
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_start_mask,d0
		bne.s	LevelSelect2P_PressStart
		bra.w	LevelSelect2P_Main
; ---------------------------------------------------------------------------

LevelSelect2P_PressStart:
		bsr.w	Chk2PZoneCompletion
		bmi.s	loc_6368
		moveq	#signextendB(sfx_Error),d0
		bsr.w	Play_SFX
		bra.w	LevelSelect2P_Main
; ---------------------------------------------------------------------------

loc_6368:
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
		moveq	#0,d0
		move.b	(Current_zone_2P).w,d0
		add.w	d0,d0
		move.w	LevelSelect2P_LevelOrder(pc,d0.w),d0
		bmi.s	loc_63BE
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		move.w	d0,(Saved_zone_and_act).w
		move.w	#1,(Competition_mode).w
		move.b	#$C,(Game_mode).w
		move.b	#0,(Last_star_post_hit).w
		move.b	#0,(Special_bonus_entry_flag).w
		moveq	#0,d0
		move.l	d0,(Score).w
		move.l	d0,(Score_P2).w
		move.l	#5000,(Next_extra_life_score).w
		move.l	#5000,(Next_extra_life_score_P2).w
		rts
; ---------------------------------------------------------------------------

loc_63BE:
		move.b	#4,(Current_special_stage).w
		move.b	#$10,(Game_mode).w
		moveq	#1,d0
		move.w	d0,(Competition_mode).w
		move.w	d0,(Competition_settings).w
		rts
; ---------------------------------------------------------------------------
LevelSelect2P_LevelOrder:
		dc.w 0
		dc.w $B00
		dc.w $C00
		dc.w $FFFF

; =============== S U B R O U T I N E =======================================


LevelSelect2P_Controls:
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		move.b	d0,d1
		andi.b	#button_up_mask|button_down_mask,d0
		beq.s	loc_63F4
		bchg	#1,(Current_zone_2P).w

loc_63F4:
		andi.b	#button_left_mask|button_right_mask,d1
		beq.s	locret_6400
		bchg	#0,(Current_zone_2P).w

locret_6400:
		rts
; End of function LevelSelect2P_Controls


; =============== S U B R O U T I N E =======================================


Update2PLevSelSelection:
		moveq	#0,d0
		move.b	(Current_zone_2P).w,d0
		lsl.w	#4,d0
		lea	(S2LevSel2PIconData).l,a3
		lea	(a3,d0.w),a3
		move.w	#palette_line_3,d0
		lea	(RAM_start+$48).l,a2
		movea.l	(a3)+,a1
		bsr.w	MenuScreenTextToRAM
		lea	(RAM_start+$94).l,a2
		movea.l	(a3)+,a1
		bsr.w	MenuScreenTextToRAM
		lea	(RAM_start+$D8).l,a2
		movea.l	4(a3),a1
		bsr.w	Chk2PZoneCompletion
		bmi.s	loc_6446
		lea	(RAM_start+$468).l,a1

loc_6446:
		moveq	#3-1,d1

loc_6448:
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		lea	$1A(a2),a2
		dbf	d1,loc_6448
		lea	(RAM_start).l,a1
		move.l	(a3)+,d0
		moveq	#$11-1,d1
		moveq	#$C-1,d2
		bsr.w	Plane_Map_To_VRAM
		lea	(Pal_S2LevelIcons).l,a1
		moveq	#0,d0
		move.b	(a3),d0
		lsl.w	#5,d0
		lea	(a1,d0.w),a1
		lea	(Normal_palette_line_3).w,a2
		moveq	#bytesToLcnt($20),d1

loc_647A:
		move.l	(a1)+,(a2)+
		dbf	d1,loc_647A
		rts
; End of function Update2PLevSelSelection


; =============== S U B R O U T I N E =======================================


Chk2PZoneCompletion:
		moveq	#0,d0
		move.b	(Current_zone_2P).w,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		add.w	d0,d0
		lea	(a5,d0.w),a5
		move.w	(a5),d0
		add.w	2(a5),d0
		rts
; End of function Chk2PZoneCompletion


; =============== S U B R O U T I N E =======================================


ClearOld2PLevSelSelection:
		moveq	#0,d0
		move.b	(Current_zone_2P).w,d0
		lsl.w	#4,d0
		lea	(S2LevSel2PIconData).l,a3
		lea	(a3,d0.w),a3
		moveq	#palette_line_0,d0
		lea	(RAM_start+$1E0).l,a2
		movea.l	(a3)+,a1
		bsr.w	MenuScreenTextToRAM
		lea	(RAM_start+$22C).l,a2
		movea.l	(a3)+,a1
		bsr.w	MenuScreenTextToRAM
		lea	(RAM_start+$270).l,a2
		lea	(RAM_start+$498).l,a1
		bsr.w	Chk2PZoneCompletion
		bmi.s	loc_64E0
		lea	(RAM_start+$468).l,a1

loc_64E0:
		moveq	#3-1,d1

loc_64E2:
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		lea	$1A(a2),a2
		dbf	d1,loc_64E2
		lea	(RAM_start+$198).l,a1
		move.l	(a3)+,d0
		moveq	#$11-1,d1
		moveq	#$C-1,d2
		bra.w	Plane_Map_To_VRAM
; End of function ClearOld2PLevSelSelection

; ---------------------------------------------------------------------------
S2LevSel2PIconData:
		dc.l Text2P_EmeraldHill
		dc.l Text2P_Zone
		dc.l vdpComm(VRAM_Plane_A_Name_Table+$104,VRAM,WRITE)
		dc.l $FF0330+(0<<24)
		dc.l Text2P_MysticCave
		dc.l Text2P_Zone
		dc.l vdpComm(VRAM_Plane_A_Name_Table+$12C,VRAM,WRITE)
		dc.l $FF03A8+(5<<24)
		dc.l Text2P_CasinoNight
		dc.l Text2P_Zone
		dc.l vdpComm(VRAM_Plane_A_Name_Table+$784,VRAM,WRITE)
		dc.l $FF03C0+(6<<24)
		dc.l Text2P_Special
		dc.l Text2P_Stage
		dc.l vdpComm(VRAM_Plane_A_Name_Table+$7AC,VRAM,WRITE)
		dc.l $FF0450+($C<<24)

; =============== S U B R O U T I N E =======================================


MenuScreenTextToRAM:
		moveq	#0,d1
		move.b	(a1)+,d1

.loop:
		move.b	(a1)+,d0
		move.w	d0,(a2)+
		dbf	d1,.loop
		rts
; End of function MenuScreenTextToRAM

; ---------------------------------------------------------------------------

MenuScreen_Options:
		lea	(RAM_start).l,a1
		lea	(MapEni_S2Options).l,a0
		move.w	#make_art_tile($070,0,0),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start+$160).l,a1
		lea	(MapEni_S2Options).l,a0
		move.w	#make_art_tile($070,1,0),d0
		bsr.w	Eni_Decomp
		clr.b	(Options_menu_box).w
		bsr.w	OptionScreen_DrawSelected
		addq.b	#1,(Options_menu_box).w
		bsr.w	OptionScreen_DrawUnselected
		addq.b	#1,(Options_menu_box).w
		bsr.w	OptionScreen_DrawUnselected
		clr.b	(Options_menu_box).w
		clr.b	(Level_started_flag).w
		clr.w	(Anim_Counters).w
		lea	(AniPLC_SONICMILES).l,a2
		jsr	(AnimateTiles_DoAniPLC).l
		moveq	#4,d0
		bsr.w	LoadPalette
		moveq	#signextendB(mus_DataSelect),d0
		bsr.w	Play_Music
		clr.w	(Competition_mode).w
		clr.l	(Camera_X_pos).w
		clr.l	(Camera_Y_pos).w
		clr.w	(Level_select_cheat_counter).w
		clr.w	(Debug_mode_cheat_counter).w
		move.b	#$16,(V_int_routine).w
		bsr.w	Wait_VSync
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		bsr.w	Pal_FadeFromBlack

OptionScreen_Main:
		move.b	#$16,(V_int_routine).w
		bsr.w	Wait_VSync
		move	#$2700,sr
		bsr.w	OptionScreen_DrawUnselected
		bsr.w	OptionScreen_Controls
		bsr.w	OptionScreen_DrawSelected
		move	#$2300,sr
		lea	(AniPLC_SONICMILES).l,a2
		jsr	(AnimateTiles_DoAniPLC).l
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_start_mask,d0
		bne.s	OptionScreen_Select
		bra.w	OptionScreen_Main
; ---------------------------------------------------------------------------

OptionScreen_Select:
		move.b	(Options_menu_box).w,d0
		bne.s	OptionScreen_Select_Not1P
		moveq	#0,d0
		move.w	d0,(Competition_mode).w
		move.w	d0,(Competition_settings).w
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		move.w	d0,(Saved_zone_and_act).w
		move.b	#$C,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

OptionScreen_Select_Not1P:
		subq.b	#1,d0
		bne.s	OptionScreen_Select_Other
		moveq	#1,d0
		move.w	d0,(Competition_mode).w
		move.w	d0,(Competition_settings).w
		move.b	#$1C,(Game_mode).w
		move.b	#0,(Current_zone_2P).w
		move.w	#0,(Player_mode).w
		rts
; ---------------------------------------------------------------------------

OptionScreen_Select_Other:
		move.b	#0,(Game_mode).w
		rts

; =============== S U B R O U T I N E =======================================


OptionScreen_Controls:
		moveq	#0,d2
		move.b	(Options_menu_box).w,d2
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		btst	#button_up,d0
		beq.s	loc_6686
		subq.b	#1,d2
		bcc.s	loc_6686
		move.b	#2,d2

loc_6686:
		btst	#button_down,d0
		beq.s	loc_6696
		addq.b	#1,d2
		cmpi.b	#3,d2
		bcs.s	loc_6696
		moveq	#0,d2

loc_6696:
		move.b	d2,(Options_menu_box).w
		lsl.w	#2,d2
		move.b	OptionScreen_Choices(pc,d2.w),d3
		movea.l	OptionScreen_Choices(pc,d2.w),a1
		move.w	(a1),d2
		btst	#button_left,d0
		beq.s	loc_66B2
		subq.b	#1,d2
		bcc.s	loc_66B2
		move.b	d3,d2

loc_66B2:
		btst	#button_right,d0
		beq.s	loc_66C0
		addq.b	#1,d2
		cmp.b	d3,d2
		bls.s	loc_66C0
		moveq	#0,d2

loc_66C0:
		btst	#button_A,d0
		beq.s	loc_66D0
		addi.b	#$10,d2
		cmp.b	d3,d2
		bls.s	loc_66D0
		moveq	#0,d2

loc_66D0:
		move.w	d2,(a1)
		cmpi.b	#2,(Options_menu_box).w
		bne.s	locret_66FE
		andi.w	#button_B_mask|button_C_mask,d0
		beq.s	locret_66FE
		move.w	(Sound_test_sound).w,d0
		bsr.w	Play_Music
		lea	(S2LevelSelectCodeDat).l,a0
		lea	(S2ContinueCodeDat).l,a2
		lea	(Level_select_flag).w,a1
		moveq	#0,d2
		bsr.w	CheckCheats

locret_66FE:
		rts
; End of function OptionScreen_Controls

; ---------------------------------------------------------------------------
OptionScreen_Choices:
		dc.w   $2FF, $FF0A
		dc.w   $1FF, $FF0C
		dc.w  $C9FF, $FF84

; =============== S U B R O U T I N E =======================================


OptionScreen_DrawSelected:
		bsr.w	OptionScreen_SelectTextPtr
		moveq	#0,d1
		move.b	(Options_menu_box).w,d1
		lsl.w	#3,d1
		lea	(S2OptScrBoxData).l,a3
		lea	(a3,d1.w),a3
		move.w	#palette_line_3,d0
		lea	(RAM_start+$030).l,a2
		movea.l	(a3)+,a1
		bsr.w	MenuScreenTextToRAM
		lea	(RAM_start+$0B6).l,a2
		moveq	#0,d1
		cmpi.b	#2,(Options_menu_box).w
		beq.s	loc_6754
		move.b	(Options_menu_box).w,d1
		lsl.w	#2,d1
		lea	OptionScreen_Choices(pc),a1
		movea.l	(a1,d1.w),a1
		move.w	(a1),d1
		lsl.w	#2,d1

loc_6754:
		movea.l	(a4,d1.w),a1
		bsr.w	MenuScreenTextToRAM
		cmpi.b	#2,(Options_menu_box).w
		bne.s	loc_676E
		lea	(RAM_start+$0C2).l,a2
		bsr.w	OptionScreen_HexDumpSoundTest

loc_676E:
		lea	(RAM_start).l,a1
		move.l	(a3)+,d0
		moveq	#$16-1,d1
		moveq	#8-1,d2
		bra.w	Plane_Map_To_VRAM
; End of function OptionScreen_DrawSelected


; =============== S U B R O U T I N E =======================================


OptionScreen_DrawUnselected:
		bsr.w	OptionScreen_SelectTextPtr
		moveq	#0,d1
		move.b	(Options_menu_box).w,d1
		lsl.w	#3,d1
		lea	(S2OptScrBoxData).l,a3
		lea	(a3,d1.w),a3
		moveq	#palette_line_0,d0
		lea	(RAM_start+$190).l,a2
		movea.l	(a3)+,a1
		bsr.w	MenuScreenTextToRAM
		lea	(RAM_start+$216).l,a2
		moveq	#0,d1
		cmpi.b	#2,(Options_menu_box).w
		beq.s	loc_67C4
		move.b	(Options_menu_box).w,d1
		lsl.w	#2,d1
		lea	OptionScreen_Choices(pc),a1
		movea.l	(a1,d1.w),a1
		move.w	(a1),d1
		lsl.w	#2,d1

loc_67C4:
		movea.l	(a4,d1.w),a1
		bsr.w	MenuScreenTextToRAM
		cmpi.b	#2,(Options_menu_box).w
		bne.s	loc_67DE
		lea	(RAM_start+$222).l,a2
		bsr.w	OptionScreen_HexDumpSoundTest

loc_67DE:
		lea	(RAM_start+$160).l,a1
		move.l	(a3)+,d0
		moveq	#$16-1,d1
		moveq	#8-1,d2
		bra.w	Plane_Map_To_VRAM
; End of function OptionScreen_DrawUnselected


; =============== S U B R O U T I N E =======================================


OptionScreen_SelectTextPtr:
		lea	(off_6858).l,a4
		tst.b	(Graphics_flags).w
		bpl.s	loc_6800
		lea	(off_6864).l,a4

loc_6800:
		tst.b	(Options_menu_box).w
		beq.s	loc_680C
		lea	(off_6870).l,a4

loc_680C:
		cmpi.b	#2,(Options_menu_box).w
		bne.s	locret_681A
		lea	(off_6878).l,a4

locret_681A:
		rts
; End of function OptionScreen_SelectTextPtr


; =============== S U B R O U T I N E =======================================


OptionScreen_HexDumpSoundTest:
		move.w	(Sound_test_sound).w,d1
		move.b	d1,d2
		lsr.b	#4,d1
		bsr.s	sub_6828
		move.b	d2,d1
; End of function OptionScreen_HexDumpSoundTest


; =============== S U B R O U T I N E =======================================


sub_6828:
		andi.w	#$F,d1
		cmpi.b	#$A,d1
		bcs.s	loc_6836
		addi.b	#4,d1

loc_6836:
		addi.b	#$10,d1
		move.b	d1,d0
		move.w	d0,(a2)+
		rts
; End of function sub_6828

; ---------------------------------------------------------------------------
S2OptScrBoxData:
		dc.l TextOptScr_PlayerSelect
		dc.l vdpComm(VRAM_Plane_A_Name_Table+$192,VRAM,WRITE)
		dc.l TextOptScr_VsModeItems
		dc.l vdpComm(VRAM_Plane_A_Name_Table+$592,VRAM,WRITE)
		dc.l TextOptScr_SoundTest
		dc.l vdpComm(VRAM_Plane_A_Name_Table+$992,VRAM,WRITE)
off_6858:
		dc.l TextOptScr_SonicAndMiles
		dc.l TextOptScr_SonicAlone
		dc.l TextOptScr_MilesAlone
off_6864:
		dc.l TextOptScr_SonicAndTails
		dc.l TextOptScr_SonicAlone
		dc.l TextOptScr_TailsAlone
off_6870:
		dc.l TextOptScr_AllKindsItems
		dc.l TextOptScr_TeleportOnly
off_6878:
		dc.l TextOptScr_0
; ---------------------------------------------------------------------------

MenuScreen_LevelSelect:
		; Loaded S2's level select plane map here, for the level icon emblem
		lea	(RAM_start).l,a1
		lea	(MapEni_S2LevSel).l,a0
		move.w	#make_art_tile($000,0,0),d0
		bsr.w	Eni_Decomp


		lea	(RAM_start).l,a3
		; Only clear 1600 bytes, in order to preserve the level icon emblem
		move.w	#bytesToWcnt($320*2),d1

	.clearloop:
		move.w	#0,(a3)+
		dbf	d1,.clearloop

		; S3 would remove the one zone name that wasn't cleared: Oil Ocean
		lea	(RAM_start+planeLocH28(3,$15)).l,a3
		move.w	#bytesToWcnt($20),d1

	.loop:
		move.w	#0,(a3)+
		dbf	d1,.loop

		; Build new plane map from LevelSelectText and LevSel_MappingOffsets
		save
		codepage	LEVELSELECT	; This is here so we can use '*' instead of '$1A'

		lea	(RAM_start).l,a3
		lea	(LevelSelectText).l,a1
		lea	(LevSel_MappingOffsets).l,a5
		moveq	#0,d0
		move.w	#$F-1,d1		; This is how many entries there are in LevelSelectText

	.writezone:
		move.w	(a5)+,d3	; Get relative address in plane map to write to
		lea	(a3,d3.w),a2	; Get absolute address
		moveq	#0,d2
		move.b	(a1)+,d2	; Get length of string
		move.w	d2,d3		; Store it

	.writeletter:
		move.b	(a1)+,d0	; Get character from string
		;ori.w	#make_art_tile($000,0,0),d0
		move.w	d0,(a2)+	; Send it to plane map
		dbf	d2,.writeletter	; Loop for entire string

		move.w	#$D,d2		; Maximum length of string
		sub.w	d3,d2		; Get remaining space in string
		bcs.s	.stringfull	; If there is none, skip ahead

	.blankloop:
		move.w	#make_art_tile(' ',0,0),(a2)+	; Full the remaining space with blank characters
		dbf	d2,.blankloop

	.stringfull:
		move.w	#make_art_tile('1',0,0),(a2)	; Write (act) '1'
		lea	$28*2(a2),a2	; Next line
		move.w	#make_art_tile('2',0,0),(a2)	; Write (act) '2'
		dbf	d1,.writezone

		; Assuming the last line was the sound test...
		move.w	#make_art_tile(' ',0,0),(a2)	; Get rid of (act) '2'
		lea	-$28*2(a2),a2	; Go back to (act) '1'
		move.w	#make_art_tile('*',0,0),(a2)	; Replace that with '*'

		restore

		; Send our built plane map to VRAM
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l

		moveq	#palette_line_0,d3
		bsr.w	LevelSelect_DrawSoundNumber

		lea	(RAM_start+($28*$1C*2)).l,a1	; 2240; after the plane map
		lea	(MapEni_S2LevSelIcon).l,a0
		move.w	#make_art_tile($090,0,0),d0
		bsr.w	Eni_Decomp
		bsr.w	LevelSelect_DrawIcon

		clr.w	(Player_mode).w
		clr.w	(Results_screen_2P).w
		clr.b	(Level_started_flag).w
		clr.w	(Anim_Counters).w
		lea	(AniPLC_SONICMILES).l,a2
		jsr	(AnimateTiles_DoAniPLC).l
		moveq	#4,d0
		bsr.w	LoadPalette
		lea	(Normal_palette_line_3).w,a1
		lea	(Target_palette_line_3).w,a2
		moveq	#bytesToLcnt($20),d1

loc_696C:
		move.l	(a1),(a2)+
		clr.l	(a1)+
		dbf	d1,loc_696C
		moveq	#signextendB(mus_DataSelect),d0
		jsr	(Play_Music).l
		move.w	#(30*60)-1,(Demo_timer).w
		clr.w	(Competition_mode).w
		clr.l	(Camera_X_pos).w
		clr.l	(Camera_Y_pos).w
		clr.l	(Save_pointer).w
		move.w	#(1<<8)|1,(Level_select_flag).w
		move.w	#(1<<8)|1,(Debug_cheat_flag).w
		clr.w	(Level_select_cheat_counter).w
		clr.w	(Debug_mode_cheat_counter).w
		move.b	#$16,(V_int_routine).w
		bsr.w	Wait_VSync
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		bsr.w	Pal_FadeFromBlack

LevelSelect_Main:	; routine running during level select
		move.b	#$16,(V_int_routine).w
		bsr.w	Wait_VSync
		move	#$2700,sr
		moveq	#palette_line_0,d3
		bsr.w	LevelSelect_MarkFields
		bsr.w	LevSelControls
		move.w	#palette_line_3,d3
		bsr.w	LevelSelect_MarkFields
		bsr.w	LevelSelect_DrawIcon
		move	#$2300,sr
		lea	(AniPLC_SONICMILES).l,a2
		jsr	(AnimateTiles_DoAniPLC).l
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_start_mask,d0
		bne.s	LevelSelect_PressStart
		bra.w	LevelSelect_Main
; ---------------------------------------------------------------------------

LevelSelect_PressStart:
		move.w	(Level_select_option).w,d0
		add.w	d0,d0
		move.w	LS_Level_Order(pc,d0.w),d0
		bmi.w	LevelSelect_Return	; sound test
		cmpi.w	#$5555,d0		; S&K zones
		beq.w	LevelSelect_Main	; If entry is $5555, don't do anything
		cmpi.w	#$4001,d0			; Is Special Stage 2 selected?
		beq.w	LevelSelect_SpecialStage	; If so, branch
		cmpi.w	#$4000,d0			; Is Special Stage 1 selected?
		bne.w	LevelSelect_StartZone	; If not, branch
		move.b	#$2C,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

LevelSelect_SpecialStage:
		move.b	#$34,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
		move.b	#$10,(Game_mode).w
		clr.w	(Current_zone_and_act).w
		clr.w	(Apparent_zone_and_act).w
		clr.w	(Saved_zone_and_act).w
		move.b	#3,(Life_count).w
		move.b	#3,(Life_count_P2).w
		moveq	#0,d0
		move.w	d0,(Ring_count).w
		move.l	d0,(Timer).w
		move.l	d0,(Score).w
		move.w	d0,(Ring_count_P2).w
		move.l	d0,(Timer_P2).w
		move.l	d0,(Score_P2).w
		move.l	#5000,(Next_extra_life_score).w
		move.l	#5000,(Next_extra_life_score_P2).w
		move.w	(Player_option).w,(Player_mode).w
		rts
; ---------------------------------------------------------------------------
LS_Level_Order:
		dc.w     0	; AIZ act 1
		dc.w     1	; AIZ act 2
		dc.w  $100	; HCZ act 1
		dc.w  $101	; HCZ act 2
		dc.w  $200	; MGZ act 1
		dc.w  $201	; MGZ act 2
		dc.w  $300	; CNZ act 1
		dc.w  $301	; CNZ act 2
		dc.w $5555	; FBZ act 1 (disabled)
		dc.w $5555	; FBZ act 2 (disabled)
		dc.w  $500	; ICZ act 1
		dc.w  $501	; ICZ act 2
		dc.w  $600	; LBZ act 1
		dc.w  $601	; LBZ act 2
		dc.w $5555	; MHZ act 1 (disabled)
		dc.w $5555	; MHZ act 2 (disabled)
		dc.w $5555	; SOZ act 1 (disabled)
		dc.w $5555	; SOZ act 2 (disabled)
		dc.w  $E00	; ALZ
		dc.w  $F00	; BPZ
		dc.w $1000	; DPZ
		dc.w $1100	; CGZ
		dc.w $1200	; EMZ
		dc.w $1300	; 2P VS (Bonus Stage)
		dc.w $5555	; Bonus Stage (disabled)
		dc.w $5555	; Bonus Stage (disabled)
		dc.w $4000	; Special Stage 1
		dc.w $4001	; Special Stage 2
		dc.w $FFFF	; Sound Test
; ---------------------------------------------------------------------------

LevelSelect_Return:
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

LevelSelect_StartZone:
		andi.w	#$3FFF,d0
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		move.w	d0,(Saved_zone_and_act).w
		move.b	#$C,(Game_mode).w
		move.b	#3,(Life_count).w
		move.b	#3,(Life_count_P2).w
		moveq	#0,d0
		move.w	d0,(Ring_count).w
		move.l	d0,(Timer).w
		move.l	d0,(Score).w
		move.w	d0,(Ring_count_P2).w
		move.l	d0,(Timer_P2).w
		move.l	d0,(Score_P2).w
		move.b	d0,(Continue_count).w
		move.l	#5000,(Next_extra_life_score).w
		move.l	#5000,(Next_extra_life_score_P2).w
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_SFX).l
		moveq	#0,d0
		move.w	d0,(Competition_settings).w
		move.w	d0,(Competition_mode).w
		cmpi.b	#$E,(Current_zone).w
		blo.s	locret_6B48
		cmpi.b	#$13,(Current_zone).w
		bhs.s	locret_6B48
		move.w	#1,(Competition_mode).w

locret_6B48:
		rts

; =============== S U B R O U T I N E =======================================


LevSelControls:
		move.b	(Ctrl_1_pressed).w,d1
		andi.b	#button_up_mask|button_down_mask,d1
		bne.s	loc_6B5A	; up/down pressed
		subq.w	#1,(Level_select_repeat).w
		bpl.s	LevSelControls_CheckLR

loc_6B5A:
		move.w	#$B,(Level_select_repeat).w
		move.b	(Ctrl_1_held).w,d1
		andi.b	#button_up_mask|button_down_mask,d1
		beq.s	LevSelControls_CheckLR	; up/down not pressed, check for left & right
		move.w	(Level_select_option).w,d0
		btst	#button_up,d1
		beq.s	loc_6B7A
		subq.w	#1,d0		; decrease by 1
		bcc.s	loc_6B7A	; >= 0?
		moveq	#$1C,d0		; set to $1C

loc_6B7A:
		btst	#button_down,d1
		beq.s	loc_6B8A
		addq.w	#1,d0		; yes, add 1
		cmpi.w	#$1D,d0
		blo.s	loc_6B8A	; smaller than $1D?
		moveq	#0,d0		; if not, set to 0

loc_6B8A:
		move.w	d0,(Level_select_option).w
		rts
; ---------------------------------------------------------------------------

LevSelControls_CheckLR:
		cmpi.w	#$1C,(Level_select_option).w		; are we in the sound test?
		bne.s	LevSelControls_SwitchSide	; no
		move.w	(Sound_test_sound).w,d0
		move.b	(Ctrl_1_pressed).w,d1
		btst	#button_left,d1
		beq.s	loc_6BAC
		subq.b	#1,d0
		bcc.s	loc_6BAC
		moveq	#0,d0

loc_6BAC:
		btst	#button_right,d1
		beq.s	loc_6BBC
		addq.b	#1,d0
		cmpi.w	#$100,d0
		blo.s	loc_6BBC
		moveq	#0,d0

loc_6BBC:
		btst	#button_A,d1
		beq.s	loc_6BCA
		addi.b	#$10,d0
		andi.b	#$FF,d0

loc_6BCA:
		move.w	d0,(Sound_test_sound).w
		btst	#button_C,d1
		beq.s	loc_6BF4
		move.w	(Sound_test_sound).w,d0
		jsr	(Play_Music).l
		lea	(DebugCodeDat).l,a0
		lea	(AllEmeraldsCodeDat).l,a2
		lea	(Debug_cheat_flag).w,a1
		moveq	#1,d2
		bra.w	CheckCheats
; ---------------------------------------------------------------------------

loc_6BF4:
		btst	#button_B,d1
		beq.s	locret_6C02
		moveq	#signextendB(mus_MutePSG),d0
		jsr	(Play_Music).l

locret_6C02:
		rts
; ---------------------------------------------------------------------------

LevSelControls_SwitchSide:
		move.b	(Ctrl_1_pressed).w,d1
		andi.b	#button_left_mask|button_right_mask,d1
		beq.s	loc_6C1A
		move.w	(Level_select_option).w,d0
		move.b	LevelSelect_SwitchTable(pc,d0.w),d0
		move.w	d0,(Level_select_option).w

loc_6C1A:
		bra.s	LevelSelect_PickCharacterNumber
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------
LevelSelect_SwitchTable:
		dc.b $12	; 0
		dc.b $13	; 1
		dc.b $14	; 2
		dc.b $15	; 3
		dc.b $16	; 4
		dc.b $17	; 5
		dc.b $18	; 6
		dc.b $19	; 7
		dc.b $1A	; 8
		dc.b $1B	; 9
		dc.b $1C	; 10
		dc.b $1C	; 11
		dc.b $1C	; 12
		dc.b $1C	; 13
		dc.b $1C	; 14
		dc.b $1C	; 15
		dc.b $1C	; 16
		dc.b $1C	; 17
		dc.b 0		; 18
		dc.b 1		; 19
		dc.b 2		; 20
		dc.b 3		; 21
		dc.b 4		; 22
		dc.b 5		; 23
		dc.b 6		; 24
		dc.b 7		; 25
		dc.b 8		; 26
		dc.b 9		; 27
		dc.b $A		; 28
		dc.b $B		; 29
; ---------------------------------------------------------------------------

LevelSelect_PickCharacterNumber:
		btst	#button_C,(Ctrl_1_pressed).w
		beq.s	loc_6C56
		addq.b	#1,(P1_character).w
		cmpi.b	#3,(P1_character).w
		blo.s	loc_6C56
		move.b	#0,(P1_character).w

loc_6C56:
		btst	#button_C,(Ctrl_2_pressed).w
		beq.s	locret_6C70
		addq.b	#1,(P2_character).w
		cmpi.b	#3,(P2_character).w
		blo.s	locret_6C70
		move.b	#0,(P2_character).w

locret_6C70:
		rts
; End of function LevSelControls


; =============== S U B R O U T I N E =======================================


LevelSelect_MarkFields:
		lea	(RAM_start).l,a4
		lea	(LevSel_MarkTable).l,a5
		lea	(VDP_data_port).l,a6
		moveq	#0,d0
		move.w	(Level_select_option).w,d0
		lsl.w	#2,d0
		lea	(a5,d0.w),a3
		moveq	#0,d0
		move.b	(a3),d0
		mulu.w	#$28*2,d0
		moveq	#0,d1
		move.b	1(a3),d1
		add.w	d1,d0
		lea	(a4,d0.w),a1
		moveq	#0,d1
		move.b	(a3),d1
		lsl.w	#7,d1
		add.b	1(a3),d1
		addi.w	#VRAM_Plane_A_Name_Table,d1
		lsl.l	#2,d1
		lsr.w	#2,d1
		ori.w	#vdpComm($0000,VRAM,WRITE)>>16,d1
		swap	d1
		move.l	d1,VDP_control_port-VDP_data_port(a6)
		moveq	#$F-1,d2

loc_6CC2:
		move.w	(a1)+,d0
		add.w	d3,d0
		move.w	d0,(a6)
		dbf	d2,loc_6CC2
		addq.w	#2,a3
		moveq	#0,d0
		move.b	(a3),d0
		beq.s	loc_6D06
		mulu.w	#$50,d0
		moveq	#0,d1
		move.b	1(a3),d1
		add.w	d1,d0
		lea	(a4,d0.w),a1
		moveq	#0,d1
		move.b	(a3),d1
		lsl.w	#7,d1
		add.b	1(a3),d1
		addi.w	#VRAM_Plane_A_Name_Table,d1
		lsl.l	#2,d1
		lsr.w	#2,d1
		ori.w	#vdpComm($0000,VRAM,WRITE)>>16,d1
		swap	d1
		move.l	d1,VDP_control_port-VDP_data_port(a6)
		move.w	(a1)+,d0
		add.w	d3,d0
		move.w	d0,(a6)

loc_6D06:
		cmpi.w	#$1C,(Level_select_option).w
		bne.s	LevelSelect_DrawCharacterNumber
		bra.w	LevelSelect_DrawSoundNumber
; ---------------------------------------------------------------------------

LevelSelect_DrawCharacterNumber:
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$1B8,VRAM,WRITE),(VDP_control_port).l
		move.b	(P1_character).w,d0
		bsr.s	LevelSelect_DrawContinued
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$1C0,VRAM,WRITE),(VDP_control_port).l
		move.b	(P2_character).w,d0
		bra.s	LevelSelect_DrawContinued
; End of function LevelSelect_MarkFields


; =============== S U B R O U T I N E =======================================


LevelSelect_DrawSoundNumber:
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$846,VRAM,WRITE),(VDP_control_port).l
		move.w	(Sound_test_sound).w,d0

LevelSelect_DrawContinued:
		move.b	d0,d2
		lsr.b	#4,d0
		bsr.s	sub_6D48
		move.b	d2,d0

sub_6D48:
		andi.w	#$F,d0
		cmpi.b	#$A,d0
		blo.s	loc_6D56
		addi.b	#4,d0

loc_6D56:
		addi.b	#$10,d0
		add.w	d3,d0
		move.w	d0,(a6)
		rts
; End of function LevelSelect_DrawSoundNumber


; =============== S U B R O U T I N E =======================================


LevelSelect_DrawIcon:
		move.w	(Level_select_option).w,d0
		lea	(LevSel_IconTable).l,a3
		lea	(a3,d0.w),a3
		lea	(RAM_start+$8C0).l,a1
		moveq	#0,d0
		move.b	(a3),d0
		lsl.w	#3,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	(a1,d0.w),a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$B36,VRAM,WRITE),d0
		moveq	#4-1,d1
		moveq	#3-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(Pal_S2LevelIcons).l,a1
		moveq	#0,d0
		move.b	(a3),d0
		lsl.w	#5,d0
		lea	(a1,d0.w),a1
		lea	(Normal_palette_line_3).w,a2
		moveq	#bytesToLcnt($20),d1

loc_6DAA:
		move.l	(a1)+,(a2)+
		dbf	d1,loc_6DAA
		rts
; End of function LevelSelect_DrawIcon

; ---------------------------------------------------------------------------
LevSel_IconTable:
		dc.b    0,   0
		dc.b    7,   7
		dc.b    8,   8
		dc.b    6,   6
		dc.b    2,   2
		dc.b    5,   5
		dc.b    4,   4
		dc.b    1,   1
		dc.b    9,   9
		dc.b   $A,  $A
		dc.b    3,   3
		dc.b   $B,  $B
		dc.b   $B,  $B
		dc.b   $C,  $C
		dc.b   $E,   0
LevSel_MarkTable:	; 4 bytes per level select entry
; line primary, 2*column ($E fields), line secondary, 2*column secondary (1 field)
		dc.b    1,   6,   1, $24
		dc.b    1,   6,   2, $24
		dc.b    4,   6,   4, $24
		dc.b    4,   6,   5, $24
		dc.b    7,   6,   7, $24
		dc.b    7,   6,   8, $24
		dc.b   $A,   6,  $A, $24
		dc.b   $A,   6,  $B, $24
		dc.b   $D,   6,  $D, $24
		dc.b   $D,   6,  $E, $24
		dc.b  $10,   6, $10, $24
		dc.b  $10,   6, $11, $24
		dc.b  $13,   6, $13, $24
		dc.b  $13,   6, $14, $24
		dc.b  $16,   6, $16, $24
		dc.b  $16,   6, $17, $24
		dc.b  $19,   6, $19, $24
		dc.b  $19,   6, $1A, $24
; --- second column ---
		dc.b    1, $2C,   1, $4A
		dc.b    1, $2C,   2, $4A
		dc.b    4, $2C,   4, $4A
		dc.b    4, $2C,   5, $4A
		dc.b    7, $2C,   7, $4A
		dc.b    7, $2C,   8, $4A
		dc.b   $A, $2C,  $A, $4A
		dc.b   $A, $2C,  $B, $4A
		dc.b   $D, $2C,  $D, $4A
		dc.b   $D, $2C,  $E, $4A
		dc.b  $10, $2C, $10, $4A
LevSel_MappingOffsets:
		dc.w planeLocH28(3,1)
		dc.w planeLocH28(3,4)
		dc.w planeLocH28(3,7)
		dc.w planeLocH28(3,$A)
		dc.w planeLocH28(3,$D)
		dc.w planeLocH28(3,$10)
		dc.w planeLocH28(3,$13)
		dc.w planeLocH28(3,$16)
		dc.w planeLocH28(3,$19)
		dc.w planeLocH28($16,1)
		dc.w planeLocH28($16,4)
		dc.w planeLocH28($16,7)
		dc.w planeLocH28($16,$A)
		dc.w planeLocH28($16,$D)
		dc.w planeLocH28($16,$10)
		dc.w planeLocH28($16,$13)

; =============== S U B R O U T I N E =======================================


CheckCheats:
		move.w	(Level_select_cheat_counter).w,d0
		adda.w	d0,a0
		move.w	(Sound_test_sound).w,d0
		cmp.b	(a0),d0
		bne.s	loc_6E88
		addq.w	#1,(Level_select_cheat_counter).w
		tst.b	1(a0)
		bne.s	loc_6E8E
		move.w	#(1<<8)|1,(a1)
		moveq	#signextendB(sfx_RingRight),d0
		jsr	(Play_SFX).l

loc_6E88:
		move.w	#0,(Level_select_cheat_counter).w

loc_6E8E:
		move.w	(Debug_mode_cheat_counter).w,d0
		adda.w	d0,a2
		move.w	(Sound_test_sound).w,d0
		cmp.b	(a2),d0
		bne.s	loc_6EC8
		addq.w	#1,(Debug_mode_cheat_counter).w
		tst.b	1(a2)
		bne.s	locret_6ECE
		tst.w	d2
		bne.s	loc_6EBA
		move.b	#$F,(Continue_count).w
		moveq	#signextendB(mus_Continue),d0
		jsr	(Play_Music).l
		bra.s	loc_6EC8
; ---------------------------------------------------------------------------

loc_6EBA:
		move.w	#7,(Chaos_emerald_count).w
		moveq	#signextendB(mus_Emerald),d0
		jsr	(Play_Music).l

loc_6EC8:
		move.w	#0,(Debug_mode_cheat_counter).w

locret_6ECE:
		rts
; End of function CheckCheats

; ---------------------------------------------------------------------------
S2LevelSelectCodeDat:
		dc.b  $19, $65,   9, $17,   0
S2ContinueCodeDat:
		dc.b    1,   1,   2,   4,   0
DebugCodeDat:
		dc.b    1,   3,   5,   7,   0
AllEmeraldsCodeDat:
		dc.b    2,   4,   5,   6,   0
TextOptScr_PlayerSelect:
		levselstr "* PLAYER SELECT *"
TextOptScr_SonicAndMiles:
		levselstr "SONIC AND MILES"
TextOptScr_SonicAndTails:
		levselstr "SONIC AND TAILS"
TextOptScr_SonicAlone:
		levselstr "SONIC ALONE    "
TextOptScr_MilesAlone:
		levselstr "MILES ALONE    "
TextOptScr_TailsAlone:
		levselstr "TAILS ALONE    "
TextOptScr_VsModeItems:
		levselstr "* VS MODE ITEMS *"
TextOptScr_AllKindsItems:
		levselstr "ALL KINDS ITEMS"
TextOptScr_TeleportOnly:
		levselstr "TELEPORT ONLY  "
TextOptScr_SoundTest:
		levselstr "*  SOUND TEST   *"
TextOptScr_0:
		levselstr "      00       "
Text2P_EmeraldHill:
		levselstr "EMERALD HILL"
Text2P_MysticCave:
		levselstr " MYSTIC CAVE"
Text2P_CasinoNight:
		levselstr "CASINO NIGHT"
Text2P_SpecialStage:
		levselstr "SPECIAL STAGE"
Text2P_Special:
		levselstr "   SPECIAL  "
Text2P_Zone:
		levselstr "ZONE "
Text2P_Stage:
		levselstr "STAGE"
Text2P_GameOver:
		levselstr "GAME OVER"
Text2P_TimeOver:
		levselstr "TIME OVER"
Text2P_NoGame:
		levselstr "NO GAME"
Text2P_Tied:
		levselstr "TIED"
Text2P_1P:
		levselstr " 1P"
Text2P_2P:
		levselstr " 2P"
Text2P_Blank:
		levselstr "    "
LevelSelectText:
		levselstr "ANGEL ISLAND"
		levselstr "HYDROCITY"
		levselstr "MARBLE GARDEN"
		levselstr "CARNIVAL NIGHT"
		levselstr "FLYING BATTERY"
		levselstr "ICECAP"
		levselstr "LAUNCH BASE"
		levselstr "MUSHROOM VALLEY"
		levselstr "SANDOPOLIS"
		levselstr "2P VS"
		levselstr "2P VS"
		levselstr "2P VS"
		levselstr "BONUS"
		levselstr "SPECIAL STAGE"
		levselstr "SOUND TEST  *"
		even
Pal_S2LevelIcons:
		binclude "General/S2Menu/Palettes/Level Select Icons.bin"
		even
MapEni_S2LevSel2P:
		binclude "General/S2Menu/Enigma Map/Level Select 2P.bin"
		even
MapEni_S2Options:
		binclude "General/S2Menu/Enigma Map/Options Screen.bin"
		even
MapEni_S2LevSel:
		binclude "General/S2Menu/Enigma Map/Level Select.bin"
		even
MapEni_S2LevSelIcon:
		binclude "General/S2Menu/Enigma Map/Level Select Icons.bin"
		even
AniPLC_SONICMILES: zoneanimstart
	; Sonic/Miles animated background
	zoneanimdecl  -1, ArtUnc_SONICMILES, $001,  6, $A
		dc.b    0, $C7
		dc.b   $A,   5
		dc.b  $14,   5
		dc.b  $1E, $C7
		dc.b  $14,   5
		dc.b   $A,   5
		even
	zoneanimend
