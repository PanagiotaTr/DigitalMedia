extends Node2D

signal toggled(state: bool)

var player_in_range: bool = false
var is_on: bool = false

@onready var interaction_area: Area2D = $InteractionArea
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)
	_update_visual()

func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		print("Mphke")
		activate()

func activate() -> void:
	is_on = not is_on
	_update_visual()
	toggled.emit(is_on)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false

func _update_visual() -> void:
	if is_on:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
