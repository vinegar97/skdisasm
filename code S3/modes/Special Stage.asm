SpecialStage:
		moveq	#signextendB(mus_Stop),d0
		bsr.w	Play_Music
		bsr.w	Clear_Nem_Queue
		bsr.w	Pal_FadeToWhite
		move	#$2700,sr
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)			; Command $9200 - Window V position at default
		move.w	#$8B00,(a6)
		move.w	#$8720,(a6)
		clr.b	(Water_full_screen_flag).w
		move.w	#$8C81,(a6)			; Command $8C81 - 40cell screen size, no interlacing, no s/h
		bsr.w	Clear_DisplayData
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clearRAM	Stat_table,$100
		jsr	(Init_SpriteTable).l
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		lea	(Pal_SStage_Main).l,a1
		lea	(Target_palette).w,a2
		move.w	#bytesToWcnt($80),d0

loc_7546:
		move.w	(a1)+,(a2)+
		dbf	d0,loc_7546
		move.l	#vdpComm(tiles_to_bytes($000),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_SStageLayout).l,a0
		bsr.w	Nem_Decomp
		lea	(MapUnc_SStageLayout).l,a1
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
		lea	(SStageLayoutPtrs).l,a2
		tst.b	(Debug_cheat_flag).w
		beq.s	loc_7692
		move.w	(Sound_test_sound).w,d0
		btst	#button_A,(Ctrl_1_held).w
		bne.s	loc_76B6

loc_7692:
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
		cmpi.w	#7,(Chaos_emerald_count).w
		bcc.s	loc_76B6
		lea	(Collected_emeralds_array).w,a1

loc_76A4:
		tst.b	(a1,d0.w)
		beq.s	loc_76B6
		addq.w	#1,d0
		cmpi.w	#7,d0
		bcs.s	loc_76A4
		moveq	#0,d0
		bra.s	loc_76A4
; ---------------------------------------------------------------------------

loc_76B6:
		andi.w	#7,d0
		move.b	d0,(Current_special_stage).w
		move.w	d0,d1
		lsl.w	#2,d0
		movea.l	(a2,d0.w),a2
		lea	(Level_layout_header).w,a3
		move.w	#bytesToLcnt($400),d0

loc_76CE:
		move.l	(a2)+,(a3)+
		dbf	d0,loc_76CE
		move.w	(a2)+,(Special_stage_angle).w
		move.w	(a2)+,(Special_stage_X_pos).w
		move.w	(a2)+,(Special_stage_Y_pos).w
		move.w	(a2)+,(Special_stage_rings_left).w
		lsl.w	#4,d1
		lea	(SS_Pal_Map_Ptrs).l,a1
		lea	(Target_palette).w,a2
		movea.l	4(a1,d1.w),a1
		move.l	a1,(Special_stage_palette_addr).w
		move.l	(a1)+,$70(a2)
		move.l	(a1)+,$74(a2)
		move.l	(a1)+,$78(a2)
		move.l	(a1)+,$7C(a2)
		move.l	$10(a1),$50(a2)
		move.w	$14(a1),$54(a2)
		bsr.w	sub_8CDC
		bsr.w	Load_SSSprite_Mappings
		clr.b	(Level_started_flag).w
		move.b	#$FF,(Special_stage_sphere_HUD_flag).w
		move.b	#$80,(Special_stage_extra_life_flags).w
		move.w	#$1000,(Special_stage_rate).w
		move.w	#30*60,(Special_stage_rate_timer).w
		move.w	#0,(Camera_X_pos_copy).w
		move.w	#0,(Camera_Y_pos_copy).w
		move.w	#-1,(Screen_Y_wrap_value).w
		move.l	#Obj_SStage_7F1C,(Player_1).w
		move.l	#Obj_SStage_8380,(Dynamic_object_RAM+object_size).w
		tst.w	(Player_option).w
		bne.s	loc_7770
		move.l	#Obj_SStage_8148,(Player_2).w
		move.l	#Obj_SStage_83E4,(Dynamic_object_RAM+(object_size*2)).w

loc_7770:
		move.l	#Obj_SStage_7D70,(Reserved_object_3).w
		move.l	#Obj_SStage_7DB8,(Dynamic_object_RAM).w
		jsr	(Process_Sprites).l
		bsr.w	Animate_SSRings
		bsr.w	Touch_SSSprites
		jsr	(Render_Sprites).l
		jsr	Draw_SSSprites(pc)
		bsr.w	sub_8B9A
		move.b	#1,(Special_stage_fade_timer).w
		move.b	#$1C,(V_int_routine).w
		bsr.w	Wait_VSync
		move.b	#0,(Special_stage_fade_timer).w
		move.w	#$8C89,(VDP_control_port).l
		moveq	#signextendB(mus_SpecialStage),d0
		bsr.w	Play_Music
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		bsr.w	Pal_FadeFromWhite

loc_77D2:
		bsr.w	Pause_Game
		move.b	#$1C,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		addq.w	#1,(Level_frame_counter).w
		jsr	(Process_Sprites).l
		bsr.w	Animate_SSRings
		bsr.w	Touch_SSSprites
		jsr	(Render_Sprites).l
		jsr	Draw_SSSprites(pc)
		bsr.w	sub_8B9A
		bsr.w	sub_89E2
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		cmpi.b	#$34,(Game_mode).w
		beq.s	loc_77D2
		tst.w	(Demo_mode_flag).w
		beq.s	loc_7828
		move.b	#0,(Game_mode).w

loc_7828:
		move.w	#60,(Demo_timer).w
		move.w	#$40-1,(Palette_fade_info).w
		clr.w	(Pal_fade_delay).w

loc_7838:
		move.b	#$1C,(V_int_routine).w
		bsr.w	Wait_VSync
		jsr	(Process_Sprites).l
		bsr.w	Animate_SSRings
		bsr.w	Touch_SSSprites
		jsr	(Render_Sprites).l
		jsr	Draw_SSSprites(pc)
		bsr.w	sub_8B9A
		bsr.w	sub_89E2
		bsr.w	Process_Nem_Queue_Init
		jsr	(Process_Kos_Module_Queue).l
		subq.w	#1,(Pal_fade_delay).w
		bpl.s	loc_787C
		move.w	#2,(Pal_fade_delay).w
		bsr.w	Pal_ToWhite

loc_787C:
		tst.w	(Demo_timer).w
		bne.s	loc_7838
		addq.b	#1,(Current_special_stage).w
		cmpi.b	#7,(Current_special_stage).w
		bcs.s	locret_7894
		move.b	#0,(Current_special_stage).w

locret_7894:
		rts

; =============== S U B R O U T I N E =======================================


Rotate_SSPal:
		tst.b	(Special_stage_fade_timer).w
		bne.s	locret_78DA
		lea	(SS_Pal_Map_Ptrs).l,a1
		move.w	(Special_stage_anim_frame).w,d0
		cmpi.w	#$10,d0
		blo.s	loc_78BA
		tst.b	(Special_stage_turning).w
		bpl.s	locret_78DA
		move.b	(Special_stage_palette_frame).w,d0
		andi.w	#$F,d0

