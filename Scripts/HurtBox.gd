extends Area2D

class_name HurtBox

onready var HitEffect: PackedScene = preload("res://Scenes/HitEffect.tscn")
onready var timer: Timer = $Timer

var invincible = false setget set_invincible

signal invincibility_stated
signal invincibility_ended

func set_invincible(value):
  invincible = value
  if invincible == true:
    emit_signal("invincibility_stated")
  if invincible == false:
    emit_signal("invincibility_ended")

func create_hit_effect():
  var hit_effect = HitEffect.instance()
  var ysort = self.get_parent().get_parent()
  hit_effect.global_position = self.global_position
  ysort.add_child(hit_effect)

func start_inbincibility(duration: float):
  self.invincible = true
  timer.start(duration)

func _on_HurtBox_area_entered(_area: Hitbox):
  create_hit_effect()

func _on_Timer_timeout():
  self.invincible = false

func _on_invincibility_stated():
  self.set_deferred("monitorable", false)

func _on_invincibility_ended():
  self.set_deferred("monitorable", true)


func _ready():
  self.connect("area_entered", self, "_on_HurtBox_area_entered")
  timer.connect("timeout", self, "_on_Timer_timeout")
  self.connect("invincibility_stated", self, "_on_invincibility_stated")
  self.connect("invincibility_ended", self, "_on_invincibility_ended")
