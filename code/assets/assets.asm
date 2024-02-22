AngleArray:
		binclude "Levels/Misc/angles.bin"
		even
HeightMaps:
		binclude "Levels/Misc/Height Maps.bin"
		even
HeightMapsRot:
		binclude "Levels/Misc/Height Maps Rotated.bin"
		even

	if Sonic3_Complete=0
Noninterleaved_Solid_Flag EQU 0
	else
Noninterleaved_Solid_Flag EQU (1<<31)
	endif

SolidIndexes:
		dc.l Solid_AIZ1+1+Noninterleaved_Solid_Flag
		dc.l Solid_AIZ2+1+Noninterleaved_Solid_Flag
		dc.l Solid_HCZ1+1+Noninterleaved_Solid_Flag
		dc.l Solid_HCZ2+1+Noninterleaved_Solid_Flag
		dc.l Solid_MGZ1+1+Noninterleaved_Solid_Flag
		dc.l Solid_MGZ2+1+Noninterleaved_Solid_Flag
		dc.l Solid_CNZ+1+Noninterleaved_Solid_Flag
		dc.l Solid_CNZ+1+Noninterleaved_Solid_Flag
		dc.l Solid_FBZ
		dc.l Solid_FBZ
		dc.l Solid_ICZ1+1+Noninterleaved_Solid_Flag
		dc.l Solid_ICZ2+1+Noninterleaved_Solid_Flag
		dc.l Solid_LBZ1+1+Noninterleaved_Solid_Flag
		dc.l Solid_LBZ2+1+Noninterleaved_Solid_Flag
		dc.l Solid_MHZ
		dc.l Solid_MHZ
		dc.l Solid_SOZ
		dc.l Solid_SOZ
		dc.l Solid_LRZ1
		dc.l Solid_LRZ2
		dc.l Solid_SSZ1
		dc.l Solid_SSZ2
		dc.l Solid_DEZ
		dc.l Solid_DEZ
		dc.l Solid_DDZ
		dc.l Solid_DDZ
		dc.l Solid_Pachinko_Special
		dc.l Solid_Pachinko_Special
		dc.l Solid_ALZ+1+Noninterleaved_Solid_Flag
		dc.l Solid_ALZ+1+Noninterleaved_Solid_Flag
		dc.l Solid_BPZ+1+Noninterleaved_Solid_Flag
		dc.l Solid_BPZ+1+Noninterleaved_Solid_Flag
		dc.l Solid_DPZ+1+Noninterleaved_Solid_Flag
		dc.l Solid_DPZ+1+Noninterleaved_Solid_Flag
		dc.l Solid_CGZ+1+Noninterleaved_Solid_Flag
		dc.l Solid_CGZ+1+Noninterleaved_Solid_Flag
		dc.l Solid_EMZ+1+Noninterleaved_Solid_Flag
		dc.l Solid_EMZ+1+Noninterleaved_Solid_Flag
		dc.l Solid_Gumball_Special+1+Noninterleaved_Solid_Flag
		dc.l Solid_Gumball_Special+1+Noninterleaved_Solid_Flag
		dc.l Solid_Pachinko_Special
		dc.l Solid_Pachinko_Special
		dc.l Solid_Slots_Special
		dc.l Solid_Slots_Special
		dc.l Solid_LRZBoss
		dc.l Solid_HPZ
		dc.l Solid_HPZ
		dc.l Solid_HPZ
Solid_FBZ:
		binclude "Levels/FBZ/Collision/1.bin"
		even
Solid_MHZ:
		binclude "Levels/MHZ/Collision/1.bin"
		even
Solid_Unknown:
		binclude "Levels/Misc/Unknown Collision.bin"
		even
Solid_SOZ:
		binclude "Levels/SOZ/Collision/1.bin"
		even
Solid_LRZ1:
		binclude "Levels/LRZ/Collision/1.bin"
		even
Solid_LRZ2:
		binclude "Levels/LRZ/Collision/2.bin"
		even
Solid_SSZ1:
		binclude "Levels/SSZ/Collision/1.bin"
		even
Solid_SSZ2:
		binclude "Levels/SSZ/Collision/2.bin"
		even
