module OpenApi.Paths exposing (Paths, jsonDecoder)

import Dict exposing (Dict)
import Json.Decode as Json
import OpenApi.PathItem as PathItem exposing (PathItem)



{- Paths Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#paths-object
-}


type alias Paths =
    Dict String PathItem



-- TODO: strip "/" from all keys


jsonDecoder : Json.Decoder Paths
jsonDecoder =
    Json.dict PathItem.jsonDecoder
