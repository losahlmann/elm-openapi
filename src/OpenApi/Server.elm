module OpenApi.Server exposing (Server, jsonDecoder)

import Dict exposing (Dict)
import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.ServerVariable as ServerVariable exposing (ServerVariable)



{- Server Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#server-object
-}


type alias Server =
    { url : String
    , description : Maybe String
    , variables : Dict String ServerVariable
    }


jsonDecoder : Json.Decoder Server
jsonDecoder =
    Json.succeed Server
        |> JsonField.required "url" Json.string
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> JsonField.optional "variables" (Json.dict ServerVariable.jsonDecoder) Dict.empty



-- TODO
-- - URL variable substitution
