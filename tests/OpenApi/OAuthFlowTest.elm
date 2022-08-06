module OpenApi.OAuthFlowTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Expect.Required
import Json.Decode as Json
import OpenApi.OAuthFlow as OAuthFlow
import Test exposing (..)


suite : Test
suite =
    describe "Parse the OAuthFlow object"
        [ test "decode JSON" <|
            \_ ->
                jsonOAuthFlow
                    -- TODO: test "authorizationCode"
                    |> Json.decodeString (Json.at [ "flows", "implicit" ] OAuthFlow.jsonImplicitFlowDecoder)
                    |> Expect.Ok.andThen
                        (Expect.all
                            [ Expect.Required.stringField .authorizationUrl
                            , Expect.Optional.dictField .scopes -- TODO: scopes is Required?
                            ]
                        )
        ]


jsonOAuthFlow =
    """{
  "type": "oauth2",
  "flows": {
    "implicit": {
      "authorizationUrl": "https://example.com/api/oauth/dialog",
      "scopes": {
        "write:pets": "modify pets in your account",
        "read:pets": "read your pets"
      }
    },
    "authorizationCode": {
      "authorizationUrl": "https://example.com/api/oauth/dialog",
      "tokenUrl": "https://example.com/api/oauth/token",
      "scopes": {
        "write:pets": "modify pets in your account",
        "read:pets": "read your pets"
      }
    }
  }
}
"""


yamlOAuthFlow =
    """type: oauth2
flows: 
  implicit:
    authorizationUrl: https://example.com/api/oauth/dialog
    scopes:
      write:pets: modify pets in your account
      read:pets: read your pets
  authorizationCode:
    authorizationUrl: https://example.com/api/oauth/dialog
    tokenUrl: https://example.com/api/oauth/token
    scopes:
      write:pets: modify pets in your account
      read:pets: read your pets 
"""
