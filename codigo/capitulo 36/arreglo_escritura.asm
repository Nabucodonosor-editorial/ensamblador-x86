segment .data
	arre db  0, 0, 0, 0 ; se almacenan los valores dentro
                      ; del rango del 0 a 9 para
                      ; evitar imprimir símbolos
	len equ $-arre
	msg1 db "ingrese un numero y presione enter, cuatro veces:", 0xA
	len1 equ $-msg1
	ln db 10,13
	lenln equ $-ln

segment .bss
	dato resb 2 ; reservamos dos bytes debido a que al leer un dato
                ; del teclado se almacenara tambien el enter (\n) o
                ; salto de linea

segment .text
	global _start
_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 0x80

	mov esi, arre ; colocamos la direccion de memoria en el registro
               ; esi esto para mejorar la velocidad del programa
	mov edi, 0 ; colocamos el numero cero en el registro edi
               ; que nos servira de contador

ciclo_lectura:
	mov eax, 3 ; leemos datos de un dispositivo
	mov ebx, 0 ; especifiamos que el dispositivo es el teclado
	mov ecx, dato ; direccion de memoria donde almacenaran los
                 ; caracteres leidos
	mov edx, 2 ; leemos dos bytes del teclado, el dato y el salto de
               ; linea (\n)
	int 0x80

	mov al, [dato] ; accedemos al dato introducido desde el teclado y
                   ; lo guardamos en el registro al
	sub al, '0' ; ya que el caracter lo deseamos pasar a su valor
                 ; numerico le restamos 30h, 48 o el caracter '0'
	mov [esi+edi], al ;colocamos el dato dentro del arreglo en la
                      ;posision edi (0,1,2,....) en bytes

	add edi,1 ; incrementamos edi en uno
	cmp edi,len ; preguntamos si ya hemos leido todos los
                ; numeros del arreglo
	jb ciclo_lectura ; si aun faltan datos por imprimir damos vuelta
                     ; al ciclo de nuevo y en caso contrario dejamos
                     ; de imprimir en pantalla

	mov edi, 0 ; colocamos el numero cero en el registro edi
               ; que nos servira de contador

ciclo_impresion:
	mov al, [esi+edi] ;obtenemos el dato dentro del arreglo en la
                      ;posision edi (0,1,2,....)
    add al, '0' ; convertimos el numero entero a caracter
	mov [dato], al ; movemos el dato obtenido a la posision de
                   ; memoria dato

    add edi,1 ; incrementamos edi en uno

	mov eax, 4
	mov ebx, 0
	mov ecx, dato
	mov edx, 1
	int 80h ; se imprimen el valor de los elementos del arreglo
        ; en pantalla

	cmp edi,len ; preguntamos si ya hemos impreso todos los
                ; datos del arreglo
	jb ciclo_impresion ; si aun faltan datos por imprimir damos vuelta
                ; al ciclo de nuevo y en caso contrario dejamos
                ; de imprimir en pantalla
	mov eax, 4
	mov ebx, 1
	mov ecx, ln
	mov edx, lenln
	int 0x80
salir:
	mov eax, 1
	xor ebx, ebx
	int 0x80