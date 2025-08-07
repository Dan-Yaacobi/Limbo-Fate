class_name ScreenController extends Node

var curr_screen: Screen
var prev_screen: Screen

func change_screen(next_screen: Screen) -> void:
	prev_screen = curr_screen
	curr_screen = next_screen
	curr_screen.init_screen()
