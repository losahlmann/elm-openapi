module OpenApi.RequestBodyTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Json.Decode as Json
import OpenApi.RequestBody as RequestBody exposing (RequestBody)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the RequestBody object"
        [ test "decode JSON" <|
            \_ ->
                jsonRequestBody
                    |> Json.decodeString RequestBody.jsonDecoder
                    |> Expect.Ok.andThen
                        (Expect.all
                            [ Expect.Optional.field .description
                            , Expect.Optional.dictField .content
                            , Expect.Optional.false .required
                            ]
                        )
        ]


jsonRequestBody =
    """{
  "description": "user to add to the system",
  "content": {
    "application/json": {
      "schema": {
        "$ref": "#/components/schemas/User"
      },
      "examples": {
          "user" : {
            "summary": "User Example", 
            "externalValue": "https://foo.bar/examples/user-example.json"
          } 
        }
    },
    "application/xml": {
      "schema": {
        "$ref": "#/components/schemas/User"
      },
      "examples": {
          "user" : {
            "summary": "User example in XML",
            "externalValue": "https://foo.bar/examples/user-example.xml"
          }
        }
    },
    "text/plain": {
      "examples": {
        "user" : {
            "summary": "User example in Plain text",
            "externalValue": "https://foo.bar/examples/user-example.txt" 
        }
      } 
    },
    "*/*": {
      "examples": {
        "user" : {
            "summary": "User example in other format",
            "externalValue": "https://foo.bar/examples/user-example.whatever"
        }
      }
    }
  }
}"""


yamlRequestBody =
    """description: user to add to the system
content: 
  'application/json':
    schema:
      $ref: '#/components/schemas/User'
    examples:
      user:
        summary: User Example
        externalValue: 'https://foo.bar/examples/user-example.json'
  'application/xml':
    schema:
      $ref: '#/components/schemas/User'
    examples:
      user:
        summary: User example in XML
        externalValue: 'https://foo.bar/examples/user-example.xml'
  'text/plain':
    examples:
      user:
        summary: User example in Plain text
        externalValue: 'https://foo.bar/examples/user-example.txt'
  '*/*':
    examples:
      user: 
        summary: User example in other format
        externalValue: 'https://foo.bar/examples/user-example.whatever'
"""



-- TODO: more tests


jsonRequestBodyArray =
    """{
  "description": "user to add to the system",
  "required": true,
  "content": {
    "text/plain": {
      "schema": {
        "type": "array",
        "items": {
          "type": "string"
        }
      }
    }
  }
}
"""


yamlRequestBodyArray =
    """description: user to add to the system
required: true
content:
  text/plain:
    schema:
      type: array
      items:
        type: string
"""
