; =============== S U B R O U T I N E =======================================


AfterBoss_Cleanup:
		moveq	#0,d0
		lea	(Current_zone_and_act).w,a1
		move.b	(a1)+,d0
		add.b	d0,d0
		add.b	(a1)+,d0
		add.b	d0,d0
		move.w	.Index(pc,d0.w),d0
		jmp	.Index(pc,d0.w)
; End of function AfterBoss_Cleanup

; ---------------------------------------------------------------------------
.Index:
		dc.w AfterBoss_AIZ1-.Index
		dc.w AfterBoss_AIZ2-.Index
		dc.w AfterBoss_HCZ-.Index
		dc.w AfterBoss_HCZ-.Index
		dc.w AfterBoss_MGZ-.Index
		dc.w AfterBoss_MGZ-.Index
		dc.w AfterBoss_CNZ-.Index
		dc.w AfterBoss_CNZ-.Index
		dc.w AfterBoss_FBZ-.Index
		dc.w AfterBoss_FBZ-.Index
		dc.w AfterBoss_ICZ1-.Index
		dc.w AfterBoss_ICZ2-.Index
		dc.w AfterBoss_LBZ-.Index
		dc.w AfterBoss_LBZ-.Index
		dc.w AfterBoss_MHZ-.Index
		dc.w AfterBoss_MHZ-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
		dc.w AfterBoss_None-.Index
; ---------------------------------------------------------------------------

AfterBoss_AIZ1:
		lea	(Pal_AIZ).l,a1
		lea	(Normal_palette_line_2).w,a2
		moveq	#bytesToLcnt($60),d0

.loop:
		move.l	(a1)+,(a2)+
		dbf	d0,.loop
		rts
; ---------------------------------------------------------------------------

