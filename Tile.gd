class_name Tile

var c:= 0
var f:= 0
var b:= 0

func _init(c:=0, f:=0, b:=0):
	self.c = c
	self.f = f
	self.b = b
func draw(sf:GlyphSurface, x:int, y:int):
	Glyphdot.draw_char(sf, x, y, c, f, b)
