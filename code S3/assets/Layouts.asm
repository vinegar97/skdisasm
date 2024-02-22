Start_Locations:
		binclude "Levels/AIZ/Start Location/Sonic/1.bin"
		binclude "Levels/AIZ/Start Location/Sonic/2.bin"
		binclude "Levels/HCZ/Start Location/Sonic/1.bin"
		binclude "Levels/HCZ/Start Location/Sonic/2.bin"
		binclude "Levels/MGZ/Start Location/Sonic/1.bin"
		binclude "Levels/MGZ/Start Location/Sonic/2.bin"
		binclude "Levels/CNZ/Start Location/Sonic/1.bin"
		binclude "Levels/CNZ/Start Location/Sonic/2.bin"
		dc.w    $60,  $6EC
		dc.w    $60,  $5EC
		binclude "Levels/ICZ/Start Location/Sonic/1.bin"
		binclude "Levels/ICZ/Start Location/Sonic/2.bin"
		binclude "Levels/LBZ/Start Location/Sonic/1.bin"
		binclude "Levels/LBZ/Start Location/Sonic/2.bin"
		dc.w    $80,  $6AA
		dc.w    $80,  $3AA
		dc.w   $230,  $1AC
		dc.w   $230,  $1AC
		dc.w   $100,   $20
		dc.w   $100,   $20
		dc.w    $60,  $6AC
		dc.w    $60,  $56C
		dc.w    $60,  $6AC
		dc.w    $60,  $5AC
		dc.w    $60,  $2AC
		dc.w    $60,  $58C
		dc.w    $60,  $1EC
		dc.w    $60,  $12C
		binclude "Levels/ALZ/Start Location/Sonic/1.bin"
		binclude "Levels/ALZ/Start Location/Sonic/2.bin"
		binclude "Levels/BPZ/Start Location/Sonic/1.bin"
		binclude "Levels/BPZ/Start Location/Sonic/2.bin"
		binclude "Levels/DPZ/Start Location/Sonic/1.bin"
		binclude "Levels/DPZ/Start Location/Sonic/2.bin"
		binclude "Levels/CGZ/Start Location/Sonic/1.bin"
		binclude "Levels/CGZ/Start Location/Sonic/2.bin"
		binclude "Levels/EMZ/Start Location/Sonic/1.bin"
		binclude "Levels/EMZ/Start Location/Sonic/2.bin"
		binclude "Levels/Gumball/Start Location/Sonic/1.bin"
		binclude "Levels/Gumball/Start Location/Sonic/2.bin"
		dc.w    $60,   $70
		dc.w    $60,   $70
		dc.w    $60,   $70
		dc.w    $60,   $70
		dc.w    $60,   $70
		dc.w    $60,   $70
		dc.w    $60,   $70
		dc.w    $60,   $70
SpriteLocPtrs:
		dc.l AIZ1_Sprites
		dc.l AIZ2_Sprites
		dc.l HCZ1_Sprites
		dc.l HCZ2_Sprites
		dc.l MGZ1_Sprites
		dc.l MGZ2_Sprites
		dc.l CNZ1_Sprites
		dc.l CNZ2_Sprites
		dc.l FBZ1_Sprites
		dc.l FBZ2_Sprites
		dc.l ICZ1_Sprites
		dc.l ICZ2_Sprites
		dc.l LBZ1_Sprites
		dc.l LBZ2_Sprites
		dc.l MHZ1_Sprites
		dc.l MHZ2_Sprites
		dc.l SOZ1_Sprites
		dc.l SOZ2_Sprites
		dc.l LRZ1_Sprites
		dc.l LRZ2_Sprites
		dc.l SSZ1_Sprites
		dc.l SSZ2_Sprites
		dc.l DEZ1_Sprites
		dc.l DEZ2_Sprites
		dc.l DDZ1_Sprites
		dc.l DDZ2_Sprites
		dc.l Ending1_Sprites
		dc.l Ending2_Sprites
		dc.l ALZ1_Sprites
		dc.l ALZ2_Sprites
		dc.l BPZ1_Sprites
		dc.l BPZ2_Sprites
		dc.l DPZ1_Sprites
		dc.l DPZ2_Sprites
		dc.l CGZ1_Sprites
		dc.l CGZ2_Sprites
		dc.l EMZ1_Sprites
		dc.l EMZ2_Sprites
		dc.l Gumball1_Sprites
		dc.l Gumball2_Sprites
		dc.l Pachinko1_Sprites
		dc.l Pachinko2_Sprites
		dc.l Slots1_Sprites
		dc.l Slots2_Sprites
		dc.l LRZ3_Sprites
		dc.l HPZ_Sprites
		dc.l DEZ3_Sprites
		dc.l HPZMini_Sprites
