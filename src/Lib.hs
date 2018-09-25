{-# LANGUAGE OverloadedLists #-}
module Lib
    ( findProgram
    ) where

import Data.SBV
import Data.SBV.List as List
import Data.SBV.List.Bounded

add :: SBV Word8
add = 0

sub :: SBV Word8
sub = 1

eval :: SWord8 -> SWord8 -> SWord8
eval x y = 
           iteLazy (x .== add) (y + 1) $
           iteLazy (x .== sub) (y - 1)
            y

maxLength = 10

evalProg :: SList Word8 -> SWord8 -> Int -> SWord8
evalProg prog y l = 
    bfoldr l eval y prog

findProgram :: Int -> IO SatResult
findProgram i = sat $ \prog -> forAll_ $ \y ->
        evalProg prog y i .== y + 1
        &&& List.length prog .== literal (toInteger i)