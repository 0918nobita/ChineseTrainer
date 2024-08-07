extends Node

var words_scene := preload('res://word_list.tscn')

var review_scene := preload('res://review.tscn')

var words: Array[Word] = [
    Word.new('不了', 'bù le', '結構です'),
    Word.new('认识', 'rèn shi', '知り合う'),
    Word.new('获得', 'huò dé', '獲得する'),
    Word.new('校长', 'xiào zhǎng', '校長'),
]

func load_words_scene() -> void:
    get_tree().change_scene_to_packed(words_scene)

func load_review_scene() -> void:
    get_tree().change_scene_to_packed(review_scene)
