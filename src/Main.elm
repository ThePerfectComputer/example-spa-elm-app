module Main exposing (main)

import Browser
import Url
import Html exposing (Html)
import Element exposing (Element, el, text, column)
import String exposing (right)
import Browser.Navigation
-- import Html exposing (header)

import Page.Landing
import Page.Products
import Page.Resources
import Page.About
import Page.Contact
import Router
import Header


-- MODEL
type alias Model =
    { key : Browser.Navigation.Key
    , url : Url.Url
    , page : Router.Page
    , header : Header.Model}

init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        page = Router.Landing (Page.Landing.init flags)
        header = Header.init flags
        model =
            { key = key
            , url = url
            , page = page
            , header = header
            }
    in
        (model, Cmd.none)

-- UPDATE
type Msg
    = NoOp
    | Header Header.Msg
    -- TODO : Fix
    | LandingPage Page.Landing.Msg
    | UrlChanged Url.Url
    | LinkedClicked Browser.UrlRequest


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Header headerMsg ->
            let
                newUrl = Router.toUrl model.url headerMsg
                newModel = { model | page = Router.toPage headerMsg }
            in
                (newModel, Browser.Navigation.pushUrl model.key (Url.toString newUrl))
        _ -> (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

viewBody : Model -> Element.Element Msg
viewBody model =
    let
        content = case model.page of
            Router.Landing m -> Page.Landing.view m |> Element.map LandingPage
            Router.Products m -> Page.Products.view m |> Element.map LandingPage
            Router.Resources m -> Page.Resources.view m |> Element.map LandingPage
            Router.About m -> Page.About.view m |> Element.map LandingPage
            Router.Contact m -> Page.Contact.view m |> Element.map LandingPage
    in
        Element.el [Element.centerY ,Element.centerX] content

-- VIEW

view : Model -> Browser.Document Msg
view model =
    let
        page =
            Element.column
                [ Element.width Element.fill
                , Element.height Element.fill
                , Element.centerX]
                [ Header.view model.header |> Element.map Header
                , viewBody model]
    in
        { title = "Example Spa Elm App"
        , body  = [ Element.layout [] page ]}

-- MAIN

main =
    Browser.application {
        init   = init
       ,view   = view
       ,update = update
       ,subscriptions = subscriptions
       ,onUrlChange = UrlChanged
       ,onUrlRequest = LinkedClicked
       }
