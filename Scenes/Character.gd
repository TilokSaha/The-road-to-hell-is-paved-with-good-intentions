extends KinematicBody2D
class_name Character, "res://v1.1 dungeon crawler 16X16 pixel pack/v1.1 dungeon crawler 16X16 pixel pack/heroes/knight/knight_idle_anim_f0.png"

const FRICTION = 0.15

export (int) var hp = 2 setget set_hp
export (int) var accelaration = 400
export (int) var max_speed = 100

signal hp_changed(new_hp)

onready var state_machine = get_node("FiniteStateMachine")
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

var direction = Vector2.ZERO
var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)

func move():
	direction = direction.normalized()
	velocity += direction * accelaration
	velocity = velocity.clamped(max_speed)

func take_damage(damage, dir, force):
	self.hp -= damage
	if hp > 0:
		state_machine.set_state(state_machine.states.hurt)
		velocity += dir * force
	else:
		state_machine.set_state(state_machine.states.dead)
		velocity += dir * force * 2

func set_hp(new_hp):
	hp = new_hp
	emit_signal("hp_changed",new_hp)
	
