extends CharacterBody2D

var wheel_base = 200  # Distance from front to rear wheel
var steering_angle = 15  # Amount that front wheel turns, in degrees

var steer_angle
var engine_power = 1200  # Forward acceleration force.

var acceleration = Vector2.ZERO
var friction = -0.8
var drag = -0.0015
var braking = -450
var max_speed_reverse = 500
var slip_speed = 100  # Speed where traction is reduced
var traction_fast = 0.06  # High-speed traction
var traction_slow = 0.3  # Low-speed traction

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	PlayerGlobalVars.PlayerSpeed = velocity.length()
	move_and_slide()

func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	if velocity.length() < 100:
		friction_force *= 3
	acceleration += drag_force + friction_force

func get_input():
	var turn = 0
	if Input.is_action_pressed("Right"):
		turn += 1
	if Input.is_action_pressed("Left"):
		turn -= 1
	steer_angle = turn * steering_angle
	if Input.is_action_pressed("Up"):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("Down"):
		acceleration = transform.x * braking



func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_angle) * delta
	var new_heading = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		set_velocity(velocity.lerp(new_heading * velocity.length(), traction))
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()
