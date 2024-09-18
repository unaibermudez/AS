## Laboratorio 2

1) En el disco recién creado, crear 4 particiones de 1GB cada una y formatearlas: una de ellas será ext3, otra
btrfs, otra xfs y última ext4.
```sh
# Listar los discos
$ lsblk -e7
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda       8:0    0   20G  0 disk 
├─sda1    8:1    0   19G  0 part /
├─sda14   8:14   0    4M  0 part 
├─sda15   8:15   0  106M  0 part /boot/efi
└─sda16 259:0    0  913M  0 part /boot
sdb       8:16   0   10G  0 disk 

# Configuramos el disco sdb
$ sudo cfdisk /dev/sdb

# Ahora tenemos 4 particiones de 1G cada una
$ lsblk -e7
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda       8:0    0   20G  0 disk 
├─sda1    8:1    0   19G  0 part /
├─sda14   8:14   0    4M  0 part 
├─sda15   8:15   0  106M  0 part /boot/efi
└─sda16 259:0    0  913M  0 part /boot
sdb       8:16   0   10G  0 disk 
├─sdb1    8:17   0    1G  0 part 
├─sdb2    8:18   0    1G  0 part 
├─sdb3    8:19   0    1G  0 part 
└─sdb4    8:20   0    1G  0 part 

# Formatemos cada disco con la extension que nos pide
$ sudo mkfs.ext3 /dev/sdb1
$ sudo mkfs.btrfs /dev/sdb2
$ sudo mkfs.xfs /dev/sdb3
$ sudo mkfs.ext4 /dev/sdb4

```

2) Configurar un montaje automático de las particiones (al arranque de la máquina virtual) en /disco[X] donde
X es 1, 2, 3, 4. Se recomienda seguir estos¹ pasos. Verificar que los montajes se mantienen al reiniciar la
máquina.
En caso de que la MV no arranque o no permita acceso vía SSH por problemas de configuración, se puede
iniciar una terminal mínima llamada “consola serie” que provee acceso root para resolver incidencias².

¹ Montaje automático de discos en máquinas virtuales, Compute Engine: https://cloud.google.com/compute/docs/disks/add-persistentdisk?hl=es-419#configuring_automatic_mounting_on_vm_restart 

² Solución de problemas con la consola serie de GCP: https://cloud.google.com/compute/docs/troubleshooting/troubleshooting-usingserial-console

```sh
$ sudo mkdir /disco1 /disco2 /disco3 /disco4

# obtener las UID de las particiones
$ sudo blkid

# editamos /etc/fstab
$ sudo vim /etc/fstab

# añadimos los UIDs obtenidos
UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx /disco1 ext3 defaults 0 2
UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx /disco2 btrfs defaults 0 2
UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx /disco3 xfs defaults 0 2
UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx /disco4 ext4 defaults 0 2

# montamos las particiones
$ sudo mount -a

# comprobamos
$ df -h 
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        19G  2.0G   17G  11% /
tmpfs           983M     0  983M   0% /dev/shm
tmpfs           394M 1008K  393M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
efivarfs         56K   24K   27K  48% /sys/firmware/efi/efivars
/dev/sda16      881M   61M  759M   8% /boot
/dev/sda15      105M  6.1M   99M   6% /boot/efi
tmpfs           197M   12K  197M   1% /run/user/1001
/dev/sdb1       975M   60K  924M   1% /disco1
/dev/sdb2       1.0G  5.8M  905M   1% /disco2
/dev/sdb3       960M   51M  910M   6% /disco3
/dev/sdb4       974M   24K  907M   1% /disco4

```
3) ¿Cuál de los sistemas de ficheros creados ocupa más espacio? 

En el comando anterios podemos ver que el sistema de ficheros que mas espacio ocupa (columna `Used`) es el que hemos utilizdo en /deb/sdb3 : `xfs`

4) ¿Es posible acceder a una partición ext3 que ha sido montada como ext4? ¿Y al revés? ¿Por qué?

ChatGPT dice:
- **Montar ext3 como ext4:** Sí, es posible, ya que ext4 es compatible hacia atrás.
- **Montar ext4 como ext3:** No, no es recomendable, ya que ext3 no puede manejar las mejoras estructurales de ext4 y puede provocar problemas de datos.


5) Desmontar y borrar las 3 últimas particiones. Crear una única partición ext4 de 8 GB.

```sh
$ sudo umount /disco4
$ sudo umount /disco3
$ sudo umount /disco2

```

6) Copiar el contenido del directorio /var en la nueva partición ext4 que acabas de crear. Después,
redimensionar la partición para que sea lo más pequeña posible.

```sh
# montamos la particion (si no lo esta ya)
$ sudo mount /dev/sdb1 /disco1

# copiamos los datos
$ sudo rsync -aAXv /var/ /disco1/

## Para redimensionar la particion

# desmontamos el disco
$ sudo umount /disco1

# Verificar y redimensionar
$ sudo e2fsck -f /dev/sdb1
$ sudo resize2fs -M /dev/sdb1


```