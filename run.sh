# ERROR:
# bash: ./run.sh: Permiso denegado
# FIX (run):
# chmod u+x run.sh

# from lex to c
flex -o LAB01.yy.c LAB01.l

# from c to out
gcc LAB01.yy.c -o LAB01.out

# run the file from txt
./LAB01.out entrada.txt > salida.txt