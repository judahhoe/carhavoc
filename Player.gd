extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 1.5
@export var acc = 1000  # Adjust the acceleration value as needed

var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("Left", "Right") * 4
	
	var target_velocity = transform.x * Input.get_axis("Down", "Up") * speed
	
	if Input.is_action_pressed("Down"):
		target_velocity *= 0.2
	elif Input.is_action_pressed("Up"):
		target_velocity *= 0.5
	
	# Apply acceleration
	velocity = velocity.lerp(target_velocity, acc * delta)

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
