# ERROR:
# bash: ./run.sh: Permiso denegado
# FIX (run):
# chmod u+x run.sh

# from lex to c
flex -o LAB01.yy.cpp LAB01.l

# from c to out
g++ -std=c++11 -o LAB01.out LAB01.yy.cpp -lfl

# run the file from txt
./LAB01.out entrada.txt > salida.txt

cat salida.txt
echo "\n"