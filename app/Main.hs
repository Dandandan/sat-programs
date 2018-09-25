module Main where

import Lib
import Data.List
import Data.SBV
import Data.SBV.Control


synthesize :: [Int] -> IO ()
synthesize [] = error "Not found within limits"
synthesize (x:xs) = do
    r <- findProgram x
    case r of
        SatResult (Satisfiable c m) -> print r
        _ -> synthesize xs

main :: IO ()
main = do
    synthesize [1..20]