extends CanvasLayer

class_name HUD

signal start_game

@onready var score_label := $ScoreLabel as Label
@onready var message := $Message as Label
@onready var start_button := $StartButton as Button

func show_message(text: String) -> void:
    message.text = text
    message.show()

func hide_message() -> void:
    message.hide()

func show_game_over() -> void:
    show_message('Game Over')
    message.text = 'Dodge the creeps!'
    message.show()
    await get_tree().create_timer(1.0).timeout
    start_button.show()

func update_score(score: int) -> void:
    score_label.text = str(score)

func _ready() -> void:
    pass

func _process(_delta: float) -> void:
    pass

func _on_start_button_pressed() -> void:
    start_button.hide()
    start_game.emit()
