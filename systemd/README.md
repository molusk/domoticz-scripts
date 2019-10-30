# Domoticz, Raspbian et Systemd
## Accès aux ports série et gpio
Ajouter l'utilisateur dans les groupes dialout et gpio

`sudo usermod -aG dialout gpio pi`

(reboot nécessaire pour prise en compte)

## Déactiver le service init.d si existant
```
sudo update-rc.d domoticz remove
sudo mv /etc/init.d/domoticz ~
```

## ~~Donner les droits à domoticz d'utiliser les pors non-privilégiés~~
~~`sudo setcap CAP_NET_BIND_SERVICE=+eip /home/pi/domoticz/domoticz`~~

## Créer l'unité Systemd
`sudo vi /lib/systemd/system/domoticz.service`

(fichier dispo dans le dossier systemd de ce dépôt)

```
sudo systemctl enable domoticz
sudo systemctl start domoticz
```
