module OpenApi.ResponseTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Expect.Required
import Json.Decode as Json
import OpenApi.Response as Response exposing (Response)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the Response object"
        [ describe "Response of an array of a complex type"
            [ test "decode JSON" <|
                \_ ->
                    jsonResponse
                        |> Json.decodeString Response.jsonDecoder
                        |> Expect.Ok.andThen
                            (Expect.all
                                [ Expect.Required.stringField .description
                                , Expect.Optional.dictField .content
                                ]
                            )
            ]
        , describe "Response with a string type"
            [ test "decode JSON" <|
                \_ ->
                    jsonResponseStringType
                        |> Json.decodeString Response.jsonDecoder
                        |> Expect.Ok.andThen
                            (Expect.all
                                [ Expect.Required.stringField .description
                                , Expect.Optional.dictField .content
                                ]
                            )
            ]
        , describe "Plain text response with headers"
            [ test "decode JSON" <|
                \_ ->
                    jsonResponsePlainTextWithHeaders
                        |> Json.decodeString Response.jsonDecoder
                        |> Expect.Ok.andThen
                            (Expect.all
                                [ Expect.Required.stringField .description
                                , Expect.Optional.dictField .content
                                , Expect.Optional.dictField .headers
                                ]
                            )
            ]
        , describe "Response with no return value"
            [ test "decode JSON" <|
                \_ ->
                    jsonResponseNoReturnValue
                        |> Json.decodeString Response.jsonDecoder
                        |> Expect.Ok.andThen
                            (Expect.all
                                [ Expect.Required.stringField .description
                                ]
                            )
            ]
        ]


jsonResponse =
    """{
  "description": "A complex object array response",
  "content": {
    "application/json": {
      "schema": {
        "type": "array",
        "items": {
          "$ref": "#/components/schemas/VeryComplexType"
        }
      }
    }
  }
}"""


yamlResponse =
    """description: A complex object array response
content: 
  application/json:
    schema: 
      type: array
      items:
        $ref: '#/components/schemas/VeryComplexType'
"""


jsonResponseStringType =
    """{
  "description": "A simple string response",
  "content": {
    "text/plain": {
      "schema": {
        "type": "string"
      }
    }
  }
}
"""


yamlResponseStringType =
    """description: A simple string response
content:
  text/plain:
    schema:
      type: string
"""


jsonResponsePlainTextWithHeaders =
    """{
  "description": "A simple string response",
  "content": {
    "text/plain": {
      "schema": {
        "type": "string",
        "example": "whoa!"
      }
    }
  },
  "headers": {
    "X-Rate-Limit-Limit": {
      "description": "The number of allowed requests in the current period",
      "schema": {
        "type": "integer"
      }
    },
    "X-Rate-Limit-Remaining": {
      "description": "The number of remaining requests in the current period",
      "schema": {
        "type": "integer"
      }
    },
    "X-Rate-Limit-Reset": {
      "description": "The number of seconds left in the current period",
      "schema": {
        "type": "integer"
      }
    }
  }
}
"""


yamlResponsePlainTextWithHeaders =
    """description: A simple string response
content:
  text/plain:
    schema:
      type: string
    example: 'whoa!'
headers:
  X-Rate-Limit-Limit:
    description: The number of allowed requests in the current period
    schema:
      type: integer
  X-Rate-Limit-Remaining:
    description: The number of remaining requests in the current period
    schema:
      type: integer
  X-Rate-Limit-Reset:
    description: The number of seconds left in the current period
    schema:
      type: integer
"""


jsonResponseNoReturnValue =
    """{
  "description": "object created"
}
"""


yamlResponseNoReturnValue =
    """description: object created"""
