module Main exposing (main)

-- external imports
import Browser
import Url
import Html exposing (Html)
import Element exposing (Element, el, text, column)
import String exposing (right)
import Browser.Navigation
import Browser exposing (UrlRequest)
import Html exposing (header)

-- internal imports
import Body
import Header

type Msg
    = Header        Header.Msg
    | Body          Body.Msg
    | UrlChanged    Url.Url
    | UrlRequest    Browser.UrlRequest

type alias Model =
    { key : Browser.Navigation.Key
    , url : Url.Url
    , page : Body.Model
    , header : Header.Model}

init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        page = Body.init flags
        header = Header.init flags
        model =
            { key = key
            , url = url
            , page = page
            , header = header
            }
    in
        (model, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Body bodyMsg ->
            let
                (newPage, cmd) = Body.update bodyMsg model.page
            in
                ( {model | page = newPage}, cmd |> Cmd.map Body )
        UrlChanged url  ->
            ( {model | url = url}, Cmd.none )
        UrlRequest (Browser.Internal url) ->
            ( model, Browser.Navigation.pushUrl model.key (Url.toString url) )
        _ -> (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


view : Model -> Browser.Document Msg
view model =
    let
        header = Header.view model.header |> Element.map Header
        body = Body.view model.page |> Element.map Body
        page =
            Element.column
                [ Element.width Element.fill
                , Element.height Element.fill
                , Element.centerX]
                [ header
                , body]
    in
        { title = "Example Spa Elm App"
        , body  = [ Element.layout [] page ]}

main =
    Browser.application {
        init            = init
       ,view            = view
       ,update          = update
       ,subscriptions   = subscriptions
       -- when a link is clicked, first UrlRequest is issued
       ,onUrlRequest    = UrlRequest
       -- then UrlChanged is issued
       ,onUrlChange     = UrlChanged
       }
