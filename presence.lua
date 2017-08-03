-- Alexandre DUBOIS - 2014
-- Ce script vérifie la présence de 2 téléphones sur le réseau pour savoir si quelqu'un est là.
-- La vérification est effectuée une fois par minute tant qu'aucun téléphone n'est à portée,
-- puis une fois toute les 10 minutes quand au moins un téléphone est connecté pour ne pas trop stresser sa batterie.

commandArray = {}

--Cette fonction calcule la différence de temps (en secondes) entre maintenant
--et la date passée en paramètre.
function timedifference (s)
  year = string.sub(s, 1, 4)
  month = string.sub(s, 6, 7)
  day = string.sub(s, 9, 10)
  hour = string.sub(s, 12, 13)
  minutes = string.sub(s, 15, 16)
  seconds = string.sub(s, 18, 19)
  t1 = os.time()
  t2 = os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds}
  difference = os.difftime (t1, t2)
  return difference
end

--Si le téléphone n'est pas détecté ou qu'il est présent depuis plus de 10 minutes (600 secondes),
--alors on vérifie à nouveau sa présence
if (otherdevices['Presence']=='Off' or (otherdevices['Presence']=='On' and timedifference(otherdevices_lastupdate['Presence']) > 600)) then
        ping_success_tel1=os.execute('ping -c1 -w1 numia')
        ping_success_tel2=os.execute('ping -c1 -w1 sphone')

        if ping_success_tel1 or ping_success_tel2 then
            commandArray['Presence']='On'
        else
          if otherdevices['Presence']=='On' then --On ne passe l'interrupteur virtuel à Off que s'il est sur On.
             commandArray['Presence']='Off'
          end
        end
end

return commandArray
