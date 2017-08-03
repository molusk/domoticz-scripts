-- molusk - 2015
-- Ce script vérifie la consommation de la prise extérieure.
-- La vérification est effectuée une fois par minute,
-- Si la prise est allumée et sa consommation inférieure à 2W sur 5 mesures consécutives,
-- Elle sera éteinte automatiquement.

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

-- print("Conso de la prise exterieure : " .. otherdevices_svalues['Prise exterieure conso'])
-- print("Valeur de la variable : " .. uservariables["compteur_ext"])

if (otherdevices['Prise exterieure']=='On') then
        if ( tonumber(otherdevices_svalues['Prise exterieure conso']) <= 2 and  otherdevices['By-pass prise']=='Off') then
                if ( tonumber( uservariables['compteur_ext']) == 5) then
                        commandArray[0]={['Prise exterieure']='Off'}
                        print("Extinction de la prise exterieure car non utilisée")
                        commandArray[1]={['Variable:compteur_ext']='0'}
--                      print("Reinitialisation du compteur 1")
                else
                        commandArray['Variable:compteur_ext']= tostring(uservariables["compteur_ext"] +1)
                        print("Nouvelle valeur de la variable : " .. uservariables['compteur_ext'] +1)
                end
        else
                if tonumber( uservariables['compteur_ext']) > 0 then
                        commandArray['Variable:compteur_ext']='0'
--                      print("Reinitialisation du compteur 2")
                end
        end
else
        if tonumber( uservariables['compteur_ext']) > 0 then
                commandArray['Variable:compteur_ext']='0'
--              print("Reinitialisation du compteur 3")
        end
end

return commandArray
