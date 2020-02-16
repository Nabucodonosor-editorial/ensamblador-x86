#include <stdio.h>
#include <stdint.h>

int suma(int dato, int dato2){
int salida; // en C un dato de tipo int ocupa 32 bits (4 bytes)
asm volatile ( // esta instruccion nos permite colocar codigo ensamblador
		       // en el programa c
	"addl %%ebx, %%eax;" // codigo ensamblador Gnu Assembler, soportado
                         // por el compilador gcc existente en Gnu/Linux
    : "=a" (salida)  // la letra a hace referencia
    // al operando destino que en la sintaxis at&t, refiere al registro eax
    // el simbolo = indica que se copiara el valor del regitro eax a una
    // variable, en este caso salida; una vez se haya ejecutado la
    //instruccion
    : "a" (dato), "b" (dato2)  // esta instruccion indica que se copiara
    // el contenido de la variable dato al operando destino (eax), y el
    // contenido de la variable dato2 se copiara al operando fuente (ebx)
);
return salida;
}

int main(){

int resultado = 0;
resultado = suma(5,2); // invocacion de la funcion suma


printf("resultado = %d\n", resultado); // impresion en pantalla de la
	                                   // variable resultado
return 0;
}