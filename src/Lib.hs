{-# LANGUAGE OverloadedLists #-}
module Lib where

import Data.SBV
import Data.SBV.List as List
import Data.SBV.List.Bounded
import Data.SBV.Control

add :: SBV Word8
add = 0

sub :: SBV Word8
sub = 1

eval :: Int -> SWord8 -> SList Word8 -> SList Word8
eval i x y = 
           ite (x .== add) (bmap i (*2) y) $
           ite (x .== sub) (bmap i (+1) y)
           y

evalProg :: SList Word8 -> SList Word8 -> Int -> Int -> SList Word8
evalProg prog y l i = 
    bfoldr l (eval i) y prog

findProgram :: Int -> IO SatResult
findProgram i = sat $ do
        prog <- free "prog"
        constrain $ List.length prog .== literal (toInteger i)
        return $
            evalProg prog [0] i 1 .== [1]
