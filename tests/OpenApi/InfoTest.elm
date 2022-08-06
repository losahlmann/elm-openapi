module OpenApi.InfoTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Expect.Required
import Json.Decode as Json
import OpenApi.Info as Info exposing (Info)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the Info object"
        [ test "decode JSON" <|
            \_ ->
                jsonInfo
                    |> Json.decodeString Info.jsonDecoder
                    |> Expect.Ok.andThen
                        (Expect.all
                            [ Expect.Required.stringField .title
                            , Expect.Optional.field .summary
                            , Expect.Optional.field .description
                            , Expect.Optional.field .termsOfService
                            , Expect.Optional.field .contact
                            , Expect.Optional.field .license
                            , Expect.Required.stringField .version
                            ]
                        )
        ]


jsonInfo =
    """{
  "title": "Sample Pet Store App",
  "summary": "A pet store manager.",
  "description": "This is a sample server for a pet store.",
  "termsOfService": "https://example.com/terms/",
  "contact": {
    "name": "API Support",
    "url": "https://www.example.com/support",
    "email": "support@example.com"
  },
  "license": {
    "name": "Apache 2.0",
    "url": "https://www.apache.org/licenses/LICENSE-2.0.html"
  },
  "version": "1.0.1"
}"""


yamlInfo =
    """title: Sample Pet Store App
summary: A pet store manager.
description: This is a sample server for a pet store.
termsOfService: https://example.com/terms/
contact:
  name: API Support
  url: https://www.example.com/support
  email: support@example.com
license:
  name: Apache 2.0
  url: https://www.apache.org/licenses/LICENSE-2.0.html
version: 1.0.1"""
