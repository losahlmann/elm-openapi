module OpenApi.Operation exposing (Operation, jsonDecoder)

-- import OpenApi.Callback as Callback exposing (Callback)

import Dict exposing (Dict)
import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.ExternalDocumentation as ExternalDocumentation exposing (ExternalDocumentation)
import OpenApi.Parameter as Parameter exposing (Parameter)
import OpenApi.RequestBody as RequestBody exposing (RequestBody)
import OpenApi.Responses as Responses exposing (Responses)
import OpenApi.SecurityRequirement as SecurityRequirement exposing (SecurityRequirement)
import OpenApi.Server as Server exposing (Server)



-- TODO: extensions: x-private in Make API schema
{- Operation Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#operation-object
-}


type alias Operation =
    { tags : List String
    , summary : Maybe String
    , description : Maybe String
    , externalDocs : Maybe ExternalDocumentation
    , operationId : Maybe String
    , parameters : List Parameter
    , requestBody : Maybe RequestBody
    , responses : Maybe Responses

    -- TODO: Callback has circular dependency via PathItem -> Operation
    -- , callbacks : Dict String Callback
    , deprecated : Bool
    , security : List SecurityRequirement
    , servers : List Server
    }


jsonDecoder : Json.Decoder Operation
jsonDecoder =
    Json.succeed Operation
        |> JsonField.optional "tags" (Json.list Json.string) []
        |> JsonField.optional "summary" (Json.nullable Json.string) Nothing
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> JsonField.optional "externalDocs" (Json.nullable ExternalDocumentation.jsonDecoder) Nothing
        |> JsonField.optional "operationId" (Json.nullable Json.string) Nothing
        |> JsonField.optional "parameters" (Json.list Parameter.jsonDecoder) []
        |> JsonField.optional "requestBody" (Json.nullable RequestBody.jsonDecoder) Nothing
        |> JsonField.optional "responses" (Json.nullable Responses.jsonDecoder) Nothing
        -- |> JsonField.optional "callbacks" (Json.dict Callback.jsonDecoder)
        |> JsonField.optional "deprecated" Json.bool False
        |> JsonField.optional "security" (Json.list SecurityRequirement.jsonDecoder) []
        |> JsonField.optional "servers" (Json.list Server.jsonDecoder) []
