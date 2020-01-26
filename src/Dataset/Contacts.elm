module Dataset.Contacts exposing (..)

import Geo exposing (City(..), Geo)


type alias ExternalUrl =
    String


type Link
    = Link Geo ExternalUrl String


getContacts : Geo -> List Link
getContacts geo =
    [ Link Geo.global "https://github.com/fpspecialty" "GitHub" ]
        ++ (geo |> Maybe.map getContactsByCity |> Maybe.withDefault [])


getContactsByCity : City -> List Link
getContactsByCity city =
    case city of
        Novosibirsk ->
            [ Link (Just Novosibirsk) "https://www.meetup.com/fpspecialty_nsk/" "Meetup.com"
            , Link (Just Novosibirsk) "https://t.me/fpspecialty_nsk" "Telegram"
            , Link (Just Novosibirsk) "https://vk.com/fpspecialty_nsk" "VK"
            ]
