extends ProgressBar

var filling_meter = false
var paused = false
var release_value = 0.0
const FILL_SPEED = 100.0

@onready var meter_timer = $MeterTimer

func _ready():
	visible = false
	meter_timer.timeout.connect(_on_MeterTimer_timeout)


func Reset_Start():
	value = min_value
	visible = true
	filling_meter = true
	paused = false
	meter_timer.start()

func Pause_Fill():
	release_value = value
	paused = true
	print(release_value)

func _on_MeterTimer_timeout():
	visible = false
	paused = false

func _process(delta):
	if filling_meter and not paused:
		value += FILL_SPEED * delta
		if value >= max_value:
			value = max_value
			filling_meter = false
