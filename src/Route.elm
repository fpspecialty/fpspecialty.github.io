module Route exposing (..)

import Browser.Navigation as Nav
import Geo exposing (Geo)
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, oneOf)
import Utils exposing (..)


type Route
    = Projects
    | Events


defaultRoute : Route
defaultRoute =
    Events


parseUrl : Nav.Key -> Geo -> Url -> ( ( Geo, Route ), Cmd msg )
parseUrl key fallbackGeo url =
    fromUrl url
        |> Maybe.map plain
        |> Maybe.withDefault ( ( fallbackGeo, defaultRoute ), replaceUrl key fallbackGeo defaultRoute )


routeToPieces : Route -> List String
routeToPieces page =
    case page of
        Projects ->
            [ "projects" ]

        Events ->
            [ "events" ]


toUrlPath : Geo -> Route -> String
toUrlPath city page =
    "#/" ++ Geo.toPathSegment city ++ "/" ++ String.join "/" (routeToPieces page)


fromUrl : Url -> Maybe ( Geo, Route )
fromUrl url =
    Parser.parse parser url


parser : Parser (( Geo, Route ) -> a) a
parser =
    (Geo.urlParser
        </> oneOf
                [ Parser.map Projects (Parser.s "projects")
                , Parser.map Events (Parser.s "events")
                ]
    )
        |> Parser.map (\a b -> ( a, b ))


replaceUrl : Nav.Key -> Geo -> Route -> Cmd msg
replaceUrl key city route =
    Nav.pushUrl key (toUrlPath city route)
