segment .data

	mensaje db "El numero de argumentos es: "
	lonmensaje equ $-mensaje

	texto db "El argumento es: "
	lontexto equ $-texto

	ln db 10,13
	lonln equ $-ln

segment .bss
	datos resb 2

segment .text
	global _start
_start:

	pop eax ;extraemos de la pila el numero de argumentos
	add eax, '0' ; convertimos el numero entero a caracter
	mov [datos], eax ; copiamos el contenido del registro ax en
	                 ; la ubicacion de memoria datos
	mov eax, 4
	mov ebx, 0
	mov ecx, mensaje
	mov edx, lonmensaje
	int 80h

	mov eax, 4
	mov ebx, 0
	mov ecx, datos
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 0
	mov ecx, ln
	mov edx, lonln
	int 80h

	mov eax, 4
	mov ebx, 0
	mov ecx, texto
	mov edx, lontexto
	int 80h

	pop ebx ; extraemos de la pila la direccion de memoria donde se
	        ; encuentra almacenado el nombre del programa y lo guardamos
	        ; en el registro ebx

	mov eax, 4
	mov ebx, 0
	pop ecx ; guardamos en el registro ecx, la direccion de memoria
        ; donde se encuentra el primer argumento pasado al programa
        ; argv[1]
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 0
	mov ecx, ln
	mov edx, lonln
	int 80h

salir:
	mov eax, 1
	xor ebx,ebx
	int 0x80