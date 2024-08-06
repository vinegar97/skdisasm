; ---------------------------------------------------------------------------
; Small bubbles from Sonic's face while underwater
; ---------------------------------------------------------------------------
Obj_AirCountdown:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w .Init-.Index
		dc.w AirCountdown_Animate-.Index
		dc.w AirCountdown_ChkWater-.Index
		dc.w AirCountdown_Display-.Index
		dc.w AirCountdown_Delete-.Index
		dc.w AirCountdown_Countdown-.Index
		dc.w AirCountdown_AirLeft-.Index
		dc.w AirCountdown_DisplayNumber-.Index
		dc.w AirCountdown_Delete-.Index
; ---------------------------------------------------------------------------

.Init:
		addq.b	#2,routine(a0)
		move.l	#Map_Bubbler,mappings(a0)
		tst.b	parent+1(a0)
		beq.s	loc_16F36
		move.l	#Map_Bubbler2,mappings(a0)

loc_16F36:
		move.w	#make_art_tile($45C,0,0),art_tile(a0)
		move.b	#$84,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.b	subtype(a0),d0
		bpl.s	loc_16F64
		addq.b	#8,routine(a0)
		andi.w	#$7F,d0
		move.b	d0,$37(a0)
		bra.w	AirCountdown_Countdown
; ---------------------------------------------------------------------------

loc_16F64:
		move.b	d0,anim(a0)
		move.w	x_pos(a0),$34(a0)
		move.w	#-$100,y_vel(a0)

AirCountdown_Animate:
		lea	(Ani_AirCountdown).l,a1
		jsr	(Animate_Sprite).l

AirCountdown_ChkWater:
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0		; has bubble reached the water surface?
		blo.s	AirCountdown_Wobble	; if not, branch
		; pop the bubble:
		move.b	#6,routine(a0)
		addq.b	#7,anim(a0)
		cmpi.b	#$D,anim(a0)
		beq.s	AirCountdown_Display
		bcs.s	AirCountdown_Display
		move.b	#$D,anim(a0)
		bra.s	AirCountdown_Display
; ---------------------------------------------------------------------------

AirCountdown_Wobble:
		tst.w	(WindTunnel_flag).w
		beq.s	loc_16FB0
		addq.w	#4,$34(a0)

loc_16FB0:
		move.b	angle(a0),d0
		addq.b	#1,angle(a0)
		andi.w	#$7F,d0
		lea	(AirCountdown_WobbleData).l,a1
		move.b	(a1,d0.w),d0
		ext.w	d0
		add.w	$34(a0),d0
		move.w	d0,x_pos(a0)
		bsr.w	AirCountdown_ShowNumber
		jsr	(MoveSprite2).l
		tst.b	render_flags(a0)
		bpl.s	loc_16FE6
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_16FE6:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; AirCountdown_Display and AirCountdown_DisplayNumber were split in this
; game, unlike Sonic 2, to fix a bug where the countdown numbers corrupted
; if they reached the surface of the water.
; (The start of ARZ Act 1 is a good place to see this).


AirCountdown_Display:
		bsr.s	AirCountdown_ShowNumber
		lea	(Ani_AirCountdown).l,a1
		jsr	(Animate_Sprite).l
		bsr.w	AirCountdown_Load_Art
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

AirCountdown_Delete:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

AirCountdown_AirLeft:
		movea.l	$40(a0),a2	; a2=character
		cmpi.b	#12,air_left(a2)	; check air remaining
		bhi.s	loc_17044		; if higher than 12, branch
		subq.w	#1,$3C(a0)
		bne.s	AirCountdown_Display2
		move.b	#$E,routine(a0)
		addq.b	#7,anim(a0)
		bra.s	AirCountdown_Display
; ---------------------------------------------------------------------------

AirCountdown_Display2:
		lea	(Ani_AirCountdown).l,a1
		jsr	(Animate_Sprite).l
		bsr.w	AirCountdown_Load_Art
		tst.b	render_flags(a0)
		bpl.s	loc_17044
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_17044:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

AirCountdown_DisplayNumber:
		movea.l	$40(a0),a2	; a2=character
		cmpi.b	#12,air_left(a2)
		bhi.s	AirCountdown_Delete
		bsr.s	AirCountdown_ShowNumber
		lea	(Ani_AirCountdown).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


AirCountdown_ShowNumber:
		tst.w	$3C(a0)
		beq.s	locret_170B4
		subq.w	#1,$3C(a0)
		bne.s	locret_170B4
		cmpi.b	#7,anim(a0)
		bhs.s	locret_170B4
		move.w	#$F,$3C(a0)
		clr.w	y_vel(a0)
		move.b	#$80,render_flags(a0)
		move.w	x_pos(a0),d0
		sub.w	(Camera_X_pos).w,d0
		addi.w	#$80,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		move.w	d0,y_pos(a0)
		move.b	#$C,routine(a0)

locret_170B4:
		rts
; End of function AirCountdown_ShowNumber

; ---------------------------------------------------------------------------
AirCountdown_WobbleData:
		dc.b  0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2
		dc.b  2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
		dc.b  3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2
		dc.b  2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
		dc.b  0,-1,-1,-1,-1,-1,-2,-2,-2,-2,-2,-3,-3,-3,-3,-3
		dc.b -3,-3,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4
		dc.b -4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-3
		dc.b -3,-3,-3,-3,-3,-3,-2,-2,-2,-2,-2,-1,-1,-1,-1,-1

		; Amazing, this S1 leftover is *still* here.
		; This was used by LZ's water ripple effect in REV01.
		dc.b  0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2
		dc.b  2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
		dc.b  3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2
		dc.b  2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
		dc.b  0,-1,-1,-1,-1,-1,-2,-2,-2,-2,-2,-3,-3,-3,-3,-3
		dc.b -3,-3,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4
		dc.b -4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-3
		dc.b -3,-3,-3,-3,-3,-3,-2,-2,-2,-2,-2,-1,-1,-1,-1,-1

; =============== S U B R O U T I N E =======================================


