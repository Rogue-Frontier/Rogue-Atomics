class_name BufferedSet
var items := {}
var toAdd := {}
var toRemove := {}
func add(e, busy := true):
	toRemove.erase(e)
	if items.has(e):
		return false
	if busy:
		toAdd[e] = e
	else:
		items[e] = e
func remove(e, busy := true):
	toAdd.erase(e)
	if !items.has(e):
		return false
	if busy:
		toRemove[e] = e
	else:
		items.erase(e)
func update():
	for e in toAdd:
		items[e] = e
	for e in toRemove:
		items.erase(e)
	
	toAdd.clear()
	toRemove.clear()
	pass
