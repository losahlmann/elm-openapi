module OpenApi.Schema exposing (Schema, jsonDecoder)

import Json.Decode as Json
import Json.Decode.Pipeline as JsonField


type alias Schema =
    Json.Value


jsonDecoder : Json.Decoder Schema
jsonDecoder =
    Json.value