Solid_DEZ:
		binclude "Levels/DEZ/Collision/1.bin"
		even
Solid_DDZ:
		binclude "Levels/DDZ/Collision/1.bin"
		even
Solid_Pachinko_Special:
		binclude "Levels/Pachinko/Collision/1.bin"
		even
Solid_Slots_Special:
		binclude "Levels/Slots/Collision/1.bin"
		even

Solid_LRZBoss:
		binclude "Levels/LRZ/Collision/3.bin"
		even
Solid_HPZ:
		binclude "Levels/HPZ/Collision/1.bin"
		even
LevelPtrs:
		dc.l Layout_AIZ1
		dc.l Layout_AIZ2
		dc.l Layout_HCZ1
		dc.l Layout_HCZ2
		dc.l Layout_MGZ1
		dc.l Layout_MGZ2
		dc.l Layout_CNZ1
		dc.l Layout_CNZ2
		dc.l Layout_FBZ1
		dc.l Layout_FBZ2
		dc.l Layout_ICZ1
		dc.l Layout_ICZ2
		dc.l Layout_LBZ1
		dc.l Layout_LBZ2
		dc.l Layout_MHZ1
		dc.l Layout_MHZ2
		dc.l Layout_SOZ1
		dc.l Layout_SOZ2
		dc.l Layout_LRZ1
		dc.l Layout_LRZ2
		dc.l Layout_SSZ1
		dc.l Layout_SSZ2
		dc.l Layout_DEZ1
		dc.l Layout_DEZ2
		dc.l Layout_DDZ
		dc.l Layout_DDZ
		dc.l Layout_SSZ2
		dc.l Layout_SSZ2
		dc.l Layout_ALZ
		dc.l Layout_ALZ
		dc.l Layout_BPZ
		dc.l Layout_BPZ
		dc.l Layout_DPZ
		dc.l Layout_DPZ
		dc.l Layout_CGZ
		dc.l Layout_CGZ
		dc.l Layout_EMZ
		dc.l Layout_EMZ
		dc.l Layout_Gumball_Special
		dc.l Layout_Gumball_Special
		dc.l Layout_Pachinko_Special
		dc.l Layout_Pachinko_Special
		dc.l Layout_Slots_Special
		dc.l Layout_Slots_Special
		dc.l Layout_LRZBoss
		dc.l Layout_HPZ
		dc.l Layout_DEZBoss
		dc.l Layout_HPZ
Layout_FBZ1:
		binclude "Levels/FBZ/Layout/1.bin"
		even
Layout_FBZ2:
		binclude "Levels/FBZ/Layout/2.bin"
		even
Layout_MHZ1:
		binclude "Levels/MHZ/Layout/1.bin"
		even
Layout_MHZ2:
		binclude "Levels/MHZ/Layout/2.bin"
		even
Layout_SOZ1:
		binclude "Levels/SOZ/Layout/1.bin"
		even
Layout_SOZ2:
		binclude "Levels/SOZ/Layout/2.bin"
		even
Layout_LRZ1:
		binclude "Levels/LRZ/Layout/1.bin"
		even
Layout_LRZ2:
		binclude "Levels/LRZ/Layout/2.bin"
		even
Layout_SSZ1:
		binclude "Levels/SSZ/Layout/1.bin"
		even
Layout_SSZ2:
		binclude "Levels/SSZ/Layout/2.bin"
		even
Layout_DEZ1:
		binclude "Levels/DEZ/Layout/1.bin"
		even
Layout_DEZ2:
		binclude "Levels/DEZ/Layout/2.bin"
		even
Layout_DDZ:
		binclude "Levels/DDZ/Layout/1.bin"
		even
Layout_Pachinko_Special:
		binclude "Levels/Pachinko/Layout/1.bin"
		even
Layout_Slots_Special:
		binclude "Levels/Slots/Layout/1.bin"
		even

Layout_LRZBoss:
		binclude "Levels/LRZ/Layout/3.bin"
		even
Layout_HPZ:
		binclude "Levels/HPZ/Layout/1.bin"
		even
Layout_DEZBoss:
		binclude "Levels/DEZ/Layout/3.bin"
		even
