
class_name Floor
var pos:Vector2i
var tile:Tile
const is_actor = false
signal removed
func _init(pos:Vector2i) -> void:
	self.pos = pos
	tile = Tile.new(254, Color(25./255, 25./255, 36./255, (204. + randf() * 51)/255).to_rgba32(), Color.BLACK.to_rgba32())