AirCountdown_Load_Art:
		moveq	#0,d1
		move.b	mapping_frame(a0),d1
		cmpi.b	#9,d1
		blo.s	locret_171FC
		cmpi.b	#$13,d1
		bhs.s	locret_171FC
		cmp.b	$32(a0),d1
		beq.s	locret_171FC
		move.b	d1,$32(a0)
		subi.w	#9,d1
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		lsl.w	#6,d1
		addi.l	#ArtUnc_AirCountdown,d1
		move.w	#tiles_to_bytes(ArtTile_DashDust),d2
		tst.b	parent+1(a0)
		beq.s	loc_171F2
		move.w	#tiles_to_bytes(ArtTile_DashDust_P2),d2

loc_171F2:
		move.w	#$60,d3
		jsr	(Add_To_DMA_Queue).l

locret_171FC:
		rts
; End of function AirCountdown_Load_Art

; ---------------------------------------------------------------------------

AirCountdown_Countdown:
		movea.l	$40(a0),a2	; a2=character
		tst.w	$30(a0)
		bne.w	loc_1730C
		cmpi.b	#6,routine(a2)
		bhs.w	locret_17410
		btst	#Status_BublShield,status_secondary(a2)
		bne.w	locret_17410
		btst	#Status_Underwater,status(a2)
		beq.w	locret_17410
		subq.w	#1,$3C(a0)
		bpl.w	loc_17324
		move.w	#60-1,$3C(a0)
		move.w	#1,$3A(a0)
		jsr	(Random_Number).l
		andi.w	#1,d0
		move.b	d0,$38(a0)
		moveq	#0,d0
		move.b	air_left(a2),d0	; check air remaining
		cmpi.w	#25,d0
		beq.s	AirCountdown_WarnSound	; play ding sound if air is 25
		cmpi.w	#20,d0
		beq.s	AirCountdown_WarnSound	; play ding sound if air is 20
		cmpi.w	#15,d0
		beq.s	AirCountdown_WarnSound	; play ding sound if air is 15
		cmpi.w	#12,d0
		bhi.s	AirCountdown_ReduceAir
		bne.s	loc_17278
		tst.b	parent+1(a0)
		bne.s	loc_17278
		moveq	#signextendB(mus_Drowning),d0
		jsr	(Play_Music).l

loc_17278:
		subq.b	#1,$36(a0)
		bpl.s	AirCountdown_ReduceAir
		move.b	$37(a0),$36(a0)
		bset	#7,$3A(a0)
		bra.s	AirCountdown_ReduceAir
; ---------------------------------------------------------------------------

AirCountdown_WarnSound:
		tst.b	parent+1(a0)
		bne.s	AirCountdown_ReduceAir
		moveq	#signextendB(sfx_AirDing),d0
		jsr	(Play_SFX).l

AirCountdown_ReduceAir:
		subq.b	#1,air_left(a2)
		bcc.w	loc_17322
		move.b	#$81,object_control(a2)
		move.w	#sfx_Drown,d0
		jsr	(Play_SFX).l
		move.b	#$A,$38(a0)
		move.w	#1,$3A(a0)
		move.w	#$78,$30(a0)
		movea.l	a2,a1
		bsr.w	Player_ResetAirTimer
		move.l	a0,-(sp)
		movea.l	a2,a0
		bsr.w	Player_TouchFloor
		move.b	#$17,anim(a0)
		bset	#Status_InAir,status(a0)
		bset	#7,art_tile(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#$C,routine(a0)
		movea.l	(sp)+,a0
		cmpa.w	#Player_1,a2
		bne.s	locret_1730A
		move.b	#1,(Deform_lock).w

locret_1730A:
		rts
; ---------------------------------------------------------------------------

loc_1730C:
		move.b	#$17,anim(a2)
		subq.w	#1,$30(a0)
		bne.s	loc_17320
		move.b	#6,routine(a2)
		rts
; ---------------------------------------------------------------------------

loc_17320:
		bra.s	loc_17324
; ---------------------------------------------------------------------------

loc_17322:
		bra.s	AirCountdown_MakeItem
; ---------------------------------------------------------------------------

loc_17324:
		tst.w	$3A(a0)
		beq.w	locret_17410
		subq.w	#1,$3E(a0)
		bpl.w	locret_17410

AirCountdown_MakeItem:
		jsr	(Random_Number).l
		andi.w	#$F,d0
		addq.w	#8,d0
		move.w	d0,$3E(a0)
		jsr	(AllocateObject).l
		bne.w	locret_17410
		move.l	(a0),(a1)		; load Obj_Air_Countdown
		move.w	x_pos(a2),x_pos(a1)	; match its X position to Sonic
		moveq	#6,d0
		btst	#Status_Facing,status(a2)
		beq.s	loc_17368
		neg.w	d0
		move.b	#$40,angle(a1)

loc_17368:
		add.w	d0,x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)
		move.l	$40(a0),$40(a1)
		move.b	#6,subtype(a1)
		tst.w	$30(a0)
		beq.w	loc_173BA
		andi.w	#7,$3E(a0)
		addi.w	#0,$3E(a0)
		move.w	y_pos(a2),d0
		subi.w	#$C,d0
		move.w	d0,y_pos(a1)
		jsr	(Random_Number).l
		move.b	d0,angle(a1)
		move.w	(Level_frame_counter).w,d0
		andi.b	#3,d0
		bne.s	loc_17406
		move.b	#$E,subtype(a1)
		bra.s	loc_17406
; ---------------------------------------------------------------------------
; has something to do with making bubbles come out less regularly
; when Sonic is almost drowning
loc_173BA:
		btst	#7,$3A(a0)
		beq.s	loc_17406
		moveq	#0,d2
		move.b	air_left(a2),d2
		cmpi.b	#12,d2
		bhs.s	loc_17406
		lsr.w	#1,d2
		jsr	(Random_Number).l
		andi.w	#3,d0
		bne.s	loc_173EE
		bset	#6,$3A(a0)
		bne.s	loc_17406
		move.b	d2,subtype(a1)
		move.w	#$1C,$3C(a1)

