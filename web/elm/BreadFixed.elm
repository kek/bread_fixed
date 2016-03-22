module BreadFixed (..) where

import StartApp
import Effects exposing (Effects, Never)
import Task exposing (Task)
import Html exposing (text, Html, p)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Json exposing ((:=))


main : Signal Html
main =
  app.html


app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = [incomingActions]
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



-- EFFECTS


fetchBread : Effects Action
fetchBread =
  Http.get decodeBread "http://localhost:4000/api/bread/1"
    |> Task.toMaybe
    |> Task.map SetBread
    |> Effects.task


decodeBread : Json.Decoder Model
decodeBread =
  Json.at [ "data", "fixed" ] Json.bool



-- VIEW


toYesNo : IsFixed -> String
toYesNo isfixed =
  if isfixed then
    "Yes"
  else
    "No"


type Action
  = Toggle Model
  | SetBread (Maybe Model)


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

    SetBread bread ->
      (bread, Effects.none)
      -- let
      --   newModel =
      --     Maybe.withDefault model bread
      -- in
      --   ( newModel, Effects.none )



-- SIGNALS


port fixed : Signal Model

incomingActions: Signal Action
incomingActions =
  Signal.map SetBread fixed
