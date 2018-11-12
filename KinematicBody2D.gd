extends KinematicBody2D

const UP =Vector2(0,-1)
const Gravity=20
const Jump=-700
const Acceleration=100
const MaxSpeed=400
var jump = Jump 
var motion=Vector2()
var friction=false
func _physics_process(delta):
	motion.y+=Gravity
	if Input.is_action_pressed("ui_right"):
		$Brassman.flip_h=false
		$Brassman/Trambone.flip_h=false
		$Brassman.play("Run")
		motion.x=min(motion.x+Acceleration,MaxSpeed)
		if Input.is_action_just_pressed("ui_accept"):
			self.position.x+=120
	elif Input.is_action_pressed("ui_left"):
		$Brassman.flip_h=true
		$Brassman/Trambone.flip_h=true
		$Brassman.play("Run")
		motion.x=max(motion.x-Acceleration,-MaxSpeed)
		if Input.is_action_just_pressed("ui_accept"):
			self.position.x-=120
	else:
		$Brassman.play("idle")
		motion.x=0
	if is_on_floor():
		jump = Jump 
		if Input.is_action_pressed("ui_up"):
			motion.y=Jump
		if friction==true:
			motion.x=lerp(motion.x,0,0)
	else:
		$Brassman.play("Jump")
		if friction==false:
			motion.x=lerp(motion.x,0,0)
	if is_on_wall():
		if Input.is_action_pressed("ui_accept"):
			motion.y=0
			if Input.is_action_pressed("ui_up"):
				motion.y=jump
				jump = 0
				
			
	motion=move_and_slide(motion,UP)