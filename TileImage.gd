class_name TileImage

class PosTile:
	var pos:Vector2
	var tile:Tile
	func _init(pos:Vector2, tile:Tile) -> void:
		self.pos = pos
		self.tile = tile
static func abgr32_to_rgba32(n:int) -> int:
	return Color(
		((n & 0x000000FF) >> 00) / 255.,
		((n & 0x0000FF00) >> 08) / 255.,
		((n & 0x00FF0000) >> 16) / 255.,
		((n & 0xFF000000) >> 24) / 255.
		).to_rgba32()
static func load(path:String) -> Dictionary:
	assert(FileAccess.file_exists(path))
	var obj = JSON.parse_string(FileAccess.get_file_as_string(path))
	var img := {}
	for tile:String in obj["$values"] as Array[String]:
		var i := tile.split(" ")
		var x := int(i[0])
		var y := int(i[1])
		var f := Color.html(i[2]).to_rgba32()
		var b := Color.html(i[3]).to_rgba32()
		var g := int(i[4])
		img[Vector2i(x,y)] = Tile.new(g, f, b)
	return img
