module Main exposing (..)

import Browser
import Elements
import FontAwesome as Icon
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (class, src)



---- MODEL ----


type Section
    = Overall
    | Category Int


type alias Model =
    { overall : Elements.Selection {}
    , category1 : Elements.Selection {}
    , category2 : Elements.Selection {}
    , category3 : Elements.Selection {}
    , activeDropdown : Maybe Section
    }


mockSelectionWithPrefix : String -> Int -> Int -> Elements.Selection {}
mockSelectionWithPrefix prefix from to =
    List.range from to
        |> List.map
            (\idx ->
                { id = prefix ++ String.fromInt idx
                , name = "Option " ++ prefix ++ String.fromInt idx
                , selected = False
                }
            )


init : ( Model, Cmd Msg )
init =
    ( { overall = mockSelectionWithPrefix "" 1 15
      , category1 = mockSelectionWithPrefix "1." 1 10
      , category2 = mockSelectionWithPrefix "2." 1 10
      , category3 = mockSelectionWithPrefix "3." 1 10
      , activeDropdown = Nothing
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = ToggleDropdown (Maybe Section)
      -- this might not be the optimal way but ... it will do for a small example
    | ToggleOption (Elements.Option {})


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleDropdown dropdown ->
            ( { model | activeDropdown = dropdown }, Cmd.none )

        ToggleOption ({ selected } as option) ->
            model.activeDropdown
                |> Maybe.map
                    (\section ->
                        case section of
                            Overall ->
                                ( { model | overall = Elements.updateSelectionOnId { option | selected = not selected } model.overall }, Cmd.none )

                            Category 1 ->
                                ( { model | category1 = Elements.updateSelectionOnId { option | selected = not selected } model.category1 }, Cmd.none )

                            Category 2 ->
                                ( { model | category2 = Elements.updateSelectionOnId { option | selected = not selected } model.category2 }, Cmd.none )

                            Category 3 ->
                                ( { model | category3 = Elements.updateSelectionOnId { option | selected = not selected } model.category3 }, Cmd.none )

                            _ ->
                                ( model, Cmd.none )
                    )
                |> Maybe.withDefault ( model, Cmd.none )



---- VIEW ----


isActive : Section -> Model -> Bool
isActive section { activeDropdown } =
    Just section == activeDropdown


view : Model -> Html Msg
view ({ overall, category1, category2, category3 } as model) =
    div [ class "min-h-screen min-w-screen has-background-white-ter" ]
        [ div [ class "container is-rounded has-background-grey-lighter" ]
            [ Elements.box
                { toggleOption = ToggleOption
                , showDropdown = ToggleDropdown <| Just Overall
                , hideDropdown = ToggleDropdown Nothing
                }
                "Overall"
                []
                overall
                (isActive Overall model)
            , div [ class "container p-5" ]
                [ div [ class "m-0" ]
                    [ h1 [ class "title uppercase is-size-4 m-0" ] [ text "Breakdown" ]
                    , text "Select the options from dropdown menu"
                    ]
                ]
            , div [ class "container" ]
                [ div [ class "columns mx-5 pb-8" ]
                    [ Elements.box
                        { toggleOption = ToggleOption
                        , showDropdown = ToggleDropdown <| Just <| Category 1
                        , hideDropdown = ToggleDropdown Nothing
                        }
                        "Category 1"
                        [ class "column is-full" ]
                        category1
                        (isActive (Category 1) model)
                    ]
                , div [ class "columns mx-3 pb-8" ]
                    [ div [ class "column columns" ]
                        [ div [ class "column is-half" ]
                            [ Elements.box
                                { toggleOption = ToggleOption
                                , showDropdown = ToggleDropdown <| Just <| Category 2
                                , hideDropdown = ToggleDropdown Nothing
                                }
                                "Category 2"
                                []
                                category2
                                (isActive (Category 2) model)
                            ]
                        , div [ class "column is-half" ]
                            [ Elements.box
                                { toggleOption = ToggleOption
                                , showDropdown = ToggleDropdown <| Just <| Category 3
                                , hideDropdown = ToggleDropdown Nothing
                                }
                                "Category 3"
                                []
                                category3
                                (isActive (Category 3) model)
                            ]
                        ]
                    ]
                ]
            ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
