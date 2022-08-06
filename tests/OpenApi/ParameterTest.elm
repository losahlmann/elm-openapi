module OpenApi.ParameterTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Expect.Required
import Json.Decode as Json
import OpenApi.Parameter as Parameter exposing (Parameter)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the Parameter object"
        [ test "decode JSON" <|
            \_ ->
                jsonParameter
                    |> Json.decodeString Parameter.jsonDecoder
                    |> Expect.Ok.andThen
                        (Expect.all
                            [ Expect.Required.stringField .name
                            , Expect.Required.stringField .in_
                            , Expect.Optional.field .description
                            , Expect.Optional.true .required
                            , Expect.Optional.field .schema
                            , Expect.Optional.field .style
                            ]
                        )
        ]


jsonParameter =
    """{
  "name": "token",
  "in": "header",
  "description": "token to be passed as a header",
  "required": true,
  "schema": {
    "type": "array",
    "items": {
      "type": "integer",
      "format": "int64"
    }
  },
  "style": "simple"
}"""


yamlParameter =
    """name: token
in: header
description: token to be passed as a header
required: true
schema:
  type: array
  items:
    type: integer
    format: int64
style: simple
"""



-- TODO: more examples
