module Expect.Optional exposing (dictField, emptyDict, emptyField, false, field, true)

import Dict exposing (Dict)
import Expect exposing (Expectation)


field : (a -> Maybe b) -> a -> Expectation
field getValue object =
    getValue object |> isJust |> Expect.true "Field does not exist or is empty"


emptyField : (a -> Maybe b) -> a -> Expectation
emptyField getValue object =
    getValue object |> isJust |> Expect.false "Field should not exist or be empty"


dictField : (a -> Dict k v) -> a -> Expectation
dictField getValue object =
    getValue object |> Dict.isEmpty |> not |> Expect.true "Dictionary should not be empty"


emptyDict : (a -> Dict k v) -> a -> Expectation
emptyDict getValue object =
    getValue object |> Dict.isEmpty |> Expect.true "Dictionary should be empty"


true : (a -> Bool) -> a -> Expectation
true getValue object =
    getValue object |> Expect.true "Field should be true"


false : (a -> Bool) -> a -> Expectation
false getValue object =
    getValue object |> Expect.false "Field should be false"


isJust : Maybe a -> Bool
isJust m =
    case m of
        Just _ ->
            True

        Nothing ->
            False
