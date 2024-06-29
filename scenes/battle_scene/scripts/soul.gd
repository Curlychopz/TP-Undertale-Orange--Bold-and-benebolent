extends CharacterBody2D

var input_mov = Vector2.ZERO

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	
	input_mov =  Vector2( (Input.get_action_strength("right") - Input.get_action_strength("left")), (Input.get_action_strength("down") - Input.get_action_strength("up")) )
	velocity = input_mov * 65
	
	move_and_slide()
