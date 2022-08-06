module OpenApi.TagTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Expect.Required
import Json.Decode as Json
import OpenApi.Tag as Tag exposing (Tag)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the Tag object"
        [ test "decode JSON" <|
            \_ ->
                jsonTag
                    |> Json.decodeString Tag.jsonDecoder
                    |> Expect.Ok.andThen
                        (Expect.all
                            [ Expect.Required.stringField .name
                            , Expect.Optional.field .description
                            , Expect.Optional.emptyField .externalDocs
                            ]
                        )
        ]


jsonTag =
    """{
    "name": "pet",
    "description": "Pets operations"
}
"""


yamlTag =
    """name: pet
description: Pets operations
"""
