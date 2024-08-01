extends CharacterBody3D

const SPEED = 5.0
const SPRINT_SPEED = 10.0 
const JUMP_VELOCITY = 4.5
const INERTIA = 0.1  # Adjust this value to control the inertia

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var shot_meter

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	shot_meter = $CameraHolder/PlayerCam/ShotMeter

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(event.relative.x * -0.04))
		
	# Manage the shot meter when the input is pressed or released
	if event.is_action_pressed("Shoot"):
		shot_meter.Reset_Start()
	elif event.is_action_released("Shoot"):
		shot_meter.Pause_Fill()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if (Input.is_action_just_pressed("Shoot") or Input.is_action_just_pressed("Jump")) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Movement code only when on the floor
	if is_on_floor():
		# Get the input direction and handle the movement/deceleration.
		var input_dir = Input.get_vector("a", "d", "w", "s")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		# Check if the "Sprint" action is being pressed
		var target_speed = SPEED
		if Input.is_action_pressed("Sprint"):
			target_speed = SPRINT_SPEED
		
		# Use inertia to smoothly change the velocity
		if direction:
			var target_velocity = direction * target_speed
			velocity.x = lerp(float(velocity.x), float(target_velocity.x), INERTIA)
			velocity.z = lerp(float(velocity.z), float(target_velocity.z), INERTIA)
		else:
			velocity.x = lerp(float(velocity.x), 0.0, INERTIA)
			velocity.z = lerp(float(velocity.z), 0.0, INERTIA)
	
	move_and_slide()
