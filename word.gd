class_name Word extends Resource

@export var zh: String
@export var pinyin: String
@export var ja: String

func _init(p_zh: String = '', p_pinyin: String = '', p_ja: String = ''):
    zh = p_zh
    pinyin = p_pinyin
    ja = p_ja
