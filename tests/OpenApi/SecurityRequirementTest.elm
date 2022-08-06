module OpenApi.SecurityRequirementTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Json.Decode as Json
import OpenApi.SecurityRequirement as SecurityRequirement exposing (SecurityRequirement)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the SecurityRequirement object"
        [ describe "Non-OAuth2 Security requirement"
            [ test "decode JSON" <|
                \_ ->
                    jsonNonOauth2SecurityRequirement
                        |> Json.decodeString SecurityRequirement.jsonDecoder
                        |> Expect.Ok.andThen
                            (Expect.equal <|
                                SecurityRequirement.Required
                                    { name = "api_key"
                                    , scopes = []
                                    }
                            )
            ]
        , describe "OAuth2 Security requirement"
            [ test "decode JSON" <|
                \_ ->
                    jsonOauth2SecurityRequirement
                        |> Json.decodeString SecurityRequirement.jsonDecoder
                        |> Expect.Ok.andThen
                            (Expect.equal <|
                                SecurityRequirement.Required
                                    { name = "petstore_auth"
                                    , scopes = [ "write:pets", "read:pets" ]
                                    }
                            )
            ]
        , describe "Optional OAuth2 Security requirement"
            [ test "decode JSON" <|
                \_ ->
                    jsonOptionalOauth2SecurityRequirement
                        |> Json.decodeString (Json.field "security" (Json.list SecurityRequirement.jsonDecoder))
                        |> Expect.Ok.andThen
                            (Expect.equal
                                [ SecurityRequirement.Optional
                                , SecurityRequirement.Required
                                    { name = "petstore_auth"
                                    , scopes = [ "write:pets", "read:pets" ]
                                    }
                                ]
                            )
            ]
        ]


jsonNonOauth2SecurityRequirement =
    """{
  "api_key": []
}
"""


yamlNonOauth2SecurityRequirement =
    """api_key: []"""


jsonOauth2SecurityRequirement =
    """{
  "petstore_auth": [
    "write:pets",
    "read:pets"
  ]
}
"""


yamlOauth2SecurityRequirement =
    """petstore_auth:
- write:pets
- read:pets
"""


jsonOptionalOauth2SecurityRequirement =
    """{
  "security": [
    {},
    {
      "petstore_auth": [
        "write:pets",
        "read:pets"
      ]
    }
  ]
}
"""


yamlOptionalOauth2SecurityRequirement =
    """security:
  - {}
  - petstore_auth:
    - write:pets
    - read:pets
"""
