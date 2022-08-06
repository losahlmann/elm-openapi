module OpenApi.ExternalDocumentationTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Expect.Required
import Json.Decode as Json
import OpenApi.ExternalDocumentation as ExternalDocumentation exposing (ExternalDocumentation)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the ExternalDocumentation object"
        [ test "decode JSON" <|
            \_ ->
                jsonExternalDocumentation
                    |> Json.decodeString ExternalDocumentation.jsonDecoder
                    |> Expect.Ok.andThen
                        (Expect.all
                            [ Expect.Required.stringField .url
                            , Expect.Optional.field .description
                            ]
                        )
        ]


jsonExternalDocumentation =
    """{
  "description": "Find more info here",
  "url": "https://example.com"
}"""


yamlExternalDocumentation =
    """description: Find more info here
url: https://example.com"""
