segment .data

	mensaje db "El registro eax contiene el valor: "
	lonmensaje equ $-mensaje

	ln db 10,13
	lonln equ $-ln

segment .bss
	datos resb 2

segment .text
	global _start
_start:

	mov ax, '0' ; almacenamos en el registro ax el caracter 0

	push ax ; almacenamos el valor contenido en el registro ax
	         ; en la pila

	mov ax, '9' ; almacenamos en el registro ax el caracter 9

	mov [datos], ax ; copiamos el contenido del registro ax en
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

	pop ax ; el dato almacenado en la cima de la pila es copiado
	        ; al registro ax, y eliminado de la misma
	mov [datos], ax ; copiamos el valor contenido en el registro
	        ; ax en la ubicacion de memoria datos

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


salir:
	mov eax, 1
	xor ebx,ebx
	int 0x80