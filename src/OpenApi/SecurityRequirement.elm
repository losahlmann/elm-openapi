module OpenApi.SecurityRequirement exposing (SecurityRequirement(..), jsonDecoder)

import Dict
import Json.Decode as Json



{- Security requirement Object
   as in v3.1.0 of the OpenAPI Specification
   https://spec.openapis.org/oas/v3.1.0.html#security-requirement-object
-}
-- TODO: this data model is not yet correctly representing optional/required


type SecurityRequirement
    = Optional
    | Required { name : String, scopes : List String }


jsonDecoder : Json.Decoder SecurityRequirement
jsonDecoder =
    Json.dict (Json.list Json.string)
        |> Json.andThen
            (\entries ->
                case entries |> Dict.toList of
                    [] ->
                        Json.succeed <| Optional

                    [ ( name, scopes ) ] ->
                        Json.succeed <| Required { name = name, scopes = scopes }

                    _ ->
                        Json.fail "Expected Security Requirement with a single entry"
            )
