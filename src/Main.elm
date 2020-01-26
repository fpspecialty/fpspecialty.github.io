module Main exposing (main)

import Browser
import Browser.Hash exposing (application)
import Browser.Navigation as Nav
import Dataset.Events exposing (..)
import Dataset.Projects exposing (..)
import Geo
import Html
import Page
import Page.Events as Events
import Page.Projects as Projects
import Route exposing (Route)
import Session exposing (Session)
import Url exposing (Url)
import Utils exposing (..)


toSession : Model -> Session
toSession page =
    case page of
        Projects session ->
            session

        Events session _ ->
            session


main : Program () Model Msg
main =
    application
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        , onUrlChange = RouteChange
        , onUrlRequest = OnUrlRequest
        }


type Model
    = Projects Session
    | Events Session Events.Model


type Msg
    = GotEventsMsg Events.Msg
    | RouteChange Url
    | OnUrlRequest Browser.UrlRequest


updateWith :
    (subModel -> Model)
    -> (subMsg -> Msg)
    -> ( subModel, Cmd subMsg )
    -> ( Model, Cmd Msg )
updateWith toModel toMsg ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )


changeRouteTo : Route -> Session -> ( Model, Cmd Msg )
changeRouteTo route session =
    case route of
        Route.Projects ->
            plain <| Projects session

        Route.Events ->
            Events.init
                |> updateWith (Events session) GotEventsMsg


{-| A crutch. I don't know how to implement it the right way for now.
Later will remove it, for sure.
Needed in cases when user clicks Enter with the same url,
or when city changes
-}
preserveOldState : Model -> Model -> Model
preserveOldState prev next =
    case ( prev, next ) of
        ( Events _ x, Events session _ ) ->
            Events session x

        _ ->
            next


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        ( ( city, route ), navCmd ) =
            Route.parseUrl key Geo.defaultGeo url

        ( newModel, initCmd ) =
            changeRouteTo route (Session city key)
    in
    ( newModel, Cmd.batch [ navCmd, initCmd ] )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( GotEventsMsg m, Events session x ) ->
            Events.update m x |> updateWith (Events session) GotEventsMsg

        ( RouteChange url, _ ) ->
            let
                prevSession =
                    toSession model

                ( ( geo, route ), navCmd ) =
                    Route.parseUrl prevSession.navKey prevSession.geo url

                ( newModel, initCmd ) =
                    changeRouteTo route (Session geo prevSession.navKey)
            in
            ( preserveOldState model newModel, Cmd.batch [ navCmd, initCmd ] )

        ( OnUrlRequest urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.replaceUrl (toSession model).navKey <| "#" ++ Maybe.withDefault "" url.fragment )

                Browser.External url ->
                    ( model, Nav.load url )

        _ ->
            plain model


view : Model -> Browser.Document Msg
view model =
    let
        geo =
            (toSession model).geo

        viewPage page toMsg config =
            let
                { title, body } =
                    Page.view geo page config
            in
            { title = title
            , body = List.map (Html.map toMsg) body
            }
    in
    case model of
        Projects _ ->
            viewPage Page.Projects identity (Projects.view projects)

        Events _ state ->
            viewPage Page.Events GotEventsMsg (Events.view geo state knownEvents)
