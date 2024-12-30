module Header exposing (Model, Msg, view, init, update)
import Element exposing (Element)
import Element.Events
import Element.Border

type alias Model = {}
type alias Msg = {}

init : () -> Model
init flags = {}

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

view : Model -> Element Msg
view model =
    let
        dropShadow = Element.Border.shadow {
            offset = ( 0, 2 ),
            size = 1,
            blur = 5,
            color = Element.rgba 0 0 0 0.15
            }
        headerButton string =
            Element.link
                [Element.alignRight]
                { url = "/" ++ string
                , label = Element.text string
                }

        products  = headerButton "Products"
        resources = headerButton "Resources"
        about     = headerButton "About"
        contact   = headerButton "Contact"
    in
    Element.row [Element.width Element.fill,
                 Element.spacing 15,
                 Element.paddingXY 30 25,
                 dropShadow]
                [ Element.el [Element.alignLeft] (Element.text "Elm Example App")
                , products
                , resources
                , about
                , contact
                ]
