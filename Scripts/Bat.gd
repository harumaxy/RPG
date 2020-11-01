extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200


const KNOCKBACK_SPEED = 100


onready var stats: Stats = $Stats
onready var player_detection_zone: PlayerDetectionZone = $PlayerDetectionZone
onready var DeathEffect: PackedScene = preload("res://Scenes/EnemyDeathEffect.tscn")

enum {
  Idle,
  Wander,
  Chase
}
var state = Chase
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO


func seek_player():
  if player_detection_zone.can_see_player():
    state = Chase


func _ready():
  print(stats.max_health)

func _physics_process(delta):
  knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
  knockback = move_and_slide(knockback)

  match state:
    Idle:
      velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
      seek_player()
    Wander:
      seek_player()
    Chase:
      var player = player_detection_zone.player
      if player != null:
        var direction = (player.global_position - self.global_position).normalized()
        velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
      else:
        state = Idle

  velocity = move_and_slide(velocity)


func _on_HurtBox_area_entered(hit_box: Hitbox):
  stats.health -= hit_box.damage
  var knockback_vector = (self.global_position - hit_box.global_position).normalized()
  knockback = knockback_vector * KNOCKBACK_SPEED


func create_effect(packed_scene: PackedScene):
  var death_effect = packed_scene.instance()
  var ysort = self.get_parent()
  death_effect.global_position = self.global_position
  ysort.add_child(death_effect)
  

func _on_Stats_no_health():
  create_effect(DeathEffect)
  queue_free()