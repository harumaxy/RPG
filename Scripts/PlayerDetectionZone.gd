extends Area2D

class_name PlayerDetectionZone

onready var player = null

func _ready():
  var _res = self.connect("body_entered", self, "_on_PlayerDetectionZone_body_entered")
  _res = self.connect("body_exited", self, "_on_PlayerDetectionZone_body_exited")

func can_see_player() -> bool:
  return player != null

func _on_PlayerDetectionZone_body_entered(body: KinematicBody2D):
  player = body

func _on_PlayerDetectionZone_body_exited(_body: KinematicBody2D):
  player = null