RingLocPtrs:
		dc.l AIZ1_Rings
		dc.l AIZ2_Rings
		dc.l HCZ1_Rings
		dc.l HCZ2_Rings
		dc.l MGZ1_Rings
		dc.l MGZ2_Rings
		dc.l CNZ1_Rings
		dc.l CNZ2_Rings
		dc.l FBZ1_Rings
		dc.l FBZ2_Rings
		dc.l ICZ1_Rings
		dc.l ICZ2_Rings
		dc.l LBZ1_Rings
		dc.l LBZ2_Rings
		dc.l MHZ1_Rings
		dc.l MHZ2_Rings
		dc.l SOZ1_Rings
		dc.l SOZ2_Rings
		dc.l LRZ1_Rings
		dc.l LRZ2_Rings
		dc.l SSZ1_Rings
		dc.l SSZ2_Rings
		dc.l DEZ1_Rings
		dc.l DEZ2_Rings
		dc.l DDZ1_Rings
		dc.l DDZ2_Rings
		dc.l Ending1_Rings
		dc.l Ending2_Rings
		dc.l ALZ1_Rings
		dc.l ALZ2_Rings
		dc.l BPZ1_Rings
		dc.l BPZ2_Rings
		dc.l DPZ1_Rings
		dc.l DPZ2_Rings
		dc.l CGZ1_Rings
		dc.l CGZ2_Rings
		dc.l EMZ1_Rings
		dc.l EMZ2_Rings
		dc.l Gumball1_Rings
		dc.l Gumball2_Rings
		dc.l Pachinko1_Rings
		dc.l Pachinko2_Rings
		dc.l Slots1_Rings
		dc.l Slots2_Rings
		dc.l LRZ3_Rings
		dc.l HPZ_Rings
		dc.l DEZ3_Rings
		dc.l HPZMini_Rings
AutoTunnel_Data:
		dc.l AutoTunnel_00
		dc.l AutoTunnel_01_02
		dc.l AutoTunnel_01_02
		dc.l AutoTunnel_03
		dc.l AutoTunnel_04
		dc.l AutoTunnel_05
		dc.l AutoTunnel_06
		dc.l AutoTunnel_07
		dc.l AutoTunnel_08
		dc.l AutoTunnel_09
		dc.l AutoTunnel_0A
		dc.l AutoTunnel_0B
		dc.l AutoTunnel_0C
		dc.l AutoTunnel_0D
		dc.l AutoTunnel_0E
		dc.l AutoTunnel_0F
		dc.l AutoTunnel_10
		dc.l AutoTunnel_11
		dc.l AutoTunnel_12
		dc.l AutoTunnel_13
		dc.l AutoTunnel_14
		dc.l SpriteTerminat9
		dc.l SpriteTerminat9
		dc.l SpriteTerminat9
		dc.l SpriteTerminat9
		dc.l SpriteTerminat9
		dc.l SpriteTerminat9
		dc.l SpriteTerminat9
		dc.l SpriteTerminat9
		dc.l SpriteTerminat9
		dc.l SpriteTerminat9
		dc.l SpriteTerminat9
