module Main exposing (..)

import Browser
import Elements
import FontAwesome as Icon
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (class, src)



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "min-h-screen min-w-screen has-background-white-ter" ]
        [ div [ class "container is-rounded has-background-grey-lighter" ]
            [ Elements.box "Overall" [] [] [] False
            , div [ class "container p-5" ]
                [ div [ class "m-0" ]
                    [ h1 [ class "title uppercase is-size-4 m-0" ] [ text "Breakdown" ]
                    , text "Select the options from dropdown menu"
                    ]
                ]
            , div [ class "container" ]
                [ div [ class "columns mx-5 pb-8" ]
                    [ Elements.box "Category 1" [ class "column is-full" ] [] [] False
                    ]
                , div [ class "columns mx-3 pb-8" ]
                    [ div [ class "column columns" ]
                        [ div [ class "column is-half" ]
                            [ Elements.box "Category 2" [] [] [] False
                            ]
                        , div [ class "column is-half" ]
                            [ Elements.box "Category 3" [] [] [] False
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