loc_78BA:
		andi.w	#$E,d0
		neg.w	d0
		addi.w	#$10,d0
		movea.l	(Special_stage_palette_addr).w,a1
		lea	(a1,d0.w),a1
		lea	(Normal_palette_line_4+$10).w,a2
		move.w	#bytesToWcnt($10),d0

loc_78D4:
		move.w	(a1)+,(a2)+
		dbf	d0,loc_78D4

locret_78DA:
		rts
; End of function Rotate_SSPal


; =============== S U B R O U T I N E =======================================


Update_SSMap:
		lea	(VDP_data_port).l,a6
		lea	(SS_Pal_Map_Ptrs).l,a1
		move.w	(Special_stage_anim_frame).w,d0
		cmp.b	(Special_stage_prev_anim_frame).w,d0
		beq.s	loc_7938
		move.b	d0,(Special_stage_prev_anim_frame).w
		lsl.w	#3,d0
		movea.l	(a1,d0.w),a3
		lea	$10E(a3),a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$19E,VRAM,WRITE),(VDP_control_port).l	; VRAM write $C19E
		moveq	#$A-1,d1

loc_790C:
		move.w	(a1)+,(a6)
		dbf	d1,loc_790C
		lea	$140(a3),a3
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$200,VRAM,WRITE),d0		; VRAM write $C200
		moveq	#$28-1,d1
		moveq	#$18-1,d2
		move.l	#$80<<16,d4

loc_7926:
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.w	d1,d3

loc_792C:
		move.w	(a3)+,(a6)
		dbf	d3,loc_792C
		add.l	d4,d0
		dbf	d2,loc_7926

loc_7938:
		tst.b	(Special_stage_sphere_HUD_flag).w
		beq.s	loc_7952
		move.b	#0,(Special_stage_sphere_HUD_flag).w
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$086,VRAM,WRITE),d0	; VRAM write $C086
		move.w	(Special_stage_spheres_left).w,d1
		bsr.w	Draw_SSNum

loc_7952:
		tst.b	(Special_stage_extra_life_flags).w
		bpl.s	locret_796C
		bclr	#7,(Special_stage_extra_life_flags).w
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$0BE,VRAM,WRITE),d0	; VRAM write $C0BE
		move.w	(Special_stage_ring_count).w,d1
		bsr.w	Draw_SSNum

locret_796C:
		rts
; End of function Update_SSMap

; ---------------------------------------------------------------------------
SS_Pal_Map_Ptrs:
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_2
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_2
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_3
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_3
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_4
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_4
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_5
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_5
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_6
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_6
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_7
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_7
		dc.l MapUnc_SStageLayout
		dc.l Pal_SStage_8
		dc.l MapUnc_SStageLayout+$8C0
		dc.l Pal_SStage_8
		dc.l MapUnc_SStageLayout+$4600
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$3D40
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$3480
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$2BC0
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$2300
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$1A40
		dc.l Pal_SStage_1
		dc.l MapUnc_SStageLayout+$1180
		dc.l Pal_SStage_1
Pal_SStage_Main:
		binclude "General/Special Stage/Palettes/Main.bin"
		even
Pal_SStage_1:
		binclude "General/Special Stage/Palettes/3-1.bin"
		even
Pal_SStage_2:
		binclude "General/Special Stage/Palettes/3-2.bin"
		even
Pal_SStage_3:
		binclude "General/Special Stage/Palettes/3-3.bin"
		even
Pal_SStage_4:
		binclude "General/Special Stage/Palettes/3-4.bin"
		even
Pal_SStage_5:
		binclude "General/Special Stage/Palettes/3-5.bin"
		even
Pal_SStage_6:
		binclude "General/Special Stage/Palettes/3-6.bin"
		even
Pal_SStage_7:
		binclude "General/Special Stage/Palettes/3-7.bin"
		even
Pal_SStage_8:
		binclude "General/Special Stage/Palettes/3-8 S3.bin"
		even

; =============== S U B R O U T I N E =======================================


Draw_SSNum:
		lea	(SSNum_Precision).l,a2
		moveq	#3-1,d6
		lea	MapUnc_SSNum(pc),a1

loc_7BE2:
		moveq	#0,d2
		move.w	(a2)+,d3

loc_7BE6:
		sub.w	d3,d1
		bcs.s	loc_7BEE
		addq.w	#1,d2
		bra.s	loc_7BE6
; ---------------------------------------------------------------------------

loc_7BEE:
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
		dbf	d6,loc_7BE2
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

.loop:
		lea	next_object(a1),a1
		tst.l	(a1)
		dbeq	d0,.loop

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

Obj_SStage_7D70:
		move.b	#$80,width_pixels(a0)
		move.b	#$80,height_pixels(a0)
		move.w	#0,priority(a0)
		move.l	#Map_SSIcons,mappings(a0)
		move.w	#make_art_tile($589,2,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$94,y_pos(a0)
		move.l	#loc_7DA2,(a0)

loc_7DA2:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_SSIcons:
		include "General/Special Stage/Map - Icons.asm"
; ---------------------------------------------------------------------------

Obj_SStage_7DB8:
		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
		bne.w	loc_7DD4
		move.l	#loc_7DD4,(a1)
		bset	#0,status(a1)
		move.b	#1,mapping_frame(a1)

loc_7DD4:
		move.b	#$80,width_pixels(a0)
		move.b	#$80,height_pixels(a0)
		move.w	#0,priority(a0)
		move.l	#Map_GetBlueSpheres,mappings(a0)
		move.w	#make_art_tile($55F,1,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$E8,y_pos(a0)
		move.w	#3*60,$32(a0)
		move.l	#loc_7E0C,(a0)

loc_7E0C:
		tst.w	$32(a0)
		beq.s	loc_7E1C
		subq.w	#1,$32(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E1C:
		cmpi.w	#$C0,$30(a0)
		blo.s	loc_7E3C
		move.l	#loc_7E5E,(a0)
		addq.b	#2,mapping_frame(a0)
		tst.w	(Special_stage_velocity).w
		bne.s	loc_7E42
		move.b	#1,(Special_stage_advancing).w
		bra.s	loc_7E42
; ---------------------------------------------------------------------------

loc_7E3C:
		addi.w	#$10,$30(a0)

loc_7E42:
		move.w	$30(a0),d0
		btst	#0,status(a0)
		bne.s	loc_7E50
		neg.w	d0

loc_7E50:
		addi.w	#$120,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E5E:
		tst.w	(Special_stage_rings_left).w
		beq.s	loc_7E66
		rts
; ---------------------------------------------------------------------------

loc_7E66:
		subi.w	#$10,$30(a0)
		bne.s	loc_7E7A
		move.l	#loc_7E96,(a0)
		move.w	#180,$32(a0)

loc_7E7A:
		move.w	$30(a0),d0
		btst	#0,status(a0)
		bne.s	loc_7E88
		neg.w	d0

loc_7E88:
		addi.w	#$120,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E96:
		tst.w	$32(a0)
		beq.s	loc_7EA6
		subq.w	#1,$32(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7EA6:
		cmpi.w	#$C0,$30(a0)
		bhs.s	loc_7EB4
		addi.w	#$10,$30(a0)

