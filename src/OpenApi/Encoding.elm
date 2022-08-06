module OpenApi.Encoding exposing (Encoding, jsonDecoder)

import Dict exposing (Dict)
import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.Header as Header exposing (Header)



{- Encoding Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#encoding-object
-}


type alias Encoding =
    { contentType : Maybe String
    , headers : Dict String Header
    , style : Maybe String
    , explode : Bool
    , allowReserved : Bool
    }


jsonDecoder : Json.Decoder Encoding
jsonDecoder =
    Json.succeed Encoding
        |> JsonField.optional "contentType" (Json.nullable Json.string) Nothing
        |> JsonField.required "headers" (Json.dict Header.jsonDecoder)
        |> JsonField.optional "style" (Json.nullable Json.string) Nothing
        |> JsonField.optional "explode" Json.bool True
        |> JsonField.optional "allowReserved" Json.bool False



-- TODO: tests (in spec YAML only)
