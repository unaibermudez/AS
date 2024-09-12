#!/bin/bash
# Script para mostrar solo los directorios en el directorio actual

for dir in */; do
    if [ -d "$dir" ]; then
        echo "$dir"
    fi
done