loc_7EB4:
		move.w	$30(a0),d0
		btst	#0,status(a0)
		bne.s	loc_7EC2
		neg.w	d0

loc_7EC2:
		addi.w	#$120,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_GetBlueSpheres:
		include "General/Special Stage/Map - Get Blue Spheres.asm"
; ---------------------------------------------------------------------------

Obj_SStage_7F1C:
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.l	#Map_SStageSonic,mappings(a0)
		move.w	#make_art_tile($7D4,0,1),art_tile(a0)
		cmpi.w	#2,(Player_option).w
		bne.s	loc_7F6C
		move.l	#Map_SStageTails,mappings(a0)
		move.w	#make_art_tile($7EB,1,1),art_tile(a0)
		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
		bne.w	loc_7F6C
		move.l	#Obj_SStage_82EE,(a1)
		move.w	a0,$3E(a1)

loc_7F6C:
		move.w	#$A0,$30(a0)
		move.w	#$70,$32(a0)
		move.w	#0,$34(a0)
		move.w	#$F800,$36(a0)
		move.w	#0,$38(a0)
		bsr.w	sub_8402
		move.b	#$FF,$3A(a0)
		move.l	#loc_7F9A,(a0)

loc_7F9A:
		tst.w	(Special_stage_rate_timer).w
		beq.s	loc_7FCE
		subq.w	#1,(Special_stage_rate_timer).w
		bne.s	loc_7FCE
		move.w	#30*60,(Special_stage_rate_timer).w
		cmpi.w	#$2000,(Special_stage_rate).w
		beq.s	loc_7FCE
		addi.w	#$400,(Special_stage_rate).w
		move.b	(Special_stage_rate).w,d0
		subi.b	#$20,d0
		neg.b	d0
		add.b	d0,d0
		addq.b	#8,d0
		jsr	(Change_Music_Tempo).l

loc_7FCE:
		bsr.w	sub_8476
		moveq	#$C,d0
		move.w	(Special_stage_velocity).w,d1
		beq.s	loc_7FF8
		asr.w	#5,d1
		add.w	d1,anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame_timer(a0),d0
		bpl.s	loc_7FEE
		addi.b	#$C,d0
		bra.s	loc_7FF8
; ---------------------------------------------------------------------------

loc_7FEE:
		cmpi.b	#$C,d0
		blo.s	loc_7FF8
		subi.b	#$C,d0

loc_7FF8:
		move.b	d0,anim_frame_timer(a0)
		lea	(byte_811E).l,a1
		tst.b	(Special_stage_jumping).w
		bpl.s	loc_801C
		lea	(byte_812C).l,a1
		move.w	(Special_stage_velocity).w,d1
		bne.s	loc_801C
		move.b	(Level_frame_counter+1).w,d0
		andi.w	#3,d0

loc_801C:
		move.b	(a1,d0.w),mapping_frame(a0)
		tst.b	(Special_stage_clear_routine).w
		bne.s	loc_803E
		move.w	(Ctrl_1).w,d0
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	loc_803E
		tst.b	(Special_stage_jumping).w
		bmi.s	loc_803E
		move.b	#1,(Special_stage_jumping).w

loc_803E:
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	loc_80A2
		cmpi.b	#1,(Special_stage_jumping).w
		bne.s	loc_806E
		move.l	#-$100000,$40(a0)
		move.b	#$80,(Special_stage_jumping).w
		move.b	#0,(Special_stage_turning).w
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l

loc_806E:
		tst.b	(Special_stage_jumping).w
		bpl.s	loc_80A2
		move.l	$3C(a0),d0
		add.l	$40(a0),d0
		bmi.s	loc_8088
		moveq	#0,d0
		move.l	d0,$40(a0)
		move.b	d0,(Special_stage_jumping).w

loc_8088:
		move.w	(Special_stage_rate).w,d1
		ext.l	d1
		lsl.l	#4,d1
		add.l	d1,$40(a0)
		move.l	d0,$3C(a0)
		swap	d0
		addi.w	#-$800,d0
		move.w	d0,$36(a0)

loc_80A2:
		bsr.w	sub_8402
		bsr.w	sub_8434
		jsr	(Draw_Sprite).l
		lea	(PLC_SStageSonic).l,a2
		move.l	#ArtUnc_SStageSonic,d6
		move.w	#tiles_to_bytes($7D4),d4
		cmpi.w	#2,(Player_option).w
		bne.s	loc_80D8
		lea	(PLC_SStageTails).l,a2
		move.l	#ArtUnc_SStageTails,d6
		move.w	#tiles_to_bytes($7EB),d4

loc_80D8:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	$3A(a0),d0
		beq.s	locret_811C
		move.b	d0,$3A(a0)
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_811C

loc_80F4:
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
		dbf	d5,loc_80F4

locret_811C:
		rts
; ---------------------------------------------------------------------------
byte_811E:
		dc.b    2,   6,   7,   8,   7,   6,   2,   3,   4,   5,   4,   3,   1,   0
byte_812C:
		dc.b    9,  $B,  $A,  $B,   9,  $B,  $A,  $B,   9,  $B,  $A,  $B,  $B,   0
byte_813A:
		dc.b    9,  $A,  $B,   9,  $A,  $B,   9,  $A,  $B,   9,  $A,  $B,  $B,   0
		even
; ---------------------------------------------------------------------------

Obj_SStage_8148:
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
		bsr.w	sub_82CE
		jsr	(AllocateObjectAfterCurrent_SpecialStage).l
		bne.w	loc_81AA
		move.l	#Obj_SStage_82EE,(a1)
		move.w	a0,$3E(a1)

loc_81AA:
		move.l	#loc_81B0,(a0)

loc_81B0:
		moveq	#$C,d0
		move.w	(Special_stage_velocity).w,d1
		beq.s	loc_81D6
		asr.w	#5,d1
		add.w	d1,anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame_timer(a0),d0
		bpl.s	loc_81CC
		addi.b	#$C,d0
		bra.s	loc_81D6
; ---------------------------------------------------------------------------

loc_81CC:
		cmpi.b	#$C,d0
		blo.s	loc_81D6
		subi.b	#$C,d0

loc_81D6:
		move.b	d0,anim_frame_timer(a0)
		lea	(byte_811E).l,a1
		tst.b	(Special_stage_jumping_P2).w
		beq.s	loc_81FA
		lea	(byte_813A).l,a1
		move.w	(Special_stage_velocity).w,d1
		bne.s	loc_81FA
		move.b	(Level_frame_counter+1).w,d0
		andi.w	#3,d0

loc_81FA:
		move.b	(a1,d0.w),mapping_frame(a0)
		bsr.w	sub_8272
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	loc_8226
		tst.b	(Special_stage_jumping_P2).w
		bne.s	loc_8226
		move.l	#$FFF00000,$40(a0)
		move.b	#1,(Special_stage_jumping_P2).w
		moveq	#signextendB(sfx_Jump),d0
		jsr	(Play_SFX).l

loc_8226:
		move.l	$3C(a0),d0
		add.l	$40(a0),d0
		bmi.s	loc_823A
		moveq	#0,d0
		move.l	d0,$40(a0)
		move.b	d0,(Special_stage_jumping_P2).w

