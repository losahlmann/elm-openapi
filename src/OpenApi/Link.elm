module OpenApi.Link exposing (Link, jsonDecoder)

import Dict exposing (Dict)
import Json.Decode as Json



-- TODO: Link Object
{- Link Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#link-object
-}


type alias Link =
    {}


jsonDecoder : Json.Decoder Link
jsonDecoder =
    Json.succeed {}
