# 6) Extender el script anterior para que cada fichero contenga la N-sima línea delmanual de ls (man ls). El fichero fich0.txt tendrá la línea 0 del manual, fich1.txt tendrá la línea 1 del manual, …


#!/bin/bash

mkdir cosas2

for i in {0..99}
do
    touch cosas2/fic$i.txt
    echo "linea $i:"
    man ls | sed -n "${i}p" > cosas2/fic$i.txt
   
    
done

echo "fin"

