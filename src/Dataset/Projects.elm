module Dataset.Projects exposing (..)

import Project exposing (..)


projects : List Project
projects =
    [ Project
        { name_i18n =
            "Скоро: Русский перевод книги «Scala with Cats»"
        , description_i18n =
            """Книга описывает чисто функциональный подход к разработке приложений на Scala."""
        , links = [ Link "Читать онлайн (текущая версия)" "https://fpspecialty.github.io/scala-with-cats/scala-with-cats.html" ]
        , imgFileName = Just "scala-with-cats.webp"
        , contributors =
            [ Contributor "Vladimir Logachev" "https://github.com/VladimirLogachev"
            , Contributor "ivan-klass" "https://github.com/ivan-klass"
            , Contributor "Vladimir Nizamutdinov" "https://github.com/astartes91"
            , Contributor "BanyRule" "https://github.com/banyrule"
            , Contributor "AntonShtyrkin" "https://github.com/AntonShtyrkin"
            , Contributor "Erdemus" "https://github.com/Erdemus"
            , Contributor "остальные участники" "https://github.com/fpspecialty/scala-with-cats-ru/graphs/contributors"
            ]
        }
    ]
