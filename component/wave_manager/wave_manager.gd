extends Node2D
class_name WaveManager
var entities: Array[Entity] = []
var waves : Array[WaveManager] = []
@export var duration = 1.0
@export var depend_on: WaveManager = null
@export var depend_on_start : bool = true
@export var disabled = false
@export var winning_wave = false
var timer = Timer.new()
var finished = false
var ready_wave = true

var has_started = false


signal on_winning_wave

func _ready():
	show()
	timer.set_wait_time(duration)
	timer.timeout.connect(start_wave)
	timer.one_shot = true
	add_child(timer)
	for node in get_children():
		if node is WaveManager:
			node.ready_wave = false
			waves.append(node)
		if node is Entity:
			entities.append(node)
	if disabled:
		disable()
		return
	pass

func disable():
	disabled = true
	timer.stop()
	for wave in waves:
		wave.disable()
	pass

func reset():
	finished = false
	ready_wave = true
	has_started = false
	timer.stop()
	for entity in entities:
		entity.reset()
	for wave in waves:
		wave.reset()
		wave.ready_wave = false
	pass

func _process(delta: float):
	if disabled:
		return
	if finished or not ready_wave or timer.time_left > 0:
		return

	if !has_started:
		if depend_on:
			depend_start()
		elif duration > 0:
			timer.start()
		else:
			start_wave()
		return
	
	#winning condition
	for entity in entities:
		if entity != null and entity.enable:
			return
	for wave in waves:
		if not wave.finished:
			return

	finished = true
	if winning_wave:
		handle_winning_wave()
pass

func depend_start():
	if depend_on.finished and !depend_on_start:
		timer.start()
	if depend_on_start and depend_on.has_started:
		timer.start()

func start_wave():
	has_started = true
	for entity in entities:
		entity.start()
	for wave in waves:
		wave.ready_wave = true
	pass

func handle_winning_wave():
	LevelGlobal.win_level()
	pass