extends Area2D

func _on_body_entered(body: Node2D) -> void:
		
	#print("Mphke")
	#if body.is_in_group("fireboy"):
		#queue_free()
	queue_free()
