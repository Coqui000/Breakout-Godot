extends Node2D

#controle dos blocos
@export_group("Controle de Blocos")
@export var blocos : Node2D
var blocos_na_fase : int = 0

#passar de fase
@export_group("Passar de fase")
@export var proxima_fase : String 
@onready var time_do_passar_de_fase : Timer = $Timer_do_passsar_de_fase

func _ready() -> void:
	buscar_blocos()



func _process(delta: float) -> void:
	receber_inputs()
	
	
func receber_inputs() ->  void:
	#reinicia a fase
	if Input.is_action_just_pressed("reiniciar"):
		get_tree().reload_current_scene()
		
	if Input.is_action_just_pressed("sair"):
		#sai do jogo
		get_tree().quit()
	
	
func buscar_blocos() -> void:
	#conta quantos blocos há na fase
	for bloco in blocos.get_children():
		blocos_na_fase += 1
		
func atualizar_contagem_blocos() -> void:
	#remove um bloco da contagem e se nao tiver mais nenhum inicia o passar de fase
	blocos_na_fase -= 1
	if blocos_na_fase <= 0:
		time_do_passar_de_fase.start()


func _on_timer_do_passsar_de_fase_timeout() -> void:
	#carrega a proxima fase
	get_tree().change_scene_to_file(proxima_fase)