SStageLayoutPtrs:
		dc.l SStage1_Layout
		dc.l SStage2_Layout
		dc.l SStage3_Layout
		dc.l SStage4_Layout
		dc.l SStage5_Layout
		dc.l SStage6_Layout
		dc.l SStage7_Layout
		dc.l SStage8_Layout
SpriteTerminat1:
		dc.w  $FFFF,     0,     0
AIZ1_Sprites:
		binclude "Levels/AIZ/Object Pos/1-S3.bin"
		even
AIZ2_Sprites:
		binclude "Levels/AIZ/Object Pos/2-S3.bin"
		even
AIZ1_Rings:
		binclude "Levels/AIZ/Ring Pos/1-S3.bin"
		even
AIZ2_Rings:
		binclude "Levels/AIZ/Ring Pos/2-S3.bin"
		even
SpriteTerminat2:
		dc.w  $FFFF,     0,     0
HCZ1_Sprites:
		binclude "Levels/HCZ/Object Pos/1-S3.bin"
		even
HCZ2_Sprites:
		binclude "Levels/HCZ/Object Pos/2-S3.bin"
		even
HCZ1_Rings:
		binclude "Levels/HCZ/Ring Pos/1-S3.bin"
		even
HCZ2_Rings:
		binclude "Levels/HCZ/Ring Pos/2-S3.bin"
		even
SpriteTerminat3:
		dc.w  $FFFF,     0,     0
MGZ1_Sprites:
		binclude "Levels/MGZ/Object Pos/1-S3.bin"
		even
MGZ1_Rings:
		binclude "Levels/MGZ/Ring Pos/1-S3.bin"
		even
SpriteTerminat4:
		dc.w  $FFFF,     0,     0
MGZ2_Sprites:
		binclude "Levels/MGZ/Object Pos/2-S3.bin"
		even
MGZ2_Rings:
		binclude "Levels/MGZ/Ring Pos/2-S3.bin"
		even
SpriteTerminat5:
		dc.w  $FFFF,     0,     0
CNZ1_Sprites:
		binclude "Levels/CNZ/Object Pos/1-S3.bin"
		even
CNZ2_Sprites:
		binclude "Levels/CNZ/Object Pos/2-S3.bin"
		even
CNZ1_Rings:
		binclude "Levels/CNZ/Ring Pos/1-S3.bin"
		even
CNZ2_Rings:
		binclude "Levels/CNZ/Ring Pos/2-S3.bin"
		even
SpriteTerminat6:
		dc.w  $FFFF,     0,     0
FBZ1_Sprites:
		binclude "Levels/FBZ/Object Pos/1-S3.bin"
		even
FBZ2_Sprites:
		binclude "Levels/FBZ/Object Pos/2-S3.bin"
		even
FBZ1_Rings:
		binclude "Levels/FBZ/Ring Pos/1-S3.bin"
		even
FBZ2_Rings:
		binclude "Levels/FBZ/Ring Pos/2-S3.bin"
		even
SpriteTerminat7:
		dc.w  $FFFF,     0,     0
ICZ1_Sprites:
		binclude "Levels/ICZ/Object Pos/1-S3.bin"
		even
ICZ2_Sprites:
		binclude "Levels/ICZ/Object Pos/2-S3.bin"
		even
ICZ1_Rings:
		binclude "Levels/ICZ/Ring Pos/1-S3.bin"
		even
ICZ2_Rings:
		binclude "Levels/ICZ/Ring Pos/2-S3.bin"
		even
SpriteTerminat8:
		dc.w  $FFFF,     0,     0
LBZ1_Sprites:
		binclude "Levels/LBZ/Object Pos/1-S3.bin"
		even
LBZ2_Sprites:
		binclude "Levels/LBZ/Object Pos/2-S3.bin"
		even
LBZ1_Rings:
		binclude "Levels/LBZ/Ring Pos/1-S3.bin"
		even
LBZ2_Rings:
		binclude "Levels/LBZ/Ring Pos/2-S3.bin"
		even
