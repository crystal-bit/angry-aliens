extends Node


export(bool) var change_aspect_ratio_only


func _on_DebugOptions_resolution_selected(res) -> void:
	var default_size = Vector2(
		ProjectSettings.get("display/window/size/width"),
		ProjectSettings.get("display/window/size/height")
	)

	var target_aspect_ratio = res[0] / res[1]

	if change_aspect_ratio_only:
		# get_viewport().size = Vector2(default_size.y * target_aspect_ratio, default_size.y)
		OS.window_size = Vector2(default_size.y * target_aspect_ratio, default_size.y)
	else:
		# get_viewport().size = Vector2(res[0], res[1])
		OS.window_size = Vector2(res[0], res[1])
