SpecialStage:
		moveq	#signextendB(mus_Stop),d0
		bsr.w	Play_Music
		clr.w	(Kos_decomp_queue_count).w
		clearRAM	Kos_decomp_stored_registers,$6C
		bsr.w	Clear_Nem_Queue
		bsr.w	Pal_FadeToWhite
		move	#$2700,sr
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B00,(a6)
		move.w	#$8720,(a6)
		clr.b	(Water_full_screen_flag).w
		move.w	#$8C81,(a6)
		bsr.w	Clear_DisplayData
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clearRAM	Oscillating_table,(AIZ_vine_angle-Oscillating_table)
		clearRAM	Stat_table,$100
		moveq	#0,d0
		move.l	d0,(LRZ_rocks_addr_front).w
		move.l	d0,(LRZ_rocks_addr_back).w
		jsr	(Init_SpriteTable).l
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		lea	(Pal_SStage_Main).l,a1
		lea	(Target_palette).w,a2
		move.w	#bytesToWcnt($80),d0

- ;loc_8284:
		move.w	(a1)+,(a2)+
		dbf	d0,- ;loc_8284
		cmpi.w	#3,(Player_mode).w
		bne.s	+ ;loc_82A6
		lea	(Pal_SStage_Knux).l,a1
		lea	(Target_palette+$10).w,a2
		move.w	#bytesToWcnt($10),d0

- ;loc_82A0:
		move.w	(a1)+,(a2)+
		dbf	d0,- ;loc_82A0

+ ;loc_82A6:
		move.l	#vdpComm(tiles_to_bytes($000),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageLayout).l,a0
		bsr.w	Nem_Decomp
		bsr.w	sub_85B0
		lea	(RAM_start+$5500).l,a1
		lea	(MapEni_SStageLayout).l,a0
		move.w	#make_art_tile($000,0,0),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start+$5500).l,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l
		move.l	#vdpComm(tiles_to_bytes($680),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageSphere).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($5A7),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageRing).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($59B),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageBG).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($55F),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_GetBlueSpheres).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($6F8),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_GBSArrow).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($781),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageDigits).l,a0
		bsr.w	Nem_Decomp
		lea	(ArtNem_SStageDigits).l,a0
		lea	(H_scroll_buffer+$20).w,a4
		bsr.w	Nem_Decomp_To_RAM
		move.l	#vdpComm(tiles_to_bytes($589),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageIcons).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($7A0),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageShadow).l,a0
		bsr.w	Nem_Decomp
		lea	(MapUnc_SSNum000).l,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$084,VRAM,WRITE),d0
		moveq	#8-1,d1
		moveq	#3-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(MapUnc_SSNum000).l,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$0BC,VRAM,WRITE),d0
		moveq	#8-1,d1
		moveq	#3-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(RAM_start).l,a1
		lea	(MapEni_SStageBG).l,a0
		move.w	#make_art_tile($59B,2,0),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#$40-1,d1
		moveq	#$20-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(SStageKos_PerspectiveMaps).l,a0
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
		bsr.w	sub_9EA0
		bsr.w	Load_SSSprite_Mappings
		clr.b	(Level_started_flag).w
		move.b	#$FF,(Special_stage_sphere_HUD_flag).w
		move.b	#$80,(Special_stage_extra_life_flags).w
		move.w	#$1000,(Special_stage_rate).w
		move.w	#30*60,(Special_stage_rate_timer).w
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	+ ;loc_842C
		move.w	#45*60,(Special_stage_rate_timer).w

+ ;loc_842C:
		move.w	#0,(Camera_X_pos_copy).w
		move.w	#0,(Camera_Y_pos_copy).w
		move.w	#-1,(Screen_Y_wrap_value).w
		move.l	#Obj_SStage_8FAA,(Player_1).w
		tst.w	(Player_mode).w
		bne.s	+ ;loc_8454
		move.l	#Obj_SStage_9212,(Player_2).w

+ ;loc_8454:
		move.l	#Obj_SStage_8DF8,(Reserved_object_3).w
		move.l	#Obj_SStage_8E40,(Dynamic_object_RAM).w
		jsr	(Process_Sprites).l
		bsr.w	Animate_SSRings
		bsr.w	Touch_SSSprites
		jsr	(Render_Sprites).l
		jsr	Draw_SSSprites(pc)
		bsr.w	sub_9D5E
		move.b	#1,(Special_stage_fade_timer).w
		move.b	#$1C,(V_int_routine).w
		bsr.w	Wait_VSync
		move.b	#0,(Special_stage_fade_timer).w
		move.w	#$8C89,(VDP_control_port).l
		move.w	#30*60,(Demo_timer).w
		jsr	(GetDemoPtr).l
		moveq	#signextendB(mus_SpecialStage),d0
		bsr.w	Play_Music
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		bsr.w	Pal_FadeFromWhite

loc_84C2:
		bsr.w	Pause_Game
		move.b	#$1C,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		addq.w	#1,(Level_frame_counter).w
		jsr	(Demo_PlayRecord).l
		jsr	(Process_Sprites).l
		bsr.w	Animate_SSRings
		bsr.w	Touch_SSSprites
		jsr	(Render_Sprites).l
		jsr	Draw_SSSprites(pc)
		bsr.w	Draw_SSShadows
		bsr.w	sub_9D5E
		bsr.w	sub_9B62
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		tst.w	(Demo_mode_flag).w
		beq.s	+ ;loc_851A
		tst.w	(Demo_timer).w
		beq.s	++ ;loc_8522

+ ;loc_851A:
		cmpi.b	#$34,(Game_mode).w
		beq.s	loc_84C2

+ ;loc_8522:
		tst.w	(Demo_mode_flag).w
		beq.s	+ ;loc_852E
		move.b	#0,(Game_mode).w

+ ;loc_852E:
		move.w	#60,(Demo_timer).w
		move.w	#$40-1,(Palette_fade_info).w
		clr.w	(Pal_fade_delay).w

loc_853E:
		move.b	#$1C,(V_int_routine).w
		bsr.w	Wait_VSync
		jsr	(Demo_PlayRecord).l
		jsr	(Process_Sprites).l
		bsr.w	Animate_SSRings
		bsr.w	Touch_SSSprites
		jsr	(Render_Sprites).l
		jsr	Draw_SSSprites(pc)
		bsr.w	sub_9D5E
		bsr.w	sub_9B62
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		subq.w	#1,(Pal_fade_delay).w
		bpl.s	+ ;loc_8588
		move.w	#2,(Pal_fade_delay).w
		bsr.w	Pal_ToWhite

+ ;loc_8588:
		tst.w	(Demo_timer).w
		bne.s	loc_853E
		rts
; ---------------------------------------------------------------------------
SSLayoutOffs_RAM:
		dc.l RAM_start+$0000
		dc.l RAM_start+$0408
		dc.l RAM_start+$0810
		dc.l RAM_start+$0C18
		dc.l RAM_start+$1020
		dc.l RAM_start+$1428
		dc.l RAM_start+$1830
		dc.l RAM_start+$1C38

; =============== S U B R O U T I N E =======================================


sub_85B0:
		tst.b	(Blue_spheres_stage_flag).w
		bne.w	loc_86C8
		lea	(SSCompressedLayoutPtrs).l,a0
		movea.l	(a0),a0
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
		lea	(SStageLayoutPtrs).l,a2
		move.b	(Chaos_emerald_count).w,d3
		tst.w	(SK_alone_flag).w
		beq.s	+ ;loc_85E4
		lea	(SSLayoutOffs_RAM).l,a2
		moveq	#0,d2
		bra.s	++ ;loc_85F4
; ---------------------------------------------------------------------------

+ ;loc_85E4:
		move.b	(SK_special_stage_flag).w,d2
		beq.s	+ ;loc_85F4
		lea	(SSLayoutOffs_RAM).l,a2
		move.b	(Super_emerald_count).w,d3

+ ;loc_85F4:
		tst.b	(Debug_cheat_flag).w
		beq.s	+ ;loc_8606
		move.w	(Sound_test_sound).w,d0
		btst	#button_A,(Ctrl_1).w
		bne.s	++ ;loc_8630

+ ;loc_8606:
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
		cmpi.b	#7,d3
		bhs.s	+ ;loc_8630
		moveq	#5,d1
		lea	(Collected_emeralds_array).w,a1
		add.b	d2,d2

- ;loc_861A:
		cmp.b	(a1,d0.w),d2
		beq.s	+ ;loc_8630
		addq.w	#1,d0
		cmpi.w	#7,d0
		blo.s	- ;loc_861A
		moveq	#0,d0
		dbf	d1,- ;loc_861A
		moveq	#7,d0

+ ;loc_8630:
		andi.w	#7,d0
		move.b	d0,(Current_special_stage).w
		move.w	d0,d1
		lsl.w	#2,d0
		movea.l	(a2,d0.w),a2
	if Sonic3_Complete=0
		tst.w	(SK_alone_flag).w
		bne.s	+ ;loc_8652
		tst.b	(SK_special_stage_flag).w
		bne.s	+ ;loc_8652
		adda.l	#LockOnROM_Start,a2

+ ;loc_8652:
	endif
		lea	(SStage_layout_buffer).w,a3
		moveq	#0,d2
		move.w	#bytesToLcnt($100),d0

- ;loc_865C:
		move.l	d2,(a3)+
		dbf	d0,- ;loc_865C
		move.w	#bytesToLcnt($400),d0

- ;loc_8666:
		move.l	(a2)+,(a3)+
		dbf	d0,- ;loc_8666
		move.w	#bytesToLcnt($100),d0

- ;loc_8670:
		move.l	d2,(a3)+
		dbf	d0,- ;loc_8670
		move.w	(a2)+,(Special_stage_angle).w
		move.w	(a2)+,(Special_stage_X_pos).w
		move.w	(a2)+,(Special_stage_Y_pos).w
		move.w	(a2)+,(Special_stage_rings_left).w
		lsl.w	#4,d1
		lea	(SS_Pal_Map_Ptrs).l,a1
		lea	(Target_palette).w,a2
		movea.l	4(a1,d1.w),a1
		tst.w	(SK_alone_flag).w
		bne.s	+ ;loc_86A2
		tst.b	(SK_special_stage_flag).w
		beq.s	++ ;loc_86A6

+ ;loc_86A2:
		lea	$130(a1),a1

+ ;loc_86A6:
		move.l	a1,(Special_stage_palette_addr).w
		move.l	(a1)+,$70(a2)
		move.l	(a1)+,$74(a2)
		move.l	(a1)+,$78(a2)
		move.l	(a1)+,$7C(a2)
		move.l	$10(a1),$50(a2)
		move.w	$14(a1),$54(a2)
		rts