AutoTunnel_00:
		dc.w $C
		dc.w   $F60,  $578
		dc.w   $F60,  $548
		dc.w   $F60,  $378
AutoTunnel_01_02:
		dc.w $38
		dc.w   $D40,  $770
		dc.w   $D48,  $770
		dc.w   $D50,  $770
		dc.w   $D58,  $770
		dc.w   $D60,  $770
		dc.w   $DB0,  $770
		dc.w   $DD0,  $77C
		dc.w   $DE0,  $79C
		dc.w   $DD6,  $7BC
		dc.w   $DB6,  $7CE
		dc.w   $D96,  $7CE
		dc.w   $D86,  $7C8
		dc.w   $D70,  $7A8
		dc.w   $D70,  $688
AutoTunnel_03:
		dc.w $28
		dc.w   $D30,  $770
		dc.w   $DB0,  $770
		dc.w   $DD0,  $77C
		dc.w   $DE0,  $79C
		dc.w   $DD6,  $7BC
		dc.w   $DB6,  $7CE
		dc.w   $D96,  $7CE
		dc.w   $D86,  $7C8
		dc.w   $D70,  $7A8
		dc.w   $D70,  $748
AutoTunnel_04:
		dc.w $38
		dc.w  $2CC0,  $9F0
		dc.w  $2CC8,  $9F0
		dc.w  $2CD0,  $9F0
		dc.w  $2CD8,  $9F0
		dc.w  $2CE0,  $9F0
		dc.w  $2D30,  $9F0
		dc.w  $2D50,  $9FC
		dc.w  $2D60,  $A1C
		dc.w  $2D56,  $A3C
		dc.w  $2D36,  $A4E
		dc.w  $2D16,  $A4E
		dc.w  $2D06,  $A48
		dc.w  $2CF0,  $A28
		dc.w  $2CF0,  $908
AutoTunnel_05:
		dc.w $28
		dc.w  $2CB0,  $9F0
		dc.w  $2D30,  $9F0
		dc.w  $2D50,  $9FC
		dc.w  $2D60,  $A1C
		dc.w  $2D56,  $A3C
		dc.w  $2D36,  $A4E
		dc.w  $2D16,  $A4E
		dc.w  $2D06,  $A48
		dc.w  $2CF0,  $A28
		dc.w  $2CF0,  $9C8
AutoTunnel_06:
		dc.w $38
		dc.w  $3640,  $A70
		dc.w  $3648,  $A70
		dc.w  $3650,  $A70
		dc.w  $3658,  $A70
		dc.w  $3660,  $A70
		dc.w  $36B0,  $A70
		dc.w  $36D0,  $A7C
		dc.w  $36E0,  $A9C
		dc.w  $36D6,  $ABC
		dc.w  $36B6,  $ACE
		dc.w  $3696,  $ACE
		dc.w  $3686,  $AC8
		dc.w  $3670,  $AA8
		dc.w  $3670,  $988
AutoTunnel_07:
		dc.w $28
		dc.w  $3630,  $A70
		dc.w  $36B0,  $A70
		dc.w  $36D0,  $A7C
		dc.w  $36E0,  $A9C
		dc.w  $36D6,  $ABC
		dc.w  $36B6,  $ACE
		dc.w  $3696,  $ACE
		dc.w  $3686,  $AC8
		dc.w  $3670,  $AA8
		dc.w  $3670,  $A48
AutoTunnel_08:
		dc.w $38
		dc.w  $37C0,  $7F0
		dc.w  $37C8,  $7F0
		dc.w  $37D0,  $7F0
		dc.w  $37D8,  $7F0
		dc.w  $37E0,  $7F0
		dc.w  $3830,  $7F0
		dc.w  $3850,  $7FC
		dc.w  $3860,  $81C
		dc.w  $3856,  $83C
		dc.w  $3836,  $84E
		dc.w  $3816,  $84E
		dc.w  $3806,  $848
		dc.w  $37F0,  $828
		dc.w  $37F0,  $708
