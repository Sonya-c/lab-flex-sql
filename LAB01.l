
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

/*----- COMANDOS -------*/
COMMAND {CREATE}|{DROP}|{SEARCH}|{MANIPULATION}|{FUNCTION}|{RESERVED}|{TABLE}

/* Creación y eliminación (CREATE TABLE, DROP TABLE) */
TABLE [tT][aA][bB][lL][eE]
CREATE [cC][rR][eE][aA][tT][eE]
DROP [dD][rR][oO][pP]

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
OP_ADD "+"
OP_SUB "-"
/*OP_MULT "*"*/
OP_DIV "/"
OP_EQ "=="
OP_DIFF "<>"
OP_GT ">"
OP_LT "<"
OP_GE ">="
OP_LE "<="
OP_AND [aA][nN][dD]
OP_OR [oO][rR]

/* Separadores: Paréntesis que abre ( ( ), paréntesis que cierra( ) ), coma (,), punto y coma (;), asignación (=) */
PARAOPEN "("
PARACLOSE ")"
COMMAN ","
SEMICOLON ";"
ASIG "="

/* Caracteres especiales: asterisco (*) */
AST "*"

/* Identificadores: Nombres de tablas y columnas */
DIGIT [0-9]
ACCENT [áéíóúÁÉÍÓÚñÑ]
ALPHA [a-zA-Z]|{ACCENT}
ID {ALPHA}({ALPHA}|{DIGIT})*

/* Números: entero o decimal */
INTEGER {DIGIT}+
DECIMAL {INTEGER}?"\."{INTEGER}|{INTEGER}"\."{INTEGER}?

/* Cadenas: entre comillas ’ (no son variables o indetificadores) */
STRING \'[^\']*\'|\"[^\"]*\"

ERROR {INTEGER_ERROR}|{DECIMAL_ERROR}
INTEGER_ERROR {INTEGER}{ALPHA}+({INTEGER}|{ALPHA})*
DECIMAL_ERROR {INTEGER_ERROR}"\."{INTEGER}|{INTEGER}"\."{INTEGER_ERROR}|{INTEGER_ERROR}"\."{INTEGER_ERROR}
%%
\n|" "|\t {printf("%s", yytext);}

{COMMAND}|{TYPE} {
    printf("%s", toUpper(yytext));
}

{OP_ADD} {printf(" suma=%s ", yytext);}
{OP_SUB} {printf(" resta=%s ", yytext);}
{OP_DIV} {printf(" div=%s ", yytext);}
{OP_EQ} {printf(" igual=%s ", yytext);}
{OP_DIFF} {printf(" dife=%s ", yytext);}
{OP_GT} {printf(" mayorq=%s ", yytext);}
{OP_LT} {printf(" menorq=%s ", yytext);}
{OP_GE} {printf(" mayoriq=%s ", yytext);}
{OP_LE} {printf(" menoriq=%s ", yytext);}
{OP_AND} {printf(" y=%s ", yytext);}
{OP_OR} {printf(" o=%s ", yytext);}

{PARAOPEN} {printf(" parabre=%s ", yytext);}
{PARACLOSE} {printf(" parcierr=%s ", yytext);}
{COMMAN} {printf(" coma=%s", yytext);}
{SEMICOLON} {printf(" puntcoma=%s", yytext);}
{ASIG} {printf(" asign=%s ", yytext);}

{AST} {printf(" asterisco=%s", yytext);}

{ERROR} {
    printf("ERROR=%s ", yytext);
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

{INTEGER} {printf("entero=%s" yytext);}
{DECIMAL} {printf("decimal=%s", yytext);}


. {
    printf("ERROR: %s ", yytext);
    num_errors++;
}
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

    printf("\n%d Errores lexicos\n", num_errors);
}