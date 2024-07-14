extends RigidBody2D

var animated_sprite_2d: AnimatedSprite2D

func _ready() -> void:
    animated_sprite_2d = $AnimatedSprite2D as AnimatedSprite2D
    var mob_types := animated_sprite_2d.sprite_frames.get_animation_names()
    var animation_index := randi() % mob_types.size()
    animated_sprite_2d.play(mob_types[animation_index])

func _process(delta: float) -> void:
    pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    queue_free()