AutoTunnel_09:
		dc.w $28
		dc.w  $37B0,  $7F0
		dc.w  $3830,  $7F0
		dc.w  $3850,  $7FC
		dc.w  $3860,  $81C
		dc.w  $3856,  $83C
		dc.w  $3836,  $84E
		dc.w  $3816,  $84E
		dc.w  $3806,  $848
		dc.w  $37F0,  $828
		dc.w  $37F0,  $7C8
AutoTunnel_0A:
		dc.w $38
		dc.w  $29C0,  $470
		dc.w  $29C8,  $470
		dc.w  $29D0,  $470
		dc.w  $29D8,  $470
		dc.w  $29E0,  $470
		dc.w  $2A30,  $470
		dc.w  $2A50,  $47C
		dc.w  $2A60,  $49C
		dc.w  $2A56,  $4BC
		dc.w  $2A36,  $4CE
		dc.w  $2A16,  $4CE
		dc.w  $2A06,  $4C8
		dc.w  $29F0,  $4A8
		dc.w  $29F0,  $388
AutoTunnel_0B:
		dc.w $28
		dc.w  $29B0,  $470
		dc.w  $2A30,  $470
		dc.w  $2A50,  $47C
		dc.w  $2A60,  $49C
		dc.w  $2A56,  $4BC
		dc.w  $2A36,  $4CE
		dc.w  $2A16,  $4CE
		dc.w  $2A06,  $4C8
		dc.w  $29F0,  $4A8
		dc.w  $29F0,  $448
AutoTunnel_0C:
		dc.w $104
		dc.w  $26C0,  $530
		dc.w  $26C0,  $6E0
		dc.w  $26B2,  $700
		dc.w  $2692,  $710
		dc.w  $25F2,  $710
		dc.w  $25D2,  $704
		dc.w  $25C0,  $6E4
		dc.w  $25C0,  $4B4
		dc.w  $25B0,  $484
		dc.w  $2590,  $464
		dc.w  $2560,  $450
		dc.w  $24D0,  $450
		dc.w  $2490,  $43B
		dc.w  $2450,  $41F
		dc.w  $2400,  $410
		dc.w  $2300,  $410
		dc.w  $22D0,  $415
		dc.w  $22A0,  $42B
		dc.w  $2280,  $448
		dc.w  $2240,  $468
		dc.w  $2200,  $470
		dc.w  $21C0,  $468
		dc.w  $2180,  $448
		dc.w  $2160,  $42B
		dc.w  $2130,  $415
		dc.w  $2100,  $410
		dc.w  $20D0,  $415
		dc.w  $20A0,  $42B
		dc.w  $2080,  $448
		dc.w  $2040,  $468
		dc.w  $2000,  $470
		dc.w  $1FC0,  $468
		dc.w  $1F80,  $448
		dc.w  $1F60,  $42B
		dc.w  $1F30,  $415
		dc.w  $1F00,  $410
		dc.w  $1ED0,  $415
		dc.w  $1EA0,  $42B
		dc.w  $1E80,  $448
		dc.w  $1E40,  $468
		dc.w  $1E00,  $470
		dc.w  $1C70,  $470
		dc.w  $1C40,  $440
		dc.w  $1C40,  $320
		dc.w  $1C50,  $300
		dc.w  $1C70,  $2F0
		dc.w  $1F80,  $2F0
		dc.w  $1FD0,  $2E4
		dc.w  $2000,  $2C8
		dc.w  $2020,  $2AB
		dc.w  $2040,  $29A
		dc.w  $2080,  $290
		dc.w  $20C0,  $2A7
		dc.w  $2170,  $357
		dc.w  $21B0,  $370
		dc.w  $2400,  $370
		dc.w  $2440,  $380
		dc.w  $2480,  $390
		dc.w  $24B0,  $384
		dc.w  $24C0,  $364
		dc.w  $24C0,   $C4
		dc.w  $2490,   $90
		dc.w  $2450,   $9C
		dc.w  $2440,   $CC
		dc.w  $2440,   $FC
