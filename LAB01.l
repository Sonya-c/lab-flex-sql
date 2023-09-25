
/**=================== Definitions ===================**/
%{
    #include <stdio.h>
    #include <ctype.h>

    int num_errors = 0;
%}

/** GRAMATICA **/

WS " "

/*----- COMANDOS -------*/
COMMAND {CREATE}|{DROP}|{SEARCH}|{MANIPULATION}|{FUNCTION}|{RESERVED}

/* Creación y eliminación (CREATE TABLE, DROP TABLE) */
TABLE [tT][aA][bB][lL][eE]
CREATE [cC][rR][eE][aA][tT][eE]{WS}{TABLE}
DROP [dD][rR][oO][pP]{WS}{TABLE}

/* Busqueda (SELECT, WHERE, GROUP BY, ORDER BY) */
SEARCH {SELECT}|{WHERE}|{GROUP}" "{BY}|{ORDER}" "{BY}
SELECT [sS][eE][lL][eE][cC][tT] 
WHERE [wW][hH][eE][rR][eE]
BY [bB][yY]
GROUP [gG][rR][oO][uU][pP]
ORDER [oO][rR][dD][eE][rR]

/* Manipulación (INSERT, DELETE, UPDATE)*/
MANIPULATION {INSERT}|{DELETE}|{UPDATE}
INSERT [iI][nN][sS][eE][rR][tT]
DELETE [dD][eE][lL][eE][tT][eE]
UPDATE [uU][pP][dD][aA][tT][eE]

/* Funciones (MAX, MIN, AVG, COUNT) */
FUNCTION {MAX}|{MIN}|{AVG}|{COUNT}
MAX [mM][aA][xX]
MIN [mM][iI][nN]
AVG [aA][vV][gG]
COUNT [cC][oO][uU][nN][tT]  

/* Palabras reservadas (INTO, VALUES, FROM, SET, ASC, DESC) */
RESERVED {INTO}|{VALUES}|{FROM}|{SET}|{ASC}|{DESC}
INTO [iI][nN][tT][oO]
VALUES [vV][aA][lL][uU][eE][sS]
FROM [fF][rR][oO][mM]
SET [sS][eE][tT]
ASC [aA][sS][cC]
DESC [dD][eE][sS][cC]

/* Tipos de datos: INTEGER, DECIMAL, VARCHAR... */
TYPE {INTEGER}|{DECIMAL}|{VARCHAR}
INTEGER [iI][nN][tT][eE][gG][eE][rR] 
DECIMAL [dD][eE][cC][iI][mM][aA][lL] 
VARCHAR [vV][aA][rR][cC][hH][aA][rR]

/* Operadores: 
- aritmeticos: suma (+), resta (-), multiplicación (*), división (/)
- relacionales: igualdad (=), diferencia (<>), mayor que (>), menor que (<), mayor o igual que (>=), menor o igual que (<=)
- logicos: conjunción (AND) y disyunción (OR)
*/

/* Separadores: Paréntesis que abre ( ( ), paréntesis que cierra( ) ), coma (,), punto y coma (;),
asignación (=) */

/* Caracteres especiales: asterisco (*) */

/* Números: entero o decimal */

/* Cadenas: entre comillas ’ (no son variables o indetificadores) */

/* Identificadores: Nombres de tablas y columnas */


/** ESTRUCTURAS **/

/* Creación o eliminación de tablas */

/* Inserción, Eliminación, Actualización*/

/* Búsqueda básica, con funciones y combinada */

/* Búsquedas Condicionadas, agrupadas y ordenadas */

/**====================== Rules ========================**/

/* Cada una de las palabras reservadas y comandos de las instrucciones debe mostrarse en mayúscula */

/* Los identificadores deben ir numerados. En caso de encontrar uno repetido debe tener la misma numeración en cada aparición. Al terminar el análisis léxico se deben mostrar cuántos y cuáles fueron los identificadores encontrados */

/* Para los números, operadores y separadores se debe especificar el tipo de token encontrado */

/*Para los números identificar si son enteros o decimales*/

/* Errores léxicos
- Un token no especificado en la gramática debe indicar error en el lugar donde fue encontrado.
- Un error en la estructura de la instrucción no es un error léxico
*/

%%
{COMMAND}|{TYPE} {
    // Handle commands and types to uppercase
    for (int i = 0; yytext[i]; i++) {
        yytext[i] = toupper(yytext[i]);
    }

    printf("%s", yytext);
}
. {printf(" ");}
%%

/**=================== CODE SECTION ===================**/

int yywrap(){return 1;}

int main( int argc, char **argv )
    {
    ++argv, --argc; /* skip over program name */
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;
    yylex();
}