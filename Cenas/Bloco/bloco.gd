extends StaticBody2D

#referencias gerais
@export var game_manager : Node2D

#parametros
@export var vida_do_bloco : int

#cores
@export var vermelho : Color
@export var verde : Color
@export var azul : Color


func _ready() -> void:
	atualizar_cor()



func atualizar_cor() -> void:
	#muda a cor do bloco dependendo da vida
	if vida_do_bloco == 3:
		modulate = verde
	elif vida_do_bloco == 2:
		modulate = azul
	elif vida_do_bloco == 1:
		modulate = vermelho
	else:
		modulate = Color.WHITE
		
		
func receber_dano() -> void:
	#desconta a vida e se tiver muda de cor se nao some
	vida_do_bloco -= 1
	
	if vida_do_bloco >= 1:
		atualizar_cor()
	else:
		game_manager.atualizar_contagem_blocos()
		queue_free()
	
	
