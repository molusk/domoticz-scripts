commandArray = {}
if (devicechanged['Fermeture_chambre'] == 'On' ) then
    print('Fermeture du volet de la chambre en position intermediaire')
    commandArray[0]={['OpenURL']="http://pi2r/json.htm?type=command&param=switchlight&idx=14&switchcmd=Stop"}
end
return commandArray
