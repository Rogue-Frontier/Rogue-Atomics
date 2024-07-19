class_name Glyphdot
static func fill(sf:GlyphSurface, c := 0, f := 0, b := 0):
	for x in sf.grid_width:
		for y in sf.grid_height:
			sf.set_cell(x, y, c, f, b)
static func draw_string(sf: GlyphSurface, x:int, y:int, s:String, f:=0xFFFFFFFF, b:=0x000000FF):
	for c:int in s.to_ascii_buffer():
		draw_char(sf, x, y, c, f, b)
		x += 1
		if x == sf.grid_width:
			x = 0
			y += 1
static func draw_char(sf:GlyphSurface, x:int,y:int,c:int,f:=0xFFFFFFFF, b:=0x000000FF):
	sf.set_cell(x,y,c,Color.hex(f), Color.hex(b))
