module Expect.List exposing (forEach)

import Expect exposing (Expectation)


forEach : (subject -> Expectation) -> List subject -> Expectation
forEach expectations query =
    Expect.all
        (query |> List.map expectations |> List.map (\i -> \_ -> i))
        ()