; ---------------------------------------------------------------------------

loc_86C8:
		lea	(SSCompressedLayoutPtrs).l,a0
		movea.l	4(a0),a0
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
		lea	(SStage_layout_buffer).w,a3
		moveq	#0,d2
		move.w	#bytesToLcnt($600),d0

- ;loc_86E6:
		move.l	d2,(a3)+
		dbf	d0,- ;loc_86E6
		move.b	#0,(Current_special_stage).w
		move.w	#$4000,(Special_stage_angle).w
		move.w	#$1000,(Special_stage_X_pos).w
		move.w	#$300,(Special_stage_Y_pos).w
		clr.w	(Special_stage_rings_left).w
		clr.w	(Blue_spheres_difficulty).w
		lea	(Blue_spheres_current_stage).w,a4
		lea	word_87BA(pc),a1
		moveq	#4-1,d7

- ;loc_8716:
		lea	(RAM_start).l,a2
		move.b	(a4)+,d0
		andi.w	#$7F,d0
		moveq	#0,d1
		move.b	(a2,d0.w),d1
		add.w	d1,(Special_stage_rings_left).w
		lea	$80(a2),a2
		moveq	#0,d1
		move.b	(a2,d0.w),d1
		add.w	d1,(Blue_spheres_difficulty).w
		lea	$80(a2),a2
		lsl.w	#8,d0
		lea	(a2,d0.w),a2
		move.w	(a1)+,d3
		move.w	(a1)+,d4
		move.w	(a1)+,d5
		move.w	(a1)+,d0
		lea	(SStage_layout_buffer+$100).w,a3
		lea	(a3,d0.w),a3
		moveq	#$F,d0

- ;loc_8756:
		move.w	d4,d2
		moveq	#$10-1,d1

- ;loc_875A:
		move.b	(a2,d2.w),(a3)+
		add.w	d3,d2
		dbf	d1,- ;loc_875A
		lea	$10(a3),a3
		add.w	d5,d4
		dbf	d0,-- ;loc_8756
		dbf	d7,--- ;loc_8716
		moveq	#0,d1
		move.b	(Blue_spheres_current_stage+2).w,d1
		move.w	d1,d2
		andi.w	#7,d1
		lsl.w	#4,d1
		lea	(SS_Pal_Map_Ptrs).l,a1
		lea	(Target_palette).w,a2
		movea.l	4(a1,d1.w),a1
		andi.w	#8,d2
		beq.s	+ ;loc_8798
		lea	$130(a1),a1

+ ;loc_8798:
		move.l	a1,(Special_stage_palette_addr).w
		move.l	(a1)+,$70(a2)
		move.l	(a1)+,$74(a2)
		move.l	(a1)+,$78(a2)
		move.l	(a1)+,$7C(a2)
		move.l	$10(a1),$50(a2)
		move.w	$14(a1),$54(a2)
		rts
; End of function sub_85B0

; ---------------------------------------------------------------------------
word_87BA:
		dc.w      1
		dc.w      0
		dc.w    $10
		dc.w      0
		dc.w  $FFFF
		dc.w     $F
		dc.w    $10
		dc.w    $10
		dc.w      1
		dc.w    $F0
		dc.w  $FFF0
		dc.w   $200
		dc.w  $FFFF
		dc.w    $FF
		dc.w  $FFF0
		dc.w   $210

; =============== S U B R O U T I N E =======================================


Rotate_SSPal:
		tst.b	(Special_stage_fade_timer).w
		bne.s	locret_8818
		move.w	(Special_stage_anim_frame).w,d0
		cmpi.w	#$10,d0
		blo.s	+ ;loc_87F8
		tst.b	(Special_stage_turning).w
		bpl.s	locret_8818
		move.b	(Special_stage_palette_frame).w,d0
		andi.w	#$F,d0

+ ;loc_87F8:
		andi.w	#$E,d0
		neg.w	d0
		addi.w	#$10,d0
		movea.l	(Special_stage_palette_addr).w,a1
		lea	(a1,d0.w),a1
		lea	(Normal_palette_line_4+$10).w,a2
		move.w	#bytesToWcnt($10),d0

- ;loc_8812:
		move.w	(a1)+,(a2)+
		dbf	d0,- ;loc_8812

locret_8818:
		rts
; End of function Rotate_SSPal


; =============== S U B R O U T I N E =======================================


Update_SSMap:
		lea	(VDP_data_port).l,a6
		lea	(SS_Pal_Map_Ptrs).l,a1
		move.w	(Special_stage_anim_frame).w,d0
		cmp.b	(Special_stage_prev_anim_frame).w,d0
		beq.s	+ ;loc_8876
		move.b	d0,(Special_stage_prev_anim_frame).w
		lsl.w	#3,d0
		movea.l	(a1,d0.w),a3
		lea	$10E(a3),a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$19E,VRAM,WRITE),(VDP_control_port).l	; VRAM write $C19E
		moveq	#$A-1,d1

- ;loc_884A:
		move.w	(a1)+,(a6)
		dbf	d1,- ;loc_884A
		lea	$140(a3),a3
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$200,VRAM,WRITE),d0		; VRAM write $C200
		moveq	#$28-1,d1
		moveq	#$18-1,d2
		move.l	#$80<<16,d4

- ;loc_8864:
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.w	d1,d3

- ;loc_886A:
		move.w	(a3)+,(a6)
		dbf	d3,- ;loc_886A
		add.l	d4,d0
		dbf	d2,-- ;loc_8864

+ ;loc_8876:
		tst.b	(Special_stage_sphere_HUD_flag).w
		beq.s	loc_8890
		move.b	#0,(Special_stage_sphere_HUD_flag).w
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$086,VRAM,WRITE),d0	; VRAM write $C086
		move.w	(Special_stage_spheres_left).w,d1
		bsr.w	Draw_SSNum

loc_8890:
		tst.b	(Special_stage_extra_life_flags).w
		bpl.s	locret_88B4
		bclr	#7,(Special_stage_extra_life_flags).w
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$0BE,VRAM,WRITE),d0	; VRAM write $C0BE
		move.w	(Special_stage_ring_count).w,d1
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	+ ;loc_88B0
		move.w	(Special_stage_rings_left).w,d1

+ ;loc_88B0:
		bsr.w	Draw_SSNum

locret_88B4:
		rts
; End of function Update_SSMap

; ---------------------------------------------------------------------------
SS_Pal_Map_Ptrs:
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_2
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_2
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_3
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_3
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_4
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_4
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_5
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_5
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_6
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_6
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_7
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_7
		dc.l RAM_start+$5500
		dc.l Pal_SStage_3_8
		dc.l RAM_start+$5DC0
		dc.l Pal_SStage_3_8
		dc.l RAM_start+$9B00
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$9240
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$8980
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$80C0
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$7800
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$6F40
		dc.l Pal_SStage_3_1
		dc.l RAM_start+$6680
		dc.l Pal_SStage_3_1
Pal_SStage_Main:
		binclude "General/Special Stage/Palettes/Main.bin"
		even
Pal_SStage_Knux:
		binclude "General/Special Stage/Palettes/Knux Patch.bin"
		even
Pal_SStage_3_1:
		binclude "General/Special Stage/Palettes/3-1.bin"
		even
Pal_SStage_3_2:
		binclude "General/Special Stage/Palettes/3-2.bin"
		even
Pal_SStage_3_3:
		binclude "General/Special Stage/Palettes/3-3.bin"
		even
Pal_SStage_3_4:
		binclude "General/Special Stage/Palettes/3-4.bin"
		even
Pal_SStage_3_5:
		binclude "General/Special Stage/Palettes/3-5.bin"
		even
Pal_SStage_3_6:
		binclude "General/Special Stage/Palettes/3-6.bin"
		even
Pal_SStage_3_7:
		binclude "General/Special Stage/Palettes/3-7.bin"
		even
Pal_SStage_3_8:
		binclude "General/Special Stage/Palettes/3-8.bin"
		even
Pal_SStage_K_1:
		binclude "General/Special Stage/Palettes/K-1.bin"
		even
Pal_SStage_K_2:
		binclude "General/Special Stage/Palettes/K-2.bin"
		even
Pal_SStage_K_3:
		binclude "General/Special Stage/Palettes/K-3.bin"
		even
Pal_SStage_K_4:
		binclude "General/Special Stage/Palettes/K-4.bin"
		even
Pal_SStage_K_5:
		binclude "General/Special Stage/Palettes/K-5.bin"
		even
Pal_SStage_K_6:
		binclude "General/Special Stage/Palettes/K-6.bin"
		even
Pal_SStage_K_7:
		binclude "General/Special Stage/Palettes/K-7.bin"
		even
Pal_SStage_K_8:
		binclude "General/Special Stage/Palettes/K-8.bin"
		even

; =============== S U B R O U T I N E =======================================


Draw_SSNum:
		lea	(SSNum_Precision).l,a2
		moveq	#3-1,d6
		lea	MapUnc_SSNum(pc),a1

- ;loc_8C6A:
		moveq	#0,d2
		move.w	(a2)+,d3

loc_8C6E:
		sub.w	d3,d1
		bcs.s	+ ;loc_8C76
		addq.w	#1,d2
		bra.s	loc_8C6E
; ---------------------------------------------------------------------------

+ ;loc_8C76:
		add.w	d3,d1
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		add.w	d2,d2
		add.w	d2,d2
		lea	(a1,d2.w),a3
		move.l	(a3),(a6)
		addi.l	#$80<<16,d0
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.l	$28(a3),(a6)
		addi.l	#$80<<16,d0
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.l	$50(a3),(a6)
		subi.l	#$FC<<16,d0
		dbf	d6,- ;loc_8C6A
		rts
; End of function Draw_SSNum

; ---------------------------------------------------------------------------
SSNum_Precision:
		dc.w 100
		dc.w 10
		dc.w 1
MapUnc_SSNum:
		binclude "General/Special Stage/Uncompressed Map/HUD Numbers.bin"
		even
MapUnc_SSNum000:
		binclude "General/Special Stage/Uncompressed Map/HUD.bin"
		even

; =============== S U B R O U T I N E =======================================

; Create_New_Sprite2:
AllocateObjectAfterCurrent_SpecialStage:
		movea.l	a0,a1
		move.w	#Object_RAM_end-object_size,d0
		sub.w	a0,d0
		lsr.w	#6,d0
		move.b	.lookup(pc,d0.w),d0
		bmi.s	.return

