type PatientsName = (String, String)

type Age = Int

type Height = Int

type MiddleName = String

type FirstName = String

type LastName = String

data Sex
  = Male
  | Female

data RhType
  = Pos
  | Neg

data ABOType
  = A
  | B
  | AB
  | O

data BloodType =
  BloodType ABOType RhType

data Name
  = Name FirstName LastName
  | NameWithMiddle FirstName MiddleName LastName

data Patient =
  Patient
    { name :: Name
    , sex :: Sex
    , age :: Age
    , height :: Height
    , weight :: Int
    , bloodType :: BloodType
    }

patientInfo :: PatientsName -> Age -> Height -> String
patientInfo (fname, lname) age height = name ++ " " ++ ageHeight
  where
    name = lname ++ ", " ++ fname
    ageHeight = "(" ++ show age ++ "yrs. " ++ show height ++ "in.)"

firstName :: PatientsName -> String
firstName patient = fst patient

lastName :: PatientsName -> String
lastName patient = snd patient

sexInitial :: Sex -> Char
sexInitial Male = 'M'
sexInitial Female = 'F'

showRh :: RhType -> String
showRh Pos = "+"
showRh Neg = "-"

showABO :: ABOType -> String
showABO A = "A"
showABO B = "B"
showABO AB = "AB"
showABO O = "O"

showBloodtype :: BloodType -> String
showBloodtype (BloodType abo rh) = showABO abo ++ showRh rh

showName :: Name -> String
showName (Name first last) = first ++ " " ++ last
showName (NameWithMiddle first middle last) =
  first ++ " " ++ middle ++ " " ++ last


canDonateTo :: BloodType -> BloodType -> Bool
canDonateTo (BloodType O _) _ = True
canDonateTo _ (BloodType AB _) = True
canDonateTo (BloodType A _) (BloodType A _) = True
canDonateTo (BloodType B _) (BloodType B _) = True
canDonateTo _ _ = False

canDonateToV2 :: Patient -> Patient -> Bool
canDonateToV2 (Patient _ _ _ _ _ (BloodType O _)) _ = True
canDonateToV2 _ (Patient _ _ _ _ _ (BloodType AB _)) = True
canDonateToV2 (Patient _ _ _ _ _ (BloodType A _)) (Patient _ _ _ _ _ (BloodType A _)) =
  True
canDonateToV2 (Patient _ _ _ _ _ (BloodType B _)) (Patient _ _ _ _ _ (BloodType B _)) =
  True
canDonateToV2 _ _ = False

-- Need to add helper show functions
patientSummary :: Patient -> String
patientSummary patient =
  "**************" ++
  "\n" "Patient Name: " ++
  showName (name patient) ++
  "\n" ++
  "Sex: " ++
  (sex patient) ++
  "\n" ++
  "Age: " ++
  (age patient) ++
  "\n" ++
  "Height: " ++
  (height patient) ++
  "\n" ++
  "Weight: " ++
  (weight patient) ++
  "\n" ++
  "Blood Type: " ++
  showBloodtype (bloodType patient) ++ "\n" ++ "**************"

jackieSmith :: Patient
jackieSmith =
  Patient
    { name = Name "Jackie" "Smith"
    , age = 43
    , sex = Female
    , height = 62
    , weight = 115
    , bloodType = BloodType O Neg
    }

kekSmith :: Patient
kekSmith =
  Patient
    { name = Name "Kek" "Smith"
    , age = 43
    , sex = Male
    , height = 62
    , weight = 115
    , bloodType = BloodType O Neg
    }
