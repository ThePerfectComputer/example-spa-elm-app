module Main exposing (main)

import Browser
import Url
import Html exposing (Html)
import Element exposing (Element, el, text, column)
import String exposing (right)
import Browser.Navigation

import Page.Landing
import Header
import Html exposing (header)


-- MODEL
type Page
    = Landing Page.Landing.Model
    | Products
    | Resources
    | About
    | Contact

type alias Model =
    { key : Browser.Navigation.Key
    , url : Url.Url
    , page : Page
    , header : Header.Model}

init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        page = Landing (Page.Landing.init flags)
        header = Header.init flags
        model =
            { key = key
            , url = url
            , page = page
            , header = header
            }
    in
        (model, Cmd.none)

toPage : Header.Msg -> Page
toPage msg =
    case msg of
        Header.ClickedProducts -> Products
        Header.ClickedResources -> Resources
        Header.ClickedAbout -> About
        Header.ClickedContact -> Contact

-- TODO : move this function to Router.elm
toUrl : Url.Url -> Header.Msg -> Url.Url
toUrl baseUrl msg =
    case msg of
        Header.ClickedProducts -> {baseUrl | path = "/products"}
        Header.ClickedResources -> {baseUrl | path = "/resources"}
        Header.ClickedAbout -> {baseUrl | path = "/about"}
        Header.ClickedContact -> {baseUrl | path = "/contact"}

-- UPDATE
type Msg
    = NoOp
    | Header Header.Msg
    | LandingPage Page.Landing.Msg
    | UrlChanged Url.Url
    | UrlRequest Browser.UrlRequest


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Header headerMsg ->
            let
                newUrl = toUrl model.url headerMsg
                newModel = { model | page = toPage headerMsg }
            in
                (newModel, Browser.Navigation.pushUrl model.key (Url.toString newUrl))
        UrlChanged url ->
                (model, Browser.Navigation.pushUrl model.key (Url.toString url))
        _ -> (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

viewBody : Model -> Element.Element Msg
viewBody model =
    let
        content = case model.page of
            Landing m -> Page.Landing.view m |> Element.map LandingPage
            Products -> Element.text "Products"
            Resources -> Element.text "Resources"
            About -> Element.text "About"
            Contact -> Element.text "Contact"
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
       ,onUrlRequest = UrlRequest
       }
