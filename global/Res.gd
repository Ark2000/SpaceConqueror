extends Node

const explosion := preload("res://scenes/misc/explosion/Explosion.tscn")
const explosion_02 := preload("res://scenes/misc/explosion/Explosion02.tscn")
const trail := preload("res://scenes/misc/Trail.tscn")
const spark := preload("res://scenes/misc/Spark.tscn")
const spark2 := preload("res://scenes/misc/Spark2.tscn")
const weapon_pack := preload("res://scenes/misc/WeaponPack.tscn")
const connection_line := preload("res://scenes/misc/ConnectionLine.tscn")
const sound := preload("res://scenes/misc/Sound.tscn")
const smoke := preload("res://scenes/misc/Smoke.tscn")

const spawner := preload("res://scenes/misc/Spawner.tscn")

const enemies := {
	"Believer": preload("res://scenes/ships/enemy_ships/Believer.tscn"),
	"Cardinal": preload("res://scenes/ships/enemy_ships/Cardinal.tscn"),
	"Martyr": preload("res://scenes/ships/enemy_ships/Martyr.tscn"),
	"Missionary": preload("res://scenes/ships/enemy_ships/Missionary.tscn"),
	"Paladin": preload("res://scenes/ships/enemy_ships/Paladin.tscn"),
	"Priest": preload("res://scenes/ships/enemy_ships/Priest.tscn"),
	"Guardian": preload("res://scenes/ships/enemy_ships/Guardian.tscn")
}

const asteroid := preload("res://scenes/misc/Asteroid.tscn")

const popup_msg := preload("res://scenes/misc/PopupMsg.tscn")

const layout_01 = preload("res://scenes/ui/menu/layouts/layout_01.tscn")
const layout_02 = preload("res://scenes/ui/menu/layouts/layout_02.tscn")
const layout_03 = preload("res://scenes/ui/menu/layouts/layout_03.tscn")
const layout_04 = preload("res://scenes/ui/menu/layouts/layout_04.tscn")
const layout_05 = preload("res://scenes/ui/menu/layouts/layout_05.tscn")
const layout_06 = preload("res://scenes/ui/menu/layouts/layout_06.tscn")
const layout_07 = preload("res://scenes/ui/menu/layouts/layout_07.tscn")
const layout_08 = preload("res://scenes/ui/menu/layouts/layout_08.tscn")
const layout_09 = preload("res://scenes/ui/menu/layouts/layout_09.tscn")
const layout_10 = preload("res://scenes/ui/menu/layouts/layout_10.tscn")
const layout_11 = preload("res://scenes/ui/menu/layouts/layout_11.tscn")
const layout_12 = preload("res://scenes/ui/menu/layouts/layout_12.tscn")
const layout_pause = preload("res://scenes/ui/menu/layouts/layout_pause.tscn")
const layout_upgrade = preload("res://scenes/ui/menu/layouts/layout_upgrade.tscn")
const layout_gameover = preload("res://scenes/ui/menu/layouts/layout_gameover.tscn")

const bgm_01 = preload("res://assets/sound/ObservingTheStar.ogg")
const bgm_02 = preload("res://assets/sound/Space Ambience.ogg")

const sfx_01 = preload("res://assets/sound/Laser_03.wav")
const sfx_02 = preload("res://assets/sound/missile-blast-2.wav")

const sfx_explosions = [
	preload("res://assets/sound/explosion01.wav"),
	preload("res://assets/sound/explosion02.wav"),
	preload("res://assets/sound/explosion03.wav")
]

const sfx_explosions2 = [
	preload("res://assets/sound/Explosion_01.wav"),
	preload("res://assets/sound/Explosion_02.wav"),
	preload("res://assets/sound/Explosion_03.wav"),
	preload("res://assets/sound/Explosion_04.wav")
]
