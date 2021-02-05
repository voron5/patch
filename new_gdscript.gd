extends Camera

onready var player=$'../player'

func _physics_process(delta):
	var p=player.transform.origin+Vector3(0,8,10).rotated(Vector3.UP,player.rotation.y)
	var t = player.transform.origin+Vector3(0,3,0)
	look_at_from_position(p,t,Vector3.UP)
