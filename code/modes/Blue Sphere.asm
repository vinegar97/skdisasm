BlueSpheresTitle:
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		jsr	(Pal_FadeToBlack).l
		bsr.w	sub_4C8E4
		bsr.w	sub_4CCA6
		lea	(Target_palette).w,a2
		bsr.w	sub_4CB1A
		move.l	#vdpComm(tiles_to_bytes($5BF),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_CreditsText).l,a0
		jsr	(Nem_Decomp).l
		move.l	#vdpComm(tiles_to_bytes($197),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_BlueSphereSKLogo).l,a0
		jsr	(Nem_Decomp).l
		lea	(RAM_start).l,a1
		lea	(ArtKos_BlueSphereChar).l,a0
		jsr	(Kos_Decomp).l
		lea	(ArtKos_BlueSphereCharSprite).l,a0
		jsr	(Kos_Decomp).l
		move.w	a1,d3
		lsr.w	#1,d3
		move.l	#RAM_start&$FFFFFF,d1
		move.w	#0,d2
		jsr	(Add_To_DMA_Queue).l
		lea	(RAM_start+$4000).l,a1
		lea	(ArtKos_BlueSphereNormalText).l,a0
		jsr	(Kos_Decomp).l
		move.l	#(RAM_start+$4000)&$FFFFFF,d1
		move.w	#tiles_to_bytes($54E),d2
		move.w	#$6D0,d3
		jsr	(Add_To_DMA_Queue).l
		lea	(Level_layout_header).w,a1
		lea	(MapEni_BlueSphereTitleFG).l,a0
		move.w	#make_art_tile($000,1,0),d0
		jsr	(Eni_Decomp).l
		lea	(Level_layout_header).w,a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$380,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$10-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(Level_layout_header).w,a1
		lea	(MapEni_BlueSphereTitleBG).l,a0
		move.w	#make_art_tile($197,2,0),d0
		jsr	(Eni_Decomp).l
		lea	(Level_layout_header).w,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table+$09C,VRAM,WRITE),d0
		moveq	#$C-1,d1
		moveq	#8-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	aGetBlueSpheres(pc),a1
		tst.b	(Blue_spheres_menu_flag).w
		bne.s	+ ;loc_4CA8C
		lea	aNoWayNoWayNoWa(pc),a1
		move.w	#1,(Player_option).w
		move.l	#$FFF0FFF8,(V_scroll_value).w

+ ;loc_4CA8C:
		move.w	#$100,d2
		move.w	#$5BF,d6
		jsr	(sub_5B318).l
		tst.b	(Blue_spheres_mode).w
		bne.s	+ ;loc_4CAA8
		move.l	#$FFF0FFF8,(V_scroll_value).w

+ ;loc_4CAA8:
		move.l	#Obj_SpheresTitle_4CEAA,(Player_1).w
		move.l	#Obj_SpheresTitle_4DA30,(Player_2).w
		move.l	#Obj_SpheresTitle_4D986,(Reserved_object_3).w
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		moveq	#signextendB(mus_Continue),d0
		jsr	(Play_Music).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l

- ;loc_4CAE8:
		move.b	#$1A,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		jsr	(Wait_VSync).l
		bsr.w	sub_4CC96
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		jsr	(Process_Kos_Module_Queue).l
		cmpi.b	#$2C,(Game_mode).w
		beq.s	- ;loc_4CAE8
		rts

; =============== S U B R O U T I N E =======================================


sub_4CB1A:
		lea	(Pal_SpheresTitle_2).l,a1
		tst.b	(Blue_spheres_progress_flag).w
		bne.s	+ ;loc_4CB2C
		lea	(Pal_SpheresTitle_1).l,a1

+ ;loc_4CB2C:
		moveq	#bytesToWcnt($80),d0

- ;loc_4CB2E:
		move.w	(a1)+,(a2)+
		dbf	d0,- ;loc_4CB2E
		rts
; End of function sub_4CB1A

; ---------------------------------------------------------------------------
Pal_SpheresTitle_1:
		binclude "General/Blue Sphere/Palettes/Title 1.bin"
		even
Pal_SpheresTitle_2:
		binclude "General/Blue Sphere/Palettes/Title 2.bin"
		even
aNoWayNoWayNoWa:
		dc.b "NO WAY!    NO WAY!    NO WAY!    NO WAY?   ",0
		even
aGetBlueSpheres:
		dc.b "GET   BLUE   SPHERES !                            ",0
		even

; =============== S U B R O U T I N E =======================================


sub_4CC96:
		lea	(H_scroll_buffer).w,a1
		moveq	#$40-1,d1

- ;.loop:
		subq.w	#2,(a1)
		addq.w	#4,a1
		dbf	d1,- ;.loop
		rts
; End of function sub_4CC96


; =============== S U B R O U T I N E =======================================


sub_4CCA6:
		lea	(BlueSpheresSerialsText).l,a1
		moveq	#4-1,d1

- ;loc_4CCAE:
		lea	(LockonSerialNumber).l,a0
		moveq	#0,d3
		moveq	#$D-1,d2

- ;loc_4CCB8:
		move.b	(a1)+,d0
		cmp.b	(a0)+,d0
		beq.s	+ ;loc_4CCC0
		moveq	#1,d3

+ ;loc_4CCC0:
		dbf	d2,- ;loc_4CCB8
		tst.b	d3
		beq.s	+ ;loc_4CCDC
		dbf	d1,-- ;loc_4CCAE
		move.b	#0,(Blue_spheres_mode).w
		move.b	#-1,(Blue_spheres_progress_flag).w
		bsr.s	sub_4CD18

locret_4CCDA:
		rts
; ---------------------------------------------------------------------------

+ ;loc_4CCDC:
		move.b	#1,(Blue_spheres_mode).w
		tst.b	(Blue_spheres_menu_flag).w
		bne.s	locret_4CCDA
		clr.b	(Blue_spheres_progress_flag).w
		move.l	#0,(Blue_spheres_current_level).w
		move.l	#$10203,(Blue_spheres_current_stage).w
		rts
; End of function sub_4CCA6

; ---------------------------------------------------------------------------
BlueSpheresSerialsText:
		dc.b "GM 00001009-0"
		dc.b "GM 00004049-0"
		even

; =============== S U B R O U T I N E =======================================


sub_4CD18:
		lea	(LockonSerialNumber).l,a1
		moveq	#$B-1,d1

- ;loc_4CD20:
		move.b	(a1),d0
		subi.b	#$30,d0
		beq.s	+ ;loc_4CD2E
		cmpi.b	#$A,d0
		blo.s	++ ;loc_4CD34

+ ;loc_4CD2E:
		addq.w	#1,a1
		dbf	d1,- ;loc_4CD20

+ ;loc_4CD34:
		moveq	#0,d2

- ;loc_4CD36:
		move.b	(a1)+,d0
		subi.b	#$30,d0
		cmpi.b	#$A,d0
		bhs.s	+ ;loc_4CD4C
		andi.b	#$F,d0
		mulu.w	#$A,d2
		add.w	d0,d2

+ ;loc_4CD4C:
		dbf	d1,- ;loc_4CD36
		andi.w	#$7FFF,d2
		moveq	#0,d6
		move.w	d2,d6
		andi.w	#$3F,d6
		lea	(BlueSpheresMonthText).l,a2
		move.l	(LockonDate).l,d0
		moveq	#$E,d1

