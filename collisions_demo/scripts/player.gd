extends CharacterBody2D
signal health_changed(new_health)

func _ready() -> void:
	add_to_group("player")

@export var max_health: int = 3
var health: int = max_health

# PROPERTIES
@export var speed: float = 300.0
@export var jump_velocity: float = -400.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var state_machine = $AnimationTree.get("parameters/playback")

enum {
	WALK,
	DUCK,
	JUMP,
	IDLE
}

var state = IDLE

func _physics_process(delta: float) -> void:
	# add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		state_machine.travel("Jump")
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		state_machine.travel("Jump")
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		state_machine.travel("Walk")
		if direction < 0:
			$Sprite2D.scale.x = abs($Sprite2D.scale.x) * -1
		elif direction > 0:
			$Sprite2D.scale.x = abs($Sprite2D.scale.x)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		state_machine.travel("Idle")
		
	move_and_slide()

	if has_node("PickupArea"):
		for area in $PickupArea.get_overlapping_areas():
			if area.name == "Key":
				if area.has_method("_on_body_entered"):
					area._on_body_entered(self)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	take_damage(1)

func take_damage(amount: int) -> void:
	health -= amount
	print("OUCH! Vida restante:", health)
	emit_signal("health_changed", health)
	if health <= 0:
		_die()

func _die() -> void:
	print("¡Has muerto!")
	queue_free()
