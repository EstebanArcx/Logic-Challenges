.data
    prompt0: .asciiz "Ingrese el primer numero: "         # Define el mensaje del prompt para el usuario
    prompt1: .asciiz "Ingrese el segundo numero: "
    prompt2: .asciiz "Ingrese el tercer numero: "
    
    resultMin: .asciiz "El número menor es: "     # Define el mensaje para mostrar antes del resultado
    
    num1: .word 0                                 # Reserva espacio para el primer numero
    num2: .word 0                                 # Reserva espacio para el segundo numero
    num3: .word 0                                 # Reserva espacio para el tercer numero

.text
main:
#-------------------------------------------------------------------------------------------------------------------------

    # Leer el primer numero
    li $v0, 4                    # Prepara la syscall para imprimir cadena (codigo 4)
    la $a0, prompt0              # Carga la direccion del mensaje del prompt en $a0
    syscall                      # Ejecuta la syscall para imprimir el prompt
    
    li $v0, 5                   # Prepara la syscall para leer un entero (codigo 5)
    syscall                     # Ejecuta la syscall, el entero leido se almacena en $v0
    sw $v0, num1                # Guarda el entero leido en la ubicacion de memoria de num1
    
    move $t0, $v0   # Mueve el valor de $v0 a $t0
    
    
    # Leer el segundo numero
    li $v0, 4                   
    la $a0, prompt1              
    syscall                     

    li $v0, 5                   
    syscall                     
    sw $v0, num2                # Guarda este segundo entero en la ubicaciun de memoria de num2
    
    move $t1, $v0               # Mueve el valor de $v0 a $t1
    
    
    # Leer el tercer numero
    li $v0, 4                   
    la $a0, prompt2              
    syscall                     

    li $v0, 5                   
    syscall                     
    sw $v0, num3                # Guarda este tercer entero en la ubicaciun de memoria de num3
    
    move $t2, $v0               # Mueve el valor de $v0 a $t2
    
    
 #-------------------------------------------------------------------------------------------------------------------------
 
    # Encontrar el número menor
    
    move $t3, $t0   # Inicialmente asumimos que el menor es $t0 (el valor es almacenado en el registro $t3)
    
    # Comparar $t1 con $t3 
    bge $t1, $t3, comparar_tercero  # Si $t1 >= $t3, seguimos directamente a la etiqueta comparar_tercero
    move $t3, $t1   # Si $t1 < $t3, ahora el menor sera $t1 (mover el valor de $t1 a $t3)
    
    comparar_tercero:
    bge $t2, $t3, imprimir_resultado  # Si $t2 >= $t3, no cambia el menor y seguimos directamente a la etiqueta imprimir_resultado  
    move $t3, $t2   # Si $t2 < $t3, el menor es $t2 (mover el valor de $t2 a $t3)
 
 
#------------------------------------------------------------------------------------------------------------------------- 
    # Imprimir el mensaje "El número menor es: "
    imprimir_resultado:
    li $v0, 4
    la $a0, resultMin
    syscall
    
    # Imprimir numero menor ($t3)
    li $v0, 1                   # Prepara la syscall para imprimir entero (codigo 1)
    move $a0, $t3            
    syscall                     # Ejecuta la syscall para imprimir el prompt
    
    
#------------------------------------------------------------------------------------------------------------------------- 
    # Salir
    li $v0, 10                  # Carga el codigo de operacion 10 en $v0 para terminar el programa
    syscall                     # Ejecuta la syscall, que terminar el programa
    
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 