loc_173EE:
		tst.b	$38(a0)
		bne.s	loc_17406
		bset	#6,$3A(a0)
		bne.s	loc_17406
		move.b	d2,subtype(a1)
		move.w	#$1C,$3C(a1)

loc_17406:
		subq.b	#1,$38(a0)
		bpl.s	locret_17410
		clr.w	$3A(a0)

locret_17410:
		rts

; =============== S U B R O U T I N E =======================================


Player_ResetAirTimer:
		cmpi.b	#12,air_left(a1)
		bhi.s	loc_1744C		; branch if countdown hasn't started yet
		cmpa.w	#Player_1,a1
		bne.s	loc_1744C		; branch if it isn't player 1
		move.w	(Current_music).w,d0	; prepare to play current level's music
		btst	#Status_Invincible,status_secondary(a1)
		beq.s	loc_17430		; branch if Sonic is not invincible
		move.w	#mus_Invincibility,d0	; prepare to play invincibility music

loc_17430:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.w	loc_1743C		; branch if it isn't Super
		move.w	#mus_Invincibility,d0	; prepare to play Super Sonic music (same as invincibility in this game)

loc_1743C:
		tst.b	(Boss_flag).w
		beq.s	loc_17446		; branch if not in a boss fight
		move.w	#mus_MinibossK,d0	; prepare to play boss music

loc_17446:
		jsr	(Play_Music).l

loc_1744C:
		move.b	#30,air_left(a1)	; reset air to full
		rts
; End of function Player_ResetAirTimer

; ---------------------------------------------------------------------------
Ani_AirCountdown:
		include "General/Sprites/Dash Dust/Anim - Air Countdown.asm"
; ---------------------------------------------------------------------------

Obj_S2Shield:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w .Init-.Index
		dc.w .Main-.Index
; ---------------------------------------------------------------------------

.Init:
		addq.b	#2,routine(a0)
		move.l	#Map_S2Shield,mappings(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)

.Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)
		bne.s	.locret_17566
		btst	#Status_Shield,status_secondary(a2)
		beq.s	.Destroy
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	.Display
		ori.w	#high_priority,art_tile(a0)

.Display:
		lea	(Ani_S2Shield).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.locret_17566:
		rts
; ---------------------------------------------------------------------------

.Destroy:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
off_1756E:
		dc.l byte_1776D
		dc.b    0,  $B
		dc.l byte_17782
		dc.b  $16,  $D
		dc.l byte_1779B
		dc.b  $2C,  $D
; ---------------------------------------------------------------------------

Obj_Invincibility:
		move.l	#ArtUnc_Invincibility,d1
		move.w	#tiles_to_bytes(ArtTile_Shield),d2
		move.w	#$200,d3
		jsr	(Add_To_DMA_Queue).l
		moveq	#0,d2
		lea	off_1756E-6(pc),a2
		lea	(a0),a1
		moveq	#4-1,d1

loc_1759E:
		move.l	#Obj_17670,(a1)
		move.l	#Map_Invincibility,mappings(a1)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a1)
		move.w	#$80,priority(a1)
		move.b	#4,render_flags(a1)
		bset	#6,render_flags(a1)
		move.b	#$10,width_pixels(a1)
		move.w	#2,mainspr_childsprites(a1)
		move.w	parent(a0),parent(a1)
		move.b	d2,$36(a1)
		addq.w	#1,d2
		move.l	(a2)+,$30(a1)
		move.w	(a2)+,$34(a1)
		lea	next_object(a1),a1
		dbf	d1,loc_1759E
		move.l	#loc_175F8,(a0)
		move.b	#4,$34(a0)

loc_175F8:
		tst.b	(Super_Sonic_Knux_flag).w
		bne.w	Delete_Current_Sprite
		movea.w	parent(a0),a1
		btst	#Status_Invincible,status_secondary(a1)
		beq.w	Delete_Current_Sprite
		move.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),d1
		move.w	d1,y_pos(a0)
		lea	sub2_x_pos(a0),a2
		lea	byte_17760(pc),a3
		moveq	#0,d5

loc_17628:
		move.w	$38(a0),d2
		move.b	(a3,d2.w),d5
		bpl.s	loc_17638
		clr.w	$38(a0)
		bra.s	loc_17628
; ---------------------------------------------------------------------------

loc_17638:
		addq.w	#1,$38(a0)
		lea	byte_17720(pc),a6
		move.b	$34(a0),d6
		jsr	sub_1770A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		addi.w	#$20,d6
		jsr	sub_1770A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		moveq	#$12,d0
		btst	#Status_Facing,status(a1)
		beq.s	loc_17668
		neg.w	d0

loc_17668:
		add.b	d0,$34(a0)
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

Obj_17670:
		tst.b	(Super_Sonic_Knux_flag).w
		bne.w	Delete_Current_Sprite
		movea.w	parent(a0),a1
		btst	#Status_Invincible,status_secondary(a1)
		beq.w	Delete_Current_Sprite
		lea	(Pos_table_index).w,a5
		lea	(Pos_table).w,a6
		move.b	$36(a0),d1
		lsl.b	#2,d1
		move.w	d1,d2
		add.w	d1,d1
		add.w	d2,d1
		move.w	(a5),d0
		sub.b	d1,d0
		lea	(a6,d0.w),a2
		move.w	(a2)+,d0
		move.w	(a2)+,d1
		move.w	d0,x_pos(a0)
		move.w	d1,y_pos(a0)
		lea	sub2_x_pos(a0),a2
		movea.l	$30(a0),a3

loc_176B6:
		move.w	$38(a0),d2
		move.b	(a3,d2.w),d5
		bpl.s	loc_176C6
		clr.w	$38(a0)
		bra.s	loc_176B6
; ---------------------------------------------------------------------------

loc_176C6:
		swap	d5
		add.b	$35(a0),d2
		move.b	(a3,d2.w),d5
		addq.w	#1,$38(a0)
		lea	byte_17720(pc),a6
		move.b	$34(a0),d6
		jsr	sub_1770A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		addi.w	#$20,d6
		swap	d5
		jsr	sub_1770A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		moveq	#2,d0
		btst	#Status_Facing,status(a1)
		beq.s	loc_17702
		neg.w	d0

