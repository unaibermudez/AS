#!/bin/bash
# Script para contar el numero de caracteres de una palabra introducida

read -p "Teclea una palabra: " palabra

longitud=${#palabra}

echo "'$palabra' tiene $longitud caracteres" 

