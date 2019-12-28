{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}
{- HLINT ignore "Unused LANGUAGE pragma" -}

module Main where

import Control.Applicative
import Control.Lens
import Data.Char
import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.Text as Text

main :: IO ()
main = putStrLn "Hello world"
