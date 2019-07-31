type FirstName = String

type LastName = String

type MiddleName = String

data Name
  = Name FirstName LastName
  | NameWithMiddleName FirstName MiddleName LastName
  | TwoInitialsWithLastName Char Char LastName
  | FirstNameWithTwoInitials FirstName Char Char

data Author =
  Author Name

data Artist
  = Person Name
  | Band String

data Creator
  = AuthorCreator Author
  | ArtistCreator Artist

data Book =
  Book
    { author :: Creator
    , isbn :: String
    , bookTitle :: String
    , bookYear :: Int
    , bookPrice :: Double
    }

data VinylRecord =
  VinylRecord
    { artist :: Creator
    , recordTitle :: String
    , recordYear :: Int
    , recordPrice :: Double
    }

data CollectibleToy =
  CollectibleToy
    { name :: String
    , description :: String
    , toyPrice :: Double
    }

data StoreItem
  = BookItem Book
  | RecordItem VinylRecord
  | ToyItem CollectibleToy

price :: StoreItem -> Double
price (BookItem book) = bookPrice book
price (VinylRecord record) = recordPrice record
price (ToyItem toy) = toyPrice toy
