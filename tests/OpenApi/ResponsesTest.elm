module OpenApi.ResponsesTest exposing (..)

import Expect exposing (Expectation)
import Expect.Dict
import Expect.Ok
import Json.Decode as Json
import OpenApi.Responses as Responses exposing (Responses)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the Responses object"
        [ test "decode JSON" <|
            \_ ->
                jsonResponses
                    |> Json.decodeString Responses.jsonDecoder
                    |> Expect.Ok.andThen
                        (Expect.all
                            [ Expect.Dict.key "default"
                            , Expect.Dict.key "200"
                            ]
                        )
        ]


jsonResponses =
    """{
  "200": {
    "description": "a pet to be returned",
    "content": {
      "application/json": {
        "schema": {
          "$ref": "#/components/schemas/Pet"
        }
      }
    }
  },
  "default": {
    "description": "Unexpected error",
    "content": {
      "application/json": {
        "schema": {
          "$ref": "#/components/schemas/ErrorModel"
        }
      }
    }
  }
}"""


yamlResponses =
    """'200':
  description: a pet to be returned
  content: 
    application/json:
      schema:
        $ref: '#/components/schemas/Pet'
default:
  description: Unexpected error
  content:
    application/json:
      schema:
        $ref: '#/components/schemas/ErrorModel'
"""
