extends Character

onready var sword = get_node("Sword")
onready var sword_animation = sword.get_node("SwordAnimation")
onready var sword_hitbox = get_node("Sword/Node2D/Sprite/Hitbox")

func _process(delta):
	var mouse_direction = (get_global_mouse_position() - global_position).normalized()
	
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and !animated_sprite.flip_h:
		animated_sprite.flip_h = true
	
	sword.rotation = mouse_direction.angle()
	sword_hitbox.knockback_direction = mouse_direction
	if sword.scale.y == 1 and mouse_direction.x > 0 :
		sword.scale.y = -1
	elif sword.scale.y == -1 and mouse_direction.x < 0:
		sword.scale.y = 1
		
	

func get_input():
	direction =Vector2( Input.get_action_strength("ui_right") -   Input.get_action_strength("ui_left") ,
						Input.get_action_strength("ui_down")    -   Input.get_action_strength("ui_up") ).normalized()
	
	if Input.is_action_just_pressed("ui_attack"):
		sword_animation.play("Attack")
		
func switch_camera():
	var main_scene_camera: Camera2D = get_parent().get_node("Camera2D")
	main_scene_camera.position = position
	main_scene_camera.current = true
	get_node("Camera2D").current = false
