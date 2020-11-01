extends Node

class_name Stats

signal no_health

export (int) var max_health = 1
onready var health = max_health setget set_health

func set_health(new_health):
  health = new_health
  if new_health <= 0:
    emit_signal("no_health")

