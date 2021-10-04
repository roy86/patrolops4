/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2019-07-06
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class CfgVirtualArmoury {
    enableFullArmoury = 0;
    allTraits[] = {"Crewman","PilotHeli","PilotPlane","Medic","Engineer","ExplosiveSpecialist","HALO"};
    allWeaponTypes[] = {
        "AssaultRifle","Shotgun","Rifle","SubmachineGun","Handgun",
        "MachineGun",
        "SniperRifle",
        "Launcher","MissileLauncher","RocketLauncher",
        "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear",
        "Glasses","Binocular","Compass","FirstAidKit","Radio","Toolkit","Watch",
        "UAVTerminal",
        "NVGoggles",
        "GPS",
        "LaserDesignator",
        "Map",
        "Medikit",
        "MineDetector",
        "UnknownWeapon",
        "Backpack"
    };
    /* ROLES */
    class Rifle {
        displayName = "Rifleman"; //Name of the role, displayed in the respawn menu
        icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa"; //Icon shown next to the role name in the respawn screen
        limit = 0;
        fullArmoury = 0;
        traits[] = {"HALO"};
        weaponTypes[] = {
            "AssaultRifle","Shotgun","Rifle","SubmachineGun","Handgun","Grenade","SmokeShell","Mine",
            "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear",
            "Glasses","Binocular","Compass","FirstAidKit","Radio","Watch","Map",
            "Backpack"
        };
        class Loadout {
            uniformClass = "U_B_CombatUniform_mcam";
            backpack = "B_AssaultPack_mcamo";
            linkedItems[] = {"V_PlateCarrier1_rgr","H_HelmetB","ItemCompass","ItemWatch","ItemRadio","NVGoggles"};
            weapons[] = {"arifle_MX_ACO_pointer_F","hgun_P07_F"};
            items[] = {"FirstAidKit","FirstAidKit","FirstAidKit"};
            magazines[] = {"30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","SmokeShell","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade","HandGrenade"};
        };
    };
    class AT {
        displayName = "Anti Armour"; //Name of the role, displayed in the respawn menu
        icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa"; //Icon shown next to the role name in the respawn screen
        limit = 0;
        fullArmoury = 0;
        traits[] = {"HALO"};
        weaponTypes[] = {
            "AssaultRifle","Shotgun","Rifle","SubmachineGun","Handgun","Grenade","SmokeShell","Mine",
            "Launcher","MissileLauncher","RocketLauncher",
            "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear",
            "Glasses","Binocular","Compass","FirstAidKit","Radio","Watch","Map",
            "Backpack"
        };
        class Loadout {
            uniformClass = "U_B_CombatUniform_mcam";
            backpack = "B_AssaultPack_mcamo";
            linkedItems[] = {"V_PlateCarrier1_rgr","H_HelmetB","ItemCompass","ItemWatch","ItemRadio","NVGoggles"};
            weapons[] = {"arifle_MX_ACO_pointer_F","hgun_P07_F"};
            items[] = {"FirstAidKit","FirstAidKit","FirstAidKit"};
            magazines[] = {"30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","SmokeShell"};
        };
    };
    class SL {
        displayName = "Field Command"; //Name of the role, displayed in the respawn menu
        icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa"; //Icon shown next to the role name in the respawn screen
        limit = 0;
        fullArmoury = 0;
        traits[] = {"HALO"};
        weaponTypes[] = {
            "AssaultRifle","Shotgun","Rifle","SubmachineGun","Handgun","Grenade","SmokeShell",
            "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear",
            "Glasses","Binocular","Compass","FirstAidKit","Radio","Watch","Map",
            "GPS",
            "LaserDesignator",
            "MineDetector",
            "Backpack"
        };
        class Loadout {
            uniformClass = "U_B_CombatUniform_mcam_vest";
            backpack = "B_Patrol_Respawn_bag_F";
            weapons[] = {"arifle_MX_GL_F","hgun_Pistol_heavy_01_F","Rangefinder","Throw","Put"};
            magazines[] = {"30Rnd_65x39_caseless_mag","11Rnd_45ACP_Mag","30Rnd_65x39_caseless_mag","SmokeShell","SmokeShellGreen","SmokeShellBlue","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag","HandGrenade","HandGrenade","3Rnd_HE_Grenade_shell","3Rnd_HE_Grenade_shell","3Rnd_HE_Grenade_shell","SmokeShell","SmokeShellGreen","SmokeShellBlue"};
            items[] = {"FirstAidKit","FirstAidKit"};
            linkedItems[] = {"V_PlateCarrierGL_rgr","H_HelmetSpecB_paint1","G_Aviator","ItemMap","ItemCompass","ItemWatch","ItemRadio","B_UavTerminal","NVGoggles"};
        };
    };
    class TL {
        displayName = "Team Lead"; //Name of the role, displayed in the respawn menu
        icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa"; //Icon shown next to the role name in the respawn screen
        limit = 0;
        fullArmoury = 0;
        traits[] = {"HALO"};
        weaponTypes[] = {
            "AssaultRifle","Shotgun","Rifle","SubmachineGun","Handgun","Grenade","SmokeShell",
            "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear",
            "Glasses","Binocular","Compass","FirstAidKit","Radio","Watch","Map",
            "UAVTerminal",
            "GPS",
            "LaserDesignator",
            "MineDetector",
            "Backpack"
        };
        class Loadout {
            uniformClass = "U_B_CombatUniform_mcam_vest";
            backpack = "B_Patrol_Respawn_bag_F";
            weapons[] = {"arifle_MX_GL_F","hgun_Pistol_heavy_01_F","Rangefinder","Throw","Put"};
            magazines[] = {"30Rnd_65x39_caseless_mag","11Rnd_45ACP_Mag","30Rnd_65x39_caseless_mag","SmokeShell","SmokeShellGreen","SmokeShellBlue","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag","HandGrenade","HandGrenade","3Rnd_HE_Grenade_shell","3Rnd_HE_Grenade_shell","3Rnd_HE_Grenade_shell","SmokeShell","SmokeShellGreen","SmokeShellBlue"};
            items[] = {"FirstAidKit","FirstAidKit"};
            linkedItems[] = {"V_PlateCarrierGL_rgr","H_HelmetSpecB_paint1","G_Aviator","ItemMap","ItemCompass","ItemWatch","ItemRadio","B_UavTerminal","NVGoggles"};
        };
    };
    class Marksman {
        displayName = "Marksman"; //Name of the role, displayed in the respawn menu
        icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa"; //Icon shown next to the role name in the respawn screen
        limit = 0;
        fullArmoury = 0;
        traits[] = {"HALO"};
        weaponTypes[] = {
            "AssaultRifle","Shotgun","Rifle","SubmachineGun","Handgun","Grenade","SmokeShell",
            "SniperRifle",
            "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear",
            "Glasses","Binocular","Compass","FirstAidKit","Radio","Watch","Map",
            "GPS",
            "LaserDesignator",
            "Backpack"
        };
        class Loadout {
            uniformClass = "U_B_CombatUniform_mcam";
            backpack = "";
            weapons[] = {"srifle_EBR_F","hgun_Pistol_heavy_01_F","Rangefinder","Throw","Put"};
            magazines[] = {"20Rnd_762x51_Mag","11Rnd_45ACP_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellGreen"};
            items[] = {"FirstAidKit","FirstAidKit"};
            linkedItems[] = {"V_PlateCarrier1_rgr","H_HelmetB_light_desert","G_Bandanna_khk","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"};
        };
    };
    class Grenadier {
        displayName = "Grenadier"; //Name of the role, displayed in the respawn menu
        icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa"; //Icon shown next to the role name in the respawn screen
        limit = 0;
        fullArmoury = 0;
        traits[] = {"HALO","Engineer","ExplosiveSpecialist"};
        weaponTypes[] = {
            "AssaultRifle","Shotgun","Rifle","SubmachineGun","Handgun","Grenade","SmokeShell",
            "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear",
            "Glasses","Binocular","Compass","FirstAidKit","Radio","Watch","Map",
            "MineDetector",
            "Backpack"
        };
        class Loadout {
            uniformClass = "U_B_CombatUniform_mcam_vest";
            backpack = "B_Kitbag_rgr_Exp";
            weapons[] = {"hgun_Pistol_heavy_01_F","Binocular","arifle_MX_GL_F","Throw","Put"};
            magazines[] = {"11Rnd_45ACP_Mag","30Rnd_65x39_caseless_mag","1Rnd_HE_Grenade_shell","SmokeShell","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag","HandGrenade","HandGrenade","SmokeShellGreen","30Rnd_65x39_caseless_mag","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","APERSBoundingMine_Range_Mag","APERSBoundingMine_Range_Mag","APERSBoundingMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag","ClaymoreDirectionalMine_Remote_Mag","SLAMDirectionalMine_Wire_Mag","SLAMDirectionalMine_Wire_Mag","DemoCharge_Remote_Mag"};
            items[] = {"FirstAidKit","FirstAidKit","ToolKit","MineDetector"};
            linkedItems[] = {"V_PlateCarrierGL_mtp","H_HelmetSpecB_paint2","G_Tactical_Clear","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"};
        };
    };
    class AutoRifle {
        displayName = "Auto Rifleman"; //Name of the role, displayed in the respawn menu
        icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa"; //Icon shown next to the role name in the respawn screen
        limit = 0;
        fullArmoury = 0;
        traits[] = {"HALO"};
        weaponTypes[] = {
            "AssaultRifle","Shotgun","Rifle","SubmachineGun","Handgun","Grenade","SmokeShell",
            "MachineGun",
            "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear",
            "Glasses","Binocular","Compass","FirstAidKit","Radio","Watch","Map",
            "Backpack"
        };
        class Loadout {
            uniformClass = "U_B_CombatUniform_mcam_tshirt";
            backpack = "";
            weapons[] = {"arifle_MX_SW_F","hgun_Pistol_heavy_01_F","Binocular","Throw","Put"};
            magazines[] = {"100Rnd_65x39_caseless_mag","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag","SmokeShell","SmokeShellGreen","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer","MiniGrenade","MiniGrenade","100Rnd_65x39_caseless_mag_Tracer"};
            items[] = {"FirstAidKit","FirstAidKit"};
            linkedItems[] = {"V_PlateCarrier2_rgr","H_HelmetB_snakeskin","G_Bandanna_khk","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"};
        };
    };
    class Medic {
        displayName = "Medic"; //Name of the role, displayed in the respawn menu
        icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa"; //Icon shown next to the role name in the respawn screen
        limit = 0;
        fullArmoury = 0;
        traits[] = {"HALO","Medic"};
        weaponTypes[] = {
            "AssaultRifle","Shotgun","Rifle","SubmachineGun","Handgun","Grenade","SmokeShell",
            "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear",
            "Glasses","Binocular","Compass","FirstAidKit","Radio","Watch","Map",
            "Medikit",
            "Backpack"
        };
        class Loadout {
            uniformClass = "U_B_CombatUniform_mcam_vest";
            backpack = "B_Patrol_Medic_bag_F";
            weapons[] = {"arifle_MX_F","hgun_Pistol_heavy_01_F","Binocular","Throw","Put"};
            magazines[] = {"30Rnd_65x39_caseless_mag","11Rnd_45ACP_Mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellGreen","SmokeShellBlue","SmokeShellRed","SmokeShellYellow"};
            items[] = {"Medikit"};
            linkedItems[] = {"V_PlateCarrierSpec_rgr","H_HelmetSpecB_sand","G_Combat","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"};
        };
    };
    class Engineer {
        displayName = "Crewman"; //Name of the role, displayed in the respawn menu
        icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa"; //Icon shown next to the role name in the respawn screen
        limit = 0;
        fullArmoury = 0;
        traits[] = {"HALO","Crewman","Engineer","ExplosiveSpecialist"};
        weaponTypes[] = {
            "AssaultRifle","Shotgun","Rifle","SubmachineGun","Handgun","Grenade","SmokeShell",
            "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear",
            "Glasses","Binocular","Compass","FirstAidKit","Radio","Watch","Map",
            "GPS",
            "Toolkit",
            "MineDetector",
            "Backpack"
        };
        class Loadout {
            uniformClass = "U_B_CombatUniform_mcam_vest";
            backpack = "B_Kitbag_rgr_Exp";
            weapons[] = {"arifle_MX_F","hgun_Pistol_heavy_01_F","Binocular","Throw","Put"};
            magazines[] = {"30Rnd_65x39_caseless_mag","11Rnd_45ACP_Mag","30Rnd_65x39_caseless_mag","SmokeShell","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag","HandGrenade","HandGrenade","SmokeShellGreen","APERSBoundingMine_Range_Mag","APERSBoundingMine_Range_Mag","APERSBoundingMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag","ClaymoreDirectionalMine_Remote_Mag","SLAMDirectionalMine_Wire_Mag","SLAMDirectionalMine_Wire_Mag","DemoCharge_Remote_Mag"};
            items[] = {"FirstAidKit","FirstAidKit","ToolKit","MineDetector"};
            linkedItems[] = {"V_PlateCarrierGL_mtp","H_HelmetSpecB_paint2","G_Tactical_Clear","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"};
        };
    };
    class PilotHelo {
        displayName = "Helo Pilot"; //Name of the role, displayed in the respawn menu
        icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa"; //Icon shown next to the role name in the respawn screen
        limit = 0;
        fullArmoury = 0;
        traits[] = {"HALO","PilotHeli","Engineer"};
        weaponTypes[] = {
            "AssaultRifle","SubmachineGun","Handgun","Grenade","SmokeShell",
            "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear",
            "Glasses","Binocular","Compass","FirstAidKit","Radio","Watch","Map",
            "NVGoggles",
            "GPS",
            "Toolkit",
            "Backpack"
        };
        class Loadout {
            uniformClass = "U_B_HeliPilotCoveralls";
            backpack = "";
            weapons[] = {"SMG_01_F","Throw","Put"};
            magazines[] = {"30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01","Chemlight_green","30Rnd_45ACP_Mag_SMG_01","SmokeShellGreen","SmokeShellBlue","SmokeShellOrange","Chemlight_green"};
            items[] = {"FirstAidKit"};
            linkedItems[] = {"V_TacVest_blk","H_PilotHelmetHeli_B","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"};
        };
    };
    class Pilot {
        displayName = "Fighter Pilot"; //Name of the role, displayed in the respawn menu
        icon = "a3\missions_f_exp\data\img\classes\assault_ca.paa"; //Icon shown next to the role name in the respawn screen
        limit = 0;
        fullArmoury = 0;
        traits[] = {"HALO","PilotHeli","PilotPlane","Engineer"};
        weaponTypes[] = {
            "SubmachineGun","Handgun","Grenade","SmokeShell",
            "AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear",
            "Glasses","Binocular","Compass","FirstAidKit","Radio","Watch","Map",
            "NVGoggles",
            "GPS",
            "Backpack"
        };
        class Loadout {
            uniformClass = "U_B_PilotCoveralls";
            backpack = "B_Parachute";
            weapons[] = {"SMG_01_F","Throw","Put"};
            magazines[] = {"30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01","SmokeShell","SmokeShellBlue","Chemlight_green"};
            items[] = {"FirstAidKit"};
            linkedItems[] = {"H_PilotHelmetFighter_B","G_Combat","ItemMap","ItemCompass","ItemWatch","ItemRadio"};
        };
    };
};

#include "ui\roy86.rsc.virtualarmoury.roles.hpp"