- ;loc_4CD6A:
		cmp.l	(a2)+,d0
		dbeq	d1,- ;loc_4CD6A
		subi.w	#$E,d1
		neg.w	d1
		andi.w	#$F,d1
		lsl.w	#4,d6
		or.b	d1,d6
		move.w	d2,d0
		lsr.w	#6,d0
		andi.w	#$F,d0
		lsl.w	#4,d6
		or.b	d0,d6
		move.b	(SSMagic_TestLoc_200150).l,d1
		andi.b	#1,d1
		lsl.l	#1,d6
		or.b	d1,d6
		lea	(SSMagic_TestLoc_20011A).l,a1
		moveq	#0,d0
		move.b	(a1)+,d0
		subi.b	#$30,d0
		mulu.w	#$A,d0
		move.b	(a1)+,d1
		subi.b	#$30,d1
		add.b	d1,d0
		subi.b	#$58,d0
		andi.b	#7,d0
		lsl.l	#3,d6
		or.b	d0,d6
		rol.w	#6,d2
		andi.w	#$1F,d2
		lsl.l	#5,d6
		or.b	d2,d6
		move.w	(SSMagic_TestLoc_2001A4).l,d0
		lsr.b	#3,d0
		andi.b	#3,d0
		lsl.l	#2,d6
		or.b	d0,d6
		moveq	#0,d1
		cmpi.w	#"EG",(SSMagic_TestLoc_200114).l
		beq.s	+ ;loc_4CDE6
		moveq	#1,d1

+ ;loc_4CDE6:
		lsl.l	#1,d6
		or.b	d1,d6
		move.b	(Blue_spheres_header_flag).w,d1
		andi.b	#1,d1
		lsl.l	#1,d6
		or.b	d1,d6
		andi.l	#$7FFFFFF,d6
		move.l	d6,(Blue_spheres_current_level).w
		lea	(Blue_spheres_current_stage).w,a2
		move.l	d6,d0
		andi.b	#$7F,d0
		move.b	d0,(a2)+
		move.l	d6,d0
		add.l	d0,d0
		add.l	d6,d0
		addq.l	#1,d0
		moveq	#0,d2
		swap	d0
		move.w	d0,d2
		swap	d0
		divu.w	#$7F,d2
		move.w	d0,d2
		divu.w	#$7F,d2
		swap	d2
		move.b	d2,(a2)+
		move.l	d6,d0
		add.l	d0,d0
		add.l	d0,d0
		add.l	d6,d0
		addq.l	#2,d0
		moveq	#0,d2
		swap	d0
		move.w	d0,d2
		swap	d0
		divu.w	#$7E,d2
		move.w	d0,d2
		divu.w	#$7E,d2
		swap	d2
		move.b	d2,(a2)+
		move.l	d6,d0
		add.l	d0,d0
		add.l	d6,d0
		add.l	d0,d0
		add.l	d6,d0
		addq.l	#3,d0
		moveq	#0,d2
		swap	d0
		move.w	d0,d2
		swap	d0
		divu.w	#$7D,d2
		move.w	d0,d2
		divu.w	#$7D,d2
		swap	d2
		move.b	d2,(a2)+
		rts
; End of function sub_4CD18

; ---------------------------------------------------------------------------
BlueSpheresMonthText:
		dc.b ".JAN"
		dc.b ".FEB"
		dc.b ".MAR"
		dc.b ".APR"
		dc.b ".MAY"
		dc.b ".JUN"
		dc.b ".JUL"
		dc.b ".AUG"
		dc.b ".SEP"
		dc.b ".OCT"
		dc.b ".NOV"
		dc.b ".DEC"
		dc.b ".   "
		dc.b "    "
		dc.b "...."
; ---------------------------------------------------------------------------

Obj_SpheresTitle_4CEAA:
		tst.b	(Blue_spheres_menu_flag).w
		bne.s	++ ;loc_4CEF8
		move.l	#loc_4CEB6,(a0)

loc_4CEB6:
		; Bug: no idea what this was meant to be
		tst.b	0
		bne.s	locret_4CEC6
		move.b	(Ctrl_1).w,d0
		cmpi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	+ ;loc_4CEC8

locret_4CEC6:
		rts
; ---------------------------------------------------------------------------

+ ;loc_4CEC8:
		clr.b	(Ctrl_1_pressed).w
		moveq	#-1,d0
		move.w	d0,(Special_stage_spheres_left).w
		move.w	d0,(Special_stage_rings_left).w
		moveq	#signextendB(sfx_Starpost),d0
		jsr	(Play_SFX).l
		move	#$2700,sr
		lea	aGetBlueSpheres(pc),a1
		move.w	#$100,d2
		move.w	#$5BF,d6
		jsr	(sub_5B318).l
		move	#$2300,sr

+ ;loc_4CEF8:
		move.l	#loc_4CF82,(a0)
		move.l	#Obj_SpheresTitle_4D03E,(Dynamic_object_RAM+(object_size*3)).w
		move.w	#$C0,(Dynamic_object_RAM+(object_size*3)+y_pos).w
		move.b	#1,(Blue_spheres_menu_flag).w
		move.b	#0,(Blue_spheres_option).w
		move.l	#Obj_SpheresTitle_4D64E,(Dynamic_object_RAM+(object_size*43)).w
		move.l	#Obj_SpheresTitle_4D64E,(Dynamic_object_RAM+(object_size*44)).w
		bset	#0,(Dynamic_object_RAM+(object_size*44)+render_flags).w
		tst.b	(Blue_spheres_mode).w
		beq.s	+ ;loc_4CF66
		move.w	#$B0,(Dynamic_object_RAM+(object_size*3)+y_pos).w
		move.l	#Obj_SpheresTitle_4D2F4,(Dynamic_object_RAM+(object_size*15)).w
		move.w	#$144,(Dynamic_object_RAM+(object_size*15)+y_pos).w
		move.l	#Obj_SpheresTitle_4D302,(Dynamic_object_RAM+(object_size*28)).w
		move.w	#$144,(Dynamic_object_RAM+(object_size*28)+y_pos).w
		move.l	#Obj_SpheresTitle_4D610,(Dynamic_object_RAM+(object_size*42)).w
		move.b	#1,(Blue_spheres_option).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_4CF66:
		tst.w	(Special_stage_spheres_left).w
		bne.s	locret_4CF80
		tst.w	(Special_stage_rings_left).w
		bne.s	locret_4CF80
		move.l	#Obj_SpheresTitle_4D302,(Dynamic_object_RAM+(object_size*28)).w
		move.w	#$144,(Dynamic_object_RAM+(object_size*28)+y_pos).w

locret_4CF80:
		rts
; ---------------------------------------------------------------------------

loc_4CF82:
		tst.b	(Blue_spheres_mode).w
		beq.w	loc_4D008
		tst.w	(V_scroll_value).w
		beq.s	++ ;loc_4CFB2
		addq.w	#1,(V_scroll_value).w
		btst	#0,(V_scroll_value_FG+1).w
		bne.s	+ ;loc_4CFA0
		addq.w	#1,(V_scroll_value_BG).w

+ ;loc_4CFA0:
		lea	(Reserved_object_3).w,a1
		moveq	#4-1,d1

- ;loc_4CFA6:
		subq.w	#1,y_pos(a1)
		lea	next_object(a1),a1
		dbf	d1,- ;loc_4CFA6

+ ;loc_4CFB2:
		tst.b	(Blue_spheres_menu_flag).w
		bmi.s	++ ;loc_4D000
		move.b	(Ctrl_1_pressed).w,d1
		btst	#0,d1
		beq.s	+ ;loc_4CFD4
		tst.b	(Blue_spheres_option).w
		beq.s	+ ;loc_4CFD4
		subq.b	#1,(Blue_spheres_option).w
		moveq	#signextendB(sfx_WeatherMachine),d0
		jsr	(Play_SFX).l

