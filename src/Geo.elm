module Geo exposing (..)

import Url.Parser exposing (string)
import Utils exposing (..)


type alias Geo =
    Maybe City


type City
    = Novosibirsk


toGeo : City -> Geo
toGeo =
    Just


global : Geo
global =
    Nothing


{-| The only place for hardcoding a city
-}
defaultCity : City
defaultCity =
    Novosibirsk


defaultGeo : Geo
defaultGeo =
    Just Novosibirsk


urlParser : Url.Parser.Parser (Geo -> a) a
urlParser =
    (\str ->
        case str of
            "nsk" ->
                Just (Just Novosibirsk)

            "global" ->
                Just global

            _ ->
                Nothing
    )
        |> Url.Parser.custom "CITY"


toPathSegment : Geo -> String
toPathSegment geo =
    case geo of
        Just Novosibirsk ->
            "nsk"

        Nothing ->
            "global"


show : City -> String
show city =
    case city of
        Novosibirsk ->
            "Новосибирск"


showGeo : Geo -> String
showGeo =
    Maybe.map show >> Maybe.withDefault "Все города"
