segment .data
	string1 db 'hola cadenas'
	len equ $-string1

	encontrado db 'letra encontrada'
	lenencontrado equ $-encontrado

	noencontrado db 'letra no encontrada'
	lennoenecontrado equ $-noencontrado

	ln db 10,13
	lenln equ $-ln

segment .text
	global _start
_start:

	mov ecx, len ; utilizamos el registro ecx como contador
	mov edi, string1 ; especificamos la ubicacion de memoria en donde
                     ; se encuentra el inicio de la cadena sobre la
                     ; cual realizaremos la busqueda
	mov al, 'n' ; colocamos en el registro al el caracter a buscar
	cld ; colocamos en la bandera de direccion un cero, lo que nos
	    ; permitira movernos de izquierda a derecha, al incrementar
	    ; automaticamente las direcciones de memoria al utilizar
        ; instrucciones de manejo de cadenas

	repne scasb ; la instruccion scasb compara aun byte de la direccion de
              ; memoria destino con el valor del registro al,
              ; al hacer la comparacion aumenta en uno la direccion
              ; de memoria destino de forma automatica, esto debido a la
              ; instruccion cld
              ; la instruccion rep disminuira en uno el valor almacenado
              ; en el registro ecx y ejecutara la instruccion movsb hasta
              ; que el valor del registro ecx sea cero

    je si_esta ; si el dato almacenado en el registro al y el ubicado en
               ; memoria son iguales la bandera de zero se coloca en uno
               ; la instruccion je lee este bit y si encuentra un uno
               ; realiza el salto a la etiqueta si_esta, de lo contrario
               ; no realiza ninguna accion

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

salir:
	mov eax, 1
	xor ebx, ebx
	int 0x80