module Dataset.Events exposing (..)

import Event exposing (..)
import Geo exposing (City(..))


knownEvents : List Event
knownEvents =
    [ Event
        { id = 8
        , shortDescription = ""
        , title = "FP Specialty. Functors, Functoriality, Function Types (Category Theory for Programmers)"
        , registrationUrl = "https://leader-id.ru/event/39170/"
        , cover = Nothing
        , level = Level3
        , isOpen = True
        , location = Offline Novosibirsk { time = 0, place = "" }
        }
    , Event
        { id = 7
        , shortDescription = ""
        , title = "FP Specialty 7"
        , registrationUrl = "https://leader-id.ru/event/38170/"
        , cover = Just "nsk.7.png"
        , level = Level3
        , isOpen = False
        , location = Offline Novosibirsk { time = 0, place = "" }
        }
    , Event
        { id = 6
        , shortDescription = ""
        , title = "FP Specialty at Blurred Education"
        , registrationUrl = "https://leader-id.ru/event/35852"
        , cover = Nothing
        , level = Level1
        , isOpen = False
        , location = Offline Novosibirsk { time = 0, place = "" }
        }
    , Event
        { id = 5
        , shortDescription = ""
        , title = "FP Specialty 6"
        , registrationUrl = "https://leader-id.ru/event/32834"
        , cover = Just "nsk.6.png"
        , level = Level3
        , isOpen = False
        , location = Offline Novosibirsk { time = 0, place = "" }
        }
    , Event
        { id = 4
        , shortDescription = ""
        , title = "FP Specialty 5"
        , registrationUrl = "https://leader-id.ru/event/28368/"
        , cover = Just "nsk.5.png"
        , level = Level3
        , isOpen = False
        , location = Offline Novosibirsk { time = 0, place = "" }
        }
    , Event
        { id = 3
        , shortDescription = ""
        , title = "FP Specialty 4"
        , registrationUrl = "https://leader-id.ru/event/28481/"
        , cover = Just "nsk.4.png"
        , level = Level3
        , isOpen = False
        , location = Offline Novosibirsk { time = 0, place = "" }
        }
    , Event
        { id = 2
        , shortDescription = ""
        , title = "FP Specialty 3"
        , registrationUrl = "https://leader-id.ru/event/28479/"
        , cover = Just "nsk.3.png"
        , level = Level3
        , isOpen = False
        , location = Offline Novosibirsk { time = 0, place = "" }
        }
    , Event
        { id = 1
        , shortDescription = ""
        , title = "FP Specialty 2"
        , registrationUrl = "https://www.meetup.com/fpspecialty_nsk/events/263680809/"
        , cover = Just "nsk.2.jpg"
        , level = Level3
        , isOpen = False
        , location = Offline Novosibirsk { time = 0, place = "" }
        }
    , Event
        { id = 0
        , shortDescription = ""
        , title = "FP Specialty 1"
        , registrationUrl = "https://www.meetup.com/fpspecialty_nsk/events/263679831/"
        , cover = Just "nsk.1.jpg"
        , level = Level3
        , isOpen = False
        , location = Offline Novosibirsk { time = 0, place = "" }
        }
    ]
