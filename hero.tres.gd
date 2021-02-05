extends KinematicBody

const run_speed=4
const rot_speed=0.05
const dir_speed=2.5

var vel = Vector3()

onready var anim=$AnimationPlayer
var state='idle'

const gr_speed=1

func _physics_process(delta):
	var need_state = ''
	var need_anim=''
	var dir=Vector3()
	var rot=0
	if anim.current_animation!='attack':
		if Input.is_action_pressed('ui_left'):
			rot=1
		elif Input.is_action_pressed('ui_right'):
			rot=-1
		if Input.is_action_pressed('ui_up'):
			dir.z=-1
			if Input.is_action_pressed('ui_shift'):
				dir.z=-dir_speed
		elif Input.is_action_pressed('ui_down'):
			dir.z=1
	if Input.is_action_just_pressed('ui_accept'):
		need_state='attack'
	if rot:
		rotate_y(rot*rot_speed)
		need_state='turn'
	if dir:
		need_state='run' if dir.z==-dir_speed else 'move'
		dir=dir.rotated(Vector3.UP,rotation.y)*run_speed
	vel.z=dir.z
	vel.x=dir.x
	if !is_on_floor():
		vel.y-=gr_speed
	vel=move_and_slide(vel,Vector3.UP)
	if anim.current_animation!='attack':
		if !need_state:
			need_state='idle'
	set_state(need_state,need_anim)
	
func set_state(s,a=''):
	if !s||state==s:
		return
	state=s
	if !a:a=s
	if anim.current_animation==a:
		return
	if a=='run':anim.playback_speed=1.5
	else: anim.playback_speed=1
	anim.play(a,0.3)
