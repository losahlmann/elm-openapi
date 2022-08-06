module OpenApi.Tag exposing (Tag, jsonDecoder)

import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.ExternalDocumentation as ExternalDocumentation exposing (ExternalDocumentation)



{- Tag Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#tag-object
-}


type alias Tag =
    { name : String
    , description : Maybe String
    , externalDocs : Maybe ExternalDocumentation
    }


jsonDecoder : Json.Decoder Tag
jsonDecoder =
    Json.succeed Tag
        |> JsonField.required "name" Json.string
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> JsonField.optional "externalDocs" (Json.nullable ExternalDocumentation.jsonDecoder) Nothing
