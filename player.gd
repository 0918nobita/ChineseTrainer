extends Area2D

signal hit

@export var speed := 400
var screen_size: Vector2
var animated_sprite_2d: AnimatedSprite2D
var collision_shape_2d: CollisionShape2D

func _ready() -> void:
    hide()
    screen_size = get_viewport_rect().size
    animated_sprite_2d = $AnimatedSprite2D as AnimatedSprite2D
    collision_shape_2d = $CollisionShape2D as CollisionShape2D

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
        animated_sprite_2d.play()
    else:
        animated_sprite_2d.pause()

    position += velocity * delta
    position = position.clamp(Vector2.ZERO, screen_size)

    if velocity.x != 0 and velocity.y != 0:
        animated_sprite_2d.animation = "up"
        animated_sprite_2d.flip_h = velocity.y > 0
        animated_sprite_2d.flip_v = velocity.x < 0
    if velocity.x != 0:
        animated_sprite_2d.animation = "walk"
        animated_sprite_2d.flip_v = false
        animated_sprite_2d.flip_h = velocity.x < 0
    if velocity.y != 0:
        animated_sprite_2d.animation = "up"
        animated_sprite_2d.flip_v = velocity.y > 0

func _on_body_entered(body: Node2D) -> void:
    hide()
    hit.emit()
    # 衝突判定の途中でコリジョンを無効化するとエラーが発生するため、
    # フレーム終了時までコリジョン無効化処理を遅延する
    collision_shape_2d.set_deferred("disabled", false)

func start(pos: Vector2) -> void:
    position = pos
    show()
    collision_shape_2d.disabled = false
