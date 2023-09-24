extends CharacterBody2D

class_name enemy_class

var blood_particles = preload("res://scenes/blood_particles.tscn").instantiate()

var target = null
const speed = 100
var player = preload("res://scenes/player.tscn").instantiate()

func _physics_process(delta):
	if target:
		var velocity = global_position.direction_to(target.global_position)
		look_at(target.global_position)
		move_and_collide(velocity * speed * delta)


func _on_area_2d_body_entered(body):
	target = body


func _on_area_2d_body_exited(body):
	target = null

func explode():
	queue_free()
	if blood_particles:
		get_tree().current_scene.add_child(blood_particles)
		blood_particles.global_position = self.global_position
	queue_free()


func _on_hitbox_area_entered(area):
	if (area.name == "DmgBox"):
		print(PlayerGlobalVars.PlayerSpeed)
		if (PlayerGlobalVars.PlayerSpeed >= 600) :
			explode()


