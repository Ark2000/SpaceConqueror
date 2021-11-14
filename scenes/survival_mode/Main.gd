extends Node2D

var rules = preload("res://scenes/survival_mode/SurvivalModeConfig.gd").new()

var score := 0 setget set_score

var current_wepaon_count := 0
var current_level := 0

var max_infected := 2
var max_enemies := 40
var current_infected := 0
var current_enemies := 0 setget set_current_enemies

var gameover := false

var spawners_paused := false

onready var hud = $UI/HUD

func _ready() -> void:
# warning-ignore:return_value_discarded
	Event.connect("exploded", self, "_on_exploded")
# warning-ignore:return_value_discarded
	Event.connect("died", self, "_on_ship_die")
# warning-ignore:return_value_discarded
	Event.connect("spawned", self, "_on_ship_spawn")

	if rules.survival_time_bonus:
		$Timer.wait_time = rules.survival_time_bonus_interval
		$Timer.start()
	$RestrictedZone.radius = rules.restricted_zone_initial_radius

	for s in rules.enemies_spawn_rule:
		Butler.summon_spawner(s[0], s[1], s[2], s[3], s[4])

	$UI/MenuUI.set_process_input(false)
	$Upgrades.player = $Player
	$Upgrades.configs = rules

# warning-ignore:return_value_discarded
	$Player.connect("hp_changed", self, "_on_player_hp_changed")
# warning-ignore:return_value_discarded
	$Player.connect("shield_changed", self, "_on_player_shield_changed")
# warning-ignore:return_value_discarded
	$Player.connect("heat_changed", self, "_on_player_heat_changed")
# warning-ignore:return_value_discarded
	$Player.connect("weapon_info_changed", self, "_on_player_weapon_info_changed")
# warning-ignore:return_value_discarded
	$Player.connect("select_weapon", self, "_on_player_select_weapon")
	hud.v1.max_value = $Player.max_hp
	hud.v2.max_value = $Player.max_shield
	hud.v1.value = $Player.hp
	hud.v2.value = $Player.shield
	hud.v3.value = $Player.heat / $Player.max_heat * 100
	hud.w1.highlight = true
	
	SoundPlayer.play_bgm(Res.bgm_02)
	
	if !Config.c.options_skip_opening_animation:
		$AnimationPlayer.play("Intro")

func set_score(new_score:int):
	var d = new_score - score
	score = new_score
	$RestrictedZone.radius += d * rules.restricted_zone_expansion_rate
	$RestrictedZone.radius = min($RestrictedZone.radius, rules.restricted_zone_max_radius)

	hud.s.number = new_score

	var v = 1.0 * (new_score - rules.levelup_exp[current_level]) / (rules.levelup_exp[current_level+1] - rules.levelup_exp[current_level])
	hud.set_skull_value(v)

	while new_score >= rules.levelup_exp[current_level+1] and !gameover:
		current_level += 1
		hud.set_level(current_level)
		$Tween.stop_all()
		$Tween.interpolate_property(Engine, "time_scale", 1.0, 0.01, 0.5)
		$Tween.interpolate_callback(self, 0.5, "_pop_upgrade_menu")
		$Tween.start()
		
		Butler.summon_explosion_02($Player.position, 0, 6.0, 100.0, $Player)
		$Player.hp = $Player.max_hp
		$Player.shield = $Player.max_shield

func set_current_enemies(n:int):
	current_enemies = n
	$UI/Label2.text = n as String
	if n >= max_enemies and !spawners_paused:
		spawners_paused = true
		Event.emit_signal("stop_spawning")
	elif n < max_enemies and spawners_paused:
		spawners_paused = false
		Event.emit_signal("start_spawning")

func _pop_upgrade_menu():
	$Tween.stop_all()
	Engine.time_scale = 1.0
	get_tree().paused = true
	var l = Res.layout_upgrade.instance()
	l.set_content($Upgrades.get_available_options())
	$UI/MenuUI.load_layout(l, true)
	$UI/MenuUI.layer = 3
	$UI/MenuUI.set_process_input(true)

