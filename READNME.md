# Laboratorio de Análisis Léxico- Lex

**Objetivo:** Aplicar el proceso de análisis léxico para identificar los tokens del lenguaje SQL y los errores
léxicos.

## Compilación y ejecución

1. Compilar el archivo fuente lex a

    ~~~bash
    flex -o LAB01.yy.c LAB01.l
    ~~~

2. Compilar el archivo C a un ejecutable

    ~~~bash
    gcc LAB01.yy.c -o LAB01.out
    ~~~

3. Ejecutar

    ~~~bash
    ./LAB01.out entrada.txt > salida.txt
    ~~~
