# domoticz-scripts

Un backup de mes quelques scripts LUA et Shell pour domoticz

# Domoticz, Raspbian et Systemd
## Accès aux ports série
Ajouter l'utilisateur dans le groupe dialout

`sudo usermod -aG dialout pi`

(reboot nécessaire pour prise en compte)

## Déactiver le service init.d si existant
```
sudo update-rc.d domoticz remove
sudo mv /etc/init.d/domoticz ~
```

## Donner les droits à domoticzz d'utiliser les pors non-privilégiés
`sudo setcap CAP_NET_BIND_SERVICE=+eip /home/pi/domoticz/domoticz`

## Créer l'unité Systemd
`sudo vi /lib/systemd/system/domoticz.service`

(fichier dispo dans le dossier systemd de ce dépôt)

```
sudo systemctl enable domoticz
sudo systemctl start domoticz
```
