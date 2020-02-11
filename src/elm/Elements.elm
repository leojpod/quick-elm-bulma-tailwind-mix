module Elements exposing
    ( Option
    , Selection
    , box
    , dropdown
    , updateSelectionOnId
    )

import FontAwesome as Icon
import Html exposing (Html, button, div, h1, input, label, span, text)
import Html.Attributes exposing (class, classList, type_)
import Html.Events exposing (onClick, onInput)



-- Model like stuff


type alias Option a =
    { a
        | id : String
        , name : String
        , selected : Bool
    }


type alias Selection a =
    List (Option a)


selectedOptions : Selection a -> List String
selectedOptions =
    List.filter .selected
        >> List.map .name


updateSelectionOnId : Option a -> Selection a -> Selection a
updateSelectionOnId replacement =
    List.map
        (\({ id } as option) ->
            if id == replacement.id then
                replacement

            else
                option
        )



-- box element


type alias Messages a msg =
    { toggleOption : Option a -> msg
    , showDropdown : msg
    , hideDropdown : msg
    }


box : Messages a msg -> String -> List (Html.Attribute msg) -> Selection a -> Bool -> Html msg
box messages title extraAttributes selection isShown =
    div (class "box h-64" :: extraAttributes)
        [ div [ class "flex flex-row-reverse items-center justify-between" ]
            [ dropdown messages selection isShown
            , h1 [ class "title uppercase is-size-4" ] [ text title ]
            ]
        , case selectedOptions selection of
            [] ->
                text ""

            selected ->
                String.join ", " selected
                    |> (++) "Selected: "
                    |> text
        ]


dropdown : Messages a msg -> Selection a -> Bool -> Html msg
dropdown { toggleOption, showDropdown, hideDropdown } selection isShown =
    div [ class "dropdown is-right", classList [ ( "is-active", isShown ) ] ] <|
        div [ class "dropdown-trigger" ]
            [ button
                [ class "button is-rounded is-small has-background-grey-lighter"
                , onClick showDropdown
                ]
                [ span [ class "uppercase mr-2" ] [ text "compare" ]
                , span [ class "icon is-small" ]
                    [ Icon.icon <|
                        if isShown then
                            Icon.caretUp

                        else
                            Icon.caretDown
                    ]
                ]
            ]
            :: (if isShown then
                    -- TODO put the menu here
                    [ -- the dropback first
                      div
                        [ class "fixed left-0 top-0 right-0 bottom-0"
                        , onClick hideDropdown
                        ]
                        []
                    , div [ class "dropdown-menu" ]
                        [ div [ class "dropdown-content overflow-y-auto h-48" ] <|
                            List.map (viewOption toggleOption) selection
                        ]
                    ]

                else
                    []
               )


viewOption : (Option a -> msg) -> Option a -> Html msg
viewOption toggleOption ({ name, selected } as option) =
    div [ class "px-3 py-2 whitespace-no-wrap" ]
        [ label [ class "checkbox" ]
            [ input
                [ type_ "checkbox"
                , Html.Attributes.selected selected
                , onInput <| \_ -> toggleOption option
                , class "mr-2"
                ]
                []
            , span [ class "whitespace-no-wrap" ]
                [ text name
                ]
            ]
        ]