+ ;loc_4CFD4:
		btst	#1,d1
		beq.s	+ ;loc_4D000
		cmpi.b	#2,(Blue_spheres_option).w
		bhs.s	+ ;loc_4D000
		addq.b	#1,(Blue_spheres_option).w
		moveq	#signextendB(sfx_WeatherMachine),d0
		jsr	(Play_SFX).l
		cmpi.b	#2,(Blue_spheres_option).w
		bne.s	+ ;loc_4D000
		ori.b	#$80,(Blue_spheres_menu_flag).w
		clr.b	(Ctrl_1_pressed).w

+ ;loc_4D000:
		cmpi.b	#1,(Blue_spheres_option).w
		bne.s	locret_4D03C

loc_4D008:
		move.b	(Ctrl_1_pressed).w,d0
		cmpi.b	#button_start_mask,d0
		bne.s	locret_4D03C
		move.b	#0,(Special_bonus_entry_flag).w
		move.b	#1,(Blue_spheres_stage_flag).w
		move.w	(Player_option).w,(Player_mode).w
		move.b	#3,(Life_count).w
		move.b	#0,(SK_special_stage_flag).w
		move.b	#0,(Current_special_stage).w
		move.b	#$34,(Game_mode).w

locret_4D03C:
		rts
; ---------------------------------------------------------------------------

Obj_SpheresTitle_4D03E:
		move.l	#Map_BlueSpheresText,mappings(a0)
		move.w	#make_art_tile($54E,0,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$14,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.w	y_pos(a0),d3
		addi.w	#$10,d3
		movea.l	a0,a1
		move.b	#$A,next_object+mapping_frame(a1)
		move.w	#$F7,d2
		moveq	#$B-1,d1

- ;loc_4D07A:
		lea	next_object(a1),a1
		move.l	#loc_4D5B4,(a1)
		move.w	d2,x_pos(a1)
		move.w	d3,y_pos(a1)
		addq.w	#8,d2
		dbf	d1,- ;loc_4D07A
		move.b	#$B,mapping_frame(a1)
		move.l	#loc_4D09E,(a0)

loc_4D09E:
		tst.b	(Blue_spheres_mode).w
		beq.s	loc_4D0B0
		tst.b	(Blue_spheres_option).w
		bne.s	+ ;loc_4D0D4
		tst.b	(Blue_spheres_progress_flag).w
		bne.s	++ ;loc_4D0DA

loc_4D0B0:
		move.l	(Blue_spheres_current_stage).w,d1
		lsl.b	#1,d1
		lsl.w	#1,d1
		swap	d1
		lsl.b	#1,d1
		lsr.w	#1,d1
		swap	d1
		lsr.l	#2,d1
		andi.l	#$FFFFFFF,d1
		bsr.w	sub_4D0F6
		move.b	#1,mapping_frame(a0)
		bra.s	+++ ;loc_4D0F0
; ---------------------------------------------------------------------------

+ ;loc_4D0D4:
		tst.b	(Blue_spheres_progress_flag).w
		bne.s	loc_4D0B0

+ ;loc_4D0DA:
		move.l	(Blue_spheres_current_level).w,d1
		addq.l	#1,d1
		andi.l	#$7FFFFFF,d1
		bsr.w	sub_4D13A
		move.b	#0,mapping_frame(a0)

+ ;loc_4D0F0:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_4D0F6:
		andi.l	#$FFFFFFF,d1
		movea.l	a0,a1
		lea	next_object(a1),a1
		lea	dword_4D21C(pc),a2
		moveq	#8,d6

- ;loc_4D108:
		lea	next_object(a1),a1
		moveq	#0,d2
		move.l	(a2)+,d3

loc_4D110:
		sub.l	d3,d1
		bcs.s	+ ;loc_4D118
		addq.w	#1,d2
		bra.s	loc_4D110
; ---------------------------------------------------------------------------

+ ;loc_4D118:
		add.l	d3,d1
		move.b	d2,mapping_frame(a1)
		dbf	d6,- ;loc_4D108
		move.w	#$F7,d2
		moveq	#$A,d1
		movea.l	a0,a1

- ;loc_4D12A:
		lea	next_object(a1),a1
		move.w	d2,x_pos(a1)
		addq.w	#8,d2
		dbf	d1,- ;loc_4D12A
		rts
; End of function sub_4D0F6


; =============== S U B R O U T I N E =======================================


sub_4D13A:
		andi.l	#$7FFFFFF,d1
		movea.l	a0,a1
		lea	next_object(a1),a1
		lea	dword_4D21C(pc),a2
		moveq	#8,d6
		moveq	#0,d4

- ;loc_4D14E:
		lea	next_object(a1),a1
		moveq	#0,d2
		move.l	(a2)+,d3

loc_4D156:
		sub.l	d3,d1
		bcs.s	+ ;loc_4D15E
		addq.w	#1,d2
		bra.s	loc_4D156
; ---------------------------------------------------------------------------

+ ;loc_4D15E:
		add.l	d3,d1
		tst.w	d2
		beq.s	+ ;loc_4D16C
		tst.w	d4
		bne.s	+ ;loc_4D16C
		move.w	d6,d4
		addq.w	#1,d4

+ ;loc_4D16C:
		tst.w	d4
		bne.s	+ ;loc_4D172
		moveq	#$A,d2

+ ;loc_4D172:
		move.b	d2,mapping_frame(a1)
		dbf	d6,- ;loc_4D14E
		move.w	#$F7,d2
		move.w	d4,d0
		subi.w	#9,d0
		neg.w	d0
		move.w	d0,d1
		lsl.w	#2,d0
		add.w	d0,d2
		movea.l	a0,a1

- ;loc_4D18E:
		lea	next_object(a1),a1
		move.w	d2,x_pos(a1)
		dbf	d1,- ;loc_4D18E

- ;loc_4D19A:
		lea	next_object(a1),a1
		addq.w	#8,d2
		move.w	d2,x_pos(a1)
		dbf	d4,- ;loc_4D19A
		rts
; End of function sub_4D13A


; =============== S U B R O U T I N E =======================================


sub_4D1AA:
		andi.l	#$FF,d1
		movea.l	a0,a1
		lea	next_object(a1),a1
		lea	dword_4D238(pc),a2
		moveq	#1,d6
		moveq	#0,d4

- ;loc_4D1BE:
		lea	next_object(a1),a1
		moveq	#0,d2
		move.l	(a2)+,d3

loc_4D1C6:
		sub.l	d3,d1
		bcs.s	+ ;loc_4D1CE
		addq.w	#1,d2
		bra.s	loc_4D1C6
; ---------------------------------------------------------------------------

+ ;loc_4D1CE:
		add.l	d3,d1
		tst.w	d2
		beq.s	+ ;loc_4D1DC
		tst.w	d4
		bne.s	+ ;loc_4D1DC
		move.w	d6,d4
		addq.w	#1,d4

+ ;loc_4D1DC:
		tst.w	d4
		bne.s	+ ;loc_4D1E2
		moveq	#$A,d2

+ ;loc_4D1E2:
		move.b	d2,$22(a1)
		dbf	d6,- ;loc_4D1BE
		move.w	#$113,d2
		move.w	d4,d0
		subq.w	#2,d0
		neg.w	d0
		move.w	d0,d1
		lsl.w	#2,d0
		add.w	d0,d2
		movea.l	a0,a1

- ;loc_4D1FC:
		lea	next_object(a1),a1
		move.w	d2,x_pos(a1)
		dbf	d1,- ;loc_4D1FC

- ;loc_4D208:
		lea	next_object(a1),a1
		addq.w	#8,d2
		move.w	d2,x_pos(a1)
		dbf	d4,- ;loc_4D208
		rts
; End of function sub_4D1AA

; ---------------------------------------------------------------------------
		dc.l 1000000000
dword_4D21C:	dc.l 100000000
		dc.l 10000000
		dc.l 1000000
		dc.l 100000
		dc.l 10000
		dc.l 1000
		dc.l 100
dword_4D238:	dc.l 10
		dc.l 1
