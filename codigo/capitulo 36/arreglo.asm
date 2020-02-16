segment .data
	arre db  '45', '23', '11', '09' ; estos datos se almacenan como
                                ; bytes en memoria, de forma consecutiva
	len equ ($-arre)/4

	temp	dq	0
    sum	dd	0

	ln db 10,13
	lenln equ $-ln

segment .text
	global _start
_start:
	mov eax, 4
	mov ebx, 0
	mov ecx, arre ; aqui estamos igualando el valor de ecx
           ; con el de la direccion de la etiqueta de memoria que
           ; el sistema operativo asigna en el momento de ejecutar
           ; el programa, por lo que es un numero dinámico
	mov edx, 2  ; enviamos a imprimir 2 bytes a la pantalla
	int 80h ; con esto hemos impreso en pantalla el primer elemento
            ; del arreglo (System.out.println(datos[0])) que presenta
            ; dos caracteres
	mov eax, 4
	mov ebx, 0
	mov ecx, ln
	mov edx, lenln
	int 80h

	mov eax, 4
	mov ebx, 0
	mov ecx, arre
	add ecx, 2 ; aumentamos en dos bytes el valor de la posición de
          ; memoria, con el fin de obtener el "segundo" elemento
          ; del arreglo "23" debido a que el "primer" elemento es
          ; "45" un elemento de dos bytes
	mov edx, 2  ; enviamos a imprimir 2 bytes a la pantalla
	int 80h ; con esto hemos impreso en pantalla el segundo elemento
          ; del arreglo (System.out.println(datos[1]))
	mov eax, 4
	mov ebx, 0
	mov ecx, ln
	mov edx, lenln
	int 80h
	salir:
	mov eax, 1
	xor ebx, ebx
	int 0x80
