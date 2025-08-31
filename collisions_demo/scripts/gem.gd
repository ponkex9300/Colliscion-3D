extends Area2D

signal collected

func _on_body_entered(body: Node) -> void:
	collected.emit(body)
	queue_free()
