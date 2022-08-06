module OpenApi.Example exposing (Example, jsonDecoder)

import Json.Decode as Json
import Json.Decode.Pipeline as JsonField



{- Example Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#example-object
-}


type alias Example =
    { summary : Maybe String
    , description : Maybe String

    -- value and externalValue are mutually exclusive
    , value : Maybe Json.Value -- just keep JSON content, can be primitive type or object
    , externalValue : Maybe String
    }


jsonDecoder : Json.Decoder Example
jsonDecoder =
    Json.succeed Example
        |> JsonField.optional "summary" (Json.nullable Json.string) Nothing
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> JsonField.optional "value" (Json.nullable Json.value) Nothing
        |> JsonField.optional "externalValue" (Json.nullable Json.string) Nothing



-- TODO: tests (in spec YAML only)
