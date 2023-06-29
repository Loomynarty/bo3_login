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
    // Trigger function on player spawn
    callback::on_spawned( &watch_max_ammo );
    callback::on_spawned( &load_message );
    callback::on_spawned( &map_check );

    // Change starting perks
    level.perk_purchase_limit = 10;

    /#
    // Activate the following only if devblocks are enabled (+scr_mod_enable_devblock 1)
    // Enable godmode
    callback::on_spawned( &god_mode );
    
    // Change starting points
    level.player_starting_points = 500000;

    // Initiates the custom loadout
    level.giveCustomLoadout = &giveCustomLoadout;
    #/ 
    
}

function get_camo_options(weapon) {
    camo = undefined;
    w_name = weapon.rootweapon.name;
    
    debug("^2user: " + self.name);
    
    // PAP'ed weapon have _upgrade at the end; remove it
    if (StrEndsWith(w_name, "_upgraded")) {
        w_name = GetSubStr(w_name, 0, w_name.size - 9);
    }
 
    // Search weapon_camos for weapon
    if (IsDefined(self.weapon_camos)) {
        for (i = 0; i < self.weapon_camos.size; i++) {
            if (self.weapon_camos[i].weapon == w_name) {
                camo = self.weapon_camos[i].camo;
                debug("found previous camo - " + camo);
            }
        }
    }
    else {
        debug("^2init_camo for user: " + self.name);
        self.weapon_camos = array();
    }

    if (!IsDefined(camo)) {
        camo = RandomIntRange(1, 139);
        debug("random camo - " + camo);

        // Remember camo
        data = SpawnStruct();
        data.weapon = w_name;
        data.camo = camo;

        // Edge case: bowie_flourish and bowie_knife are two different items
        // Ensure that bowie_flourish and bowie_knife have the same camo
        if (data.weapon == "bowie_flourish") {
            data.weapon = "bowie_knife";
        }

        array::add(self.weapon_camos, data );

        debug("array size - " + self.weapon_camos.size);
    }

    options = self GetBuildKitWeaponOptions(weapon, camo);

    return options;
}

function god_mode() {
    debug("Setting godmode");
    for(i = 0; i < level.players.size; i++)
	{
		level.players[i] EnableInvulnerability();
	}
}

function load_message()
{
    // Wait until the blackscreen has passed
    level flag::wait_till( "initial_blackscreen_passed" );
    debug("GSC Loading Successful");
}

function map_check()
{
    //Gets the map name
    mapname = GetDvarString("ui_mapname"); 

    // Wait until the blackscreen has passed
    level flag::wait_till( "initial_blackscreen_passed" );
    debug("^2mapname = " + mapname);
}

function giveCustomLoadout(takeAllWeapons)
{
    // Starting weapon
    level.weapon_start = "sniper_fastsemi"; 

    // Built in function in scripts\zm\_zm_utility
    // Gives the player a weapon that respects the weapon kits
    weapon = self zm_weapons::give_build_kit_weapon(GetWeapon(level.weapon_start));

    // This gives the player the ability to melee   
    self GiveWeapon(level.weaponBaseMelee); 

    // Switches to the weapon the server gave the player
    self SwitchToWeapon(weapon);
}

// BO4 Max Ammo - fill weapon clip along with ammo reserves 
function watch_max_ammo() {
    self endon("bled_out");
    self endon("spawned_player");
    self endon("disconnect");
    
    for(;;) {
        self waittill("zmb_max_ammo");
        debug("BO4 Max Ammo Trigger");
        foreach(weapon in self GetWeaponsList(1)) {
            if (isdefined(weapon.clipsize) && weapon.clipsize > 0) { 
                self SetWeaponAmmoClip(weapon, weapon.clipsize);
            }
        }
    }
}

function debug(message) {
    dev = false;
    /# dev = true; #/
    if (dev) self IPrintLnBold("^1DEBUG: " + message);
}