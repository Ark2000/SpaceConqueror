extends Node

func summon_smoke(pos:Vector2):
	var e = Res.smoke.instance()
	e.position = pos
	get_tree().current_scene.call_deferred("add_child", e)
	return e

func summon_conn_line(from:Node2D, to:Node2D):
	var e = Res.connection_line.instance()
	e.start = from
	e.end = to
	get_tree().current_scene.call_deferred("add_child", e)
	return e

func summon_weapon_pack(pos:Vector2):
	var e = Res.weapon_pack.instance()
	e.position = pos
	get_tree().current_scene.call_deferred("add_child", e)
	return e

func summon_spark(pos:Vector2, type := 0):
	var e = [Res.spark, Res.spark2][type].instance()
	e.position = pos
	get_tree().current_scene.call_deferred("add_child", e)
	return e

func summon_spawner(code_name:String, start_time:float, interval_time:float, waves:int, formula:String):
	var e = Res.spawner.instance()
	e.code_name = code_name
	e.start_time = start_time
	e.interval_time = interval_time
	e.waves = waves
	e.formula = formula
	get_tree().current_scene.call_deferred("add_child", e)
	return e

func summon_enemy(code_name:String, pos:Vector2, parent_node = null):
	var e = Res.enemies[code_name].instance()
	e.global_position = pos
	var pnode = parent_node if parent_node else get_tree().current_scene
	pnode.call_deferred("add_child", e)

	summon_spark(pos,  1)
	return e

func summon_popup_msg():
	var p = Res.popup_msg.instance()
	get_tree().current_scene.call_deferred("add_child", p)
	return p

func summon_explosion(position:Vector2):
	var p = Res.explosion.instance()
	p.position = position
	get_tree().current_scene.call_deferred("add_child", p)
	Event.emit_signal("exploded", position, 1.0, 1000)
	return p

func summon_explosion_02(position:Vector2, team := -1, escale := 1.0, damage := 0.0, src = null):
	var p = Res.explosion_02.instance()
	p.position = position
	get_tree().current_scene.call_deferred("add_child", p)
	Event.emit_signal("exploded", position, 0.4, 2000)
	
	if team >= 0:
		p.collision_mask = ((1 << team) ^ (-1)) << 20
	p.scale = Vector2(escale, escale)
	p.damage = damage
	p.src = src
	
	return p
	
func summon_projectile(projectile:PackedScene):
	var p :Area2D = projectile.instance()
	get_tree().current_scene.call_deferred("add_child", p)
	return p

func summon_trail(width:=6.0):
	var p = Res.trail.instance()
	p.width = width
	p.clear_points()
	get_tree().current_scene.call_deferred("add_child", p)
	return p

func summon_asteroid(pos:Vector2, force:Vector2, life:float):
	var p = Res.asteroid.instance()
	p.position = pos
	p.impluse = force
	p.get_node("Timer").wait_time = life
	get_tree().current_scene.call_deferred("add_child", p)	
	return p

var _map = {"en":load("res://lang/template/Lang.gd").new()}
func get_text(key:String) -> String:
	var lang = Config.c.options_language

	if not _map.has(lang):
		var lang_res = load("res://lang/%s.tres"%lang)
		if lang_res != null:
			_map[lang] = lang_res
		else:
			return _map.en[key]
	
	if not _map[lang][key].empty():
		return _map[lang][key]

	return _map.en[key]

func get_current_language_name() -> String:
	if _map.has(Config.c.options_language):
		return _map[Config.c.options_language].language
	return "[NOT FOUND]"
