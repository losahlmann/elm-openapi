module OpenApi.Parameter exposing (Parameter, jsonDecoder)

import Dict exposing (Dict)
import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.Example as Example exposing (Example)
import OpenApi.Schema as Schema exposing (Schema)



{- Parameter Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#parameter-object
-}


type alias Parameter =
    { name : String
    , in_ : String
    , description : Maybe String
    , required : Bool
    , deprecated : Bool
    , allowEmptyValue : Bool

    --
    , style : Maybe String
    , explode : Bool
    , allowReserved : Bool
    , schema : Maybe Schema
    , example : Maybe String
    , examples : Dict String Example
    }


jsonDecoder : Json.Decoder Parameter
jsonDecoder =
    Json.succeed Parameter
        |> JsonField.required "name" Json.string
        |> JsonField.required "in" Json.string
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> JsonField.optional "required" Json.bool False
        |> JsonField.optional "deprecated" Json.bool False
        |> JsonField.optional "allowEmptyValue" Json.bool False
        |> JsonField.optional "style" (Json.nullable Json.string) Nothing
        |> JsonField.optional "explode" Json.bool True
        |> JsonField.optional "allowReserved" Json.bool False
        |> JsonField.optional "schema" (Json.nullable Schema.jsonDecoder) Nothing
        |> JsonField.optional "example" (Json.nullable Json.string) Nothing
        |> JsonField.optional "examples" (Json.dict Example.jsonDecoder) Dict.empty
