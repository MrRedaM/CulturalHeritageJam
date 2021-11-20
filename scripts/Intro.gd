extends CanvasLayer

const logos = ["godot", "global", "chcc", "america"]

var _logo_index = 0

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and _logo_index <= 3:
		$AnimationPlayer.play(logos[_logo_index])
		_logo_index += 1


func _on_AnimationPlayer_animation_finished(anim_name):
	if _logo_index <= 3:
		$AnimationPlayer.play(logos[_logo_index])
		_logo_index += 1
