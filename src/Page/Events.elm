module Page.Events exposing (..)

import Colors
import Css exposing (..)
import Event exposing (..)
import Geo exposing (City(..), Geo)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (alt, css, href, src)
import List.Extra exposing (stableSortWith)
import Typography exposing (text__)
import UiElements exposing (..)
import UiStyles exposing (..)
import Utils exposing (..)


type Msg
    = SetEventLevel (Maybe Level)


type alias Model =
    { level : Maybe Level }


init : ( Model, Cmd Msg )
init =
    plain { level = Nothing }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetEventLevel level ->
            plain { model | level = level }


roundSticker : Style
roundSticker =
    batch
        [ -- sticker position
          position relative
        , bottom (px 58)
        , left (px 5)
        , transform (rotate (deg -10))

        -- sticker itself
        , displayFlex
        , width (px 50)
        , height (px 50)
        , textAlign center
        , alignItems center
        , borderRadius (px 300)
        , fontSize (px 12)
        ]


view : Geo -> Model -> List Event -> { title : String, content : Html Msg }
view geo _ events =
    let
        description =
            """
            Формат:
            • не употребляем алкоголь на мероприятиях
            • не ценим сообщения в чате, часто стираем их
            • не занимаемся обсуждением ФП в ООП языках"""

        splitDescription =
            description
                |> String.split "\n"
                |> List.map (\x -> p [] [ text__ x ])
                |> div [ css [ regularText, marginTop (Css.em 1) ] ]
    in
    div [ css [ fullwidthContainer, backgroundColor Colors.lightGrey ] ]
        [ article [ css [ innerContainer ] ]
            [ header2 [] [ text__ "Мероприятия" ]
            , splitDescription
            , events
                |> stableSortWith eventOrdering
                |> List.map (viewEvent geo)
                |> div [ css [ displayFlex, flexWrap wrap, alignItems baseline ] ]
            ]
        ]
        |> (\x -> { title = "Мероприятия", content = x })


viewEvent : Geo -> Event -> Html msg
viewEvent geo event =
    viewEvent_ { sticker = Nothing, available = Event.isOpen event } event


viewEvent_ : { sticker : Maybe (Html msg), available : Bool } -> Event -> Html msg
viewEvent_ { sticker, available } (Event event) =
    let
        availabilityStyle =
            batch <| ifElse available [] [ opacity (num 0.5) ]

        {- sticker area is placed in a bottom left corner of the event -}
        {- use ralative position for sticker to move inside this area -}
        stickerNode =
            case sticker of
                Just x ->
                    div
                        [ css
                            [ position relative
                            , height zero
                            , userSelectNone
                            ]
                        ]
                        [ x ]

                Nothing ->
                    emptyHtml
    in
    section
        [ css
            [ marginRight (px 32)
            , width (px 300)
            , fontSize (px 13)
            ]
        ]
        [ textLink [ href event.registrationUrl, targetBlank, noOpener ]
            [ img
                [ css
                    [ availabilityStyle
                    , regularShadow
                    , maxHeight (px 200)
                    , maxWidth (px 300)
                    , borderRadius (px 3)
                    , marginTop (Css.em 2)
                    ]
                , srcSet ("/images/events/" ++ Maybe.withDefault defaultCover event.cover)
                , src ("/images/events/" ++ Maybe.withDefault defaultCover event.cover)
                , alt <| event.shortDescription ++ ", " ++ event.title
                ]
                []
            ]
        , stickerNode
        , div []
            [ p [ css [ margin2 (Css.em 0.5) zero ] ] [ textLink [ href event.registrationUrl, targetBlank, noOpener ] [ text__ event.title ] ]
            , p [] [ text__ event.shortDescription ]
            ]
        ]
