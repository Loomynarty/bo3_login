# Black Ops 3 Login Mod

Current features:
- Random camos
    - PAP keeps current camo
    - Weapon models for the mystery box + PAP reflect the randomized camo
    - Camos are only randomized once
- Sets perk limit to 10
- BO4 Style Max Ammo

Dev Only Features
- Debug print statements
- Sets starting points to 500000
- Sets starting weapon to Drakon
- God Mode

How to build:
1. `git clone`
2. Place the repo in the `Call of Duty Black Ops III\mods` folder
3. Launch the Black Ops 3 Mod Tools
4. In the mods area, find the `login` mod and click the box next to `zm_mod`
5. On the right side, click the `Link` and `Run` options
    - `Link` builds the mod
    - `Run` launches BO3 with the mod enabled
6. In the box under `Run`, there are many options, but I always use the following:
    - +developer 2: Enables developer mode and in-game console use (Shift + ~)
    - +logfile 2: Logs what the game is doing into the `console_mp.log` file in the mod folder
    - +devmap **replace_with_map**: Loads straight into the specified map. [List of map names](https://t7wiki.com/en/information/list-of-original-map-console-names)
    - Example: +devmap zm_prototype +developer 2 +logfile 2 +scr_mod_enable_devblock 1
    - Example 2: +devmap zm_testopener +developer 2 +logfile 2 +scr_mod_enable_devblock 1
    - Multiplayer Test: +devmap zm_testopener +set splitscreen 1 +set splitscreen_playerCount 2 +developer 2 +logfile 2 +scr_mod_enable_devblock 1 
7. Profit!

Mod Template Download: [Link](https://drive.google.com/file/d/15Z4Ho8yZFBvgh6xqv8HutQnJCcey-W7g/view?usp=sharing)

1. Extract `Mod 2.0` into the directory `Call of Duty Black Ops III\rex\templates` folder
2. Now head to the Mod Tools and select the `New` icon at the top left
3. Select `Mod 2.0` as the Template, and name it something awesome
    - Has the point, perk, and starting weapon changes enabled by default





