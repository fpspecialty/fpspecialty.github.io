module Event exposing (..)

import Css exposing (..)
import Geo exposing (City, Geo)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (alt, css, href, src)
import Ordering exposing (Ordering)
import Typography exposing (text__)
import UiElements exposing (..)
import UiStyles exposing (..)
import Utils exposing (..)


type Event
    = Event
        { id : Int
        , shortDescription : String
        , title : String
        , registrationUrl : String
        , cover : Maybe String
        , level : Level
        , isOpen : Bool
        , location : EventLocation
        }


defaultCover : String
defaultCover =
    "default_cover.webp"


type Level
    = Level1
    | Level2
    | Level3
    | Level4
    | Level5


type EventLocation
    = Online String
    | Offline City TimeAndPlace
    | UnknownOnline
    | UnknownOffline City


type alias TimeAndPlace =
    { time : Int, place : String }


isOpen : Event -> Bool
isOpen (Event e) =
    e.isOpen


{-| TODO: order by tymestamp. All others are filters.
-}
eventOrdering : Ordering Event
eventOrdering =
    Ordering.byField (\(Event { id }) -> id)
        |> Ordering.reverse
