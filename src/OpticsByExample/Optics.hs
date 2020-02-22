{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE PackageImports #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}


module OpticsByExample.Optics where


import Control.Applicative
import Data.Char
import "generic-optics" Data.Generics.Product.Fields (field)
import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.Text as Text
import GHC.Generics (Generic)
import Optics
import Prelude hiding (zip)


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


ex1 :: String
ex1 = view (field @"address" % field @"country") person


ex2 :: (Char, Char, Bool)
ex2 = set _3 False ('a', 'b', 'c')


ex3 :: Int
ex3 =
  sumOf
    (folded % _2 % _Left)
    [(True, Left 10), (False, Right "pepperoni"), (True, Left 20)]


{- HLINT ignore "Unused LANGUAGE pragma" -}