loc_17702:
		add.b	d0,$34(a0)
		bra.w	Draw_Sprite

; =============== S U B R O U T I N E =======================================


sub_1770A:
		andi.w	#$3E,d6
		move.b	(a6,d6.w),d2
		move.b	1(a6,d6.w),d3
		ext.w	d2
		ext.w	d3
		add.w	d0,d2
		add.w	d1,d3
		rts
; End of function sub_1770A

; ---------------------------------------------------------------------------
byte_17720:
		dc.b   $F,   0
		dc.b   $F,   3
		dc.b   $E,   6
		dc.b   $D,   8
		dc.b   $B,  $B
		dc.b    8,  $D
		dc.b    6,  $E
		dc.b    3,  $F
		dc.b    0, $10
		dc.b   -4,  $F
		dc.b   -7,  $E
		dc.b   -9,  $D
		dc.b  -$C,  $B
		dc.b  -$E,   8
		dc.b  -$F,   6
		dc.b -$10,   3
		dc.b -$10,   0
		dc.b -$10,  -4
		dc.b  -$F,  -7
		dc.b  -$E,  -9
		dc.b  -$C, -$C
		dc.b   -9, -$E
		dc.b   -7, -$F
		dc.b   -4,-$10
		dc.b   -1,-$10
		dc.b    3,-$10
		dc.b    6, -$F
		dc.b    8, -$E
		dc.b   $B, -$C
		dc.b   $D,  -9
		dc.b   $E,  -7
		dc.b   $F,  -4
byte_17760:
		dc.b    8,   5,   7,   6,   6,   7,   5,   8,   6,   7,   7,   6, $FF
byte_1776D:
		dc.b    8,   7,   6,   5,   4,   3,   4,   5,   6,   7, $FF,   3,   4,   5,   6,   7,   8,   7,   6,   5
		dc.b    4
byte_17782:
		dc.b    8,   7,   6,   5,   4,   3,   2,   3,   4,   5,   6,   7, $FF,   2,   3,   4,   5,   6,   7,   8
		dc.b    7,   6,   5,   4,   3
byte_1779B:
		dc.b    7,   6,   5,   4,   3,   2,   1,   2,   3,   4,   5,   6, $FF,   1,   2,   3,   4,   5,   6,   7
		dc.b    6,   5,   4,   3,   2
		even
Ani_S2Shield:
		include "General/Sprites/Shields/Anim - S2 Shield.asm"
Map_S2Shield:
		include "General/Sprites/Shields/Map - S2 Shield.asm"
Map_Invincibility:
		include "General/Sprites/Shields/Map - Invincibility.asm"
; ---------------------------------------------------------------------------

Obj_DashDust:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_178D4-.Index
		dc.w loc_1792A-.Index
		dc.w loc_17A1C-.Index
		dc.w loc_17A20-.Index
; ---------------------------------------------------------------------------

loc_178D4:
		addq.b	#2,routine(a0)
		move.l	#Map_DashDust,mappings(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.w	#make_art_tile(ArtTile_DashDust,0,0),art_tile(a0)
		move.w	#Player_1,parent(a0)
		move.w	#tiles_to_bytes(ArtTile_DashDust),vram_art(a0)
		cmpa.w	#Dust,a0
		beq.s	loc_1792A
		move.b	#1,$38(a0)
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_1792A
		move.w	#make_art_tile(ArtTile_DashDust_P2,0,0),art_tile(a0)
		move.w	#Player_2,parent(a0)
		move.w	#tiles_to_bytes(ArtTile_DashDust_P2),vram_art(a0)

loc_1792A:
		movea.w	parent(a0),a2
		moveq	#0,d0
		move.b	anim(a0),d0
		add.w	d0,d0
		move.w	off_1793E(pc,d0.w),d1
		jmp	off_1793E(pc,d1.w)
; ---------------------------------------------------------------------------
off_1793E:
		dc.w loc_179FE-off_1793E
		dc.w loc_17948-off_1793E
		dc.w loc_179A0-off_1793E
		dc.w loc_179F6-off_1793E
		dc.w loc_1796C-off_1793E
; ---------------------------------------------------------------------------

loc_17948:
		move.w	(Water_level).w,y_pos(a0)
		tst.b	prev_anim(a0)
		bne.w	loc_179FE
		move.w	x_pos(a2),x_pos(a0)
		move.b	#0,status(a0)
		andi.w	#drawing_mask,art_tile(a0)
		bra.w	loc_179FE
; ---------------------------------------------------------------------------

loc_1796C:
		tst.b	prev_anim(a0)
		bne.s	loc_17984
		move.w	x_pos(a2),x_pos(a0)
		move.b	#0,status(a0)
		andi.w	#drawing_mask,art_tile(a0)

loc_17984:
		lea	(Ani_DashSplashDrown).l,a1
		jsr	(Animate_Sprite).l
		move.l	#ArtUnc_SplashDrown,d6
		bsr.w	SplashDrown_Load_DPLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_179A0:
		cmpi.b	#12,air_left(a2)
		blo.w	loc_17A14
		cmpi.b	#4,routine(a2)
		bhs.s	loc_17A14
		tst.b	spin_dash_flag(a2)
		beq.s	loc_17A14
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)
		andi.b	#1,status(a0)
		tst.b	$38(a0)
		beq.s	loc_179DC
		subi.w	#4,y_pos(a0)

loc_179DC:
		tst.b	prev_anim(a0)
		bne.s	loc_179FE
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	loc_179FE
		ori.w	#high_priority,art_tile(a0)
		bra.s	loc_179FE
; ---------------------------------------------------------------------------

loc_179F6:
		cmpi.b	#12,air_left(a2)
		blo.s	loc_17A14

loc_179FE:
		lea	(Ani_DashSplashDrown).l,a1
		jsr	(Animate_Sprite).l
		bsr.w	DashDust_Load_DPLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_17A14:
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_17A1C:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

loc_17A20:
		movea.w	parent(a0),a2
		cmpi.b	#$D,anim(a2)
		beq.s	loc_17A3A
		move.b	#2,routine(a0)
		move.b	#0,$36(a0)
		rts
