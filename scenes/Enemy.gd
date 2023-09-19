extends CharacterBody2D

var blood_particles = preload("res://scenes/blood_particles.tscn").instantiate()

var target = null
const speed = 100

func _physics_process(delta):
	if target:
		var velocity = global_position.direction_to(target.global_position)
		look_at(target.global_position)
		move_and_collide(velocity * speed * delta)


func _on_area_2d_body_entered(body):
	print(body.name)
	target = body


func _on_area_2d_body_exited(body):
	print(body.name)
	target = null

func explode():
	if blood_particles:
		get_tree().current_scene.add_child(blood_particles)
		blood_particles.global_position = self.global_position
	queue_free()


func _on_hitbox_body_entered(body):
	explode()
