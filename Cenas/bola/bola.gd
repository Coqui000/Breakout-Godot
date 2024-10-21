extends Area2D

#referencias gerais
@onready var timer_bola : Timer = $Timer_da_bola
@onready var som_impacto_bloco : AudioStreamPlayer = $Som_impacto_bloco
@onready var som_impacto_paddle : AudioStreamPlayer = $Som_impacto_Paddle
@onready var som_impacto_tela: AudioStreamPlayer = $Som_impacto_tela

#movimento da bola
var velocidade_bola : float = 400.0
var posicao_inicial : Vector2 = Vector2(400, 500)
var direcao_inicial : Vector2 = Vector2(0, 0)
var nova_direcao : Vector2 = Vector2(0, 0)

#limites da bola
var x_minimo : float = 0
var x_maximo : float = 800
var y_minimo : float = 0
var y_maximo : float = 600

#verificacoes
var primeiro_lancamento : bool = true
var caiu_da_tela : bool = false

func _ready() -> void:
	timer_bola.one_shot = true
	resetar_bola()


func _process(delta: float) -> void:
	#espera acao do jogador para lancar a bola no 1 lancamento
	if primeiro_lancamento:
		if Input.is_action_just_pressed("lancar-bola"):
			escolher_direcao_inicial()
			primeiro_lancamento = false
			
	movimentar_bola(delta)
	verificar_posicao_bola()
	
	
		
	
func resetar_bola() -> void:
	#reseta a bola
	position = posicao_inicial	
	
	
func escolher_direcao_inicial() -> void:
	#escolhe uma nova direcao
	var x_aleatorio = [-1, 1].pick_random()
	
	#aplica a nova direcao
	direcao_inicial = Vector2(x_aleatorio, -1)
	nova_direcao = direcao_inicial
	
	
func movimentar_bola(delta) -> void:
	#mov a bola
	position += nova_direcao * velocidade_bola * delta
	
	
func verificar_posicao_bola() -> void:
	#se a bola estiver dentro da tela rebate-a ao colidir com as bordas
	if position.y <= y_maximo:
		if position.y <= y_minimo:
			som_impacto_tela.play()
			nova_direcao.y *= -1
			
		if position.x <= x_minimo or position.x >= x_maximo:
			som_impacto_tela.play()
			nova_direcao.x *= -1

	#se a bola cair da tela
	if position.y > y_maximo and not caiu_da_tela:
		timer_bola.start()
		caiu_da_tela = true
		
		
#para o mov da bola e reseta sua posicao
func sair_da_tela() -> void:
	nova_direcao = Vector2(0, 0)
	primeiro_lancamento = true
	resetar_bola()
			
			
func _on_body_entered(body: Node2D) -> void:
	#se colidir com o paddle a rebate
	if body.is_in_group("Paddle"):
		som_impacto_paddle.play()
		nova_direcao.y *= -1
		
	#se colidir com bloco, desconta a vida e rebate
	elif body.is_in_group("blocos"):
		som_impacto_bloco.play()
		body.receber_dano()
		nova_direcao.y *= -1


func _on_timer_da_bola_timeout() -> void:
	sair_da_tela()
	caiu_da_tela = false
