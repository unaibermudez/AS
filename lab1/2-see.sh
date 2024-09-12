#!/bin/bash
# Script para mostrar el contenido de un fichero o directorio

if [ -z "$1" ]; then 
    echo "Uso: $0 <nombre_fichero_directorio>"
    exit 1
fi

if [ -f "$1" ]; then 
    # si el parametro es un archivo, muestra su contenido con more
    more "$1"
elif [ -d "$1" ]; then 
    # si el parametro es un directorio, muestra su contenido con ls 
    ls "$1"
else 
    # si el parametro no es ni un archivo ni directorio, muestra mensaje de error
    echo "$1 no es un archivo ni un directorio valido."
    exit 1
fi

