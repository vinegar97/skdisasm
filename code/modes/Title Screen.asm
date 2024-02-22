Title_Screen:
		moveq	#signextendB(mus_FadeOut),d0
		bsr.w	Play_Music			; Fade music if any is playing
		clr.w	(Kos_decomp_queue_count).w
		clearRAM	Kos_decomp_stored_registers,$6C	; Clear FFFF10-FFFF7B
		bsr.w	Clear_Nem_Queue
		clr.w	(Current_zone_and_act).w		; Clear zone/act index
		bsr.w	Pal_FadeToBlack		; Fade out
		move	#$2700,sr
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
		move.w	#$9001,(a6)			; Command $9001 - 64x32 cell nametable area
		move.w	#$9200,(a6)			; Command $9200 - Window V position at default
		move.w	#$8B03,(a6)			; Command $8B03 - Vscroll full, HScroll line-based
		move.w	#$8700,(a6)			; Command $8700 - BG color is Pal 0 Color 0
		clr.b	(Water_full_screen_flag).w
		clr.b	(Water_flag).w		; Both water flags cleared
		move.w	#$8C81,(a6)			; Command $8C81 - 40cell screen size, no interlacing, no s/h
		bsr.w	Clear_DisplayData
		clearRAM	Sprite_table_input,$400		; Clear object display array
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)	; Clear SST array
		clearRAM	Tails_CPU_interact,$100	; Clear active play variables
		clearRAM	Camera_RAM,$100	; Clear play positional values
		jsr	(Init_SpriteTable).l		; Initialize the sprite table
		clearRAM	Normal_palette,$100	; Clear main palette
		moveq	#0,d0
		move.b	d0,(Last_star_post_hit).w
		move.b	d0,(Special_bonus_entry_flag).w
		move.w	d0,(Debug_placement_mode).w
		move.w	d0,(Demo_mode_flag).w
		move.w	d0,(Palette_cycle_counter1).w
		move.w	d0,(Competition_mode).w
		move.b	d0,(Level_started_flag).w
		move.b	d0,(Debug_mode_flag).w
		move.w	d0,(Competition_mode).w
		move.w	d0,(Level_select_cheat_counter).w
		move.w	d0,(Debug_mode_cheat_counter).w
		move.b	d0,(Blue_spheres_stage_flag).w
		move.w	#(6*60)-1,(Demo_timer).w		; Wait on title screen for six seconds
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w	; Clear DMA queue
		nop
		nop
		nop
		nop
		nop
		nop
		tst.w	(SK_alone_flag).w
		bne.w	SK_Alone_Title_Screen
		lea	(ArtKos_S3TitleSonic1).l,a0	;S3DATA
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
		move.w	a1,d3
		lsr.w	#1,d3
		move.l	#RAM_start&$FFFFFF,d1
		move.w	#tiles_to_bytes($000),d2
		jsr	(Add_To_DMA_Queue).l		; DMA Sega logo+Sonic art data 1 to $0 in VRAM
		lea	(RAM_start+$8000).w,a1
		lea	(MapEni_S3TitleSonic1).l,a0	;S3DATA
		move.w	#0,d0
		bsr.w	Eni_Decomp			; Decompress Enigma mappings
		tst.b	(Graphics_flags).w
		bmi.s	loc_3F7E
		moveq	#0,d0
		move.l	d0,(RAM_start+$83AC).w		; Hide trademark symbol if the console is Japanese

loc_3F7E:
		lea	(RAM_start+$8000).w,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l		; Copy screen mappings to VRAM
		lea	(Pal_TitleSonic1).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt($20),d0

loc_3F9E:
		move.l	(a0)+,(a1)+				; Fill 2 palette lines with title screen data
		dbf	d0,loc_3F9E
		move.w	#4*60,(Demo_timer).w
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l			; Turn the display on
		bsr.w	Pal_FadeFromBlack		; Fade in to logo
		moveq	#signextendB(mus_SEGA),d0
		bsr.w	Play_Music
		move.w	#3*60,(Demo_timer).w		; Set to wait for 3 seconds

Wait_SegaS3K:
		move.b	#$14,(V_int_routine).w
		bsr.w	Wait_VSync				; Wait for SEGA sound
		move.b	(Ctrl_1_pressed).w,d0
		andi.b	#button_start_mask,d0
		bne.w	loc_3FE4				; If start was pressed, skip ahead
		tst.w	(Demo_timer).w
		bne.s	Wait_SegaS3K

loc_3FE4:
		moveq	#signextendB(mus_StopSEGA),d0
		bsr.w	Play_Music				; Stop SEGA sound
		lea	(Pal_Title).l,a1

loc_3FF0:
		move.b	#2,(V_int_routine).w
		bsr.w	Wait_VSync
		lea	(Normal_palette).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		move.w	(a1)+,(a2)+
		tst.w	-$E(a1)					; Wait for BG color to turn to black
		bne.s	loc_3FF0
		clr.w	(_unkF660).w
		clr.w	(_unkF662).w
		move.b	#-1,(Title_anim_buffer).w
		move.b	#0,(Title_anim_delay).w
		move.w	#1,(Title_anim_frame).w		; Set initial variables for Sonic animation page flipping
		moveq	#1,d0
		bsr.w	TitleSonic_LoadFrame
		move.w	#15*60,(Demo_timer).w		; Set to wait 15 seconds (900 frames in NTSC)
		btst	#6,(Graphics_flags).w
		beq.s	loc_4040
		move.w	#15*50,(Demo_timer).w		; Set to wait 15 seconds (750 frames in PAL)

loc_4040:
		lea	(ArtKos_S3TitleSonic8).l,a1
		lea	(RAM_start).l,a2
		jsr	(Queue_Kos).l				; Queue frame 8 of data into a2 since frame 1 is already in VRAM
		moveq	#signextendB(mus_TitleScreen),d0
		bsr.w	Play_Music				; Start playing the title screen music

Wait_TitleS3K:
		move.b	#4,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		bsr.w	Iterate_TitleSonicFrame
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bsr.w	Process_Nem_Queue_Init
		move.b	(Ctrl_1_pressed).w,d0
		andi.b	#button_start_mask,d0
		bne.w	loc_4090			; If start was pressed, skip straight to title
		cmpi.w	#$C,(Title_anim_frame).w
		blo.s	Wait_TitleS3K		; If last frame was reached, don't repeat

loc_4090:
		move.w	#$C,(Title_anim_frame).w
		lea	(Normal_palette).w,a1
		moveq	#$40-1,d1

loc_409C:
		move.w	#$EEE,(a1)+
		dbf	d1,loc_409C				; Flash palette white
		move.b	#3,(Title_anim_delay).w
		move.b	#4,(V_int_routine).w
		bsr.w	Wait_VSync
		lea	(ArtKos_S3TitleSonicD).l,a0	;S3DATA
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
		move.w	a1,d3
		lsr.w	#1,d3
		move.l	#RAM_start,d1
		move.w	#tiles_to_bytes($000),d2
		andi.l	#$FFFFFF,d1
		jsr	(Add_To_DMA_Queue).l		; Load Sonic art frame 14
		lea	(Level_layout_header).w,a1
		lea	(MapEni_S3TitleSonicD).l,a0
		move.w	#make_art_tile($000,0,1),d0
		bsr.w	Eni_Decomp
		lea	(Level_layout_header).w,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l		; Load Sonic mapping frame 14 to $C000 VRAM
		lea	(Level_layout_header).w,a1
		lea	(MapEni_S3TitleBg).l,a0
		move.w	#make_art_tile($000,2,0),d0
		bsr.w	Eni_Decomp
		lea	(Level_layout_header).w,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l		; Load S3K Title BG to $E000 VRAM
		move.b	#4,(V_int_routine).w
		bsr.w	Wait_VSync
		lea	(Pal_TitleSonicD).l,a0		; Title palette
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt($80),d0

loc_4140:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_4140
		move.l	#vdpComm(tiles_to_bytes($500),VRAM,WRITE),(VDP_control_port).l	; to VRAM $A000
		lea	(ArtNem_Title_S3Banner).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($680),VRAM,WRITE),(VDP_control_port).l	; to VRAM $D000
		lea	(ArtNem_TitleScreenText).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($400),VRAM,WRITE),(VDP_control_port).l	; to VRAM $8000
		lea	(ArtNem_Title_SonicSprites).l,a0
		bsr.w	Nem_Decomp
		move.l	#vdpComm(tiles_to_bytes($4C0),VRAM,WRITE),(VDP_control_port).l	; to VRAM $9800
		lea	(ArtNem_Title_ANDKnuckles).l,a0
		bsr.w	Nem_Decomp
		move.l	#Obj_TitleBanner,(Player_1).w
		move.l	#Obj_TitleSelection,(Player_2).w
		move.l	#Obj_TitleCopyright,(Dynamic_object_RAM).w
		move.l	#Obj_TitleSonicFinger,(Dynamic_object_RAM+object_size).w
		move.l	#Obj_TitleSonicWink,(Dynamic_object_RAM+(object_size*2)).w
		move.l	#Obj_TitleTailsPlane,(Dynamic_object_RAM+(object_size*3)).w
		move.l	#Obj_TitleANDKnuckles,(Dynamic_object_RAM+(object_size*4)).w		; Load all applicable title objects
		move.b	#0,(Title_anim_delay).w