; ---------------------------------------------------------------------------

loc_17A3A:
		subq.b	#1,$36(a0)
		bpl.s	loc_17AB2
		move.b	#3,$36(a0)
		bsr.w	AllocateObject
		bne.s	loc_17AB2
		move.l	(a0),(a1)
		move.w	x_pos(a2),x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)
		addi.w	#$10,y_pos(a1)
		tst.b	$38(a0)
		beq.s	loc_17A6C
		subi.w	#4,y_pos(a1)

loc_17A6C:
		move.b	#0,status(a1)
		move.b	#3,anim(a1)
		addq.b	#2,routine(a1)
		move.l	mappings(a0),mappings(a1)
		move.b	render_flags(a0),render_flags(a1)
		move.w	#$80,priority(a1)
		move.b	#4,width_pixels(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.w	parent(a0),parent(a1)
		andi.w	#drawing_mask,art_tile(a1)
		tst.w	art_tile(a2)
		bpl.s	loc_17AB2
		ori.w	#high_priority,art_tile(a1)

loc_17AB2:
		bsr.s	DashDust_Load_DPLC
		rts

; =============== S U B R O U T I N E =======================================


DashDust_Load_DPLC:
		move.l	#ArtUnc_DashDust,d6

SplashDrown_Load_DPLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	$34(a0),d0
		beq.s	locret_17B0A
		move.b	d0,$34(a0)
		lea	(DPLC_DashSplashDrown).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_17B0A
		move.w	vram_art(a0),d4

loc_17AE2:
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
		dbf	d5,loc_17AE2

locret_17B0A:
		rts
; End of function DashDust_Load_DPLC

; ---------------------------------------------------------------------------
Ani_DashSplashDrown:
		include "General/Sprites/Dash Dust/Anim - Dash Dust.asm"
Map_DashDust:
		include "General/Sprites/Dash Dust/Map - Dash Dust.asm"
DPLC_DashSplashDrown:
		include "General/Sprites/Dash Dust/DPLC - Dash Dust.asm"
; ---------------------------------------------------------------------------

Obj_DashDust2P:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_17CE8-.Index
		dc.w loc_17D1E-.Index
		dc.w loc_17DAC-.Index
		dc.w loc_17DB0-.Index
; ---------------------------------------------------------------------------

loc_17CE8:
		addq.b	#2,routine(a0)
		move.l	#Map_DashDust2P,mappings(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.w	#make_art_tile(ArtTile_DashDust,0,0),art_tile(a0)
		move.w	#Player_1,parent(a0)
		cmpa.w	#Dust,a0
		beq.s	loc_17D1E
		move.w	#Player_2,parent(a0)

loc_17D1E:
		movea.w	parent(a0),a2
		moveq	#0,d0
		move.b	anim(a0),d0
		add.w	d0,d0
		move.w	off_17D32(pc,d0.w),d1
		jmp	off_17D32(pc,d1.w)
; ---------------------------------------------------------------------------
off_17D32:
		dc.w loc_17D3A-off_17D32
		dc.w loc_17D3A-off_17D32
		dc.w loc_17D42-off_17D32
		dc.w loc_17D8A-off_17D32
; ---------------------------------------------------------------------------

loc_17D3A:
		move.b	#0,mapping_frame(a0)
		bra.s	loc_17D92
; ---------------------------------------------------------------------------

loc_17D42:
		cmpi.b	#12,air_left(a2)
		blo.s	loc_17DA4
		cmpi.b	#4,routine(a2)
		bhs.s	loc_17DA4
		tst.b	spin_dash_flag(a2)
		beq.s	loc_17DA4
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)
		andi.b	#1,status(a0)
		tst.b	prev_anim(a0)
		bne.s	loc_17D92
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	loc_17D92
		ori.w	#high_priority,art_tile(a0)
		bra.s	loc_17D92
; ---------------------------------------------------------------------------

loc_17D8A:
		cmpi.b	#12,air_left(a2)
		blo.s	loc_17DA4

loc_17D92:
		lea	(Ani_DashDust2P).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_17DA4:
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_17DAC:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

loc_17DB0:
		movea.w	parent(a0),a2
		cmpi.b	#$D,anim(a2)
		beq.s	loc_17DCA
		move.b	#2,routine(a0)
		move.b	#0,$36(a0)
		rts
; ---------------------------------------------------------------------------

loc_17DCA:
		move.b	#0,mapping_frame(a0)
		subq.b	#1,$36(a0)
		bpl.s	locret_17E3C
		move.b	#3,$36(a0)
		bsr.w	AllocateObject
		bne.s	locret_17E3C
		move.l	(a0),(a1)
		move.w	x_pos(a2),x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)
		addi.w	#$C,y_pos(a1)
		move.b	#0,status(a1)
		move.b	#3,anim(a1)
		addq.b	#2,routine(a1)
		move.l	mappings(a0),mappings(a1)
		move.b	render_flags(a0),render_flags(a1)
		move.w	#$80,priority(a1)
		move.b	#4,width_pixels(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.w	parent(a0),parent(a1)
		andi.w	#drawing_mask,art_tile(a1)
		tst.w	art_tile(a2)
		bpl.s	locret_17E3C
		ori.w	#high_priority,art_tile(a1)

locret_17E3C:
		rts
; ---------------------------------------------------------------------------
Ani_DashDust2P:
		include "General/Sprites/Dash Dust/Anim - Dash Dust 2P.asm"
Map_DashDust2P:
		include "General/Sprites/Dash Dust/Map - Dash Dust 2P.asm"
; ---------------------------------------------------------------------------

Obj_SuperSonic_Stars:
		move.l	#ArtUnc_SuperSonic_Stars,d1
		move.w	#tiles_to_bytes(ArtTile_Shield),d2
		move.w	#$1A0,d3
		jsr	(Add_To_DMA_Queue).l
		move.l	#Map_SuperSonic_Stars,mappings(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		btst	#7,(Player_1+art_tile).w
		beq.s	loc_17EEA
		bset	#7,art_tile(a0)

loc_17EEA:
		move.l	#loc_17EF0,(a0)

