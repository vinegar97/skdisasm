Obj_RobotnikHead:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_RobotnikHeadInit-.Index
		dc.w Obj_RobotnikHeadMain-.Index
		dc.w Obj_RobotnikHeadEnd-.Index
; ---------------------------------------------------------------------------

Obj_RobotnikHeadInit:
		lea	ObjDat_RobotnikHead(pc),a1
		jsr	(SetUp_ObjAttributes).l
		jsr	(Child_SyncDraw).l
		move.l	#AniRaw_RobotnikHead,$30(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	Obj_RobotnikHeadEnd

; =============== S U B R O U T I N E =======================================


sub_67B14:
		move.l	#Map_EggRoboHead,mappings(a0)	; If player is Knuckles, use EggRobo head

loc_67B1C:
		move.l	#AniRaw_EggRoboHead,$30(a0)
		lea	(ArtKosM_EggRoboHead).l,a1
		move.w	#tiles_to_bytes($52E),d2
		jmp	(Queue_Kos_Module).l
; End of function sub_67B14

; ---------------------------------------------------------------------------

Obj_RobotnikHeadMain:
		jsr	(Animate_Raw).l
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		bne.s	+ ;loc_67B56
		btst	#6,status(a1)
		beq.s	locret_67B54
		move.b	#2,mapping_frame(a0)		; Use hurt mapping frame if parent boss object is currently hurt

locret_67B54:
		rts
; ---------------------------------------------------------------------------

+ ;loc_67B56:
		move.b	#4,routine(a0)
		move.b	#3,mapping_frame(a0)		; Use defeated head frame if parent boss object is defeated
		rts
; ---------------------------------------------------------------------------

Obj_RobotnikHeadEnd:
		rts
; ---------------------------------------------------------------------------

Obj_RobotnikHead2:
		jsr	(Refresh_ChildPositionAdjusted).l
		jsr	(Child_SyncDraw).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		btst	#6,$38(a0)
		bne.w	Obj_RobotnikHeadEnd
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_RobotnikHeadInit-.Index
		dc.w Obj_RobotnikHeadMain-.Index
		dc.w Obj_RobotnikHeadEnd-.Index
; ---------------------------------------------------------------------------

Obj_FBZRobotnikHead:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		jsr	(Child_GetPriority).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_FBZRobotnikHeadInit-.Index
		dc.w Obj_FBZRobotnikHeadMain-.Index
		dc.w Obj_RobotnikHeadEnd-.Index
; ---------------------------------------------------------------------------

