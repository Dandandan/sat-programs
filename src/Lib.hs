module Lib
    ( findProgram
    ) where

import Data.SBV

eval :: SWord8 -> (SWord8 -> SWord8)
eval x y = ite (x .== 0) y (y + 1)

findProgram :: IO SatResult
findProgram = sat $ \x -> forAll_ $ \y -> (inter x) y .== y + 1