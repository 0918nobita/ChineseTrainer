extends Node2D

const savedata_path := 'user://savedata.json'

func save_json(data: Variant) -> void:
    var file := FileAccess.open(savedata_path, FileAccess.WRITE_READ)
    file.store_string(JSON.stringify(data))
    file.close()

func load_json() -> Variant:
    var file := FileAccess.open(savedata_path, FileAccess.READ)
    var content := file.get_as_text()
    file.close()
    return JSON.parse_string(content)

func _ready() -> void:
    save_json(JSON.stringify([{"id": "0", "zh": "然后", "ja": "それから"}]))
    # var data = load_json()
    # print(data)

func _process(_delta: float) -> void:
    pass