loc_17EF0:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.w	loc_17F7C
		tst.b	anim(a0)
		beq.s	loc_17F02
		bsr.w	sub_17F82

loc_17F02:
		tst.b	$34(a0)
		beq.s	loc_17F4C
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_17F34
		move.b	#1,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#6,mapping_frame(a0)
		blo.s	loc_17F34
		move.b	#0,mapping_frame(a0)
		move.b	#0,$34(a0)
		move.b	#1,$35(a0)
		rts
; ---------------------------------------------------------------------------

loc_17F34:
		tst.b	$35(a0)
		bne.s	loc_17F46

loc_17F3A:
		move.w	(Player_1+x_pos).w,x_pos(a0)
		move.w	(Player_1+y_pos).w,y_pos(a0)

loc_17F46:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_17F4C:
		tst.b	(Player_1+object_control).w
		bne.s	loc_17F6E
		move.w	(Player_1+ground_vel).w,d0
		bpl.s	loc_17F5A
		neg.w	d0

loc_17F5A:
		cmpi.w	#$800,d0
		blo.s	loc_17F6E
		move.b	#0,mapping_frame(a0)
		move.b	#1,$34(a0)
		bra.s	loc_17F3A
; ---------------------------------------------------------------------------

loc_17F6E:
		move.b	#0,$34(a0)
		move.b	#0,$35(a0)
		rts
; ---------------------------------------------------------------------------

loc_17F7C:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_17F82:
		move.b	#0,anim(a0)
		lea	(Player_1).w,a2
		moveq	#$10-1,d5
		move.w	#$488,d4

loc_17F92:
		bsr.w	AllocateObject
		bne.w	locret_1800A
		move.l	#Obj_SuperSonic_Stars_Timer,(a1)
		move.w	x_pos(a2),x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)
		move.l	#Map_SuperSonic_Stars2,mappings(a1)
		move.w	#make_art_tile($79C,0,1),art_tile(a1)
		move.b	#$84,render_flags(a1)
		move.w	#$380,priority(a1)
		move.b	#8,width_pixels(a1)
		move.b	#8,height_pixels(a1)
		tst.w	d4
		bmi.s	loc_17FFA
		move.w	d4,d0
		jsr	(GetSineCosine).l
		move.w	d4,d2
		lsr.w	#8,d2
		asl.w	d2,d0
		asl.w	d2,d1
		move.w	d0,d2
		move.w	d1,d3
		addi.b	#$10,d4
		bcc.s	loc_17FFA
		subi.w	#$80,d4
		bcc.s	loc_17FFA
		move.w	#$488,d4

loc_17FFA:
		move.w	d2,x_vel(a1)
		move.w	d3,y_vel(a1)
		neg.w	d2
		neg.w	d4
		dbf	d5,loc_17F92

locret_1800A:
		rts
; End of function sub_17F82

; ---------------------------------------------------------------------------

Obj_SuperSonic_Stars_Timer:
		tst.b	render_flags(a0)
		bmi.s	loc_18018
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_18018:
		addq.b	#1,mapping_frame(a0)
		andi.b	#3,mapping_frame(a0)
		bsr.w	MoveSprite2
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
Map_SuperSonic_Stars:
		include "General/Sprites/Shields/Map - Super Sonic Stars.asm"
; ---------------------------------------------------------------------------

Obj_InstaShield:
		; Init
		move.l	#Map_InstaShield,mappings(a0)
		move.l	#DPLC_InstaShield,shield_plc(a0)			; Used by PLCLoad_Shields
		move.l	#ArtUnc_InstaShield,shield_art(a0)			; Used by PLCLoad_Shields
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.w	#tiles_to_bytes(ArtTile_Shield),vram_art(a0)	; Used by PLCLoad_Shields
		btst	#7,(Player_1+art_tile).w
		beq.s	.nothighpriority
		bset	#7,art_tile(a0)

	.nothighpriority:
		move.w	#1,anim(a0)			; Clear anim and set prev_anim to 1
		move.b	#-1,shield_prev_frame(a0)	; Reset shield_prev_frame (used by PLCLoad_Shields)
		move.l	#.Main,(a0)

.Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)	; Is the player invincible?
		bne.s	.locret_18158			; If so, return
		move.w	x_pos(a2),x_pos(a0)		; Inherit player's x_pos
		move.w	y_pos(a2),y_pos(a0)		; Inherit player's y_pos
		move.b	status(a2),status(a0)		; Inherit status
		andi.b	#1,status(a0)			; Limit inheritance to 'orientation' bit
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	.nothighpriority
		ori.w	#high_priority,art_tile(a0)

	.nothighpriority:
		lea	(Ani_InstaShield).l,a1
		jsr	(Animate_Sprite).l
		cmpi.b	#7,mapping_frame(a0)		; Has it reached then end of its animation?
		bne.s	.notover			; If not, branch
		move.b	#2,double_jump_flag(a2)		; Mark attack as over

	.notover:
		tst.b	mapping_frame(a0)		; Is this the first frame?
		beq.s	.loadnewDPLC			; If so, branch and load the DPLC for this and the next few frames
		cmpi.b	#3,mapping_frame(a0)		; Is this the third frame?
		bne.s	.skipDPLC			; If not, branch as we don't need to load another DPLC yet

	.loadnewDPLC:
		bsr.w	PLCLoad_Shields

	.skipDPLC:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.locret_18158:
		rts
; ---------------------------------------------------------------------------

Obj_FireShield:
		; Init
		move.l	#Map_FireShield,mappings(a0)
		move.l	#DPLC_FireShield,shield_plc(a0)				; Used by PLCLoad_Shields
		move.l	#ArtUnc_FireShield,shield_art(a0)			; Used by PLCLoad_Shields
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.w	#tiles_to_bytes(ArtTile_Shield),vram_art(a0)	; Used by PLCLoad_Shields
		btst	#7,(Player_1+art_tile).w
		beq.s	.nothighpriority
		bset	#7,art_tile(a0)

