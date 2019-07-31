cup f10z = \massage -> massage f10z

getOz aCup = aCup (\f10z -> f10z)

isEmpty aCup = (getOz aCup) == 0

drink aCup ozDrank =
  if ozDiff > 0
    then cup ozDiff
    else cup 0
  where
    f10z = getOz aCup
    ozDiff = f10z - ozDrank
