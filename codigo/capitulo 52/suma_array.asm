extern printf
; utilizaremos la funcion printf de C para imprimir
; un numero decimal en pantalla
section .data
	; cada dato esta definido como un double world
	; (flotante de 32 bits)
	vector dd 7.36464646465, 0.930984158273, 10.6047098049
	dd 14.3058722306, 15.2983812149, -17.4394255035
	dd -17.8120975978, -12.4885670266, 3.74178604342
	dd 16.3611827165, -9.1182728262, -11.4055038727
	dd 4.68148165048, -9.66095817322, 5.54394454154
	dd 13.4203706426, 18.2194407176, -7.878340987
	dd -6.60045833452, -7.98961850398

	lenvector equ ($-vector)/4 ; cada elemento emplea cuatro bytes
	                  ; para su representacion
	;mensaje a imprimir en pantalla, %e hace referencia a los datos
	;almaceandos en la pila de la cpu
	msg  db "la suma es = %e",0x0a,0x00
	suma  dq 0

section .text
	global main

main:
	mov ecx, lenvector ; guardamos en ecx la cantidad de elementos a
	                   ; iterar
	mov ebx, 0 ; utilizaremos al arreglo ebx, como el desplazamiento
	           ; en memoria

	fldz ; colocamos un cero en la cima de la pila (st0 <- 0)
for:
	fld	dword [vector + ebx*4] ; carga en la cima de la pila un
	; dato leido de la memoria y lo conviente a punto flotante,
	; se indica que el dato a cargar es una palabra doble
	fadd ; realiza la suma entre el registro st0 y st1 y el resultado
	; lo almacena en st0 (st0 <- st0 + st1)
	inc ebx ; incrementamos en uno el desplazamiento
	loop for

	fstp qword [suma] ; copia el dato ubicado en la cima de la pila a
	                 ; una ubicacion de memoria como un dato de 64
	                 ; bits y remueve el dato de la pila

	push dword [suma+4] ; almacenamos la variable suma en la pila de
	push dword [suma]  ; la cpu como dos datos de 32 bits cada uno

	push dword msg
	call printf
	add esp, 12
	ret