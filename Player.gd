class_name  Player


var tile := Tile.new('@'.to_ascii_buffer()[0], Color.MAGENTA.to_rgba32(), Color.BLACK.to_rgba32())
var visibleTiles := {}
var pos := Vector2i(0, 0)

signal removed
const is_actor := true
func updateTick():
	visibleTiles.clear()
	visibleTiles[pos] = tile
	pass
