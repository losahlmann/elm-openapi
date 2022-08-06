module OpenApi.ContactTest exposing (..)

import Expect exposing (Expectation)
import Expect.Ok
import Expect.Optional
import Json.Decode as Json
import OpenApi.Contact as Contact exposing (Contact)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the Contact object"
        [ test "decode JSON" <|
            \_ ->
                jsonContact
                    |> Json.decodeString Contact.jsonDecoder
                    |> Expect.Ok.andThen
                        (Expect.all
                            [ Expect.Optional.field .name
                            , Expect.Optional.field .url
                            , Expect.Optional.field .email
                            ]
                        )
        ]


jsonContact =
    """{
  "name": "API Support",
  "url": "https://www.example.com/support",
  "email": "support@example.com"
}"""


yamlContact =
    """name: API Support
url: https://www.example.com/support
email: support@example.com"""
