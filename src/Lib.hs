module Lib
    ( findProgram
    ) where

import Data.SBV

add :: SBV Word8
add = 0

eval :: SArray Word8 Word8  -> (SWord8 -> SWord8)
eval x y = ite (readArray x (literal 0) .== add) (y + 1) y

findProgram = sat $ newArray "x" Nothing >>= \x -> forAll ["y"] $ \y -> eval x y .== y + 1