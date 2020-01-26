module Project exposing (..)


type Project
    = Project
        { name_i18n : String
        , description_i18n : String
        , links : List Link
        , imgFileName : Maybe String
        , contributors : List Contributor
        }


type alias Link =
    { name_i18n : String
    , url : String
    }


type alias Contributor =
    { name_i18n : String
    , url : String
    }
