module OpenApi.HeaderTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Json.Decode as Json
import OpenApi.Header as Header exposing (Header)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the Header object"
        [ test "decode JSON" <|
            \_ ->
                jsonHeader
                    |> Json.decodeString Header.jsonDecoder
                    |> Expect.Ok.andThen
                        (Expect.all
                            [ Expect.Optional.field .description
                            , Expect.Optional.field .schema
                            ]
                        )
        ]


jsonHeader =
    """{
  "description": "The number of allowed requests in the current period",
  "schema": {
    "type": "integer"
  }
}"""


yamlHeader =
    """description: The number of allowed requests in the current period
schema:
  type: integer
"""
