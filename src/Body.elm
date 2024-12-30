module Body exposing (Msg(..), Model(..), init, update, view)

import Element

import Page.About
import Page.Contact
import Page.Landing
import Page.Products
import Page.Resources

type Msg
    = MsgLanding    Page.Landing.Msg
    | MsgProducts   Page.Products.Msg
    | MsgResources  Page.Resources.Msg
    | MsgAbout      Page.About.Msg
    | MsgContact    Page.Contact.Msg

type Model
    = ModelLanding   Page.Landing.Model
    | ModelProducts  Page.Products.Model
    | ModelResources Page.Resources.Model
    | ModelAbout     Page.About.Model
    | ModelContact   Page.Contact.Model

init : () -> Model
init flags = ModelLanding (Page.Landing.init flags)

update : Msg -> Model -> (Model, Cmd Msg)
update bodyMsg bodyModel =
    let
        updatePage msg model updateFn wrapMsg toBodyModel =
            let
                (newModel, cmd) = updateFn msg model
            in
                (toBodyModel newModel, Cmd.map wrapMsg cmd)
    in
    case (bodyMsg, bodyModel) of
        (MsgLanding msg, ModelLanding m) ->
            updatePage msg m Page.Landing.update MsgLanding ModelLanding

        (MsgProducts msg, ModelProducts m) ->
            updatePage msg m Page.Products.update MsgProducts ModelProducts

        (MsgResources msg, ModelResources m) ->
            updatePage msg m Page.Resources.update MsgResources ModelResources

        (MsgAbout msg, ModelAbout m) ->
            updatePage msg m Page.About.update MsgAbout ModelAbout

        (MsgContact msg, ModelContact m) ->
            updatePage msg m Page.Contact.update MsgContact ModelContact

        _ ->
            (bodyModel, Cmd.none)

view : Model -> Element.Element Msg
view model =
    let
        content = case model of
            ModelLanding m   -> Page.Landing.view m     |> Element.map MsgLanding
            ModelProducts m -> Page.Products.view m     |> Element.map MsgProducts
            ModelResources m -> Page.Resources.view m   |> Element.map MsgResources
            ModelAbout m     -> Page.About.view m       |> Element.map MsgAbout
            ModelContact m   -> Page.Contact.view m     |> Element.map MsgContact
    in
        Element.el [Element.centerY ,Element.centerX] content
