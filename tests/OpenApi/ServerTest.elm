module OpenApi.ServerTest exposing (..)

import Expect exposing (Expectation)
import Expect.List
import Expect.Ok
import Expect.Optional
import Expect.Required
import Json.Decode as Json
import OpenApi.Server as Server exposing (Server)
import Test exposing (..)


suite : Test
suite =
    describe "Parse the Server object"
        [ describe "Parse a single Server object"
            [ test "decode JSON" <|
                \_ ->
                    jsonServer
                        |> Json.decodeString Server.jsonDecoder
                        |> Expect.Ok.andThen
                            (Expect.all
                                [ Expect.Required.stringField .url
                                , Expect.Optional.field .description
                                , Expect.Optional.emptyDict .variables
                                ]
                            )
            ]
        , describe "Parse list of multiple Server objects"
            [ test "decode JSON" <|
                \_ ->
                    jsonMultipleServers
                        |> Json.decodeString (Json.field "servers" <| Json.list <| Server.jsonDecoder)
                        |> Expect.Ok.andThen
                            (Expect.List.forEach <|
                                Expect.all
                                    [ Expect.Required.stringField .url
                                    , Expect.Optional.field .description
                                    , Expect.Optional.emptyDict .variables
                                    ]
                            )
            ]
        , describe "Parse the Server object with Server Variables"
            [ test "decode JSON" <|
                \_ ->
                    jsonConfiguredServer
                        |> Json.decodeString (Json.field "servers" <| Json.list <| Server.jsonDecoder)
                        |> Expect.Ok.andThen
                            (Expect.List.forEach <|
                                Expect.all
                                    [ Expect.Required.stringField .url
                                    , Expect.Optional.field .description
                                    , Expect.Optional.dictField .variables
                                    ]
                            )
            ]
        ]


jsonServer =
    """{
  "url": "https://development.gigantic-server.com/v1",
  "description": "Development server"
}"""


yamlServer =
    """url: https://development.gigantic-server.com/v1
description: Development server
"""



-- multiple servers


jsonMultipleServers =
    """{
  "servers": [
    {
      "url": "https://development.gigantic-server.com/v1",
      "description": "Development server"
    },
    {
      "url": "https://staging.gigantic-server.com/v1",
      "description": "Staging server"
    },
    {
      "url": "https://api.gigantic-server.com/v1",
      "description": "Production server"
    }
  ]
}"""


yamlMultipleServers =
    """servers:
- url: https://development.gigantic-server.com/v1
  description: Development server
- url: https://staging.gigantic-server.com/v1
  description: Staging server
- url: https://api.gigantic-server.com/v1
  description: Production server
"""



-- server with variable configuration


jsonConfiguredServer =
    """{
  "servers": [
    {
      "url": "https://{username}.gigantic-server.com:{port}/{basePath}",
      "description": "The production API server",
      "variables": {
        "username": {
          "default": "demo",
          "description": "this value is assigned by the service provider, in this example `gigantic-server.com`"
        },
        "port": {
          "enum": [
            "8443",
            "443"
          ],
          "default": "8443"
        },
        "basePath": {
          "default": "v2"
        }
      }
    }
  ]
}"""


yamlConfiguredServer =
    """servers:
- url: https://{username}.gigantic-server.com:{port}/{basePath}
  description: The production API server
  variables:
    username:
      # note! no enum here means it is an open value
      default: demo
      description: this value is assigned by the service provider, in this example `gigantic-server.com`
    port:
      enum:
        - '8443'
        - '443'
      default: '8443'
    basePath:
      # open meaning there is the opportunity to use special base paths as assigned by the provider, default is `v2`
      default: v2
"""
