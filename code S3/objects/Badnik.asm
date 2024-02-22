loc_54B46:
		movea.l	$3E(a0),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_54B5A,(a0)
		bset	#3,shield_reaction(a0)

loc_54B5A:
		movea.l	$34(a0),a1
		jsr	(a1)
		jmp	(Sprite_CheckDeleteTouchXY).l
; ---------------------------------------------------------------------------

	include "code S3/badnik/AIZ/Bloominator.asm"
	include "code S3/badnik/AIZ/Rhinobot.asm"
	include "code S3/badnik/AIZ/Monkey Dude.asm"
	include "code S3/badnik/AIZ/Cater Killer Jr.asm"

	include "code S3/badnik/HCZ/Jawz.asm"
	include "code S3/badnik/HCZ/Blastoid.asm"
	include "code S3/badnik/HCZ/Buggernaut.asm"
	include "code S3/badnik/HCZ/Turbo Spiker.asm"
	include "code S3/badnik/HCZ/Mega Chopper.asm"

	include "code S3/badnik/MGZ/Poindexter.asm"
	include "code S3/badnik/MGZ/Bubbles.asm"
	include "code S3/badnik/MGZ/Tunnelbot.asm"
	include "code S3/badnik/MGZ/Spiker.asm"
	include "code S3/badnik/MGZ/Mantis.asm"

	include "code S3/badnik/CNZ/Clamer.asm"
	include "code S3/badnik/CNZ/Sparkle.asm"
	include "code S3/badnik/CNZ/Batbot.asm"

	include "code S3/badnik/FBZ/Blaster.asm"
	include "code S3/badnik/FBZ/Technosqueek.asm"

	include "code S3/objects/ICZ/Pushable Platform.asm"
	include "code S3/objects/ICZ/Crushing Column.asm"
	include "code S3/objects/ICZ/Freezer.asm"
	include "code S3/objects/ICZ/Segment Column.asm"
	include "code S3/objects/ICZ/Swinging Platform.asm"
	include "code S3/objects/ICZ/Stalagtite.asm"
	include "code S3/objects/ICZ/Ice Spikes.asm"
	include "code S3/objects/ICZ/Ice Cube.asm"
	include "code S3/objects/ICZ/Harmful Ice.asm"
	include "code S3/objects/ICZ/Snow Pile.asm"
	include "code S3/objects/ICZ/Tension Platform.asm"

	include "code S3/badnik/ICZ/Penguinator.asm"
	include "code S3/badnik/ICZ/Star Pointer.asm"

	include "code S3/badnik/LBZ/Snale Blaster.asm"
	include "code S3/badnik/LBZ/Ribot.asm"
	include "code S3/badnik/LBZ/Orbinaut.asm"
	include "code S3/badnik/LBZ/Corkey.asm"
	include "code S3/badnik/LBZ/Flybot 767.asm"
	include "code S3/badnik/LBZ/Robotnik.asm"

