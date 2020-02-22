{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE PackageImports #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}

{- HLINT ignore "Unused LANGUAGE pragma" -}


module OpticsByExample.Lens where


import Control.Applicative
import Control.Lens
import Data.Bits.Lens (bitAt)
import Data.Char
import Data.Data.Lens (biplate)
import "generic-lens" Data.Generics.Labels ()
import Data.List (sort)
import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.Text as Text
import GHC.Generics (Generic)
import Numeric.Lens (negated)
import Prelude hiding (zip)


--------------------------------------------------------------------------------
-- 2.4 Practical optics at a glance
--------------------------------------------------------------------------------


data Address = Address
  { street1 :: String
  , street2 :: String
  , city :: String
  , state :: String
  , zip :: String
  , country :: String
  } deriving stock (Generic, Show)


data Person = Person
  { name :: String
  , address :: Address
  } deriving stock (Generic, Show)


person :: Person
person = Person
  { name = "Tim Cook"
  , address = Address
      { street1 = "1 Infinite Loop"
      , street2 = ""
      , city = "Cupertino"
      , state = "CA"
      , zip = "95014"
      , country = "United States"
      }
  }


-- | Example 1
-- >>> ex1
-- "United States"
ex1 :: String
ex1 = view (#address . #country) person


-- | Example 2
-- >>> ex2
-- ('a','b',False)
ex2 :: (Char, Char, Bool)
ex2 = set _3 False ('a', 'b', 'c')


-- | Example 3
-- >>> ex3
-- 30
ex3 :: Int
ex3 =
  sumOf
    (folded . _2 . _Left)
    [(True, Left 10), (False, Right "pepperoni"), (True, Left 20)]


-- | Example 4
-- >>> ex4
-- ["This one t...","Nuff said.","This is a ..."]
ex4 :: [String]
ex4 =
  let
    stories =
      [ "This one time at band camp"
      , "Nuff said."
      , "This is a short story"
      ]
  in
    over
      (traversed . filtered ((> 10) . length))
      (\story -> take 10 story <> "...")
      stories


--------------------------------------------------------------------------------
-- 2.5 Impractical optics at a glance
--------------------------------------------------------------------------------


-- | Example 5
-- >>> ex5
-- 27
ex5 :: Int
ex5 = sumOf (folded . beside negated id) [Left 1, Right 10, Left 2, Right 20]


-- | Example 6
-- >>> ex6
-- "Why Is A Raven Like A Writing Desk"
ex6 :: String
ex6 = "why is a raven like a writing desk" & worded . _head %~ toUpper


-- | Example 7
-- >>> ex7
-- (Just 300,Left ("hello",[1300,1500,1700]))
ex7 :: (Maybe Int, Either (String, [Int]) ())
ex7 = (Just 3, Left ("hello", [13,15,17])) & biplate *~ (100 :: Int)


-- | Example 8
-- >>> ex8
-- [1,8,3,6,5,4,7,2]
ex8 :: [Int]
ex8 = [1 .. 8] & partsOf (traversed . filtered even) %~ reverse


-- | Example 9
-- >>> ex9
-- ("eee","hno","orttw")
ex9 :: (String, String, String)
ex9 = ("one", "two", "three") & partsOf (each . traversed) %~ sort


-- | Example 10
-- >>> ex10
-- [3,0,1,6]
ex10 :: [Int]
ex10 = [1 .. 4] & traversed . bitAt 1 %~ not


-- | Example 11
-- doctest doesn't work with getLine :-(
ex11 :: IO (String, String, String)
ex11 =
  let
    prompts =
      ( "What is your name?"
      , "What is your quest?"
      , "What is your favorite color?"
      )
  in
    prompts & each %%~ (\prompt -> putStrLn prompt >> getLine)
