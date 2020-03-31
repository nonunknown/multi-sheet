tool
extends Sprite

export(bool) var update = false
export(String) var path_to_tpsheet
export(Array,Texture) var textures
export(Array,Texture) var normals
export(int) var sprite_id = 0 setget set_sprite
export(Array,Rect2) var spr_rects
export(Array,int) var spr_ids

var sprite_data
var current_atlas:int = 0


func set_sprite(id:int):
	if id > spr_rects.size()-1 or id < 0:
		printerr("Invalid sprite id")
		return
	sprite_id = id
	
	var r = spr_rects[sprite_id]
	var i = spr_ids[sprite_id]
	if current_atlas != i:
		current_atlas = i
	texture = textures[current_atlas]
	if normals.size() == textures.size():
		normal_map = normals[current_atlas]
	region_rect = r
	

func read_file():
	var file:File = File.new()
	file.open(path_to_tpsheet,File.READ)
	var json = file.get_as_text()
	json = parse_json(json)
	sprite_data = json
	file.close()
	pass # Replace with function body.

func _process(delta):
	if update:
		update_data()
		update = false

func update_data():
	read_file()
	spr_rects = []
	spr_ids = []
#	if sprite_data == null: print("spritedata is null")
	print(sprite_data.textures.size())
	for j in range(sprite_data.textures.size()-1):
		var tex = sprite_data.textures[j]
		print(tex.sprites.size())
		
		for i in range(tex.sprites.size()-1):
			var spr = tex.sprites[i]
#			print(spr.filename)
			var rect:Rect2
			rect.size = Vector2(spr.region.w,spr.region.h)
			rect.position = Vector2(spr.region.x,spr.region.y)
			spr_rects.append(rect)
			spr_ids.append(j)
	print(sprite_data.textures[0].sprites[0])
#	print(sprite_data.textures.sprite)
	pass