; ---------------------------------------------------------------------------

loc_4D240:
		moveq	#$C-1,d6
		lea	word_4D294(pc),a2

- ;loc_4D246:
		lea	next_object(a1),a1
		moveq	#0,d4
		move.w	(a2)+,d2
		move.l	(a2)+,d3

loc_4D250:
		sub.l	d3,d1
		subx.w	d2,d0
		bcs.s	+ ;loc_4D25A
		addq.w	#1,d4
		bra.s	loc_4D250
; ---------------------------------------------------------------------------

+ ;loc_4D25A:
		add.l	d3,d1
		addx.w	d2,d0
		move.b	d4,mapping_frame(a1)
		dbf	d6,- ;loc_4D246
		rts
; ---------------------------------------------------------------------------

loc_4D268:
		movea.l	a0,a1
		moveq	#0,d0
		moveq	#0,d1
		moveq	#$C-1,d6
		lea	word_4D294(pc),a2

- ;loc_4D274:
		lea	next_object(a1),a1
		moveq	#0,d4
		move.b	mapping_frame(a1),d4
		move.w	(a2)+,d2
		move.l	(a2)+,d3
		subq.w	#1,d4
		bcs.s	+ ;loc_4D28E

- ;loc_4D286:
		add.l	d3,d1
		addx.w	d2,d0
		dbf	d4,- ;loc_4D286

+ ;loc_4D28E:
		dbf	d6,-- ;loc_4D274
		rts
; ---------------------------------------------------------------------------
word_4D294:
		dc.w $17
		dc.l $4876E800
		dc.w 2
		dc.l $540BE400
		dc.w 0
		dc.l 1000000000
		dc.w 0
		dc.l 100000000
		dc.w 0
		dc.l 10000000
		dc.w 0
		dc.l 1000000
		dc.w 0
		dc.l 100000
		dc.w 0
		dc.l 10000
		dc.w 0
		dc.l 1000
		dc.w 0
		dc.l 100
		dc.w 0
		dc.l 10
		dc.w 0
		dc.l 1
word_4D2DC:
		dc.w   $10C
		dc.w   $114
		dc.w   $11C
		dc.w   $124
		dc.w   $134
		dc.w   $13C
		dc.w   $144
		dc.w   $14C
		dc.w   $15C
		dc.w   $164
		dc.w   $16C
		dc.w   $174
; ---------------------------------------------------------------------------

Obj_SpheresTitle_4D2F4:
		move.l	#loc_4D3CE,(a0)
		move.l	#loc_4D5FA,d2
		bra.s	+ ;loc_4D30E
; ---------------------------------------------------------------------------

Obj_SpheresTitle_4D302:
		move.l	#loc_4D362,(a0)
		move.l	#loc_4D5E4,d2

+ ;loc_4D30E:
		move.l	#Map_BlueSpheresText,mappings(a0)
		move.w	#make_art_tile($54E,0,1),art_tile(a0)
		move.w	#$D4,x_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$14,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.b	#2,mapping_frame(a0)
		lea	word_4D2DC(pc),a2
		movea.l	a0,a1
		moveq	#$C-1,d1

- ;loc_4D342:
		lea	next_object(a1),a1
		move.l	d2,(a1)
		move.w	(a2)+,x_pos(a1)
		subi.w	#$C,x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		dbf	d1,- ;loc_4D342
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4D362:
		tst.b	(Blue_spheres_menu_flag).w
		bpl.s	+ ;loc_4D36A
		rts
; ---------------------------------------------------------------------------

+ ;loc_4D36A:
		lea	(Stat_table).w,a2
		move.l	(Blue_spheres_current_level).w,(a2)
		tst.b	(Blue_spheres_progress_flag).w
		beq.s	+ ;loc_4D37E
		addi.l	#$7654321,(a2)

+ ;loc_4D37E:
		andi.l	#$7FFFFFF,(a2)
		moveq	#1,d6
		bsr.w	sub_4D5A0
		move.w	d4,d0
		andi.w	#$3F,d0
		tst.b	(Blue_spheres_progress_flag).w
		beq.s	+ ;loc_4D39A
		ori.w	#$40,d0

+ ;loc_4D39A:
		eori.w	#$55,d0
		move.l	(Blue_spheres_current_level).w,d1
		addi.l	#$1234567,d1
		andi.l	#$7FFFFFF,d1
		swap	d1
		lsl.w	#5,d4
		andi.w	#$F800,d4
		or.w	d4,d1
		swap	d1
		ror.l	#6,d1
		eori.l	#$AAAAAAAA,d1
		movea.l	a0,a1
		bsr.w	loc_4D240
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4D3CE:
		tst.b	(Blue_spheres_menu_flag).w
		bmi.s	+ ;loc_4D3DC
		move.w	#0,$30(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_4D3DC:
		move.b	(Ctrl_1_pressed).w,d0
		cmpi.b	#button_start_mask,d0
		bne.s	+ ;loc_4D3EA
		bsr.w	sub_4D488

+ ;loc_4D3EA:
		movea.l	a0,a1
		move.w	$30(a0),d0
		addq.w	#1,d0
		mulu.w	#object_size,d0
		adda.w	d0,a1
		move.w	#make_art_tile($54E,0,1),art_tile(a1)
		move.b	(Ctrl_1_pressed).w,d1
		btst	#button_up,d1
		beq.s	+ ;loc_4D414
		subq.b	#1,mapping_frame(a1)
		bcc.s	+ ;loc_4D414
		move.b	#9,mapping_frame(a1)

+ ;loc_4D414:
		btst	#1,d1
		beq.s	+ ;loc_4D42C
		addq.b	#1,mapping_frame(a1)
		cmpi.b	#$A,mapping_frame(a1)
		blo.s	+ ;loc_4D42C
		move.b	#0,mapping_frame(a1)

+ ;loc_4D42C:
		btst	#2,d1
		beq.s	+ ;loc_4D43E
		subq.w	#1,$30(a0)
		bcc.s	+ ;loc_4D43E
		move.w	#$B,$30(a0)

+ ;loc_4D43E:
		btst	#3,d1
		beq.s	+ ;loc_4D456
		addq.w	#1,$30(a0)
		cmpi.w	#$C,$30(a0)
		blo.s	+ ;loc_4D456
		move.w	#0,$30(a0)

+ ;loc_4D456:
		tst.b	(Blue_spheres_menu_flag).w
		bpl.s	+ ;loc_4D470
		movea.l	a0,a1
		move.w	$30(a0),d0
		addq.w	#1,d0
		mulu.w	#object_size,d0
		adda.w	d0,a1
		move.w	#make_art_tile($562,0,1),art_tile(a1)

+ ;loc_4D470:
		move.b	(Ctrl_1_pressed).w,d1
		andi.b	#button_up_mask|button_down_mask|button_left_mask|button_right_mask,d1
		beq.s	+ ;loc_4D482
		moveq	#signextendB(sfx_WeatherMachine),d0
		jsr	(Play_SFX).l

+ ;loc_4D482:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_4D488:
		bsr.w	loc_4D268
		eori.w	#$55,d0
		move.w	d0,d2
		andi.w	#$3F,d0
		eori.l	#$AAAAAAAA,d1
		rol.l	#6,d1
		swap	d1
		move.w	d1,d3
		andi.w	#$F800,d3
		lsr.w	#5,d3
		or.w	d0,d3
		andi.w	#$7FF,d3
		swap	d1
		subi.l	#$1234567,d1
		andi.w	#$40,d2
		beq.s	+ ;loc_4D4C2
		addi.l	#$7654321,d1

