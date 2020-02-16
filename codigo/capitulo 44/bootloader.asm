	;;----------------------BOOTLOADER-------------------------------
	USE16 ; especifica que se usara el modo de compilacion de 16 bits
	ORG 0x7C00 ; especifica que el programa se cargara en la direccion
	           ; 0x7C00 de la memoria

	jmp inicio ; salto a la etiqueta inicio

	inicio: ; funcion principal del programa
	mov al, "h" ; caracter a escribir en la pantalla
	mov ah, 0x0E ; escribe un caracter en la pantalla y avanza el cursor
	int 0x10

	mov al, "o"
	mov ah, 0x0E
	int 0x10

	mov al, "l"
	mov ah, 0x0E
	int 0x10

	mov al, "a"
	mov ah, 0x0E
	int 0x10


	mov al, "_"
	mov ah, 0x0E
	int 0x10

	mov al, "m"
	mov ah, 0x0E
	int 0x10

	mov al, "u"
	mov ah, 0x0E
	int 0x10

	mov al, "n"
	mov ah, 0x0E
	int 0x10

	mov al, "d"
	mov ah, 0x0E
	int 0x10

	mov al, "o"
	mov ah, 0x0E
	int 0x10

	hlt ; Esta instruccion detiene el procesador para que ya no ejecute
	    ; mas instrucciones.

	;; -----------------------Estructura MBR----------------------------------
	TIMES 510 - ($-$$) db 0 ; Completa el archivo con ceros hasta 2 bytes antes
	                        ; del final, esto para ocupar todo el sector boot (MBR).
	dw 0xAA55 ; los dos bytes finales del programa contiene la firma que identifica
	           ; al programa como un MBR Booteable.