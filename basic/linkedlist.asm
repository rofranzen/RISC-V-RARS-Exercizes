# Worksheet 1
#
# LINKED LIST GAME
#
# ---------------
.data
.align 2

menu_str: .asciz "\n-> MENU:\n(1) Adiciona - (2) Remove - (3) Lista - (4) Busca ID - (5) Sair\n"
opcao_vazia: .asciz "Esta opcao nao esta no menu. Tente de novo.\n"

lista_str: .asciz "Sua lista tem os itens de ID: "
lista_vazia: .asciz "A lista esta vazia."

existe: .asciz "\nID encontrado!"
nao_existe: .asciz "\nEste ID nao esta na lista."

.text
.globl main

# bugs:
# 0 at the end, null pointer
# \n menu

main:
	
	#  ----- OPCOES DO PROGRAMA -----
	# Elas se encontram aqui para minimizar acessos a memoria
	# e redefinicao constante dos registradores temporarios.
		
	li s1, 1 # 1 -> adicionar item
	li s2, 2 # 2 -> Remover item
	li s3, 3 # 3 -> Listar inventario
	li s4, 4 # 4 -> Buscar item
	li s5, 5 # 5 -> Sair
	
	li sp, 0 # Define header da lista como nulo
	
menu_loop:
	
	# Printa texto do menu
	la a0, menu_str
	li a7, 4
	ecall
	
	# ----- MENU -----
	# 1 -> Adicionar item
	# 2 -> Remover item
	# 3 -> Listar inventario
	# 4 -> Buscar item
	# 5 -> sair
	
	# Le numero inteiro (opcao do menu)
	li a7, 5
	ecall
	
	beq a0, s1, adiciona
	beq a0, s2, remove
	beq a0, s3, print_start # Dividido entre inicializacao e loop
	beq a0, s4, procura_start # Dividido entre inicializacao e loop
	beq a0, s5, exit
	
	# Escolheu opcao inexistente
	la a0, opcao_vazia # Texto sobre tentar de novo
	li a7, 4
	ecall
	
	j menu_loop # Volta ao inicio do menu
	
	
adiciona:

	# ------ ESTRUTURA DA LISTA ------
	# Usaremos alocacao para representar nos sendo criados
	# ao inves do uso de stack simples.
	
	# Precisamos de 8 bytes no nó:
	# 4 bytes -> dado do ID inteiro
	# 4 bytes -> ponteiro para o proximo
	
	li a0, 8 # Bytes alocados
	li a7, 9 # Comando de alocação dinâmica
	ecall
	
	sw sp, 4(a0) # Copia stack pointer para o "prox endereco" do no
	addi sp, a0, 0 # Stack pointer aponta para endereco do no novo
	
	# Le ID do item
	li a7, 5
	ecall
	
	sw a0, 0(sp)# Salva o valor no noh da lista

	j menu_loop # Volta ao menu

remove:
	
	# ----- REMOVE PRIMEIRO ITEM -----
	# Movemos o ponteiro principal para o proximo no
	# assim esquecendo o primeiro no da lista
	
	beq sp, x0, print_vazio # Explica que nao ha nada na lista
	
	lw t0, 4(sp) # Recebe endereco do prox
	addi sp, t0, 0 # Salva como inicio
	
	j menu_loop # Volta ao menu

print_start:

	# ----- LISTA IDS -----
	# Itera pela lista atraves de ponteiro novo
	
	beq sp, x0, print_vazio # Explica que nao ha nada na lista
	
	addi s0, sp, 0 # Copia endereco de inicio da lista
	
	# Texto de print
	la a0, lista_str # "Sua lista tem os itens de ID: "
	li a7, 4
	ecall
	
	# Automaticamente vai para print_loop

print_loop:
	
	# Printa ID do item atual
	lw a0, 0(s0) # Valor do ID no noh
	li a7, 1
	ecall
	
	# Printa espaco
	li a0, 32 # 32 = ' '
	li a7, 11
	ecall
	
	# Proximo endereco:
	lw t0, 4(s0)# Recebe endereco do proximo no
	addi s0, t0, 0 # Ponteiro atualiza para o novo
	
	# ----- SAIDA PRINT -----
	
	# Repete se o endereco do proximo noh nao for vazio
	bne t0, x0, print_loop # x0 = 0 (valor padrao nao designado)
	
	j menu_loop # Volta ao menu

print_vazio:

	# ----- PRINT VAZIO -----
	
	la a0, lista_vazia # "A lista esta vazia."
	li a7, 4
	ecall
	
	j menu_loop # Volta ao menu

procura_start:

	# ----- PROCURA SE ID EXISTE -----
	# Itera pela lista atraves de ponteiro novo
	
	beq sp, x0, print_vazio # Explica que nao ha nada na lista
	
	# Le o ID procurado e salva em a0
	li a7, 5
	ecall
	
	addi s0, sp, 0 # Copia endereco de inicio da lista
	
	# Automaticamente vai para procura_loop
	
procura_loop:
	
	# Verifica o ID atual
	lw t0, 0(s0)# Recebe o valor
	beq t0, a0, encontrado
	
	# Proximo endereco:
	lw t1, 4(s0)# Recebe endereco do proximo no
	addi s0, t1, 0 # Ponteiro atualiza para o novo
	
	# ----- FIM DA LISTA -----
	
	# Repete se o endereco do proximo noh nao for vazio
	bne t1, x0, procura_loop # x0 = 0 (valor padrao nao designado)
	
	# Nao havia o ID na lista
	la a0, nao_existe # "\nEste ID nao esta na lista"
	li a7, 4
	ecall
	
	j menu_loop # Volta ao menu

encontrado:
	
	# ----- ITEM EXISTE -----
	la a0, existe # "\nID encontrado!"
	li a7, 4
	ecall
	
	j menu_loop # Volta ao menu

exit:
	
	# Fim do programa
	li a7, 10
	ecall

	
