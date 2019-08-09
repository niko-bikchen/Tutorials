allFmap :: Applicative f => (a -> b) -> f a -> f b
allFmap func val = pure func <*> val
