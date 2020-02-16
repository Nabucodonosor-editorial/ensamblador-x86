segment .data
	textoebx db  0xA,0xD,"El valor de ebx es: "
	lentextoebx equ $- textoebx
	saltodelinea db  0xA,0xD
	lensaltodelinea equ $- saltodelinea

segment .bss
	valorebx resb 1

section .text
	global _start
_start:

	mov al, 5 ; guardamos el valor cinco en pantalla
	add al, 48 ; el cual estableceremos como el valor
	mov [valorebx], al ; inicial del registro ebx

	mov eax, 4
	mov ebx, 1
	mov ecx, textoebx
	mov edx, lentextoebx
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, valorebx
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, saltodelinea
	mov edx, lensaltodelinea
	int 0x80

	mov ebx,[valorebx]; recuperamos el valor almacenado en la memoria
	mov eax, 5 ; establecemos el valor de eax a cinco
	cmp eax, 5 ; compara el valor de eax con cinco

	jne salir ; si la bandera cero almacena un cero, eso significa
           ; que ambos numeros NO son iguales (eax!=5) y se realiza
           ; un salto a la etiqueta salir, de lo contrario (eax==5)
           ; no se realiza ningún salto y se ejecutan las siguientes
	mov ebx, 1; lineas donde se iguala el valor de ebx con 1 (ebx = 1)

	mov eax, ebx
	add eax, 48
	mov [valorebx], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, textoebx
	mov edx, lentextoebx
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, valorebx
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, saltodelinea
	mov edx, lensaltodelinea
	int 0x80

salir:
	mov eax, 1
	mov ebx, 0
	int 0x80