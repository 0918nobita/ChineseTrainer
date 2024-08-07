extends Control

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

func _add_row(text: String) -> Label:
    var label := Label.new()
    label.text = text
    label.set_anchors_preset(Control.PRESET_FULL_RECT)
    label.set_label_settings(label_settings)
    return label

func _ready() -> void:
    for word in GameManager.words:
        var zh_label := _add_row(word.zh)
        var pinyin_label := _add_row(word.pinyin)
        var ja_label := _add_row(word.ja)
        rows.add_child(zh_label)
        zh_width = max(zh_width, zh_label.size.x)
        rows.add_child(pinyin_label)
        pinyin_width = max(pinyin_width, pinyin_label.size.x)
        rows.add_child(ja_label)
        ja_width = max(ja_width, ja_label.size.x)

    zh_width = max(zh_width, zh_header.size.x)
    pinyin_width = max(pinyin_width, pinyin_header.size.x)
    ja_width = max(ja_width, ja_header.size.x)
    call_deferred('_layout')

func _layout() -> void:
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
