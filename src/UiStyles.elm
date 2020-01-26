module UiStyles exposing (..)

import Colors
import Css exposing (..)
import Css.Media as Media exposing (only, orientation, portrait, screen, withMedia)


mediaSmartphonePortrait : List Style -> Style
mediaSmartphonePortrait =
    withMedia [ only screen [ Media.maxWidth (px 600), orientation portrait ] ]


regularShadow : Style
regularShadow =
    property "box-shadow" """0px -1px 1px rgba(0, 0, 0, 0.1), 
    0px 1px 1px rgba(0, 0, 0, 0.1),
    0px 2px 2px rgba(0, 0, 0, 0.1), 
    0px 3px 3px rgba(0, 0, 0, 0.1)"""


fullwidthContainer : Style
fullwidthContainer =
    batch
        [ displayFlex
        , flexDirection row
        , justifyContent center
        ]


innerContainer : Style
innerContainer =
    batch
        [ width (pct 100)
        , maxWidth (px 1000)
        , padding4 (px 48) (px 16) (px 32) (px 32)
        , mediaSmartphonePortrait [ paddingLeft (px 16), paddingRight (px 16) ]
        ]


regularText : Style
regularText =
    batch
        [ lineHeight (num 1.3)
        , marginTop (em 0.4)
        , marginBottom (em 0.4)
        ]


linkStyle : Style
linkStyle =
    batch [ marginRight (em 1), cursor pointer, userSelectNone ]


allHeaders : Style
allHeaders =
    batch
        [ fontFamilies [ "Merriweather", "serif" ]
        , fontWeight (int 400)
        , lineHeight (num 1.6)
        ]


userSelectNone : Style
userSelectNone =
    property "user-select" "none"
