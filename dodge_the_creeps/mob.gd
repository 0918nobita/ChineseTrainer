extends RigidBody2D

class_name Mob

const Scene := preload('res://dodge_the_creeps/mob.tscn')

static func instantiate() -> Mob:
    return Scene.instantiate() as Mob

@onready var sprite := $AnimatedSprite2D as AnimatedSprite2D

func _ready() -> void:
    var mob_types := sprite.sprite_frames.get_animation_names()
    var animation_index := randi() % mob_types.size()
    sprite.play(mob_types[animation_index])

func _process(_delta: float) -> void:
    pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    queue_free()
