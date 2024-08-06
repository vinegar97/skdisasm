Obj_ICZPathFollowPlatform:
		jsr	(Obj_WaitOffscreen).l

Obj_ICZPathFollowPlatform_2:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		move.w	x_pos(a0),-(sp)
		jsr	.Index(pc,d1.w)
		moveq	#$2B,d1
		moveq	#$14,d2
		moveq	#$14,d3
		move.w	(sp)+,d4
		btst	#7,status(a0)
		bne.s	loc_89F64
		jsr	(SolidObjectFull).l
		bsr.w	sub_8A3C4

 loc_89F64:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_89F7E-.Index
		dc.w loc_89FB6-.Index
		dc.w loc_89FD6-.Index
		dc.w loc_89FF2-.Index
		dc.w loc_8A036-.Index
		dc.w loc_8A11C-.Index
		dc.w locret_8A176-.Index
		dc.w loc_8A178-.Index
		dc.w loc_8A192-.Index
		dc.w loc_8A1AE-.Index
; ---------------------------------------------------------------------------

loc_89F7E:
		lea	ObjDat_ICZPathFollowPlatform(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.w	a0,(_unkFAA4).w
		move.b	#$20,x_radius(a0)
		move.b	#$12,y_radius(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		move.b	byte_89FB2(pc,d0.w),routine(a0)
		tst.w	d0
		bne.w	locret_8A034
		lea	ChildObjDat_8A436(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------
byte_89FB2:
		dc.b    2,   6,  $C,  $E
		even
; ---------------------------------------------------------------------------

loc_89FB6:
		btst	#p1_standing_bit,status(a0)
		bne.s	loc_89FC0
		rts
; ---------------------------------------------------------------------------

loc_89FC0:
		move.b	#4,routine(a0)
		move.w	#$F,$2E(a0)
		move.l	#loc_89FEA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_89FD6:
		moveq	#1,d0
		btst	#0,(V_int_run_count+3).w
		beq.s	loc_89FE2
		neg.w	d0

loc_89FE2:
		add.w	d0,x_pos(a0)
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_89FEA:
		move.b	#$A,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_89FF2:
		btst	#p1_pushing_bit,status(a0)
		beq.s	loc_8A004
		move.b	(Ctrl_1_held).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	loc_8A00A

loc_8A004:
		clr.b	$39(a0)
		rts
; ---------------------------------------------------------------------------

loc_8A00A:
		addq.b	#1,$39(a0)
		cmpi.b	#$10,$39(a0)
		blo.w	locret_8A034
		move.b	#8,routine(a0)
		lea	(Player_1).w,a1
		jsr	Find_SonicTails(pc)
		move.w	#$80,d1
		tst.w	d0
		beq.s	loc_8A030
		neg.w	d1

loc_8A030:
		move.w	d1,x_vel(a0)

locret_8A034:
		rts
; ---------------------------------------------------------------------------

loc_8A036:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	loc_8A046
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

loc_8A046:
		jsr	(MoveSprite2).l
		jsr	(ObjCheckFloorDist).l
		cmpi.w	#8,d1
		bge.s	loc_8A09E
		move.b	d3,angle(a0)
		add.w	d1,y_pos(a0)
		move.b	d3,d0
		bpl.s	loc_8A066
		neg.b	d0

loc_8A066:
		andi.b	#$F8,d0
		beq.s	loc_8A07C
		move.w	x_vel(a0),d0
		add.w	d3,d3
		ext.w	d3
		asr.w	#1,d3
		add.w	d3,d0
		bsr.w	sub_8A35A

loc_8A07C:
		tst.w	x_vel(a0)
		bmi.s	loc_8A090
		moveq	#$1C,d3
		jsr	(ObjCheckRightWallDist).l
		tst.w	d1
		bmi.s	loc_8A0AA
		rts
; ---------------------------------------------------------------------------

loc_8A090:
		moveq	#-$1C,d3
		jsr	(ObjCheckLeftWallDist).l
		tst.w	d1
		bmi.s	loc_8A0F4
		rts
; ---------------------------------------------------------------------------

loc_8A09E:
		move.b	#$A,routine(a0)
		bsr.w	sub_8A386
		rts
; ---------------------------------------------------------------------------

loc_8A0AA:
		move.b	#$C,routine(a0)
		clr.b	(Fast_V_scroll_flag).w
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		tst.b	subtype(a0)
		beq.w	locret_8A034
		lea	ChildObjDat_8A42A(pc),a2
		jsr	CreateChild6_Simple(pc)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_8A0EC
		move.l	#Obj_Spring,(a1)
		move.w	#$5D5A,x_pos(a1)
		move.w	#$27A,y_pos(a1)
		move.b	#0,subtype(a1)

loc_8A0EC:
		jsr	Displace_PlayerOffObject(pc)
		jmp	loc_85088(pc)
; ---------------------------------------------------------------------------

loc_8A0F4:
		move.b	#$C,routine(a0)
		rts
; ---------------------------------------------------------------------------
		dc.w      0,     8,   $10,   $18,   $20,   $28,   $30,   $38
		dc.w   -$38,  -$30,  -$28,  -$20,  -$18,  -$10,    -8,     0
; ---------------------------------------------------------------------------

loc_8A11C:
		bsr.w	sub_8A36C
		jsr	(MoveSprite2).l
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_8A15E
		tst.w	x_vel(a0)
		beq.s	locret_8A15C
		bmi.s	loc_8A148
		moveq	#$20,d3
		jsr	(ObjCheckRightWallDist).l
		tst.w	d1
		bmi.s	loc_8A154
		bra.w	locret_8A15C
; ---------------------------------------------------------------------------

loc_8A148:
		moveq	#-$20,d3
		jsr	(ObjCheckLeftWallDist).l
		tst.w	d1
		bpl.s	locret_8A15C

loc_8A154:
		add.w	d1,x_pos(a0)
		clr.w	x_vel(a0)

locret_8A15C:
		rts
; ---------------------------------------------------------------------------

loc_8A15E:
		move.b	#8,routine(a0)
		move.w	y_vel(a0),d0
		btst	#6,d3
		beq.s	loc_8A170
		neg.w	d0

loc_8A170:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

locret_8A176:
		rts
; ---------------------------------------------------------------------------

loc_8A178:
		move.b	status(a0),d0
		andi.b	#standing_mask,d0
		bne.s	loc_8A184
		rts
; ---------------------------------------------------------------------------

loc_8A184:
		move.b	#$10,routine(a0)
		move.w	y_pos(a0),$3A(a0)
		rts
; ---------------------------------------------------------------------------

loc_8A192:
		move.b	status(a0),d0
		andi.b	#standing_mask,d0
		beq.s	loc_8A1A2
		addq.w	#1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_8A1A2:
		move.b	#$12,routine(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_8A1AE:
		addi.w	#-$20,y_vel(a0)
		jsr	(MoveSprite2).l
		move.w	y_pos(a0),d0
		cmp.w	$3A(a0),d0
		bls.s	loc_8A1C6
		rts
; ---------------------------------------------------------------------------

loc_8A1C6:
		move.b	#$E,routine(a0)
		move.w	$3A(a0),y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_8A1D4:
		lea	ObjDat3_8A412(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#AnimateRaw_MoveChkDel,(a0)
		move.l	#byte_8A43E,$30(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	byte_8A200(pc,d0.w),child_dx(a0)	; and child_dy
		jsr	Refresh_ChildPosition(pc)
		moveq	#8,d0
		jmp	Set_IndexedVelocity(pc)
; ---------------------------------------------------------------------------
byte_8A200:
		dc.b -$14,  -9
		dc.b  $14, -$C
		dc.b  $14,   0
		dc.b   $C,  $C
		dc.b   -8,   9
		dc.b   -4,  -6
		even
; ---------------------------------------------------------------------------

loc_8A20C:
		lea	ObjDat3_8A41E(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_8A258,(a0)
		move.l	#byte_8A444,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		move.w	#$5F,$2E(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	byte_8A246(pc,d0.w),child_dx(a0)	; and child_dy
		jsr	Refresh_ChildPosition(pc)
		moveq	#0,d0
		jmp	Set_IndexedVelocity(pc)
; ---------------------------------------------------------------------------
byte_8A246:
		dc.b -$14,-$30
		dc.b    8,-$34
		dc.b  -$C,-$14
		dc.b  $10,-$20
		dc.b   $A,  -4
		dc.b -$14,  $C
		dc.b    8, $18
		dc.b -$10, $28
		dc.b   $C, $34
		even
; ---------------------------------------------------------------------------

loc_8A258:
		jsr	Animate_Raw(pc)
		jsr	(MoveSprite).l
		jsr	Obj_Wait(pc)
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_ICZBreakableWall:
		lea	ObjDat_ICZBreakableWall(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_8A280,(a0)
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_8A280:
		moveq	#$2B,d1
		moveq	#$40,d2
		moveq	#$70,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	loc_8A2A0
		swap	d6
		andi.w	#1,d6
		bne.s	loc_8A2E2

loc_8A2A0:
		movea.w	(_unkFAA4).w,a1
		cmpi.l	#Obj_ICZPathFollowPlatform_2,(a1)
		bne.s	loc_8A2DC
		move.w	x_pos(a1),d0
		move.w	y_pos(a1),d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		lea	word_8A2FC(pc),a2
		add.w	(a2)+,d2
		cmp.w	d2,d0
		blo.s	loc_8A2DC
		add.w	(a2)+,d2
		cmp.w	d2,d0
		bhs.s	loc_8A2DC
		add.w	(a2)+,d3
		cmp.w	d3,d1
		blo.s	loc_8A2DC
		add.w	(a2)+,d3
		cmp.w	d3,d1
		blo.s	loc_8A2E2

loc_8A2DC:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_8A2E2:
		lea	ChildObjDat_8A430(pc),a2
		jsr	CreateChild6_Simple(pc)
		jsr	Go_Delete_Sprite(pc)
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
word_8A2FC:
		dc.w   -$30,   $60,  -$40,   $80
; ---------------------------------------------------------------------------

loc_8A304:
		lea	ObjDat3_8A3FA(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_8A318,(a0)
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_8A318:
		movea.w	parent3(a0),a1
		btst	#p1_standing_bit,status(a1)
		beq.s	loc_8A32A
		move.l	#MoveChkDel,(a0)

loc_8A32A:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_ICZIceBlock:
		jsr	(Obj_WaitOffscreen).l
		lea	ObjDat_ICZIceBlock(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_8A344,(a0)

loc_8A344:
		moveq	#$1B,d1
		moveq	#$10,d2
		moveq	#$11,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_8A35A:
		cmpi.w	#-$C00,d0
		blt.s	locret_8A36A
		cmpi.w	#$C00,d0
		bgt.s	locret_8A36A
		move.w	d0,x_vel(a0)

locret_8A36A:
		rts
; End of function sub_8A35A


; =============== S U B R O U T I N E =======================================


sub_8A36C:
		move.w	y_vel(a0),d0
		addi.w	#$38,d0
		cmpi.w	#-$C00,d0
		blt.s	locret_8A384
		cmpi.w	#$C00,d0
		bgt.s	locret_8A384
		move.w	d0,y_vel(a0)

locret_8A384:
		rts
; End of function sub_8A36C


; =============== S U B R O U T I N E =======================================


sub_8A386:
		move.b	angle(a0),d3
		lsr.b	#3,d3
		andi.w	#$E,d3
		move.w	x_vel(a0),d1
		bpl.s	loc_8A398
		neg.w	d1

loc_8A398:
		move.w	off_8A3A0(pc,d3.w),d0
		jmp	off_8A3A0(pc,d0.w)
; End of function sub_8A386

; ---------------------------------------------------------------------------
off_8A3A0:
		dc.w loc_8A3B0-off_8A3A0
		dc.w loc_8A3B6-off_8A3A0
		dc.w loc_8A3BE-off_8A3A0
		dc.w loc_8A3B6-off_8A3A0
		dc.w loc_8A3B0-off_8A3A0
		dc.w loc_8A3B6-off_8A3A0
		dc.w loc_8A3BE-off_8A3A0
		dc.w loc_8A3B6-off_8A3A0
; ---------------------------------------------------------------------------

loc_8A3B0:
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_8A3B6:
		lsr.w	#1,d1
		move.w	d1,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_8A3BE:
		move.w	d1,y_vel(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_8A3C4:
		clr.b	(Fast_V_scroll_flag).w
		tst.w	x_vel(a0)
		bne.s	loc_8A3D4
		tst.w	y_vel(a0)
		beq.s	locret_8A3E0

loc_8A3D4:
		btst	#p1_standing_bit,status(a0)
		beq.s	locret_8A3E0
		st	(Fast_V_scroll_flag).w

locret_8A3E0:
		rts
; End of function sub_8A3C4

; ---------------------------------------------------------------------------
ObjDat_ICZPathFollowPlatform:
		dc.l Map_ICZPlatforms
		dc.w make_art_tile($3B6,2,0)
		dc.w   $280
		dc.b  $20, $14,   0,   0
ObjDat_ICZIceBlock:
		dc.l Map_ICZPlatforms
		dc.w make_art_tile($377,2,0)
		dc.w   $280
		dc.b  $10, $10, $1E,   0
ObjDat3_8A3FA:
		dc.l Map_ICZWallAndColumn
		dc.w make_art_tile($001,2,0)
		dc.w   $280
		dc.b  $10,  $C,   8,   0
ObjDat_ICZBreakableWall:
		dc.l Map_ICZWallAndColumn
		dc.w make_art_tile($001,2,0)
		dc.w   $280
		dc.b  $20, $40,   6,   0
ObjDat3_8A412:
		dc.l Map_ICZPlatforms
		dc.w make_art_tile($3B6,2,1)
		dc.w    $80
		dc.b    8,   8, $23,   0
ObjDat3_8A41E:
		dc.l Map_ICZPlatforms
		dc.w make_art_tile($347,2,1)
		dc.w    $80
		dc.b   $C,  $C, $1C,   0
ChildObjDat_8A42A:
		dc.w 6-1
		dc.l loc_8A1D4
ChildObjDat_8A430:
		dc.w 9-1
		dc.l loc_8A20C
ChildObjDat_8A436:
		dc.w 1-1
		dc.l loc_8A304
		dc.b -$10, $10
byte_8A43E:
		dc.b    2, $23, $13, $24, $14, $FC
byte_8A444:
		dc.b    2, $1C, $1D, $25, $26, $FC
		even
; ---------------------------------------------------------------------------
