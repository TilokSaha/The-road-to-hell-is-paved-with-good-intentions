extends Area2D
class_name Hitbox

export (int) var damage : int = 1
var knockback_direction : Vector2 = Vector2.ZERO
export (int) var knockback_force : int = 300

onready var collision_shape = get_child(0)

func _init():
	connect("body_entered", self, "_on_body_entered")

func _ready():
	assert(collision_shape != null)
	
func _on_body_entered(body):
	 body.take_damage(damage, knockback_direction, knockback_force)
