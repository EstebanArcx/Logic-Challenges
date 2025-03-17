.data
    prompt0: .asciiz "----------S E R I E  F I B O N A C C I----------\n"    # Define el mensaje para el usuario
    prompt1: .asciiz "Cantidad numeros desea generar?:  "         	    # Define el mensaje del prompt para el usuario

    
    fibSerie: .asciiz "\nSerie Fibonacci: "     # Define el mensaje para mostrar antes del resultado
    
    space: .asciiz ","
    
    totalSum: .asciiz "\nLa suma total es: "
    
    nFibonacci: .word 0                           # Reserva espacio para la cantidad de numeros de la serie
    
    num1: .word 0                                 # Reserva espacio para el primer numero
    num2: .word 1                                 # Reserva espacio para el segundo numero
    
    sum: .word 0                                    # Reserva espacio para La suma total
 
 	
.text
main:
#-------------------------------------------------------------------------------------------------------------------------

    # Leer cantidad de numeros de la serie
    
    li $v0, 4                    # Prepara la syscall para imprimir cadena (codigo 4)
    la $a0, prompt0              # Carga la direccion del mensaje del prompt0 en $a0
    syscall                      # Ejecuta la syscall para imprimir el prompt
    
    
    li $v0, 4                   
    la $a0, prompt1              
    syscall                      
    
    li $v0, 5                   # Prepara la syscall para leer un entero (codigo 5)
    syscall                     # Ejecuta la syscall, el entero leido se almacena en $v0
    sw $v0, nFibonacci           # Guarda el entero leido en la ubicacion de memoria de nFibonacci
    
    move $t0, $v0   # Mueve el valor de $v0 a $t0
    
    
#-------------------------------------------------------------------------------------------------------------------------

# Si el usuario solicitó 0 números, salir
    li $t5, 0
    beq $t0, $t5, exit      # Si $t0 = $t5, seguimos directamente a la etiqueta exit
    
    
    
#-------------------------------------------------------------------------------------------------------------------------    
    
    # Inicializar sum en $t4
    li $t4, 0              
    
#-------------------------------------------------------------------------------------------------------------------------
    
    li $v0, 4                    # Prepara la syscall para imprimir cadena (codigo 4)
    la $a0, fibSerie              # Carga la direccion del mensaje del totalSum en $a0
    syscall                      # Ejecuta la syscall para imprimir el prompt 
        
              
    # Imprimir num1
    lw $t1, num1                # Cargar el num1 en $t0
    li $v0, 1                   # Prepara la syscall para imprimir entero  (codigo 1)
    move $a0, $t1               # Mover el valor de $t0 a $a0 para imprimir
    syscall
    
    
     # Sumar num1 a $t4
    add $t4, $t4, $t1           # $t4 += $t1
    
    
    # Si el usuario solicitó 1 número, salir
    li $t5, 1
    beq $t0, $t5, exit      # Si $t0 = $t5, seguimos directamente a la etiqueta exit
    
#-------------------------------------------------------------------------------------------------------------------------

    #Imprimir Separacion
    li $v0, 4                   # Prepara la syscall para imprimir cadena (codigo 4)
    la $a0, space              # Carga la direccion del mensaje space en $a0
    syscall                     # Ejecuta la syscall para imprimir el prompt
    
    
    # Imprimir num2                 
    lw $t2, num2                # Cargar el num2 en $t2                                         
    li $v0, 1                   # Prepara la syscall para imprimir entero  (codigo 1)
    move $a0, $t2             	# Mover el valor de $t2 a $a0 para imprimir
    syscall
    
    
    # Sumar num2 a $t4
    add $t4, $t4, $t2           # $t4 += $t1
    
    
    # Si el usuario solicitó 2 números, salir
    li $t5, 2
    beq $t0, $t5, exit      # Si $t3 = $t5, seguimos directamente a la etiqueta exit
    
#-------------------------------------------------------------------------------------------------------------------------
    
    # utilizar el valor de dos para el registro $t6 como contador para controlar las iteraciones
    li $t6, 2  # Ya imprimimos 2 números, faltan (n-2)
    
    #Tambien podriamos utilizar el registro $t5
    
#-------------------------------------------------------------------------------------------------------------------------

    loop:
    # Calcular el siguiente número de Fibonacci: num3 = num1 + num2
    add $t3, $t1, $t2  # t3 = t1 + t2
    
    #Imprimir Separacion
    li $v0, 4                   
    la $a0, space              
    syscall 
    
    # Imprimir num3
    li $v0, 1
    move $a0, $t3
    syscall
    
    
    # Sumar num3 a $t4
    add $t4, $t4, $t3          # $t4 += $t3
    
    
    # Actualizar los valores: num1 = num2, num2 = num3
    move $t1, $t2
    move $t2, $t3                                                                                
    
    # Incrementar el contador
    addi $t6, $t6, 1    # $t6 += 1
    
                
#------------------------------------------------------------------------------------------------------------------------- 

    # Repetir la etiqueta loop hasta alcanzar la cantidad deseada $t6 = $t0
    blt $t6, $t0, loop
    
#------------------------------------------------------------------------------------------------------------------------- 
   
    li $v0, 4                    # Prepara la syscall para imprimir cadena (codigo 4)
    la $a0, totalSum              # Carga la direccion del mensaje del totalSum en $a0
    syscall                      # Ejecuta la syscall para imprimir el prompt
     
    # Imprimir resultado de sum                
    li $v0, 1                   # Prepara la syscall para imprimir entero  (codigo 1)
    move $a0, $t4               # Mover el valor de $t4 a $a0 para imprimir
    syscall
    
#------------------------------------------------------------------------------------------------------------------------- 
    # Salir
    exit:
    li $v0, 10                  # Carga el codigo de operacion 10 en $v0 para terminar el programa
    syscall                     # Ejecuta la syscall, que terminar el programa
    
    