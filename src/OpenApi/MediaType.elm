module OpenApi.MediaType exposing (MediaType, jsonDecoder)

import Dict exposing (Dict)
import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.Encoding as Encoding exposing (Encoding)
import OpenApi.Example as Example exposing (Example)
import OpenApi.Schema as Schema exposing (Schema)



{- Media Type Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#media-type-object
-}
-- TODO: example/s


type alias MediaType =
    { schema : Maybe Schema

    -- , example :
    , examples : Dict String Example
    , encoding : Dict String Encoding
    }


jsonDecoder : Json.Decoder MediaType
jsonDecoder =
    Json.succeed MediaType
        |> JsonField.optional "schema" (Json.nullable Schema.jsonDecoder) Nothing
        |> JsonField.optional "examples" (Json.dict Example.jsonDecoder) Dict.empty
        |> JsonField.optional "content" (Json.dict Encoding.jsonDecoder) Dict.empty
