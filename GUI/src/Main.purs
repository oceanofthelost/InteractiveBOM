module Main where

import Prelude

import Data.Foldable (traverse_)
import Data.Newtype (wrap)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, mkEffectFn2, runEffectFn1)
import Web.DOM (Element, NonElementParentNode)
import Web.DOM.Element (toEventTarget)
import Web.DOM.NonElementParentNode (getElementById)
import Web.Event.Event (Event)
import Web.Event.EventTarget (addEventListener, eventListener)
import Web.HTML as Web.HTML
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window as Web.HTML.Window

main :: EffectFn2 HtmlFunctions IBOM Unit
main = mkEffectFn2 \htmlFunctions ibom -> do
  htmlFunctions.init

  document <- getDocument

  flButton <- document # getElementById "fl-btn"
  flButton # (traverse_ <<< onClick) \_ ->
    runEffectFn1 ibom.changeCanvasLayout "F"

  fbButton <- document # getElementById "fb-btn"
  fbButton # (traverse_ <<< onClick) \_ ->
    runEffectFn1 ibom.changeCanvasLayout "FB"

  blButton <- document # getElementById "bl-btn"
  blButton # (traverse_ <<< onClick) \_ ->
    runEffectFn1 ibom.changeCanvasLayout "B"

  bomButton <- document # getElementById "bom-btn"
  bomButton # (traverse_ <<< onClick) \_ ->
    runEffectFn1 ibom.changeBomLayout "BOM"

  lrButton <- document # getElementById "lr-btn"
  lrButton # (traverse_ <<< onClick) \_ ->
    runEffectFn1 ibom.changeBomLayout "LR"

  tbButton <- document # getElementById "tb-btn"
  tbButton # (traverse_ <<< onClick) \_ ->
    runEffectFn1 ibom.changeBomLayout "TB"

getDocument :: Effect NonElementParentNode
getDocument = do
  window <- Web.HTML.window
  document' <- Web.HTML.Window.document window
  pure (toNonElementParentNode document')

onClick :: (Event -> Effect Unit) -> Element -> Effect Unit
onClick listener' element = do
  listener <- eventListener listener'
  addEventListener (wrap "click") listener false (toEventTarget element)

type HtmlFunctions
  = { init :: Effect Unit
    }

type IBOM
  = { changeBomLayout :: EffectFn1 String Unit
    , changeCanvasLayout :: EffectFn1 String Unit
    }
