extends Node2D

onready var GrassEffect: PackedScene = preload("res://Scenes/GrassEffect.tscn")

func create_grass_effect():
  var grass_effect: Node2D = GrassEffect.instance()
  var world = get_tree().current_scene
  world.add_child(grass_effect)
  grass_effect.global_position = self.global_position



func _on_HurtBox_area_entered(_area: Area2D):
  create_grass_effect()
  queue_free()
