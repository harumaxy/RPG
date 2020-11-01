extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var heart_ui_full = $HeartUIFull
onready var heart_ui_empty = $HeartUIEmpty

const HEART_WIDTH = 15

func set_hearts(value):
  hearts = clamp(value, 0, max_hearts)
  heart_ui_full.rect_size.x = hearts * HEART_WIDTH

func set_max_hearts(value):
  max_hearts = max(value, 1)
  heart_ui_empty.rect_size.x = max_hearts * HEART_WIDTH
  

func _ready():
  self.max_hearts = PlayerStats.max_health
  self.hearts = PlayerStats.health
  PlayerStats.connect("health_changed", self, "set_hearts")
  PlayerStats.connect("max_health_changed", self, "set_max_hearts")