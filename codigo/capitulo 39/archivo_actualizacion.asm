segment .data

	MsgError db "se produjo un error",0xA,0xD ;mensaje en caso de
	         ; existir un error al crear el archivo los numeros
	         ; hexadecimales son equivalentes a los numeros decimales
	         ; 10 y 13 los cuales permiten el salto de linea
	lon equ $ -MsgError

	MsgExito db "archivo abierto con exito",0xA,0xD
	lonexito equ $ -MsgExito

	mensajearchivo db "hola archivo"
	lonmensaje equ $ -mensajearchivo

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
	mov ecx, 2; indicamos el modo de apertura del archivo
    ; solo lectura = 0
    ; solo escritura = 1
    ; lectura/escritura = 2
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

	;desplazamiento del puntero del archivo
	mov eax, 19 ; indicamos que desplazaremos el puntero
	mov ebx, [idarchivo] ; colocamos el descriptor del archivo
	mov ecx, 5 ; especificamos el numero de bytes que desplazaremos
	           ; el puntero del archivo
	mov edx, 0 ; establecemos desde donde moveremos el puntero
	           ; del archivo
	; 0 = desde el inicio del archivo
	; 1 = desde la posicion actual del puntero
	; 2 = desde el final del archivo
	int 80h

	;escritura de contenido en el archivo
	mov eax, 4 ; indicamos que escribiremos contenido
	mov ebx, [idarchivo] ; colocamos el descriptor del archivo
	mov ecx, mensajearchivo ; especificamos la ubicacion de memoria
	     ; de donde se obtendran los datos a escribir en el archivo
	mov edx, lonmensaje ; establecemos la cantidad de bytes a escribir
	                    ; en el archivo
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