MHZ_Custom_Layout:
		binclude "Levels/MHZ/Layout/3.bin"
		even
PalPoint:
		include "Levels/Misc/Palette pointers.asm"

Pal_S2Sega:
		binclude "General/S2Menu/Palettes/Sega Screen.bin"
		even
Pal_S2Title:
		binclude "General/S2Menu/Palettes/Title Screen SK.bin"
		even
Pal_S2LevSel:
		binclude "General/S2Menu/Palettes/Proto Level Select SK.bin"
		even
Pal_SonicTails:
		binclude "General/Sprites/Sonic/Palettes/SonicAndTails.bin"
		even
Pal_S2Menu:
		binclude "General/S2Menu/Palettes/Main.bin"
		even
Pal_Knuckles:
		binclude "General/Sprites/Knuckles/Palettes/Main.bin"
		even
Pal_AIZIntro:
		binclude "Levels/AIZ/Palettes/Intro.bin"
		even
Pal_AIZ:
		binclude "Levels/AIZ/Palettes/Main.bin"
		even
Pal_AIZFire:
		binclude "Levels/AIZ/Palettes/Fire.bin"
		even
Pal_AIZBoss:
		binclude "Levels/AIZ/Palettes/Boss.bin"
		even
Pal_AIZ_Water:
		binclude "Levels/AIZ/Palettes/Water.bin"
		even
Pal_AIZ2_Water:
		binclude "Levels/AIZ/Palettes/Act 2 Water.bin"
		even
Pal_HCZ1:
		binclude "Levels/HCZ/Palettes/1.bin"
		even
Pal_HCZ2:
		binclude "Levels/HCZ/Palettes/2.bin"
		even
Pal_HCZ1_Water:
		binclude "Levels/HCZ/Palettes/Act 1 Water.bin"
		even
Pal_HCZ2_Water:
		binclude "Levels/HCZ/Palettes/Act 2 Water.bin"
		even
Pal_MGZ:
		binclude "Levels/MGZ/Palettes/Main.bin"
		even
Pal_CNZ:
		binclude "Levels/CNZ/Palettes/Main.bin"
		even
Pal_CNZ_Water:
		binclude "Levels/CNZ/Palettes/Water.bin"
		even
Pal_FBZ1:
		binclude "Levels/FBZ/Palettes/FBZ1.bin"
		even
Pal_FBZ2:
		binclude "Levels/FBZ/Palettes/FBZ2.bin"
		even
Pal_ICZ1:
		binclude "Levels/ICZ/Palettes/1.bin"
		even
Pal_ICZ2:
		binclude "Levels/ICZ/Palettes/2.bin"
		even
Pal_ICZ2_Water:
		binclude "Levels/ICZ/Palettes/Act 2 Water.bin"
		even
Pal_LBZ1:
		binclude "Levels/LBZ/Palettes/1.bin"
		even
Pal_LBZ2:
		binclude "Levels/LBZ/Palettes/2.bin"
		even
Pal_LBZ_Water:
		binclude "Levels/LBZ/Palettes/Act 2 Water.bin"
		even
Pal_LBZ_Water2:
		binclude "Levels/LBZ/Palettes/Act 2 Water 2.bin"
		even
Pal_MHZ1:
		binclude "Levels/MHZ/Palettes/1.bin"
		even
Pal_MHZ2:
		binclude "Levels/MHZ/Palettes/2.bin"
		even
Pal_SOZ1:
		binclude "Levels/SOZ/Palettes/1.bin"
		even
Pal_S0Z2:
		binclude "Levels/SOZ/Palettes/2.bin"
		even
Pal_SOZ1_Clone:
		binclude "Levels/SOZ/Palettes/Act 1 Clone.bin"
		even
Pal_SOZ2_Extra:
		binclude "Levels/SOZ/Palettes/Act 2 Extra.bin"
		even
Pal_LRZ1:
		binclude "Levels/LRZ/Palettes/1.bin"
		even
Pal_LRZ2:
		binclude "Levels/LRZ/Palettes/2.bin"
		even
Pal_SSZ1:
		binclude "Levels/SSZ/Palettes/1.bin"
		even
