module BreadFixed (..) where

import StartApp.Simple
import Html exposing (text, Html, p)
import Html.Events exposing (onClick)


main : Signal Html
main =
  StartApp.Simple.start
    { model = init
    , update = update
    , view = view
    }


type alias IsFixed =
  Bool


type alias Model =
  IsFixed


init : Model
init =
  False


toYesNo : IsFixed -> String
toYesNo isfixed =
  if isfixed then
    "Yes"
  else
    "No"


type Action
  = Toggle Model


view : Signal.Address Action -> Model -> Html
view address model =
  p
    [ onClick address (Toggle model) ]
    [ text (toYesNo model) ]


update : Action -> Model -> Model
update action model =
  case model of
    True ->
      False

    False ->
      True
