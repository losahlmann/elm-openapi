module OpenApi.Response exposing (Response, jsonDecoder)

import Dict exposing (Dict)
import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.Header as Header exposing (Header)
import OpenApi.Link as Link exposing (Link)
import OpenApi.MediaType as MediaType exposing (MediaType)



{- Response Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#response-object
-}


type alias Response =
    { description : String
    , headers : Dict String Header
    , content : Dict String MediaType
    , links : Dict String Link
    }


jsonDecoder : Json.Decoder Response
jsonDecoder =
    Json.succeed Response
        |> JsonField.required "description" Json.string
        |> JsonField.optional "headers" (Json.dict Header.jsonDecoder) Dict.empty
        |> JsonField.optional "content" (Json.dict MediaType.jsonDecoder) Dict.empty
        |> JsonField.optional "links" (Json.dict Link.jsonDecoder) Dict.empty
