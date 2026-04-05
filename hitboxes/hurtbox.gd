class_name Hurtbox

extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	var hitbox = area as Hitbox
	if hitbox:
		Debug.log("damage received")
		if owner.has_method("take_damage"):
			owner.take_damage(hitbox.DMG)
			hitbox.damage_dealt.emit()
