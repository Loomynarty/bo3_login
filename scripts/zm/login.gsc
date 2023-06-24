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
    level.giveCustomLoadout = &giveCustomLoadout; // Initiates the custom loadout (Spawn weapons, as certain maps use a certian function that you can't replace without a loadout)
    level.player_starting_points = 500000;
    level.perk_purchase_limit = 10;
    thread Debug();
    thread MapCheck();
}

function Debug()
{
    level flag::wait_till( "initial_blackscreen_passed" );
    IPrintLnBold("^1DEBUG: GSC Loading Successful");
}

function MapCheck()
{
    //Gets the map name
    mapname = GetDvarString("ui_mapname"); 
    level flag::wait_till( "initial_blackscreen_passed" );
    IPrintLnBold("^1DEBUG: mapname = " + mapname);
}

function giveCustomLoadout(takeAllWeapons)
{
    level.weapon_start = "sniper_fastsemi"; // Starting weapon
    weapon = self zm_weapons::give_build_kit_weapon(GetWeapon(level.weapon_start));
    self GiveWeapon(level.weaponBaseMelee); // This gives the player the ability to melee
    self SwitchToWeapon(weapon); // Switches to the weapon the server gave the player
}