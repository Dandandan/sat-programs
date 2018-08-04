module Main where

import Lib

main :: IO ()
main = do
    r <- findProgram
    print r 