;loc_181A4:
	.nothighpriority:
		move.w	#1,anim(a0)				; Clear anim and set prev_anim to 1
		move.b	#-1,shield_prev_frame(a0)		; Reset shield_prev_frame (used by PLCLoad_Shields)
		move.l	#.Main,(a0)

.Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)	; Is player invincible?
		bne.s	.locret_18236				; If so, do not display and do not update variables
		cmpi.b	#$1C,anim(a2)				; Is player in their 'blank' animation?
		beq.s	.locret_18236				; If so, do not display and do not update variables
		btst	#Status_Shield,status_secondary(a2)	; Should the player still have a shield?
		beq.w	.Destroy			; If not, change to Insta-Shield
		btst	#Status_Underwater,status(a2)		; Is player underwater?
		bne.s	.DestroyUnderwater	; If so, branch
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		tst.b	anim(a0)				; Is shield in its 'dashing' state?
		bne.s	.nothighpriority			; If so, do not update orientation or allow changing of the priority art_tile bit
		move.b	status(a2),status(a0)			; Inherit status
		andi.b	#1,status(a0)				; Limit inheritance to 'orientation' bit
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	.nothighpriority
		ori.w	#high_priority,art_tile(a0)

	.nothighpriority:
		lea	(Ani_FireShield).l,a1
		jsr	(Animate_Sprite).l
		move.w	#$80,priority(a0)		; Layer shield over player sprite
		cmpi.b	#$F,mapping_frame(a0)		; Are these the frames that display in front of the player?
		blo.s	.overplayer			; If so, branch
		move.w	#$200,priority(a0)		; If not, layer shield behind player sprite

	.overplayer:
		bsr.w	PLCLoad_Shields
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.locret_18236:
		rts
; ---------------------------------------------------------------------------

.DestroyUnderwater:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		jsr	(AllocateObject).l		; Set up for a new object
		bne.w	.Destroy		; If that can't happen, branch
		move.l	#Obj_FireShield_Dissipate,(a1)	; Create dissipate object
		move.w	x_pos(a0),x_pos(a1)		; Put it at shields' x_pos
		move.w	y_pos(a0),y_pos(a1)		; Put it at shields' y_pos

.Destroy:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		move.l	#Obj_InstaShield,(a0)		; Replace the Fire Shield with the Insta-Shield
		rts
; ---------------------------------------------------------------------------

Obj_LightningShield:
		; init
		; Load Spark art
		move.l	#ArtUnc_LightningShield_Sparks,d1			; Load art source
		move.w	#tiles_to_bytes(ArtTile_Shield_Sparks),d2		; Load art destination
		move.w	#(ArtUnc_LightningShield_Sparks.end-ArtUnc_LightningShield_Sparks)/2,d3	; Size of art (in words)
		jsr	(Add_To_DMA_Queue).l

		move.l	#Map_LightningShield,mappings(a0)
		move.l	#DPLC_LightningShield,shield_plc(a0)			; Used by PLCLoad_Shields
		move.l	#ArtUnc_LightningShield,shield_art(a0)			; Used by PLCLoad_Shields
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.w	#tiles_to_bytes(ArtTile_Shield),vram_art(a0)	; Used by PLCLoad_Shields
		btst	#7,(Player_1+art_tile).w
		beq.s	.nothighpriority
		bset	#7,art_tile(a0)

	.nothighpriority:
		move.w	#1,anim(a0)				; Clear anim and set prev_anim to 1
		move.b	#-1,shield_prev_frame(a0)		; Reset shield_prev_frame (used by PLCLoad_Shields)
		move.l	#.Main,(a0)

.Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)	; Is player invincible?
		bne.s	.locret_1835E				; If so, do not display and do not update variables
		cmpi.b	#$1C,anim(a2)				; Is player in their 'blank' animation?
		beq.s	.locret_1835E				; If so, do not display and do not update variables
		btst	#Status_Shield,status_secondary(a2)	; Should the player still have a shield?
		beq.w	.Destroy		; If not, change to Insta-Shield
		btst	#Status_Underwater,status(a2)		; Is player underwater?
		bne.s	.DestroyUnderwater	; If so, branch
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)			; Inherit status
		andi.b	#1,status(a0)				; Limit inheritance to 'orientation' bit
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	.nothighpriority
		ori.w	#high_priority,art_tile(a0)

	.nothighpriority:
		tst.b	anim(a0)				; Is shield in its 'double jump' state?
		beq.s	.Display		; Is not, branch and display
		bsr.s	.CreateSpark		; Create sparks
		clr.b	anim(a0)				; Once done, return to non-'double jump' state

.Display:
		lea	(Ani_LightningShield).l,a1
		jsr	(Animate_Sprite).l
		move.w	#$80,priority(a0)			; Layer shield over player sprite
		cmpi.b	#$E,mapping_frame(a0)			; Are these the frames that display in front of the player?
		blo.s	.overplayer				; If so, branch
		move.w	#$200,priority(a0)			; If not, layer shield behind player sprite

	.overplayer:
		bsr.w	PLCLoad_Shields
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.locret_1835E:
		rts
; ---------------------------------------------------------------------------

.DestroyUnderwater:
		tst.w	(Palette_fade_timer).w
		bne.s	.Destroy
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0

		; Flashes the underwater palette white
		lea	(Water_palette).w,a1
		lea	(Target_water_palette).w,a2
		move.w	#bytesToLcnt($80),d0			; Size of Water_palette/4-1

;loc_18378:
;.FlashWater:
		move.l	(a1),(a2)+			; Backup palette entries
		move.l	#$0EEE0EEE,(a1)+		; Overwrite palette entries with white
		dbf	d0,.FlashWater			; Loop until entire thing is overwritten

		move.w	#0,(Water_palette_line_3).w			; Set the first colour in the third palette line to black
		move.b	#3,anim_frame_timer(a0)
		move.l	#Obj_LightningShield_DestroyUnderwater2,(a0)
		rts
; ---------------------------------------------------------------------------

.Destroy:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		move.l	#Obj_InstaShield,(a0)		; Replace the Lightning Shield with the Insta-Shield
		rts

; =============== S U B R O U T I N E =======================================


