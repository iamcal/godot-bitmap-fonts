@tool
extends Resource
class_name CharacterBlock

## The characters defined by this block, e.g. "ABC".
@export var characters: String

## The x offset within the texture where this character block starts.
@export var offset_x: int

## The y offset within the texture where this character block starts.
@export var offset_y: int

## The width of each character in this block.
@export var character_width: int

## The height of each character in this block.
@export var character_height: int