loc_823A:
		move.w	(Special_stage_rate).w,d1
		ext.l	d1
		lsl.l	#4,d1
		add.l	d1,$40(a0)
		move.l	d0,$3C(a0)
		swap	d0
		addi.w	#-$800,d0
		move.w	d0,$36(a0)
		bsr.w	sub_8434
		jsr	(Draw_Sprite).l
		lea	(PLC_SStageTails).l,a2
		move.l	#ArtUnc_SStageTails,d6
		move.w	#tiles_to_bytes($7EB),d4
		bra.w	loc_80D8

; =============== S U B R O U T I N E =======================================


sub_8272:
		move.w	(Pos_table_index).w,d0
		lea	(Pos_table).w,a1
		lea	(a1,d0.w),a1
		move.w	(Ctrl_1).w,(a1)
		move.b	(Special_stage_jumping).w,2(a1)
		addq.b	#4,(Pos_table_index+1).w
		move.b	(Ctrl_2_held).w,d0
		andi.b	#$7F,d0
		beq.s	loc_829C
		move.w	#600,(Tails_CPU_idle_timer).w

loc_829C:
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	loc_82AC
		subq.w	#1,(Tails_CPU_idle_timer).w
		move.w	(Ctrl_2).w,d0
		rts
; ---------------------------------------------------------------------------

loc_82AC:
		lea	(Pos_table).w,a1
		move.w	#8,d1
		lsl.b	#2,d1
		addq.b	#4,d1
		move.w	(Pos_table_index).w,d0
		sub.b	d1,d0
		move.b	2(a1,d0.w),d1
		moveq	#0,d0
		tst.b	d1
		bpl.s	locret_82CC
		move.w	#$70,d0

locret_82CC:
		rts
; End of function sub_8272


; =============== S U B R O U T I N E =======================================


sub_82CE:
		lea	(Pos_table).w,a2
		move.w	#bytesToLcnt($100),d0

loc_82D6:
		move.l	#0,(a2)+
		dbf	d0,loc_82D6
		move.w	#0,(Pos_table_index).w
		move.w	#0,(Tails_CPU_idle_timer).w
		rts
; End of function sub_82CE

; ---------------------------------------------------------------------------

Obj_SStage_82EE:
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
		move.l	#loc_8332,(a0)

