extends Control

#const savedata_path := 'user://savedata.json'

var words: Array[Word] = [
    Word.new('你好', 'nǐ hǎo', 'こんにちは'),
    Word.new('谢谢', 'xiè xiè', 'ありがとう'),
    Word.new('再见', 'zài jiàn', 'さようなら'),
    Word.new('了', 'le', 'めっっっっっっっっっっっっっっっっっっっっっっちゃ長い説明')
]

@onready var vscroll := $%VScroll as ScrollContainer
@onready var hscroll := $%HScroll as ScrollContainer
@onready var hscroll_bar := $%HScrollBar as HScrollBar
@onready var rows := $%Rows as GridContainer
@onready var zh_header := $%Header/Zh as Label
@onready var pinyin_header := $%Header/Pinyin as Label
@onready var ja_header := $%Header/Ja as Label

var zh_width := 0
var pinyin_width := 0

func _ready() -> void:
    hscroll.get_h_scroll_bar().value_changed.connect(_on_hscroll)

    for i in range(100):
        for word in words:
            var zh_label := Label.new()
            zh_label.text = word.zh
            zh_label.set_anchors_preset(Control.PRESET_FULL_RECT)
            var pinyin_label := Label.new()
            pinyin_label.text = word.pinyin
            pinyin_label.set_anchors_preset(Control.PRESET_FULL_RECT)
            var ja_label := Label.new()
            ja_label.text = word.ja
            ja_label.set_anchors_preset(Control.PRESET_FULL_RECT)
            rows.add_child(zh_label)
            zh_width = max(zh_width, zh_label.size.x)
            rows.add_child(pinyin_label)
            pinyin_width = max(pinyin_width, pinyin_label.size.x)
            rows.add_child(ja_label)

    call_deferred('layout')

func layout() -> void:
    for i_row in range(rows.get_child_count() / 3):
        var zh_cell := rows.get_child(i_row * 3) as Label
        zh_cell.custom_minimum_size.x = max(zh_header.size.x, zh_width)
        var pinyin_cell := rows.get_child(i_row * 3 + 1) as Label
        pinyin_cell.custom_minimum_size.x = max(pinyin_header.size.x, pinyin_width)

    zh_header.custom_minimum_size.x = max(zh_header.size.x, zh_width)
    pinyin_header.custom_minimum_size.x = max(pinyin_header.size.x, pinyin_width)

    _update_h_scroll_bar()
    resized.connect(_update_h_scroll_bar)
    hscroll_bar.value_changed.connect(_hscroll_bar_changed)

func _process(_delta: float) -> void:
    pass

func _update_h_scroll_bar() -> void:
    await get_tree().process_frame
    var inner_hscroll_bar := hscroll.get_h_scroll_bar()
    if inner_hscroll_bar.max_value > inner_hscroll_bar.page:
        if !hscroll_bar.visible:
            hscroll_bar.visible = true
        hscroll_bar.page = inner_hscroll_bar.page
        hscroll_bar.value = inner_hscroll_bar.value
        hscroll_bar.min_value = inner_hscroll_bar.min_value
        hscroll_bar.max_value = inner_hscroll_bar.max_value
    else:
        if hscroll_bar.visible:
            hscroll_bar.visible = false

func _on_hscroll(val: int) -> void:
    hscroll_bar.value = val

func _hscroll_bar_changed(val: int) -> void:
    hscroll.scroll_horizontal = val

#func save_json(data: Variant) -> void:
    #var file := FileAccess.open(savedata_path, FileAccess.WRITE_READ)
    #file.store_string(JSON.stringify(data))
    #file.close()

#func load_json() -> Variant:
    #var file := FileAccess.open(savedata_path, FileAccess.READ)
    #var content := file.get_as_text()
    #file.close()
    #return JSON.parse_string(content)