- ;.loop:
		lea	next_object(a1),a1
		tst.l	(a1)
		dbeq	d0,- ;.loop

.return:
		rts

.lookup:
.a		set	Object_RAM-object_size*2	; Oddly, this does too many object slots.
.b		set	Object_RAM_end-object_size
.c		set	.b				; begin from bottom of array and decrease backwards
		; There's a mistake here: this division should be rounded up,
		; otherwise the first object slot might not get an entry.
		; In this case, the aforementioned surplus entries counteract this problem.
		rept	(.b-.a)/$40			; repeat for all slots, minus exception
.c		set	.c-$40				; address for previous $40 (also skip last part)
		dc.b	(.b-.c-1)/object_size-1		; write possible slots according to object_size division + hack + dbf hack
		endm
		even
; End of function AllocateObjectAfterCurrent_SpecialStage

; ---------------------------------------------------------------------------

Obj_SStage_8DF8:
		move.b	#$80,width_pixels(a0)
		move.b	#$80,height_pixels(a0)
		move.w	#0,priority(a0)
		move.l	#Map_SSIcons,mappings(a0)
		move.w	#make_art_tile($589,2,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$94,y_pos(a0)
		move.l	#loc_8E2A,(a0)

loc_8E2A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_SSIcons:
		include "General/Special Stage/Map - Icons.asm"
; ---------------------------------------------------------------------------

Obj_SStage_8E40:
		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
		bne.w	loc_8E5C
		move.l	#loc_8E5C,(a1)
		bset	#0,status(a1)
		move.b	#1,mapping_frame(a1)

loc_8E5C:
		move.b	#$80,width_pixels(a0)
		move.b	#$80,height_pixels(a0)
		move.w	#0,priority(a0)
		move.l	#Map_GetBlueSpheres,mappings(a0)
		move.w	#make_art_tile($55F,1,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$E8,y_pos(a0)
		move.w	#3*60,$32(a0)
		move.l	#loc_8E94,(a0)

loc_8E94:
		tst.w	$32(a0)
		beq.s	+ ;loc_8EA4
		subq.w	#1,$32(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_8EA4:
		cmpi.w	#$C0,$30(a0)
		blo.s	+ ;loc_8ECA
		move.l	#loc_8EEC,(a0)
		addq.b	#2,mapping_frame(a0)
		tst.w	(Special_stage_velocity).w
		bne.s	++ ;loc_8ED0
		move.b	#1,(Special_stage_advancing).w
		move.b	#1,(Special_stage_started).w
		bra.s	++ ;loc_8ED0
; ---------------------------------------------------------------------------

+ ;loc_8ECA:
		addi.w	#$10,$30(a0)

+ ;loc_8ED0:
		move.w	$30(a0),d0
		btst	#0,status(a0)
		bne.s	+ ;loc_8EDE
		neg.w	d0

+ ;loc_8EDE:
		addi.w	#$120,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8EEC:
		tst.w	(Special_stage_rings_left).w
		beq.s	+ ;loc_8EF4
		rts
; ---------------------------------------------------------------------------

+ ;loc_8EF4:
		subi.w	#$10,$30(a0)
		bne.s	+ ;loc_8F08
		move.l	#loc_8F24,(a0)
		move.w	#180,$32(a0)

+ ;loc_8F08:
		move.w	$30(a0),d0
		btst	#0,status(a0)
		bne.s	+ ;loc_8F16
		neg.w	d0

+ ;loc_8F16:
		addi.w	#$120,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8F24:
		tst.w	$32(a0)
		beq.s	+ ;loc_8F34
		subq.w	#1,$32(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_8F34:
		cmpi.w	#$C0,$30(a0)
		bhs.s	+ ;loc_8F42
		addi.w	#$10,$30(a0)

+ ;loc_8F42:
		move.w	$30(a0),d0
		btst	#0,status(a0)
		bne.s	+ ;loc_8F50
		neg.w	d0

+ ;loc_8F50:
		addi.w	#$120,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_GetBlueSpheres:
		include "General/Special Stage/Map - Get Blue Spheres.asm"
; ---------------------------------------------------------------------------

Obj_SStage_8FAA:
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.l	#Map_SStageSonic,mappings(a0)
		move.w	#make_art_tile($7D4,0,1),art_tile(a0)
		cmpi.w	#2,(Player_mode).w
		bne.s	+ ;loc_8FFA
		move.l	#Map_SStageTails,mappings(a0)
		move.w	#make_art_tile($7EB,1,1),art_tile(a0)
		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
		bne.w	+ ;loc_8FFA
		move.l	#Obj_SStage_9444,(a1)
		move.w	a0,$3E(a1)

+ ;loc_8FFA:
		cmpi.w	#3,(Player_mode).w
		bne.s	+ ;loc_9010
		move.l	#Map_SStageKnuckles,mappings(a0)
		move.w	#make_art_tile($7D4,0,1),art_tile(a0)

+ ;loc_9010:
		move.w	#$A0,$30(a0)
		move.w	#$70,$32(a0)
		move.w	#0,$34(a0)
		move.w	#$F800,$36(a0)
		move.w	#0,$38(a0)
		bsr.w	sub_950C
		move.b	#$FF,$3A(a0)
		move.l	#loc_903E,(a0)

loc_903E:
		tst.w	(Special_stage_rate_timer).w
		beq.s	++ ;loc_907E
		subq.w	#1,(Special_stage_rate_timer).w
		bne.s	++ ;loc_907E
		move.w	#30*60,(Special_stage_rate_timer).w
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	+ ;loc_905C
		move.w	#45*60,(Special_stage_rate_timer).w

+ ;loc_905C:
		cmpi.w	#$2000,(Special_stage_rate).w
		beq.s	+ ;loc_907E
		addi.w	#$400,(Special_stage_rate).w
		move.b	(Special_stage_rate).w,d0
		subi.b	#$20,d0
		neg.b	d0
		add.b	d0,d0
		addq.b	#8,d0
		jsr	(Change_Music_Tempo).l

+ ;loc_907E:
		bsr.w	sub_9580
		moveq	#$C,d0
		move.w	(Special_stage_velocity).w,d1
		beq.s	++ ;loc_90A8
		asr.w	#5,d1
		add.w	d1,anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame_timer(a0),d0
		bpl.s	+ ;loc_909E
		addi.b	#$C,d0
		bra.s	++ ;loc_90A8
; ---------------------------------------------------------------------------

+ ;loc_909E:
		cmpi.b	#$C,d0
		blo.s	+ ;loc_90A8
		subi.b	#$C,d0

+ ;loc_90A8:
		move.b	d0,anim_frame_timer(a0)
		lea	(byte_91E8).l,a1
		tst.b	(Special_stage_jumping).w
		bpl.s	+ ;loc_90CC
		lea	(byte_91F6).l,a1
		move.w	(Special_stage_velocity).w,d1
		bne.s	+ ;loc_90CC
		move.b	(Level_frame_counter+1).w,d0
		andi.w	#3,d0

+ ;loc_90CC:
		move.b	(a1,d0.w),mapping_frame(a0)
		tst.b	(Special_stage_clear_routine).w
		bne.s	+ ;loc_90EE
		move.w	(Ctrl_1).w,d0
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	+ ;loc_90EE
		tst.b	(Special_stage_jumping).w
		bmi.s	+ ;loc_90EE
		move.b	#1,(Special_stage_jumping).w

+ ;loc_90EE:
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	+++ ;loc_9152
		cmpi.b	#1,(Special_stage_jumping).w
		bne.s	+ ;loc_911E
		move.l	#-$100000,$40(a0)
		move.b	#$80,(Special_stage_jumping).w
		move.b	#0,(Special_stage_turning).w
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l

+ ;loc_911E:
		tst.b	(Special_stage_jumping).w
		bpl.s	++ ;loc_9152
		move.l	$3C(a0),d0
		add.l	$40(a0),d0
		bmi.s	+ ;loc_9138
		moveq	#0,d0
		move.l	d0,$40(a0)
		move.b	d0,(Special_stage_jumping).w

+ ;loc_9138:
		move.w	(Special_stage_rate).w,d1
		ext.l	d1
		lsl.l	#4,d1
		add.l	d1,$40(a0)
		move.l	d0,$3C(a0)
		swap	d0
		addi.w	#-$800,d0
		move.w	d0,$36(a0)

+ ;loc_9152:
		bsr.w	sub_950C
		bsr.w	sub_953E
		jsr	(Draw_Sprite).l
		lea	(PLC_SStageSonic).l,a2
		move.l	#ArtUnc_SStageSonic,d6
		move.w	#tiles_to_bytes($7D4),d4
		cmpi.w	#2,(Player_mode).w
		bne.s	+ ;loc_918A
		lea	(PLC_SStageTails).l,a2
		move.l	#ArtUnc_SStageTails,d6
		move.w	#tiles_to_bytes($7EB),d4
		bra.s	SStage_PLCLoad_91A2
; ---------------------------------------------------------------------------

+ ;loc_918A:
		cmpi.w	#3,(Player_mode).w
		bne.s	SStage_PLCLoad_91A2
		lea	(PLC_SStageKnuckles).l,a2
		move.l	#ArtUnc_SStageKnuckles,d6
		move.w	#tiles_to_bytes($7D4),d4

SStage_PLCLoad_91A2:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	$3A(a0),d0
		beq.s	locret_91E6
		move.b	d0,$3A(a0)
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_91E6

- ;loc_91BE:
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
		dbf	d5,- ;loc_91BE

locret_91E6:
		rts
; ---------------------------------------------------------------------------
byte_91E8:
		dc.b    2,   6,   7,   8,   7,   6,   2,   3,   4,   5,   4,   3,   1,   0
byte_91F6:
		dc.b    9,  $B,  $A,  $B,   9,  $B,  $A,  $B,   9,  $B,  $A,  $B,  $B,   0
byte_9204:
		dc.b    9,  $A,  $B,   9,  $A,  $B,   9,  $A,  $B,   9,  $A,  $B,  $B,   0
		even
; ---------------------------------------------------------------------------

Obj_SStage_9212:
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$180,priority(a0)
		move.l	#Map_SStageTails,mappings(a0)
		move.w	#make_art_tile($7EB,1,1),art_tile(a0)
		move.w	#$A0,$30(a0)
		move.w	#$70,$32(a0)
		move.w	#0,$34(a0)
		move.w	#-$800,$36(a0)
		move.w	#-$20,$38(a0)
		move.b	#$FF,$3A(a0)
		bsr.w	sub_93E2
		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
		bne.w	+ ;loc_9274
		move.l	#Obj_SStage_9444,(a1)
		move.w	a0,$3E(a1)

