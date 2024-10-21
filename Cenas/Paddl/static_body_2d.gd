extends StaticBody2D

var velocidade_paddle : float = 700.0
var x_minimo : float = 45
var x_maximo : float = 755




func _process(delta: float) -> void: 
	movimentar_paddle(delta)
	limitar_mov_paddle()
	
	#movimenta o paddle
func movimentar_paddle(delta: float) -> void:
	if Input.is_action_pressed("mv-esquerdo"):
		position.x -= velocidade_paddle * delta
	elif Input.is_action_pressed("mv-direito"):
		position.x += velocidade_paddle * delta
		
		
	#limita o paddle para ele nao atravessar a tela
func limitar_mov_paddle() -> void:
	position.x = clamp(position.x, x_minimo, x_maximo)