+ ;loc_4D4C2:
		andi.l	#$7FFFFFF,d1
		move.l	d1,(Stat_table).w
		lea	(Stat_table).w,a2
		moveq	#1,d6
		bsr.w	sub_4D5A0
		andi.w	#$7FF,d4
		cmp.w	d4,d3
		bne.w	++ ;loc_4D58A
		move.b	#0,(Blue_spheres_progress_flag).w
		tst.w	d2
		beq.s	+ ;loc_4D4FC
		subi.l	#$7654321,d1
		andi.l	#$7FFFFFF,d1
		move.b	#-1,(Blue_spheres_progress_flag).w

+ ;loc_4D4FC:
		move.l	d1,(Blue_spheres_current_level).w
		lea	(Blue_spheres_current_stage).w,a2
		move.l	d1,d0
		andi.b	#$7F,d0
		move.b	d0,(a2)+
		move.l	d1,d0
		add.l	d0,d0
		add.l	d1,d0
		addq.l	#1,d0
		moveq	#0,d2
		swap	d0
		move.w	d0,d2
		swap	d0
		divu.w	#$7F,d2
		move.w	d0,d2
		divu.w	#$7F,d2
		swap	d2
		move.b	d2,(a2)+
		move.l	d1,d0
		add.l	d0,d0
		add.l	d0,d0
		add.l	d1,d0
		addq.l	#2,d0
		moveq	#0,d2
		swap	d0
		move.w	d0,d2
		swap	d0
		divu.w	#$7E,d2
		move.w	d0,d2
		divu.w	#$7E,d2
		swap	d2
		move.b	d2,(a2)+
		move.l	d1,d0
		add.l	d0,d0
		add.l	d1,d0
		add.l	d0,d0
		add.l	d1,d0
		addq.l	#3,d0
		moveq	#0,d2
		swap	d0
		move.w	d0,d2
		swap	d0
		divu.w	#$7D,d2
		move.w	d0,d2
		divu.w	#$7D,d2
		swap	d2
		move.b	d2,(a2)+
		lea	(Normal_palette).w,a2
		bsr.w	sub_4CB1A
		moveq	#signextendB(sfx_Starpost),d0
		jsr	(Play_SFX).l
		andi.b	#$7F,(Blue_spheres_menu_flag).w
		move.b	#1,(Blue_spheres_option).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_4D58A:
		moveq	#signextendB(sfx_Error),d0
		jsr	(Play_SFX).l
		andi.b	#$7F,(Blue_spheres_menu_flag).w
		move.b	#1,(Blue_spheres_option).w
		rts
; End of function sub_4D488


; =============== S U B R O U T I N E =======================================


sub_4D5A0:
		moveq	#0,d4

- ;loc_4D5A2:
		move.w	(a2)+,d5
		eor.w	d5,d4
		lsr.w	#1,d4
		bcc.s	+ ;loc_4D5AE
		eori.w	#$8810,d4

+ ;loc_4D5AE:
		dbf	d6,- ;loc_4D5A2
		rts
; End of function sub_4D5A0

; ---------------------------------------------------------------------------

loc_4D5B4:
		bsr.s	sub_4D5C2
		move.l	#loc_4D5BC,(a0)

loc_4D5BC:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_4D5C2:
		move.l	#Map_BlueSpheresNum,mappings(a0)
		move.w	#make_art_tile($54E,0,1),art_tile(a0)
		move.w	#$80,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		rts
; End of function sub_4D5C2

; ---------------------------------------------------------------------------

loc_4D5E4:
		bsr.s	sub_4D5C2
		move.l	#loc_4D5EC,(a0)

loc_4D5EC:
		tst.b	(Blue_spheres_menu_flag).w
		bpl.s	+ ;loc_4D5F4
		rts
; ---------------------------------------------------------------------------

+ ;loc_4D5F4:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4D5FA:
		bsr.s	sub_4D5C2
		move.l	#loc_4D602,(a0)

loc_4D602:
		tst.b	(Blue_spheres_menu_flag).w
		bmi.s	+ ;loc_4D60A
		rts
; ---------------------------------------------------------------------------

+ ;loc_4D60A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SpheresTitle_4D610:
		move.l	#Map_BlueSpheresText,mappings(a0)
		move.w	#make_art_tile($54E,0,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$128,y_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$14,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.b	#3,mapping_frame(a0)
		move.l	#loc_4D648,(a0)

loc_4D648:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SpheresTitle_4D64E:
		move.l	#Map_BlueSpheresIcon,mappings(a0)
		move.w	#make_art_tile($598,3,1),art_tile(a0)
		cmpi.w	#3,(Player_option).w
		bne.s	+ ;loc_4D66A
		move.w	#make_art_tile($598,0,1),art_tile(a0)

+ ;loc_4D66A:
		move.w	#$100,x_pos(a0)
		move.w	#$126,y_pos(a0)
		tst.b	(Blue_spheres_mode).w
		bne.s	+ ;loc_4D682
		move.w	#$BE,y_pos(a0)

+ ;loc_4D682:
		move.l	#word_4D7A6,$30(a0)
		btst	#0,render_flags(a0)
		beq.s	+ ;loc_4D6A0
		move.w	#$140,x_pos(a0)
		move.l	#word_4D7B2,$30(a0)

+ ;loc_4D6A0:
		move.w	#0,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.l	#loc_4D6B8,(a0)

loc_4D6B8:
		tst.b	(Blue_spheres_mode).w
		beq.w	loc_4D75E
		movea.l	$30(a0),a1
		moveq	#0,d0
		move.b	(Blue_spheres_option).w,d0
		lsl.w	#2,d0
		move.w	(a1,d0.w),d2
		move.w	2(a1,d0.w),d3
		cmp.w	x_pos(a0),d2
		bne.s	+ ;loc_4D6F0
		move.w	x_vel(a0),d0
		addi.w	#$80,d0
		cmpi.w	#$100,d0
		bhi.s	+ ;loc_4D6F0
		moveq	#0,d1
		move.w	d1,x_vel(a0)
		bra.s	+++ ;loc_4D712
; ---------------------------------------------------------------------------

+ ;loc_4D6F0:
		move.w	#$40,d1
		cmp.w	x_pos(a0),d2
		bge.s	+ ;loc_4D708
		neg.w	d1
		tst.w	x_vel(a0)
		bmi.s	++ ;loc_4D712
		add.w	d1,d1
		add.w	d1,d1
		bra.s	++ ;loc_4D712
; ---------------------------------------------------------------------------

+ ;loc_4D708:
		tst.w	x_vel(a0)
		bpl.s	+ ;loc_4D712
		add.w	d1,d1
		add.w	d1,d1

+ ;loc_4D712:
		add.w	d1,x_vel(a0)
		cmp.w	y_pos(a0),d3
		bne.s	+ ;loc_4D732
		move.w	y_vel(a0),d0
		addi.w	#$100,d0
		cmpi.w	#$200,d0
		bhi.s	+ ;loc_4D732
		moveq	#0,d1
		move.w	d1,y_vel(a0)
		bra.s	+++ ;loc_4D754
; ---------------------------------------------------------------------------

+ ;loc_4D732:
		move.w	#$80,d1
		cmp.w	y_pos(a0),d3
		bge.s	+ ;loc_4D74A
		neg.w	d1
		tst.w	y_vel(a0)
		bmi.s	++ ;loc_4D754
		add.w	d1,d1
		add.w	d1,d1
		bra.s	++ ;loc_4D754
; ---------------------------------------------------------------------------

+ ;loc_4D74A:
		tst.w	y_vel(a0)
		bpl.s	+ ;loc_4D754
		add.w	d1,d1
		add.w	d1,d1

+ ;loc_4D754:
		add.w	d1,y_vel(a0)
		jsr	(MoveSprite2).l

loc_4D75E:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	+ ;loc_4D774
		move.b	#3-1,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		andi.b	#7,mapping_frame(a0)

