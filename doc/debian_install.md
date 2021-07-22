


https://www.debian.org/devel/debian-installer/

f12 to have a one time boot option. USB boot option appears available. UEFI: Generic usb flash disk (there is also a partition 2 entry for USB. Using the first only)

graphical install, usual
at first ethernet card not detected; 
go back and try again. wifi nonfree drivers missing, skip. 
This time eth cards detected, but there are three so need to say which one. 

bail out; need to get a proper list of hardware just in case.

usermod -a -G sftp_users per202

 but seems not to wrk as expected. Not in that froup.
systemctl restart sshd

netstat -tlnp
systemctl restart sshd


Seems to work: https://www.tecmint.com/restrict-sftp-user-home-directories-using-chroot/  

```
usermod -G sftp_users per202
nano /etc/ssh/sshd_config
systemctl restart sshd
cd /home
ls
ls -l
chmod 700 per202/
ls -l
history 
```