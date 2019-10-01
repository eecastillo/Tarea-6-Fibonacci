.data
.text
	li $s0,8 #cargamos el valor de n
	li $v0,0 #variable a incrementar
	jal fibonacci #saltamos al algoritmo de fibonacci
	j exit
fibonacci:
	addi $sp, $sp,-8 #hacemos espacio dentro del stack para dos valores
	sw $ra, 0($sp) # cargamos ra al stack
	sw $s0, 4($sp) #cargamos s0 al stack
	
	slti $t1,$s0,2 # encendemos la bandera t1 si s0 corresponde al caso base, o sea, menor a 2
	beq $t1, 1, simplecase # saltamos para manejar el caso base
	addi $s0,$s0,-1 # ejecutamos el algoritmo de n-1
	jal fibonacci #regresamos a fibonacci con el valor de n-1
	addi $s0,$s0,-1 #obtenemos el valor de n-2
	jal fibonacci # regrasamos a fibonacci con valor de n
	j loadStack #brincamos a la funcion para recuperar el stack
loadStack:
	lw $ra, 0($sp) # cargamos a ra desde el stack
	lw $s0, 4($sp) #cargamos a s0 desde el stack
	addi $sp,$sp,8	#reducimos el stack en 8 para trabajar con las variables siguientes
	jr $ra
simplecase:
	add $v0, $v0, $s0 #añadimos a v0 s0, el cual puede vlaer 0 o 1
	j loadStack #regresamos a load stack
exit:
	j exit
