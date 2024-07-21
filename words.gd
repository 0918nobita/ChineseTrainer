extends Control

const savedata_path := 'user://savedata.json'

var words: Array[Word] = [
    Word.new('你好', 'nǐ hǎo', 'こんにちは'),
    Word.new('谢谢', 'xiè xiè', 'ありがとう'),
    Word.new('再见', 'zài jiàn', 'さようなら'),
]

@onready var grid := $ScrollContainer/GridContainer as GridContainer

func _ready() -> void:
    for i in range(100):
        for word in words:
            var zh_label := Label.new()
            zh_label.text = word.zh
            var pinyin_label := Label.new()
            pinyin_label.text = word.pinyin
            var ja_label := Label.new()
            ja_label.text = word.ja
            grid.add_child(zh_label)
            grid.add_child(pinyin_label)
            grid.add_child(ja_label)

func _process(_delta: float) -> void:
    pass

func save_json(data: Variant) -> void:
    var file := FileAccess.open(savedata_path, FileAccess.WRITE_READ)
    file.store_string(JSON.stringify(data))
    file.close()

func load_json() -> Variant:
    var file := FileAccess.open(savedata_path, FileAccess.READ)
    var content := file.get_as_text()
    file.close()
    return JSON.parse_string(content)