+ ;loc_9274:
		move.l	#loc_927A,(a0)

loc_927A:
		moveq	#$C,d0
		move.w	(Special_stage_velocity).w,d1
		beq.s	++ ;loc_92A0
		asr.w	#5,d1
		add.w	d1,anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame_timer(a0),d0
		bpl.s	+ ;loc_9296
		addi.b	#$C,d0
		bra.s	++ ;loc_92A0
; ---------------------------------------------------------------------------

+ ;loc_9296:
		cmpi.b	#$C,d0
		blo.s	+ ;loc_92A0
		subi.b	#$C,d0

+ ;loc_92A0:
		move.b	d0,anim_frame_timer(a0)
		lea	(byte_91E8).l,a1
		tst.b	(Special_stage_jumping_P2).w
		beq.s	+ ;loc_92C4
		lea	(byte_9204).l,a1
		move.w	(Special_stage_velocity).w,d1
		bne.s	+ ;loc_92C4
		move.b	(Level_frame_counter+1).w,d0
		andi.w	#3,d0

+ ;loc_92C4:
		move.b	(a1,d0.w),mapping_frame(a0)
		bsr.w	sub_9402
		cmpi.b	#5,$44(a0)
		bne.s	+ ;loc_9304
		tst.b	(Special_stage_clear_routine).w
		bne.s	+ ;loc_9304
		tst.b	(Special_stage_jumping_P2).w
		bmi.s	+ ;loc_9304
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	+ ;loc_9304
		move.l	#$FFE80000,$40(a0)
		move.b	#$81,(Special_stage_jumping_P2).w
		moveq	#signextendB(sfx_Spring),d0
		jsr	(Play_SFX).l

+ ;loc_9304:
		bsr.w	sub_937C
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	+ ;loc_932A
		tst.b	(Special_stage_jumping_P2).w
		bne.s	+ ;loc_932A
		move.l	#$FFF00000,$40(a0)
		move.b	#$80,(Special_stage_jumping_P2).w
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l

+ ;loc_932A:
		tst.b	(Special_stage_jumping_P2).w
		bpl.s	++ ;loc_935E
		move.l	$3C(a0),d0
		add.l	$40(a0),d0
		bmi.s	+ ;loc_9344
		moveq	#0,d0
		move.l	d0,$40(a0)
		move.b	d0,(Special_stage_jumping_P2).w

+ ;loc_9344:
		move.w	(Special_stage_rate).w,d1
		ext.l	d1
		lsl.l	#4,d1
		add.l	d1,$40(a0)
		move.l	d0,$3C(a0)
		swap	d0
		addi.w	#-$800,d0
		move.w	d0,$36(a0)

+ ;loc_935E:
		bsr.w	sub_953E
		jsr	(Draw_Sprite).l
		lea	(PLC_SStageTails).l,a2
		move.l	#ArtUnc_SStageTails,d6
		move.w	#tiles_to_bytes($7EB),d4
		bra.w	SStage_PLCLoad_91A2

; =============== S U B R O U T I N E =======================================


sub_937C:
		move.w	(Pos_table_index).w,d0
		lea	(Pos_table).w,a1
		lea	(a1,d0.w),a1
		move.w	(Ctrl_1).w,(a1)
		move.b	(Special_stage_jumping).w,2(a1)
		addq.b	#4,(Pos_table_index+1).w
		move.b	(Ctrl_2_held).w,d0
		andi.b	#$7F,d0
		beq.s	+ ;loc_93A6
		move.w	#600,(Tails_CPU_idle_timer).w

+ ;loc_93A6:
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	+ ;loc_93B6
		subq.w	#1,(Tails_CPU_idle_timer).w
		move.w	(Ctrl_2).w,d0
		rts
; ---------------------------------------------------------------------------

+ ;loc_93B6:
		lea	(Pos_table).w,a1
		move.w	#4,d1
		lsl.b	#2,d1
		move.w	(Pos_table_index).w,d0
		sub.b	d1,d0
		move.b	2(a1,d0.w),d2
		subq.b	#4,d0
		move.b	2(a1,d0.w),d1
		moveq	#0,d0
		cmpi.b	#-$7F,d2
		beq.s	locret_93E0
		tst.b	d1
		bpl.s	locret_93E0
		move.w	#$70,d0

locret_93E0:
		rts
; End of function sub_937C


; =============== S U B R O U T I N E =======================================


sub_93E2:
		lea	(Pos_table).w,a2
		move.w	#bytesToLcnt($100),d0

- ;loc_93EA:
		move.l	#0,(a2)+
		dbf	d0,- ;loc_93EA
		move.w	#0,(Pos_table_index).w
		move.w	#0,(Tails_CPU_idle_timer).w
		rts
; End of function sub_93E2


; =============== S U B R O U T I N E =======================================


sub_9402:
		lea	(SStage_layout_buffer+$100).w,a1
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$80,d0
		lsr.w	#8,d0
		andi.w	#$1F,d0
		move.w	(Special_stage_Y_pos).w,d1
		addi.w	#$80,d1
		lsr.w	#8,d1
		andi.w	#$1F,d1
		lsl.w	#5,d1
		or.b	d0,d1
		lea	(a1,d1.w),a1
		lea	$44(a0),a2
		move.b	1(a2),(a2)
		move.b	2(a2),1(a2)
		move.b	3(a2),2(a2)
		move.b	(a1),3(a2)
		rts
; End of function sub_9402

; ---------------------------------------------------------------------------

Obj_SStage_9444:
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$100,priority(a0)
		move.l	#Map_SStageTailstails,mappings(a0)
		move.w	#make_art_tile($7B0,1,1),art_tile(a0)
		move.w	#$A0,$30(a0)
		move.w	#$70,$32(a0)
		move.b	#-1,$3A(a0)
		move.b	#1,mapping_frame(a0)
		move.l	#loc_9488,(a0)

