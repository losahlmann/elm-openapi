module OpenApi.Callback exposing (Callback, jsonDecoder)

import Dict exposing (Dict)
import Json.Decode as Json
import OpenApi.PathItem as PathItem exposing (PathItem)



{- Callback Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#callback-object
-}


type alias Callback =
    Dict String PathItem


jsonDecoder : Json.Decoder Callback
jsonDecoder =
    Json.dict PathItem.jsonDecoder



-- TODO: Callback Object tests
