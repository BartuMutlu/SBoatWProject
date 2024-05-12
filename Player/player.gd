extends CharacterBody2D 

#dragged and dropped while holding down command 
@onready var animated_sprite_2d = $AnimatedSprite2D

#All constant directional variabbles 
const Gravity = 1000
#@export var makes this a Dynamic Variable which we can now easily change on "player.gd" 
@export var Speed: int  = 300 
@export var Jump: int  = -300 #the y axis is inversed for some reason 

enum State{Idle, Run, Jump} #

var current_state 

func _ready(): #will be called in the very beginning and is called only once 
	current_state = State.Idle 

func _physics_process(delta): #function for all player movement in sequential order 
	player_falling(delta)
	player_Idle(delta)
	player_run(delta)
	player_jump(delta)
	print ("State: ", State.keys()[current_state])  #Displays the state the player is in on "Output" 
	
	move_and_slide()
	
	player_animations()

func player_falling(delta): #function to create gravity 
	if !is_on_floor(): #if character is not on the floor nv
		velocity.y += Gravity * delta  #gravity is declared up above 

 
func  player_Idle(delta): #idle function 
	if is_on_floor(): # if the player is on the floor 
		current_state = State.Idle # the "current state" will be idle 


func player_run(delta): #function to acess the inputs in order to move player 
	#if !is_on_floor():   this function allows the animation of the directional jump with the flip, however the play isnt controllable in this animation 
		#return
		
	var direction = Input.get_axis("move_left", "move_right") # the Input.get_axis( L , R) will always move L left and R, right
	
	if direction: 
		velocity.x = direction * Speed
	else: 
		velocity.x = move_toward(velocity.x, 0 , Speed)
	
	if direction != 0: 
		current_state = State.Run
		animated_sprite_2d.flip_h = false if direction > 0 else true #ternerary statement, if direction is greater than 0, set that false value to true, which then activates the "flip.h" statement which flips the sprite
	
func player_jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor(): #function takes the input and activates it if the player just presses it ( if this isnt here, player floats away
		velocity.y = Jump  
		current_state = State.Jump
		
		#if statement for to make jump limited 
		
		#Honestly dont really need this, this is supposed to make the run and jump longer but I dont see a difference 
	#if !is_on_floor() and current_state == State.Jump:
		#var direction = Input.get_axis("move_left", "move_right")
		#velocity.x += direction * 300 * delta 
		

func player_animations():
	if current_state == State.Idle: # if current state is idling, then
		animated_sprite_2d.play("idle") # play "idle" animation 
		
	elif current_state == State.Run:  #if current state is running, then 
		animated_sprite_2d.play("run") #play run animation
		
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")



