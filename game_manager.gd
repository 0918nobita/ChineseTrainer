extends Node

var words_scene := preload('res://words.tscn')

func load_words_scene() -> void:
    get_tree().change_scene_to_packed(words_scene)
