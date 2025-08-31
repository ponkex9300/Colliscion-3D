
extends Node2D

var vulnerable = false
var health := 3
func _on_hitbox_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		if vulnerable:
			health -= 1
			if health <= 0:
				queue_free()
			return
		# No hacer daño al jugador si el enemigo es vulnerable

func set_vulnerable(value: bool) -> void:
	vulnerable = value
	if vulnerable:
		timer.stop()
	else:
		# Si el jugador está en el área de activación, reanudar disparos
		if animation_player.current_animation == "Active":
			timer.start()

var rn = RandomNumberGenerator.new()
const FireballScene = preload("res://scenes/fireball.tscn")

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	add_to_group("enemies")
	timer.one_shot = true
	timer.wait_time = rn.randi_range(1, 3)
	timer.stop()
	animation_player.play("Idle")

func shoot_fireball():
	var fireball_instance = FireballScene.instantiate()
	get_parent().add_child(fireball_instance)
	fireball_instance.global_position = global_position
	fireball_instance.direction = Vector2(rn.randf_range(-1, 1), rn.randf_range(-1, 1))
	fireball_instance.speed = rn.randi_range(30, 200)

func _on_timer_timeout() -> void:
	shoot_fireball()
	timer.wait_time = rn.randi_range(1, 3)
	timer.start()

func _on_activate_zone_body_entered(body: Node2D) -> void:
	animation_player.play("Active")
	if not vulnerable:
		timer.start()

func _on_activate_zone_body_exited(body: Node2D) -> void:
	animation_player.play("Idle")
	timer.stop()
