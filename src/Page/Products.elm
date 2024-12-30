module Page.Products exposing (Model, Msg, view, init)
import Element exposing (Element)

type alias Model = {}
type alias Msg = {}

init : () -> Model
init flags = {}

view : Model -> Element Msg
view model =
    Element.el []
        <| Element.text "Products"
