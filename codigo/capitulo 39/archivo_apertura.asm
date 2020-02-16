segment .data

	MsgError db "se produjo un error",0xA,0xD ;mensaje en caso de
	         ; existir un error al crear el archivo los numeros
	         ; hexadecimales son equivalentes a los numeros decimales
	         ; 10 y 13 los cuales permiten el salto de linea
	lon equ $ -MsgError

	MsgExito db "archivo abierto con exito",0xA,0xD
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
	; abrimos el archivo
	mov eax,5        ; indicamos que abriremos un archivo
	mov ebx,archivo  ; indicamos la ruta y el nombre del archivo
	mov ecx, 0; indicamos el modo de apertura del archivo
    ; solo lectura = 0000h
    ; solo escritura = 0001h
    ; lectura/escritura = 0002h
    ; banderas
    ; escritura la final del archivo = 0400h
    ; trunca a cero la longitud el archivo = 0200h
    ; crea el archivo si no existe = 0040h, es necesario indicar los permisos
    ; mod edx, 640q
    ; O_ACCMODE = 3h
    ; O_ASYNC  = 2000h
    ; O_CLOEXEC= 80000h
    ; O_DIRECT = 4000h
    ; O_DIRECTORY = 10000h
    ; O_DSYNC  = 1000h
    ; O_EXCL   = 80h
    ; O_FSYNC  = 101000h
    ; O_NDELAY = 800h
    ; O_NOATIME= 40000h
    ; O_NOCTTY = 100h
    ; O_NOFOLLOW = 20000h
    ; O_NONBLOCK = 800h
    ; O_RSYNC  = 101000h
    ; O_SYNC   = 101000h
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
	mov ebx, [idarchivo] ; colocamos el descriptor de archivo
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