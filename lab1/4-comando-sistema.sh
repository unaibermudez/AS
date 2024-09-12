#4) Crear un script que pida al usuario que teclee una palabra y compruebe si es un comando del sistema o no.

#!/bin/bash 

echo "Introduce una palabra: "
read palabra

if [ -x /bin/$palabra ]; then
    echo "Es un comando del sistema"
else
    echo "No es un comando del sistema"
fi