loc_9488:
		movea.w	$3E(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.w	#$2AAA,d0
		move.w	(Special_stage_velocity).w,d1
		bmi.s	+ ;loc_94A4
		add.w	d1,d0

+ ;loc_94A4:
		add.w	d0,anim_frame_timer(a0)
		bcc.s	++ ;loc_94BC
		move.b	mapping_frame(a0),d0
		addq.b	#1,d0
		cmpi.b	#$F,d0
		blo.s	+ ;loc_94B8
		moveq	#1,d0

+ ;loc_94B8:
		move.b	d0,mapping_frame(a0)

+ ;loc_94BC:
		jsr	(Draw_Sprite).l
		lea	(PLC_SStageTailstails).l,a2
		move.l	#ArtUnc_SStageTailstails,d6
		move.w	#tiles_to_bytes($7B0),d4
		bra.w	SStage_PLCLoad_91A2

; =============== S U B R O U T I N E =======================================


Draw_SSShadows:
		lea	(word_94FC).l,a3
		move.w	(a3)+,(a6)+
		move.b	(a3)+,(a6)+
		addq.w	#1,a3
		addq.w	#1,a6
		move.w	(a3)+,(a6)+
		move.w	(a3)+,(a6)+
		tst.w	(Player_mode).w
		bne.s	locret_94FA
		move.w	(a3)+,(a6)+
		move.b	(a3)+,(a6)+
		addq.w	#1,a3
		addq.w	#1,a6
		move.w	(a3)+,(a6)+
		move.w	(a3)+,(a6)+

locret_94FA:
		rts
; End of function Draw_SSShadows

; ---------------------------------------------------------------------------
word_94FC:
		dc.w $116, $F0A, make_art_tile($7A0,3,1), $110
		dc.w $127, $F0B, make_art_tile($7A0,3,1), $110

; =============== S U B R O U T I N E =======================================


sub_950C:
		move.w	(SStage_scalar_index_2).w,d0
		lea	(SStage_scalar_result_2).w,a1
		bsr.w	GetScalars2
		move.w	(SStage_scalar_index_1).w,d0
		lea	(SStage_scalar_result_1).w,a1
		bsr.w	GetScalars2
		move.w	(SStage_scalar_index_0).w,d0
		lea	(SStage_scalar_result_0).w,a1
		bsr.w	GetScalars2
		move.w	#$E0,d0
		lea	(SStage_scalar_result_3).w,a1
		bsr.w	GetScalars2
		rts
; End of function sub_950C


; =============== S U B R O U T I N E =======================================


sub_953E:
		move.w	$34(a0),d1
		move.w	$36(a0),d2
		move.w	$38(a0),d0
		bsr.w	sub_A1DC
		bsr.w	sub_A1B2
		bsr.w	sub_A188
		addi.w	#$100,d0
		addi.w	#$980,d2
		bsr.w	sub_A206
		ext.l	d1
		lsl.l	#8,d1
		divs.w	d0,d1
		ext.l	d2
		lsl.l	#8,d2
		divs.w	d0,d2
		add.w	$30(a0),d1
		move.w	d1,x_pos(a0)
		add.w	$32(a0),d2
		move.w	d2,y_pos(a0)
		rts
; End of function sub_953E


; =============== S U B R O U T I N E =======================================


sub_9580:
		tst.b	(Special_stage_fade_timer).w
		beq.s	++ ;loc_95AE
		cmpi.b	#$61,(Special_stage_fade_timer).w
		bhs.s	+ ;loc_959A
		moveq	#8,d1
		add.b	d1,(Special_stage_angle).w
		addq.b	#1,(Special_stage_fade_timer).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_959A:
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		beq.s	+ ;loc_95AE
		move.b	#0,(Special_stage_fade_timer).w

+ ;loc_95AE:
		move.w	(Special_stage_X_pos).w,d3
		btst	#6,(Special_stage_angle).w
		bne.s	+ ;loc_95BE
		move.w	(Special_stage_Y_pos).w,d3

+ ;loc_95BE:
		moveq	#0,d2
		move.b	(Special_stage_turning).w,d1
		beq.s	+ ;loc_95F4
		andi.w	#$E0,d3
		bne.s	+ ;loc_95F4
		tst.b	(Special_stage_jumping).w
		bmi.s	++ ;loc_9600
		add.b	d1,(Special_stage_angle).w
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	locret_972C
		move.b	#0,(Special_stage_turning).w
		tst.w	(Special_stage_velocity).w
		beq.s	+ ;loc_95F4
		move.b	#1,(Special_stage_turn_lock).w

+ ;loc_95F4:
		andi.w	#$E0,d3
		beq.s	+ ;loc_9600
		move.b	#0,(Special_stage_turn_lock).w

+ ;loc_9600:
		move.b	(Ctrl_1).w,d1
		move.w	(Special_stage_velocity).w,d2
		tst.b	(Special_stage_clear_routine).w
		bne.w	loc_96FA
		tst.b	(Special_stage_bumper_lock).w
		bne.s	+++ ;loc_9658
		btst	#0,d1
		beq.s	+ ;loc_9628
		move.b	#1,(Special_stage_advancing).w
		move.b	#1,(Special_stage_started).w

+ ;loc_9628:
		tst.b	(Special_stage_advancing).w
		bne.s	+ ;loc_964A
		tst.b	(Special_stage_started).w
		beq.s	++ ;loc_9658
		tst.w	d2
		bpl.s	+ ;loc_964A
		move.w	(Special_stage_rate).w,d3
		neg.w	d3
		subi.w	#$200,d2
		cmp.w	d3,d2
		bgt.s	++ ;loc_9658
		move.w	d3,d2
		bra.s	++ ;loc_9658
; ---------------------------------------------------------------------------

+ ;loc_964A:
		move.w	(Special_stage_rate).w,d3
		addi.w	#$200,d2
		cmp.w	d3,d2
		blt.s	+ ;loc_9658
		move.w	d3,d2

+ ;loc_9658:
		tst.b	(Special_stage_turn_lock).w
		bne.s	++ ;loc_9676
		btst	#2,d1
		beq.s	+ ;loc_966A
		move.b	#4,(Special_stage_turning).w

+ ;loc_966A:
		btst	#3,d1
		beq.s	+ ;loc_9676
		move.b	#-4,(Special_stage_turning).w

+ ;loc_9676:
		move.w	d2,(Special_stage_velocity).w
		tst.b	(Special_stage_bumper_lock).w
		beq.s	loc_96FA
		move.w	(Special_stage_X_pos).w,d0
		btst	#6,(Special_stage_angle).w
		bne.s	+ ;loc_9690
		move.w	(Special_stage_Y_pos).w,d0

+ ;loc_9690:
		andi.w	#$E0,d0
		bne.s	++ ;loc_96D4
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$80,d0
		lsr.w	#8,d0
		andi.w	#$1F,d0
		move.w	(Special_stage_Y_pos).w,d1
		addi.w	#$80,d1
		lsr.w	#8,d1
		andi.w	#$1F,d1
		lsl.w	#5,d1
		or.b	d0,d1
		cmp.w	(Special_stage_interact).w,d1
		beq.s	++ ;loc_96D4
		move.b	#0,(Special_stage_bumper_lock).w
		move.w	(Special_stage_rate).w,d2
		tst.w	(Special_stage_velocity).w
		bmi.s	+ ;loc_96CE
		neg.w	d2

+ ;loc_96CE:
		move.w	d2,(Special_stage_velocity).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_96D4:
		move.w	(Special_stage_velocity).w,d2
		bne.s	++ ;loc_96F8
		move.b	#0,(Special_stage_bumper_lock).w
		move.b	#1,(Special_stage_advancing).w
		move.w	(Special_stage_rate).w,d2
		tst.w	(Special_stage_velocity).w
		bmi.s	+ ;loc_96F2
		neg.w	d2

+ ;loc_96F2:
		move.w	d2,(Special_stage_velocity).w
		bra.s	loc_96FA
; ---------------------------------------------------------------------------

+ ;loc_96F8:
		neg.w	d2

loc_96FA:
		cmpi.b	#$81,(Special_stage_jumping).w
		bne.s	+ ;loc_9704
		add.w	d2,d2

+ ;loc_9704:
		move.b	(Special_stage_angle).w,d0
		jsr	(GetSineCosine).l
		muls.w	d2,d0
		muls.w	d2,d1
		swap	d0
		sub.w	d0,(Special_stage_X_pos).w
		swap	d1
		sub.w	d1,(Special_stage_Y_pos).w
		tst.b	(Special_stage_jumping).w
		bmi.s	locret_972C
		tst.b	(Special_stage_clear_routine).w
		bne.s	locret_972C
		bsr.s	+ ;sub_972E

locret_972C:
		rts
; End of function sub_9580


; =============== S U B R O U T I N E =======================================


+ ;sub_972E:
		lea	(SStage_layout_buffer+$100).w,a1
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$80,d0
		lsr.w	#8,d0
		andi.w	#$1F,d0
		move.w	(Special_stage_Y_pos).w,d1
		addi.w	#$80,d1
		lsr.w	#8,d1
		andi.w	#$1F,d1
		lsl.w	#5,d1
		or.b	d0,d1
		lea	(a1,d1.w),a1
		move.b	(a1),d2
		beq.w	locret_98AE
		cmpi.b	#1,d2
		bne.s	+++ ;loc_97AA
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		bne.s	locret_97A8
		tst.b	(Special_stage_fade_timer).w
		bne.s	locret_97A8
		move.b	#1,(Special_stage_fade_timer).w
		move.b	#$48,(Game_mode).w
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	+ ;loc_978E
		move.b	#$2C,(Game_mode).w

+ ;loc_978E:
		tst.b	(Special_bonus_entry_flag).w
		beq.s	+ ;loc_97A0
		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
		ori.b	#$80,(Last_star_post_hit).w

+ ;loc_97A0:
		moveq	#signextendB(sfx_Goal),d0
		jsr	(Play_SFX).l

locret_97A8:
		rts
; ---------------------------------------------------------------------------

+ ;loc_97AA:
		cmpi.b	#2,d2
		bne.s	++ ;loc_97C8
		bsr.w	Find_SStageCollisionResponseSlot
		bne.s	+ ;loc_97BE
		move.b	#2,(a2)
		move.l	a1,4(a2)

+ ;loc_97BE:
		moveq	#signextendB(sfx_BlueSphere),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

+ ;loc_97C8:
		cmpi.b	#3,d2
		bne.s	+ ;loc_97EE
		tst.b	(Special_stage_bumper_lock).w
		bne.s	+ ;loc_97EE
		move.w	d1,(Special_stage_interact).w
		move.b	#1,(Special_stage_bumper_lock).w
		move.b	#0,(Special_stage_advancing).w
		moveq	#signextendB(sfx_Bumper),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

+ ;loc_97EE:
		cmpi.b	#5,d2
		bne.s	+ ;loc_9822
		tst.b	(Special_stage_clear_routine).w
		bne.s	+ ;loc_9822
		tst.b	(Special_stage_jumping).w
		bmi.s	+ ;loc_9822
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	+ ;loc_9822
		move.l	#$FFE80000,$40(a0)
		move.b	#$81,(Special_stage_jumping).w
		moveq	#signextendB(sfx_Spring),d0
		jsr	(Play_SFX).l

+ ;loc_9822:
		cmpi.b	#4,d2
		bne.w	locret_98AE
		bsr.w	Find_SStageCollisionResponseSlot
		bne.s	+ ;loc_9838
		move.b	#1,(a2)
		move.l	a1,4(a2)

+ ;loc_9838:
		tst.w	(Special_stage_rings_left).w
		beq.s	+ ;loc_984C
		subq.w	#1,(Special_stage_rings_left).w
		bne.s	+ ;loc_984C
		moveq	#signextendB(sfx_Perfect),d0
		jsr	(Play_Music).l

+ ;loc_984C:
		addi.w	#1,(Special_stage_ring_count).w
		bset	#7,(Special_stage_extra_life_flags).w
		moveq	#signextendB(sfx_RingRight),d0
		tst.b	(Blue_spheres_stage_flag).w
		bne.s	+++ ;loc_98A6
		cmpi.w	#50,(Special_stage_ring_count).w
		blo.s	+ ;loc_987E
		bset	#0,(Special_stage_extra_life_flags).w
		bne.s	+ ;loc_987E
		addq.b	#1,(Continue_count).w
		move.w	#signextendB(sfx_Continue),d0
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------

+ ;loc_987E:
		moveq	#signextendB(sfx_RingRight),d0
		cmpi.w	#100,(Special_stage_ring_count).w
		blo.s	++ ;loc_98A6
		bset	#1,(Special_stage_extra_life_flags).w
		beq.s	+ ;loc_98A0
		cmpi.w	#200,(Special_stage_ring_count).w
		blo.s	++ ;loc_98A6
		bset	#2,(Special_stage_extra_life_flags).w
		bne.s	++ ;loc_98A6

+ ;loc_98A0:
		addq.b	#1,(Life_count).w
		moveq	#signextendB(sfx_RingLoss),d0

+ ;loc_98A6:
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

locret_98AE:
		rts
; End of function sub_972E

; ---------------------------------------------------------------------------
word_98B0:
		dc.w    $18
		dc.w      6
		dc.w      1
		dc.w    $1F
		dc.w  $FFFF
		dc.w    $1F
		dc.w      0
		dc.w      0
		dc.w      8
		dc.w      6
		dc.w  $FFFF
		dc.w    $1F
		dc.w  $FFFF
		dc.w    $1F
		dc.w      0
		dc.w      0
		dc.w      8
		dc.w    $1A
		dc.w  $FFFF
		dc.w    $1F
		dc.w      1
		dc.w    $1F
		dc.w      0
		dc.w      0
		dc.w    $18
		dc.w    $1A
		dc.w      1
		dc.w    $1F
		dc.w      1
		dc.w    $1F
		dc.w      0
		dc.w      0

; =============== S U B R O U T I N E =======================================


Draw_SSSprites:
		move.b	(Special_stage_angle).w,d0
		andi.w	#$C0,d0
		lsr.w	#2,d0
		lea	word_98B0(pc,d0.w),a5
		moveq	#0,d1
		move.b	(Special_stage_X_pos).w,d1
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$100,d0
		move.w	(Special_stage_Y_pos).w,d2
		andi.w	#$100,d2
		add.w	d2,d0
		btst	#6,(Special_stage_angle).w
		bne.s	+ ;loc_9930
		move.b	(Special_stage_Y_pos).w,d1
		move.w	(Special_stage_Y_pos).w,d0
		move.w	(Special_stage_X_pos).w,d2
		andi.w	#$100,d2
		add.w	d2,d0

+ ;loc_9930:
		tst.b	(Special_stage_angle).w
		bmi.s	+ ;loc_9946
		neg.w	d0
		addi.w	#$1F,d0
		move.w	d0,d2
		andi.w	#$E0,d2
		beq.s	+ ;loc_9946
		addq.b	#1,d1

+ ;loc_9946:
		andi.w	#$1E0,d0
		lsr.w	#5,d0
		move.w	d0,(Special_stage_anim_frame).w
		move.b	d0,(Special_stage_palette_frame).w
		move.b	(Special_stage_angle).w,d0
		andi.w	#$38,d0
		beq.s	+ ;loc_9968
		lsr.w	#3,d0
		addi.w	#$F,d0
		move.w	d0,(Special_stage_anim_frame).w

+ ;loc_9968:
		lea	(Draw_SSSprite_Normal).l,a0
		tst.w	(Special_stage_clear_timer).w
		beq.s	+ ;loc_997A
		lea	(Draw_SSSprite_FlyAway).l,a0

+ ;loc_997A:
		btst	#6,(Special_stage_angle).w
		bne.w	loc_9A3C
		move.w	2(a5),d5
		add.w	d1,d5
		and.w	$A(a5),d5
		move.w	(Special_stage_anim_frame).w,d0
		add.w	d0,d0
		add.w	d0,d0
		lea	(RAM_start).l,a1
		movea.l	(a1,d0.w),a1
		lea	(SStage_layout_buffer+$100).w,a2
		lea	(SStage_extra_sprites).w,a4
		lea	(Sprite_table).w,a6
		moveq	#$50-1,d7
		moveq	#0,d6
		move.b	(Sprites_drawn).w,d6
		sub.b	d6,d7
		lsl.w	#3,d6
		adda.w	d6,a6
		moveq	#$10-1,d2

- ;loc_99BC:
		move.w	(a5),d4
		moveq	#0,d0
		move.b	(Special_stage_X_pos).w,d0
		add.w	d0,d4
		and.w	6(a5),d4
		moveq	#$F-1,d3

- ;loc_99CC:
		move.w	d5,d0
		lsl.w	#5,d0
		or.b	d4,d0
		move.b	(a2,d0.w),d0
		beq.s	+++ ;loc_9A20
		move.w	(a1),d1
		andi.w	#$7C,d1
		beq.s	+++ ;loc_9A20
		lsr.w	#2,d1
		subq.w	#6,d1
		cmpi.w	#$10,d1
		bhs.s	+++ ;loc_9A20
		add.w	d1,d1
		andi.w	#$FF,d0
		lsl.w	#3,d0
		movea.l	(a4,d0.w),a3
		move.w	4(a4,d0.w),d6
		cmpi.w	#$54,(a1)
		blo.s	+ ;loc_9A04
		andi.w	#$7FFF,d6

+ ;loc_9A04:
		move.w	6(a4,d0.w),d0
		add.w	d0,d0
		bcc.s	+ ;loc_9A0E
		moveq	#0,d1

+ ;loc_9A0E:
		add.w	d0,d1
		adda.w	(a3,d1.w),a3
		move.w	(a3)+,d1
		subq.w	#1,d1
		bmi.s	+ ;loc_9A20
		jsr	(a0)
		tst.w	d7
		bmi.s	locret_9A3A

+ ;loc_9A20:
		addq.w	#6,a1
		add.w	4(a5),d4
		and.w	6(a5),d4
		dbf	d3,- ;loc_99CC
		add.w	8(a5),d5
		and.w	$A(a5),d5
		dbf	d2,-- ;loc_99BC

locret_9A3A:
		rts
; ---------------------------------------------------------------------------

loc_9A3C:
		move.w	2(a5),d5
		add.w	d1,d5
		and.w	$A(a5),d5
		move.w	(Special_stage_anim_frame).w,d0
		add.w	d0,d0
		add.w	d0,d0
		lea	(RAM_start).l,a1
		movea.l	(a1,d0.w),a1
		lea	(SStage_layout_buffer+$100).w,a2
		lea	(SStage_extra_sprites).w,a4
		lea	(Sprite_table).w,a6
		moveq	#$50-1,d7
		moveq	#0,d6
		move.b	(Sprites_drawn).w,d6
		sub.b	d6,d7
		lsl.w	#3,d6
		adda.w	d6,a6
		moveq	#$10-1,d2

- ;loc_9A74:
		move.w	(a5),d4
		moveq	#0,d0
		move.b	(Special_stage_Y_pos).w,d0
		add.w	d0,d4
		and.w	6(a5),d4
		moveq	#$F-1,d3

- ;loc_9A84:
		move.w	d4,d0
		lsl.w	#5,d0
		or.b	d5,d0
		move.b	(a2,d0.w),d0
		beq.s	+++ ;loc_9AD8
		move.w	(a1),d1
		andi.w	#$7C,d1
		beq.s	+++ ;loc_9AD8
		lsr.w	#2,d1
		subq.w	#6,d1
		cmpi.w	#$10,d1
		bhs.s	+++ ;loc_9AD8
		add.w	d1,d1
		andi.w	#$FF,d0
		lsl.w	#3,d0
		movea.l	(a4,d0.w),a3
		move.w	4(a4,d0.w),d6
		cmpi.w	#$54,(a1)
		blo.s	+ ;loc_9ABC
		andi.w	#$7FFF,d6

+ ;loc_9ABC:
		move.w	6(a4,d0.w),d0
		add.w	d0,d0
		bcc.s	+ ;loc_9AC6
		moveq	#0,d1

+ ;loc_9AC6:
		add.w	d0,d1
		adda.w	(a3,d1.w),a3
		move.w	(a3)+,d1
		subq.w	#1,d1
		bmi.s	+ ;loc_9AD8
		jsr	(a0)
		tst.w	d7
		bmi.s	locret_9AF2

+ ;loc_9AD8:
		addq.w	#6,a1
		add.w	4(a5),d4
		and.w	6(a5),d4
		dbf	d3,- ;loc_9A84
		add.w	8(a5),d5
		and.w	$A(a5),d5
		dbf	d2,-- ;loc_9A74

locret_9AF2:
		rts
; End of function Draw_SSSprites

; ---------------------------------------------------------------------------

Draw_SSSprite_Normal:
		move.b	(a3)+,d0
		ext.w	d0
		add.w	4(a1),d0
		move.w	d0,(a6)+
		move.b	(a3)+,(a6)+
		addq.w	#1,a6
		move.w	(a3)+,d0
		add.w	d6,d0
		move.w	d0,(a6)+
		move.w	(a3)+,d0
		add.w	2(a1),d0
		move.w	d0,(a6)+
		subq.w	#1,d7
		dbmi	d1,Draw_SSSprite_Normal
		rts
; ---------------------------------------------------------------------------

Draw_SSSprite_FlyAway:
		move.b	(a3)+,d0
		ext.w	d0
		add.w	4(a1),d0
		sub.w	(Special_stage_clear_timer).w,d0
		move.w	d0,(a6)+
		move.b	(a3)+,(a6)+
		addq.w	#1,a6
		move.w	(a3)+,d0
		add.w	d6,d0
		move.w	d0,(a6)+
		move.w	(a3)+,d0
		add.w	2(a1),d0
		move.w	d1,-(sp)
		subi.w	#$120,d0
		move.w	(Special_stage_clear_timer).w,d1
		addi.w	#$100,d1
		muls.w	d1,d0
		asr.l	#8,d0
		addi.w	#$120,d0
		cmpi.w	#$1D0,d0
		blo.s	+ ;loc_9B56
		move.w	#1,d0

+ ;loc_9B56:
		move.w	(sp)+,d1
		move.w	d0,(a6)+
		subq.w	#1,d7
		dbmi	d1,Draw_SSSprite_FlyAway
		rts

; =============== S U B R O U T I N E =======================================


sub_9B62:
		move.b	(Special_stage_clear_routine).w,d1
		beq.w	locret_9D1C
		subq.b	#1,d1
		bne.w	loc_9C5C
		cmpi.w	#$100,(Special_stage_clear_timer).w
		bhs.s	++ ;loc_9BA6
		addq.w	#2,(Special_stage_clear_timer).w
		cmpi.w	#2,(Special_stage_clear_timer).w
		bne.s	+ ;loc_9B8C
		moveq	#signextendB(sfx_AllSpheres),d0
		jsr	(Play_Music).l

+ ;loc_9B8C:
		cmpi.w	#$40,(Special_stage_clear_timer).w
		blo.s	locret_9BA4
		addq.w	#1,(Special_stage_clear_timer).w
		cmpi.w	#$80,(Special_stage_clear_timer).w
		blo.s	locret_9BA4
		addq.w	#1,(Special_stage_clear_timer).w

locret_9BA4:
		rts
; ---------------------------------------------------------------------------

+ ;loc_9BA6:
		addq.b	#1,(Special_stage_clear_routine).w
		lea	(SStage_layout_buffer+$100).w,a1
		move.w	#bytesToLcnt($400),d0

- ;loc_9BB2:
		move.l	#0,(a1)+
		dbf	d0,- ;loc_9BB2
		move.b	(Special_stage_angle).w,d0
		jsr	(GetSineCosine).l
		move.w	(Special_stage_X_pos).w,d2
		move.w	(Special_stage_Y_pos).w,d3
		asl.w	#3,d0
		asl.w	#3,d1
		sub.w	d0,d2
		sub.w	d1,d3
		lea	(SStage_layout_buffer+$100).w,a1
		move.w	d2,d0
		addi.w	#$80,d0
		lsr.w	#8,d0
		andi.w	#$1F,d0
		move.w	d3,d1
		addi.w	#$80,d1
		lsr.w	#8,d1
		andi.w	#$1F,d1
		lsl.w	#5,d1
		or.b	d0,d1
		move.b	#$B,(a1,d1.w)
		tst.b	(SK_special_stage_flag).w
		beq.s	+ ;loc_9C08
		move.b	#$D,(a1,d1.w)

+ ;loc_9C08:
		move.w	d1,(Special_stage_interact).w
		move.w	#$800,(Special_stage_velocity).w
		move.b	#120,(Special_stage_emerald_timer).w
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	+ ;loc_9C28
		move.b	(Blue_spheres_current_stage+2).w,d0

+ ;loc_9C28:
		andi.w	#7,d0
		lea	(Pal_SStage_Emeralds).l,a1
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		lea	(Normal_palette_line_4+$4).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		lea	(ArtKosM_SStageChaosEmerald).l,a1
		tst.b	(SK_special_stage_flag).w
		beq.s	+ ;loc_9C52
		lea	(ArtKosM_SStageSuperEmerald).l,a1

+ ;loc_9C52:
		move.w	#tiles_to_bytes($5A7),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_9C5C:
		subq.b	#1,d1
		bne.s	+ ;loc_9C80
		tst.b	(Kos_modules_left).w
		bne.s	locret_9C7E
		move.w	#0,(Special_stage_clear_timer).w
		subq.b	#1,(Special_stage_emerald_timer).w
		bne.s	locret_9C7E
		addq.b	#1,(Special_stage_clear_routine).w
		moveq	#signextendB(mus_Emerald),d0
		jsr	(Play_Music).l

locret_9C7E:
		rts
; ---------------------------------------------------------------------------

+ ;loc_9C80:
		subq.b	#1,d1
		bne.w	locret_9D1C
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$80,d0
		lsr.w	#8,d0
		andi.w	#$1F,d0
		move.w	(Special_stage_Y_pos).w,d1
		addi.w	#$80,d1
		lsr.w	#8,d1
		andi.w	#$1F,d1
		lsl.w	#5,d1
		or.b	d0,d1
		cmp.w	(Special_stage_interact).w,d1
		bne.s	locret_9D1C
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		bne.s	locret_9D1C
		tst.b	(Blue_spheres_stage_flag).w
		bne.s	++ ;loc_9CE6
		lea	(Chaos_emerald_count).w,a2
		move.b	(SK_special_stage_flag).w,d2
		beq.s	+ ;loc_9CCE
		lea	(Super_emerald_count).w,a2

+ ;loc_9CCE:
		cmpi.b	#7,(a2)
		bhs.s	+ ;loc_9CE6
		addq.b	#1,(a2)
		lea	(Collected_emeralds_array).w,a1
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
		bset	#0,(a1,d0.w)

+ ;loc_9CE6:
		addq.b	#1,(Special_stage_clear_routine).w
		move.b	#1,(Special_stage_fade_timer).w
		move.b	#$48,(Game_mode).w
		tst.b	(Blue_spheres_stage_flag).w
		beq.s	+ ;loc_9D02
		move.b	#$30,(Game_mode).w

+ ;loc_9D02:
		tst.b	(Special_bonus_entry_flag).w
		beq.s	+ ;loc_9D14
		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
		ori.b	#$80,(Last_star_post_hit).w

+ ;loc_9D14:
		moveq	#signextendB(sfx_Goal),d0
		jsr	(Play_SFX).l

locret_9D1C:
		rts
; End of function sub_9B62

; ---------------------------------------------------------------------------
Pal_SStage_Emeralds:
		binclude "General/Special Stage/Palettes/Emeralds.bin"
		even

; =============== S U B R O U T I N E =======================================


sub_9D5E:
		move.w	(Special_stage_X_pos).w,d0
		sub.w	(Special_stage_prev_X_pos).w,d0
		btst	#6,(Special_stage_angle).w
		bne.s	+ ;loc_9D76
		move.w	(Special_stage_Y_pos).w,d0
		sub.w	(Special_stage_prev_Y_pos).w,d0

+ ;loc_9D76:
		tst.b	(Special_stage_angle).w
		bmi.s	+ ;loc_9D7E
		neg.w	d0

+ ;loc_9D7E:
		asr.w	#2,d0
		add.w	d0,(V_scroll_value_BG).w
		moveq	#0,d1
		move.b	(Special_stage_angle).w,d1
		asl.w	#2,d1
		move.w	d1,(H_scroll_buffer+2).w
		move.w	(Special_stage_X_pos).w,(Special_stage_prev_X_pos).w
		move.w	(Special_stage_Y_pos).w,(Special_stage_prev_Y_pos).w
		rts
; End of function sub_9D5E


; =============== S U B R O U T I N E =======================================


Animate_SSRings:
		lea	(SStage_extra_sprites+$07).w,a1
		subq.b	#1,(Rings_frame_timer).w
		bpl.s	+ ;loc_9DC2
		move.b	#7,(Rings_frame_timer).w
		addi.b	#$10,(Rings_frame).w
		cmpi.b	#$30,(Rings_frame).w
		blo.s	+ ;loc_9DC2
		move.b	#0,(Rings_frame).w

+ ;loc_9DC2:
		move.b	(Rings_frame).w,anim(a1)
		rts
; End of function Animate_SSRings


; =============== S U B R O U T I N E =======================================


Find_SStageCollisionResponseSlot:
		lea	(SStage_collision_response_list).w,a2
		move.w	#$20-1,d0

- ;loc_9DD2:
		tst.b	(a2)
		beq.s	locret_9DDC
		addq.w	#8,a2
		dbf	d0,- ;loc_9DD2

locret_9DDC:
		rts
; End of function Find_SStageCollisionResponseSlot


; =============== S U B R O U T I N E =======================================


Touch_SSSprites:
		lea	(SStage_collision_response_list).w,a0
		move.w	#$20-1,d7

- ;loc_9DE6:
		moveq	#0,d0
		move.b	(a0),d0
		beq.s	+ ;loc_9DF4
		lsl.w	#2,d0
		movea.l	off_9DFC-4(pc,d0.w),a1
		jsr	(a1)

+ ;loc_9DF4:
		addq.w	#8,a0
		dbf	d7,- ;loc_9DE6
		rts
; End of function Touch_SSSprites

; ---------------------------------------------------------------------------
off_9DFC:
		dc.l Touch_SSSprites_Ring
		dc.l Touch_SSSprites_BlueSphere
; ---------------------------------------------------------------------------

Touch_SSSprites_Ring:
		subq.b	#1,2(a0)
		bpl.s	locret_9E2C
		move.b	#5,2(a0)
		moveq	#0,d0
		move.b	3(a0),d0
		addq.b	#1,3(a0)
		movea.l	4(a0),a1
		move.b	byte_9E2E(pc,d0.w),d0
		move.b	d0,(a1)
		bne.s	locret_9E2C
		clr.l	(a0)
		clr.l	4(a0)

locret_9E2C:
		rts
; ---------------------------------------------------------------------------
byte_9E2E:
		dc.b    6,   7,   8,   9,   0
		even
; ---------------------------------------------------------------------------

Touch_SSSprites_BlueSphere:
		subq.b	#1,2(a0)
		bpl.s	locret_9E86
		move.b	#9,2(a0)
		movea.l	4(a0),a1
		cmpi.b	#2,(a1)
		bne.s	+ ;loc_9E62
		bsr.w	sub_9E88
		move.b	#$A,(a1)
		bsr.s	sub_9EBC
		beq.s	locret_9E60
		move.b	#4,(a1)
		clr.l	(a0)
		clr.l	4(a0)

locret_9E60:
		rts
; ---------------------------------------------------------------------------

+ ;loc_9E62:
		move.b	#0,2(a0)
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		beq.s	locret_9E86
		cmpi.b	#$A,(a1)
		bne.s	+ ;loc_9E80
		move.b	#1,(a1)

+ ;loc_9E80:
		clr.l	(a0)
		clr.l	4(a0)

locret_9E86:
		rts

; =============== S U B R O U T I N E =======================================


sub_9E88:
		move.w	d0,-(sp)
		move.b	#-1,(Special_stage_sphere_HUD_flag).w
		subq.w	#1,(Special_stage_spheres_left).w
		bne.s	+ ;loc_9E9C
		move.b	#1,(Special_stage_clear_routine).w

+ ;loc_9E9C:
		move.w	(sp)+,d0
		rts
; End of function sub_9E88


; =============== S U B R O U T I N E =======================================


sub_9EA0:
		lea	(SStage_layout_buffer+$100).w,a3
		moveq	#0,d1
		move.w	#$400-1,d0

- ;loc_9EAA:
		cmpi.b	#2,(a3)+
		bne.s	+ ;loc_9EB2
		addq.w	#1,d1

+ ;loc_9EB2:
		dbf	d0,- ;loc_9EAA
		move.w	d1,(Special_stage_spheres_left).w
		rts
; End of function sub_9EA0


; =============== S U B R O U T I N E =======================================


sub_9EBC:
		lea	(SStage_layout_buffer+$100).w,a2
		move.l	a1,d5
		sub.l	a2,d5
		bsr.s	sub_9F44
		moveq	#0,d6
		move.l	a5,d1
		lea	(SStage_unkA500).w,a4
		sub.l	a4,d1
		beq.s	locret_9F42

loc_9ED2:
		move.w	(a4)+,d5
		lea	(word_A0CA).l,a3
		move.w	#8-1,d0

- ;loc_9EDE:
		move.w	(a3)+,d2
		add.w	d5,d2
		andi.w	#$3FF,d2
		cmpi.b	#2,(a2,d2.w)
		bne.s	+ ;loc_9EFC
		bsr.w	sub_9E88
		move.b	#4,(a2,d2.w)
		move.w	d2,(a5)+
		addq.w	#2,d1

+ ;loc_9EFC:
		dbf	d0,- ;loc_9EDE
		subq.w	#2,d1
		bne.s	loc_9ED2
		move.l	a5,d1
		lea	(SStage_unkA500).w,a4
		sub.l	a4,d1
		beq.s	locret_9F42

loc_9F0E:
		move.w	(a4)+,d5
		lea	(word_A0CA).l,a3
		move.w	#8-1,d0

- ;loc_9F1A:
		move.w	(a3)+,d2
		add.w	d5,d2
		andi.w	#$3FF,d2
		cmpi.b	#1,(a2,d2.w)
		bne.s	+ ;loc_9F30
		move.b	#4,(a2,d2.w)

+ ;loc_9F30:
		dbf	d0,- ;loc_9F1A
		subq.w	#2,d1
		bne.s	loc_9F0E
		moveq	#signextendB(sfx_RingLoss),d0
		jsr	(Play_SFX).l
		moveq	#1,d1

locret_9F42:
		rts
; End of function sub_9EBC


; =============== S U B R O U T I N E =======================================


sub_9F44:
		lea	(SStage_unkA500).w,a5
		lea	(word_A0CA).l,a3
		moveq	#0,d2
		move.w	#8-1,d0

- ;loc_9F54:
		move.w	(a3)+,d1
		add.w	d5,d1
		andi.w	#$3FF,d1
		cmpi.b	#$A,(a2,d1.w)
		bne.s	+ ;loc_9F6A
		move.b	#1,(a2,d1.w)

+ ;loc_9F6A:
		cmpi.b	#2,(a2,d1.w)
		bne.s	+ ;loc_9F74
		addq.w	#1,d2

+ ;loc_9F74:
		dbf	d0,- ;loc_9F54
		tst.w	d2
		beq.w	locret_A076
		moveq	#0,d2
		move.w	d5,d1
		moveq	#$10-1,d3

- ;loc_9F84:
		addq.w	#1,d2
		addi.w	#-1,d1
		tst.b	(a2,d1.w)
		beq.s	+ ;loc_9F94
		dbf	d3,- ;loc_9F84

+ ;loc_9F94:
		move.w	d5,d1
		moveq	#$10-1,d3

- ;loc_9F98:
		addq.w	#1,d2
		addi.w	#1,d1
		tst.b	(a2,d1.w)
		beq.s	+ ;loc_9FA8
		dbf	d3,- ;loc_9F98

+ ;loc_9FA8:
		cmpi.w	#4,d2
		blo.w	locret_A076
		moveq	#0,d2
		move.w	d5,d1
		moveq	#$10-1,d3

- ;loc_9FB6:
		addq.w	#1,d2
		addi.w	#$FFE0,d1
		tst.b	(a2,d1.w)
		beq.s	+ ;loc_9FC6
		dbf	d3,- ;loc_9FB6

+ ;loc_9FC6:
		move.w	d5,d1
		moveq	#$10-1,d3

- ;loc_9FCA:
		addq.w	#1,d2
		addi.w	#$20,d1
		tst.b	(a2,d1.w)
		beq.s	+ ;loc_9FDA
		dbf	d3,- ;loc_9FCA

+ ;loc_9FDA:
		cmpi.w	#4,d2
		blo.w	locret_A076
		lea	(SStage_unkA600).w,a4
		lea	(word_A0DA).l,a3
		moveq	#0,d6
		moveq	#0,d3
		moveq	#6,d4
		add.w	d3,d4
		move.w	d5,d0

loc_9FF6:
		move.w	(a3,d4.w),d1
		add.w	d0,d1
		andi.w	#$3FF,d1
		move.b	(a2,d1.w),d2
		cmpi.b	#$8A,d2
		beq.s	++ ;loc_A078
		cmpi.b	#1,d2
		bne.s	loc_A054
		cmpi.w	#2,d6
		blo.s	+ ;loc_A034
		move.w	d1,d2
		sub.w	-6(a4),d2
		cmpi.w	#-1,d2
		beq.s	loc_A054
		cmpi.w	#1,d2
		beq.s	loc_A054
		cmpi.w	#$20,d2
		beq.s	loc_A054
		cmpi.w	#-$20,d2
		beq.s	loc_A054

+ ;loc_A034:
		ori.b	#$80,(a2,d0.w)
		move.b	d3,(a4)+
		move.b	d4,(a4)+
		move.w	d0,(a4)+
		addq.w	#1,d6
		move.w	d4,d3
		subq.w	#2,d3
		andi.w	#6,d3
		move.w	#4,d4
		add.w	d3,d4
		move.w	d1,d0
		bra.s	loc_9FF6
; ---------------------------------------------------------------------------

loc_A054:
		subq.w	#2,d4
		cmp.w	d3,d4
		bge.s	loc_9FF6

loc_A05A:
		moveq	#0,d3
		moveq	#0,d4
		move.w	-(a4),d0
		move.b	-(a4),d4
		move.b	-(a4),d3
		subq.w	#1,d6
		bcs.s	locret_A076
		andi.b	#$7F,(a2,d0.w)
		subq.w	#2,d4
		cmp.w	d3,d4
		bge.s	loc_9FF6
		bra.s	loc_A05A
; ---------------------------------------------------------------------------

locret_A076:
		rts
; ---------------------------------------------------------------------------

+ ;loc_A078:
		movem.l	d0/d3-d4/d6/a4,-(sp)
		sub.w	d5,d0
		move.w	d0,d4
		neg.w	d4
		lea	(SStage_unkA600+6).w,a4
		move.w	(a4),d2
		sub.w	d5,d2
		move.w	d5,d3

loc_A08C:
		move.w	(a4)+,d0
		addq.w	#2,a4
		sub.w	d3,d0
		cmp.w	d2,d0
		bne.s	+ ;loc_A09A
		add.w	d0,d3
		bra.s	loc_A08C
; ---------------------------------------------------------------------------

+ ;loc_A09A:
		cmp.w	d4,d0
		beq.s	+ ;loc_A0A4
		cmp.w	d4,d2
		beq.s	+ ;loc_A0A4
		add.w	d2,d0

+ ;loc_A0A4:
		add.w	d5,d0
		cmpi.b	#2,(a2,d0.w)
		beq.s	+ ;loc_A0B8
		cmpi.b	#4,(a2,d0.w)
		beq.s	++ ;loc_A0C4
		bra.s	++ ;loc_A0C4
; ---------------------------------------------------------------------------

+ ;loc_A0B8:
		bsr.w	sub_9E88
		move.b	#4,(a2,d0.w)
		move.w	d0,(a5)+

+ ;loc_A0C4:
		movem.l	(sp)+,d0/d3-d4/d6/a4
		bra.s	loc_A054
; End of function sub_9F44

; ---------------------------------------------------------------------------
word_A0CA:
		dc.w   -$21
		dc.w   -$20
		dc.w   -$1F
		dc.w     -1
		dc.w      1
		dc.w    $1F
		dc.w    $20
		dc.w    $21
word_A0DA:
		dc.w     -1
		dc.w   -$20
		dc.w      1
		dc.w    $20
		dc.w     -1
		dc.w   -$20

; =============== S U B R O U T I N E =======================================


Load_SSSprite_Mappings:
		lea	(SStage_extra_sprites).w,a1
		lea	(MapPtr_A10A).l,a0
		moveq	#$E-1,d1

- ;loc_A0F2:
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		dbf	d1,- ;loc_A0F2
		lea	(SStage_collision_response_list).w,a1
		move.w	#$40-1,d1

- ;loc_A102:
		clr.l	(a1)+
		dbf	d1,- ;loc_A102
		rts
; End of function Load_SSSprite_Mappings

; ---------------------------------------------------------------------------
MapPtr_A10A:
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,0,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,0,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,2,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,1,1), $0000
		dc.l Map_SStageRing
		dc.w make_art_tile($5A7,2,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,3,1), $0000
		dc.l Map_SStageRing
		dc.w make_art_tile($5A7,2,1), $8030
		dc.l Map_SStageRing
		dc.w make_art_tile($5A7,2,1), $8031
		dc.l Map_SStageRing
		dc.w make_art_tile($5A7,2,1), $8032
		dc.l Map_SStageRing
		dc.w make_art_tile($5A7,2,1), $8033
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,2,1), $0000
		dc.l Map_SStageChaosEmerald
		dc.w make_art_tile($5A7,3,1), $0000
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,2,1), $0000
		dc.l Map_SStageSuperEmerald
		dc.w make_art_tile($5A7,3,1), $0000
