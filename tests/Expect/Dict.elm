module Expect.Dict exposing (key)

import Dict exposing (Dict)
import Expect exposing (Expectation)
import Expect.Maybe


key : String -> Dict String v -> Expectation
key k object =
    object |> Dict.get k |> Expect.Maybe.isJust |> Expect.true ("Dictionary should contain key " ++ k)
