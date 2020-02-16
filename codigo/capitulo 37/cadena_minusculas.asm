segment .data
	string1 db 'HOLA MUNDO'
	len equ $-string1

	ln db 10,13
	lenln equ $-ln

segment .bss
	string2 resb 10

segment .text
	global _start
_start:

	mov ecx, len ; utilizamos el registro ecx como contador
	mov esi, string1 ; especificamos la ubicacion de memoria de donde
	                 ; obtendremos los datos a procesar
	mov edi, string2 ; especificamos la ubicacion de memoria en donde
                     ; almacenaremos los datos procesados
	cld ; colocamos en la bandera de direccion un cero, lo que nos
	    ; permitira movernos de izquierda a derecha, al incrementar
	    ; automaticamente las direcciones de memoria al usar
        ; instrucciones de manejo de cadenas
ciclo:
	lodsb ; copia un byte de memoria en el registro al y se aumenta
	      ; en uno la direccion de memoria origen de forma automatica
	or al, 20h ; la operacion logica or entre el dato almacenado y el
	           ; numero 20h permite convertir de mayuscula a minuscula
	stosb ; copia a la memoria el dato almacenado en el registro al
   ; y se aumenta en uno la direccion de memoria destino automaticamente
	loop ciclo ; resta en uno el valor contenido en ecx, si el valor de
	           ; ese registro despues de la sustraccion es diferente de
	           ; cero saltara a la etiqueta ciclo, de lo contrario no
	           ; realizara ninguna acción.

	mov eax, 4
	mov ebx, 1
	mov ecx, string2
	mov edx, len
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