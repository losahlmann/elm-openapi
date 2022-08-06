module OpenApi.SecuritySchemeTest exposing (..)

import Dict
import Expect exposing (Expectation)
import Expect.Ok
import Json.Decode as Json
import OpenApi.SecurityScheme as SecurityScheme exposing (SecurityScheme)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the SecurityScheme object"
        [ describe "Basic Authentication"
            [ test "decode JSON" <|
                \_ ->
                    jsonBasicAuthentication
                        |> Json.decodeString SecurityScheme.jsonDecoder
                        |> Expect.Ok.andThen
                            (Expect.equal <|
                                SecurityScheme.Http { scheme = "basic", description = Nothing, bearerFormat = Nothing }
                            )
            ]
        , describe "API Key"
            [ test "decode JSON" <|
                \_ ->
                    jsonApiKey
                        |> Json.decodeString SecurityScheme.jsonDecoder
                        |> Expect.Ok.andThen
                            (Expect.equal <|
                                SecurityScheme.ApiKey { name = "api_key", description = Nothing, in_ = "header" }
                            )
            ]
        , describe "JWT Bearer"
            [ test "decode JSON" <|
                \_ ->
                    jsonJwtBearer
                        |> Json.decodeString SecurityScheme.jsonDecoder
                        |> Expect.Ok.andThen
                            (Expect.equal <|
                                SecurityScheme.Http { scheme = "bearer", description = Nothing, bearerFormat = Just "JWT" }
                            )
            ]
        , describe "Implicit OAuth2"
            [ test "decode JSON" <|
                \_ ->
                    jsonImplicitOAuth2
                        |> Json.decodeString SecurityScheme.jsonDecoder
                        |> Expect.Ok.andThen
                            (Expect.equal <|
                                SecurityScheme.OAuth2
                                    { description = Nothing
                                    , flows =
                                        { implicit =
                                            Just
                                                { authorizationUrl = "https://example.com/api/oauth/dialog"
                                                , refreshUrl = Nothing
                                                , scopes =
                                                    Dict.fromList
                                                        [ ( "write:pets", "modify pets in your account" )
                                                        , ( "read:pets", "read your pets" )
                                                        ]
                                                }
                                        , password = Nothing
                                        , clientCredentials = Nothing
                                        , authorizationCode = Nothing
                                        }
                                    }
                            )
            ]
        ]


jsonBasicAuthentication =
    """{
  "type": "http",
  "scheme": "basic"
}
"""


yamlBasicAuthentication =
    """type: http
scheme: basic
"""


jsonApiKey =
    """{
  "type": "apiKey",
  "name": "api_key",
  "in": "header"
}
"""


yamlApiKey =
    """type: apiKey
name: api_key
in: header
"""


jsonJwtBearer =
    """{
  "type": "http",
  "scheme": "bearer",
  "bearerFormat": "JWT"
}
"""


yamlJwtBearer =
    """type: http
scheme: bearer
bearerFormat: JWT
"""


jsonImplicitOAuth2 =
    """{
  "type": "oauth2",
  "flows": {
    "implicit": {
      "authorizationUrl": "https://example.com/api/oauth/dialog",
      "scopes": {
        "write:pets": "modify pets in your account",
        "read:pets": "read your pets"
      }
    }
  }
}
"""


yamlImplicitOAuth2 =
    """type: oauth2
flows: 
  implicit:
    authorizationUrl: https://example.com/api/oauth/dialog
    scopes:
      write:pets: modify pets in your account
      read:pets: read your pets
"""
