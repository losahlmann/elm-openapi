module OpenApi.SchemaTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Expect.Required
import Json.Decode as Json
import Json.Schema.Definitions as JsonSchema
import OpenApi.Schema as Schema exposing (Schema)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the JSON Schema"
        [ test "decode schema" <|
            \_ ->
                jsonSchema
                    |> Json.decodeString Schema.jsonDecoder
                    |> Result.withDefault JsonSchema.blankSchema
                    |> unwrapObjectSchema
                    |> .properties
                    |> Maybe.map getProperties
                    |> Maybe.withDefault []
                    |> List.map
                        (Tuple.mapSecond <|
                            unwrapObjectSchema
                                >> .type_
                                >> typeToString
                        )
                    |> Expect.equal
                        [ ( "blueprint", "string" )
                        , ( "teamId", "integer" )
                        , ( "scheduling", "string" )
                        , ( "folderId", "integer" )
                        , ( "basedon", "integer" )
                        ]
        ]


jsonSchema =
    """{
        "type": "object",
        "properties": {
            "blueprint": {
                "type": "string",
                "description": "The scenario blueprint. To save resources, the blueprint is sent as a string, not as an object."
            },
            "teamId": {
                "type": "integer",
                "description": "The unique ID of the team in which the scenario will be created."
            },
            "scheduling": {
                "type": "string",
                "description": "The scenario scheduling details. To save resources, the scheduling details are sent as a string, not as an object."
            },
            "folderId": {
                "type": "integer",
                "description": "The unique ID of the folder in which you want to store created scenario."
            },
            "basedon": {
                "type": "integer",
                "description": "Defines if the scenario is created based on a template. The value is the template ID."
            }
        },
        "required": [
            "blueprint",
            "teamId",
            "scheduling"
        ]
    }"""


unwrapObjectSchema : JsonSchema.Schema -> JsonSchema.SubSchema
unwrapObjectSchema schema =
    case schema of
        JsonSchema.ObjectSchema subSchema ->
            subSchema

        _ ->
            JsonSchema.blankSubSchema


getProperties : JsonSchema.Schemata -> List ( String, JsonSchema.Schema )
getProperties (JsonSchema.Schemata properties) =
    properties


typeToString : JsonSchema.Type -> String
typeToString st =
    case st of
        JsonSchema.SingleType JsonSchema.StringType ->
            "string"

        JsonSchema.SingleType JsonSchema.IntegerType ->
            "integer"

        JsonSchema.SingleType JsonSchema.NumberType ->
            "number"

        JsonSchema.SingleType JsonSchema.BooleanType ->
            "boolean"

        JsonSchema.SingleType JsonSchema.ObjectType ->
            "object"

        JsonSchema.SingleType JsonSchema.ArrayType ->
            "array"

        JsonSchema.SingleType JsonSchema.NullType ->
            "null"

        _ ->
            ""
