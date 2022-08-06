module OpenApi.OAuthFlows exposing (OAuthFlows, jsonDecoder)

import Json.Decode as Json
import Json.Decode.Pipeline as JsonField
import OpenApi.OAuthFlow as OAuthFlow exposing (AuthorizationCodeFlow, ClientCredentialsFlow, ImplicitFlow, PasswordFlow)



{- OAuth Flows Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#oauth-flows-object
-}


type alias OAuthFlows =
    { implicit : Maybe ImplicitFlow
    , password : Maybe PasswordFlow
    , clientCredentials : Maybe ClientCredentialsFlow
    , authorizationCode : Maybe AuthorizationCodeFlow
    }


jsonDecoder : Json.Decoder OAuthFlows
jsonDecoder =
    Json.succeed OAuthFlows
        |> JsonField.optional "implicit" (Json.nullable OAuthFlow.jsonImplicitFlowDecoder) Nothing
        |> JsonField.optional "password" (Json.nullable OAuthFlow.jsonPasswordFlowDecoder) Nothing
        |> JsonField.optional "clientCredentials" (Json.nullable OAuthFlow.jsonClientCredentialsFlowDecoder) Nothing
        |> JsonField.optional "authorizationCode" (Json.nullable OAuthFlow.jsonAuthorizationCodeFlowDecoder) Nothing
