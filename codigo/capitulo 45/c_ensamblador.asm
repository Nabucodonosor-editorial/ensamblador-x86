
; ------------ To assemble and run:----------------------------------
;     linux
; nasm -f elf32  c_ensamblador.asm & gcc -m32  c_ensamblador.o -o c_ensamblador & ./c_ensamblador
; -------------------------------------------------------------------

extern printf ; invocacion de la funcion printf de C

section .data
	mensaje db 'Hello',10,13, 0 ; Las cadenas en c requieren el
                      ; byte cero para encontrar el fin de cadena

section .text
	global  main ; la etiqueta main se indica como global para que
	             ; el ligador lo encuentre y ensamble
main: ; inicio del procedimiento main (funcion main de c)
	push   mensaje ; insercion en la pila de la cadena a imprimir
	call   printf ; invocacion de la funcion printf de c
	add    esp, 4 ; eliminacion de los ultimos 4 bytes de la pila
                  ; donde la funcion printf almaceno ciertos datos
	ret ; retorno del procedimiento main


; ------------ To assemble and run:----------------------------------
;     windows
;     nasm -f win32 hola.asm && gcc hola.obj -o main.exe  && main.exe
; -------------------------------------------------------------------

;extern _printf ; invocacion de la funcion printf de C

;section .data
;	mensaje db 'Hello',10,13, 0 ; Las cadenas en c requieren el
                      ; byte cero para encontrar el fin de cadena

;section .text
;	global  _main ; la etiqueta main se indica como global para que
	             ; el ligador lo encuentre y ensamble
;_main: ; inicio del procedimiento main (funcion main de c)
;	push   mensaje ; insercion en la pila de la cadena a imprimir
;	call   _printf ; invocacion de la funcion printf de c
;	add    esp, 4 ; eliminacion de los ultimos 4 bytes de la pila
                  ; donde la funcion printf almaceno ciertos datos
;	ret ; retorno del procedimiento main
