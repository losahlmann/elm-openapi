module OpenApi.ExternalDocumentation exposing (ExternalDocumentation, jsonDecoder)

import Json.Decode as Json
import Json.Decode.Pipeline as JsonField



{- External Documentation Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#external-documentation-object
-}


type alias ExternalDocumentation =
    { url : String
    , description : Maybe String
    }


jsonDecoder : Json.Decoder ExternalDocumentation
jsonDecoder =
    Json.succeed ExternalDocumentation
        |> JsonField.required "url" Json.string
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
