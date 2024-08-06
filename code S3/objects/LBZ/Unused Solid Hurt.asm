Obj_LBZUnusedSolidHurt:
		move.l	#Map_LBZUnusedSolidHurt,mappings(a0)
		move.w	#make_art_tile($2EA,2,0),art_tile(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.w	#$200,priority(a0)
		move.w	y_pos(a0),$30(a0)
		move.l	#loc_26930,(a0)

loc_26930:
		tst.b	$2E(a0)
		beq.s	+ ;loc_26966
		move.w	y_vel(a0),d0
		addi.w	#8,y_vel(a0)
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,y_pos(a0)
		move.w	$30(a0),d0
		addq.w	#2,d0
		cmp.w	y_pos(a0),d0
		bcc.s	+ ;loc_26966
		move.w	$30(a0),y_pos(a0)
		clr.w	$16(a0)
		clr.w	y_vel(a0)
		clr.b	$2E(a0)

+ ;loc_26966:
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	#$11,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		jsr	(SolidObjectFull2_1P).l
		cmpi.w	#-2,d4
		bne.s	+ ;loc_2698E
		bsr.s	sub_269E0

+ ;loc_2698E:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		jsr	(SolidObjectFull2_1P).l
		cmpi.w	#-2,d4
		bne.s	+ ;loc_269A6
		bsr.s	sub_269E0

+ ;loc_269A6:
		move.b	status(a0),d6
		andi.b	#standing_mask,d6
		beq.s	++ ;loc_269CE
		move.b	d6,d0
		andi.b	#p1_standing,d0
		beq.s	+ ;loc_269C0
		lea	(Player_1).w,a1
		bsr.w	sub_228EC

+ ;loc_269C0:
		andi.b	#p2_standing,d6
		beq.s	+ ;loc_269CE
		lea	(Player_2).w,a1
		bsr.w	sub_228EC

+ ;loc_269CE:
		lea	(Ani_LBZUnusedSolidHurt).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_269E0:
		move.w	#-$40,y_vel(a0)
		move.b	#1,$2E(a0)
		rts
; End of function sub_269E0

; ---------------------------------------------------------------------------
Ani_LBZUnusedSolidHurt:
		include "Levels/LBZ/Misc Object Data/Anim - Unused Solid Hurt.asm"
Map_LBZUnusedSolidHurt:
		include "Levels/LBZ/Misc Object Data/Map - Unused Solid Hurt.asm"
; ---------------------------------------------------------------------------


