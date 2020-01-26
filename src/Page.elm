module Page exposing (..)

import Browser
import Colors
import Css exposing (..)
import Css.Global exposing (global, selector)
import Dataset.Contacts as Contacts
import Geo exposing (City(..), Geo)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href)
import Route exposing (Route)
import Typography exposing (text__)
import UiElements exposing (..)
import UiStyles exposing (..)
import Utils exposing (..)


{-| Same thing as route,
but not parametrized with anything.
(this remains true until routes became complex)
Idea is to use it for navbar.
-}
type Page
    = Projects
    | Events


toRoute : Page -> Route
toRoute page =
    case page of
        Projects ->
            Route.Projects

        Events ->
            Route.Events


fromRoute : Route -> Page
fromRoute route =
    case route of
        Route.Projects ->
            Projects

        Route.Events ->
            Events


isCurrentlyActive : Page -> Route -> Bool
isCurrentlyActive page route =
    fromRoute route == page


generalTemplate : Geo -> Page -> Html msg -> Html msg
generalTemplate city page content =
    div
        [ css
            [ backgroundColor Colors.lightGrey
            , fontFamilies [ "Nunito", "sans-serif" ]
            , fontWeight (int 400)
            , lineHeight (num 1.1)
            , color Colors.darkGrey
            ]
        ]
        [ global
            [ selector "html" [ backgroundColor Colors.lightGrey ]
            , selector
                "::selection"
                [ color Colors.darkGrey
                , property "background" Colors.pageSelection
                , textShadow none
                ]
            ]
        , viewHeader city (viewIntro city)
        , viewNav city page
        , content
        ]


viewHeader : Geo -> Html msg -> Html msg
viewHeader geo content =
    header
        [ css
            [ fullwidthContainer
            , backgroundColor Colors.darkGrey
            , color Colors.lightGrey
            ]
        ]
        [ div [ css [ innerContainer, paddingTop (px 32) ] ]
            [ h1 [ css [ color Colors.lightGrey, fontSize (px 36), fontFamilies [ "Staatliches" ], letterSpacing (Css.em 0.05) ] ]
                [ text__ "FP Specialty" ]
            , p [] [ text__ (Geo.showGeo geo) ]
            , content
            ]
        ]


viewIntro : Geo -> Html msg
viewIntro geo =
    let
        link (Contacts.Link g url caption) =
            textLinkOnDark
                [ css [ marginRight (Css.em 1) ]
                , targetBlank
                , noOpener
                , href url
                ]
                [ text__ caption ]
    in
    section [ css [ regularText ] ]
        [ p [] [ text__ "Мы изучаем и применяем функциональные языки программирования." ]
        , geo
            |> Contacts.getContacts
            |> List.map link
            |> p [ css [ displayFlex, flexWrap wrap ] ]
        ]


viewNav : Geo -> Page -> Html msg
viewNav geo model =
    let
        link route txt =
            ifElse (isCurrentlyActive model route) navLinkDisabled navLink (Route.toUrlPath geo route) txt
    in
    div [ css [ fullwidthContainer, backgroundColor Colors.secondaryLightGrey ] ]
        [ nav
            [ css
                [ displayFlex
                , flexWrap wrap
                , width (pct 100)
                , maxWidth (px 1000)
                , padding4 zero (px 16) (px 16) (px 32)
                , mediaSmartphonePortrait [ paddingLeft (px 16), paddingRight (px 16) ]
                ]
            ]
            [ link Route.Events "Мероприятия"
            , link Route.Projects "Проекты"
            ]
        ]


view : Geo -> Page -> { title : String, content : Html msg } -> Browser.Document msg
view geo page { title, content } =
    { title = title ++ " — " ++ "FP Specialty"
    , body = [ toUnstyled <| generalTemplate geo page content ]
    }
