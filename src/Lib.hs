module Lib
    ( findProgram
    ) where

import Data.SBV
import Data.SBV.List
import Data.SBV.Control

add :: SBV Word8
add = 0

eval :: SList Word8 -> SWord8 -> SWord8
eval x y = ite (x `elemAt` literal 0 .== add) (y + 1) y

findProgram :: IO SatResult
findProgram = sat $ \prog -> forAll_ $ \y ->
    eval prog y .== y + 1