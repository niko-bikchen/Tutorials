robot (name, attack, hp) = (\massage -> massage (name, attack, hp))

name (name, _, _) = name

attack (_, attack, _) = attack

hp (_, _, hp) = hp

getName aRobot = aRobot name

getAttack aRobot = aRobot attack

getHP aRobot = aRobot hp

setName aRobot newName =
  aRobot (\(name, attack, hp) -> robot (newName, attack, hp))

setAttack aRobot newAttack =
  aRobot (\(name, attack, hp) -> robot (name, newAttack, hp))

setHP aRobot newHP = aRobot (\(name, attack, hp) -> robot (name, attack, newHP))

printRobot aRobot =
  aRobot (\(n, a, h) -> n ++ " attack:" ++ (show a) ++ " hp:" ++ (show h))

damage aRobot attackDamage =
  aRobot (\(n, a, h) -> robot (n, a, h - attackDamage))

fight aRobot defender = damage defender attack
  where
    attack =
      if getHP aRobot > 10
        then getAttack aRobot
        else 0

getLifeOfRobots listOfRobots = map getHP listOfRobots

threeRoundFight robotA robotB =
  (\robotA robotB ->
     (\robotA robotB ->
        (\robotA robotB ->
           (\robotA robotB ->
              (\robotA robotB ->
                 (\robotA robotB ->
                    (\robotA robotB -> robotA : robotB : [])
                      (fight robotB robotA)
                      robotB)
                   robotA
                   (fight robotA robotB))
                (fight robotB robotA)
                robotB)
             robotA
             (fight robotA robotB))
          (fight robotB robotA)
          robotB)
       robotA
       (fight robotA robotB))
    robotA
    robotB

readyThreeAndFightX robotA robotB robotC robotD =
  (\robotD ->
     map (\robotX -> fight robotD robotX) (robotA : robotB : robotC : []))