loc_8332:
		movea.w	$3E(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.w	#$2AAA,d0
		move.w	(Special_stage_velocity).w,d1
		bmi.s	loc_834E
		add.w	d1,d0

loc_834E:
		add.w	d0,anim_frame_timer(a0)
		bcc.s	loc_8366
		move.b	mapping_frame(a0),d0
		addq.b	#1,d0
		cmpi.b	#$F,d0
		blo.s	loc_8362
		moveq	#1,d0

loc_8362:
		move.b	d0,mapping_frame(a0)

loc_8366:
		jsr	(Draw_Sprite).l
		lea	(PLC_SStageTailstails).l,a2
		move.l	#ArtUnc_SStageTailstails,d6
		move.w	#tiles_to_bytes($7B0),d4
		bra.w	loc_80D8
; ---------------------------------------------------------------------------

Obj_SStage_8380:
		move.w	#0,$34(a0)
		move.w	#$F800,$36(a0)
		move.w	#0,$38(a0)

loc_8392:
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$380,priority(a0)
		move.l	#Map_SStageShadow,mappings(a0)
		move.w	#make_art_tile($7A0,3,1),art_tile(a0)
		move.w	#$A0,$30(a0)
		move.w	#$70,$32(a0)
		move.b	#-1,$3A(a0)
		bsr.w	sub_8434
		move.l	#loc_83D6,(a0)
		rts
; ---------------------------------------------------------------------------

loc_83D6:
		tst.b	(Special_stage_fade_timer).w
		beq.s	loc_83DE
		rts
; ---------------------------------------------------------------------------

loc_83DE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SStage_83E4:
		move.w	#0,$34(a0)
		move.w	#$F800,$36(a0)
		move.w	#$FFE0,$38(a0)
		bra.s	loc_8392
; ---------------------------------------------------------------------------
Map_SStageShadow:
		include "General/Special Stage/Map - Shadow.asm"

; =============== S U B R O U T I N E =======================================


sub_8402:
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
; End of function sub_8402


; =============== S U B R O U T I N E =======================================


sub_8434:
		move.w	$34(a0),d1
		move.w	$36(a0),d2
		move.w	$38(a0),d0
		bsr.w	sub_8FE4
		bsr.w	sub_8FBA
		bsr.w	sub_8F90
		addi.w	#$100,d0
		addi.w	#$980,d2
		bsr.w	sub_900E
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
; End of function sub_8434


; =============== S U B R O U T I N E =======================================


sub_8476:
		tst.b	(Special_stage_fade_timer).w
		beq.s	loc_84A4
		cmpi.b	#$61,(Special_stage_fade_timer).w
		bhs.s	loc_8490
		moveq	#8,d1
		add.b	d1,(Special_stage_angle).w
		addq.b	#1,(Special_stage_fade_timer).w
		rts
; ---------------------------------------------------------------------------

loc_8490:
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		beq.s	loc_84A4
		move.b	#0,(Special_stage_fade_timer).w

loc_84A4:
		move.w	(Special_stage_X_pos).w,d3
		btst	#6,(Special_stage_angle).w
		bne.s	loc_84B4
		move.w	(Special_stage_Y_pos).w,d3

loc_84B4:
		moveq	#0,d2
		move.b	(Special_stage_turning).w,d1
		beq.s	loc_84F0
		andi.w	#$E0,d3
		bne.s	loc_84F0
		tst.b	(Special_stage_jumping).w
		bmi.s	loc_84FC
		add.b	d1,(Special_stage_angle).w
		move.b	(Special_stage_angle).w,d0
		andi.b	#$3F,d0
		bne.w	locret_85FC
		move.b	#0,(Special_stage_turning).w
		move.b	#0,(Special_stage_bumper_lock).w
		tst.w	(Special_stage_velocity).w
		beq.s	loc_84F0
		move.b	#1,(Special_stage_turn_lock).w

loc_84F0:
		andi.w	#$E0,d3
		beq.s	loc_84FC
		move.b	#0,(Special_stage_turn_lock).w

loc_84FC:
		move.b	(Ctrl_1_held).w,d1
		move.w	(Special_stage_velocity).w,d2
		tst.b	(Special_stage_clear_routine).w
		bne.w	loc_85D4
		tst.b	(Special_stage_bumper_lock).w
		bne.s	loc_8532
		btst	#0,d1
		beq.s	loc_851E
		move.b	#1,(Special_stage_advancing).w

loc_851E:
		tst.b	(Special_stage_advancing).w
		beq.s	loc_8532
		move.w	(Special_stage_rate).w,d3
		addi.w	#$200,d2
		cmp.w	d3,d2
		blt.s	loc_8532
		move.w	d3,d2

loc_8532:
		tst.b	(Special_stage_turn_lock).w
		bne.s	loc_8550
		btst	#2,d1
		beq.s	loc_8544
		move.b	#4,(Special_stage_turning).w

loc_8544:
		btst	#3,d1
		beq.s	loc_8550
		move.b	#-4,(Special_stage_turning).w

loc_8550:
		move.w	d2,(Special_stage_velocity).w
		tst.b	(Special_stage_bumper_lock).w
		beq.s	loc_85D4
		move.w	(Special_stage_X_pos).w,d0
		btst	#6,(Special_stage_angle).w
		bne.s	loc_856A
		move.w	(Special_stage_Y_pos).w,d0

loc_856A:
		andi.w	#$E0,d0
		bne.s	loc_85AE
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
		beq.s	loc_85AE
		move.b	#0,(Special_stage_bumper_lock).w
		move.w	(Special_stage_rate).w,d2
		tst.w	(Special_stage_velocity).w
		bmi.s	loc_85A8
		neg.w	d2

loc_85A8:
		move.w	d2,(Special_stage_velocity).w
		rts
; ---------------------------------------------------------------------------

loc_85AE:
		move.w	(Special_stage_velocity).w,d2
		bne.s	loc_85D2
		move.b	#0,(Special_stage_bumper_lock).w
		move.b	#1,(Special_stage_advancing).w
		move.w	(Special_stage_rate).w,d2
		tst.w	(Special_stage_velocity).w
		bmi.s	loc_85CC
		neg.w	d2

loc_85CC:
		move.w	d2,(Special_stage_velocity).w
		bra.s	loc_85D4
; ---------------------------------------------------------------------------

loc_85D2:
		neg.w	d2

loc_85D4:
		move.b	(Special_stage_angle).w,d0
		jsr	(GetSineCosine).l
		muls.w	d2,d0
		muls.w	d2,d1
		swap	d0
		sub.w	d0,(Special_stage_X_pos).w
		swap	d1
		sub.w	d1,(Special_stage_Y_pos).w
		tst.b	(Special_stage_jumping).w
		bmi.s	locret_85FC
		tst.b	(Special_stage_clear_routine).w
		bne.s	locret_85FC
		bsr.s	sub_85FE

locret_85FC:
		rts
; End of function sub_8476


; =============== S U B R O U T I N E =======================================


sub_85FE:
		lea	(Level_layout_header).w,a1
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
		beq.w	locret_872E
		cmpi.b	#1,d2
		bne.s	loc_866E
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		bne.s	locret_866C
		tst.b	(Special_stage_fade_timer).w
		bne.s	locret_866C
		move.b	#1,(Special_stage_fade_timer).w
		move.b	#$48,(Game_mode).w
		tst.b	(Special_bonus_entry_flag).w
		beq.s	loc_8664
		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
		ori.b	#$80,(Last_star_post_hit).w

loc_8664:
		moveq	#signextendB(sfx_Goal),d0
		jsr	(Play_SFX).l

locret_866C:
		rts
; ---------------------------------------------------------------------------

loc_866E:
		cmpi.b	#2,d2
		bne.s	loc_868C
		bsr.w	Find_SStageCollisionResponseSlot
		bne.s	loc_8682
		move.b	#2,(a2)
		move.l	a1,4(a2)

loc_8682:
		moveq	#signextendB(sfx_BlueSphere),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_868C:
		cmpi.b	#3,d2
		bne.s	loc_86B2
		tst.b	(Special_stage_bumper_lock).w
		bne.s	loc_86B2
		move.w	d1,(Special_stage_interact).w
		move.b	#1,(Special_stage_bumper_lock).w
		move.b	#0,(Special_stage_advancing).w
		moveq	#signextendB(sfx_Bumper),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_86B2:
		cmpi.b	#4,d2
		bne.s	locret_872E
		bsr.w	Find_SStageCollisionResponseSlot
		bne.s	loc_86C6
		move.b	#1,(a2)
		move.l	a1,4(a2)

loc_86C6:
		subq.w	#1,(Special_stage_rings_left).w
		bne.s	loc_86D4
		moveq	#signextendB(sfx_Perfect),d0
		jsr	(Play_Music).l

loc_86D4:
		addi.w	#1,(Special_stage_ring_count).w
		bset	#7,(Special_stage_extra_life_flags).w
		cmpi.w	#50,(Special_stage_ring_count).w
		blo.s	loc_86FE
		bset	#0,(Special_stage_extra_life_flags).w
		bne.s	loc_86FE
		addq.b	#1,(Continue_count).w
		move.w	#$FF00|sfx_Continue,d0
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------

loc_86FE:
		moveq	#signextendB(sfx_RingRight),d0
		cmpi.w	#100,(Special_stage_ring_count).w
		blo.s	loc_8726
		bset	#1,(Special_stage_extra_life_flags).w
		beq.s	loc_8720
		cmpi.w	#200,(Special_stage_ring_count).w
		blo.s	loc_8726
		bset	#2,(Special_stage_extra_life_flags).w
		bne.s	loc_8726

loc_8720:
		addq.b	#1,(Life_count).w
		moveq	#signextendB(sfx_RingLoss),d0

loc_8726:
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

locret_872E:
		rts
; End of function sub_85FE

; ---------------------------------------------------------------------------
word_8730:
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
		lea	word_8730(pc,d0.w),a5
		moveq	#0,d1
		move.b	(Special_stage_X_pos).w,d1
		move.w	(Special_stage_X_pos).w,d0
		addi.w	#$100,d0
		move.w	(Special_stage_Y_pos).w,d2
		andi.w	#$100,d2
		add.w	d2,d0
		btst	#6,(Special_stage_angle).w
		bne.s	loc_87B0
		move.b	(Special_stage_Y_pos).w,d1
		move.w	(Special_stage_Y_pos).w,d0
		move.w	(Special_stage_X_pos).w,d2
		andi.w	#$100,d2
		add.w	d2,d0

loc_87B0:
		tst.b	(Special_stage_angle).w
		bmi.s	loc_87C6
		neg.w	d0
		addi.w	#$1F,d0
		move.w	d0,d2
		andi.w	#$E0,d2
		beq.s	loc_87C6
		addq.b	#1,d1

loc_87C6:
		andi.w	#$1E0,d0
		lsr.w	#5,d0
		move.w	d0,(Special_stage_anim_frame).w
		move.b	d0,(Special_stage_palette_frame).w
		move.b	(Special_stage_angle).w,d0
		andi.w	#$38,d0
		beq.s	loc_87E8
		lsr.w	#3,d0
		addi.w	#$F,d0
		move.w	d0,(Special_stage_anim_frame).w

loc_87E8:
		lea	(Draw_SSSprite_Normal).l,a0
		tst.w	(Special_stage_clear_timer).w
		beq.s	loc_87FA
		lea	(Draw_SSSprite_FlyAway).l,a0

loc_87FA:
		btst	#6,(Special_stage_angle).w
		bne.w	loc_88BC
		move.w	2(a5),d5
		add.w	d1,d5
		and.w	$A(a5),d5
		move.w	(Special_stage_anim_frame).w,d0
		add.w	d0,d0
		add.w	d0,d0
		lea	(SStage_PerspectiveMapPtrs).l,a1
		movea.l	(a1,d0.w),a1
		lea	(Level_layout_header).w,a2
		lea	(SStage_extra_sprites).w,a4
		lea	(Sprite_table).w,a6
		moveq	#$50-1,d7
		moveq	#0,d6
		move.b	(Sprites_drawn).w,d6
		sub.b	d6,d7
		lsl.w	#3,d6
		adda.w	d6,a6
		moveq	#$10-1,d2

loc_883C:
		move.w	(a5),d4
		moveq	#0,d0
		move.b	(Special_stage_X_pos).w,d0
		add.w	d0,d4
		and.w	6(a5),d4
		moveq	#$F-1,d3

loc_884C:
		move.w	d5,d0
		lsl.w	#5,d0
		or.b	d4,d0
		move.b	(a2,d0.w),d0
		beq.s	loc_88A0
		move.w	(a1),d1
		andi.w	#$7C,d1
		beq.s	loc_88A0
		lsr.w	#2,d1
		subq.w	#6,d1
		cmpi.w	#$10,d1
		bhs.s	loc_88A0
		add.w	d1,d1
		andi.w	#$FF,d0
		lsl.w	#3,d0
		movea.l	(a4,d0.w),a3
		move.w	4(a4,d0.w),d6
		cmpi.w	#$54,(a1)
		blo.s	loc_8884
		andi.w	#$7FFF,d6

loc_8884:
		move.w	6(a4,d0.w),d0
		add.w	d0,d0
		bcc.s	loc_888E
		moveq	#0,d1

loc_888E:
		add.w	d0,d1
		adda.w	(a3,d1.w),a3
		move.w	(a3)+,d1
		subq.w	#1,d1
		bmi.s	loc_88A0
		jsr	(a0)
		tst.w	d7
		bmi.s	locret_88BA

loc_88A0:
		addq.w	#6,a1
		add.w	4(a5),d4
		and.w	6(a5),d4
		dbf	d3,loc_884C
		add.w	8(a5),d5
		and.w	$A(a5),d5
		dbf	d2,loc_883C

locret_88BA:
		rts
; ---------------------------------------------------------------------------

loc_88BC:
		move.w	2(a5),d5
		add.w	d1,d5
		and.w	$A(a5),d5
		move.w	(Special_stage_anim_frame).w,d0
		add.w	d0,d0
		add.w	d0,d0
		lea	(SStage_PerspectiveMapPtrs).l,a1
		movea.l	(a1,d0.w),a1
		lea	(Level_layout_header).w,a2
		lea	(SStage_extra_sprites).w,a4
		lea	(Sprite_table).w,a6
		moveq	#$50-1,d7
		moveq	#0,d6
		move.b	(Sprites_drawn).w,d6
		sub.b	d6,d7
		lsl.w	#3,d6
		adda.w	d6,a6
		moveq	#$10-1,d2

loc_88F4:
		move.w	(a5),d4
		moveq	#0,d0
		move.b	(Special_stage_Y_pos).w,d0
		add.w	d0,d4
		and.w	6(a5),d4
		moveq	#$F-1,d3

loc_8904:
		move.w	d4,d0
		lsl.w	#5,d0
		or.b	d5,d0
		move.b	(a2,d0.w),d0
		beq.s	loc_8958
		move.w	(a1),d1
		andi.w	#$7C,d1
		beq.s	loc_8958
		lsr.w	#2,d1
		subq.w	#6,d1
		cmpi.w	#$10,d1
		bhs.s	loc_8958
		add.w	d1,d1
		andi.w	#$FF,d0
		lsl.w	#3,d0
		movea.l	(a4,d0.w),a3
		move.w	4(a4,d0.w),d6
		cmpi.w	#$54,(a1)
		blo.s	loc_893C
		andi.w	#$7FFF,d6

loc_893C:
		move.w	6(a4,d0.w),d0
		add.w	d0,d0
		bcc.s	loc_8946
		moveq	#0,d1

loc_8946:
		add.w	d0,d1
		adda.w	(a3,d1.w),a3
		move.w	(a3)+,d1
		subq.w	#1,d1
		bmi.s	loc_8958
		jsr	(a0)
		tst.w	d7
		bmi.s	locret_8972

loc_8958:
		addq.w	#6,a1
		add.w	4(a5),d4
		and.w	6(a5),d4
		dbf	d3,loc_8904
		add.w	8(a5),d5
		and.w	$A(a5),d5
		dbf	d2,loc_88F4

locret_8972:
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
		blo.s	loc_89D6
		move.w	#1,d0

loc_89D6:
		move.w	(sp)+,d1
		move.w	d0,(a6)+
		subq.w	#1,d7
		dbmi	d1,Draw_SSSprite_FlyAway
		rts

; =============== S U B R O U T I N E =======================================


sub_89E2:
		move.b	(Special_stage_clear_routine).w,d1
		beq.w	locret_8B58
		subq.b	#1,d1
		bne.w	loc_8AB6
		cmpi.w	#$100,(Special_stage_clear_timer).w
		bhs.s	loc_8A26
		addq.w	#2,(Special_stage_clear_timer).w
		cmpi.w	#2,(Special_stage_clear_timer).w
		bne.s	loc_8A0C
		moveq	#signextendB(sfx_AllSpheres),d0
		jsr	(Play_Music).l

loc_8A0C:
		cmpi.w	#$40,(Special_stage_clear_timer).w
		blo.s	locret_8A24
		addq.w	#1,(Special_stage_clear_timer).w
		cmpi.w	#$80,(Special_stage_clear_timer).w
		blo.s	locret_8A24
		addq.w	#1,(Special_stage_clear_timer).w

locret_8A24:
		rts
; ---------------------------------------------------------------------------

loc_8A26:
		addq.b	#1,(Special_stage_clear_routine).w
		lea	(Level_layout_header).w,a1
		move.w	#bytesToLcnt($400),d0

loc_8A32:
		move.l	#0,(a1)+
		dbf	d0,loc_8A32
		move.b	(Special_stage_angle).w,d0
		jsr	(GetSineCosine).l
		move.w	(Special_stage_X_pos).w,d2
		move.w	(Special_stage_Y_pos).w,d3
		asl.w	#3,d0
		asl.w	#3,d1
		sub.w	d0,d2
		sub.w	d1,d3
		lea	(Level_layout_header).w,a1
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
		move.b	#$A,(a1,d1.w)
		move.w	d1,(Special_stage_interact).w
		move.w	#$800,(Special_stage_velocity).w
		move.b	#120,(Special_stage_emerald_timer).w
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
		lea	(Pal_SStage_Emeralds).l,a1
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		lea	(Normal_palette_line_4+$4).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		lea	(ArtKosM_SStageChaosEmerald).l,a1
		move.w	#tiles_to_bytes($5A7),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_8AB6:
		subq.b	#1,d1
		bne.s	loc_8ADA
		tst.b	(Kos_modules_left).w
		bne.s	locret_8AD8
		move.w	#0,(Special_stage_clear_timer).w
		subq.b	#1,(Special_stage_emerald_timer).w
		bne.s	locret_8AD8
		addq.b	#1,(Special_stage_clear_routine).w
		moveq	#signextendB(mus_Emerald),d0
		jsr	(Play_Music).l

locret_8AD8:
		rts
; ---------------------------------------------------------------------------

loc_8ADA:
		subq.b	#1,d1
		bne.s	locret_8B58
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
		bne.s	locret_8B58
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		bne.s	locret_8B58
		cmpi.w	#7,(Chaos_emerald_count).w
		bhs.s	loc_8B2E
		addq.w	#1,(Chaos_emerald_count).w
		lea	(Collected_emeralds_array).w,a1
		moveq	#0,d0
		move.b	(Current_special_stage).w,d0
		move.b	#1,(a1,d0.w)

loc_8B2E:
		addq.b	#1,(Special_stage_clear_routine).w
		move.b	#1,(Special_stage_fade_timer).w
		move.b	#$48,(Game_mode).w
		tst.b	(Special_bonus_entry_flag).w
		beq.s	loc_8B50
		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
		ori.b	#$80,(Last_star_post_hit).w

loc_8B50:
		moveq	#signextendB(sfx_Goal),d0
		jsr	(Play_SFX).l

locret_8B58:
		rts
; End of function sub_89E2

; ---------------------------------------------------------------------------
Pal_SStage_Emeralds:
		binclude "General/Special Stage/Palettes/Emeralds S3.bin"
		even

; =============== S U B R O U T I N E =======================================


sub_8B9A:
		move.w	(Special_stage_X_pos).w,d0
		sub.w	(Special_stage_prev_X_pos).w,d0
		btst	#6,(Special_stage_angle).w
		bne.s	loc_8BB2
		move.w	(Special_stage_Y_pos).w,d0
		sub.w	(Special_stage_prev_Y_pos).w,d0

loc_8BB2:
		tst.b	(Special_stage_angle).w
		bmi.s	loc_8BBA
		neg.w	d0

loc_8BBA:
		asr.w	#2,d0
		add.w	d0,(V_scroll_value_BG).w
		moveq	#0,d1
		move.b	(Special_stage_angle).w,d1
		asl.w	#2,d1
		move.w	d1,(H_scroll_buffer+2).w
		move.w	(Special_stage_X_pos).w,(Special_stage_prev_X_pos).w
		move.w	(Special_stage_Y_pos).w,(Special_stage_prev_Y_pos).w
		rts
; End of function sub_8B9A


; =============== S U B R O U T I N E =======================================


Animate_SSRings:
		lea	(SStage_extra_sprites+$07).w,a1
		subq.b	#1,(Rings_frame_timer).w
		bpl.s	loc_8BFE
		move.b	#7,(Rings_frame_timer).w
		addi.b	#$10,(Rings_frame).w
		cmpi.b	#$30,(Rings_frame).w
		blo.s	loc_8BFE
		move.b	#0,(Rings_frame).w

loc_8BFE:
		move.b	(Rings_frame).w,anim(a1)
		rts
; End of function Animate_SSRings


; =============== S U B R O U T I N E =======================================


Find_SStageCollisionResponseSlot:
		lea	(SStage_collision_response_list).w,a2
		move.w	#$20-1,d0

loc_8C0E:
		tst.b	(a2)
		beq.s	locret_8C18
		addq.w	#8,a2
		dbf	d0,loc_8C0E

locret_8C18:
		rts
; End of function Find_SStageCollisionResponseSlot


; =============== S U B R O U T I N E =======================================


Touch_SSSprites:
		lea	(SStage_collision_response_list).w,a0
		move.w	#$20-1,d7

loc_8C22:
		moveq	#0,d0
		move.b	(a0),d0
		beq.s	loc_8C30
		lsl.w	#2,d0
		movea.l	off_8C38-4(pc,d0.w),a1
		jsr	(a1)

loc_8C30:
		addq.w	#8,a0
		dbf	d7,loc_8C22
		rts
; End of function Touch_SSSprites

; ---------------------------------------------------------------------------
off_8C38:
		dc.l Touch_SSSprites_Ring
		dc.l Touch_SSSprites_BlueSphere
; ---------------------------------------------------------------------------

Touch_SSSprites_Ring:
		subq.b	#1,2(a0)
		bpl.s	locret_8C68
		move.b	#5,2(a0)
		moveq	#0,d0
		move.b	3(a0),d0
		addq.b	#1,3(a0)
		movea.l	4(a0),a1
		move.b	byte_8C6A(pc,d0.w),d0
		move.b	d0,(a1)
		bne.s	locret_8C68
		clr.l	(a0)
		clr.l	4(a0)

locret_8C68:
		rts
; ---------------------------------------------------------------------------
byte_8C6A:
		dc.b    5,   6,   7,   8,   0
		even
; ---------------------------------------------------------------------------

Touch_SSSprites_BlueSphere:
		subq.b	#1,2(a0)
		bpl.s	locret_8CC2
		move.b	#9,2(a0)
		movea.l	4(a0),a1
		cmpi.b	#2,(a1)
		bne.s	loc_8C9E
		bsr.w	sub_8CC4
		move.b	#9,(a1)
		bsr.s	sub_8CF8
		beq.s	locret_8C9C
		move.b	#4,(a1)
		clr.l	(a0)
		clr.l	4(a0)

locret_8C9C:
		rts
; ---------------------------------------------------------------------------

loc_8C9E:
		move.b	#0,2(a0)
		move.w	(Special_stage_X_pos).w,d0
		or.w	(Special_stage_Y_pos).w,d0
		andi.w	#$E0,d0
		beq.s	locret_8CC2
		cmpi.b	#9,(a1)
		bne.s	loc_8CBC
		move.b	#1,(a1)

loc_8CBC:
		clr.l	(a0)
		clr.l	4(a0)

locret_8CC2:
		rts

; =============== S U B R O U T I N E =======================================


sub_8CC4:
		move.w	d0,-(sp)
		move.b	#-1,(Special_stage_sphere_HUD_flag).w
		subq.w	#1,(Special_stage_spheres_left).w
		bne.s	loc_8CD8
		move.b	#1,(Special_stage_clear_routine).w

loc_8CD8:
		move.w	(sp)+,d0
		rts
; End of function sub_8CC4


; =============== S U B R O U T I N E =======================================


sub_8CDC:
		lea	(Level_layout_header).w,a3
		moveq	#0,d1
		move.w	#$400-1,d0

loc_8CE6:
		cmpi.b	#2,(a3)+
		bne.s	loc_8CEE
		addq.w	#1,d1

loc_8CEE:
		dbf	d0,loc_8CE6
		move.w	d1,(Special_stage_spheres_left).w
		rts
; End of function sub_8CDC


; =============== S U B R O U T I N E =======================================


sub_8CF8:
		lea	(Level_layout_header).w,a2
		move.l	a1,d5
		sub.l	a2,d5
		bsr.s	sub_8D78
		moveq	#0,d6
		move.l	a5,d1
		lea	(SStage_unkA500).w,a4
		sub.l	a4,d1
		beq.s	locret_8D76

loc_8D0E:
		move.w	(a4)+,d5
		lea	(word_8EDA).l,a3
		move.w	#8-1,d0

loc_8D1A:
		move.w	(a3)+,d2
		add.w	d5,d2
		cmpi.b	#2,(a2,d2.w)
		bne.s	loc_8D34
		bsr.w	sub_8CC4
		move.b	#4,(a2,d2.w)
		move.w	d2,(a5)+
		addq.w	#2,d1

loc_8D34:
		dbf	d0,loc_8D1A
		subq.w	#2,d1
		bne.s	loc_8D0E
		move.l	a5,d1
		lea	(SStage_unkA500).w,a4
		sub.l	a4,d1
		beq.s	locret_8D76

loc_8D46:
		move.w	(a4)+,d5
		lea	(word_8EDA).l,a3
		move.w	#8-1,d0

loc_8D52:
		move.w	(a3)+,d2
		add.w	d5,d2
		cmpi.b	#1,(a2,d2.w)
		bne.s	loc_8D64
		move.b	#4,(a2,d2.w)

loc_8D64:
		dbf	d0,loc_8D52
		subq.w	#2,d1
		bne.s	loc_8D46
		moveq	#signextendB(sfx_RingLoss),d0
		jsr	(Play_SFX).l
		moveq	#1,d1

locret_8D76:
		rts
; End of function sub_8CF8


; =============== S U B R O U T I N E =======================================


sub_8D78:
		lea	(SStage_unkA500).w,a5
		lea	(word_8EDA).l,a3
		moveq	#0,d2
		move.w	#8-1,d0

loc_8D88:
		move.w	(a3)+,d1
		add.w	d5,d1
		cmpi.b	#9,(a2,d1.w)
		bne.s	loc_8D9A
		move.b	#1,(a2,d1.w)

loc_8D9A:
		cmpi.b	#2,(a2,d1.w)
		bne.s	loc_8DA4
		addq.w	#1,d2

loc_8DA4:
		dbf	d0,loc_8D88
		tst.w	d2
		beq.w	locret_8E8A
		moveq	#0,d2
		move.w	d5,d1

loc_8DB2:
		addq.w	#1,d2
		addi.w	#-1,d1
		tst.b	(a2,d1.w)
		bne.s	loc_8DB2
		move.w	d5,d1

loc_8DC0:
		addq.w	#1,d2
		addi.w	#1,d1
		tst.b	(a2,d1.w)
		bne.s	loc_8DC0
		cmpi.w	#4,d2
		blo.w	locret_8E8A
		moveq	#0,d2
		move.w	d5,d1

loc_8DD8:
		addq.w	#1,d2
		addi.w	#-$20,d1
		tst.b	(a2,d1.w)
		bne.s	loc_8DD8
		move.w	d5,d1

loc_8DE6:
		addq.w	#1,d2
		addi.w	#$20,d1
		tst.b	(a2,d1.w)
		bne.s	loc_8DE6
		cmpi.w	#4,d2
		blo.w	locret_8E8A
		lea	(SStage_unkA600).w,a4
		lea	(word_8EEA).l,a3
		moveq	#0,d6
		moveq	#0,d3
		moveq	#6,d4
		add.w	d3,d4
		move.w	d5,d0

loc_8E0E:
		move.w	(a3,d4.w),d1
		add.w	d0,d1
		move.b	(a2,d1.w),d2
		cmpi.b	#$89,d2
		beq.s	loc_8E8C
		cmpi.b	#1,d2
		bne.s	loc_8E68
		cmpi.w	#2,d6
		blo.s	loc_8E48
		move.w	d1,d2
		sub.w	-6(a4),d2
		cmpi.w	#-1,d2
		beq.s	loc_8E68
		cmpi.w	#1,d2
		beq.s	loc_8E68
		cmpi.w	#$20,d2
		beq.s	loc_8E68
		cmpi.w	#-$20,d2
		beq.s	loc_8E68

loc_8E48:
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
		bra.s	loc_8E0E
; ---------------------------------------------------------------------------

loc_8E68:
		subq.w	#2,d4
		cmp.w	d3,d4
		bge.s	loc_8E0E

loc_8E6E:
		moveq	#0,d3
		moveq	#0,d4
		move.w	-(a4),d0
		move.b	-(a4),d4
		move.b	-(a4),d3
		subq.w	#1,d6
		bcs.s	locret_8E8A
		andi.b	#$7F,(a2,d0.w)
		subq.w	#2,d4
		cmp.w	d3,d4
		bge.s	loc_8E0E
		bra.s	loc_8E6E
; ---------------------------------------------------------------------------

locret_8E8A:
		rts
; ---------------------------------------------------------------------------

loc_8E8C:
		movem.l	d0/d3/d6/a4,-(sp)
		sub.w	d5,d0
		move.w	d0,d2
		neg.w	d2
		lea	(SStage_unkA600+6).w,a4
		move.w	d5,d3

loc_8E9C:
		move.w	(a4)+,d0
		addq.w	#2,a4
		sub.w	d3,d0
		cmp.w	d2,d0
		bne.s	loc_8EAA
		add.w	d0,d3
		bra.s	loc_8E9C
; ---------------------------------------------------------------------------

loc_8EAA:
		add.w	d5,d0
		cmpi.b	#2,(a2,d0.w)
		beq.s	loc_8EC8
		cmpi.b	#4,(a2,d0.w)
		beq.s	loc_8ED4
		sub.w	d2,d0
		cmpi.b	#2,(a2,d0.w)
		beq.s	loc_8EC8
		bra.s	loc_8ED4
; ---------------------------------------------------------------------------

loc_8EC8:
		bsr.w	sub_8CC4
		move.b	#4,(a2,d0.w)
		move.w	d0,(a5)+

loc_8ED4:
		movem.l	(sp)+,d0/d3/d6/a4
		bra.s	loc_8E68
; End of function sub_8D78

; ---------------------------------------------------------------------------
word_8EDA:
		dc.w   -$21
		dc.w   -$20
		dc.w   -$1F
		dc.w     -1
		dc.w      1
		dc.w    $1F
		dc.w    $20
		dc.w    $21
word_8EEA:
		dc.w     -1
		dc.w   -$20
		dc.w      1
		dc.w    $20
		dc.w     -1
		dc.w   -$20

; =============== S U B R O U T I N E =======================================


Load_SSSprite_Mappings:
		lea	(SStage_extra_sprites).w,a1
		lea	(MapPtr_8F1A).l,a0
		moveq	#$D-1,d1

loc_8F02:
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		dbf	d1,loc_8F02
		lea	(SStage_collision_response_list).w,a1
		move.w	#$40-1,d1

loc_8F12:
		clr.l	(a1)+
		dbf	d1,loc_8F12
		rts
; End of function Load_SSSprite_Mappings

; ---------------------------------------------------------------------------
MapPtr_8F1A:
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
		dc.l Map_SStageSphere
		dc.w make_art_tile($680,2,1), $0000
; ---------------------------------------------------------------------------
		ext.l	d1
		lsl.l	#8,d1
		divs.w	d0,d1
		ext.l	d2
		lsl.l	#8,d2
		divs.w	d0,d2
		rts

; =============== S U B R O U T I N E =======================================


sub_8F90:
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
; End of function sub_8F90


; =============== S U B R O U T I N E =======================================


sub_8FBA:
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
; End of function sub_8FBA


; =============== S U B R O U T I N E =======================================


sub_8FE4:
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
; End of function sub_8FE4


; =============== S U B R O U T I N E =======================================


sub_900E:
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
; End of function sub_900E


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
; ---------------------------------------------------------------------------

locret_952E:
		rts
