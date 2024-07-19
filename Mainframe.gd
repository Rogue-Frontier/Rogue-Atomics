extends Node
@onready var main :GlyphSurface= $Main
@onready var readout :GlyphSurface= $Readout
@onready var center := main.grid_size / 2
var world:World
var player:Player
var subticks:World.Subticks
var player_idle:bool:
	get:
		return (!subticks or subticks.done) and !player.busy
var img := TileImage.load("res://Assets/sprite/giant_cockroach_robot.dat")
func _ready() -> void:
	world = World.new()
	player = Player.new()
	player.world = world
	for x in range(0, 30):
		for y in range(0, 30):
			world.add_entity(Floor.new(Vector2i(x,y)))
	world.add_entity(player)
	world.try_update_present()
	world.updateTick()
func _process(delta: float) -> void:
	Glyphdot.fill(main)
	Glyphdot.fill(readout)
	
	if subticks and !subticks.done:
		subticks.update()
	elif player.busy:
		world.updateTick()
	else:
		Input.is_action_just_pressed()
		if Input.is_key_pressed(KEY_RIGHT):
			player.pos += Vector2i(1,0)
			player.busy = true
	for x in range(0, main.grid_width):
		for y in range(0, main.grid_height):
			var loc := player.pos + Vector2i(x,y) - center
			var t :Tile= player.visibleTiles.get(loc)
			if !t:
				t = Tile.new('p'.to_ascii_buffer()[0] + 64, Color(Color.WHITE, randf_range(0, 5./255) + 51./255).to_rgba32(), Color.BLACK.to_rgba32())
			t.draw(main, x, main.grid_height - y - 1)
	var keys := img.keys()
	var vals := img.values()
	for i:int in len(keys):
		var k :Vector2i= keys[i]
		var v :Tile= vals[i]
		v.draw(main, k.x, k.y)
	main.queue_redraw()
	readout.queue_redraw()
