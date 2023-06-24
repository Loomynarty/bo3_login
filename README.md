# Black Ops 3 Login Mod

Current features:
- Sets starting points to 500000
- Sets perk limit to 10
- Sets starting weapon to Drakon

How to build:

1. `git clone`
2. rename the `bo3_login` folder to `login`
3. Launch the Black Ops 3 Mod Tools
4. In the mods area, find the `login` mod and click the box next to `zm_mod`
5. On the right side, click the `Link` and `Run` options
    - `Link` builds the mod
    - `Run` launches BO3 with the mod enabled
6. In the box under `Run`, there are many options, but I always use the following:
    - +developer 2: Enables developer mode and in-game console use (Shift + ~)
    - +logfile 2: Logs what the game is doing into the `console_mp.log` file in the mod folder
    - +devmap **replace_with_map**: Loads straight into the specified map. [List of map names](https://t7wiki.com/en/information/list-of-original-map-console-names)
    - Example: +devmap zm_prototype +developer 2 +logfile 2 
7. Profit!

The primary file to pay attention to is `scripts\zm\login.gsc`