Obj_FBZRobotnikHeadInit:
		lea	ObjDat_FBZRobotnikHead(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#AniRaw_RobotnikHead,$30(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		cmpi.b	#2,(Player_1+character_id).w
		bne.w	Obj_RobotnikHeadEnd
		bra.w	sub_67B14
; ---------------------------------------------------------------------------

Obj_FBZRobotnikHeadMain:
		move.w	x_pos(a0),d0
		bclr	#0,render_flags(a0)
		cmp.w	(Player_1+x_pos).w,d0
		bhs.s	+ ;loc_67BFC
		bset	#0,render_flags(a0)

+ ;loc_67BFC:
		clr.b	mapping_frame(a0)
		movea.w	$44(a0),a1
		; Bug: this should check bit 2 of $38(a1)
		btst	#2,$38(a0)
		beq.s	+ ;loc_67C12
		move.b	#1,mapping_frame(a0)

+ ;loc_67C12:
		btst	#7,status(a1)
		bne.s	+ ;loc_67C2A
		btst	#6,status(a1)
		beq.s	locret_67C28
		move.b	#2,mapping_frame(a0)

locret_67C28:
		rts
; ---------------------------------------------------------------------------

+ ;loc_67C2A:
		move.b	#4,routine(a0)
		move.b	#3,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

Obj_RobotnikHead3:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_RobotnikHead3Init-.Index
		dc.w Obj_RobotnikHead3Main-.Index
		dc.w Obj_RobotnikHead3End-.Index
; ---------------------------------------------------------------------------

Obj_RobotnikHead3Init:
		lea	ObjDat_RobotnikHead(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#AniRaw_RobotnikHead,$30(a0)
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	+ ;loc_67C76
		bsr.w	sub_67B14

+ ;loc_67C76:
		movea.w	parent3(a0),a1
		btst	#7,art_tile(a1)
		beq.s	locret_67C88
		bset	#7,art_tile(a0)

locret_67C88:
		rts
; ---------------------------------------------------------------------------

Obj_RobotnikHead3Main:
		jsr	(Animate_Raw).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	+ ;loc_67CAC
		btst	#6,status(a1)
		beq.s	locret_67CAA
		move.b	#2,mapping_frame(a0)

locret_67CAA:
		rts
; ---------------------------------------------------------------------------

+ ;loc_67CAC:
		move.b	#4,routine(a0)
		move.b	#3,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

Obj_RobotnikHead3End:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.w	Obj_RobotnikHeadEnd
		lea	AniRaw_RobotnikHead(pc),a1
		jmp	(Animate_RawNoSST).l
; ---------------------------------------------------------------------------

Obj_RobotnikHead4:
		jsr	(Refresh_ChildPositionAdjusted).l
		jsr	(Child_GetPriority).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.s	+ ;loc_67CFE
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_67CFE:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_RobotnikHead3Init-.Index
		dc.w Obj_RobotnikHead3Main-.Index
		dc.w Obj_RobotnikHead3End-.Index
; ---------------------------------------------------------------------------

Obj_MechaSonicHead:
		lea	ObjDat_MechaSonicHead(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#.Main,(a0)
		lea	(ArtKosM_MechaSonicHead).l,a1
		move.w	#tiles_to_bytes($52E),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

.Main:
		jsr	(Refresh_ChildPositionAdjusted).l
		tst.b	(_unkFA89).w
		bne.s	+ ;loc_67D3C
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_67D3C:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_RobotnikShip:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		btst	#6,$38(a0)
		bne.w	Obj_RobotnikHeadEnd
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_67D68-.Index
		dc.w loc_67D84-.Index
		dc.w loc_67DD8-.Index
		dc.w loc_67E0A-.Index
; ---------------------------------------------------------------------------

loc_67D68:
		lea	ObjDat_RobotnikShip(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	subtype(a0),mapping_frame(a0)
		lea	(Child1_MakeRoboHead2).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_67D84:
		jsr	(Refresh_ChildPositionAdjusted).l
		jsr	(Child_SyncDraw).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	+ ;loc_67D9E
		rts
; ---------------------------------------------------------------------------

+ ;loc_67D9E:
		move.b	#4,routine(a0)
		cmpi.b	#0,(Current_zone).w
		beq.s	+ ;loc_67DC2
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	locret_67DC0
		move.b	#4,subtype(a1)

locret_67DC0:
		rts
; ---------------------------------------------------------------------------

+ ;loc_67DC2:
		lea	(Child6_CreateBossExplosion).l,a2	; if in Angel Island
		jsr	(CreateChild6_Simple).l
		bne.s	locret_67DD6
		move.b	#$12,subtype(a1)

locret_67DD6:
		rts
; ---------------------------------------------------------------------------

loc_67DD8:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	+ ;loc_67DF0
		jsr	(Child_SyncDraw).l
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------

+ ;loc_67DF0:
		move.b	#6,routine(a0)
		move.b	#5,mapping_frame(a0)
		move.w	#-$200,y_vel(a0)
		move.w	#$7F,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_67E0A:
		jsr	(MoveSprite).l
		subq.w	#1,$2E(a0)
		bmi.s	+ ;loc_67E18
		rts
; ---------------------------------------------------------------------------

+ ;loc_67E18:
		bset	#5,$38(a0)
		clr.b	(Boss_flag).w
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

Obj_RobotnikShip2:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_RobotnikShipInit-.Index
		dc.w Obj_RobotnikShipMain-.Index
		dc.w Obj_RobotnikShip2Wait-.Index
		dc.w Obj_RobotnikShipReady-.Index
		dc.w Obj_RobotnikShipEscape-.Index
; ---------------------------------------------------------------------------

Obj_RobotnikShip2Wait:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	+ ;loc_67E54
		rts
; ---------------------------------------------------------------------------

+ ;loc_67E54:
		move.b	#6,routine(a0)
		move.b	#5,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

Obj_RobotnikShip3:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.s	+ ;loc_67E8C
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_RobotnikShipInit-.Index
		dc.w Obj_RobotnikShipMain-.Index
		dc.w Obj_RobotnikShipWait-.Index
		dc.w Obj_RobotnikShipReady-.Index
		dc.w Obj_RobotnikShipEscape-.Index
; ---------------------------------------------------------------------------

+ ;loc_67E8C:
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

Obj_RobotnikShipInit:
		lea	ObjDat_RobotnikShip(pc),a1
		jsr	(SetUp_ObjAttributes).l
		jsr	(Child_SyncDraw).l
		move.b	subtype(a0),mapping_frame(a0)
		lea	(Child1_MakeRoboHead).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

Obj_RobotnikShipMain:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	+ ;loc_67EC8
		rts
; ---------------------------------------------------------------------------

+ ;loc_67EC8:
		move.b	#4,routine(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	locret_67EE2
		move.b	#4,subtype(a1)

locret_67EE2:
		rts
; ---------------------------------------------------------------------------

Obj_RobotnikShipWait:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	+ ;loc_67EF6
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------

+ ;loc_67EF6:
		move.b	#6,routine(a0)
		move.b	#$A,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

Obj_RobotnikShipReady:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$40,d0
		cmp.w	y_pos(a0),d0
		bhs.s	+ ;loc_67F18
		subq.w	#1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_67F18:
		move.b	#8,routine(a0)

loc_67F1E:
		bset	#0,render_flags(a0)
		move.w	#$300,x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#$100,$2E(a0)
		lea	Child1_MakeRoboShipFlame(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

Obj_RobotnikShipEscape:
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bmi.s	+ ;loc_67F4C
		rts
; ---------------------------------------------------------------------------

+ ;loc_67F4C:
		bset	#5,$38(a0)
		clr.b	(Boss_flag).w
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

Obj_RobotnikShip4:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_RobotnikShipInit-.Index
		dc.w Obj_RobotnikShipMain-.Index
		dc.w Obj_RobotnikShipWait-.Index
		dc.w Obj_RobotnikShipReady-.Index
		dc.w Obj_RobotnikShipEscape-.Index
; ---------------------------------------------------------------------------

Obj_FBZRobotnikShip:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_FBZRobotnikShipInit-.Index
		dc.w Obj_FBZRobotnikShipMain-.Index
		dc.w Obj_FBZRobotnikShipWait-.Index
		dc.w Obj_FBZRobotnikShipFall-.Index
		dc.w Obj_FBZRobotnikShipRise-.Index
		dc.w Obj_RobotnikShipEscape-.Index
; ---------------------------------------------------------------------------

Obj_FBZRobotnikShipInit:
		lea	ObjDat_RobotnikShip(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	subtype(a0),mapping_frame(a0)
		lea	(Child1_MakeFBZRoboHead).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

Obj_FBZRobotnikShipMain:
		jsr	(Refresh_ChildPosition).l
		jsr	(Child_GetPriority).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	+ ;loc_67FD0
		rts
; ---------------------------------------------------------------------------

+ ;loc_67FD0:
		move.b	#4,routine(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	locret_67FEA
		move.b	#4,subtype(a1)

locret_67FEA:
		rts
; ---------------------------------------------------------------------------

Obj_FBZRobotnikShipWait:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	+ ;loc_68004
		jsr	(Child_GetPriority).l
		jmp	(Refresh_ChildPosition).l
; ---------------------------------------------------------------------------

+ ;loc_68004:
		move.b	#6,routine(a0)
		move.b	#5,mapping_frame(a0)
		clr.w	x_vel(a0)
		move.w	#-$200,y_vel(a0)
		move.w	#$2F,$2E(a0)
		move.l	#Obj_FBZRobotnikShipReadyGo,$34(a0)
		rts
; ---------------------------------------------------------------------------

Obj_FBZRobotnikShipFall:
		jsr	(MoveSprite).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

Obj_FBZRobotnikShipReadyGo:
		move.b	#8,routine(a0)
		bset	#0,render_flags(a0)
		rts
; ---------------------------------------------------------------------------

Obj_FBZRobotnikShipRise:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$C0,d0
		cmp.w	y_pos(a0),d0
		bhs.s	+ ;loc_68058
		subq.w	#1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_68058:
		move.b	#$A,routine(a0)
		bra.w	loc_67F1E
; ---------------------------------------------------------------------------

Obj_RobotnikShipFlame:
		lea	ObjDat3_RoboShipFlame(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#Obj_RobotnikShipFlameMain,(a0)
		rts
; ---------------------------------------------------------------------------

Obj_RobotnikShipFlameMain:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	+ ;loc_6809E
		jsr	(Refresh_ChildPositionAdjusted).l
		btst	#0,(V_int_run_count+3).w
		bne.w	Obj_RobotnikHeadEnd
		tst.w	x_vel(a1)
		beq.w	Obj_RobotnikHeadEnd
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_6809E:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_Difficulty_Ship:
		move.l	#loc_680EC,(a0)
		move.l	#Map_RobotnikShip,mappings(a0)
		move.w	#make_art_tile($26F,1,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		move.b	#$A,mapping_frame(a0)
		move.w	#$188,x_pos(a0)
		move.w	#$C0,y_pos(a0)
		jsr	(Swing_Setup1).l
		lea	Child1_DifficultyShipHead(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_680EC:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_Difficulty_ShipHead:
		move.l	#loc_68118,(a0)
		move.w	#$280,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		rts
; ---------------------------------------------------------------------------

loc_68118:
		jsr	(Refresh_ChildPositionAdjusted).l
		lea	AniRaw_EggRoboHead(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
ObjDat_RobotnikHead:
		dc.l Map_RobotnikShip
		dc.w make_art_tile($52E,0,0)
		dc.w   $280
		dc.b  $10,   8,   0,   0
ObjDat_FBZRobotnikHead:
		dc.l Map_FBZRobotnikHead
		dc.w make_art_tile($430,0,0)
		dc.w   $280
		dc.b  $10,   8,   0,   0
ObjDat_RobotnikShip:
		dc.l Map_RobotnikShip
		dc.w make_art_tile($52E,0,0)
		dc.w   $280
		dc.b  $1C, $20,   8,   0
ObjDat3_RoboShipFlame:
		dc.w   $280
		dc.b    8,   4,   6,   0
ObjDat_MechaSonicHead:
		dc.l Map_MechaSonicHead
		dc.w make_art_tile($52E,1,0)
		dc.w   $280
		dc.b  $14, $10,   0,   0
Child1_MakeRoboHead:
		dc.w 1-1
		dc.l Obj_RobotnikHead
		dc.b    0,-$1C
Child1_MakeRoboHead2:
		dc.w 1-1
		dc.l Obj_RobotnikHead2
		dc.b    0,-$1C
Child1_MakeFBZRoboHead:
		dc.w 1-1
		dc.l Obj_FBZRobotnikHead
		dc.b    0,-$1C
Child1_MakeRoboHead3:
		dc.w 1-1
		dc.l Obj_RobotnikHead3
		dc.b    0,-$1C
Child1_MakeRoboHead4:
		dc.w 1-1
		dc.l Obj_RobotnikHead4
		dc.b    0,-$1C
Child1_MakeRoboShip:
		dc.w 1-1
		dc.l Obj_RobotnikShip
		dc.b    0,-$14
Child1_MakeRoboShip2:	; unused
		dc.w 1-1
		dc.l Obj_RobotnikShip2
		dc.b    0,   0
Child1_MakeRoboShip3:
		dc.w 1-1
		dc.l Obj_RobotnikShip3
		dc.b   -6,   4
Child1_MakeRoboShip4:
		dc.w 1-1
		dc.l Obj_RobotnikShip4
		dc.b    0,  -8
Child1_MakeFBZRoboShip:
		dc.w 1-1
		dc.l Obj_FBZRobotnikShip
		dc.b    0,   4
Child1_MakeRoboShipFlame:
		dc.w 1-1
		dc.l Obj_RobotnikShipFlame
		dc.b  $1E,   0
Child1_MakeMechaHead:
		dc.w 1-1
		dc.l Obj_MechaSonicHead
		dc.b    0,-$20
Child1_DifficultyShipHead:
		dc.w 1-1
		dc.l Obj_Difficulty_ShipHead
		dc.b    0,-$1C
AniRaw_RobotnikHead:
		dc.b    5,   0,   1, $FC
AniRaw_EggRoboHead:
		dc.b   $F,   0,   1, $FC
		even
Map_EggRoboHead:
		include "General/Sprites/Egg Robo/Map - Egg Robo Head.asm"
Map_MechaSonicHead:
		include "General/Sprites/Mecha Sonic/Map - Mecha Sonic Head.asm"
Map_RobotnikShip:
		include "General/Sprites/Robotnik/Map - Robotnik Ship.asm"
Map_FBZRobotnikRun:
		include "General/Sprites/Robotnik/Map - FBZ Robotnik Run.asm"
Map_FBZRobotnikHead:
		include "General/Sprites/Robotnik/Map - FBZ Robotnik Head.asm"
Map_FBZRobotnikStand:
		include "General/Sprites/Robotnik/Map - FBZ Robotnik Stand.asm"