loc_41D4:
		move.b	#4,(V_int_routine).w
		bsr.w	Wait_VSync
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bsr.w	Process_Nem_Queue_Init
		tst.l	(Reserved_object_3).w
		beq.s	loc_41D4			; Don't do anything at all until banner has finished moving
		tst.w	(Demo_timer).w
		beq.w	loc_4278			; If the timer has run out, go do the level demos
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_start_mask,d0
		beq.w	loc_41D4			; Repeat until start has been pressed on either controller
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
		bsr.w	Play_SFX			; Fade out the title screen music
		moveq	#0,d0
		move.b	(Title_screen_option).w,d0		; Selection is stored here
		bne.w	loc_4264
		move.b	#$4C,(Game_mode).w		; Game Mode 4C is the save select
		rts
; ---------------------------------------------------------------------------

loc_4264:
		subq.b	#1,d0
		bne.s	loc_4270
		move.b	#$38,(Game_mode).w		; Game Mode 38 is Competition mode
		rts
; ---------------------------------------------------------------------------

loc_4270:
		move.b	#$28,(Game_mode).w		; Game Mode 28 is the level select
		rts
; ---------------------------------------------------------------------------

loc_4278:
		moveq	#signextendB(mus_FadeOut),d0
		bsr.w	Play_SFX			; Fade out music
		move.w	(Next_demo_number).w,d0		; Get index of current demo to run
		move.w	d0,(Demo_number).w
		andi.w	#7,d0
		add.w	d0,d0
		lea	DemoLevels(pc),a0
		move.w	(a0,d0.w),d0
		move.w	d0,(Current_zone_and_act).w		; Load level index to the appropriate variables
		move.w	d0,(Apparent_zone_and_act).w
		move.w	d0,(Saved_zone_and_act).w
		move.w	(Next_demo_number).w,d1
		addq.w	#1,d1
		tst.w	(SK_alone_flag).w
		bne.s	loc_42C0		; If playing only Sonic & Knuckles, branch
		cmpi.w	#3,d1
		bne.s	loc_42B6
		moveq	#4,d1
		bra.s	loc_42C8
; ---------------------------------------------------------------------------

loc_42B6:
		cmpi.w	#7,d1
		blo.s	loc_42C8
		moveq	#0,d1
		bra.s	loc_42C8
; ---------------------------------------------------------------------------
; unused/dead code, since it's not possible to reach the S3K title screen in S&K mode
; Even if were, this sets the next demo to a S3 level, which would crash S&K when played

loc_42C0:
		cmpi.w	#3,d1
		blo.s	loc_42C8
		moveq	#0,d1

loc_42C8:
		move.w	d1,(Next_demo_number).w
		tst.w	d0
		bpl.s	loc_4300			; Branch if we are indeed playing a level
		move.b	#$34,(Game_mode).w	; Do the special stage demo
		move.b	#1,(Current_special_stage).w
		move.b	#1,(SK_special_stage_flag).w
		move.b	#7,(Current_zone).w
		clr.w	(Emerald_counts).w
		clr.l	(Collected_emeralds_array).w
		clr.w	(Collected_emeralds_array+4).w
		clr.b	(Collected_emeralds_array+6).w
		move.b	#2,(Collected_emeralds_array+1).w
		bra.s	loc_4306
; ---------------------------------------------------------------------------

loc_4300:
		move.b	#8,(Game_mode).w	; We're about to perform a level demo

loc_4306:
		move.w	#1,(Demo_mode_flag).w
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
		rts
; ---------------------------------------------------------------------------
DemoLevels:
		dc.w      0	; Angel Island
		dc.w   $100	; Hydrocity
		dc.w   $200	; Marble Garden
		dc.w   $700	; Mushroom Hill
		dc.w   $400	; Flying Battery
		dc.w   $800	; Sandopolis
		dc.w  $FFFF
; ---------------------------------------------------------------------------


TitleAnim_FlipBuffer:
		tst.b	(Title_anim_delay).w
		bne.s	loc_43AC
		move.b	#4-1,(Title_anim_delay).w
		cmpi.w	#$C,(Title_anim_frame).w
		bhs.s	loc_43B2
		move.b	#4-1,(Title_anim_delay).w
		lea	(Target_palette).w,a0
		lea	(Normal_palette).w,a1
		moveq	#bytesToLcnt($40),d0

loc_4376:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_4376
		eori.b	#-1,(Title_anim_buffer).w
		tst.b	(Title_anim_buffer).w
		beq.s	loc_439A
		move.w	#$8406,(VDP_control_port).l		; Nametable B Address $C000
		move.w	#$8230,(VDP_control_port).l		; Nametable A Address $C000
		rts
; ---------------------------------------------------------------------------

loc_439A:
		move.w	#$8407,(VDP_control_port).l		; Nametable B Address $E000
		move.w	#$8238,(VDP_control_port).l		; Nametable A Address $E000
		rts
; ---------------------------------------------------------------------------

loc_43AC:
		subq.b	#1,(Title_anim_delay).w
		rts
; ---------------------------------------------------------------------------

loc_43B2:
		lea	(Target_palette).w,a0
		lea	(Normal_palette).w,a1
		moveq	#bytesToLcnt($80),d0

loc_43BC:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_43BC
		move.w	#$8407,(VDP_control_port).l		; Nametable B Address $E000
		move.w	#$8230,(VDP_control_port).l		; Nametable A Address $C000
		rts


; =============== S U B R O U T I N E =======================================


Iterate_TitleSonicFrame:
		cmpi.b	#1,(Title_anim_delay).w
		bne.s	locret_43F0
		move.w	(Title_anim_frame).w,d0
		move.b	SonicFrameIndex(pc,d0.w),d0
		ext.w	d0
		bmi.s	loc_43F2
		bsr.w	TitleSonic_LoadFrame
		addq.w	#1,(Title_anim_frame).w

locret_43F0:
		rts
; ---------------------------------------------------------------------------

loc_43F2:
		move.w	#$C,(Title_anim_frame).w
		move.b	#3,(Title_anim_delay).w
		rts
; ---------------------------------------------------------------------------
SonicFrameIndex:
		dc.b    1,   2,   3,   4,   5,   6,   7,   8,   9,  $A,  $B, $FF
		even

; =============== S U B R O U T I N E =======================================


TitleSonic_LoadFrame:
		move.w	d0,d7
		add.w	d0,d0
		add.w	d0,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	(TitleSonic_Frames).l,a2
		lea	(a2,d0.w),a2
		move.w	#$2C60,d3
		move.l	(a2)+,d0				; Art data
		cmpi.w	#7,d7
		beq.s	loc_4446
		bcs.s	loc_4466
		andi.l	#$FFFFFF,d0
		movea.l	d0,a0
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
		move.w	a1,d3
		lsr.w	#1,d3

loc_4446:
		move.l	#RAM_start,d1
		move.w	#0,d2
		tst.b	(Title_anim_buffer).w		; FFFFBC toggles on and off so that each animation frame could alternate locations for a sort of makeshift double-buffering
		beq.s	loc_445A
		move.w	#tiles_to_bytes($300),d2

loc_445A:
		andi.l	#$FFFFFF,d1
		jsr	(Add_To_DMA_Queue).l

loc_4466:
		movea.l	(a2)+,a0			; Palette data address
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt($40),d0

loc_446E:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_446E
		tst.b	(Title_anim_buffer).w
		bne.s	loc_44B8
		lea	(RAM_start+$8000).w,a1			; Buffer 1
		movea.l	(a2)+,a0				; Enigma Mappings
		move.w	#make_art_tile($000,0,0),d0
		bsr.w	Eni_Decomp
		cmpi.w	#7,d7
		bhs.s	loc_449A
		tst.b	(Graphics_flags).w
		bmi.s	loc_449A
		moveq	#0,d0
		move.l	d0,(RAM_start+$83AC).w

loc_449A:
		move	#$2700,sr
		lea	(RAM_start+$8000).w,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0	; to $C000 in VRAM, Nametable A
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l
		move	#$2300,sr
		rts
; ---------------------------------------------------------------------------

loc_44B8:
		lea	(RAM_start+$8000).w,a1			; Buffer 2
		movea.l	(a2)+,a0				; Enigma Mappings
		move.w	#make_art_tile($300,0,0),d0
		cmpi.w	#7,d7
		bhs.s	loc_44CC
		move.w	#make_art_tile($000,0,0),d0

loc_44CC:
		bsr.w	Eni_Decomp
		cmpi.w	#7,d7
		bhs.s	loc_44E2
		tst.b	(Graphics_flags).w
		bmi.s	loc_44E2
		moveq	#0,d0
		move.l	d0,(RAM_start+$83AC).w

loc_44E2:
		move	#$2700,sr
		lea	(RAM_start+$8000).w,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0	; to $E000 in VRAM Nametable B
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l
		move	#$2300,sr
		rts
; End of function TitleSonic_LoadFrame

