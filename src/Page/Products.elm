module Page.Products exposing (Model, Msg, view, init, update)
import Element exposing (Element)

type alias Model = {}
type alias Msg = {}

init : () -> Model
init flags = {}

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

view : Model -> Element Msg
view model =
    Element.el []
        <| Element.text "Products"
