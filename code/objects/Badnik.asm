loc_86D4A:
		movea.l	$3E(a0),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_86D5E,(a0)
		bset	#3,shield_reaction(a0)

loc_86D5E:
		movea.l	$34(a0),a1
		jsr	(a1)
		jmp	(Sprite_CheckDeleteTouchXY).l
; ---------------------------------------------------------------------------

	include "code/badnik/AIZ/Bloominator.asm"
	include "code/badnik/AIZ/Rhinobot.asm"
	include "code/badnik/AIZ/Monkey Dude.asm"
	include "code/badnik/AIZ/Cater Killer Jr.asm"

	include "code/badnik/HCZ/Jawz.asm"
	include "code/badnik/HCZ/Blastoid.asm"
	include "code/badnik/HCZ/Buggernaut.asm"
	include "code/badnik/HCZ/Turbo Spiker.asm"
	include "code/badnik/HCZ/Mega Chopper.asm"

	include "code/badnik/MGZ/Poindexter.asm"
	include "code/badnik/MGZ/Bubbles.asm"
	include "code/badnik/MGZ/Tunnelbot.asm"
	include "code/badnik/MGZ/Spiker.asm"
	include "code/badnik/MGZ/Mantis.asm"

	include "code/badnik/CNZ/Clamer.asm"
	include "code/badnik/CNZ/Sparkle.asm"
	include "code/badnik/CNZ/Batbot.asm"

	include "code/badnik/FBZ/Blaster.asm"
	include "code/badnik/FBZ/Technosqueek.asm"
	include "code/badnik/FBZ/Egg Capsule.asm"

	include "code/objects/ICZ/Pushable Platform.asm"
	include "code/objects/ICZ/Crushing Column.asm"
	include "code/objects/ICZ/Freezer.asm"
	include "code/objects/ICZ/Segment Column.asm"
	include "code/objects/ICZ/Swinging Platform.asm"
	include "code/objects/ICZ/Stalagtite.asm"
	include "code/objects/ICZ/Ice Spikes.asm"
	include "code/objects/ICZ/Ice Cube.asm"
	include "code/objects/ICZ/Harmful Ice.asm"
	include "code/objects/ICZ/Snow Pile.asm"
	include "code/objects/ICZ/Tension Platform.asm"

	include "code/badnik/ICZ/Penguinator.asm"
	include "code/badnik/ICZ/Star Pointer.asm"

	include "code/badnik/LBZ/Snale Blaster.asm"
	include "code/badnik/LBZ/Ribot.asm"
	include "code/badnik/LBZ/Orbinaut.asm"
	include "code/badnik/LBZ/Corkey.asm"
	include "code/badnik/LBZ/Flybot 767.asm"
	include "code/badnik/LBZ/Robotnik.asm"

	include "code/badnik/MHZ/Madmole.asm"
	include "code/badnik/MHZ/Mushmeanie.asm"
	include "code/badnik/MHZ/Dragonfly.asm"
	include "code/badnik/MHZ/Butterdroid.asm"
	include "code/badnik/MHZ/Cluckoid.asm"

	include "code/badnik/SOZ/Skorp.asm"
	include "code/badnik/SOZ/Sandworm.asm"
	include "code/badnik/SOZ/Rock'n.asm"
	include "code/badnik/SOZ/Ghosts.asm"

	include "code/badnik/LRZ/Fireworm.asm"
	include "code/badnik/LRZ/Iwamodoki.asm"
	include "code/badnik/LRZ/Toxomister.asm"
	include "code/badnik/LRZ/Rock Crusher.asm"

	include "code/badnik/HPZ/Objects.asm"

	include "code/badnik/SSZ/Egg Robo.asm"

	include "code/badnik/DEZ/Spikebonker.asm"
	include "code/badnik/DEZ/Chainspike.asm"
