extends Area2D

class_name SoftCollision

func is_colliding():
  var areas = self.get_overlapping_areas()
  return areas.size() > 0


func get_push_vector() -> Vector2:
  var areas = self.get_overlapping_areas()
  if areas.size() > 0:
    var area = areas[0]
    return area.global_position.direction_to(self.global_position)
  return Vector2.ZERO

