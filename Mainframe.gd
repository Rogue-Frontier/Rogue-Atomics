extends Node
@onready var main :GlyphSurface= $Main
@onready var readout :GlyphSurface= $Readout

@onready var center := main.grid_size / 2
var world:World
var player:Player

func _ready() -> void:
	world = World.new()
	player = Player.new()
	for x in range(0, 30):
		for y in range(0, 30):
			world.add_entity(Floor.new(Vector2i(x,y)))
	world.add_entity(player)
	world.try_update_present()
	world.updateTick()
func _process(delta: float) -> void:
	Glyphdot.fill(main)
	Glyphdot.fill(readout)
	Glyphdot.draw_string(main, 0, 0, "Hello Universe")
	Glyphdot.draw_string(readout, 0, 1, "Hello UI")
	
	for x in range(0, main.grid_width):
		for y in range(0, main.grid_height):
			var loc = player.pos + Vector2i(x,y) - center
			
			var t :Tile= player.visibleTiles.get(loc)
			if !t:
				t = Tile.new('p'.to_ascii_buffer()[0] + 64, Color(Color.WHITE, randf_range(0, 5./255) + 51./255).to_rgba32(), Color.BLACK.to_rgba32())
			t.draw(main, x, main.grid_height - y - 1)
	
	main.queue_redraw()
	readout.queue_redraw()
	pass