func _pop_gameover_menu():
	$Tween.stop_all()
	Engine.time_scale = 1.0
	get_tree().paused = true
	var l = Res.layout_gameover.instance()
	l.set_content(score)
	$UI/MenuUI.load_layout(l, true)
	$UI/MenuUI.layer = 3
	$UI/MenuUI.set_process_input(true)

func _on_Timer_timeout() -> void:
	self.score += rules.survival_time_bounus_amount

func _on_ship_die(e):
	if e.team != 0: self.current_enemies -= 1

	if rules.scores.has(e.code_name) and e.team != 0:
		self.score += rules.scores[e.code_name]

		var wc = int(score / rules.weapon_drop_interval)
		if  wc != current_wepaon_count:
			current_wepaon_count = wc
			if randf() > (1.0 - rules.weapon_drop_rate):
				var w = Butler.summon_weapon_pack(e.global_position)
				w.weapon_type = rules.weapons[randi() % rules.weapons.size()]
				w.max_ammo_ratio = $Upgrades.weapon_max_ammo_ratio
				w.fire_rate_ratio = $Upgrades.weapon_fire_rate_ratio

		if randf() < $Upgrades.infection_rate and current_infected < max_infected:
			e.queue_free()
			var infected = Butler.summon_enemy(e.code_name, e.position + Vector2(1, 1))
			infected.team = 0
			current_infected += 1
			Butler.summon_conn_line(infected, $Player)
			infected.connect("died", self, "_on_infected_died")

	if e == $Player:
		gameover = true
		
		if score > Config.c.highest_score:
			Config.c.highest_score = score

		$UI/HUD.layer = -1
		$UI/CountDown.hide()
		$Tween.stop_all()
		$Tween.interpolate_property(Engine, "time_scale", 1.0, 0.01, 1.0)
		$Tween.interpolate_callback(self, 1.0, "_pop_gameover_menu")
		$Tween.start()

func _on_ship_spawn(e):
	if e.team != 0: self.current_enemies += 1

func _on_infected_died(_e):
	current_infected -= 1

var ttt = 0

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") and !gameover:
		get_tree().paused = true
		$UI/MenuUI.load_layout(Res.layout_pause.instance(), true)
		$UI/MenuUI.layer = 3
		$UI/MenuUI.set_process_input(true)
		
	if Input.is_action_just_pressed("zoom_in"):
		print_stray_nodes()

func _physics_process(delta: float) -> void:
	var zoom = Vector2(0.6, 0.6) + Vector2(0.6, 0.6) * $Player.linear_velocity.length_squared() / 40000.0
	$GoodCamera.zoom = lerp($GoodCamera.zoom, zoom, 0.01)
	
	$VisualFX/Aberration.material.set("shader_param/p", range_lerp($GoodCamera.trauma, 0.0, 1.0, 0.001, 0.01))

	$RestrictedZone.radius -= delta * rules.restricted_zone_shrinkage_speed

	ttt += delta

func _on_exploded(p, s, r):
	var d = ($GoodCamera.position - p).length()
	var t = max(0.0, 1.0 - d / r) * s
	$GoodCamera.trauma += t

func _on_CountDown_countdown_is_over() -> void:
	$Player.hurt(10000)

func _on_Monitor_player_entered() -> void:
	$UI/CountDown.stop()

func _on_Monitor_player_exited() -> void:
	$UI/CountDown.start()

func _on_player_hp_changed(hp, max_hp) -> void:
	hud.v1.value = hp
	hud.v1.max_value = max_hp

func _on_player_shield_changed(shield, max_shield) -> void:
	hud.v2.value = shield
	hud.v2.max_value = max_shield

func _on_player_heat_changed(heat, max_heat) -> void:
	hud.v3.value = heat / max_heat * 100

func _on_player_weapon_info_changed(id, title, val1, val2) -> void:
	var w = [hud.w1, hud.w2, hud.w3][id]
	w.title = title
	w.progress1 = val1
	w.progress2 = val2

func _on_player_select_weapon(id) -> void:
		hud.w1.highlight = id == 0
		hud.w2.highlight = id == 1
		hud.w3.highlight = id == 2