+ ;loc_4D774:
		move.b	(Ctrl_1_pressed).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	+ ;loc_4D7A0
		move.w	art_tile(a0),d0
		move.w	#3,(Player_option).w
		move.w	#make_art_tile($598,0,1),art_tile(a0)
		cmpi.w	#make_art_tile($598,0,1),d0
		bne.s	+ ;loc_4D7A0
		move.w	#1,(Player_option).w
		move.w	#make_art_tile($598,3,1),art_tile(a0)

+ ;loc_4D7A0:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
word_4D7A6:
		dc.w   $100,   $AE
		dc.w   $100,  $126
		dc.w    $C8,  $142
word_4D7B2:
		dc.w   $140,   $AE
		dc.w   $140,  $126
		dc.w   $178,  $142
Map_BlueSpheresText:
		include "General/Blue Sphere/Map - Text.asm"
Map_BlueSpheresNum:
		include "General/Blue Sphere/Map - Numbers.asm"
Map_BlueSpheresIcon:
		include "General/Blue Sphere/Map - Rotating Icon.asm"
; ---------------------------------------------------------------------------
word_4D976:
		dc.w    $B8,  $100
		dc.w   $10C,   $F8
		dc.w   $130,   $F4
		dc.w   $178,   $E0
; ---------------------------------------------------------------------------

Obj_SpheresTitle_4D986:
		lea	word_4D976(pc),a2
		movea.l	a0,a1
		moveq	#4-1,d1

- ;loc_4D98E:
		move.l	#Map_BlueSphereCharSprite,mappings(a1)
		move.w	#make_art_tile($0FE,1,0),art_tile(a1)
		move.w	(a2)+,x_pos(a1)
		move.w	(a2)+,y_pos(a1)
		tst.b	(Blue_spheres_menu_flag).w
		beq.s	+ ;loc_4D9B6
		tst.b	(Blue_spheres_mode).w
		beq.s	+ ;loc_4D9B6
		subi.w	#$10,y_pos(a1)

+ ;loc_4D9B6:
		move.w	#$180,priority(a1)
		move.b	#$10,width_pixels(a1)
		move.b	#$10,height_pixels(a1)
		move.l	#loc_4D9EC,(a1)
		move.b	d1,anim(a1)
		move.w	d1,d0
		add.w	d0,d0
		lea	(Ani_BlueSphereCharSprite).l,a3
		adda.w	(a3,d0.w),a3
		move.b	(a3),mapping_frame(a1)
		lea	next_object(a1),a1
		dbf	d1,- ;loc_4D98E

loc_4D9EC:
		tst.b	(Blue_spheres_mode).w
		beq.s	+ ;loc_4D9FE
		lea	(Ani_BlueSphereCharSprite).l,a1
		jsr	(Animate_SpriteIrregularDelay).l

+ ;loc_4D9FE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_BlueSphereCharSprite:
		include "General/Blue Sphere/Anim - Character Sprites.asm"
; ---------------------------------------------------------------------------

Obj_SpheresTitle_4DA30:
		move.l	#Map_BlueSpheresCopyright,mappings(a0)
		move.w	#make_art_tile($5B2,0,1),art_tile(a0)
		move.w	#$180,x_pos(a0)
		move.w	#$152,y_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$2C,width_pixels(a0)
		move.b	#4,height_pixels(a0)
		move.l	#loc_4DA62,(a0)

loc_4DA62:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_BlueSpheresCopyright:
		include "General/Blue Sphere/Map - Copyright.asm"
; ---------------------------------------------------------------------------

BlueSpheresResults:
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		bsr.w	sub_4C8E4
		lea	(Pal_SphereResults_012).l,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToWcnt($80),d0

- ;loc_4DA96:
		move.w	(a1)+,(a2)+
		dbf	d0,- ;loc_4DA96
		lea	(RAM_start).l,a1
		lea	(ArtKos_SSResultsGeneral).l,a0
		jsr	(Kos_Decomp).l
		lea	(ArtKos_SSResultsTKIcons).l,a0
		jsr	(Kos_Decomp).l
		move.w	a1,d3
		lsr.w	#1,d3
		move.l	#$FF0000,d1
		move.w	#tiles_to_bytes($1DC),d2
		jsr	(Add_To_DMA_Queue).l
		lea	(RAM_start+$4000).l,a1
		lea	(ArtKos_BlueSphereNormalText).l,a0
		jsr	(Kos_Decomp).l
		move.l	#$FF4000,d1
		move.w	#tiles_to_bytes($54E),d2
		move.w	#$6D0,d3
		jsr	(Add_To_DMA_Queue).l
		move.l	#vdpComm(tiles_to_bytes($5BF),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_CreditsText).l,a0
		jsr	(Nem_Decomp).l
		move.l	#vdpComm(tiles_to_bytes($197),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_BlueSphereSKLogo).l,a0
		jsr	(Nem_Decomp).l
		lea	aCongratulation(pc),a1
		move.w	#$30A,d2
		move.w	#$85BF,d6
		jsr	(sub_5B318).l
		lea	(Level_layout_header).w,a1
		lea	(MapEni_BlueSphereTitleBG).l,a0
		move.w	#make_art_tile($197,3,0),d0
		jsr	(Eni_Decomp).l
		bsr.w	sub_4DEA2
		move.b	#1,(Blue_spheres_option).w
		move.l	#Obj_SphereResults_4DEF8,(Player_1).w
		move.l	#Obj_SphereResults_4DF86,(Player_2).w
		move.l	#Obj_SpheresTitle_4D03E,(Dynamic_object_RAM+(object_size*3)).w
		move.w	#$90,(Dynamic_object_RAM+(object_size*3)+y_pos).w
		move.l	#Obj_Sphere_Results_4E012,(Dynamic_object_RAM+(object_size*26)).w
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		moveq	#signextendB(mus_GotThroughAct),d0
		jsr	(Play_Music).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromWhite).l

- ;loc_4DB9E:
		move.b	#$1A,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		jsr	(Wait_VSync).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		jsr	(Process_Kos_Module_Queue).l
		cmpi.b	#$30,(Game_mode).w
		beq.s	- ;loc_4DB9E
		tst.w	(Special_stage_rings_left).w
		beq.s	+++ ;loc_4DC1A
		tst.b	(Blue_spheres_progress_flag).w
		bmi.s	locret_4DC18
		tst.b	(Blue_spheres_mode).w
		beq.s	locret_4DC18
		addq.l	#1,(Blue_spheres_current_level).w
		lea	(Blue_spheres_current_stage).w,a2
		addi.l	#$01030507,(a2)
		andi.b	#$7F,(a2)
		cmpi.b	#$7F,1(a2)
		blo.s	+ ;loc_4DBFC
		subi.b	#$7F,1(a2)

+ ;loc_4DBFC:
		cmpi.b	#$7E,2(a2)
		blo.s	+ ;loc_4DC0A
		subi.b	#$7E,2(a2)

+ ;loc_4DC0A:
		cmpi.b	#$7D,3(a2)
		blo.s	locret_4DC18
		subi.b	#$7D,3(a2)

locret_4DC18:
		rts
; ---------------------------------------------------------------------------

+ ;loc_4DC1A:
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		jsr	(Pal_FadeToBlack).l
		bsr.w	sub_4C8E4
		clearRAM _unkFA80,$80
		lea	(Pal_SonicTails).l,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToLcnt($20),d6

- ;loc_4DC48:
		move.l	(a1)+,(a2)+
		dbf	d6,- ;loc_4DC48
		lea	(Pal_Knuckles).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

- ;loc_4DC5A:
		move.l	(a1)+,(a2)+
		dbf	d6,- ;loc_4DC5A
		lea	(Pal_SphereResults_3).l,a1
		lea	(Target_palette_line_3).w,a2
		moveq	#bytesToLcnt($20),d6

