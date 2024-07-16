extends Area2D

class_name Player

signal hit

@export var speed := 400

@onready var screen_size := get_viewport_rect().size
@onready var sprite := $AnimatedSprite2D as AnimatedSprite2D
@onready var collision := $CollisionShape2D as CollisionShape2D

func _ready() -> void:
    hide()

func _process(delta: float) -> void:
    var velocity := Vector2.ZERO

    if Input.is_action_pressed('move_up'):
        velocity.y -= 1
    if Input.is_action_pressed('move_down'):
        velocity.y += 1
    if Input.is_action_pressed('move_left'):
        velocity.x -= 1
    if Input.is_action_pressed('move_right'):
        velocity.x += 1

    if velocity.length() > 0:
        # 斜め移動でも同じスピードになるように予め normalize する
        velocity = velocity.normalized() * speed
        sprite.play()
    else:
        sprite.pause()

    position += velocity * delta
    position = position.clamp(Vector2.ZERO, screen_size)

    if velocity.x != 0 and velocity.y != 0:
        sprite.animation = 'up'
        sprite.flip_h = velocity.y > 0
        sprite.flip_v = velocity.x < 0
    if velocity.x != 0:
        sprite.animation = 'walk'
        sprite.flip_v = false
        sprite.flip_h = velocity.x < 0
    if velocity.y != 0:
        sprite.animation = 'up'
        sprite.flip_v = velocity.y > 0

func _on_body_entered(_body: Node2D) -> void:
    hide()
    hit.emit()
    # 衝突判定の途中でコリジョンを無効化するとエラーが発生するため、
    # フレーム終了時までコリジョン無効化処理を遅延する
    collision.set_deferred('disabled', false)

func start(pos: Vector2) -> void:
    position = pos
    show()
    collision.disabled = false
