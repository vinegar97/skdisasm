Obj_HCZWaveSplash:
		move.l	#Map_HCZWaveSplash,mappings(a0)
		move.w	#make_art_tile($42E,0,1),art_tile(a0)
		move.b	#4,render_flags(a0)
		move.b	#$80,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		bset	#6,render_flags(a0)
		move.w	#1,mainspr_childsprites(a0)
		lea	sub2_x_pos(a0),a2
		move.w	x_pos(a0),(a2)
		addi.w	#$C0,(a2)+
		move.w	y_pos(a0),(a2)+
		move.l	#loc_1F244,(a0)

loc_1F244:
		move.w	(Camera_X_pos).w,d1
		andi.w	#$FFE0,d1
		addi.w	#$60,d1
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc_1F25C
		addi.w	#$20,d1

loc_1F25C:
		move.w	d1,x_pos(a0)
		move.w	(Water_level).w,d1
		move.w	d1,y_pos(a0)
		lea	sub2_x_pos(a0),a2
		move.w	x_pos(a0),(a2)
		addi.w	#$C0,(a2)+
		move.w	y_pos(a0),(a2)+
		tst.b	$32(a0)
		bne.s	loc_1F296
		tst.b	(Ctrl_1_pressed_logical).w
		bmi.s	loc_1F28A
		tst.b	(Ctrl_2_pressed_logical).w
		bpl.s	loc_1F2A6

loc_1F28A:
		addq.b	#3,mapping_frame(a0)
		move.b	#1,$32(a0)
		bra.s	loc_1F2C4
; ---------------------------------------------------------------------------

loc_1F296:
		tst.w	(Game_paused).w
		bne.s	loc_1F2C4
		move.b	#0,$32(a0)
		subq.b	#3,mapping_frame(a0)

loc_1F2A6:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_1F2C4
		move.b	#9,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#4,mapping_frame(a0)
		blo.s	loc_1F2C4
		move.b	#1,mapping_frame(a0)

loc_1F2C4:
		move.b	mapping_frame(a0),1(a2)
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
Map_HCZWaveSplash:
		include "Levels/HCZ/Misc Object Data/Map - Wave Splash.asm"
; ---------------------------------------------------------------------------