AutoTunnel_0D:
		dc.w $64
		dc.w  $33C0,  $130
		dc.w  $33C0,  $1E0
		dc.w  $33D0,  $200
		dc.w  $3400,  $210
		dc.w  $3450,  $220
		dc.w  $34A0,  $270
		dc.w  $34C0,  $2A0
		dc.w  $34C0,  $460
		dc.w  $34CE,  $480
		dc.w  $34F0,  $490
		dc.w  $3710,  $490
		dc.w  $372E,  $480
		dc.w  $3740,  $460
		dc.w  $3740,  $330
		dc.w  $3720,  $310
		dc.w  $35F0,  $310
		dc.w  $35CE,  $300
		dc.w  $35C0,  $2E0
		dc.w  $35C0,   $40
		dc.w  $35CC,   $20
		dc.w  $3600,   $10
		dc.w  $3690,   $10
		dc.w  $36B4,   $20
		dc.w  $36C0,   $40
		dc.w  $36C0,   $80
AutoTunnel_0E:
		dc.w $38
		dc.w  $14C0,  $AB0
		dc.w  $14C0,  $B60
		dc.w  $14D0,  $B80
		dc.w  $14F0,  $B90
		dc.w  $1610,  $B90
		dc.w  $1630,  $B80
		dc.w  $1640,  $B60
		dc.w  $1640,  $8C0
		dc.w  $1650,  $8A0
		dc.w  $1670,  $890
		dc.w  $1890,  $890
		dc.w  $18B0,  $89C
		dc.w  $18C0,  $8BC
		dc.w  $18C0,  $8FC
AutoTunnel_0F:
		dc.w $38
		dc.w  $3840,  $730
		dc.w  $3840,  $860
		dc.w  $3832,  $880
		dc.w  $3802,  $890
		dc.w  $37D2,  $884
		dc.w  $37C0,  $864
		dc.w  $37C0,  $3D4
		dc.w  $37D0,  $3B4
		dc.w  $37F0,  $39C
		dc.w  $3820,  $390
		dc.w  $3990,  $390
		dc.w  $39B0,  $39C
		dc.w  $39C0,  $3BC
		dc.w  $39C0,  $3FC
AutoTunnel_10:
		dc.w $7C
		dc.w   $F60,  $5C8
		dc.w   $F60,  $950
		dc.w   $F64,  $980
		dc.w   $F68,  $990
		dc.w   $F73,  $9B0
		dc.w   $F82,  $9D0
		dc.w   $F8C,  $9E0
		dc.w   $F98,  $9F0
		dc.w   $FA5,  $A00
		dc.w   $FB5,  $A10
		dc.w   $FC5,  $A1C
		dc.w   $FD5,  $A28
		dc.w   $FF5,  $A38
		dc.w  $1005,  $A40
		dc.w  $1025,  $A4A
		dc.w  $1035,  $A4C
		dc.w  $1055,  $A50
		dc.w  $1265,  $A50
		dc.w  $12A5,  $A48
		dc.w  $12C5,  $A3C
		dc.w  $12E5,  $A2C
		dc.w  $12F5,  $A20
		dc.w  $1305,  $A14
		dc.w  $1315,  $A08
		dc.w  $1320,  $9F8
		dc.w  $132F,  $9E8
		dc.w  $1343,  $9C8
		dc.w  $1350,  $9A8
		dc.w  $135A,  $988
		dc.w  $1360,  $958
		dc.w  $1360,  $878
