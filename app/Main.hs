module Main where

import Lib
import Data.List
import Data.SBV
import Data.SBV.Control

main :: IO ()
main = do
    r <- findProgram 1
    print r