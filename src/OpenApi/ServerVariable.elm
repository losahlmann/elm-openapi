module OpenApi.ServerVariable exposing (ServerVariable, jsonDecoder)

import Json.Decode as Json
import Json.Decode.Pipeline as JsonField



{- Server Variable Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#server-variable-object
-}


type alias ServerVariable =
    { enum : List String
    , default : String
    , description : Maybe String
    }


jsonDecoder : Json.Decoder ServerVariable
jsonDecoder =
    Json.succeed ServerVariable
        |> JsonField.optional "enum" (Json.list Json.string) []
        |> JsonField.required "default" Json.string
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
