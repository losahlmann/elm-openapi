module OpenApi.Responses exposing (..)

import Dict exposing (Dict)
import Json.Decode as Json
import OpenApi.Response as Response exposing (Response)



{- Responses Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#responses-object
-}


type alias Responses =
    Dict String Response


jsonDecoder : Json.Decoder Responses
jsonDecoder =
    Json.dict Response.jsonDecoder
