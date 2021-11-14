class_name Utils

const INT_MAX = 2 ^ 63 - 1
const INT_MIN = -2 ^ 63

static func angle_diff(a:float, b:float) -> float:
	a = fposmod(a + PI, TAU) - PI;
	b = fposmod(b + PI, TAU) - PI;
	var d = b - a;
	return d if (abs(d) < PI) else (sign(-d) * TAU + d)
	#Alternative Solution
	#Vector2.RIGHT.rotated(a).angle_to(Vector2.RIGHT.rotated(b))

#reference: https://www.gamedeveloper.com/programming/predictive-aim-mathematics-for-ai-targeting
static func aim_predict(target_pos:Vector2, target_velocity:Vector2, bullet_pos:Vector2, bullet_speed:float, bullet_accel := 0.0, target_accel := 0.0) -> Vector2:
	var t:float
	var p2 := target_pos
	for i in 10:
		t = _get_t((p2 - bullet_pos).length(), bullet_speed, bullet_accel)
		p2 = target_pos + target_velocity * t + 0.5 * t * t * target_velocity.normalized() * target_accel
	return (p2 - bullet_pos).normalized()

static func _get_t(l:float, v:float, a:float) -> float:
	if a == 0.0: return l / v
	var d = sqrt(v * v + 2 * a * l)
	return max((-v + d) / a, (-v - d) / a)

static func get_team_mask(team:int):
	return 1 << (20 + team)
