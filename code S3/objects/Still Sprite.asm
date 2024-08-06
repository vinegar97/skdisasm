Obj_StillSprite:
		move.l	#Map_StillSprites,mappings(a0)
		ori.b	#4,render_flags(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.b	d0,mapping_frame(a0)
		add.w	d0,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	word_2B31A(pc,d0.w),a1
		move.w	(a1)+,art_tile(a0)
		move.w	(a1)+,priority(a0)
		move.b	(a1)+,width_pixels(a0)
		move.b	(a1)+,height_pixels(a0)
		move.l	#loc_2B314,(a0)

loc_2B314:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
word_2B31A:
		dc.w make_art_tile($2E9,2,0)	; 0 AIZ2 Bridge Post
		dc.w   $300
		dc.b   $C,  $C
		dc.w make_art_tile($2E9,2,0)	; 1 AIZ2 Large Rope Twist Tie
		dc.w   $300
		dc.b  $10,   8
		dc.w make_art_tile($2E9,2,0)	; 2 AIZ2 Rope Twist tie
		dc.w   $300
		dc.b    8,   4
		dc.w make_art_tile($001,2,0)	; 3 AIZ2 Tie Top Sprite
		dc.w   $300
		dc.b    8,   8
		dc.w make_art_tile($001,3,0)	; 4 AIZ2 Waterfall sprite
		dc.w   $300
		dc.b    8, $20
		dc.w make_art_tile($2E9,2,1)	; 5 AIZ2 Bridge Post (Different Palette)
		dc.w   $300
		dc.b   $C,  $C
		dc.w make_art_tile($001,2,1)	; 6 128x128 HCZ Waterfall
		dc.w      0
		dc.b  $40, $40
		dc.w make_art_tile($001,2,1)	; 7 128x64 HCZ Waterfall
		dc.w      0
		dc.b  $40, $20
		dc.w make_art_tile($001,2,0)	; 8 128x32 HCZ Waterfall
		dc.w   $300
		dc.b  $40, $10
		dc.w make_art_tile($001,2,1)	; 9 Stagger Down HCZ Waterfall
		dc.w      0
		dc.b  $40, $40
		dc.w make_art_tile($001,2,1)	; A Stagger Up HCZ Waterfall
		dc.w      0
		dc.b  $40, $60
		dc.w make_art_tile($451,2,0)	; B MGZ Signpost Left
		dc.w   $300
		dc.b  $10, $18
		dc.w make_art_tile($451,2,0)	; C MGZ Signpost Right
		dc.w   $300
		dc.b  $10, $18
		dc.w make_art_tile($451,2,0)	; D MGZ Signpost Up
		dc.w   $300
		dc.b  $10, $18
		dc.w make_art_tile($451,2,0)	; E MGZ Signpost Down
		dc.w   $300
		dc.b  $10, $18
		dc.w make_art_tile($368,2,1)	; F HCZ2 Tube Bend 1
		dc.w      0
		dc.b    8, $30
		dc.w make_art_tile($379,2,1)	; 10 HCZ2 Tube Bend 2
		dc.w      0
		dc.b  $30, $18
		dc.w make_art_tile($399,2,1)	; 11 HCZ2 Tube Bend 3
		dc.w      0
		dc.b   $C, $10
		dc.w make_art_tile($3A4,2,1)	; 12 HCZ2 Tube Crossover
		dc.w      0
		dc.b  $20, $34
		dc.w make_art_tile($038,2,0)	; 13 HCZ2 Bridge Post
		dc.w   $300
		dc.b    4, $10
		dc.w make_art_tile($40D,2,0)	; 14 LBZ Cup Elevator Pole Top
		dc.w   $300
		dc.b    8,   8
		dc.w make_art_tile($433,1,0)	; 15 LBZ Steel Girder Low Priority
		dc.w   $300
		dc.b  $10, $40
		dc.w make_art_tile($433,1,0)	; 16 LBZ Large Steel Girder
		dc.w   $300
		dc.b  $10, $80
		dc.w make_art_tile($433,1,0)	; 17 LBZ Steel Girder High Priority
		dc.w    $80
		dc.b  $10, $40
Map_StillSprites:
		include "Levels/Misc/Map - Still Sprites S3.asm"
; ---------------------------------------------------------------------------

Obj_AnimatedStillSprite:
		move.l	#Map_AnimatedStillSprites,mappings(a0)
		ori.b	#4,render_flags(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.b	d0,anim(a0)
		add.w	d0,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	word_2B6B6(pc,d0.w),a1
		move.w	(a1)+,art_tile(a0)
		move.w	(a1)+,priority(a0)
		move.b	(a1)+,width_pixels(a0)
		move.b	(a1)+,height_pixels(a0)
		move.l	#loc_2B6A4,(a0)

loc_2B6A4:
		lea	(Ani_AnimatedStillSprites).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
word_2B6B6:
		dc.w make_art_tile($2E9,3,0)
		dc.w   $300
		dc.b    8,  $C
		dc.w make_art_tile($2E9,3,0)
		dc.w   $300
		dc.b    8,  $C
Ani_AnimatedStillSprites:
		include "Levels/Misc/Anim - Animated Still Sprites S3.asm"
Map_AnimatedStillSprites:
		include "Levels/Misc/Map - Animated Still Sprites S3.asm"
