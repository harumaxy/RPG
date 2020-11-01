extends Node2D

class_name WanderController

export (int) var wander_range = 32

onready var start_position = self.global_position
onready var target_position = self.global_position
onready var timer: Timer = $Timer

func get_rand_range() -> float:
  return rand_range(-wander_range, wander_range)

func update_target_potions():
  var target_vetror = Vector2(get_rand_range(), get_rand_range())
  target_position = start_position + target_vetror

func get_time_left() -> float:
  return timer.time_left


func set_wander_timer(duration: float):
  timer.start(duration)


func _on_Timer_timeout():
  update_target_potions()
  

func _ready():
  timer.connect("timeout", self, "_on_Timer_timeout")