module Router exposing (..)

import Url

import Header

toUrl : Url.Url -> Header.Msg -> Url.Url
toUrl baseUrl msg =
    case msg of
        Header.ClickedProducts  -> {baseUrl | path = "/products"}
        Header.ClickedResources -> {baseUrl | path = "/resources"}
        Header.ClickedAbout     -> {baseUrl | path = "/about"}
        Header.ClickedContact   -> {baseUrl | path = "/contact"}

