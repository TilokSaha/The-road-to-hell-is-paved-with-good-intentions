extends Node2D

const SPAWN_EXPLOSION_SCENE: PackedScene = preload("res://Scenes/SpawnExplosion.tscn")
const ENEMY_SCENE: Dictionary = {
	"FLYING_CREATURE" : preload("res://Scenes/FlyingCreature.tscn")
}

var num_enemies: int

onready var tilemap: TileMap = get_node("TileMap")
onready var entrance: Node2D = get_node("Entrance")
onready var door_container: Node2D = get_node("Doors")
onready var enemy_position_container:Node2D = get_node("EnemyPositions")
onready var player_detector: Area2D = get_node("PlayerDetector")
onready var navi: Navigation2D = get_node("Navigation2D")

func _ready():
	num_enemies = enemy_position_container.get_child_count()
	
func _on_enemy_killed():
	num_enemies -= 1
	if num_enemies == 0:
		_open_doors()

func _open_doors():
	for door in door_container.get_children():
		door.open()

func _close_entrance():
	for entry_position in entrance.get_children():
		tilemap.set_cellv( tilemap.world_to_map ( entry_position.position ) , 3 )
		tilemap.set_cellv( tilemap.world_to_map ( entry_position.position ) + Vector2.DOWN , 3 )
		
func _spawn_enemies():
	for enemy_position in enemy_position_container.get_children():
		var enemy: KinematicBody2D = ENEMY_SCENE.FLYING_CREATURE.instance()
		var __ = enemy.connect("tree_exited", self, "_on_enemy_killed")
		enemy.position = enemy_position.position
		#call_deferred("add_child", enemy)
		navi.add_child(enemy)		
		var spawn_explosion: AnimatedSprite = SPAWN_EXPLOSION_SCENE.instance()
		spawn_explosion.position = enemy_position.position
		call_deferred("add_child", spawn_explosion)


func _on_PlayerDetector_body_entered(body):
	player_detector.queue_free()
	if num_enemies > 0 :
		_close_entrance()
		_spawn_enemies()
	else:
		_open_doors()
