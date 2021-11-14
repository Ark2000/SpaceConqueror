extends Area2D

export var weapon_type := "ProtonImpactor"

var p = null
var w
var max_ammo_ratio := 1.0
var fire_rate_ratio := 1.0

func _ready() -> void:
	set_process_unhandled_input(false)
	collision_mask = Utils.get_team_mask(0)
	$AnimationPlayer.play("start")
	w = load("res://scenes/weapons/New/SurvivalWeapons/" + weapon_type + ".tscn").instance()
	w.set_max_ammo(w.get_max_ammo() * max_ammo_ratio)
	w.fire_rate_ratio = fire_rate_ratio
	$Label.text = w.get_weapon_name()

func _physics_process(_delta: float) -> void:
	var t = $Timer.time_left
	$AnimationPlayer2.playback_speed = 10.0 / t

func _on_WeaponPack_body_entered(body: Node) -> void:
	if body.has_method("pick_up_weapon"):
		p = body
		set_process_unhandled_input(true)
		$Label2.show()

func _on_WeaponPack_body_exited(body: Node) -> void:
	if body.has_method("pick_up_weapon"):
		p = null
		set_process_unhandled_input(false)
		$Label2.hide()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pick_up"):
		if p.pick_up_weapon(w):
			collision_mask = 0
			$AnimationPlayer.play("end")

func _on_Timer_timeout() -> void:
	queue_free()
	Butler.summon_explosion_02(global_position)
