extends BaseShip

signal weapon_info_changed(id, title, val1, val2)
signal select_weapon(id)

var max_wing_drones := 0
var current_drones := 0

var current_weapon_id := 0

func _physics_process(delta: float) -> void:
	update_states(delta)
	var r = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var a = Input.get_action_strength("ui_up")

	set_main_engine_power(a)
	set_side_engine_power(r)

	for i in 3:
		var w:NWeapon = $Weapons.get_child(i)
		if !w: continue
		emit_signal("weapon_info_changed", i, w.get_weapon_name(), w.get_ammo() / w.get_max_ammo(), w.get_cd() / w.get_max_cd())

	if Input.is_action_just_pressed("ui_accept"):
		trigger_weapon(current_weapon_id, true)
	if Input.is_action_just_released("ui_accept"):
		trigger_weapon(current_weapon_id, false)
	if Input.is_action_just_pressed("change_weapon"):
		set_current_weapon_id((current_weapon_id + 1) % 3)

func set_current_weapon_id(id:int):
	if id == current_weapon_id: return
	trigger_weapon(current_weapon_id, false)
	current_weapon_id = id
	emit_signal("select_weapon", id)

func pick_up_weapon(w:NWeapon) -> bool:
	if !$Pick.is_stopped(): return false
	$Pick.start()
	
	if current_weapon_id == 0:
		set_current_weapon_id(1)
	$Weapons.get_child(current_weapon_id).queue_free()
	w.weapon_id = current_weapon_id
	w.setup(self)	
	$Weapons.add_child_below_node($Weapons.get_child(current_weapon_id - 1), w)
	return true

func _on_Drones_timeout() -> void:
	if current_drones < max_wing_drones:
		current_drones += 1
		var drone = Butler.summon_enemy("Guardian", global_position + Vector2.RIGHT.rotated(randf()*TAU)*100.0)
		drone.ward = self
		Butler.summon_conn_line(drone, self)
		drone.team = 0
		drone.connect("died", self, "_on_drone_died")

func _on_drone_died(_e) -> void:
	current_drones -= 1
