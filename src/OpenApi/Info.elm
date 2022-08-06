module OpenApi.Info exposing (Info, jsonDecoder)

import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.Contact as Contact exposing (Contact)
import OpenApi.License as License exposing (License)



{- Info Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#info-object
-}


type alias Info =
    { title : String
    , summary : Maybe String
    , description : Maybe String
    , termsOfService : Maybe String
    , contact : Maybe Contact
    , license : Maybe License
    , version : String
    }


jsonDecoder : Json.Decoder Info
jsonDecoder =
    Json.succeed Info
        |> JsonField.required "title" Json.string
        |> JsonField.optional "summary" (Json.nullable Json.string) Nothing
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> JsonField.optional "termsOfService" (Json.nullable Json.string) Nothing
        |> JsonField.optional "contact" (Json.nullable Contact.jsonDecoder) Nothing
        |> JsonField.optional "license" (Json.nullable License.jsonDecoder) Nothing
        |> JsonField.required "version" Json.string
