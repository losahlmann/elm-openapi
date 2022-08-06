module Expect.Required exposing (stringField)

import Expect exposing (Expectation)


stringField : (a -> String) -> a -> Expectation
stringField getValue object =
    getValue object |> String.isEmpty |> Expect.false "Field is empty"
