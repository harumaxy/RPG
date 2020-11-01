extends Node

signal no_health
signal health_changed(value)
signal max_health_changed(value)


export (int) var max_health = 3 setget set_max_health
export (int) var health = 3 setget set_health

func set_max_health(value):
  max_health = value
  self.health = min(health, max_health)
  emit_signal("max_health_changed", value)

func set_health(new_health: int):
  health = new_health
  emit_signal("health_changed", health)
  print(health)
  if health <= 0:
    self.emit_signal("no_health")