segment .data

	MsgError db "se produjo un error",0xA,0xD ;mensaje en caso de
	         ; existir un error al crear el archivo los numeros
	         ; hexadecimales son equivalentes a los numeros decimales
	         ; 10 y 13 los cuales permiten el salto de linea
	lon equ $ -MsgError

	MsgExito db "archivo abierto con exito",0xA,0xD
	lonexito equ $ -MsgExito

	encontrado db 'letra encontrada'
	lenencontrado equ $-encontrado

	noencontrado db 'letra no encontrada'
	lennoenecontrado equ $-noencontrado

	ln db 10,13
	lenln equ $-ln

	archivo db "/home/neomatrix/codigo ensamblador/prueba.txt",0
	        ; ubicacion en el sistema de archivos del archivo a crear y
	        ; y su nombre (prueba.txt), se usa el 0 como indicador
	        ; de fin de cadena
segment .bss
	idarchivo resd 1
	contenido resb 16384 ; ubicacion de memoria donde se alamcenara
                         ; el contenido del archivo
segment .text
	global _start
_start:
	; abrimos el archivo
	mov eax,5        ; indicamos que abriremos un archivo
	mov ebx,archivo  ; indicamos la ruta y el nombre del archivo
	mov ecx, 0; indicamos el modo de apertura del archivo
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

	;lectura del contenido del archivo
	mov eax, 3 ; indicamos que leeremos el contenido
	mov ebx, [idarchivo] ; colocamos el descriptor del archivo
	mov ecx, contenido ; especificamos la ubicacion de memoria
	                   ; donde almacenaremos los datos del archivo
	mov edx, 16384 ; establecemos la cantidad de bytes a leer
	int 80h

	;cierre del archivo
	mov eax, 6
	mov ebx, [idarchivo] ; colocamos el descriptor de archivo
	int 80h

	;impresion en pantalla del contenido del archivo
	mov eax, 4
	mov ebx, 1
	mov ecx, contenido
	mov edx, 16384
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ln
	mov edx, lenln
	int 0x80

	mov edi, contenido ; contenido es la ubicacion de memeoria
	                ; donde se ubica el contenido del archivo
	mov ecx, 15 ; utilizamos el registro ecx como contador
	mov al, 'h' ; especificamos la letra buscar

	cld ; colocamos en la bandera de direccion un cero, lo que nos
	    ; permitira movernos de izquierda a derecha, al incrementar
	    ; automaticamente las direcciones de memoria al utilizar
        ; instrucciones de manejo de cadenas

ciclo:
	scasb ; la instruccion scasb compara aun byte de la direccion de
              ; memoria destino con el valor del registro al,
              ; al hacer la comparacion aumenta en uno la direccion
              ; de memoria destino de forma automatica, esto debido a la
              ; instruccion cld

	je si_esta ; si el dato almacenado en el registro al y el ubicado en
               ; memoria son iguales la bandera de zero se coloca en uno
               ; la instruccion je lee este bit y si encuentra un uno
               ; realiza el salto a la etiqueta si_esta, de lo contrario
               ; no realiza ninguna accion
	loop ciclo

	mov eax, 4
	mov ebx, 1
	mov ecx, noencontrado
	mov edx, lennoenecontrado
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, ln
	mov edx, lenln
	int 0x80

	jmp salir

 si_esta:
 	mov eax, 4
	mov ebx, 1
	mov ecx, encontrado
	mov edx, lenencontrado
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, ln
	mov edx, lenln
	int 0x80

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