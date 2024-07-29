extends ProgressBar

var is_filling = true
var fill_speed = 50  # Adjust the speed as needed

func _process(delta):
	if is_filling:
		value += fill_speed * delta
		if value >= max_value:
			is_filling = false
	else:
		value -= fill_speed * delta
		if value <= min_value:
			is_filling = true
