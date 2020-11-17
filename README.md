# Readme for stuff

## Mounting the USB drive with backups

[Resource used](https://www.raspberrypi-spy.co.uk/2014/05/how-to-mount-a-usb-flash-disk-on-the-raspberry-pi/)

1. Plugin
2. ls -l /dev/disk/by-uuid/ -> remember the UUID of /dev/sda1 for 6
3. sudo mkdir /media/usb (already done, no need to do this again)
4. sudo chown -R pi:pi /media/usb (already done, no need to do this again)
5. sudo mount /dev/sda1 /media/usb -o uid=pi,gid=pi (already done, no need to do this again)
6. to auto mount on reboot -> sudo vim /etc/fstab -> UUID=<uuid from 2>/media/usb ntfs-3g auto,nofail,noatime,users,rw,uid=pi,gid=pi 0 0
6b. note that ntfs-3g for ntfs file system, vfat for fat32
