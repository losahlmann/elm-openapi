module OpenApi.Contact exposing (Contact, jsonDecoder)

import Json.Decode as Json
import Json.Decode.Pipeline as JsonField



{- Contact Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#contact-object
-}


type alias Contact =
    { name : Maybe String
    , url : Maybe String
    , email : Maybe String
    }


jsonDecoder : Json.Decoder Contact
jsonDecoder =
    Json.succeed Contact
        |> JsonField.optional "name" (Json.nullable Json.string) Nothing
        |> JsonField.optional "url" (Json.nullable Json.string) Nothing
        |> JsonField.optional "email" (Json.nullable Json.string) Nothing