; ---------------------------------------------------------------------------
TitleSonic_Frames:
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic1
		dc.l MapEni_S3TitleSonic1				;S3DATA
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic2
		dc.l MapEni_S3TitleSonic2				;S3DATA
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic3
		dc.l MapEni_S3TitleSonic3				;S3DATA
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic4
		dc.l MapEni_S3TitleSonic4				;S3DATA
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic5
		dc.l MapEni_S3TitleSonic5				;S3DATA
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic6
		dc.l MapEni_S3TitleSonic6				;S3DATA
		dc.l ArtKos_S3TitleSonic1				;S3DATA
		dc.l Pal_TitleSonic7
		dc.l MapEni_S3TitleSonic7				;S3DATA
		dc.l ArtKos_S3TitleSonic8				;S3DATA
		dc.l Pal_TitleSonic8
		dc.l MapEni_S3TitleSonic8				;S3DATA
		dc.l ArtKos_S3TitleSonic9				;S3DATA
		dc.l Pal_TitleSonic9
		dc.l MapEni_S3TitleSonic9				;S3DATA
		dc.l ArtKos_S3TitleSonicA				;S3DATA
		dc.l Pal_TitleSonicA
		dc.l MapEni_S3TitleSonicA				;S3DATA
		dc.l ArtKos_S3TitleSonicB				;S3DATA
		dc.l Pal_TitleSonicB
		dc.l MapEni_S3TitleSonicB				;S3DATA
		dc.l ArtKos_S3TitleSonicC				;S3DATA
		dc.l Pal_TitleSonicC
		dc.l MapEni_S3TitleSonicC				;S3DATA
		dc.l ArtKos_S3TitleSonicD				;S3DATA
		dc.l Pal_TitleSonicD
		dc.l MapEni_S3TitleSonicD				;S3DATA
Pal_Title:
		binclude "General/Title/Palettes/S3.bin"
		even
Pal_TitleSonic1:
		binclude "General/Title/Palettes/S3 Sonic 1.bin"
		even
Pal_TitleSonic2:
		binclude "General/Title/Palettes/S3 Sonic 2.bin"
		even
Pal_TitleSonic3:
		binclude "General/Title/Palettes/S3 Sonic 3.bin"
		even
Pal_TitleSonic4:
		binclude "General/Title/Palettes/S3 Sonic 4.bin"
		even
Pal_TitleSonic5:
		binclude "General/Title/Palettes/S3 Sonic 5.bin"
		even
Pal_TitleSonic6:
		binclude "General/Title/Palettes/S3 Sonic 6.bin"
		even
Pal_TitleSonic7:
		binclude "General/Title/Palettes/S3 Sonic 7.bin"
		even
Pal_TitleSonic8:
		binclude "General/Title/Palettes/S3 Sonic 8.bin"
		even
Pal_TitleSonic9:
		binclude "General/Title/Palettes/S3 Sonic 9.bin"
		even
Pal_TitleSonicA:
		binclude "General/Title/Palettes/S3 Sonic A.bin"
		even
Pal_TitleSonicB:
		binclude "General/Title/Palettes/S3 Sonic B.bin"
		even
Pal_TitleSonicC:
		binclude "General/Title/Palettes/S3 Sonic C.bin"
		even
Pal_TitleSonicD:
		binclude "General/Title/Palettes/S3 Sonic D.bin"
		even
; ---------------------------------------------------------------------------

Obj_TitleBanner:
		move.l	#Map_S3TitleBanner,mappings(a0)
		move.w	#make_art_tile($500,3,1),art_tile(a0)	; Origin at $A000
		move.w	#$80,priority(a0)
		move.b	#$80,width_pixels(a0)
		move.b	#$40,height_pixels(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$F0,y_pos(a0)
		move.w	#$400,y_vel(a0)
		move.l	#$FFA00000,$30(a0)
		move.l	#Obj_TitleBanner_Main,(a0)

