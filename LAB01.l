
/**=================== Definitions ===================**/
%{
    int num_errors = 0;
%}

/** GRAMATICA **/
/* Comandos:
- Creación y eliminación (CREATE TABLE, DROP TABLE)
- Busqueda (SELECT, WHERE, GROUP BY, ORDER BY)
- Manipulación (INSERT, DELETE, UPDATE)
- Funciones (MAX, MIN, AVG, COUNT)
- Palabras reservadas (INTO, VALUES, FROM, SET, ASC, DESC)
*/

/* Tipos de datos: INTEGER, DECIMAL, VARCHAR... */

/* Operadores: 
- aritmeticos: suma (+), resta (-), multiplicación (*), división (/)
- relacionales: igualdad (=), diferencia (<>), mayor que (>), menor que (<), mayor o igual que (>=), menor o igual que (<=)
- logicos: conjunción (AND) y disyunción (OR)
*/

/* Separadores: Paréntesis que abre ( ( ), paréntesis que cierra( ) ), coma (,), punto y coma (;),
asignación (=) */

/* Caracteres especiales: asterisco (*) */

/* Números: entero o decimal */

/* Cadenas: entre comillas (no son variables o indetificadores) */

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
%%

/**=================== CODE SECTION ===================**/

int yywrap(){}

int main( int argc, char **argv )
    {
    ++argv, --argc; /* skip over program name */
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;
    yylex();
}