AutoTunnel_11:
		dc.w $7C
		dc.w  $3760,  $1C8
		dc.w  $3760,  $510
		dc.w  $375A,  $540
		dc.w  $3750,  $560
		dc.w  $3743,  $580
		dc.w  $372F,  $5A0
		dc.w  $3720,  $5B0
		dc.w  $3715,  $5C0
		dc.w  $3705,  $5CC
		dc.w  $36F5,  $5D8
		dc.w  $36E5,  $5E4
		dc.w  $36C5,  $5F4
		dc.w  $36A5,  $600
		dc.w  $3665,  $608
		dc.w  $3655,  $608
		dc.w  $3635,  $604
		dc.w  $3625,  $602
		dc.w  $3605,  $5F8
		dc.w  $35F5,  $5F0
		dc.w  $35D5,  $5E0
		dc.w  $35C5,  $5D4
		dc.w  $35B5,  $5C8
		dc.w  $35A5,  $5B8
		dc.w  $3598,  $5A8
		dc.w  $358C,  $598
		dc.w  $3582,  $588
		dc.w  $3573,  $568
		dc.w  $3568,  $548
		dc.w  $3564,  $538
		dc.w  $3560,  $508
		dc.w  $3560,  $478
AutoTunnel_12:
		dc.w $7C
		dc.w  $3460,  $5C8
		dc.w  $3460,  $690
		dc.w  $345A,  $6C0
		dc.w  $3450,  $6E0
		dc.w  $3443,  $700
		dc.w  $342F,  $720
		dc.w  $3420,  $730
		dc.w  $3415,  $740
		dc.w  $3405,  $74C
		dc.w  $33F5,  $758
		dc.w  $33E5,  $764
		dc.w  $33C5,  $774
		dc.w  $33A5,  $780
		dc.w  $3365,  $788
		dc.w  $3355,  $788
		dc.w  $3335,  $784
		dc.w  $3325,  $782
		dc.w  $3305,  $778
		dc.w  $32F5,  $770
		dc.w  $32D5,  $760
		dc.w  $32C5,  $754
		dc.w  $32B5,  $748
		dc.w  $32A5,  $738
		dc.w  $3298,  $728
		dc.w  $328C,  $718
		dc.w  $3282,  $708
		dc.w  $3273,  $6E8
		dc.w  $3268,  $6C8
		dc.w  $3264,  $6B8
		dc.w  $3260,  $688
		dc.w  $3260,  $5F8
AutoTunnel_13:
		dc.w $28
		dc.w  $1C70,  $730
		dc.w  $1C70,  $6C0
		dc.w  $1C62,  $6A0
		dc.w  $1C42,  $692
		dc.w  $1C32,  $692
		dc.w  $1C12,  $69B
		dc.w  $1C00,  $6BB
		dc.w  $1C08,  $6DB
		dc.w  $1C28,  $6F0
		dc.w  $1CA8,  $6F0
AutoTunnel_14:
		dc.w $28
		dc.w  $3670,  $830
		dc.w  $3670,  $7C0
		dc.w  $3662,  $7A0
		dc.w  $3642,  $792
		dc.w  $3632,  $792
		dc.w  $3612,  $79B
		dc.w  $3600,  $7BB
		dc.w  $3608,  $7DB
		dc.w  $3628,  $7F0
		dc.w  $36A8,  $7F0
SpriteTerminat9:
		dc.w  $FFFF,     0,     0
MHZ1_Sprites:
		binclude "Levels/MHZ/Object Pos/1-S3.bin"
		even
MHZ2_Sprites:
		binclude "Levels/MHZ/Object Pos/2-S3.bin"
		even
MHZ1_Rings:
		dc.w    $80, $7100, $FFFF
MHZ2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatA:
		dc.w  $FFFF,     0,     0
SOZ1_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
SOZ2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
SOZ1_Rings:
		dc.w    $80, $7100, $FFFF
SOZ2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatB:
		dc.w  $FFFF,     0,     0
LRZ1_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
LRZ2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
LRZ1_Rings:
		dc.w    $80, $7100, $FFFF
LRZ2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatC:
		dc.w  $FFFF,     0,     0
SSZ1_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
SSZ2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
SSZ1_Rings:
		dc.w    $80, $7100, $FFFF
SSZ2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatD:
		dc.w  $FFFF,     0,     0
DEZ1_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
DEZ2_Sprites:
		dc.w   $550,     0,  $289
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
DEZ1_Rings:
		dc.w    $80, $7100, $FFFF