; ---------------------------------------------------------------------------
		ext.l	d1
		lsl.l	#8,d1
		divs.w	d0,d1
		ext.l	d2
		lsl.l	#8,d2
		divs.w	d0,d2
		rts

; =============== S U B R O U T I N E =======================================


sub_A188:
		swap	d0
		move.w	d1,d3
		move.w	d2,d4
		move.w	(SStage_scalar_result_2).w,d0
		muls.w	d0,d3
		muls.w	d0,d4
		move.w	(SStage_scalar_result_2+2).w,d0
		muls.w	d0,d1
		muls.w	d0,d2
		sub.l	d4,d1
		add.l	d1,d1
		add.l	d1,d1
		swap	d1
		add.l	d3,d2
		add.l	d2,d2
		add.l	d2,d2
		swap	d2
		swap	d0
		rts
; End of function sub_A188


; =============== S U B R O U T I N E =======================================


sub_A1B2:
		swap	d2
		move.w	d0,d3
		move.w	d1,d4
		move.w	(SStage_scalar_result_1).w,d2
		muls.w	d2,d3
		muls.w	d2,d4
		move.w	(SStage_scalar_result_1+2).w,d2
		muls.w	d2,d0
		muls.w	d2,d1
		sub.l	d4,d0
		add.l	d0,d0
		add.l	d0,d0
		swap	d0
		add.l	d3,d1
		add.l	d1,d1
		add.l	d1,d1
		swap	d1
		swap	d2
		rts
