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

t2 :: SBV Word8
t2 = 2

d2 :: SBV Word8
d2 = 3

eval :: SWord8 -> SWord8 -> SWord8
eval x y = 
           ite (x .== add) (y + 1) $
           ite (x .== sub) (y - 1) $
           ite (x .== t2) (y * 2) $
           ite (x .== d2) (y `sDiv` 2) $
           y

evalProg :: SList Word8 -> SWord8 -> Int -> SWord8
evalProg prog x len =
    bfoldr len eval x prog

findProgram :: Int -> IO SatResult
findProgram len = sat $ do
        prog <- free "prog"
        constrain $ List.length prog .== literal (toInteger len)
        
        return $
            map (\x -> evalProg prog x len) [-1, 0, 1] .== [-15, 1, 17]