Obj_TitleBanner_Main:
		move.b	$34(a0),d2
		move.w	y_vel(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$30(a0)
		move.w	$30(a0),d0
		move.b	#0,$34(a0)
		move.w	#$40,d1
		cmpi.w	#0,d0
		blt.s	loc_48B4
		bne.s	loc_48AA
		cmpi.w	#-$5B,y_vel(a0)
		bne.s	loc_48AA
		move.l	#Obj_TitleBanner_Display,(a0)
		move.l	#Obj_TitleTM,(Reserved_object_3).w
		bra.s	loc_48C2
; ---------------------------------------------------------------------------

loc_48AA:
		move.b	#-1,$34(a0)
		move.w	#-$40,d1

loc_48B4:
		add.w	d1,y_vel(a0)
		cmp.b	$34(a0),d2
		beq.s	loc_48C2
		asr	y_vel(a0)

loc_48C2:
		move.w	$30(a0),d0
		neg.w	d0
		addi.w	#$D4,d0
		move.w	d0,y_pos(a0)
		cmpi.w	#$10,(V_scroll_value).w		; Raise title screen Y position to make room for the &KNUCKLES
		beq.s	Obj_TitleBanner_Display
		addq.w	#1,(V_scroll_value).w

Obj_TitleBanner_Display:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_48F2
		move.b	#9,anim_frame_timer(a0)
		addq.b	#4,anim_frame(a0)
		andi.b	#$1C,anim_frame(a0)

loc_48F2:
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		move.l	Pal_TitleWaterRot(pc,d0.w),(Target_palette_line_3+$1A).w
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Pal_TitleWaterRot:
		binclude "General/Title/Palettes/S3 Water Anim.bin"
		even
; ---------------------------------------------------------------------------

Obj_TitleTM:
		move.l	#Map_S3TitleBanner,mappings(a0)		;S3DATA
		move.w	#make_art_tile($500,3,1),art_tile(a0)	; Start at $A000
		move.w	#$188,x_pos(a0)
		move.w	#$EC,y_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#4,height_pixels(a0)
		move.b	#1,mapping_frame(a0)
		move.l	#Obj_TitleTM_Display,(a0)

Obj_TitleTM_Display:
		tst.b	(Graphics_flags).w
		bpl.s	locret_4968
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_4968:
		rts
; ---------------------------------------------------------------------------

Obj_TitleANDKnuckles:
		move.l	#Map_TitleANDKnuckles,mappings(a0)
		move.w	#make_art_tile($4C0,3,1),art_tile(a0)	; Start at $9800
		move.w	#$120,x_pos(a0)
		move.w	#$108,y_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$54,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.l	#Obj_TitleANDKnuckles_Display,(a0)

Obj_TitleANDKnuckles_Display:
		move.w	(Player_1+y_pos).w,d0
		addi.w	#$5C,d0
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_TitleANDKnuckles:
		include "General/Title/Map - S3 ANDKnuckles.asm"
; ---------------------------------------------------------------------------

; Dead code
OldDebugCode:
		lea	(OldDebugCodeDat).l,a1
		move.w	(Debug_mode_cheat_counter).w,d0
		adda.w	d0,a1
		move.b	(Ctrl_1_pressed_title).w,d0
		andi.b	#$7F,d0
		beq.s	locret_4A10
		move.b	(Ctrl_1_held_title).w,d0
		cmp.b	(a1),d0
		bne.s	loc_4A0A
		addq.w	#1,(Debug_mode_cheat_counter).w
		tst.b	1(a1)
		bne.s	locret_4A10
		move.w	#(1<<8)|1,(Debug_cheat_flag).w
		moveq	#signextendB(sfx_RingLoss),d0
		bsr.w	Play_SFX

loc_4A0A:
		move.w	#0,(Debug_mode_cheat_counter).w

locret_4A10:
		rts
; ---------------------------------------------------------------------------
OldDebugCodeDat:
		dc.b button_C_mask
		dc.b button_C_mask|button_B_mask
		dc.b button_C_mask|button_B_mask|button_A_mask
		dc.b button_B_mask
		dc.b button_B_mask|button_A_mask
		dc.b button_B_mask|button_A_mask|button_C_mask
		dc.b button_A_mask
		dc.b button_A_mask|button_C_mask
		dc.b button_A_mask|button_C_mask|button_B_mask
		dc.b button_A_mask|button_C_mask|button_B_mask|button_up_mask
		dc.b button_A_mask|button_C_mask|button_B_mask|button_down_mask
		dc.b 0
		even
; ---------------------------------------------------------------------------

Obj_TitleCopyright:
		move.l	#Map_TitleScreenText,mappings(a0)
		move.w	#make_art_tile($680,3,1),art_tile(a0)	; Start at $D000 VRAM
		move.w	#$158,x_pos(a0)
		move.w	#$14C,y_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#4,height_pixels(a0)
		move.b	#3,mapping_frame(a0)
		move.l	#Obj_TitleCopyright_Display,(a0)

Obj_TitleCopyright_Display:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleSelection:
		move.w	#$F0,x_pos(a0)
		move.w	#$140,y_pos(a0)
		move.l	#Map_TitleScreenText,mappings(a0)
		move.w	#make_art_tile($680,2,1),art_tile(a0)	; Start at $D000 VRAM
		andi.b	#1,(Title_screen_option).w
		move.b	(Title_screen_option).w,mapping_frame(a0)
		move.l	#Obj_TitleSelection_Main,(a0)

Obj_TitleSelection_Main:
		moveq	#0,d2
		move.b	(Title_screen_option).w,d2
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		btst	#0,d0
		beq.s	loc_4AAE
		subq.b	#1,d2
		bcc.s	loc_4AAE
		move.b	#2,d2
		tst.b	(Level_select_flag).w		; If level select is on, maximum choices are 3
		bne.s	loc_4AAE
		move.b	#1,d2

loc_4AAE:
		btst	#1,d0
		beq.s	loc_4AC8
		addq.b	#1,d2
		tst.b	(Level_select_flag).w		; See above
		bne.s	loc_4AC0
		andi.b	#1,d2

loc_4AC0:
		cmpi.b	#3,d2
		blo.s	loc_4AC8
		moveq	#0,d2

loc_4AC8:
		move.b	d2,mapping_frame(a0)
		move.b	d2,(Title_screen_option).w
		andi.b	#3,d0
		beq.s	loc_4ADE
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l		; Only play sound if selection was changed

loc_4ADE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_TitleSonicFinger:
		move.l	#Map_TitleSonicAnim,mappings(a0)
		move.w	#make_art_tile($400,1,1),art_tile(a0)	; Start at $8000 VRAM
		move.w	#$148,x_pos(a0)
		move.w	#$DC,y_pos(a0)
		move.w	#$180,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$1C,height_pixels(a0)
		move.l	#Obj_TitleSonicFinger_Display,(a0)

Obj_TitleSonicFinger_Display:
		move.w	#$DC,d0
		sub.w	(V_scroll_value).w,d0
		move.w	d0,y_pos(a0)
		lea	(Ani_TitleSonicFinger).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_TitleSonicFinger:
		include "General/Title/Anim - S3 Sonic Finger.asm"
; ---------------------------------------------------------------------------

Obj_TitleSonicWink:
		move.l	#Map_TitleSonicAnim,mappings(a0)
		move.w	#make_art_tile($400,1,1),art_tile(a0)	; Start at $8000 VRAM
		move.w	#$F8,x_pos(a0)
		move.w	#$C8,y_pos(a0)
		move.w	#$180,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.l	#Obj_TitleSonicWink_Display,(a0)

Obj_TitleSonicWink_Display:
		move.w	#$C8,d0
		sub.w	(V_scroll_value).w,d0
		move.w	d0,y_pos(a0)
		lea	(Ani_TitleSonicWink).l,a1
		jsr	(Animate_SpriteIrregularDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_TitleSonicWink:
		include "General/Title/Anim - S3 Sonic Wink.asm"
; ---------------------------------------------------------------------------

Obj_TitleTailsPlane:
		move.l	#Map_TitleTailsPlane,mappings(a0)
		move.w	#make_art_tile($400,3,0),art_tile(a0)	; Start at $8000 VRAM
		move.w	#0,x_pos(a0)
		move.w	#$C0,y_pos(a0)
		move.w	#$380,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.l	#Obj_TitleTailsPlane_Main,(a0)

Obj_TitleTailsPlane_Main:
		tst.b	$30(a0)
		bne.s	loc_4C0A
		addq.w	#1,x_pos(a0)
		cmpi.w	#$240,x_pos(a0)
		bne.s	loc_4C08
		move.b	#1,$30(a0)
		bset	#0,status(a0)
		move.w	#$D0,y_pos(a0)

loc_4C08:
		bra.s	loc_4C28
; ---------------------------------------------------------------------------

loc_4C0A:
		subq.w	#1,x_pos(a0)
		cmpi.w	#0,x_pos(a0)
		bne.s	loc_4C28
		move.b	#0,$30(a0)
		bclr	#0,status(a0)
		move.w	#$C0,y_pos(a0)

loc_4C28:
		lea	(Ani_TitleTailsPlane).l,a1
		jsr	(Animate_Sprite).l
		tst.b	render_flags(a0)
		bpl.s	loc_4C3E
		bsr.w	S3_Level_Select_Code

loc_4C3E:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_TitleTailsPlane:
		include "General/Title/Anim - S3 Tails Plane.asm"

; =============== S U B R O U T I N E =======================================


S3_Level_Select_Code:
		rts
; ---------------------------------------------------------------------------
		lea	(LSelect3CodeDat).l,a1
		move.w	(Level_select_cheat_counter).w,d0
		adda.w	d0,a1
		move.b	(Ctrl_1_pressed_title).w,d0
		andi.b	#$7F,d0
		beq.s	locret_4C90
		move.b	(Ctrl_1_held_title).w,d0
		cmp.b	(a1),d0
		bne.s	loc_4C8A
		addq.w	#1,(Level_select_cheat_counter).w
		tst.b	1(a1)
		bne.s	locret_4C90
		move.w	#(1<<8)|1,(Level_select_flag).w
		move.w	#(1<<8)|1,(Debug_cheat_flag).w
		moveq	#signextendB(sfx_RingRight),d0
		bsr.w	Play_SFX

loc_4C8A:
		move.w	#0,(Level_select_cheat_counter).w

locret_4C90:
		rts
; End of function S3_Level_Select_Code

; ---------------------------------------------------------------------------
LSelect3CodeDat:
		dc.b button_up_mask
		dc.b button_up_mask
		dc.b button_down_mask
		dc.b button_down_mask
		dc.b button_up_mask
		dc.b button_up_mask
		dc.b button_up_mask
		dc.b button_up_mask
		dc.b 0
		even
Map_TitleScreenText:
		include "General/Title/Map - S3 Screen Text.asm"
ArtNem_TitleScreenText:
		binclude "General/Title/Nemesis Art/S3 Screen Text.bin"
		even
Map_TitleSonicAnim:
		include "General/Title/Map - S3 Sonic Anim.asm"
Map_TitleTailsPlane:
		include "General/Title/Map - S3 Tails Plane.asm"
; ---------------------------------------------------------------------------

SK_Alone_Title_Screen:
		lea	(ArtKos_SKTitleScreenBG).l,a0
		lea	(RAM_start).l,a1
		bsr.w	Kos_Decomp
		lea	(ArtKos_BigSEGA).l,a0
		bsr.w	Kos_Decomp
		lea	(ArtKos_SKTitle_SonicFall).l,a0		; Get title BG, Sega logo, and Sonic falling frame going
		bsr.w	Kos_Decomp
		move.w	a1,d3
		lsr.w	#1,d3
		move.l	#$FF0000,d1
		move.w	#tiles_to_bytes($000),d2
		move.w	#$E20,d3
		jsr	(Add_To_DMA_Queue).l		; DMA the BG first to $0 in VRAM
		move.l	#$FF1C40,d1
		move.w	#tiles_to_bytes($49C),d2
		move.w	#$1640,d3
		jsr	(Add_To_DMA_Queue).l		; Then DMA the logo and Sonic falling frame to $9380 in VRAM
		lea	(RAM_start+$4E00).l,a1
		lea	(ArtKos_SKTitle_DeathEgg).l,a0
		bsr.w	Kos_Decomp
		move.l	#$FF4E00,d1
		move.w	#tiles_to_bytes($680),d2
		move.w	#$720,d3
		jsr	(Add_To_DMA_Queue).l		; DMA the Death Egg title screen art to $D000 in VRAM
		lea	(RAM_start+$5D00).l,a1
		lea	(ArtKos_SKTitle_Mountain).l,a0
		bsr.w	Kos_Decomp
		move.l	#$FF5D00,d1
		move.w	#tiles_to_bytes($7A0),d2
		move.w	#$150,d3
		jsr	(Add_To_DMA_Queue).l		; DMA the little section of mountain that is drawn above the Death Egg
		lea	(RAM_start+$7400).l,a1
		lea	(MapEni_SKTitle_Sega).l,a0	; Get the SEGA logo mappings
		move.w	#make_art_tile($49C,0,1),d0
		bsr.w	Eni_Decomp
		tst.b	(Graphics_flags).w
		bmi.s	loc_5122
		move.w	#make_art_tile($49C,1,1),d0
		move.w	d0,(RAM_start+$775C).l
		move.w	d0,(RAM_start+$775E).l
		move.w	d0,(RAM_start+$7760).l
		move.w	d0,(RAM_start+$77AC).l
		move.w	d0,(RAM_start+$77AE).l
		move.w	d0,(RAM_start+$77B0).l		; Remove the TM from the Sega logo if on a Japan console

loc_5122:
		lea	(RAM_start+$7400).l,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l	; Copy Sega logo mappings to VRAM location $C000
		lea	(RAM_start+$7CC0).l,a1
		lea	(MapEni_SKTitle_Background).l,a0
		move.w	#make_art_tile($000,0,0),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start+$7CC0).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		bsr.w	RAM_Map_Data_To_VDP	; Copy SK Title Background mappings to VRAM location $E000
		lea	(RAM_start+$8580).w,a1
		lea	(MapEni_SKTitle_Frame1).l,a0
		move.w	#make_art_tile($0E2,0,1),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start+$8E40).w,a1
		lea	(MapEni_SKTitle_Frame2).l,a0
		move.w	#make_art_tile($0E2,0,1),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start+$9700).w,a1
		lea	(MapEni_SKTitle_Frame3).l,a0
		move.w	#make_art_tile($0E2,0,1),d0
		bsr.w	Eni_Decomp
		lea	(RAM_start+$9FC0).w,a1
		lea	(MapEni_SKTitle_Frame4).l,a0
		move.w	#make_art_tile($0E2,0,1),d0
		bsr.w	Eni_Decomp
		lea	(ArtKos_SKTitle_SonKnuxHand).l,a1
		lea	(RAM_start+$4800).l,a2
		jsr	(Queue_Kos).l		; Queue the Sonic/Knuckles hand animation art
		lea	(Target_palette).w,a1
		moveq	#4-1,d1

loc_51BC:
		move.w	#0,(a1)+
		moveq	#$F-1,d0

loc_51C2:
		move.w	#$EEE,(a1)+		; Set up the palette to full white
		dbf	d0,loc_51C2
		dbf	d1,loc_51BC
		lea	(Pal_SKTitle_SegaBG).l,a0
		lea	(Target_palette_line_2).w,a1
		moveq	#bytesToLcnt($20),d0

loc_51DA:
		move.l	(a0)+,(a1)+		; Load Sega palette into the first F colors of pal line 1
		dbf	d0,loc_51DA
		move.w	#3*60,(Demo_timer).w	; Set vsync timer to 3 seconds (180 frames NTSC)
		btst	#6,(Graphics_flags).w
		beq.s	loc_51F4
		move.w	#3*50,(Demo_timer).w	; Set vsync timer to 3 seconds (150 frames PAL)

loc_51F4:
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l		; Turn the display on
		bsr.w	Pal_FadeFromBlack		; Fade to Sega screen
		moveq	#signextendB(mus_SEGA),d0			; SEGA sound
		bsr.w	Play_Music

loc_520C:
		move.b	#$14,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		jsr	(Process_Kos_Module_Queue).l
		tst.b	(Kos_modules_left).w
		bne.s	loc_520C			; Don't allow the game to continue until the Knuckles art has been decompressed
		move.b	(Ctrl_1_pressed).w,d0
		andi.b	#button_start_mask,d0
		bne.w	loc_523A			; If start is pressed afterwards, skip to next part of title
		tst.w	(Demo_timer).w
		bne.s	loc_520C			; Otherwise, wait for vsync timer to run out

loc_523A:
		moveq	#signextendB(mus_StopSEGA),d0
		bsr.w	Play_Music			; Stop the SEGA sound if necessary
		lea	(Pal_SKTitle_Sonic).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt($80),d0

loc_524C:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_524C				; Load the Sonic palette and Sega palette
		lea	(ArtKosM_SonicKnuxStand).l,a1
		move.w	#tiles_to_bytes($0E2),d2
		jsr	(Queue_Kos_Module).l	; Cue the art Sonic and Knuckles standing
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$16,(Palette_fade_timer).w	; Number of frames to fade from white
		move.l	#Obj_SKTitle_SonicFall,(Player_1).w
		move.l	#Obj_SKTitle_DeathEgg,(Player_2).w
		move.l	#Obj_SKTitle_Mountain,(Reserved_object_3).w
		moveq	#signextendB(mus_TitleScreen),d0
		bsr.w	Play_Music			; Play the title screen music
		move.b	#3,(Life_count).w
		move.w	#18*60,(Demo_timer).w	; 18 second delay (1080 frames NTSC)
		btst	#6,(Graphics_flags).w
		beq.s	loc_52A6
		move.w	#18*50,(Demo_timer).w	; 18 second delay (900 frames PAL)

loc_52A6:
		move.b	#$1A,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		tst.w	(Palette_fade_timer).w
		beq.s	loc_52C4
		subq.w	#1,(Palette_fade_timer).w
		bsr.w	Pal_FromWhite		; Fade from white for set number of frames

loc_52C4:
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bsr.w	SKTitle_DeformBG
		jsr	(Process_Kos_Module_Queue).l
		move.b	(Ctrl_1_pressed).w,d0
		andi.b	#button_start_mask,d0
		bne.w	loc_52F0			; If start is pressed, branch
		tst.l	(Dynamic_object_RAM).w		; test if banner object has been created
		beq.s	loc_52A6			; If not, continue with the above
		bra.w	loc_537C
; ---------------------------------------------------------------------------

loc_52F0:
		tst.w	(Palette_fade_timer).w
		bne.s	loc_52A6			; If palette fade hasn't completed, go back
		lea	(Dynamic_object_RAM+object_size).w,a0
		bsr.w	Obj_SKTitle_HandAnim	; Initialize Hand animation object
		move.l	#Obj_SKTitle_DeathEggShake,(Player_2).w	; Change Death Egg object to second phase
		move.w	#$140,(Player_2+objoff_2E).l
		move.w	#$70,(Player_2+objoff_32).l		; Set its proper position
		move.w	#3,(Events_routine_fg).w		; Put title routine counter to max
		moveq	#0,d0
		move.w	d0,(Screen_shake_flag).w		; Turn off shaking
		move.w	#$100,d0
		move.w	d0,(V_scroll_value_BG).w
		move.w	d0,(V_scroll_value_BG).w
		move.w	d0,(Camera_Y_pos).w
		move.w	d0,(Camera_Y_pos_P2).w		; Set all Y scrolls to $100
		lea	(Pal_SKTitle_Knux).l,a0
		lea	(Normal_palette_line_2).w,a2
		moveq	#8-1,d0

loc_5342:
		move.l	(a0),$80(a2)
		move.l	(a0)+,(a2)+				; Change to Knuckles palette
		dbf	d0,loc_5342
		bsr.w	SKTitle_DeformBG		; Deform the BG to apply the changes
		move.b	#$1A,(V_int_routine).w
		bsr.w	Wait_VSync				; Refresh the screen
		move	#$2700,sr
		lea	(Chunk_table+$7CC0).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l		; Load the background
		lea	(Player_1).w,a0
		bsr.w	Obj_SKTitle_SonicFallFinish		; Finish the sonic fall object

loc_537C:
		move.b	#$1A,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		bsr.w	Wait_VSync
		tst.w	(Palette_fade_timer).w
		beq.s	loc_539A
		subq.w	#1,(Palette_fade_timer).w
		bsr.w	Pal_FromWhite

loc_539A:
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bsr.w	SKTitle_DeformBG
		jsr	(Process_Kos_Module_Queue).l
		bsr.w	S3_Level_Select_Code	; This routine is dummied out
		tst.l	(Dynamic_object_RAM+(object_size*2)).w
		beq.s	loc_537C			; If menu object isn't loaded, branch
		tst.w	(Demo_timer).w
		beq.w	loc_546C			; If timer has run out, branch forward
		move.b	(Ctrl_1_pressed).w,d0
		andi.b	#button_start_mask,d0
		beq.w	loc_537C			; If start is not pressed, branch back
		move.b	#$C,(Game_mode).w	; Play a level
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
		bsr.w	Play_SFX
		moveq	#0,d0
		move.b	(Title_screen_option).w,d0
		cmpi.b	#2,d0
		bhs.w	loc_5464
		add.w	d0,d0
		addq.w	#1,d0
		move.w	d0,(Player_option).w
		move.w	#$700,d0
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		move.w	d0,(Saved_zone_and_act).w
		clr.w	(Current_special_stage).w
		clr.w	(Emerald_counts).w
		clr.l	(Collected_emeralds_array).w
		clr.w	(Collected_emeralds_array+4).w
		clr.b	(Collected_emeralds_array+6).w
		clr.l	(Collected_special_ring_array).w
		clr.l	(Save_pointer).w
		tst.b	(Level_select_flag).w
		beq.s	locret_546A
		btst	#button_A,(Ctrl_1).w
		beq.s	locret_546A

loc_5464:
		move.b	#$28,(Game_mode).w

locret_546A:
		rts
; ---------------------------------------------------------------------------

loc_546C:
		moveq	#signextendB(mus_FadeOut),d0		; Start demo by fading out music
		bsr.w	Play_SFX
		move.w	(Next_demo_number).w,d0	; Get demo number
		cmpi.w	#3,d0
		bhs.s	loc_547E
		moveq	#3,d0

loc_547E:
		move.w	d0,(Next_demo_number).w
		move.w	d0,(Demo_number).w
		andi.w	#7,d0
		add.w	d0,d0
		lea	DemoLevels(pc),a0
		move.w	(a0,d0.w),d0		; Get the right demo level
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		move.w	d0,(Saved_zone_and_act).w	; Move it to various level ID locations
		move.w	(Next_demo_number).w,d1
		addq.w	#1,d1
		cmpi.w	#7,d1
		blo.s	loc_54AE
		moveq	#3,d1

loc_54AE:
		move.w	d1,(Next_demo_number).w
		tst.w	d0
		bpl.s	loc_54E0
		move.b	#$34,(Game_mode).w	; Special stage
		move.b	#1,(Current_special_stage).w
		move.b	#1,(SK_special_stage_flag).w
		move.b	#7,(Current_zone).w
		clr.w	(Emerald_counts).w
		clr.l	(Collected_emeralds_array).w
		clr.w	(Collected_emeralds_array+4).w
		clr.b	(Collected_emeralds_array+6).w
		bra.s	loc_54F0
; ---------------------------------------------------------------------------

loc_54E0:
		cmpi.w	#$700,d0
		bne.s	loc_54EA
		jsr	Prep_MHZDemo(pc)			; If doing Mushroom Hill demo, do this routine

loc_54EA:
		move.b	#8,(Game_mode).w

loc_54F0:
		move.w	#1,(Demo_mode_flag).w
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
		rts

; =============== S U B R O U T I N E =======================================


Prep_MHZDemo:
		move.w	#$6F4,(Saved_X_pos).w
		move.w	#$9EC,(Saved_Y_pos).w
		move.b	#1,(Last_star_post_hit).w
		move.b	#1,(Saved_last_star_post_hit).w
		move.w	d0,(Saved_zone_and_act).w
		move.w	d0,(Saved_apparent_zone_and_act).w
		move.w	#$680,(Saved_art_tile).w
		move.w	#$C0D,(Saved_solid_bits).w
		clr.w	(Saved_ring_count).w
		clr.b	(Saved_extra_life_flags).w
		clr.l	(Saved_timer).w
		clr.b	(Saved_dynamic_resize_routine).w
		move.w	#$AA0,(Saved_camera_max_Y_pos).w
		move.w	#$680,(Saved_camera_X_pos).w
		move.w	#$98C,(Saved_camera_Y_pos).w
		move.w	#$1000,(Saved_mean_water_level).w
		clr.b	(Saved_water_full_screen_flag).w
		rts
; End of function Prep_MHZDemo

; ---------------------------------------------------------------------------
Pal_SKTitle_Sonic:
		binclude "General/Title/Palettes/SK Sonic.bin"
		even
Pal_SKTitle_SegaBG:
		binclude "General/Title/Palettes/SK Sega and BG.bin"
		even
Pal_SKTitle_Knux:
		binclude "General/Title/Palettes/SK Knuckles.bin"
		even
; ---------------------------------------------------------------------------

Obj_SKTitle_SonicFall:
		move.l	#Map_SKTitle_SonicFall,mappings(a0)
		move.w	#make_art_tile($4EF,0,0),art_tile(a0)
		move.w	#$E8,x_pos(a0)
		move.w	#$16,y_pos(a0)	; Set position of falling Sonic sprite
		move.w	#$80,priority(a0)
		move.b	#$68,width_pixels(a0)
		move.b	#$70,height_pixels(a0)	; Set effective size of sprite
		move.l	#Obj_SKTitle_SonicFallMain,(a0)

Obj_SKTitle_SonicFallMain:
		cmpi.w	#$F0,y_pos(a0)
		beq.s	loc_5666
		addq.w	#1,y_pos(a0)		; Slowly move Sonic downwards

loc_5666:
		cmpi.w	#3,(Events_routine_fg).w
		bne.s	loc_56AA		; Wait until the proper phase of the title sequence
		ori.w	#high_priority,art_tile(a0)	; Modify the priority of the sprite
		cmpi.w	#$E0,(Camera_Y_pos).w
		bhs.s	loc_56B0		; If the foreground Y is past $E0, branch
		addq.w	#8,(Camera_Y_pos).w	; Otherwise scroll foreground by 8 pixels
		cmpi.w	#$C8,(Camera_Y_pos).w
		bne.s	loc_5698
		lea	(ArtKosM_SonicLand).l,a1	; Once foreground has hit C8 Y
		move.w	#tiles_to_bytes($462),d2
		jsr	(Queue_Kos_Module).l	; Queue the landing frames into VRAM

loc_5698:
		lea	(RAM_start+$8580).w,a1		; First frame data (Knuckles only)
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		move.w	(Camera_Y_pos).w,d1
		bsr.w	Copy_Map_Line_To_VRAM	; Since the nametable is only 32 tiles high, we can't copy the first foreground mapping frame for Sonic and Knuckles wholesale.
										; We set up each line of mappings data every time the screen scrolls down further

loc_56AA:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_56B0:
		bne.s	loc_56D4
		move	#$2700,sr		; Only do this when screen scrolling has his E0 Y
		lea	(RAM_start+$8E40).w,a1	; Second frame data (Sonic lands)
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l	; Copy the frame data
		move	#$2300,sr
		move.b	#6,anim_frame_timer(a0)			; Set up an internal timer

loc_56D4:
		cmpi.w	#$100,(Camera_Y_pos).w
		beq.s	loc_56E2			; When screen has hit $100 Y, branch
		addq.w	#8,(Camera_Y_pos).w
		rts
; ---------------------------------------------------------------------------

loc_56E2:
		move.l	#Obj_SKTitle_SonicFallLand,(a0)

Obj_SKTitle_SonicFallLand:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_5716
		move	#$2700,sr
		lea	(Block_table+$700).w,a1	; Get third mapping frame (Sonic starting to stand)
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l
		move	#$2300,sr
		move.b	#4,anim_frame_timer(a0)
		move.l	#Obj_SKTitle_SonicFallLand_2,(a0)

locret_5716:
		rts
; ---------------------------------------------------------------------------

Obj_SKTitle_SonicFallLand_2:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	Obj_SKTitle_SonicFallEnd

; =============== S U B R O U T I N E =======================================


Obj_SKTitle_SonicFallFinish:
		move	#$2700,sr
		lea	(Block_table+$FC0).w,a1		; Get last mapping frame (Sonic and Knuckles standing properly)
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l
		move	#$2300,sr
		lea	(ArtKosM_SKTitle_Banner).l,a1
		move.w	#tiles_to_bytes($4EE),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_SKTitle_Menu).l,a1
		move.w	#tiles_to_bytes($462),d2
		jsr	(Queue_Kos_Module).l					; Set up the banner and menu graphics to replace the landing graphics
		move.l	#Obj_SKTitle_Banner,(Dynamic_object_RAM).w
		move.b	#30,(Dynamic_object_RAM+anim_frame_timer).w					; $24 of object set to 30
		move.l	#Obj_SKTitle_SonicFallEnd,(a0)		; Disable object

Obj_SKTitle_SonicFallEnd:
		rts
; End of function Obj_SKTitle_SonicFallFinish

; ---------------------------------------------------------------------------

Obj_SKTitle_DeathEgg:
		move.l	#Map_SKTitle_DeathEgg,mappings(a0)
		move.w	#make_art_tile($680,2,0),art_tile(a0)
		move.w	#$140,x_pos(a0)
		move.w	#$B0,y_pos(a0)
		move.w	#$180,priority(a0)
		move.b	#$40,width_pixels(a0)
		move.b	#$40,height_pixels(a0)
		move.l	#Obj_SKTitle_DeathEggMain,(a0)

Obj_SKTitle_DeathEggMain:
		cmpi.w	#$F0,y_pos(a0)
		beq.s	loc_57D8				; If Death Egg has reached volcano, branch
		addi.l	#$8000,y_pos(a0)			; Move Death Egg sprite downward
		cmpi.w	#$100,(Camera_Y_pos_P2).w
		beq.s	loc_57D2
		addq.w	#1,(Camera_Y_pos_P2).w		; Scroll screen downwards
		lea	(Chunk_table+$7CC0).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		move.w	(Camera_Y_pos_P2).w,d1
		bsr.w	Copy_Map_Line_To_VRAM		; Update second nametable with background mappings as the screen scrolls down

loc_57D2:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_57D8:
		move.l	x_pos(a0),$2E(a0)
		move.l	y_pos(a0),$32(a0)			; Backup position values
		move.w	#$8000,(Camera_Y_pos_P2+2).w
		move.w	#$22,(Events_bg+$00).w
		move.w	#1,(Events_routine_fg).w
		move.w	#$1E,(Screen_shake_flag).w
		move.l	#Obj_SKTitle_DeathEggShake,(a0)

Obj_SKTitle_DeathEggShake:
		bsr.w	SKTitle_ScreenShake
		cmpi.w	#$100,(Camera_Y_pos_P2).w
		beq.s	loc_5832
		subi.l	#$8000,$32(a0)			; Move Death Egg backwards to keep up with scroll
		addi.l	#$8000,(Camera_Y_pos_P2).w
		lea	(Chunk_table+$7CC0).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		move.w	(Camera_Y_pos_P2).w,d1
		bsr.w	Copy_Map_Line_To_VRAM	; Continue drawing mapping lines

loc_5832:
		move.w	$2E(a0),d0
		move.w	$32(a0),d1
		tst.w	(Screen_shake_flag).w
		beq.s	loc_5848
		sub.w	(Camera_X_pos_P2_copy).w,d0
		sub.w	(Camera_Y_pos_P2_copy).w,d1		; Shake Death Egg along with screen

loc_5848:
		move.w	d0,x_pos(a0)
		move.w	d1,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SKTitle_Mountain:
		move.l	#Map_SKTitle_Mountain,mappings(a0)	; The top of the mountain is a sprite so it can cover the Death Egg
		move.w	#make_art_tile($7A0,3,0),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$30,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.l	#Obj_SKTitle_MountainMain,(a0)

Obj_SKTitle_MountainMain:
		move.w	#$140,d0
		move.w	#$1A8,d1
		sub.w	(Camera_X_pos_P2).w,d0
		sub.w	(Camera_Y_pos_P2).w,d1
		tst.w	(Screen_shake_flag).w
		beq.s	loc_589A
		sub.w	(Camera_X_pos_P2_copy).w,d0
		sub.w	(Camera_Y_pos_P2_copy).w,d1

loc_589A:
		move.w	d0,x_pos(a0)
		move.w	d1,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SKTitle_Banner:
		subq.b	#1,anim_frame_timer(a0)
		beq.s	loc_58B0		; Wait for the timer to finish
		rts
; ---------------------------------------------------------------------------

loc_58B0:
		move.l	#Map_SKTitle_Banner,mappings(a0)
		move.w	#make_art_tile($4EE,0,1),art_tile(a0)
		move.w	#0,priority(a0)
		move.b	#$7C,width_pixels(a0)
		move.b	#$28,height_pixels(a0)	; Set up sprite size and priority
		move.w	#$120,x_pos(a0)
		move.w	#$180,y_pos(a0)	; Position sprite below the screen
		move.w	#$400,y_vel(a0)	; Set up Y velocity
		move.l	#-$600000,$30(a0)	; Set up Y position offset
		move.l	#Obj_SKTitle_BannerMain,(a0)

Obj_SKTitle_BannerMain:
		move.b	$34(a0),d2
		move.w	y_vel(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$30(a0)	; Add velocity to Y offset
		move.w	$30(a0),d0
		move.b	#0,$34(a0)	; Set direction toggle flag
		move.w	#$40,d1
		cmpi.w	#0,d0
		blt.s	loc_5950	; If offset is negative, branch
		bne.s	loc_5946	; If offset is positive and nonzero, branch
		cmpi.w	#-$5B,y_vel(a0)
		bne.s	loc_5946	; Branch if the velocity isn't small enough
		move.l	#Obj_SKTitle_BannerDisplay,(a0)
		move.l	#Obj_SKTitle_Icon,(Dynamic_object_RAM+(object_size*2)).w
		move.l	#Obj_SKTitle_Icon2,(Dynamic_object_RAM+(object_size*3)).w
		move.l	#Obj_SKTitle_TM,(Dynamic_object_RAM+(object_size*4)).w
		move.l	#Obj_SKTitle_Copyright,(Dynamic_object_RAM+(object_size*5)).w		; Set up menu items and the like
		bra.s	loc_595E
; ---------------------------------------------------------------------------

loc_5946:
		move.b	#-1,$34(a0)		; This is all to perform the bobbing motion into place
		move.w	#-$40,d1

loc_5950:
		add.w	d1,y_vel(a0)
		cmp.b	$34(a0),d2
		beq.s	loc_595E
		asr	y_vel(a0)

loc_595E:
		move.w	$30(a0),d0
		neg.w	d0
		addi.w	#$118,d0
		move.w	d0,y_pos(a0)

Obj_SKTitle_BannerDisplay:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


Obj_SKTitle_HandAnim:
		move.l	#Chunk_table+$4800,d1
		move.w	#tiles_to_bytes($0E3),d2
		move.w	#$30,d3
		jsr	(Add_To_DMA_Queue).l
		move.l	#Chunk_table+$4E40,d1
		move.w	#tiles_to_bytes($0E6),d2
		move.w	#$290,d3
		jsr	(Add_To_DMA_Queue).l	; Load the correct initial art
		move.b	#3*60,$30(a0)
		move.l	#Obj_SKTitle_HandAnimMain,(a0)

Obj_SKTitle_HandAnimMain:
		lea	(SKTitle_AnimSmile).l,a1
		lea	$30(a0),a2
		bsr.w	SKTitle_AnimateHands
		bmi.s	loc_59D0
		lea	(RAM_start+$4800).l,a1
		lea	(a1,d0.w),a1
		move.l	a1,d1
		move.w	#tiles_to_bytes($0E3),d2
		move.w	#$30,d3
		jsr	(Add_To_DMA_Queue).l

loc_59D0:
		lea	(SKTitle_AnimFinger).l,a1
		lea	$32(a0),a2
		bsr.w	SKTitle_AnimateHands
		bmi.s	loc_59FA
		lea	(RAM_start+$4920).l,a1
		lea	(a1,d0.w),a1
		move.l	a1,d1
		move.w	#tiles_to_bytes($0E6),d2
		move.w	#$290,d3
		jsr	(Add_To_DMA_Queue).l

loc_59FA:
		lea	(SKTitle_AnimKnuckle1).l,a1
		lea	$34(a0),a2
		bsr.w	SKTitle_AnimateHands
		bmi.s	loc_5A24
		lea	(RAM_start+$5880).l,a1
		lea	(a1,d0.w),a1
		move.l	a1,d1
		move.w	#tiles_to_bytes($10F),d2
		move.w	#$2F0,d3
		jsr	(Add_To_DMA_Queue).l

loc_5A24:
		lea	(SKTitle_AnimKnuckle2).l,a1
		lea	$36(a0),a2
		bsr.w	SKTitle_AnimateHands
		bmi.s	locret_5A4E
		lea	(RAM_start+$6A20).l,a1
		lea	(a1,d0.w),a1
		move.l	a1,d1
		move.w	#tiles_to_bytes($13E),d2
		move.w	#$140,d3
		jsr	(Add_To_DMA_Queue).l

locret_5A4E:
		rts
; End of function Obj_SKTitle_HandAnim


; =============== S U B R O U T I N E =======================================


SKTitle_AnimateHands:
		subq.b	#1,(a2)
		bcc.s	loc_5A6C
		move.b	(a1),(a2)
		moveq	#0,d1
		move.b	1(a2),d1
		move.b	1(a1,d1.w),d0
		bmi.s	loc_5A70

loc_5A62:
		addq.b	#1,1(a2)
		ext.w	d0
		lsl.w	#5,d0
		rts
; ---------------------------------------------------------------------------

loc_5A6C:
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

loc_5A70:
		addq.b	#1,d0
		bne.s	loc_5A80
		move.b	#0,1(a2)
		move.b	1(a1),d0
		bra.s	loc_5A62
; ---------------------------------------------------------------------------

loc_5A80:
		addq.b	#1,d0
		bne.s	loc_5A6C
		move.b	2(a1,d1.w),d0
		sub.b	d0,1(a2)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_5A62
; End of function sub_5A50

; ---------------------------------------------------------------------------
SKTitle_AnimSmile:
		dc.b    5,   0,   3,   6, $FE,   1
SKTitle_AnimFinger:
		dc.b    3, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29
		dc.b  $29, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29, $29,   0,   0, $29, $52, $29,   0, $29
		dc.b  $52, $29,   0, $29, $52, $29, $FF
SKTitle_AnimKnuckle1:
		dc.b    3,   0,   0,   0,   0,   0,   0,   0,   0, $2F, $5E, $2F,   0, $2F, $5E, $2F, $FF
SKTitle_AnimKnuckle2:
		dc.b    3,   0,   0, $14, $28, $14,   0,   0, $FF
		even
; ---------------------------------------------------------------------------

Obj_SKTitle_Icon:
		move.w	#$108,x_pos(a0)
		move.w	#$150,y_pos(a0)
		move.w	x_pos(a0),$44(a0)
		move.w	y_pos(a0),$46(a0)
		move.l	#Map_SKTitle_Icon,mappings(a0)
		move.w	#make_art_tile($462,0,1),art_tile(a0)
		bset	#6,render_flags(a0)	; Turn on multi-sprite mode
		lea	sub2_x_pos(a0),a2
		move.w	#2,mainspr_childsprites(a0)
		move.w	x_pos(a0),(a2)+
		move.w	y_pos(a0),(a2)+	; First sprite is the Sonic/Knuckles icon
		move.w	#0,(a2)+
		andi.b	#1,(Title_screen_option).w
		move.b	(Title_screen_option).w,d0
		ror.b	#1,d0
		move.b	d0,angle(a0)
		move.b	#8,$27(a0)
		move.l	#Obj_SKTitle_IconDisplay,(a0)

Obj_SKTitle_IconDisplay:
		moveq	#0,d2
		move.b	(Title_screen_option).w,d2	; Get current selection
		move.b	angle(a0),d0
		andi.b	#$7F,d0
		bne.s	loc_5B9E			; If selection is currently, being rotated, branch
		move.b	(Ctrl_1_pressed).w,d0
		btst	#0,d0
		beq.s	loc_5B6E
		subq.b	#8,angle(a0)			; if down was pressed, rotate backwards
		move.b	#-8,$27(a0)
		subq.b	#1,d2
		bcc.s	loc_5B6E
		move.b	#1,d2

loc_5B6E:
		btst	#1,d0
		beq.s	loc_5B8C
		addq.b	#8,angle(a0)			; if up was pressed, rotate forward
		move.b	#8,$27(a0)
		addq.b	#1,d2
		andi.b	#1,d2
		cmpi.b	#3,d2
		blo.s	loc_5B8C
		moveq	#0,d2

loc_5B8C:
		move.b	d2,(Title_screen_option).w	; Move selection
		andi.b	#3,d0
		beq.s	loc_5B9E
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l		; Only play sound if selection was made

loc_5B9E:
		move.b	angle(a0),d0
		andi.b	#$7F,d0
		beq.s	loc_5BB0
		move.b	$27(a0),d0			; Perform rotation if necessary
		add.b	d0,angle(a0)

loc_5BB0:
		move.b	angle(a0),d0			; Get rotation angle
		addi.b	#$98,d0
		jsr	(GetSineCosine).l
		muls.w	#5,d1
		muls.w	#5,d0
		asr.l	#8,d1
		asr.l	#8,d0				; Convert to X/Y coordinates
		move.w	d1,d3
		move.w	d0,d2
		add.w	$44(a0),d1
		add.w	$46(a0),d0
		neg.w	d3
		neg.w	d2
		add.w	$44(a0),d3
		add.w	$46(a0),d2
		moveq	#0,d4
		moveq	#2,d5
		move.b	angle(a0),d6
		subi.b	#$A0,d6
		bpl.s	loc_5BF6
		exg	d1,d3		; Exchange attributes of Sonic/Knuckles text sprites depending on the rotation angle
		exg	d0,d2
		exg	d4,d5

loc_5BF6:
		addq.b	#1,d5
		lea	sub2_x_pos(a0),a2
		move.w	d1,(a2)+	; sub2_x_pos
		move.w	d0,(a2)+	; sub2_y_pos
		move.w	d4,(a2)+	; sub2_mapframe
		move.w	d3,(a2)+	; sub3_x_pos
		move.w	d2,(a2)+	; sub3_y_pos
		move.b	d5,1(a2)	; sub3_mapframe
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SKTitle_Icon2:
		move.w	#$D0,x_pos(a0)
		move.w	#$14C,y_pos(a0)
		move.l	#Map_SKTitle_Icon,mappings(a0)
		move.w	#make_art_tile($462,0,1),art_tile(a0)
		move.b	(Title_screen_option).w,d0
		move.b	d0,anim(a0)
		move.b	d0,prev_anim(a0)
		move.b	#1,anim_frame(a0)
		move.l	#Obj_SKTitle_Icon2Display,(a0)

Obj_SKTitle_Icon2Display:
		move.b	(Title_screen_option).w,anim(a0)
		lea	(Ani_SKTitle_Icon).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_SKTitle_Icon:
		include "General/Title/Anim - SK Icon.asm"
; ---------------------------------------------------------------------------

Obj_SKTitle_TM:
		move.l	#Map_SKTitle_TM,mappings(a0)
		move.w	#make_art_tile($462,0,1),art_tile(a0)
		move.w	#$1A2,x_pos(a0)
		move.w	#$11D,y_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#4,height_pixels(a0)
		move.l	#Obj_SKTitle_TMDisplay,(a0)

Obj_SKTitle_TMDisplay:
		tst.b	(Graphics_flags).w
		bpl.s	locret_5CAE
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_5CAE:
		rts
; ---------------------------------------------------------------------------

Obj_SKTitle_Copyright:
		move.l	#Map_SKTitle_Copyright,mappings(a0)
		move.w	#make_art_tile($462,0,1),art_tile(a0)
		move.w	#$17F,x_pos(a0)
		move.w	#$152,y_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$2C,width_pixels(a0)
		move.b	#4,height_pixels(a0)
		move.l	#Obj_SKTitle_CopyrightDisplay,(a0)

Obj_SKTitle_CopyrightDisplay:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


Copy_Map_Line_To_VRAM:
		subi.w	#$10,d1
		bcs.s	locret_5D22
		move.w	d1,d3
		andi.w	#7,d3
		bne.s	locret_5D22
		andi.w	#$F8,d1
		move.w	d1,d2
		add.w	d1,d1
		move.w	d1,d3
		lsl.w	#2,d1
		add.w	d3,d1
		lea	(a1,d1.w),a1
		lsl.w	#4,d2
		swap	d0
		add.w	d2,d0
		swap	d0
		moveq	#$28-1,d3
		lea	(VDP_data_port).l,a6
		move	#$2700,sr
		bsr.s	sub_5D42
		move	#$2300,sr

locret_5D22:
		rts
; End of function Copy_Map_Line_To_VRAM


; =============== S U B R O U T I N E =======================================


RAM_Map_Data_To_VDP:
		lea	(VDP_data_port).l,a6
		moveq	#$28-1,d1
		moveq	#$20-1,d2

.loop:
		movea.l	a1,a2
		move.w	d1,d3
		bsr.s	sub_5D42
		movea.l	a2,a1
		addi.l	#$80<<16,d0
		dbf	d2,.loop
		rts
; End of function RAM_Map_Data_To_VDP


; =============== S U B R O U T I N E =======================================


sub_5D42:
		move.l	d0,VDP_control_port-VDP_data_port(a6)

.loop:
		move.w	(a1)+,(a6)
		dbf	d3,.loop
		rts
; End of function sub_5D42


; =============== S U B R O U T I N E =======================================


ClearVRAMArea:
		lea	(VDP_data_port).l,a6
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		moveq	#0,d0

.loop:
		move.l	d0,(a6)
		dbf	d3,.loop
		rts
; End of function ClearVRAMArea


; =============== S U B R O U T I N E =======================================


SKTitle_ScreenShake:
		tst.w	(Screen_shake_flag).w
		beq.s	locret_5D92			; If timer has run out, don't do anything
		subq.w	#1,(Screen_shake_flag).w
		bne.s	loc_5D72
		addq.w	#1,(Events_routine_fg).w	; Increment title routine counter when this is done

loc_5D72:
		move.w	(V_int_run_count+2).w,d0
		andi.w	#$3F,d0				; Get frame counter then AND it for offset
		lea	(SKTitle_ShakeOffsets).l,a1
		lea	(a1,d0.w),a1
		moveq	#0,d0
		move.b	(a1)+,d0
		move.w	d0,(Camera_Y_pos_P2_copy).w
		move.b	(a1)+,d0
		move.w	d0,(Camera_X_pos_P2_copy).w

locret_5D92:
		rts
; End of function SKTitle_ScreenShake


; =============== S U B R O U T I N E =======================================


SKTitle_DeformBG:
		move.w	(Camera_Y_pos).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_P2).w,(V_scroll_value_BG).w		; Move BG position values to their proper spots
		moveq	#0,d2
		tst.w	(Screen_shake_flag).w
		beq.s	loc_5DB8
		move.w	(Camera_Y_pos_P2_copy).w,d0
		add.w	d0,(V_scroll_value).w
		add.w	d0,(V_scroll_value_BG).w				; Shake the screen by the proper offsets if screen shaking is on
		move.w	(Camera_X_pos_P2_copy).w,d2				; Move shake X amount to d2

loc_5DB8:
		lea	(H_scroll_buffer).w,a1
		move.w	(Events_routine_fg).w,d0
		bne.s	loc_5DE0

loc_5DC2:
		move.w	#$E0-1,d1							; If routine counter is zero
		move.w	(Camera_X_pos).w,d0
		add.w	d2,d0
		neg.w	d0
		swap	d0
		move.w	(Camera_X_pos_P2).w,d0
		add.w	d2,d0
		neg.w	d0

loc_5DD8:
		move.l	d0,(a1)+						; Do normal deformation, nothing special
		dbf	d1,loc_5DD8
		rts
; ---------------------------------------------------------------------------

loc_5DE0:
		subq.w	#1,d0
		bne.s	loc_5E0E
		add.w	(Camera_X_pos_P2).w,d2				; If routine counter is 1
		neg.w	d2
		move.w	#$70-1,d3

loc_5DEE:
		jsr	(Random_Number).l
		andi.w	#7,d0
		move.w	d0,(a1)+		; Shake the scanlines of the foreground (SEGA logo) by random amounts to simulate static
		move.w	d2,(a1)+
		swap	d0
		andi.w	#7,d0
		neg.w	d0
		move.w	d0,(a1)+
		move.w	d2,(a1)+
		dbf	d3,loc_5DEE
		rts
; ---------------------------------------------------------------------------

loc_5E0E:
		subq.w	#1,d0
		bne.s	loc_5DC2
		subq.w	#1,(Events_bg+$00).w		; If routine counter is 2
		bne.s	loc_5E52
		addq.w	#1,(Events_routine_fg).w		; If above timer has expired
		move	#$2700,sr
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$500,VRAM,WRITE),d0
		move.w	#$100-1,d3
		bsr.w	ClearVRAMArea			; Clear the Sega logo mappings from foreground
		move	#$2300,sr
		lea	(Pal_SKTitle_Knux).l,a0
		lea	(Normal_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d0

loc_5E3E:
		move.l	(a0)+,(a2)+				; Load the knuckles palette into the final line
		dbf	d0,loc_5E3E
		move.l	#Obj_SKTitle_HandAnim,(Dynamic_object_RAM+object_size).w	; Start hand animations
		moveq	#0,d2
		bra.w	loc_5DC2				; Then do normal deformation
; ---------------------------------------------------------------------------

loc_5E52:
		move.w	(Camera_X_pos_P2).w,d2
		neg.w	d2
		move.w	#$70-1,d3

loc_5E5C:
		jsr	(Random_Number).l
		addq.w	#8,(a1)			; On every other line, alternate between moving the line randomly to the left and randomly to the right
		andi.w	#7,d0			; The result is a staticy phaseout effect of the SEGA logo
		add.w	d0,(a1)
		cmpi.w	#$FC,(a1)
		blt.s	loc_5E74
		move.w	#$FC,(a1)

loc_5E74:
		addq.w	#2,a1
		move.w	d2,(a1)+
		subq.w	#8,(a1)
		swap	d0
		andi.w	#7,d0
		sub.w	d0,(a1)
		cmpi.w	#-$104,(a1)
		bgt.s	loc_5E8C
		move.w	#-$104,(a1)

loc_5E8C:
		addq.w	#2,a1
		move.w	d2,(a1)+
		dbf	d3,loc_5E5C
		rts
; End of function SKTitle_DeformBG

; ---------------------------------------------------------------------------
SKTitle_ShakeOffsets:
		dc.b    1,   2,   1,   3,   1,   2,   2,   1,   2,   3,   1,   2,   1,   2,   0,   0
		dc.b    2,   0,   3,   2,   2,   3,   2,   2,   1,   3,   0,   0,   1,   0,   1,   3
		dc.b    1,   2,   1,   3,   1,   2,   2,   1,   2,   3,   1,   2,   1,   2,   0,   0
		dc.b    2,   0,   3,   2,   2,   3,   2,   2,   1,   3,   0,   0,   1,   0,   1,   3,  1,   2
		even
Map_SKTitle_Icon:
		include "General/Title/Map - SK Icon.asm"
Map_SKTitle_TM:
		include "General/Title/Map - SK TM.asm"
Map_SKTitle_Copyright:
		include "General/Title/Map - SK Copyright.asm"
