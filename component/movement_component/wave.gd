extends MovementComponent

var delta_wave = 0.0
var wave_speed = 5
var wave_amplitude = 0.4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta_wave += delta * wave_speed
	delta_wave = int(delta_wave * 1000)  % int(TAU * 1000)
	delta_wave = float(delta_wave) / 1000.0
	pass

func get_velocity(vector) -> Vector2:
	return Vector2(vector.x + sin(delta_wave) * wave_amplitude, vector.y)
