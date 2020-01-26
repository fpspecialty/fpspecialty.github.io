module Page.Projects exposing (..)

import Colors
import Css exposing (..)
import Geo exposing (City(..))
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (alt, css, href, src)
import List.Extra
import Maybe.Extra exposing (toList)
import Project exposing (..)
import Typography exposing (text__)
import UiElements exposing (..)
import UiStyles exposing (..)
import Utils exposing (..)


view : List Project -> { title : String, content : Html msg }
view projs =
    div [ css [ fullwidthContainer, backgroundColor Colors.lightGrey ] ]
        [ article [ css [ innerContainer ] ]
            [ header2 [] [ text "Проекты" ]
            , div [] <| List.map viewProject projs
            ]
        ]
        |> (\x -> { title = "Проекты", content = x })


viewProject : Project -> Html msg
viewProject ((Project { name_i18n, description_i18n, contributors, links }) as project) =
    let
        projectSection =
            section
                [ css
                    [ displayFlex
                    , marginTop (px 32)
                    , marginBottom (px 72)
                    , lastChild [ marginBottom zero ]
                    , mediaSmartphonePortrait [ flexDirection column ]
                    ]
                ]

        imageWrapper =
            div
                [ css
                    [ width (px 200)
                    , flexGrow (num 0)
                    , flexShrink (num 0)
                    , textAlign right
                    , marginRight (px 32)
                    , marginBottom (px 24)
                    ]
                ]

        descriptionWrapper =
            div [ css [ flexShrink (num 1) ] ]

        splitDescription =
            description_i18n
                |> String.split "\n"
                |> List.map (\x -> p [ css [ regularText ] ] [ text__ x ])
                |> div []
    in
    projectSection
        [ imageWrapper [ viewProjectImage project ]
        , descriptionWrapper
            [ header3 []
                [ text__ name_i18n ]
            , splitDescription
            , viewContributors contributors
            , links
                |> List.map
                    (\link ->
                        buttonLink
                            [ css
                                [ marginTop (Css.em 0.7)
                                , marginBottom (Css.em 0.7)
                                , marginRight (Css.em 1)
                                , lastChild [ marginRight zero ]
                                ]
                            , href link.url
                            , targetBlank
                            , noOpener
                            ]
                            [ text__ link.name_i18n ]
                    )
                |> div
                    [ css
                        [ displayFlex
                        , flexDirection row
                        , flexWrap wrap
                        , alignItems flexStart
                        ]
                    ]
            ]
        ]


viewProjectImage : Project -> Html msg
viewProjectImage (Project { name_i18n, imgFileName }) =
    case imgFileName of
        Just filename ->
            img
                [ css
                    [ regularShadow
                    , maxWidth (px 200)
                    , maxHeight (px 300)
                    , borderRadius (px 3)
                    ]
                , srcSet ("/images/projects/" ++ filename)
                , src ("/images/projects/" ++ filename)
                , alt name_i18n
                ]
                []

        Nothing ->
            emptyHtml


viewContributors : List Contributor -> Html msg
viewContributors contributors =
    let
        viewContributor isLast { url, name_i18n } =
            textLink [ css [ displayFlex, alignItems center ], href url, targetBlank, noOpener ]
                [ text__ name_i18n
                , ifElse isLast emptyHtml (text ",")
                ]
    in
    let
        allButLast =
            contributors
                |> List.Extra.init
                |> toList
                |> List.concat
                |> List.map (viewContributor False)

        last =
            contributors
                |> List.Extra.last
                |> toList
                |> List.map (viewContributor True)
    in
    div
        [ css
            [ displayFlex
            , flexWrap wrap
            , flexDirection row
            , alignItems center
            ]
        ]
    <|
        [ span [ css [ fontWeight (int 700), marginTop (Css.em 0.5), marginRight (Css.em 0.5) ] ]
            [ text__ "Команда проекта:" ]
        ]
            ++ allButLast
            ++ last
