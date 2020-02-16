segment .data
	arre db '45', '23', '11', '09'
	len equ $-arre

	ln db 10,13
	lenln equ $-ln

segment .bss
	dato resb 1

segment .text
	global _start
_start:
	mov ebp, arre  ; colocamos la direccion de memoria en el
                   ;registro ebp, esto para mejorar la velocidad
                   ; del programa
	mov edi, 0     ; usaremos el registro edi como contador

ciclo:
	mov al, [ebp+edi] ;obtenemos el dato que se
                   ;encuentra en la memoria en la posision edi (0,1,2,....)
	mov [dato], al      ; movemos el dato obtenido a la variable dato
	add edi,1          ; incrementamos edi en uno

	mov eax, 4
	mov ebx, 0
	mov ecx, dato
	mov edx, 1
	int 80h ; se imprime en pantalla el contenido de la etiqueta de
            ; memoria dato

	mov al, [ebp+edi] ;obtenemos el dato que se
                   ;encuentra en la memoria en la posision edi (0,1,2,....)
	mov [dato], al      ; movemos el dato obtenido a la variable dato
	add edi,1          ; incrementamos edi en uno

	mov eax, 4
	mov ebx, 0
	mov ecx, dato
	mov edx, 1
	int 80h ; se imprime en pantalla el contenido de la etiqueta de
            ; memoria dato

	mov eax, 4
	mov ebx, 0
	mov ecx, ln
	mov edx, lenln
	int 80h

	cmp edi,len       ; preguntamos si ya se han impreso todos los
                      ; datos del arreglo
	jb ciclo          ; si aun faltan datos por imprimir repetimos
                      ; el ciclo de nuevo
salir:
	mov eax, 1
	xor ebx, ebx
	int 0x80