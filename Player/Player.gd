extends CharacterBody3D

const SPEED = 5.0
const SPRINT_SPEED = 10.0 
const JUMP_VELOCITY = 4.5
const INERTIA = 0.1  # Adjust this value to control the inertia

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var shot_meter
var hands_full = false
var InteractRay
var Interactable
var current_velocity

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	shot_meter = $CameraHolder/PlayerCam/ShotMeter
	InteractRay = $CameraHolder/PlayerCam/InteractRay

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(event.relative.x * -0.04))
		
	if event.is_action_pressed("Shoot"): # Manage the shot meter when the input is pressed 
		shot_meter.Reset_Start()
	elif event.is_action_released("Shoot"): # or released
		shot_meter.Pause_Fill()
		
	if event.is_action_pressed("Interact"): #Interactions
		if not hands_full:
			InteractRay.InteractNow()
			Interactable = InteractRay.ObjectCollider
			print(Interactable)
			

func _physics_process(delta):
	
	current_velocity = self.velocity.length()
	print(current_velocity)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if (Input.is_action_just_pressed("Shoot") or Input.is_action_just_pressed("Jump")) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if is_on_floor(): 
		var input_dir = Input.get_vector("a", "d", "w", "s") # Get the input direction
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() #Handle the movement/deceleration.
		
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
