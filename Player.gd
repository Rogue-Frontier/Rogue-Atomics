class_name  Player

var world:World

var tile := Tile.new('@'.to_ascii_buffer()[0], Color.MAGENTA.to_rgba32(), Color.BLACK.to_rgba32())
var visibleTiles := {}
var pos := Vector2i(0, 0)

var busy := false

signal removed
const is_actor := true
func updateTick():
	visibleTiles.clear()
	visibleTiles[pos] = tile
	for e in world.entities:
		visibleTiles[e.pos] = e.tile
	busy = false
	return []
