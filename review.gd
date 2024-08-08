extends Control

@onready var zhWord := $%ZhWord as Label

func _ready() -> void:
    var rand_index := randi() % GameManager.words.size()
    var word := GameManager.words[rand_index]
    zhWord.text = word.zh

func _process(_delta: float) -> void:
    pass
