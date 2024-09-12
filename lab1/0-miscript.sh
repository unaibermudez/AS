#!/bin/bash

echo "hola mundo"

echo "hola "$1

echo "Introduce un numero: "
read numero 

echo "El numero es " $numero

if [ $numero -eq 5 ]
then 
	echo "el numero es 5"
else
	echo "el numero no es 5"
fi


