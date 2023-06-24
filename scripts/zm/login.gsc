#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\shared\laststand_shared;
#using scripts\shared\util_shared;

//*****************************************************************************
// MAIN
//*****************************************************************************

function init()
{
    // Initiates the custom loadout
    level.giveCustomLoadout = &giveCustomLoadout; 

    // Change starting points
    level.player_starting_points = 500000;

    // Change starting perks
    level.perk_purchase_limit = 10;

    // Thread the Debug and MapCheck functions
    thread Debug();
    thread MapCheck();
}

function Debug()
{
    // Wait until the blackscreen has passed
    level flag::wait_till( "initial_blackscreen_passed" );
    IPrintLnBold("^1DEBUG: GSC Loading Successful");
}

function MapCheck()
{
    //Gets the map name
    mapname = GetDvarString("ui_mapname"); 

    // Wait until the blackscreen has passed
    level flag::wait_till( "initial_blackscreen_passed" );
    IPrintLnBold("^1DEBUG: mapname = " + mapname);
}

function giveCustomLoadout(takeAllWeapons)
{
    // Starting weapon
    level.weapon_start = "sniper_fastsemi"; 

    // Built in function in scripts\zm\_zm_utility.gsh
    // Gives the player a weapon that respects the weapon kits
    weapon = self zm_weapons::give_build_kit_weapon(GetWeapon(level.weapon_start));

    // This gives the player the ability to melee   
    self GiveWeapon(level.weaponBaseMelee); 

    // Switches to the weapon the server gave the player
    self SwitchToWeapon(weapon); 
}