; End of function sub_A1B2


; =============== S U B R O U T I N E =======================================


sub_A1DC:
		swap	d1
		move.w	d0,d3
		move.w	d2,d4
		move.w	(SStage_scalar_result_0).w,d1
		muls.w	d1,d3
		muls.w	d1,d4
		move.w	(SStage_scalar_result_0+2).w,d1
		muls.w	d1,d0
		muls.w	d1,d2
		sub.l	d4,d0
		add.l	d0,d0
		add.l	d0,d0
		swap	d0
		add.l	d3,d2
		add.l	d2,d2
		add.l	d2,d2
		swap	d2
		swap	d1
		rts
; End of function sub_A1DC


; =============== S U B R O U T I N E =======================================


sub_A206:
		swap	d1
		move.w	d0,d3
		move.w	d2,d4
		move.w	(SStage_scalar_result_3).w,d1
		muls.w	d1,d3
		muls.w	d1,d4
		move.w	(SStage_scalar_result_3+2).w,d1
		muls.w	d1,d0
		muls.w	d1,d2
		sub.l	d4,d0
		add.l	d0,d0
		add.l	d0,d0
		swap	d0
		add.l	d3,d2
		add.l	d2,d2
		add.l	d2,d2
		swap	d2
		swap	d1
		rts
