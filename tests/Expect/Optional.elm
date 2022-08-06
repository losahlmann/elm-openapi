module Expect.Optional exposing (emptyField, field)

import Expect exposing (Expectation)


field : (a -> Maybe b) -> a -> Expectation
field getValue object =
    getValue object |> isJust |> Expect.true "Field does not exist or is empty"


emptyField : (a -> Maybe b) -> a -> Expectation
emptyField getValue object =
    getValue object |> isJust |> Expect.false "Field should not exist or be empty"


isJust : Maybe a -> Bool
isJust m =
    case m of
        Just _ ->
            True

        Nothing ->
            False