.CreateSpark:
		lea	(SparkVelocities).l,a2
		moveq	#4-1,d1

	.loop:
		bsr.w	AllocateObject		; Find free object slot
		bne.s	.end			; If one can't be found, return
		move.l	#Obj_LightningShield_Spark,(a1)	; Make new object a Spark
		move.w	x_pos(a0),x_pos(a1)		; (Spark) Inherit x_pos from source object (Lightning Shield)
		move.w	y_pos(a0),y_pos(a1)		; (Spark) Inherit y_pos from source object (Lightning Shield)
		move.l	mappings(a0),mappings(a1)	; (Spark) Inherit mappings from source object (Lightning Shield)
		move.w	art_tile(a0),art_tile(a1)	; (Spark) Inherit art_tile from source object (Lightning Shield)
		move.b	#4,render_flags(a1)
		move.w	#$80,priority(a1)
		move.b	#8,width_pixels(a1)
		move.b	#8,height_pixels(a1)
		move.b	#1,anim(a1)
		move.w	(a2)+,x_vel(a1)			; (Spark) Give x_vel (unique to each of the four Sparks)
		move.w	(a2)+,y_vel(a1)			; (Spark) Give y_vel (unique to each of the four Sparks)
		dbf	d1,.loop

	.end:
		rts
; End of function Obj_LightningShield_CreateSpark

; ---------------------------------------------------------------------------
SparkVelocities:
		dc.w  -$200, -$200
		dc.w   $200, -$200
		dc.w  -$200,  $200
		dc.w   $200,  $200
; ---------------------------------------------------------------------------

Obj_LightningShield_Spark:
		jsr	(MoveSprite2).l
		addi.w	#$18,y_vel(a0)
		lea	(Ani_LightningShield).l,a1
		jsr	(Animate_Sprite).l
		tst.b	routine(a0)			; Changed by Animate_Sprite
		bne.s	.Delete
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.Delete:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_LightningShield_DestroyUnderwater2:
		subq.b	#1,anim_frame_timer(a0)		; Is it time to end the white flash?
		bpl.s	.end			; If not, return
		lea	(Target_water_palette).w,a1
		lea	(Water_palette).w,a2
		move.w	#bytesToLcnt($80),d0		; Size of Water_palette/4-1

	.loop:
		move.l	(a1)+,(a2)+			; Restore backed-up underwater palette
		dbf	d0,.loop			; Loop until entire thing is restored
		move.l	#Obj_InstaShield,(a0)		; Replace Lightning Shield with Insta-Shield

	.end:
		rts
; ---------------------------------------------------------------------------

Obj_BubbleShield:
		; Init
		move.l	#Map_BubbleShield,mappings(a0)
		move.l	#DPLC_BubbleShield,shield_plc(a0)			; Used by PLCLoad_Shields
		move.l	#ArtUnc_BubbleShield,shield_art(a0)			; Used by PLCLoad_Shields
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.w	#tiles_to_bytes(ArtTile_Shield),vram_art(a0)	; Used by PLCLoad_Shields
		btst	#7,(Player_1+art_tile).w
		beq.s	.nothighpriority
		bset	#7,art_tile(a0)

	.nothighpriority:
		move.w	#1,anim(a0)				; Clear anim and set prev_anim to 1
		move.b	#-1,shield_prev_frame(a0)		; Reset shield_prev_frame (used by PLCLoad_Shields)
		movea.w	parent(a0),a1
		bsr.w	Player_ResetAirTimer
		move.l	#.Main,(a0)

.Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)	; Is player invincible?
		bne.s	.locret_18518				; If so, do not display and do not update variables
		cmpi.b	#$1C,anim(a2)				; Is player in their 'blank' animation?
		beq.s	.locret_18518				; If so, do not display and do not update variables
		btst	#Status_Shield,status_secondary(a2)	; Should the player still have a shield?
		beq.s	.Destroy		; If not, change to Insta-Shield
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)			; Inherit status
		andi.b	#1,status(a0)				; Limit inheritance to 'orientation' bit
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	.nothighpriority
		ori.w	#high_priority,art_tile(a0)

	.nothighpriority:
		lea	(Ani_BubbleShield).l,a1
		jsr	(Animate_Sprite).l
		bsr.w	PLCLoad_Shields
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.locret_18518:
		rts
; ---------------------------------------------------------------------------

.Destroy:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		move.l	#Obj_InstaShield,(a0)		; Replace the Bubble Shield with the Insta-Shield
		rts

; =============== S U B R O U T I N E =======================================


PLCLoad_Shields:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	shield_prev_frame(a0),d0
		beq.s	.locret_18576
		move.b	d0,shield_prev_frame(a0)
		movea.l	shield_plc(a0),a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	.locret_18576
		move.w	vram_art(a0),d4

.ReadEntry:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	shield_art(a0),d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,.ReadEntry

.locret_18576:
		rts
; End of function PLCLoad_Shields

; ---------------------------------------------------------------------------
Ani_InstaShield:
		include "General/Sprites/Shields/Anim - Insta-Shield.asm"
Ani_FireShield:
		include "General/Sprites/Shields/Anim - Fire Shield.asm"
Ani_LightningShield:
		include "General/Sprites/Shields/Anim - Lightning Shield S3.asm"
Ani_BubbleShield:
		include "General/Sprites/Shields/Anim - Bubble Shield.asm"
Map_FireShield:
		include "General/Sprites/Shields/Map - Fire Shield.asm"
DPLC_FireShield:
		include "General/Sprites/Shields/DPLC - Fire Shield.asm"
Map_LightningShield:
		include "General/Sprites/Shields/Map - Lightning Shield.asm"
DPLC_LightningShield:
		include "General/Sprites/Shields/DPLC - Lightning Shield.asm"
Map_BubbleShield:
		include "General/Sprites/Shields/Map - Bubble Shield.asm"
DPLC_BubbleShield:
		include "General/Sprites/Shields/DPLC - Bubble Shield.asm"
Map_InstaShield:
		include "General/Sprites/Shields/Map - Insta-Shield.asm"
DPLC_InstaShield:
		include "General/Sprites/Shields/DPLC - Insta-Shield.asm"
