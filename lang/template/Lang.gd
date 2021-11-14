class_name Lang extends Resource

export var language := "ENGLISH"

export var PLAY := "PLAY"
export var OPTIONS := "OPTIONS"
export var CREDITS := "CREDITS"
export var HELP := "HELP"
export var GO_BACK := "GO BACK"
export var GRAPHICS := "GRAPHICS"
export var AUDIO := "AUDIO"
export var MISC := "MISC"
export var CONTROLS := "CONTROLS"
export var LANGUAGE := "LANGUAGE"
export var CHROMATIC_ABERRATION := "CHROMATIC ABERRATION"
export var DEPTH_OF_FIELD := "DEPTH OF FIELD"
export var MOTION_BLUR := "MOTION BLUR"
export var SCREEN_SHAKE := "SCREEN SHAKE"
export var ON := "ON"
export var OFF := "OFF"
export var SOUND_EFFECTS_VOLUME := "SOUND EFFECTS VOLUME"
export var MUSIC_VOLUME := "MUSIC VOLUME"
export var VIBRATIONS := "VIBRATIONS"
export var MAIN_MENU := "MAIN MENU"
export var BACK_TO_GAME := "BACK TO GAME"
export var CONFIRM := "CONFIRM"

export var INCREASE_MAX_HP_1 := "REACTIVE ARMOR I"
export var INCREASE_MAX_HP_1_DESC := "Increase max armor"
export var INCREASE_MAX_HP_3 := "REACTIVE ARMOR II"
export var INCREASE_MAX_HP_3_DESC := "Increase max armor"
export var INCREASE_MAX_SHIELD_1 := "FORCE FIELD I"
export var INCREASE_MAX_SHIELD_1_DESC := "Increase max shield"
export var INCREASE_MAX_SHIELD_3 := "FORCE FIELD II"
export var INCREASE_MAX_SHIELD_3_DESC := "Increase max shield"
export var INCREASE_SHIELD_RECOVERY_1 := "NANOBOTS I"
export var INCREASE_SHIELD_RECOVERY_1_DESC := "Increase shield recovery rate"
export var INCREASE_SHIELD_RECOVERY_3 := "NANOBOTS II"
export var INCREASE_SHIELD_RECOVERY_3_DESC := "Increase shield recovery rate"
export var INCREASE_MAX_THERMOLYSIS_1 := "HOT RESISTANCE I"
export var INCREASE_MAX_THERMOLYSIS_1_DESC := "Increase heat resistrance"
export var INCREASE_MAX_THERMOLYSIS_3 := "HOT RESISTANCE II"
export var INCREASE_MAX_THERMOLYSIS_3_DESC := "Increase heat resistance"
export var INCREASE_COOLING_RATE_1 := "THERMAL RADIATION I"
export var INCREASE_COOLING_RATE_1_DESC := "Increase cooling rate"
export var INCREASE_COOLING_RATE_3 := "THERMAL RADIATION II"
export var INCREASE_COOLING_RATE_3_DESC := "Increase cooling rate"
export var SELF_REPAIR_1 := "BIONIC ARMOR I"
export var SELF_REPAIR_1_DESC := "Increase armor recovery rate"
export var SELF_REPAIR_3 := "BIONIC ARMOR II"
export var SELF_REPAIR_3_DESC := "Increase armor recovery rate"
export var INCREASE_TORQUE_1 := "EM DRIVE I"
export var INCREASE_TORQUE_1_DESC := "Increase power of torque engine"
export var INCREASE_TORQUE_3 := "EM DRIVE II"
export var INCREASE_TORQUE_3_DESC := "Increase power of torque engine"
export var INCREASE_THRUST_1 := "FUSION ENGINE I"
export var INCREASE_THRUST_1_DESC := "Increase power of thrust engine"
export var INCREASE_THRUST_3 := "FUSION ENGINE II"
export var INCREASE_THRUST_3_DESC := "Increase power of thrust engine"
export var INCREASE_WEAPON_DROP_CHANCE := "ADVANCAED RADAR"
export var INCREASE_WEAPON_DROP_CHANCE_DESC := "Increase chance of dropped weapon"
export var MORE_OPTIONS := "ADVANCED CPU"
export var MORE_OPTIONS_DESC := "More options when upgrade"
export var MORE_AMMO := "EXTENDED AMMO BAY"
export var MORE_AMMO_DESC := "More initial ammo of weapons"
export var VAMPIRE := "ENERGY TRANSMISSION"
export var VAMPIRE_DESC := "Get healed when enemy is hit"
export var INFECTIOUS := "CRYPTOGRAPHER"
export var INFECTIOUS_DESC := "Turn your enemies into allies if possible"
export var NECROMANCY := "DRONE FACTORY"
export var NECROMANCY_DESC := "summon drones around you"
export var FLASH := "FASTER AND FASTER"
export var FLASH_DESC := "Increase fire rate"

export(String, MULTILINE) var HELP_TEXT := """
[center][i]HOW TO PLAY[/i][/center]

You are the last survivor of a space faction. Try to survive endless waves of  enemy attacks with your "pulsar" scout.

[b]Basic Rules[/b]

- Destroy enemy ships to gain points and randomly dropped weapons

- You must constantly fight to slow down the spread of the deadly force field

- When the score reaches a certain stage, you will obtain enhanced components

[b]Controls[/b]

When in menu: 
	
	Up / Down - Switch Items
	Space - Confirm
	ESC - Go Back

When fighting:

	Up - Accelerate
	Left / Right - Turn Around
	Z - Change Weapon
	X - Pick Up
	Space - Attack
	ESC - Pause
"""

export(String, MULTILINE) var CREDITS_TEXT := """
[center][i]Space Conqueror (v0.1.0)[/i][/center]

developer: k2kra (k2kra@outlook.com)

I used a lot of assets from the Internet.

[b]THANKS:[/b]

Endless Sky Project (https://endless-sky.github.io/)

yd (https://opengameart.org/content/another-space-background-track)

Pablo Roman Andrioli (https://www.shadertoy.com/view/XlfGRj)

Alexander Nakarada (https://freepd.com/electronic.php)

GDQuest (https://github.com/GDQuest/godot-2d-space-game)

And more...

"""
