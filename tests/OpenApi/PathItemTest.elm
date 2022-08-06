module OpenApi.PathItemTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Json.Decode as Json
import OpenApi.PathItem as PathItem exposing (PathItem)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the PathItem object"
        [ test "decode JSON" <|
            \_ ->
                jsonPathItem
                    |> Json.decodeString PathItem.jsonDecoder
                    |> Expect.Ok.andThen
                        (Expect.all
                            [ Expect.Optional.field .get
                            , Expect.Optional.listField .parameters
                            ]
                        )
        ]


jsonPathItem =
    """{
  "get": {
    "description": "Returns pets based on ID",
    "summary": "Find pets by ID",
    "operationId": "getPetsById",
    "responses": {
      "200": {
        "description": "pet response",
        "content": {
          "*/*": {
            "schema": {
              "type": "array",
              "items": {
                "$ref": "#/components/schemas/Pet"
              }
            }
          }
        }
      },
      "default": {
        "description": "error payload",
        "content": {
          "text/html": {
            "schema": {
              "$ref": "#/components/schemas/ErrorModel"
            }
          }
        }
      }
    }
  },
  "parameters": [
    {
      "name": "id",
      "in": "path",
      "description": "ID of pet to use",
      "required": true,
      "schema": {
        "type": "array",
        "items": {
          "type": "string"
        }
      },
      "style": "simple"
    }
  ]
}
"""


yamlPathItem =
    """get:
  description: Returns pets based on ID
  summary: Find pets by ID
  operationId: getPetsById
  responses:
    '200':
      description: pet response
      content:
        '*/*' :
          schema:
            type: array
            items:
              $ref: '#/components/schemas/Pet'
    default:
      description: error payload
      content:
        'text/html':
          schema:
            $ref: '#/components/schemas/ErrorModel'
parameters:
- name: id
  in: path
  description: ID of pet to use
  required: true
  schema:
    type: array
    items:
      type: string  
  style: simple
"""
