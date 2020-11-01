extends KinematicBody2D

class_name Player

enum {
  Move,
  Roll,
  Attack
}

var velocity = Vector2.ZERO
var state = Move
var roll_vector = Vector2.DOWN

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var animation_tree: AnimationTree = $AnimationTree
onready var animation_state: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

export (int) var MAX_SPEED = 80
export (int) var ACCELERATION = 500
export (int) var ROLL_SPEED = 120
export (int) var FRINCTION = 500


func _ready():
  animation_tree.active = true


func move_state(delta):
  var input_vector = Vector2.ZERO
  input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
  input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
  input_vector =  input_vector.normalized()
  if input_vector != Vector2.ZERO:
    roll_vector = input_vector
    animation_tree.set("parameters/Idle/blend_position", input_vector)
    animation_tree.set("parameters/Run/blend_position", input_vector)
    animation_tree.set("parameters/Attack/blend_position", input_vector)
    animation_tree.set("parameters/Roll/blend_position", input_vector)
    animation_state.travel("Run")
    velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
    # velocity += input_vector * ACCELERATION * delta
    # velocity = velocity.clamped(MAX_SPEED) * delta
  else:
    animation_state.travel("Idle")
    velocity = velocity.move_toward(Vector2.ZERO, FRINCTION * delta)

  velocity = move_and_slide(velocity, Vector2.UP)

  if Input.is_action_just_pressed("roll"):
    state = Roll

  if Input.is_action_just_pressed("attack"):
    state = Attack


func attack_state(delta):
  velocity = Vector2.ZERO
  animation_state.travel("Attack")

func attack_animaiton_finished() -> void:
  state = Move

func roll_state(delta):
   velocity = roll_vector * ROLL_SPEED
   animation_state.travel("Roll")
   velocity = move_and_slide(velocity, Vector2.UP)


func roll_animation_finished() -> void:
  velocity = velocity * 0.3
  state = Move

func _physics_process(delta):
  match state:
    Move:
      move_state(delta)
    Roll:
      roll_state(delta)
    Attack:
      attack_state(delta)