extends AnimatedSprite

func _ready():
  var _res = self.connect("animation_finished", self, "_on_AnimatedSprite_animation_finished")
  self.frame = 0
  self.play("Animate")


func _on_AnimatedSprite_animation_finished():
  self.queue_free()