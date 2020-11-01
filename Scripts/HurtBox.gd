extends Area2D

class_name HurtBox


export (bool) var show_hit = true

onready var HitEffect: PackedScene = preload("res://Scenes/HitEffect.tscn")


func _ready():
  var res_ = self.connect("area_entered", self, "_on_HurtBox_area_entered")


func _on_HurtBox_area_entered(_area: Hitbox):
  if show_hit:
    var hit_effect = HitEffect.instance()
    var ysort = self.get_parent().get_parent()
    hit_effect.global_position = self.global_position
    ysort.add_child(hit_effect)