extends Node2D

@onready var player := $Player as Player
@onready var hud := $HUD as HUD
@onready var score_timer := $ScoreTimer as Timer
@onready var mob_timer := $MobTimer as Timer
@onready var start_timer := $StartTimer as Timer
@onready var start_position := $StartPosition as Marker2D
@onready var mob_spawn_location := $MobPath/MobSpawnLocation as PathFollow2D

var score: int

func _ready() -> void:
    pass

func _process(_delta: float) -> void:
    pass

func game_over() -> void:
    score_timer.stop()
    mob_timer.stop()
    hud.show_game_over()

func new_game() -> void:
    score = 0
    player.start(start_position.position)
    start_timer.start()
    hud.update_score(score)
    hud.show_message('Get Ready')
    await get_tree().create_timer(2.0).timeout
    hud.hide_message()

func _on_score_timer_timeout() -> void:
    score += 1
    hud.update_score(score)

func _on_start_timer_timeout() -> void:
    mob_timer.start()
    score_timer.start()

func _on_mob_timer_timeout() -> void:
    var mob := Mob.instantiate()
    mob_spawn_location.progress_ratio = randf()

    var direction := mob_spawn_location.rotation + PI / 2
    direction += randf_range(-PI / 4, PI / 4)

    mob.position = mob_spawn_location.position
    mob.rotation = direction

    var velocity := Vector2(randf_range(150.0, 250.0), 0.0)
    mob.linear_velocity = velocity.rotated(direction)

    add_child(mob)
