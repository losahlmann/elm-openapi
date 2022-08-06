module OpenApi.LicenseTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Expect.Required
import Json.Decode as Json
import OpenApi.License as License exposing (License)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the License object"
        [ test "decode JSON" <|
            \_ ->
                jsonLicense
                    |> Json.decodeString License.jsonDecoder
                    |> Expect.Ok.andThen
                        (Expect.all
                            [ Expect.Required.stringField .name
                            , Expect.Optional.field .identifier
                            , Expect.Optional.emptyField .url
                            ]
                        )
        ]


jsonLicense =
    """{
  "name": "Apache 2.0",
  "identifier": "Apache-2.0"
}"""


yamlLicense =
    """name: Apache 2.0
identifier: Apache-2.0"""