- ;loc_4DC6C:
		move.l	(a1)+,(a2)+
		dbf	d6,- ;loc_4DC6C
		lea	(Pal_EndingSKLogo).l,a1
		lea	(Target_palette_line_4).w,a2
		moveq	#bytesToLcnt($20),d6

- ;loc_4DC7E:
		move.l	(a1)+,(a2)+
		dbf	d6,- ;loc_4DC7E
		move.l	#vdpComm(tiles_to_bytes($000),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_BlueSphereSKLogo).l,a0
		jsr	(Nem_Decomp).l
		lea	PLC_SphereResults(pc),a1
		jsr	(Load_PLC_Immediate).l
		lea	(RAM_start).l,a1
		lea	(ArtKosM_SKPoseBanner+2).l,a0
		jsr	(Kos_Decomp).l
		lea	(ArtKosM_ANDKnuckles+2).l,a0
		jsr	(Kos_Decomp).l
		lea	(ArtKosM_EndingMasterEmerald+2).l,a0
		jsr	(Kos_Decomp).l
		lea	(ArtKosM_RobotnikSmug+2).l,a0
		jsr	(Kos_Decomp).l
		lea	(ArtKosM_EggRoboHead+2).l,a0
		jsr	(Kos_Decomp).l
		move.w	a1,d3
		lsr.w	#1,d3
		move.l	#$FF0000,d1
		move.w	#tiles_to_bytes($180),d2
		jsr	(Add_To_DMA_Queue).l
		lea	(Level_layout_header).w,a1
		lea	(MapEni_BlueSphereTitleBG).l,a0
		move.w	#make_art_tile($000,2,0),d0
		jsr	(Eni_Decomp).l
		bsr.w	sub_4DEA2
		move.l	#Obj_SpheresTitle_4D03E,(Player_2).w
		move.w	#$C0,(Player_2+y_pos).w
		move.l	#Obj_SphereResults_4E0A4,(Dynamic_object_RAM+(object_size*10)).w
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		clr.b	(Super_Sonic_Knux_flag).w
		clr.b	(Super_palette_status).w
		move.w	#1,(Player_mode).w
		moveq	#signextendB(mus_Invincibility),d0
		jsr	(Play_Music).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l

- ;loc_4DD5E:
		move.b	#$1A,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		jsr	(Wait_VSync).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		jsr	(Process_Kos_Module_Queue).l
		jsr	(SuperHyper_PalCycle).l
		move.b	(Blue_spheres_difficulty).w,d1
		cmp.b	(Blue_spheres_target_difficulty).w,d1
		bne.s	- ;loc_4DD5E
		move.b	(Ctrl_1_pressed).w,d0
		beq.s	- ;loc_4DD5E
		tst.b	(Blue_spheres_progress_flag).w
		bmi.s	locret_4DDE6
		tst.b	(Blue_spheres_mode).w
		beq.s	locret_4DDE6
		lea	(Blue_spheres_current_stage).w,a2
		moveq	#$A-1,d1

- ;loc_4DDAA:
		addq.l	#1,(Blue_spheres_current_level).w
		addi.l	#$1030507,(a2)
		andi.b	#$7F,(a2)
		cmpi.b	#$7F,1(a2)
		blo.s	+ ;loc_4DDC6
		subi.b	#$7F,1(a2)

+ ;loc_4DDC6:
		cmpi.b	#$7E,2(a2)
		blo.s	+ ;loc_4DDD4
		subi.b	#$7E,2(a2)

+ ;loc_4DDD4:
		cmpi.b	#$7D,3(a2)
		blo.s	+ ;loc_4DDE2
		subi.b	#$7D,3(a2)

+ ;loc_4DDE2:
		dbf	d1,- ;loc_4DDAA

locret_4DDE6:
		rts
; ---------------------------------------------------------------------------
PLC_SphereResults: plrlistheader
		plreq $26F, ArtNem_RobotnikShip
		plreq $2C1, ArtNem_Chicken
		plreq $2CF, ArtNem_Squirrel
		plreq $2E1, ArtNem_Rabbit
		plreq $7A0, ArtNem_BlueSphereTails
PLC_SphereResults_End

Pal_SphereResults_012:
		binclude "General/Blue Sphere/Palettes/Results Line 0-2.bin"
		even
Pal_SphereResults_3:
		binclude "General/Blue Sphere/Palettes/Results Line 3.bin"
		even
aCongratulation:
		dc.b "CONGRATULATIONS!",0
		even
aPerfect:
		dc.b "PERFECT",0
		even

; =============== S U B R O U T I N E =======================================


sub_4DEA2:
		lea	word_4DEDC(pc),a2
		moveq	#$E-1,d5

- ;loc_4DEA8:
		lea	(Level_layout_header).w,a1
		move.w	(a2)+,d0
		swap	d0
		move.w	#3,d0
		moveq	#$C-1,d1
		moveq	#8-1,d2
		jsr	(Plane_Map_To_VRAM).l
		dbf	d5,- ;loc_4DEA8
		move.w	#$10,(V_scroll_value_BG).w
		lea	(H_scroll_buffer+2).w,a1
		move.w	#$E0-1,d1

- ;loc_4DED0:
		subi.w	#$10,(a1)
		addq.w	#4,a1
		dbf	d1,- ;loc_4DED0
		rts
; End of function sub_4DEA2

; ---------------------------------------------------------------------------
word_4DEDC:
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$000,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$020,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$040,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$410,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$430,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$450,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$3F0,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$800,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$820,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$840,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$C10,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$C30,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$C50,VRAM,WRITE)>>16
		dc.w vdpComm(VRAM_Plane_B_Name_Table+$BF0,VRAM,WRITE)>>16
; ---------------------------------------------------------------------------

Obj_SphereResults_4DEF8:
		move.w	#5*60,$30(a0)
		move.l	#loc_4DF04,(a0)

loc_4DF04:
		subq.w	#1,$30(a0)
		bpl.s	++ ;loc_4DF3E
		tst.w	(Special_stage_rings_left).w
		bne.s	+ ;loc_4DF38
		move	#$2700,sr
		lea	aPerfect(pc),a1
		move.w	#$49A,d2
		move.w	#$85BF,d6
		jsr	(sub_5B318).l
		move	#$2300,sr
		moveq	#signextendB(sfx_Continue),d0
		jsr	(Play_SFX).l
		move.w	#5*60,$30(a0)

+ ;loc_4DF38:
		move.l	#loc_4DF52,(a0)

+ ;loc_4DF3E:
		tst.w	(Special_stage_rings_left).w
		beq.s	locret_4DF50
		move.b	(Ctrl_1_pressed).w,d0
		beq.s	locret_4DF50
		move.b	#$2C,(Game_mode).w

locret_4DF50:
		rts
; ---------------------------------------------------------------------------

loc_4DF52:
		tst.w	(Special_stage_rings_left).w
		bne.s	+ ;loc_4DF5E
		subq.w	#1,$30(a0)
		bmi.s	++ ;loc_4DF64

+ ;loc_4DF5E:
		move.b	(Ctrl_1_pressed).w,d0
		beq.s	++ ;loc_4DF6A

+ ;loc_4DF64:
		move.b	#$2C,(Game_mode).w

+ ;loc_4DF6A:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$F,d0
		bne.s	locret_4DF84
		lea	(H_scroll_buffer+$120).w,a1
		moveq	#$10-1,d1

- ;loc_4DF7A:
		eori.w	#$100,(a1)
		addq.w	#4,a1
		dbf	d1,- ;loc_4DF7A

locret_4DF84:
		rts
; ---------------------------------------------------------------------------

