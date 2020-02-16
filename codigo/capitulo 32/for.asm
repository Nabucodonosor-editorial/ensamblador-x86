segment .data
	textosuma db  0xA,0xD,"El resultado de la sumatoria es: "
	lentextosuma equ $- textosuma
	saltodelinea db  0xA,0xD
	lensaltodelinea equ $- saltodelinea

segment .bss
	sumatoria resb 1

section  .text
	global _start
_start:

	mov eax, 0  ;sera nuestro acumulador por lo que colocamos un cero
            ;para no afectar el resultado de la sumatoria
	mov ecx, 3 ;servirá como contador en combinación con la
            ; instruccion loop

loop_for:
	add eax,ecx ; en eax se almacena el resultado de la sumatoria
	            ; (3+2+1)
                ; esto porque LOOP decrementara de forma automática el
                ; valor de ecx
	loop loop_for ; si el valor de ecx es diferente de cero saltara
                ; a la etiqueta loop_for, de lo contrario no
                ; realizara ninguna acción.

	add eax, 48
	mov [sumatoria], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, textosuma
	mov edx, lentextosuma
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, sumatoria
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