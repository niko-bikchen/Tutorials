data FourLetterAlphabet
  = L1
  | L2
  | L3
  | L4
  deriving (Show, Enum, Bounded)

data ThreeLetterAlphabet
  = Alpha
  | Beta
  | Kappa
  deriving (Show, Enum, Bounded)

rotN :: (Bounded a, Enum a) => Int -> a -> a
rotN alphabetSize c = toEnum rotation
  where
    halfAlphabet = alphabetSize `div` 2
    offset = fromEnum c + halfAlphabet
    rotation = offset `mod` alphabetSize

rotNDecoder :: (Bounded a, Enum a) => Int -> a -> a
rotNDecoder alphabetSize c = toEnum rotation
  where
    halfN = alphabetSize `div` 2
    offset =
      if even alphabetSize
        then fromEnum c + halfN
        else 1 + fromEnum c + halfN
    rotation = offset `mod` alphabetSize

rotEncoder :: String -> String
rotEncoder text = map rotate text
  where
    alphabetSize = 1 + fromEnum (maxBound :: Char)
    rotate = rotN alphabetSize

rotDecoder :: String -> String
rotDecoder text = map rotate text
  where
    alphabetSize = 1 + fromEnum (maxBound :: Char)
    rotate = rotNDecoder alphabetSize

rotChar :: Char -> Char
rotChar charToEncrypt = rotN sizeOfAlphabet charToEncrypt
  where
    sizeOfAlphabet = 1 + fromEnum (maxBound :: Char)

fourLetterEncoder :: [FourLetterAlphabet] -> [FourLetterAlphabet]
fourLetterEncoder vals = map rot4 vals
  where
    alphabetSize = 1 + fromEnum (maxBound :: FourLetterAlphabet)
    rot4 = rotN alphabetSize

threeLetterEncoder :: [ThreeLetterAlphabet] -> [ThreeLetterAlphabet]
threeLetterEncoder vals = map rot3l vals
  where
    alphaSize = 1 + fromEnum (maxBound :: ThreeLetterAlphabet)
    rot3l = rotN alphaSize

threeLetterDecoder :: [ThreeLetterAlphabet] -> [ThreeLetterAlphabet]
threeLetterDecoder vals = map rot3ldecoder vals
  where
    alphaSize = 1 + fromEnum (maxBound :: ThreeLetterAlphabet)
    rot3ldecoder = rotNDecoder alphaSize
