extends Node3D

@onready var target
var eps : float = 0.01
var mov_x : float = 0.05
var mov_y : float = 0.05
var default_invspeed : float = 8.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#connect("is_target", _on_is_target())

"""func _on_is_target():
	target = """

func set_mov(x : float, y : float):
	mov_x = x
	mov_y = y

func set_target(node : Node3D):
	if node == null:
		target = %mc.get_child(0)
	target = node

func snap_to_target(dist : int = 4): #instantaneous
	position = target.position + Vector3(0,0,dist)

func go_to_target(invspeed : float, dist : int = 4): #smooth
	if target == null:
		return
	if abs((target.position + Vector3(0,0,dist) - position).x) < eps:
		position = target.position + Vector3(0,0,dist)
	if position != target.position + Vector3(0,0,dist):
		position += (target.position + Vector3(0,0,dist) - position)/invspeed

func seeing() -> bool:
	return $cam_main/Ray_center.on_target(target) or $cam_main/Ray_cen_down.on_target(target) or $cam_main/Ray_cen_up.on_target(target) or\
		$cam_main/Ray_cen_right.on_target(target) or $cam_main/Ray_cen_left.on_target(target) or $cam_main/Ray_ri_up.on_target(target) or\
		$cam_main/Ray_ri_down.on_target(target) or $cam_main/Ray_le_up.on_target(target) or $cam_main/Ray_le_down.on_target(target)

func follow():
	if not $cam_main/Ray_center.on_target(target):
		if $cam_main/Ray_cen_down.on_target(target):
			position += Vector3(0, -mov_y, 0)
		elif $cam_main/Ray_cen_up.on_target(target):
			position += Vector3(0, mov_y, 0)
		elif $cam_main/Ray_cen_right.on_target(target):
			position += Vector3(mov_x, 0, 0)
		elif $cam_main/Ray_cen_left.on_target(target):
			position += Vector3(-mov_x, 0, 0)
		elif $cam_main/Ray_ri_up.on_target(target):
			position += Vector3(mov_x, mov_y, 0)
		elif $cam_main/Ray_ri_down.on_target(target):
			position += Vector3(mov_x, -mov_y, 0)
		elif $cam_main/Ray_le_up.on_target(target):
			position += Vector3(-mov_x, mov_y, 0)
		elif $cam_main/Ray_le_down.on_target(target):
			position += Vector3(-mov_x, -mov_y, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#go_to_target(default_invspeed, 8)
	#print(target.position)
	follow()
	if !seeing():
		go_to_target(default_invspeed, 12)
	#prints(position, $cam_main/Ray_center.is_colliding())
