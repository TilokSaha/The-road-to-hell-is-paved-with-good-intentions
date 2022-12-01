extends Character
class_name Enemy, "res://v1.1 dungeon crawler 16X16 pixel pack/v1.1 dungeon crawler 16X16 pixel pack/enemies/goblin/goblin_idle_anim_f0.png"

var path: PoolVector2Array

onready var _agent = $NavigationAgent2D
onready var navigation: Navigation2D = get_tree().current_scene.get_node("Rooms")
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")
onready var path_timer: Timer = get_node("Timer")

func _ready():
	_agent.set_target_location(player.global_position)

#func chase():
#	if path:
#		#print(path)
#		var vector_to_next_point =  path[0] - global_position
#		var distance_to_next_point = vector_to_next_point.length()
#
#		if distance_to_next_point < 1 :
#			path.remove(0)
#			if not path:
#				return
#		direction = vector_to_next_point
#
#		if direction.x > 0 and animated_sprite.flip_h:
#			animated_sprite.flip_h = false
#		elif direction.x < 0 and not animated_sprite.flip_h:
#			animated_sprite.flip_h = true

func chase():
	direction = global_position.direction_to(_agent.get_next_location())
	if direction.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
	elif direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true



func _on_Timer_timeout():
	
	if is_instance_valid(player):	
		_agent.set_target_location(player.global_position)
	
#	if is_instance_valid(player):
#		path = navigation.get_simple_path(global_position, player.position, false)
#	else:
#		path_timer.stop()
#		path = []
#		direction = Vector2.ZERO
