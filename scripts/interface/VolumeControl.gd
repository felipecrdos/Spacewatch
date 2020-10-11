extends HBoxContainer


var lable
var plus_btn
var minus_btn
var bars
var volume
var max_volume
var min_volume
var offset
var volume_data

export (String) var text_lable = "default" setget set_text_label
export (String) var text_plus_btn = "button +" setget set_text_plus_btn
export (String) var text_minus_btn = "button -" setget set_text_minus_btn
export (String) var bus_name = "Master" setget set_bus_name

func _ready():
	lable = $Lable
	plus_btn = $HControl/BtnPlus
	minus_btn = $HControl/BtnMinus
	bars = $MBars/HBars.get_children()
	volume = 0
	offset = 4
	max_volume = 0
	min_volume = -80
	
	lable.text = text_lable
	plus_btn.text = text_plus_btn
	minus_btn.text = text_minus_btn
	volume_data = Global.option_data["volume"]
	
	restore_bars()
	
func set_text_label(text:String):
	text_lable = text
func set_text_plus_btn(text:String):
	text_plus_btn = text
func set_text_minus_btn(text:String):
	text_minus_btn = text
func set_bus_name(text:String):
	bus_name = text
	
func on_plus_button_down():
	if volume < max_volume:
		bars[volume/offset].modulate.a = 1
		volume += offset
		SoundManager.set_bus_volume(bus_name, volume)
		SoundManager.play_sfx("ChooseButton")
		volume_data[bus_name] = volume
		
func on_minus_button_down():
	if volume > min_volume:
		volume -= offset
		SoundManager.set_bus_volume(bus_name, volume)
		bars[volume/offset].modulate.a = 0
		SoundManager.play_sfx("ChooseButton")
		volume_data[bus_name] = volume
		
func restore_bars():
	#volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus_name))
	volume = volume_data[bus_name]
	for i in range(-1, volume/offset-1, -1):
		bars[i].modulate.a = 0
		
func on_btnplus_mouse_entered():
	plus_btn.grab_focus()
	
func on_btnminus_mouse_entered():
	minus_btn.grab_focus()

func on_btnplus_focus_entered():
	SoundManager.play_sfx("ChooseButton")

func on_btnminus_focus_entered():
	SoundManager.play_sfx("ChooseButton")