Obj_SphereResults_4DF86:
		move.l	#Map_Sonic,mappings(a0)
		move.w	#make_art_tile($680,0,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$100,y_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#$13,anim(a0)
		cmpi.w	#1,(Player_mode).w
		beq.s	+ ;loc_4DFE8
		move.l	#Map_Knuckles,mappings(a0)
		move.b	#$24,anim(a0)
		lea	(Pal_Knuckles).l,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToLcnt($20),d6

- ;loc_4DFDA:
		move.l	(a1)+,(a2)+
		dbf	d6,- ;loc_4DFDA
		move.l	#loc_4E000,(a0)
		bra.s	loc_4E000
; ---------------------------------------------------------------------------

+ ;loc_4DFE8:
		move.l	#loc_4DFEE,(a0)

loc_4DFEE:
		jsr	(Animate_Sonic).l
		jsr	(Sonic_Load_PLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4E000:
		jsr	(Animate_Knuckles).l
		jsr	(Knuckles_Load_PLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_Sphere_Results_4E012:
		movea.l	a0,a1
		moveq	#0,d0
		moveq	#0,d2
		moveq	#7-1,d1

- ;loc_4E01A:
		move.l	#loc_4E074,(a1)
		move.l	#Map_BSResultsEmerald,mappings(a1)
		move.w	#make_art_tile($1DC,0,0),art_tile(a1)
		move.w	#$80,priority(a1)
		move.b	#$18,width_pixels(a1)
		move.b	#$18,height_pixels(a1)
		move.b	d0,angle(a1)
		addi.b	#$24,d0
		move.b	d2,mapping_frame(a1)
		addq.b	#1,d2
		lea	next_object(a1),a1
		dbf	d1,- ;loc_4E01A
		move.l	#loc_4E05C,(a0)

loc_4E05C:
		move.b	$27(a0),d0
		jsr	(GetSineCosine).l
		asl.w	#4,d0
		addi.w	#$4000,d0
		move.w	d0,(Stat_table).w
		addq.b	#1,$27(a0)

loc_4E074:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		move.w	(Stat_table).w,d2
		muls.w	d2,d1
		muls.w	d2,d0
		swap	d1
		swap	d0
		addi.w	#$120,d1
		addi.w	#$100,d0
		move.w	d1,x_pos(a0)
		move.w	d0,y_pos(a0)
		addq.b	#1,angle(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SphereResults_4E0A4:
		move.l	#Map_BlueSpheresText,mappings(a0)
		move.w	#make_art_tile($54E,0,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$140,y_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$28,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.b	#4,mapping_frame(a0)
		move.w	y_pos(a0),d3
		addi.w	#$10,d3
		movea.l	a0,a1
		move.b	#$A,next_object+mapping_frame(a1)
		move.w	#$114,d2
		moveq	#4-1,d1

- ;loc_4E0EC:
		lea	next_object(a1),a1
		move.l	#loc_4E1AA,(a1)
		move.w	d2,x_pos(a1)
		move.w	d3,y_pos(a1)
		addq.w	#8,d2
		dbf	d1,- ;loc_4E0EC
		move.b	#$B,mapping_frame(a1)
		move.w	#$1D,$30(a0)
		move.l	#loc_4E116,(a0)

loc_4E116:
		moveq	#0,d1
		move.b	(Blue_spheres_difficulty).w,d1
		addq.b	#1,d1
		bsr.w	sub_4D1AA
		subq.w	#1,$30(a0)
		bpl.s	+ ;loc_4E146
		move.w	#$1D,$30(a0)
		move.b	(Blue_spheres_difficulty).w,d1
		cmp.b	(Blue_spheres_target_difficulty).w,d1
		beq.s	+ ;loc_4E146
		addq.b	#1,(Blue_spheres_difficulty).w
		bsr.s	Difficulty_Level_Sprites_Display
		moveq	#signextendB(sfx_LaunchReady),d0
		jsr	(Play_SFX).l

+ ;loc_4E146:
		move.b	#4,mapping_frame(a0)
		cmpi.b	#12,(Blue_spheres_difficulty).w
		bne.s	+ ;loc_4E15A
		move.b	#5,mapping_frame(a0)

+ ;loc_4E15A:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


Difficulty_Level_Sprites_Display:
		jsr	(AllocateObject).l
		bne.w	locret_4E178
		moveq	#0,d1
		move.b	(Blue_spheres_difficulty).w,d1
		subq.b	#1,d1
		lsl.w	#2,d1
		move.l	Difficulty_Sprites(pc,d1.w),(a1)

locret_4E178:
		rts
; End of function Difficulty_Level_Sprites_Display

; ---------------------------------------------------------------------------
Difficulty_Sprites:
		dc.l Obj_Difficulty_Sonic
		dc.l Obj_Difficulty_Tails
		dc.l Obj_Difficulty_Knuckles
		dc.l Obj_Difficulty_Eggman
		dc.l Obj_Difficulty_MechaSonic
		dc.l Obj_Difficulty_Ship
		dc.l Obj_Difficulty_SpawnChickens
		dc.l Obj_Difficulty_SpawnSquirrels
		dc.l Obj_Difficulty_SpawnRabbits
		dc.l Obj_Difficulty_MasterEmerald
		dc.l Obj_Difficulty_SKLogo
		dc.l Obj_Difficulty_SuperSonic
; ---------------------------------------------------------------------------

loc_4E1AA:
		bsr.w	sub_4D5C2
		move.l	#loc_4E1B4,(a0)

loc_4E1B4:
		cmpi.b	#12,(Blue_spheres_difficulty).w
		bne.s	+ ;loc_4E1BE
		rts
; ---------------------------------------------------------------------------

+ ;loc_4E1BE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_Difficulty_Sonic:
		move.l	#Map_Sonic,mappings(a0)
		move.w	#make_art_tile($680,0,1),art_tile(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$120,y_pos(a0)
		bset	#0,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#$13,anim(a0)
		move.l	#loc_4E202,(a0)

loc_4E202:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_4E222
		move.l	#Map_SuperSonic,mappings(a0)
		move.b	#$1F,anim(a0)
		move.l	#loc_4E222,(a0)
		move.w	#$14,$30(a0)

loc_4E222:
		tst.b	(Super_palette_status).w
		bpl.s	loc_4E23A
		subq.w	#1,$30(a0)
		bpl.s	loc_4E23A
		move.b	#5,anim(a0)
		move.l	#loc_4E23A,(a0)

loc_4E23A:
		jsr	(Animate_Sonic).l
		jsr	(Sonic_Load_PLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_Difficulty_SuperSonic:
		move.b	#1,(Super_palette_status).w
		move.b	#$F,(Palette_timer).w
		move.b	#1,(Super_Sonic_Knux_flag).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_Difficulty_Tails:
		move.l	#Map_BSTailsPose,mappings(a0)
		move.w	#make_art_tile($7A0,1,1),art_tile(a0)
		move.w	#$FC,x_pos(a0)
		move.w	#$11B,y_pos(a0)
		bset	#0,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.l	#loc_4E29C,(a0)

loc_4E29C:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_BSTailsPose:
		include "General/Blue Sphere/Map - Tails Pose.asm"
; ---------------------------------------------------------------------------

Obj_Difficulty_Knuckles:
		move.l	#Map_Knuckles,mappings(a0)
		move.w	#make_art_tile($6A0,1,1),art_tile(a0)
		move.w	#$138,x_pos(a0)
		move.w	#$118,y_pos(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#$24,anim(a0)
		move.l	#loc_4E2F0,(a0)

loc_4E2F0:
		jsr	(Animate_Knuckles).l
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	$30(a0),d0
		beq.s	+ ;loc_4E310
		move.b	d0,$30(a0)
		move.w	#tiles_to_bytes($6A0),d4
		jsr	(loc_18122).l

+ ;loc_4E310:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_BSResultsEmerald:
		include "General/Blue Sphere/Map - Results Emerald.asm"
