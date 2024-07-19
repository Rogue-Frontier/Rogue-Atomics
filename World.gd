class_name  World
var entitiesAdd := {}
var entitiesRemove := {}
var entities := {}
var actors := {}

var time := 0.0
var lastUpdate := 0.0

var busy := false
var updateMap := false

var _entityMap :Dictionary= {}
var entityMap:Dictionary:
	get:
		if updateMap:
			_entityMap.clear()
			for e in entities:
				var l := _entityMap.get_or_add(e.pos.key, []) as Array
				l.push_back(e)
			updateMap = false
		return _entityMap
func add_entity(e):
	entitiesRemove.erase(e)
	if entities.has(e):
		return
	e.removed.connect(func(): remove_entity(e))
	entitiesAdd[e] = e
	try_update_present()
func remove_entity(e):
	entitiesAdd.erase(e)
	if not entities.has(e):
		return
	entitiesRemove[e] = e
	try_update_present()
func try_update_present():
	if not busy:
		update_present()
func update_present():
	for e in entitiesAdd:
		entities[e] = e
	for e in entitiesRemove:
		entities.erase(e)
	entitiesAdd.clear()
	entitiesRemove.clear()
	actors.clear()
	for e in entities.keys().filter(func(e): return e.is_actor):
		actors[e] = e
	updateMap = true
	lastUpdate = time
func updateTick() -> Subticks:
	busy = true
	var s := Subticks.new(actors.keys().map(func(a):
		var act = a.updateTick() as Array[Callable]
		if !act:
			act = []
		return act
		),
		self.update_present,
		func():return)
	busy = false
	return s
func updateReal(delta:float):
	time += delta
	for e in actors.keys:
		e.updateReal(delta)
class Subticks:
	var lines := []
	signal step
	signal end
	var remaining := []
	var length:int:
		get: return lines.map(func(e): return len(e)).max()
	var done:int:
		get: return remaining.size() == 0
	var subtick := 0
	func update():
		remaining = remaining.filter(func(e): return subtick < e.length)
		for line in remaining:
			line[subtick].call()
		step.emit()
		if done:
			end.emit()
		subtick += 1
	func _init(lines, step, end):
		self.lines = lines
		self.remaining = lines
		if not self.remaining:
			self.remaining = []
		self.step.connect(step)
		self.end.connect(end)