DEZ2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatE:
		dc.w  $FFFF,     0,     0
DDZ1_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
DDZ2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
DDZ1_Rings:
		dc.w    $80, $7100, $FFFF
DDZ2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatF:
		dc.w  $FFFF,     0,     0
Ending1_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
Ending2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
Ending1_Rings:
		dc.w    $80, $7100, $FFFF
Ending2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatG:
		dc.w  $FFFF,     0,     0
ALZ1_Sprites:
		binclude "Levels/ALZ/Object Pos/1.bin"
		even
ALZ2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
ALZ1_Rings:
		dc.w    $80, $7100, $FFFF
ALZ2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatH:
		dc.w  $FFFF,     0,     0
BPZ1_Sprites:
		binclude "Levels/BPZ/Object Pos/1.bin"
		even
BPZ2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
BPZ1_Rings:
		dc.w    $80, $7100, $FFFF
BPZ2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatI:
		dc.w  $FFFF,     0,     0
DPZ1_Sprites:
		binclude "Levels/DPZ/Object Pos/1.bin"
		even
DPZ2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
DPZ1_Rings:
		dc.w    $80, $7100, $FFFF
DPZ2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatJ:
		dc.w  $FFFF,     0,     0
CGZ1_Sprites:
		binclude "Levels/CGZ/Object Pos/1.bin"
		even
CGZ2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
CGZ1_Rings:
		dc.w    $80, $7100, $FFFF
CGZ2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatK:
		dc.w  $FFFF,     0,     0
EMZ1_Sprites:
		binclude "Levels/EMZ/Object Pos/1.bin"
		even
EMZ2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
EMZ1_Rings:
		dc.w    $80, $7100, $FFFF
EMZ2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatL:
		dc.w  $FFFF,     0,     0
Gumball1_Sprites:
		binclude "Levels/Gumball/Object Pos/1-S3.bin"
		even
Gumball2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
Gumball1_Rings:
		dc.w   $200,  $200, $FFFF
Gumball2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatM:
		dc.w  $FFFF,     0,     0
Pachinko1_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
Pachinko2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
Pachinko1_Rings:
		dc.w    $80, $7100, $FFFF
Pachinko2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatN:
		dc.w  $FFFF,     0,     0
Slots1_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
Slots2_Sprites:
		dc.w    $80,   $80,     0
		dc.w  $FFFF,     0,     0
Slots1_Rings:
		dc.w    $80, $7100, $FFFF
Slots2_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatO:
		dc.w  $FFFF,     0,     0
LRZ3_Sprites:
		dc.w  $FFFF,     0,     0
HPZ_Sprites:
		dc.w  $FFFF,     0,     0
LRZ3_Rings:
		dc.w    $80, $7100, $FFFF
HPZ_Rings:
		dc.w    $80, $7100, $FFFF
SpriteTerminatP:
		dc.w  $FFFF,     0,     0
DEZ3_Sprites:
		dc.w  $FFFF,     0,     0
HPZMini_Sprites:
		dc.w  $FFFF,     0,     0
DEZ3_Rings:
		dc.w    $80, $7100, $FFFF
HPZMini_Rings:
		dc.w    $80, $7100, $FFFF
SStage1_Layout:
		binclude "General/Special Stage/Layout/S3 1.bin"
		even
SStage2_Layout:
		binclude "General/Special Stage/Layout/S3 2.bin"
		even
SStage3_Layout:
		binclude "General/Special Stage/Layout/S3 3.bin"
		even
SStage4_Layout:
		binclude "General/Special Stage/Layout/S3 4.bin"
		even
SStage5_Layout:
		binclude "General/Special Stage/Layout/S3 5.bin"
		even
SStage6_Layout:
		binclude "General/Special Stage/Layout/S3 6.bin"
		even
SStage7_Layout:
		binclude "General/Special Stage/Layout/S3 7.bin"
		even
SStage8_Layout:
		binclude "General/Special Stage/Layout/S3 8.bin"
