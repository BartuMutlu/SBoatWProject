extends CharacterBody2D

#dragged and dropped while holding down command 
@onready var animated_sprite_2d = $AnimatedSprite2D

const Gravity = 1000
const Speed = 300

enum State{Idle, Run} #

var current_state 

func _ready(): #will be called in the very beginning and is called only once 
	current_state = State.Idle 

func _physics_process(delta): #function for all player movement in sequential order 
	player_falling(delta)
	player_Idle(delta)
	player_run(delta)
	
	move_and_slide()
	
	player_animations()

func player_falling(delta): #function to create gravity 
	if !is_on_floor(): #if character is not on the floor 
		velocity.y += Gravity * delta  #gravity is declared up above 

 
func  player_Idle(delta): #idle function 
	if is_on_floor(): # if the player is on the floor 
		current_state = State.Idle # the "current state" will be idle 


func player_run(delta): #function to acess the inputs in order to move player 
	var direction = Input.get_axis("move_left", "move_right") # the Input.get_axis( L , R) will always move L left and R, right
	
	if direction: 
		velocity.x = direction * Speed
	else: 
		velocity.x = move_toward(velocity.x, 0 , Speed)
	
	if direction != 0: 
		current_state = State.Run
		animated_sprite_2d.flip_h = false if direction > 0 else true #ternerary statement, if direction is greater than 0, set that false value to true, which then activates the "flip.h" statement which flips the sprite
	

func player_animations():
	if current_state == State.Idle: # if current state is idling, then
		animated_sprite_2d.play("idle") # play "idle" animation 
		
	elif current_state == State.Run:  #if current state is running, then 
		animated_sprite_2d.play("run") #play run animation
