module Main where

import Lib
import Data.List
import Data.SBV
import Data.SBV.Control


synthesize :: [Int] -> IO ()
synthesize [] = error "Not found within limits"
synthesize (x:xs) = do
    print x
    r <- findProgram x
    case r of
        SatResult (Satisfiable c m) -> do
            print r
        x -> do
            print x
            synthesize xs

main :: IO ()
main = do
    synthesize [1..20]