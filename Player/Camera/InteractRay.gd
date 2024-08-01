extends RayCast3D

var Interacting = false

func _process(_delta):
	if self.is_colliding() and self.get_collider().is_in_group("Interactable"):
		if not Interacting:
			Interacting = true
			print(Interacting)  # Replace with function call
	else:
		Interacting = false
