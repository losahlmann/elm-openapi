module OpenApi.Components exposing (Components, jsonDecoder)

import Dict exposing (Dict)
import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.Callback as Callback exposing (Callback)
import OpenApi.Example as Example exposing (Example)
import OpenApi.Header as Header exposing (Header)
import OpenApi.Link as Link exposing (Link)
import OpenApi.Parameter as Parameter exposing (Parameter)
import OpenApi.PathItem as PathItem exposing (PathItem)
import OpenApi.RequestBody as RequestBody exposing (RequestBody)
import OpenApi.Response as Response exposing (Response)
import OpenApi.Schema as Schema exposing (Schema)
import OpenApi.SecurityScheme as SecurityScheme exposing (SecurityScheme)



{- Components Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#components-object
-}


type alias Components =
    { schemas : Dict String Schema
    , responses : Dict String Response
    , parameters : Dict String Parameter
    , examples : Dict String Example
    , requestBodies : Dict String RequestBody
    , headers : Dict String Header
    , securitySchemes : Dict String SecurityScheme
    , links : Dict String Link
    , callbacks : Dict String Callback
    , pathItems : Dict String PathItem
    }


jsonDecoder : Json.Decoder Components
jsonDecoder =
    Json.succeed Components
        |> JsonField.optional "schemas" (Json.dict Schema.jsonDecoder) Dict.empty
        |> JsonField.optional "responses" (Json.dict Response.jsonDecoder) Dict.empty
        |> JsonField.optional "parameters" (Json.dict Parameter.jsonDecoder) Dict.empty
        |> JsonField.optional "examples" (Json.dict Example.jsonDecoder) Dict.empty
        |> JsonField.optional "requestBodies" (Json.dict RequestBody.jsonDecoder) Dict.empty
        |> JsonField.optional "headers" (Json.dict Header.jsonDecoder) Dict.empty
        |> JsonField.optional "securitySchemes" (Json.dict SecurityScheme.jsonDecoder) Dict.empty
        |> JsonField.optional "links" (Json.dict Link.jsonDecoder) Dict.empty
        |> JsonField.optional "callbacks" (Json.dict Callback.jsonDecoder) Dict.empty
        |> JsonField.optional "pathItems" (Json.dict PathItem.jsonDecoder) Dict.empty
