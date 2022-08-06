module OpenApi.OAuthFlow exposing (AuthorizationCodeFlow, ClientCredentialsFlow, ImplicitFlow, PasswordFlow, jsonAuthorizationCodeFlowDecoder, jsonClientCredentialsFlowDecoder, jsonImplicitFlowDecoder, jsonPasswordFlowDecoder)

import Dict exposing (Dict)
import Json.Decode as Json
import Json.Decode.Pipeline as JsonField



{- OAuth Flow Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#oauth-flow-object
-}


type alias ImplicitFlow =
    { authorizationUrl : String -- TODO: type URL
    , refreshUrl : Maybe String -- TODO: type URL
    , scopes : Dict String String
    }


jsonImplicitFlowDecoder : Json.Decoder ImplicitFlow
jsonImplicitFlowDecoder =
    Json.succeed ImplicitFlow
        |> JsonField.required "authorizationUrl" Json.string
        |> JsonField.optional "refreshUrl" (Json.nullable Json.string) Nothing
        |> JsonField.optional "scopes" (Json.dict Json.string) Dict.empty


type alias PasswordFlow =
    { tokenUrl : String -- TODO: type URL
    , refreshUrl : Maybe String -- TODO: type URL
    , scopes : Dict String String
    }


jsonPasswordFlowDecoder : Json.Decoder PasswordFlow
jsonPasswordFlowDecoder =
    Json.succeed PasswordFlow
        |> JsonField.required "tokenUrl" Json.string
        |> JsonField.optional "refreshUrl" (Json.nullable Json.string) Nothing
        |> JsonField.optional "scopes" (Json.dict Json.string) Dict.empty


type alias ClientCredentialsFlow =
    { tokenUrl : String -- TODO: type URL
    , refreshUrl : Maybe String -- TODO: type URL
    , scopes : Dict String String
    }


jsonClientCredentialsFlowDecoder : Json.Decoder ClientCredentialsFlow
jsonClientCredentialsFlowDecoder =
    Json.succeed ClientCredentialsFlow
        |> JsonField.required "tokenUrl" Json.string
        |> JsonField.optional "refreshUrl" (Json.nullable Json.string) Nothing
        |> JsonField.optional "scopes" (Json.dict Json.string) Dict.empty


type alias AuthorizationCodeFlow =
    { authorizationUrl : String -- TODO: type URL
    , tokenUrl : String -- TODO: type URL
    , refreshUrl : Maybe String -- TODO: type URL
    , scopes : Dict String String
    }


jsonAuthorizationCodeFlowDecoder : Json.Decoder AuthorizationCodeFlow
jsonAuthorizationCodeFlowDecoder =
    Json.succeed AuthorizationCodeFlow
        |> JsonField.required "authorizationUrl" Json.string
        |> JsonField.required "tokenUrl" Json.string
        |> JsonField.optional "refreshUrl" (Json.nullable Json.string) Nothing
        |> JsonField.optional "scopes" (Json.dict Json.string) Dict.empty
