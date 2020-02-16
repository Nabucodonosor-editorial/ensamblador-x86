segment .data
	string1 db 'hola'
	len equ $-string1

	string2 db 'hola'
	len2 equ $-string2

	siiguales db 'las cadenas son iguales'
	lensiiguales equ $-siiguales

	noiguales db 'las cadenas son diferentes'
	lennoiguales equ $-noiguales

	ln db 10,13
	lenln equ $-ln

segment .text
	global _start
_start:

	mov ecx, len ; utilizamos el registro ecx como contador
	mov esi, string1 ; especificamos la ubicacion de memoria en donde
                     ; se encuentra la cadena origen
	mov edi, string2 ; especificamos la ubicacion de memoria en donde
                     ; se encuentra la cadena destino

	cld ; colocamos en la bandera de direccion un cero, lo que nos
	    ; permitira movernos de izquierda a derecha, al incrementar
	    ; automaticamente las direcciones de memoria al utilizar
        ; instrucciones de manejo de cadenas

ciclo:
	cmpsb ; la instruccion cmpsb compara un byte de la direccion de
              ; memoria origen con un byte de la direccion de memoria
              ; destino, al hacer la comparacion aumenta en uno las
              ; direcciones de memoria de forma automatica, esto debido
              ; a la instruccion cld
              ; la instruccion rep disminuira en uno el valor almacenado
              ; en el registro ecx y ejecutara la instruccion cmpsb hasta
              ; que el valor del registro ecx sea cero

	jne no_iguales; si los datos almacenados en memoria no son
               ; iguales la bandera de zero se coloca en cero la
               ; instruccion jne lee este bit y si encuentra un cero
               ; realiza el salto a la etiqueta no_iguales, de lo contrario
               ; no realiza ninguna accion
	loop ciclo ; resta en uno el valor contenido en ecx, si el valor de
	           ; ese registro despues de la sustraccion es diferente de
	           ; cero saltara a la etiqueta ciclo, de lo contrario no
	           ; realizara ninguna acción.

	mov eax, 4
	mov ebx, 1
	mov ecx, siiguales
	mov edx, lensiiguales
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, ln
	mov edx, lenln
	int 0x80

	jmp salir

no_iguales:
	mov eax, 4
	mov ebx, 1
	mov ecx, noiguales
	mov edx, lennoiguales
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, ln
	mov edx, lenln
	int 0x80

salir:
	mov eax, 1
	xor ebx, ebx
	int 0x80