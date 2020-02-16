segment .data

	MsgError db "se produjo un error",0xA,0xD ;mensaje en caso de existir
	         ; un error al crear el archivo los numeros hexadecimales son
	         ; equivalentes a los numeros decimales 10 y 13 los cuales
	         ; permiten el salto de linea
	lon equ $ -MsgError

	MsgExito db "archivo creado con exito",0xA,0xD
	lonexito equ $ -MsgExito

	archivo db "/home/neomatrix/codigo ensamblador/prueba.txt",0
	        ; ubicacion en el sistema de archivos del archivo a crear y
	        ; y su nombre (prueba.txt), se usa el 0 como indicador
	        ; de fin de cadena
segment .bss
	idarchivo resd 1

segment .text
	global _start
_start:
	; creamos y abrimos el archivo
	mov eax,8        ; indicamos que crearemos un archivo nuevo
	mov ebx,archivo  ; indicamos la ruta y el nombre del archivo
	mov ecx,640q   ; establecemos los permisos del archivo en el
	               ; formato de permisos de linux (octal)
    ; lectura = 4
    ; escritura = 2 (solo para el propietario)
    ; ejecucion = 1
	int 80h

	cmp eax,0 ; el descriptor de archivo es un numero entero
	          ; no negativo
	jl error ; de ser negativo ha ocurrido un error

	mov dword[idarchivo] , eax ; guardamos el descriptor del archivo
	                           ; en memoria, para su uso posterior

	mov eax, 4
	mov ebx, 1
	mov ecx, MsgExito
	mov edx, lonexito
	int 80h

	;cierre del archivo
	mov eax, 6
	mov ebx, [idarchivo] ; pasamos el descriptor de archivo
	int 80h
	jmp salir

	error:
	; Mostramos el mensaje de error
	mov eax, 4
	mov ebx, 1
	mov ecx, MsgError
	mov edx, lon
	int 80h

	salir:
	mov eax, 1
	xor ebx,ebx
	int 0x80