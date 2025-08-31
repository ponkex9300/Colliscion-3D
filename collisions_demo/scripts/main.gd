extends Node2D

@onready var door: Area2D = $Door
@onready var world = $World
var gem_scene = preload("res://scenes/gem.tscn")
var gem_timer: Timer

func _ready() -> void:
	$Key.collected.connect(on_key_collected)

	# Conectar la gema ya presente en la escena
	var gem = $World/Gem
	gem.collected.connect(_on_gem_collected)

	# Crear timer para vulnerabilidad
	gem_timer = Timer.new()
	gem_timer.wait_time = 5.0
	gem_timer.one_shot = true
	gem_timer.connect("timeout", Callable(self, "_on_gem_timer_timeout"))
	add_child(gem_timer)
func _on_gem_collected(body):
	# Hacer vulnerables a los enemigos
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.set_vulnerable(true)
	gem_timer.start()

func _on_gem_timer_timeout():
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.set_vulnerable(false)
	
func on_key_collected():
	door.open()
