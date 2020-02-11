module Elements exposing (box, dropdown)

import FontAwesome as Icon
import Html exposing (Html, button, div, h1, span, text)
import Html.Attributes exposing (class)


dropdown : () -> Html msg
dropdown _ =
    div [ class "dropdown" ]
        [ div [ class "dropdown-trigger" ]
            [ button [ class "button is-rounded is-small has-background-grey-lighter" ]
                [ span [ class "uppercase mr-2" ] [ text "compare" ]
                , span [ class "icon is-small" ] [ Icon.icon Icon.caretDown ]
                ]
            ]
        ]


box : String -> List (Html.Attribute msg) -> List e -> List e -> Bool -> Html msg
box title extraAttributes selected options showDropdown =
    div (class "box h-64" :: extraAttributes)
        [ div [ class "flex flex-row-reverse items-center justify-between" ]
            [ dropdown ()
            , h1 [ class "title uppercase is-size-4" ] [ text title ]
            ]
        , text "here will be options"
        ]
