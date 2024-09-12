#!/bin/bash
# Script para borrar un fichero según la suma de los parámetros proporcionados

# Verificar que se han proporcionado parámetros
if [ "$#" -eq 0 ]; then
    echo "Uso: $0 <número1> <número2> ... <númeroN>"
    exit 1
fi

# Inicializar la variable para la suma
suma=0

# Iterar sobre los parámetros y calcular la suma
for parametro in "$@"; do
    # Verificar que el parámetro es un número entre 0 y 9
    if [[ ! "$parametro" =~ ^[0-9]$ ]]; then
        echo "Error: El parámetro '$parametro' no es un número válido (debe estar entre 0 y 9)."
        exit 1
    fi
    suma=$((suma + parametro))
done

# Construir el nombre del fichero a borrar
fichero="fich$suma.txt"

# Verificar si el fichero existe y borrarlo
if [ -e "$fichero" ]; then
    rm "$fichero"
    echo "Fichero '$fichero' borrado."
else
    echo "El fichero '$fichero' no existe."
fi

