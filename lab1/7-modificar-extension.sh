#!/bin/bash
# Script para cambiar la extensión de todos los archivos .txt a .y en un directorio

# Verificar que se ha proporcionado un directorio como argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <directorio>"
    exit 1
fi

# Asignar el directorio a una variable
directorio="$1"

# Verificar que el directorio existe
if [ ! -d "$directorio" ]; then
    echo "El directorio '$directorio' no existe."
    exit 1
fi

# Cambiar al directorio especificado
cd "$directorio"

# Iterar sobre todos los archivos .txt y cambiar la extensión a .y
for archivo in *.txt; do
    # Verificar si hay archivos .txt en el directorio
    if [ -e "$archivo" ]; then
        mv "$archivo" "${archivo%.txt}.t"
    fi
done

echo "Extensiones cambiadas de .txt a .t en el directorio '$directorio'."

