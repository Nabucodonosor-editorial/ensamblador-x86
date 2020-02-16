segment .data
	string1 db 'hola cadenas'
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
	    ; automaticamente las direciones de memoria al usar operaciones
        ; de manejo de cadenas

	rep movsb ; la instruccion movsb copia un byte de la direccion de
              ; memoria origen a la ubicacion de memoria destino,
              ; al hacer la transferencia aumenta en uno las direcciones
              ; de memoria de forma automatica
              ; la instruccion rep disminuira en uno el valor almacenado
              ; en el registro ecx y ejecutara la instruccion movsb hasta
              ; que el valor del registro ecx sea cero

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