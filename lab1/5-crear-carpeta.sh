# 5) Crear un script que cree una carpeta llamada cosas y después cree 100 ficheros vacíos llamados fich<numero>.txt dentro de ella, donde <numero> es un número entre 0 y 99.

#!/bin/bash

mkdir cosas

for i in {0..99}
do
    touch cosas/fich$i.txt
done

