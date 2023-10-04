extends Node2D

var player

var posX
var posY
var offsetX
var offsetY
var offset = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawnEnemies():
	var enemy = preload("res://scenes/enemy.tscn").instantiate()
	if enemy:
		offsetX = randi_range(-1000, 1000)
		offsetY = randi_range(-1000, 1000)
		offset = Vector2(offsetX, offsetY) + player.global_position
		get_tree().current_scene.add_child(enemy)
		enemy.global_position = offset


func _on_spawn_timer_timeout():
	spawnEnemies()
