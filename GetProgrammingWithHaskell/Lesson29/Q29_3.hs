nOfPeople :: [Int]
nOfPeople = [4, 5]

beersPersonDrinks :: [Int]
beersPersonDrinks = [3, 4]

beersPerPerson :: [Int]
beersPerPerson = pure (*) <*> nOfPeople <*> beersPersonDrinks

beersPresent :: [Int]
beersPresent = [4, 10]

beersToBuy :: [Int]
beersToBuy = pure (-) <*> beersPerPerson <*> beersPresent
