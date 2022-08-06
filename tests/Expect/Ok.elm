module Expect.Ok exposing (andThen)

import Expect exposing (Expectation)
import Json.Decode as Json


andThen : (a -> Expectation) -> Result Json.Error a -> Expectation
andThen expectation subject =
    case subject of
        Err err ->
            err
                |> Json.errorToString
                |> Expect.fail

        Ok object ->
            object
                |> expectation
