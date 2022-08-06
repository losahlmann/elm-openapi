module OpenApi.OpenApi exposing (OpenApi, decodeJsonString, jsonDecoder)

import Browser exposing (UrlRequest(..))
import Dict exposing (Dict)
import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.Components as Components exposing (Components)
import OpenApi.ExternalDocumentation as ExternalDocumentation exposing (ExternalDocumentation)
import OpenApi.Info as Info exposing (Info)
import OpenApi.PathItem as PathItem exposing (PathItem)
import OpenApi.Paths as Paths exposing (Paths)
import OpenApi.SecurityRequirement as SecurityRequirement exposing (SecurityRequirement)
import OpenApi.Server as Server exposing (Server)
import OpenApi.Tag as Tag exposing (Tag)


decodeJsonString : String -> Result Json.Error OpenApi
decodeJsonString =
    Json.decodeString jsonDecoder



{- OpenAPI Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#openapi-object
-}


type alias OpenApi =
    { openapi : String
    , info : Info
    , jsonSchemaDialect : Maybe String
    , servers : List Server
    , paths : Maybe Paths
    , webhooks : Dict String PathItem
    , components : Maybe Components
    , security : List SecurityRequirement
    , tags : List Tag
    , externalDocs : Maybe ExternalDocumentation
    }


jsonDecoder : Json.Decoder OpenApi
jsonDecoder =
    Json.succeed OpenApi
        |> JsonField.required "openapi" Json.string
        |> JsonField.required "info" Info.jsonDecoder
        |> JsonField.optional "jsonSchemaDialect" (Json.nullable Json.string) Nothing
        |> JsonField.optional "servers" (Json.list Server.jsonDecoder) []
        |> JsonField.optional "paths" (Json.nullable Paths.jsonDecoder) Nothing
        |> JsonField.optional "webhooks" (Json.dict PathItem.jsonDecoder) Dict.empty
        |> JsonField.optional "components" (Json.nullable Components.jsonDecoder) Nothing
        |> JsonField.optional "security" (Json.list SecurityRequirement.jsonDecoder) []
        |> JsonField.optional "tags" (Json.list Tag.jsonDecoder) []
        |> JsonField.optional "externalDocs" (Json.nullable ExternalDocumentation.jsonDecoder) Nothing
