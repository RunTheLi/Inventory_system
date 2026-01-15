extends Area2D

class_name PickupItem

@onready var sprite: Sprite2D = $Sprite2D

var item: Item

func _ready():
	sprite.texture = item.icon
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if not body.is_in_group("player"):
		return 
	
	Global.add_item(item)
	queue_free()
