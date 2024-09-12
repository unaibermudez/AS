#!/bin/bash
# Script para mostrar el contenido de /etc/passwd ordenado por nombre de usuario, UID o GID

# Verificar que se ha proporcionado un parámetro
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <usuario|uid|gid>"
    exit 1
fi

# Asignar el parámetro a una variable
criterio="$1"

# Verificar el criterio y ejecutar el comando de ordenación correspondiente
case "$criterio" in
    usuario)
        # Ordenar por nombre de usuario (campo 1 en /etc/passwd)
        sort -t: -k1 /etc/passwd
        ;;
    uid)
        # Ordenar por UID (campo 3 en /etc/passwd)
        sort -t: -k3n /etc/passwd
        ;;
    gid)
        # Ordenar por GID (campo 4 en /etc/passwd)
        sort -t: -k4n /etc/passwd
        ;;
    *)
        echo "Error: El criterio '$criterio' no es válido. Use 'usuario', 'uid' o 'gid'."
        exit 1
        ;;
esac

