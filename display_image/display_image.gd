extends Node2D

@onready var http_request := $HTTPRequest as HTTPRequest
@onready var texture_rect := $TextureRect as TextureRect

func _ready() -> void:
    var error := http_request.request('https://via.placeholder.com/512')
    if error != OK:
        push_error('Failed to request')

func _process(_delta: float) -> void:
    pass

func _on_http_request_request_completed(result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
    if result != HTTPRequest.RESULT_SUCCESS:
        push_error('Failed to fetch image')
        return
    var image := Image.new()
    var error := image.load_png_from_buffer(body)
    if error != OK:
        push_error('Failed to load image')
        return
    var texture := ImageTexture.create_from_image(image)
    texture_rect.texture = texture
