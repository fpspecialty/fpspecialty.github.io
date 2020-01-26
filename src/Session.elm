module Session exposing (..)

import Browser.Navigation as Nav
import Geo exposing (Geo)

type alias Session =
    { geo : Geo
    , navKey : Nav.Key
    }