; End of function sub_A206


; =============== S U B R O U T I N E =======================================


sub_A230:
		add.w	d0,d0
		addi.w	#$80,d0
		andi.w	#$1FE,d0
		move.w	ScalarTable2(pc,d0.w),d1
		subi.w	#$80,d0
		andi.w	#$1FE,d0
		move.w	ScalarTable2(pc,d0.w),d0
		rts
; End of function sub_A230


; =============== S U B R O U T I N E =======================================


GetScalars2:
		add.w	d0,d0
		andi.w	#$1FE,d0
		move.w	ScalarTable2(pc,d0.w),(a1)+
		addi.w	#$80,d0
		andi.w	#$1FE,d0
		move.w	ScalarTable2(pc,d0.w),(a1)+
		rts
; End of function GetScalars2

; ---------------------------------------------------------------------------
ScalarTable2:
		binclude "General/Special Stage/Scalars.bin"
		even
Map_SStageSphere:
		include "General/Special Stage/Map - Sphere.asm"
Map_SStageRing:
		include "General/Special Stage/Map - Ring.asm"
Map_SStageChaosEmerald:
		include "General/Special Stage/Map - Chaos Emerald.asm"
Map_SStageSuperEmerald:
		include "General/Special Stage/Map - Super Emerald.asm"
; ---------------------------------------------------------------------------

locret_A85C:
		rts
