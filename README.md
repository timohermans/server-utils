# Readme for stuff

## OpenVPN

[Resource used](https://raspberrytips.nl/pivpn-de-eenvoudige-manier-om-openvpn-te-installeren/)

- sudo -i
- curl -L http://install.pivpn.io | bash
- port 51820



## Securing Pi

[Resource used](https://www.raspberrypi.org/documentation/configuration/security.md)

enabling firewall 

- `sudo apt install ufw`
- `ufw enable`
- `ufw allow <port>`
- `ufw deny <port>`

ban users for login attempts

- sudo apt install fail2ban
- creates folder /etc/fail2ban
- sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
- sudo vim /etc/fail2ban/jail.local

```bash
[ssh]
enabled  = true
port     = ssh
filter   = sshd
logpath  = /var/log/auth.log
maxretry = 6
bantime  = -1
```

## Backing up whole raspberry pi onto USB drive

[Resource used](https://www.megaleecher.net/best_raspberry_pi_hot_backup_shell_script)

- See the [backup script](./backup-script.sh) in this repository
- Check if the directory and the subdirectory are correct

## Back up every week

[Cronjob generator](https://crontab.guru/#0_2_*_*_1)

- `sudo crontab -e`
- every week on Monday 02:00 -> `0 2 * * 1 <path-to-repo>/backup-script.sh`

## Restoring a backed up image to SD Card

- Install [Etcher](https://www.balena.io/etcher/) if not done so already
- Use the tool to flash backup on SD card

## Mounting the USB drive with backups

[Resource used](https://www.raspberrypi-spy.co.uk/2014/05/how-to-mount-a-usb-flash-disk-on-the-raspberry-pi/)

1. Plugin
2. ls -l /dev/disk/by-uuid/ -> remember the UUID of /dev/sda1 for 6
3. sudo mkdir /media/usb (already done, no need to do this again)
4. sudo chown -R pi:pi /media/usb (already done, no need to do this again)
5. sudo mount /dev/sda1 /media/usb -o uid=pi,gid=pi (already done, no need to do this again)
6. to auto mount on reboot -> sudo vim /etc/fstab -> UUID=<uuid from 2>/media/usb ntfs-3g auto,nofail,noatime,users,rw,uid=pi,gid=pi 0 0
6b. note that ntfs-3g for ntfs file system, vfat for fat32