AfterBoss_AIZ2:
		lea	(Pal_AIZFire).l,a1
		jsr	(PalLoad_Line1).l
		lea	PLC_AfterMiniboss_AIZ(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

AfterBoss_HCZ:
		rts
; ---------------------------------------------------------------------------

AfterBoss_MGZ:
		lea	PLC_MonitorsSpikesSprings(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

AfterBoss_CNZ:
AfterBoss_FBZ:
AfterBoss_ICZ1:
		rts
; ---------------------------------------------------------------------------

AfterBoss_ICZ2:
		lea	(Pal_ICZ2).l,a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

AfterBoss_LBZ:
		; Bug: LBZ uses a post-boss routine meant for MHZ
		; This makes the MHZ object palette load during LBZ1's results

AfterBoss_MHZ:
		lea	(Pal_MHZ2).l,a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

AfterBoss_None:
		rts
; ---------------------------------------------------------------------------
PLC_AfterMiniboss_AIZ: plrlistheader
		plreq ArtTile_Monitors, ArtNem_Monitors
		plreq $2E9, ArtNem_AIZMisc2
		plreq $41B, ArtNem_AIZSwingVine
		plreq $438, ArtNem_AIZBackgroundTree
		plreq $45C, ArtNem_Bubbles
		plreq $456, ArtNem_GrayButton
		plreq $440, ArtNem_AIZCorkFloor2
PLC_AfterMiniboss_AIZ_End

Pal_AfterMiniboss_AIZ:
		binclude "Levels/AIZ/Palettes/Miniboss After.bin"
		even
Pal_AfterMiniboss_ICZ:
		binclude "Levels/ICZ/Palettes/Miniboss After.bin"
		even
PLC_MonitorsSpikesSprings: plrlistheader
		plreq ArtTile_Monitors, ArtNem_Monitors
		plreq $494, ArtNem_SpikesSprings
PLC_MonitorsSpikesSprings_End

PLC_Monitors: plrlistheader
		plreq ArtTile_Monitors, ArtNem_Monitors
PLC_Monitors_End

PLC_AnimalsAndExplosion: plrlistheader	; unused
		plreq ArtTile_Explosion, ArtNem_Explosion
		plreq $580, ArtNem_Squirrel
		plreq $592, ArtNem_BlueFlicky
PLC_AnimalsAndExplosion_End

PLC_BossExplosion: plrlistheader
		plreq $500, ArtNem_BossExplosion
PLC_BossExplosion_End

PLC_Explosion: plrlistheader
		plreq ArtTile_Explosion, ArtNem_Explosion
PLC_Explosion_End

PLC_EggCapsule: plrlistheader
		plreq $494, ArtNem_EggCapsule
PLC_EggCapsule_End

PLC_RobotnikShip: plrlistheader
		plreq $52E, ArtNem_RobotnikShip
PLC_RobotnikShip_End
; ---------------------------------------------------------------------------

Obj_CreateBossExplosion:
		moveq	#0,d0
		move.b	subtype(a0),d0
		lea	CreateBossExpParameterIndex(pc),a1
		adda.w	(a1,d0.w),a1
		move.b	(a1)+,$39(a0)
		move.b	(a1)+,$3A(a0)
		move.b	(a1)+,$3B(a0)
		move.b	(a1)+,d0
		lea	CreateBossExpRoutineSet(pc,d0.w),a1
		movea.l	(a1)+,a2
		move.l	a2,(a0)
		move.l	(a1)+,$34(a0)
		jmp	(a2)
; ---------------------------------------------------------------------------
CreateBossExpRoutineSet:
		dc.l Obj_Wait
		dc.l Obj_BossExpControl1
		dc.l Obj_WaitForParent
		dc.l Obj_BossExpControl1
		dc.l Obj_Wait
		dc.l Obj_NormalExpControl
		dc.l Obj_Wait
		dc.l Obj_BossExpControl2
		dc.l Obj_WaitForParent
		dc.l Obj_BossExpControl2
		dc.l Obj_WaitForParent
		dc.l Obj_NormalExpControl
		dc.l Obj_WaitForParent
		dc.l Obj_BossExpControlOff
CreateBossExpParameterIndex:
		dc.w CreateBossExp00-CreateBossExpParameterIndex
		dc.w CreateBossExp02-CreateBossExpParameterIndex
		dc.w CreateBossExp04-CreateBossExpParameterIndex
		dc.w CreateBossExp06-CreateBossExpParameterIndex
		dc.w CreateBossExp08-CreateBossExpParameterIndex
		dc.w CreateBossExp0A-CreateBossExpParameterIndex
		dc.w CreateBossExp0C-CreateBossExpParameterIndex
		dc.w CreateBossExp0E-CreateBossExpParameterIndex
		dc.w CreateBossExp10-CreateBossExpParameterIndex
		dc.w CreateBossExp12-CreateBossExpParameterIndex
		dc.w CreateBossExp14-CreateBossExpParameterIndex
		dc.w CreateBossExp16-CreateBossExpParameterIndex
		dc.w CreateBossExp18-CreateBossExpParameterIndex
		dc.w CreateBossExp1A-CreateBossExpParameterIndex
		dc.w CreateBossExp1C-CreateBossExpParameterIndex
		dc.w CreateBossExp1E-CreateBossExpParameterIndex
		dc.w CreateBossExp20-CreateBossExpParameterIndex
CreateBossExp00:dc.b  $20, $20, $20,   0	; Explosion timer, X offset range, Y offset range, routine set
CreateBossExp02:dc.b  $28, $80, $80, $18
CreateBossExp04:dc.b  $80, $20, $20,   8
CreateBossExp06:dc.b    4, $10, $10,   0
CreateBossExp08:dc.b    8, $20, $20, $10
CreateBossExp0A:dc.b  $20, $20, $20,   0
CreateBossExp0C:dc.b  $40, $80, $20,   0
CreateBossExp0E:dc.b  $80, $40, $40,   8
CreateBossExp10:dc.b  $20, $20, $20, $18
CreateBossExp12:dc.b  $80, $20, $20, $20
CreateBossExp14:dc.b    8, $80, $20, $10
CreateBossExp16:dc.b  $80, $80, $80,   8
CreateBossExp18:dc.b  $80, $80, $80, $28
CreateBossExp1A:dc.b  $80, $40, $40, $28
CreateBossExp1C:dc.b  $80, $80, $40,   8
CreateBossExp1E:dc.b  $80, $10, $10,   8
CreateBossExp20:dc.b  $80, $20, $20, $30
; ---------------------------------------------------------------------------

Obj_WaitForParent:
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.w	loc_83EC2
		tst.l	(a1)
		beq.w	loc_83EC2
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

Obj_BossExpControl1:
		move.b	$39(a0),d0
		bmi.s	loc_83E7E		; If negative, explosions are constantly created every three frames
		subq.b	#1,d0
		move.b	d0,$39(a0)		; Otherwise, continue making explosions until timer runs out
		beq.s	loc_83EC2

loc_83E7E:
		move.w	#2,$2E(a0)

; =============== S U B R O U T I N E =======================================


sub_83E84:
		lea	Child6_MakeBossExplosion1(pc),a2
		jsr	CreateChild6_Simple(pc)
		bne.w	locret_83EC0

loc_83E90:
		jsr	(Random_Number).l		; Offset the explosion by a random amount capped by an effective range
		moveq	#0,d1
		move.b	$3A(a0),d1
		move.w	d1,d2
		add.w	d2,d2
		subq.w	#1,d2
		and.w	d2,d0
		sub.w	d1,d0
		add.w	d0,x_pos(a1)
		swap	d0
		moveq	#0,d1
		move.b	$3B(a0),d1
		move.w	d1,d2
		add.w	d2,d2
		subq.w	#1,d2
		and.w	d2,d0
		sub.w	d1,d0
		add.w	d0,y_pos(a1)

locret_83EC0:
		rts
; End of function sub_83E84

; ---------------------------------------------------------------------------

loc_83EC2:
		jmp	Go_Delete_Sprite(pc)
; ---------------------------------------------------------------------------

Obj_NormalExpControl:
		subq.b	#1,$39(a0)				; Same as above, but uses regular explosions (no animals of course)
		beq.s	loc_83EC2
		move.w	#2,$2E(a0)
		lea	Child6_MakeNormalExplosion(pc),a2
		jsr	CreateChild6_Simple(pc)
		bne.w	locret_83EC0
		move.b	#2,routine(a1)
		bset	#7,art_tile(a1)
		bra.s	loc_83E90
; ---------------------------------------------------------------------------

Obj_BossExpControl2:
		subq.b	#1,$39(a0)
		beq.s	loc_83EC2
		move.w	#2,$2E(a0)
		lea	Child6_MakeBossExplosion2(pc),a2
		jsr	CreateChild6_Simple(pc)
		bne.w	locret_83EC0
		bra.s	loc_83E90
; ---------------------------------------------------------------------------

Obj_BossExpControlOff:
		subq.b	#1,$39(a0)
		beq.s	loc_83EC2
		move.w	#2,$2E(a0)
		lea	Child6_MakeBossExplosionOff(pc),a2
		jsr	CreateChild6_Simple(pc)
		bne.w	locret_83EC0
		bra.w	loc_83E90
; ---------------------------------------------------------------------------

Obj_BossExplosionSpecial:
		move.w	#2,$2E(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#320/2,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#224/2,d0
		move.w	d0,y_pos(a0)
		move.b	#2,subtype(a0)
		bra.w	Obj_CreateBossExplosion
; ---------------------------------------------------------------------------

Obj_BossExplosion1:
		lea	ObjDat_BossExplosion1(pc),a1
		jsr	SetUp_ObjAttributes(pc)

loc_83F52:
		move.l	#Obj_BossExplosionAnim,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		moveq	#signextendB(sfx_Explode),d0
		jsr	(Play_SFX).l

Obj_BossExplosionAnim:
		lea	AniRaw_BossExplosion(pc),a1
		jsr	Animate_RawNoSSTMultiDelay(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_BossExplosion2:
		lea	ObjDat_BossExplosion2(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		bra.s	loc_83F52
; ---------------------------------------------------------------------------

Obj_BossExplosionOffset:
		lea	ObjDat_BossExplosion1(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#Obj_BossExplosionOffsetAnim,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		moveq	#signextendB(sfx_Explode),d0
		jsr	(Play_SFX).l

Obj_BossExplosionOffsetAnim:
		move.w	(Level_repeat_offset).w,d0
		sub.w	d0,x_pos(a0)
		lea	AniRaw_BossExplosion(pc),a1
		jsr	Animate_RawNoSSTMultiDelay(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
ObjDat_BossExplosion1:
		dc.l Map_BossExplosion
		dc.w make_art_tile($500,0,1)
		dc.w      0
		dc.b   $C,  $C,   0,   0
ObjDat_BossExplosion2:
		dc.l Map_BossExplosion
		dc.w make_art_tile($4D2,0,1)
		dc.w      0
		dc.b   $C,  $C,   0,   0
AniRaw_BossExplosion:
		dc.b    0,   0,   0,   1,   1,   1,   2,   2,   3,   3,   4,   4,   5,   4, $F4
		even
Child6_MakeBossExplosion1:
		dc.w 1-1
		dc.l Obj_BossExplosion1
Child6_MakeBossExplosion2:
		dc.w 1-1
		dc.l Obj_BossExplosion2
Child6_MakeBossExplosionOff:
		dc.w 1-1
		dc.l Obj_BossExplosionOffset
Child6_CreateBossExplosion:
		dc.w 1-1
		dc.l Obj_CreateBossExplosion
		dc.b    0,   0
Child6_MakeNormalExplosion:
		dc.w 1-1
		dc.l Obj_Explosion
Map_BossExplosion:
		include "General/Sprites/Boss Explosion/Map - Boss Explosion.asm"
