module OpenApi.RequestBody exposing (RequestBody, jsonDecoder)

import Dict exposing (Dict)
import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.MediaType as MediaType exposing (MediaType)



{- Request Body Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#request-body-object
-}


type alias RequestBody =
    { description : Maybe String
    , content : Dict String MediaType
    , required : Bool
    }


jsonDecoder : Json.Decoder RequestBody
jsonDecoder =
    Json.succeed RequestBody
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> JsonField.required "content" (Json.dict MediaType.jsonDecoder)
        |> JsonField.optional "required" Json.bool False
