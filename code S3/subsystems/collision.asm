; =============== S U B R O U T I N E =======================================


Player_AnglePos:
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	+ ;loc_FFB8
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

+ ;loc_FFB8:
		move.b	top_solid_bit(a0),d5
		btst	#Status_OnObj,status(a0)
		beq.s	+ ;loc_FFD0
		moveq	#0,d0
		move.b	d0,(Primary_Angle).w
		move.b	d0,(Secondary_Angle).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_FFD0:
		moveq	#3,d0
		move.b	d0,(Primary_Angle).w
		move.b	d0,(Secondary_Angle).w
		move.b	angle(a0),d0
		addi.b	#$20,d0
		bpl.s	++ ;loc_FFF2
		move.b	angle(a0),d0
		bpl.s	+ ;loc_FFEC
		subq.b	#1,d0

+ ;loc_FFEC:
		addi.b	#$20,d0
		bra.s	+++ ;loc_FFFE
; ---------------------------------------------------------------------------

+ ;loc_FFF2:
		move.b	angle(a0),d0
		bpl.s	+ ;loc_FFFA
		addq.b	#1,d0

+ ;loc_FFFA:
		addi.b	#$1F,d0

+ ;loc_FFFE:
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	Player_WalkVertL
		cmpi.b	#$80,d0
		beq.w	Player_WalkCeiling
		cmpi.b	#$C0,d0
		beq.w	Player_WalkVertR
		move.w	y_pos(a0),d2
		move.w	x_pos(a0),d3
		moveq	#0,d0
		move.b	y_radius(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	x_radius(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(Primary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		bsr.w	FindFloor
		move.w	d1,-(sp)
		move.w	y_pos(a0),d2
		move.w	x_pos(a0),d3
		moveq	#0,d0
		move.b	y_radius(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	x_radius(a0),d0
		ext.w	d0
		neg.w	d0
		add.w	d0,d3
		lea	(Secondary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		bsr.w	FindFloor
		move.w	(sp)+,d0
		bsr.w	Player_Angle
		tst.w	d1
		beq.s	locret_10088
		bpl.s	+ ;loc_1008A
		cmpi.w	#-$E,d1
		blt.s	locret_10088
		add.w	d1,y_pos(a0)

locret_10088:
		rts
; ---------------------------------------------------------------------------

+ ;loc_1008A:
		tst.b	stick_to_convex(a0)
		bne.s	+++ ;loc_100A8
		move.b	x_vel(a0),d0
		bpl.s	+ ;loc_10098
		neg.b	d0

+ ;loc_10098:
		addq.b	#4,d0
		cmpi.b	#$E,d0
		blo.s	+ ;loc_100A4
		move.b	#$E,d0

+ ;loc_100A4:
		cmp.b	d0,d1
		bgt.s	++ ;loc_100AE

+ ;loc_100A8:
		add.w	d1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_100AE:
		bset	#Status_InAir,status(a0)
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)
		rts
; End of function Player_AnglePos


; =============== S U B R O U T I N E =======================================


Player_Angle:
		move.w	d0,d3
		move.b	(Secondary_Angle).w,d2
		cmp.w	d0,d1
		ble.s	+ ;loc_100D4
		move.b	(Primary_Angle).w,d2
		move.w	d1,d3
		move.w	d0,d1

+ ;loc_100D4:
		btst	#0,d2
		bne.s	++ ;loc_100F0
		move.b	d2,d0
		sub.b	angle(a0),d0
		bpl.s	+ ;loc_100E4
		neg.b	d0

+ ;loc_100E4:
		cmpi.b	#$20,d0
		bhs.s	+ ;loc_100F0
		move.b	d2,angle(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_100F0:
		move.b	angle(a0),d2
		addi.b	#$20,d2
		andi.b	#$C0,d2
		move.b	d2,angle(a0)
		rts
; End of function Player_Angle

; ---------------------------------------------------------------------------

Player_WalkVertR:
		move.w	y_pos(a0),d2
		move.w	x_pos(a0),d3
		moveq	#0,d0
		move.b	x_radius(a0),d0
		ext.w	d0
		neg.w	d0
		add.w	d0,d2
		move.b	y_radius(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(Primary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		bsr.w	FindWall
		move.w	d1,-(sp)
		move.w	y_pos(a0),d2
		move.w	x_pos(a0),d3
		moveq	#0,d0
		move.b	x_radius(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	y_radius(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(Secondary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		bsr.w	FindWall
		move.w	(sp)+,d0
		bsr.w	Player_Angle
		tst.w	d1
		beq.s	locret_10176
		bpl.s	+++ ;loc_10198
		cmpi.w	#-$E,d1
		blt.s	++ ;loc_10184
		tst.b	$41(a0)
		bne.s	+ ;loc_10178
		add.w	d1,x_pos(a0)

locret_10176:
		rts
; ---------------------------------------------------------------------------

+ ;loc_10178:
		subq.b	#1,$41(a0)
		move.b	#$C0,angle(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_10184:
		tst.w	(Current_zone_and_act).w
		bne.s	locret_10176
		move.b	#$C0,angle(a0)
		move.b	#3,$41(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_10198:
		tst.b	stick_to_convex(a0)
		bne.s	+++ ;loc_101B6
		move.b	y_vel(a0),d0
		bpl.s	+ ;loc_101A6
		neg.b	d0

+ ;loc_101A6:
		addq.b	#4,d0
		cmpi.b	#$E,d0
		blo.s	+ ;loc_101B2
		move.b	#$E,d0

+ ;loc_101B2:
		cmp.b	d0,d1
		bgt.s	++ ;loc_101BC

+ ;loc_101B6:
		add.w	d1,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_101BC:
		bset	#Status_InAir,status(a0)
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)
		rts
; ---------------------------------------------------------------------------

Player_WalkCeiling:
		move.w	y_pos(a0),d2
		move.w	x_pos(a0),d3
		moveq	#0,d0
		move.b	y_radius(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		move.b	x_radius(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(Primary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		bsr.w	FindFloor
		move.w	d1,-(sp)
		move.w	y_pos(a0),d2
		move.w	x_pos(a0),d3
		moveq	#0,d0
		move.b	y_radius(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		move.b	x_radius(a0),d0
		ext.w	d0
		sub.w	d0,d3
		lea	(Secondary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		bsr.w	FindFloor
		move.w	(sp)+,d0
		bsr.w	Player_Angle
		tst.w	d1
		beq.s	locret_10244
		bpl.s	+ ;loc_10246
		cmpi.w	#-$E,d1
		blt.s	locret_10244
		sub.w	d1,y_pos(a0)

locret_10244:
		rts
; ---------------------------------------------------------------------------

+ ;loc_10246:
		tst.b	stick_to_convex(a0)
		bne.s	+++ ;loc_10264
		move.b	x_vel(a0),d0
		bpl.s	+ ;loc_10254
		neg.b	d0

+ ;loc_10254:
		addq.b	#4,d0
		cmpi.b	#$E,d0
		blo.s	+ ;loc_10260
		move.b	#$E,d0

+ ;loc_10260:
		cmp.b	d0,d1
		bgt.s	++ ;loc_1026A

+ ;loc_10264:
		sub.w	d1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_1026A:
		bset	#Status_InAir,status(a0)
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)
		rts
; ---------------------------------------------------------------------------

Player_WalkVertL:
		move.w	y_pos(a0),d2
		move.w	x_pos(a0),d3
		moveq	#0,d0
		move.b	x_radius(a0),d0
		ext.w	d0
		sub.w	d0,d2
		move.b	y_radius(a0),d0
		ext.w	d0
		sub.w	d0,d3
		eori.w	#$F,d3
		lea	(Primary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6
		bsr.w	FindWall
		move.w	d1,-(sp)
		move.w	y_pos(a0),d2
		move.w	x_pos(a0),d3
		moveq	#0,d0
		move.b	x_radius(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	y_radius(a0),d0
		ext.w	d0
		sub.w	d0,d3
		eori.w	#$F,d3
		lea	(Secondary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6
		bsr.w	FindWall
		move.w	(sp)+,d0
		bsr.w	Player_Angle
		tst.w	d1
		beq.s	locret_102F2
		bpl.s	+ ;loc_102F4
		cmpi.w	#-$E,d1
		blt.s	locret_102F2
		sub.w	d1,x_pos(a0)

locret_102F2:
		rts
; ---------------------------------------------------------------------------

+ ;loc_102F4:
		tst.b	stick_to_convex(a0)
		bne.s	+++ ;loc_10312
		move.b	y_vel(a0),d0
		bpl.s	+ ;loc_10302
		neg.b	d0

+ ;loc_10302:
		addq.b	#4,d0
		cmpi.b	#$E,d0
		blo.s	+ ;loc_1030E
		move.b	#$E,d0

+ ;loc_1030E:
		cmp.b	d0,d1
		bgt.s	++ ;loc_10318

+ ;loc_10312:
		sub.w	d1,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_10318:
		bset	#Status_InAir,status(a0)
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)
		rts
; ---------------------------------------------------------------------------
;GetFloorPosition_BG
Find_Tile_BG:
		lea	(Level_layout_header).w,a1
		move.w	d2,d0
		lsr.w	#5,d0
		and.w	(Layout_row_index_mask).w,d0
		move.w	$A(a1,d0.w),d0
		move.w	d3,d1
		lsr.w	#3,d1
		move.w	d1,d4
		lsr.w	#4,d1
		add.w	d1,d0
		moveq	#-1,d1
		clr.w	d1
		movea.w	d0,a1
		move.b	(a1),d1
		add.w	d1,d1
		move.w	ChunkAddrArray(pc,d1.w),d1
		move.w	d2,d0
		andi.w	#$70,d0
		add.w	d0,d1
		andi.w	#$E,d4
		add.w	d4,d1
		movea.l	d1,a1
		rts
; ---------------------------------------------------------------------------
;GetFloorPosition_FG
Find_Tile_FG:
		lea	(Level_layout_header).w,a1
		move.w	d2,d0
		lsr.w	#5,d0
		and.w	(Layout_row_index_mask).w,d0
		move.w	8(a1,d0.w),d0
		move.w	d3,d1
		lsr.w	#3,d1
		move.w	d1,d4
		lsr.w	#4,d1
		add.w	d1,d0
		moveq	#-1,d1
		clr.w	d1
		movea.w	d0,a1
		move.b	(a1),d1
		add.w	d1,d1
		move.w	ChunkAddrArray(pc,d1.w),d1
		move.w	d2,d0
		andi.w	#$70,d0
		add.w	d0,d1
		andi.w	#$E,d4
		add.w	d4,d1
		movea.l	d1,a1
		rts
; ---------------------------------------------------------------------------
ChunkAddrArray:
		dc.w     0,  $80, $100, $180, $200, $280, $300, $380, $400, $480, $500, $580, $600, $680, $700, $780
		dc.w  $800, $880, $900, $980, $A00, $A80, $B00, $B80, $C00, $C80, $D00, $D80, $E00, $E80, $F00, $F80
		dc.w $1000,$1080,$1100,$1180,$1200,$1280,$1300,$1380,$1400,$1480,$1500,$1580,$1600,$1680,$1700,$1780
		dc.w $1800,$1880,$1900,$1980,$1A00,$1A80,$1B00,$1B80,$1C00,$1C80,$1D00,$1D80,$1E00,$1E80,$1F00,$1F80
		dc.w $2000,$2080,$2100,$2180,$2200,$2280,$2300,$2380,$2400,$2480,$2500,$2580,$2600,$2680,$2700,$2780
		dc.w $2800,$2880,$2900,$2980,$2A00,$2A80,$2B00,$2B80,$2C00,$2C80,$2D00,$2D80,$2E00,$2E80,$2F00,$2F80
		dc.w $3000,$3080,$3100,$3180,$3200,$3280,$3300,$3380,$3400,$3480,$3500,$3580,$3600,$3680,$3700,$3780
		dc.w $3800,$3880,$3900,$3980,$3A00,$3A80,$3B00,$3B80,$3C00,$3C80,$3D00,$3D80,$3E00,$3E80,$3F00,$3F80
		dc.w $4000,$4080,$4100,$4180,$4200,$4280,$4300,$4380,$4400,$4480,$4500,$4580,$4600,$4680,$4700,$4780
		dc.w $4800,$4880,$4900,$4980,$4A00,$4A80,$4B00,$4B80,$4C00,$4C80,$4D00,$4D80,$4E00,$4E80,$4F00,$4F80
		dc.w $5000,$5080,$5100,$5180,$5200,$5280,$5300,$5380,$5400,$5480,$5500,$5580,$5600,$5680,$5700,$5780
		dc.w $5800,$5880,$5900,$5980,$5A00,$5A80,$5B00,$5B80,$5C00,$5C80,$5D00,$5D80,$5E00,$5E80,$5F00,$5F80
		dc.w $6000,$6080,$6100,$6180,$6200,$6280,$6300,$6380,$6400,$6480,$6500,$6580,$6600,$6680,$6700,$6780
		dc.w $6800,$6880,$6900,$6980,$6A00,$6A80,$6B00,$6B80,$6C00,$6C80,$6D00,$6D80,$6E00,$6E80,$6F00,$6F80
		dc.w $7000,$7080,$7100,$7180,$7200,$7280,$7300,$7380,$7400,$7480,$7500,$7580,$7600,$7680,$7700,$7780
		dc.w $7800,$7880,$7900,$7980,$7A00,$7A80,$7B00,$7B80,$7C00,$7C80,$7D00,$7D80,$7E00,$7E80,$7F00,$7F80

; =============== S U B R O U T I N E =======================================


FindFloor:
		lea	(Find_Tile_FG).l,a5
		tst.b	(Background_collision_flag).w
		beq.s	sub_105DA
		bsr.s	sub_105DA
		move.b	(a4),Primary_Angle_save-Primary_Angle(a4)
		move.w	d1,-(sp)
		sub.w	(Camera_X_diff).w,d3
		sub.w	(Camera_Y_diff).w,d2
		lea	(Find_Tile_BG).l,a5
		bsr.s	sub_105DA
		add.w	(Camera_X_diff).w,d3
		add.w	(Camera_Y_diff).w,d2
		move.w	(sp)+,d0
		cmp.w	d0,d1
		ble.s	locret_105D8
		move.b	Primary_Angle_save-Primary_Angle(a4),(a4)
		move.w	d0,d1

locret_105D8:
		rts
; End of function FindFloor


; =============== S U B R O U T I N E =======================================


sub_105DA:
		jsr	(a5)
		move.w	(a1),d0
		move.w	d0,d4
		andi.w	#$3FF,d0
		beq.s	loc_105EA
		btst	d5,d4
		bne.s	+ ;loc_105F8

loc_105EA:
		add.w	a3,d2
		bsr.w	sub_1067E
		sub.w	a3,d2
		addi.w	#$10,d1
		rts
; ---------------------------------------------------------------------------

+ ;loc_105F8:
		movea.l	(Collision_addr).w,a2
		add.w	d0,d0
		move.w	(a2,d0.w),d0
		beq.s	loc_105EA
		lea	(AngleArray).l,a2
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d3,d1
		btst	#$A,d4
		beq.s	+ ;loc_1061C
		not.w	d1
		neg.b	(a4)

+ ;loc_1061C:
		btst	#$B,d4
		beq.s	+ ;loc_1062C
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

+ ;loc_1062C:
		andi.w	#$F,d1
		add.w	d0,d1
		lea	(HeightMaps).l,a2
		move.b	(a2,d1.w),d0
		ext.w	d0
		eor.w	d6,d4
		btst	#$B,d4
		beq.s	+ ;loc_10648
		neg.w	d0

+ ;loc_10648:
		tst.w	d0
		beq.s	loc_105EA
		bmi.s	+ ;loc_10664
		cmpi.b	#$10,d0
		beq.s	++ ;loc_10670
		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts
; ---------------------------------------------------------------------------

+ ;loc_10664:
		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	loc_105EA

+ ;loc_10670:
		sub.w	a3,d2
		bsr.w	sub_1067E
		add.w	a3,d2
		subi.w	#$10,d1
		rts
; End of function sub_105DA


; =============== S U B R O U T I N E =======================================


sub_1067E:
		jsr	(a5)
		move.w	(a1),d0
		move.w	d0,d4
		andi.w	#$3FF,d0
		beq.s	loc_1068E
		btst	d5,d4
		bne.s	+ ;loc_1069C

loc_1068E:
		move.w	#$F,d1
		move.w	d2,d0
		andi.w	#$F,d0
		sub.w	d0,d1
		rts
; ---------------------------------------------------------------------------

+ ;loc_1069C:
		movea.l	(Collision_addr).w,a2
		add.w	d0,d0
		move.w	(a2,d0.w),d0
		beq.s	loc_1068E
		lea	(AngleArray).l,a2
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d3,d1
		btst	#$A,d4
		beq.s	+ ;loc_106C0
		not.w	d1
		neg.b	(a4)

+ ;loc_106C0:
		btst	#$B,d4
		beq.s	+ ;loc_106D0
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

+ ;loc_106D0:
		andi.w	#$F,d1
		add.w	d0,d1
		lea	(HeightMaps).l,a2
		move.b	(a2,d1.w),d0
		ext.w	d0
		eor.w	d6,d4
		btst	#$B,d4
		beq.s	+ ;loc_106EC
		neg.w	d0

+ ;loc_106EC:
		tst.w	d0
		beq.s	loc_1068E
		bmi.s	+ ;loc_10702
		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts
; ---------------------------------------------------------------------------

+ ;loc_10702:
		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	loc_1068E
		not.w	d1
		rts
; End of function sub_1067E

; ---------------------------------------------------------------------------
;loc_10712
Ring_FindFloor:
		lea	(Find_Tile_FG).l,a5
		tst.b	(Background_collision_flag).w
		beq.s	sub_1074C
		bsr.s	sub_1074C
		move.b	(a4),Primary_Angle_save-Primary_Angle(a4)
		move.w	d1,-(sp)
		sub.w	(Camera_X_diff).w,d3
		sub.w	(Camera_Y_diff).w,d2
		lea	(Find_Tile_BG).l,a5
		bsr.s	sub_1074C
		add.w	(Camera_X_diff).w,d3
		add.w	(Camera_Y_diff).w,d2
		move.w	(sp)+,d0
		cmp.w	d0,d1
		ble.s	locret_1074A
		move.b	Primary_Angle_save-Primary_Angle(a4),(a4)
		move.w	d0,d1

locret_1074A:
		rts

; =============== S U B R O U T I N E =======================================


sub_1074C:
		jsr	(a5)
		move.w	(a1),d0
		move.w	d0,d4
		andi.w	#$3FF,d0
		beq.s	loc_1075C
		btst	d5,d4
		bne.s	+ ;loc_10762

loc_1075C:
		move.w	#$10,d1
		rts
; ---------------------------------------------------------------------------

+ ;loc_10762:
		movea.l	(Collision_addr).w,a2
		add.w	d0,d0
		move.w	(a2,d0.w),d0
		beq.s	loc_1075C
		lea	(AngleArray).l,a2
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d3,d1
		btst	#$A,d4
		beq.s	+ ;loc_10786
		not.w	d1
		neg.b	(a4)

+ ;loc_10786:
		btst	#$B,d4
		beq.s	+ ;loc_10796
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

+ ;loc_10796:
		andi.w	#$F,d1
		add.w	d0,d1
		lea	(HeightMaps).l,a2
		move.b	(a2,d1.w),d0
		ext.w	d0
		eor.w	d6,d4
		btst	#$B,d4
		beq.s	+ ;loc_107B2
		neg.w	d0

+ ;loc_107B2:
		tst.w	d0
		beq.s	loc_1075C
		bmi.s	+ ;loc_107CE
		cmpi.b	#$10,d0
		beq.s	++ ;loc_107DA
		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts
; ---------------------------------------------------------------------------

+ ;loc_107CE:
		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	loc_1075C

+ ;loc_107DA:
		sub.w	a3,d2
		bsr.w	sub_1067E
		add.w	a3,d2
		subi.w	#$10,d1
		rts
; End of function sub_1074C


; =============== S U B R O U T I N E =======================================


FindWall:
		lea	(Find_Tile_FG).l,a5
		tst.b	(Background_collision_flag).w
		beq.s	sub_10846
		bsr.s	sub_10846
		move.b	(a4),Primary_Angle_save-Primary_Angle(a4)
		move.w	d1,-(sp)
		move.w	a3,d0
		bpl.s	+ ;loc_1080E
		eori.w	#$F,d3
		sub.w	(Camera_X_diff).w,d3
		eori.w	#$F,d3
		bra.s	++ ;loc_10812
; ---------------------------------------------------------------------------

+ ;loc_1080E:
		sub.w	(Camera_X_diff).w,d3

+ ;loc_10812:
		sub.w	(Camera_Y_diff).w,d2
		lea	(Find_Tile_BG).l,a5
		bsr.s	sub_10846
		move.w	a3,d0
		bpl.s	+ ;loc_10830
		eori.w	#$F,d3
		add.w	(Camera_X_diff).w,d3
		eori.w	#$F,d3
		bra.s	++ ;loc_10834
; ---------------------------------------------------------------------------

+ ;loc_10830:
		add.w	(Camera_X_diff).w,d3

+ ;loc_10834:
		add.w	(Camera_Y_diff).w,d2
		move.w	(sp)+,d0
		cmp.w	d0,d1
		ble.s	locret_10844
		move.b	Primary_Angle_save-Primary_Angle(a4),(a4)
		move.w	d0,d1

locret_10844:
		rts
; End of function FindWall


; =============== S U B R O U T I N E =======================================


sub_10846:
		jsr	(a5)
		move.w	(a1),d0
		move.w	d0,d4
		andi.w	#$3FF,d0
		beq.s	loc_10856
		btst	d5,d4
		bne.s	+ ;loc_10864

loc_10856:
		add.w	a3,d3
		bsr.w	sub_108EA
		sub.w	a3,d3
		addi.w	#$10,d1
		rts
; ---------------------------------------------------------------------------

+ ;loc_10864:
		movea.l	(Collision_addr).w,a2
		add.w	d0,d0
		move.w	(a2,d0.w),d0
		beq.s	loc_10856
		lea	(AngleArray).l,a2
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d2,d1
		btst	#$B,d4
		beq.s	+ ;loc_10890
		not.w	d1
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

+ ;loc_10890:
		btst	#$A,d4
		beq.s	+ ;loc_10898
		neg.b	(a4)

+ ;loc_10898:
		andi.w	#$F,d1
		add.w	d0,d1
		lea	(HeightMapsRot).l,a2
		move.b	(a2,d1.w),d0
		ext.w	d0
		eor.w	d6,d4
		btst	#$A,d4
		beq.s	+ ;loc_108B4
		neg.w	d0

+ ;loc_108B4:
		tst.w	d0
		beq.s	loc_10856
		bmi.s	+ ;loc_108D0
		cmpi.b	#$10,d0
		beq.s	++ ;loc_108DC
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts
; ---------------------------------------------------------------------------

+ ;loc_108D0:
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	loc_10856

+ ;loc_108DC:
		sub.w	a3,d3
		bsr.w	sub_108EA
		add.w	a3,d3
		subi.w	#$10,d1
		rts
; End of function sub_10846


; =============== S U B R O U T I N E =======================================


sub_108EA:
		jsr	(a5)
		move.w	(a1),d0
		move.w	d0,d4
		andi.w	#$3FF,d0
		beq.s	loc_108FA
		btst	d5,d4
		bne.s	+ ;loc_10908

loc_108FA:
		move.w	#$F,d1
		move.w	d3,d0
		andi.w	#$F,d0
		sub.w	d0,d1
		rts
; ---------------------------------------------------------------------------

+ ;loc_10908:
		movea.l	(Collision_addr).w,a2
		add.w	d0,d0
		move.w	(a2,d0.w),d0
		beq.s	loc_108FA
		lea	(AngleArray).l,a2
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d2,d1
		btst	#$B,d4
		beq.s	+ ;loc_10934
		not.w	d1
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

+ ;loc_10934:
		btst	#$A,d4
		beq.s	+ ;loc_1093C
		neg.b	(a4)

+ ;loc_1093C:
		andi.w	#$F,d1
		add.w	d0,d1
		lea	(HeightMapsRot).l,a2
		move.b	(a2,d1.w),d0
		ext.w	d0
		eor.w	d6,d4
		btst	#$A,d4
		beq.s	+ ;loc_10958
		neg.w	d0

+ ;loc_10958:
		tst.w	d0
		beq.s	loc_108FA
		bmi.s	+ ;loc_1096E
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts
; ---------------------------------------------------------------------------

+ ;loc_1096E:
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	loc_108FA
		not.w	d1
		rts
; End of function sub_108EA


; =============== S U B R O U T I N E =======================================


ConvertCollisionArray:
		rts
; End of function ConvertCollisionArray


; =============== S U B R O U T I N E =======================================


sub_10980:
		tst.w	(Competition_mode).w
		bne.w	sub_10A10
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	+ ;loc_1099C
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

+ ;loc_1099C:
		move.b	lrb_solid_bit(a0),d5
		move.l	x_pos(a0),d3
		move.l	y_pos(a0),d2
		move.w	x_vel(a0),d1
		ext.l	d1
		asl.l	#8,d1
		add.l	d1,d3
		move.w	y_vel(a0),d1
		ext.l	d1
		asl.l	#8,d1
		add.l	d1,d2
		swap	d2
		swap	d3
		move.b	d0,(Primary_Angle).w
		move.b	d0,(Secondary_Angle).w
		move.b	d0,d1
		addi.b	#$20,d0
		bpl.s	++ ;loc_109DC
		move.b	d1,d0
		bpl.s	+ ;loc_109D6
		subq.b	#1,d0

+ ;loc_109D6:
		addi.b	#$20,d0
		bra.s	+++ ;loc_109E6
; ---------------------------------------------------------------------------

+ ;loc_109DC:
		move.b	d1,d0
		bpl.s	+ ;loc_109E2
		addq.b	#1,d0

+ ;loc_109E2:
		addi.b	#$1F,d0

+ ;loc_109E6:
		andi.b	#$C0,d0
		beq.w	CheckFloorDist_Part2
		cmpi.b	#$80,d0
		beq.w	CheckCeilingDist_Part2
		tst.w	(Competition_mode).w
		bne.s	+ ;loc_10A04
		andi.b	#$38,d1
		bne.s	+ ;loc_10A04
		addq.w	#8,d2

+ ;loc_10A04:
		cmpi.b	#$40,d0
		beq.w	loc_11084
		bra.w	loc_10DE4
; End of function sub_10980


; =============== S U B R O U T I N E =======================================


sub_10A10:
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	+ ;loc_10A24
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

+ ;loc_10A24:
		move.b	lrb_solid_bit(a0),d5
		move.l	x_pos(a0),d3
		move.l	y_pos(a0),d2
		move.w	x_vel(a0),d1
		ext.l	d1
		asl.l	#8,d1
		add.l	d1,d3
		move.w	y_vel(a0),d1
		ext.l	d1
		asl.l	#8,d1
		add.l	d1,d2
		swap	d2
		swap	d3
		move.b	d0,(Primary_Angle).w
		move.b	d0,(Secondary_Angle).w
		move.b	d0,d1
		addi.b	#$20,d0
		bpl.s	++ ;loc_10A64
		move.b	d1,d0
		bpl.s	+ ;loc_10A5E
		subq.b	#1,d0

+ ;loc_10A5E:
		addi.b	#$20,d0
		bra.s	+++ ;loc_10A6E
; ---------------------------------------------------------------------------

+ ;loc_10A64:
		move.b	d1,d0
		bpl.s	+ ;loc_10A6A
		addq.b	#1,d0

+ ;loc_10A6A:
		addi.b	#$1F,d0

+ ;loc_10A6E:
		andi.b	#$C0,d0
		beq.w	sub_10B84
		cmpi.b	#$80,d0
		beq.w	CheckCeilingDist_WithRadius
		cmpi.b	#$40,d0
		beq.w	loc_110A4
		bra.w	loc_10E00
; End of function sub_10A10
