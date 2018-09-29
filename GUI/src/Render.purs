module Render where

import Prelude

import Data.Array ((!!))
import Data.Function.Uncurried (Fn1, Fn5, mkFn1, mkFn5)
import Data.Maybe (fromMaybe)
import Math as Math

type Text
  = { height :: Number
    , width :: Number
    }

calcFontPoint :: Fn5 (Array Number) Text Number Number Number (Array Number)
calcFontPoint = mkFn5 \linepoint text offsetx offsety tilt ->
  fromMaybe linepoint do
    linepoint0 <- linepoint !! 0
    linepoint1 <- linepoint !! 1
    let point0 = linepoint0 * text.width + offsetx
        point1 = linepoint1 * text.height + offsety
    pure
      -- Adding half a line height here is technically a bug
      -- but pcbnew currently does the same, text is slightly shifted.
      [ point0 - (point1 + text.height * 0.5) * tilt
      , point1
      ]

deg2rad :: Fn1 Number Number
deg2rad = mkFn1 \deg ->
  deg * Math.pi / 180.0
