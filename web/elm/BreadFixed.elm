module BreadFixed (..) where

import StartApp
import Effects exposing (Effects, Never)
import Task exposing (Task)
import Html exposing (text, Html, p)
import Html.Events exposing (onClick)


main : Signal Html
main =
  app.html


app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }


port tasks : Signal (Task Never ())
port tasks =
  app.tasks



-- MODEL


type alias IsFixed =
  Bool


type alias Model =
  IsFixed


init : ( Model, Effects Action )
init =
  ( False, Effects.none )



-- VIEW


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



-- UPDATE


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    Toggle state ->
      ( not model, Effects.none )
