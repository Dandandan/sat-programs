module Lib
    ( someFunc
    ) where

import Data.SBV

someFunc :: IO ThmResult
someFunc = prove $ \x -> x `shiftL` 2 .== 2 * (x :: SWord8)