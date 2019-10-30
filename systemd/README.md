# Domoticz, Raspbian and Systemd
## Serial ports and GPIO access
Add the user in dialout and gpio groups

`sudo usermod -aG dialout gpio pi`

(then reboot)

## Deactivate existing init.d service
```
sudo update-rc.d domoticz remove
sudo mv /etc/init.d/domoticz ~
```

## Create Systemd unit
`sudo vi /lib/systemd/system/domoticz.service`

(file available above)

```
sudo systemctl enable domoticz
sudo systemctl start domoticz
```
