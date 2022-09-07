module OpenApi.Schema exposing (Schema, jsonDecoder)

import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import Json.Schema.Definitions as JsonSchema


type alias Schema =
    JsonSchema.Schema


jsonDecoder : Json.Decoder Schema
jsonDecoder =
    JsonSchema.decoder
