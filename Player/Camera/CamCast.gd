extends RayCast3D


func _process(_delta):
	if self.is_colliding():
		if self.get_collider().is_in_group("Interactable"):
			print("Interactable object")
