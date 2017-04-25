#!/bin/bash

#Obtine el uso del procesador del Usuario y lo Almacenamos en una variable.

CpuUsr=$(top | head -n2 | tail -1 | tr -s ' ' ' ' | cut -d ' ' -f2 | tr -s '%' ' ')

#Obtine el uso del procesador del Sistema y lo Almacenamos en una variable.

CpuSym=$(top | head -n2 | tail -1 | tr -s ' ' ' ' | cut -d ' ' -f4 | tr -s '%' ' ')

#Para obtener el uso de la Cpu total se suma los 2 valores anteriores.

CpuTotal=$(( $CpuUsr +  $CpuSym))


#Obtiene el carga del sistema promedio de los ultimos 15 min y lo Almacenamos en una variable.

Load=$(cat /proc/loadavg | cut -d ' ' -f3)

#Obtiene la el porcentaje de uso de la memoria RAM tenemos que tener la memoria que esta siendo
#utilizada y la memoria total.

PorcRam=$(echo $((`free -m | grep '+' | awk {'print $3'}`*100/`free -m |grep 'Mem:' | awk {'print $2'}`)))

#Obtiene el Almacenaciento Disponible y lo Almacenamos en una variable.

FreeSpace=$( df -h | grep 'loop0' | tr -s ' ' ' ' | cut -d ' ' -f4 |tr -s 'M' ' ')

#Obtiene la Velocidad de Bajada de la Banda Ancha

DownSpeed=$(./speedtest.py | grep 'Download:' | cut -d ' ' -f2)

#Obtiene la Velocidad de Subida de la Banda Ancha

UpSpeed=$(./speedtest.py | grep 'Upload:' | cut -d ' ' -f2)

#Imprimimos las variables creadas 

echo "Porcentaje uso Cpu: $CpuTotal %"

echo "Promedio de Carga del Sistema en los ultimos 15 min: $Load "

echo "Porcentaje de uso RAM: $PorcRam %"

echo "Almacenamiento Disponible: $FreeSpace %"

echo "Velocidad de Bajada: $DownSpeed Mbits/sec"

echo "Velocidad de Subida: $UpSpeed Mbits/sec"


echo "Dato  $(curl --silent --request POST --header "X-THINGSPEAKAPIKEY: 4J6QBTGQ5RLLMH26" --data "field1=$CpuTotal&field2=$Load&field3=$PorcRam&field4=$FreeSpace&field5=$DownSpeed&field6=$UpSpeed" "http://api.thingspeak.com/update") enviado"
