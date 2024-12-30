module Header exposing (Model, Msg(..), view, init)

import Element exposing (Element)
import Element.Events
import Element.Border

import Page.Products as Products
import Page.Resources as Resources
import Page.About as About
import Page.Contact as Contact

import Page as P

type alias Model = {}
type Msg
    = ClickedProducts
    | ClickedResources
    | ClickedAbout
    | ClickedContact

toPage : Msg -> P
toPage msg =
    case msg of
        ClickedProducts  -> P.Products     <| Products.init ()
        ClickedResources -> P.Resources    <| Resources.init ()
        ClickedAbout     -> P.About        <| About.init ()
        ClickedContact   -> P.Contact      <| Contact.init ()

init : () -> Model
init flags = {}

view : Model -> Element Msg
view model =
    let
        dropShadow = Element.Border.shadow {
            offset = ( 0, 2 ),
            size = 1,
            blur = 5,
            color = Element.rgba 0 0 0 0.15
            }
        headerButton msg string =
            Element.el
                [Element.alignRight, Element.Events.onClick <| msg]
                (Element.text string)

        products  = headerButton ClickedProducts "Products"
        resources = headerButton ClickedResources "Resources"
        about     = headerButton ClickedAbout "About"
        contact   = headerButton ClickedContact "Contact"
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
