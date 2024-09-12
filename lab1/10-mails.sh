#!/bin/bash
# Script para generar ficheros de e-mail personalizados

# Verificar que los archivos necesarios existen
if [ ! -f "cuerpo.txt" ]; then
    echo "Error: El archivo 'cuerpo.txt' no existe."
    exit 1
fi

if [ ! -f "nombres.txt" ]; then
    echo "Error: El archivo 'nombres.txt' no existe."
    exit 1
fi

# Leer el contenido del archivo cuerpo.txt
cuerpo=$(<cuerpo.txt)

# Iterar sobre cada nombre en nombres.txt
while IFS= read -r nombre; do
    # Reemplazar la palabra 'NOMBRE' en el cuerpo del e-mail con el nombre del destinatario
    mensaje="${cuerpo//NOMBRE/$nombre}"
    
    # Guardar el mensaje personalizado en un archivo
    echo "$mensaje" > "email_$nombre.txt"
    
    echo "Archivo 'email_$nombre.txt' creado para $nombre."
done < nombres.txt

echo "Proceso completado. Se han creado los ficheros personalizados."

