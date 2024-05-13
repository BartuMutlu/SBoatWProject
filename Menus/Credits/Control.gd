extends Control

func _ready():
	var BackButton = $BackButton
	BackButton.pressed.connect(self._on_backbutton_pressed)

func _on_backbutton_pressed():
	get_tree().change_scene_to_file("res://Main Menu/MainMenu.tscn")
