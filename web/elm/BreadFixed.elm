module BreadFixed (..) where

import StartApp
import Effects exposing (Effects, Never)
import Task exposing (Task)
import Html exposing (text, Html, p, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, name, value)
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
    , inputs = [ incomingActions ]
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
-- VIEW


toYesNo : IsFixed -> String
toYesNo isfixed =
  if isfixed then
    "Yes"
  else
    "No"


type Action
  = RequestBread Model
  | SetBread Model
  | NoOp


view : Signal.Address Action -> Model -> Html
view address model =
  button
    [ class "yes-or-no"
    , onClick address (RequestBread model) ]
    [ text (toYesNo model) ]



-- UPDATE


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    RequestBread bread ->
      ( model, sendBreadRequest bread )

    SetBread isFixed ->
      ( isFixed, Effects.none )

    NoOp ->
      ( model, Effects.none )


port fixed : Signal Model
breadRequestsBox : Signal.Mailbox IsFixed
breadRequestsBox =
  Signal.mailbox False


port breadRequests : Signal IsFixed
port breadRequests =
  breadRequestsBox.signal


port breadUpdates : Signal IsFixed
changeFixed : Signal Action
changeFixed =
  Signal.map SetBread fixed


breadsToUpdate : Signal Action
breadsToUpdate =
  Signal.map RequestBread breadUpdates


incomingActions : Signal Action
incomingActions =
  Signal.merge changeFixed breadsToUpdate



-- EFFECTS


sendBreadRequest : IsFixed -> Effects Action
sendBreadRequest bread =
  Signal.send breadRequestsBox.address bread
    |> Effects.task
    |> Effects.map (always NoOp)
