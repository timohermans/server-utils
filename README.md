# Readme for stuff

At the time of this commit, I've changed to ubuntu server 20.04. Most of the stuff still applies I guess

## Getting output from container to host (the easy way)

So just use `docker exec` for doing this stuff. See the example for a database dump:

```bash
docker exec postgres-db pg_dump > backup.bak
```

The above code snippet will actually put the output in `backup.bak` on the **host** machine.

You can do this for everything, from backing up to just `cat`ting something

## Set Static IP (or fix ethernet controller)

[Resource used](https://www.osradar.com/set-a-static-ip-address-ubuntu-20-04/)

- cd /etc/netplan
- (only once) sudo cp 00-installer-config.yaml 00-installer-config.yaml.bak
- change accordingly

```yaml
network:
  ethernets:
    eno1:
      dhcp4: no
      addresses:s
        - 192.168.178.101/16
      gateway4: 192.168.178.1
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
  version: 2
```

- sudo netplan apply

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

## Change shell of new user to bash

chsh -s /bin/bash