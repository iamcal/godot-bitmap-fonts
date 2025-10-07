@tool
## A Font based on a bitmap image.
extends FontFile
class_name BitmapFont

## The image texture containing the font characters.
@export var texture: Texture2D:
	set(new_texture):
		texture = new_texture
		_update_texture()

## The space above the characters, in pixels.
@export var padding_above: int = 0:
	set(new_padding_above):
		padding_above = new_padding_above
		_update_texture()

## The space below the characters, in pixels.
@export var padding_below: int = 0:
	set(new_padding_above):
		padding_above = new_padding_above
		_update_texture()

## The groups of characters represented in the texture
@export var character_blocks: Array[CharacterBlock]:
	set (new_character_blocks):
		character_blocks = new_character_blocks
		_update_texture()


var _fixed_size = 16 # the godot default
var _cache_index = 0
var _texture_index = 0
var _size = Vector2i(_fixed_size, 0)

func _update_texture():
	clear_cache()
	
	if not texture: return
	
	var image = texture.get_image()
	
	# find max height of characters
	var max_h = 0
	for block in character_blocks:
		max_h = max(max_h, block.character_height)
	
	set_texture_image(_cache_index, _size, _texture_index, image)
	set_cache_ascent(_cache_index, _size.x, max_h + padding_above)
	set_cache_descent(_cache_index, _size.x, padding_below)

	for block in character_blocks:
		_add_glyphs(block.characters, block.offset_x, block.offset_y, block.character_width, block.character_height)

func _add_glyphs(characters: String, offset_x: int, offset_y: int, width: int, height: int):

	for i in range (0, characters.length()):

		var glyph = characters.to_ascii_buffer()[i]
		var advance = width
		var rect = Rect2(offset_x+(i*width), offset_y, width, height)
		
		set_glyph_uv_rect(_cache_index, _size, glyph, rect)
		set_glyph_texture_idx(_cache_index, _size, glyph, _texture_index)
		set_glyph_offset(_cache_index, _size, glyph, Vector2(0, -height))
		set_glyph_size(_cache_index, _size, glyph, rect.size)
		set_glyph_advance(_cache_index, _size.x, glyph, Vector2(advance, 0))
