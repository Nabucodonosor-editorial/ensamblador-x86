segment .data

	texto db " ----------- texto ------------ "
	lontexto equ $-texto

	clr    db 0x1b, "[33;40m", 0x1b,"[2J", 0x1b,"[5;20f"
	; el 0x1b indica que los caracteres enviados a la pantalla no
	; seran impresos sino ejecutados
	; se establece el color de la fuente en amarillo (33)
	; se establece el color del fondo en negro (40)
	; se borra toda la pantalla utilizando los colores previamente
	; establecidos
	; se coloca el cursor en la fila 5 columna 20
	clrlen equ $ - clr

	ln db 10,13
	lonln equ $-ln

segment .bss
	datos resb 2

segment .text
	global _start
_start:
    ; se envian los parametros a la pantalla
	mov eax, 4
	mov ebx, 0
	mov ecx, clr
	mov edx, clrlen
	int 80h
    ; se imprime en pantalla el texto
	mov eax, 4
	mov ebx, 0
	mov ecx, texto
	mov edx, lontexto
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