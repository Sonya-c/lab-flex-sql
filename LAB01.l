
/**=================== Definitions ===================**/
%{
    #include <stdio.h>
    #include <ctype.h>
    #include <iostream>
    #include <vector>
    #include <string>
    
    using namespace std;

    vector<string> identifiers;

    int num_errors = 0;

    char* toUpper(char* str) {
        for (int i = 0; str[i]; i++) {
            str[i] = toupper(str[i]);
        }
        return str;
    }

    int search_id(string id) {
        for (int i = 0; i < identifiers.size(); i++) {
            if (identifiers.at(i) == id) {
                return i;
            }
        }
        return -1;
    }

    void add_id(string id) {
        identifiers.insert(identifiers.end(), id);
    }
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
TYPE {TYPE_INTEGER}|{TYPE_DECIMAL}|{TYPE_VARCHAR}
TYPE_INTEGER [iI][nN][tT][eE][gG][eE][rR] 
TYPE_DECIMAL [dD][eE][cC][iI][mM][aA][lL] 
TYPE_VARCHAR [vV][aA][rR][cC][hH][aA][rR]

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
STRING \'[^\']*\'|\"[^\"]*\"

/* Identificadores: Nombres de tablas y columnas */
ACCENT [áéíóúÁÉÍÓÚñÑ]
DIGIT [0-9]
ALPHA [a-zA-Z]|{ACCENT}
ID {ALPHA}({ALPHA}|{DIGIT})*

ERROR {DIGIT}+{ALPHA}+({DIGIT}|{ALPHA})*

%%
{COMMAND}|{TYPE} {
    printf("%s ", toUpper(yytext));
}

{ERROR} {
    printf("ERROR: %s ", yytext);
    num_errors++;
}

{ID} {
    int index = search_id(yytext);

    if (index == -1) {
        add_id(yytext);
        index = search_id(yytext);
    }
    printf("id%d=%s", index + 1, yytext);
}

{STRING} {printf("cadena=%s", yytext);}

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

    printf("\n\n\n");
    printf("%zu Identificadores\n", identifiers.size());

    for (int i = 0; i < identifiers.size(); i++) {
        printf("id%d=%s\n", i + 1, identifiers.at(i).c_str());
    }

    printf("\n%d Errores lexicos", num_errors);
}