extends Control

func _ready() -> void:
    pass

func _process(_delta: float) -> void:
    pass

func _on_open_word_list_button_pressed() -> void:
    GameManager.load_words_scene()

func _on_start_review_button_pressed() -> void:
    GameManager.load_review_scene()
