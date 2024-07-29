extends Node3D

var min_pitch = deg_to_rad(-80) # Minimum pitch angle (in radians)
var max_pitch = deg_to_rad(80)  # Maximum pitch angle (in radians)
var current_pitch = 0.0         # Current pitch angle

# Mouse Up and Down
func _input(event):
	if event is InputEventMouseMotion:
		# Calculate the new pitch rotation
		var pitch_delta = deg_to_rad(event.relative.y * -0.04)
		current_pitch = clamp(current_pitch + pitch_delta, min_pitch, max_pitch)
		
		# Apply the rotation
		rotation.x = current_pitch
