module OpenApi.PathsTest exposing (..)

import Dict
import Expect exposing (Expectation)
import Expect.Ok
import Json.Decode as Json
import OpenApi.Paths as Paths exposing (Paths)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the Paths object"
        [ test "decode JSON" <|
            \_ ->
                jsonPaths
                    |> Json.decodeString Paths.jsonDecoder
                    |> Expect.Ok.andThen
                        (Dict.isEmpty >> Expect.false "Expect path '/pets'")
        ]


jsonPaths =
    """{
  "/pets": {
    "get": {
      "description": "Returns all pets from the system that the user has access to",
      "responses": {
        "200": {          
          "description": "A list of pets.",
          "content": {
            "application/json": {
              "schema": {
                "type": "array",
                "items": {
                  "$ref": "#/components/schemas/pet"
                }
              }
            }
          }
        }
      }
    }
  }
}"""


yamlPaths =
    """/pets:
  get:
    description: Returns all pets from the system that the user has access to
    responses:
      '200':
        description: A list of pets.
        content:
          application/json:
            schema:
              type: array
              items:
                $ref: '#/components/schemas/pet'
"""
