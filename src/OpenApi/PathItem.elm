module OpenApi.PathItem exposing (PathItem, jsonDecoder)

import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.Operation as Operation exposing (Operation)
import OpenApi.Parameter as Parameter exposing (Parameter)
import OpenApi.Server as Server exposing (Server)



{- Path Item Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#path-item-object
-}


type alias PathItem =
    { ref : Maybe String
    , summary : Maybe String
    , description : Maybe String
    , get : Maybe Operation
    , put : Maybe Operation
    , post : Maybe Operation
    , delete : Maybe Operation
    , options : Maybe Operation
    , head : Maybe Operation
    , patch : Maybe Operation
    , trace : Maybe Operation
    , servers : List Server
    , parameters : List Parameter
    }


jsonDecoder : Json.Decoder PathItem
jsonDecoder =
    Json.succeed PathItem
        |> JsonField.optional "$ref" (Json.nullable Json.string) Nothing
        |> JsonField.optional "summary" (Json.nullable Json.string) Nothing
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> JsonField.optional "get" (Json.nullable Operation.jsonDecoder) Nothing
        |> JsonField.optional "put" (Json.nullable Operation.jsonDecoder) Nothing
        |> JsonField.optional "post" (Json.nullable Operation.jsonDecoder) Nothing
        |> JsonField.optional "delete" (Json.nullable Operation.jsonDecoder) Nothing
        |> JsonField.optional "options" (Json.nullable Operation.jsonDecoder) Nothing
        |> JsonField.optional "head" (Json.nullable Operation.jsonDecoder) Nothing
        |> JsonField.optional "patch" (Json.nullable Operation.jsonDecoder) Nothing
        |> JsonField.optional "trace" (Json.nullable Operation.jsonDecoder) Nothing
        |> JsonField.optional "servers" (Json.list Server.jsonDecoder) []
        |> JsonField.optional "parameters" (Json.list Parameter.jsonDecoder) []
