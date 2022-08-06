module OpenApi.SecurityScheme exposing (SecurityScheme(..), jsonDecoder)

import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.OAuthFlows as OAuthFlows exposing (OAuthFlows)



{- Security Scheme Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#security-scheme-object
-}


type SecurityScheme
    = ApiKey ApiKeyData
    | Http HttpData
    | MutualTls MutualTlsData
    | OAuth2 OAuth2Data
    | OpenIdConnect OpenIdConnectData


type alias ApiKeyData =
    { description : Maybe String
    , name : String
    , in_ : String -- TODO: Valid values are "query", "header" or "cookie"
    }


type alias HttpData =
    { description : Maybe String
    , scheme : String
    , bearerFormat : Maybe String
    }


type alias MutualTlsData =
    { description : Maybe String
    }


type alias OAuth2Data =
    { description : Maybe String
    , flows : OAuthFlows
    }


type alias OpenIdConnectData =
    { description : Maybe String
    , openIdConnectUrl : String -- TODO: type URL
    }


jsonDecoder : Json.Decoder SecurityScheme
jsonDecoder =
    --Json.oneOf [ apiKeyDecoder, httpDecoder, openIdConnectDecoder ]
    Json.field "type" Json.string
        |> Json.andThen
            (\type_ ->
                case type_ of
                    "apiKey" ->
                        apiKeyDecoder

                    "http" ->
                        httpDecoder

                    "mutualTLS" ->
                        mutualTlsDecoder

                    "oauth2" ->
                        oauth2Decoder

                    "openIdConnect" ->
                        openIdConnectDecoder

                    _ ->
                        Json.fail ("Trying to decode SecurityScheme of type " ++ type_)
            )


apiKeyDecoder : Json.Decoder SecurityScheme
apiKeyDecoder =
    Json.succeed ApiKeyData
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> JsonField.required "name" Json.string
        |> JsonField.required "in" Json.string
        |> Json.map ApiKey


httpDecoder : Json.Decoder SecurityScheme
httpDecoder =
    Json.succeed HttpData
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> JsonField.required "scheme" Json.string
        |> JsonField.optional "bearerFormat" (Json.nullable Json.string) Nothing
        |> Json.map Http


mutualTlsDecoder : Json.Decoder SecurityScheme
mutualTlsDecoder =
    Json.succeed MutualTlsData
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> Json.map MutualTls


oauth2Decoder : Json.Decoder SecurityScheme
oauth2Decoder =
    Json.succeed OAuth2Data
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> JsonField.required "flows" OAuthFlows.jsonDecoder
        |> Json.map OAuth2


openIdConnectDecoder : Json.Decoder SecurityScheme
openIdConnectDecoder =
    Json.succeed OpenIdConnectData
        |> JsonField.optional "description" (Json.nullable Json.string) Nothing
        |> JsonField.required "openIdConnectUrl" Json.string
        |> Json.map OpenIdConnect
