segment .data
	textosuma db  0xA,0xD,"El valor final de ebx es: "
	lentextosuma equ $- textosuma
	saltodelinea db  0xA,0xD
	lensaltodelinea equ $- saltodelinea

segment .bss
	valor resb 1

section  .text
	global _start
_start:

	mov eax, 3 ; almacenamos en eax el valor tres (eax = 3)
while:
	cmp eax, 0  ; se compara eax con cero
	jna endwhile ; si eax no es mayor a cero salta fuera
                 ; del "ciclo" a la etiqueta endwhile
	add ebx, 2  ; aumenta en dos el valor de ebx (ebx+=2)
	sub eax, 1  ; disminuye en uno el valor de eax (eax -= 1)
	jmp while   ; salto incondicional para "ciclar" la ejecucion de las
                 ; instrucciones
endwhile:

	add ebx, 48
	mov [valor], ebx

	mov eax, 4
	mov ebx, 1
	mov ecx, textosuma
	mov edx, lentextosuma
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, valor
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