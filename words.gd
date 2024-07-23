extends Control

#const savedata_path := 'user://savedata.json'

var words: Array[Word] = [
    Word.new('你好', 'nǐ hǎo', 'こんにちは'),
    Word.new('谢谢', 'xiè xiè', 'ありがとう'),
    Word.new('再见', 'zài jiàn', 'さようなら'),
    Word.new('了', 'le', 'めっっっっっっっっっっっっっっっっっっっっっっちゃ長い説明')
]

@onready var header_scroll := $%HeaderScroll as ScrollContainer
@onready var header := $%Header as GridContainer
@onready var zh_header := $%Header/Zh as Label
@onready var pinyin_header := $%Header/Pinyin as Label
@onready var ja_header := $%Header/Ja as Label
@onready var scroll := $%Scroll as ScrollContainer
@onready var rows := $%Rows as GridContainer

var label_settings := preload("res://font.tres")

var zh_width := 0
var pinyin_width := 0
var ja_width := 0

func _ready() -> void:
    for i in range(100):
        for word in words:
            var zh_label := Label.new()
            zh_label.text = word.zh
            zh_label.set_anchors_preset(Control.PRESET_FULL_RECT)
            zh_label.set_label_settings(label_settings)
            var pinyin_label := Label.new()
            pinyin_label.text = word.pinyin
            pinyin_label.set_anchors_preset(Control.PRESET_FULL_RECT)
            pinyin_label.set_label_settings(label_settings)
            var ja_label := Label.new()
            ja_label.text = word.ja
            ja_label.set_anchors_preset(Control.PRESET_FULL_RECT)
            ja_label.set_label_settings(label_settings)
            rows.add_child(zh_label)
            zh_width = max(zh_width, zh_label.size.x)
            rows.add_child(pinyin_label)
            pinyin_width = max(pinyin_width, pinyin_label.size.x)
            rows.add_child(ja_label)
            ja_width = max(ja_width, ja_label.size.x)

    zh_width = max(zh_width, zh_header.size.x)
    pinyin_width = max(pinyin_width, pinyin_header.size.x)
    ja_width = max(ja_width, ja_header.size.x)
    call_deferred('layout')

func layout() -> void:
    for i_row in range(rows.get_child_count() / 3):
        var zh_cell := rows.get_child(i_row * 3) as Label
        zh_cell.custom_minimum_size.x = zh_width
        var pinyin_cell := rows.get_child(i_row * 3 + 1) as Label
        pinyin_cell.custom_minimum_size.x = pinyin_width
        var ja_cell := rows.get_child(i_row * 3 + 2) as Label
        ja_cell.custom_minimum_size.x = ja_width

    zh_header.custom_minimum_size.x = zh_width
    pinyin_header.custom_minimum_size.x = pinyin_width
    ja_header.custom_minimum_size.x = ja_width

    scroll.get_h_scroll_bar().value_changed.connect(_on_h_scroll)

func _process(_delta: float) -> void:
    pass

func _on_h_scroll(val: int) -> void:
    header_scroll.scroll_horizontal = val

#func save_json(data: Variant) -> void:
    #var file := FileAccess.open(savedata_path, FileAccess.WRITE_READ)
    #file.store_string(JSON.stringify(data))
    #file.close()

#func load_json() -> Variant:
    #var file := FileAccess.open(savedata_path, FileAccess.READ)
    #var content := file.get_as_text()
    #file.close()
    #return JSON.parse_string(content)
