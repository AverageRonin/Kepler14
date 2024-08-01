extends ProgressBar

var filling_meter = false  # Variable to indicate if the meter is currently filling
var paused = false  # Variable to track if the progress bar is paused
const FILL_SPEED = 100.0  # Speed at which the meter fills, adjust as needed

func _ready():
	visible = false  # Ensure the shot meter is initially hidden

func Reset_Start():
	value = min_value
	visible = true
	filling_meter = true  # Start filling the meter
	paused = false  # Ensure the progress bar is not paused

func Pause_Fill():
	paused = true  # Pause filling the meter

func _process(delta):
	# Fill the meter if filling_meter is true and not paused
	if filling_meter and not paused:
		value += FILL_SPEED * delta
		if value >= max_value:
			value = max_value
			filling_meter = false  # Stop filling the meter when it reaches max_value
