module OpenApi.MediaTypeTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Json.Decode as Json
import OpenApi.MediaType as MediaType exposing (MediaType)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the MediaType object"
        [ test "decode JSON" <|
            \_ ->
                jsonMediaType
                    |> Json.decodeString (Json.field "application/json" MediaType.jsonDecoder)
                    |> Expect.Ok.andThen
                        (Expect.all
                            [ Expect.Optional.field .schema
                            , Expect.Optional.dictField .examples
                            , Expect.Optional.emptyDict .encoding
                            ]
                        )
        ]


jsonMediaType =
    """{
  "application/json": {
    "schema": {
         "$ref": "#/components/schemas/Pet"
    },
    "examples": {
      "cat" : {
        "summary": "An example of a cat",
        "value": 
          {
            "name": "Fluffy",
            "petType": "Cat",
            "color": "White",
            "gender": "male",
            "breed": "Persian"
          }
      },
      "dog": {
        "summary": "An example of a dog with a cat's name",
        "value" :  { 
          "name": "Puma",
          "petType": "Dog",
          "color": "Black",
          "gender": "Female",
          "breed": "Mixed"
        },
      "frog": {
          "$ref": "#/components/examples/frog-example"
        }
      }
    }
  }
}"""


yamlMediaType =
    """application/json: 
  schema:
    $ref: "#/components/schemas/Pet"
  examples:
    cat:
      summary: An example of a cat
      value:
        name: Fluffy
        petType: Cat
        color: White
        gender: male
        breed: Persian
    dog:
      summary: An example of a dog with a cat's name
      value:
        name: Puma
        petType: Dog
        color: Black
        gender: Female
        breed: Mixed
    frog:
      $ref: "#/components/examples/frog-example"
"""
