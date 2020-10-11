extends Node2D


func _ready():
	#$Button.grab_focus()
	pass


func _on_start_button_down():
	print("start down")
	#$VBoxContainer/Start.grab_focus()
	


func _on_quit_button_down():
	print("quit down")
	#$VBoxContainer/Quit.grab_focus()
	pass 


func _on_Start_mouse_entered():
	$VBoxContainer/Start.grab_focus()
	pass 
