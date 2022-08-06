module OpenApi.License exposing (License, jsonDecoder)

import Json.Decode as Json
import Json.Decode.Pipeline as JsonField



{- License Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#license-object
-}


type alias License =
    { name : String

    -- identifier and url are mutually exclusive
    , identifier : Maybe String
    , url : Maybe String
    }


jsonDecoder : Json.Decoder License
jsonDecoder =
    Json.succeed License
        |> JsonField.required "name" Json.string
        |> JsonField.optional "identifier" (Json.nullable Json.string) Nothing
        |> JsonField.optional "url" (Json.nullable Json.string) Nothing