Pal_SSZ2:
		binclude "Levels/SSZ/Palettes/2.bin"
		even
Pal_Ending1:
		binclude "General/Ending/Palettes/Ending 1.bin"
		even
Pal_Ending2:
		binclude "General/Ending/Palettes/Ending 2.bin"
		even
Pal_DEZ1:
		binclude "Levels/DEZ/Palettes/1.bin"
		even
Pal_DEZ2:
		binclude "Levels/DEZ/Palettes/2.bin"
		even
Pal_DDZ:
		binclude "Levels/DDZ/Palettes/Main.bin"
		even
Pal_ALZ:
		binclude "Levels/ALZ/Palettes/Main.bin"
		even
Pal_BPZ:
		binclude "Levels/BPZ/Palettes/Main.bin"
		even
Pal_DPZ:
		binclude "Levels/DPZ/Palettes/Main.bin"
		even
Pal_CGZ:
		binclude "Levels/CGZ/Palettes/Main.bin"
		even
Pal_EMZ:
		binclude "Levels/EMZ/Palettes/Main.bin"
		even
Pal_Gumball_Special:
		binclude "Levels/Gumball/Palettes/Main.bin"
		even
Pal_Pachinko_Special:
		binclude "Levels/Pachinko/Palettes/Main.bin"
		even
Pal_Slot_Special:
		binclude "Levels/Slots/Palettes/Main.bin"
		even

Pal_LRZBoss:
		binclude "Levels/LRZ/Palettes/Boss Act.bin"
		even
Pal_HPZIntro:
		binclude "Levels/HPZ/Palettes/Intro.bin"
		even
Pal_DEZBoss:
		binclude "Levels/DEZ/Palettes/Boss.bin"
		even
ArtUnc_AirCountdown:
		binclude "General/Sprites/Dash Dust/Air Countdown.bin"
		even
ArtUnc_SONICMILES:
		binclude "General/S2Menu/Uncompressed Art/SONICMILES.bin"
		even
ArtUnc_SStageSonic:
		binclude "General/Sprites/Sonic/Art/SStage Sonic.bin"
		even
Map_SStageSonic:
		include "General/Sprites/Sonic/Map - SStage Sonic.asm"

ArtUnc_SStageKnuckles:
		binclude "General/Sprites/Knuckles/Art/SStage Knuckles.bin"
		even
Map_SStageKnuckles:
		include "General/Sprites/Knuckles/Map - SStage Knuckles.asm"

ArtNem_SStageShadow:
		binclude "General/Special Stage/Nemesis Art/Shadow.bin"
		even
ArtNem_GetBlueSpheres:
		binclude "General/Special Stage/Nemesis Art/Get Blue Spheres.bin"
		even
ArtNem_GBSArrow:
		binclude "General/Special Stage/Nemesis Art/Get Blue Spheres Arrow.bin"
		even
ArtNem_SStageDigits:
		binclude "General/Special Stage/Nemesis Art/Digits.bin"
		even
ArtNem_SStageIcons:
		binclude "General/Special Stage/Nemesis Art/Icons.bin"
		even
ArtNem_SStageSphere:
		binclude "General/Special Stage/Nemesis Art/Sphere.bin"
		even
ArtNem_SStageRing:
		binclude "General/Special Stage/Nemesis Art/Ring.bin"
		even
ArtKosM_SStageChaosEmerald:
		binclude "General/Special Stage/KosinskiM Art/Special Stage Chaos Emerald.bin"
		even
ArtKosM_SStageSuperEmerald:
		binclude "General/Special Stage/KosinskiM Art/Special Stage Super Emerald.bin"
		even
MapEni_SStageBG:
		binclude "General/Special Stage/Enigma Map/BG.bin"
		even
ArtNem_SStageBG:
		binclude "General/Special Stage/Nemesis Art/BG.bin"
		even
MapEni_SStageLayout:
		binclude "General/Special Stage/Enigma Map/Layout.bin"
		even
ArtNem_SStageLayout:
		binclude "General/Special Stage/Nemesis Art/Layout.bin"
		even
SStageKos_PerspectiveMaps:
		binclude "General/Special Stage/Layout/Perspective Maps.bin"
		even
