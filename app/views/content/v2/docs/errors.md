[Public API Documentation](/v2) &gt; General &gt; Errors

## Errors

### 400 Errors

The API returns errors in JSON format along with HTTP 40x status codes.

#### Error Fields

Key           | Description                                        |
-------------:|:---------------------------------------------------|
type          | Error type.                                        |
message       | Humanly readable error message.                    |
detail        | Additional detail specific to an error type.       |

#### Examples

An access denied error.

``` json
{
  "type" : "auth_error",
  "message" : "The access token is invalid or has expired."
}
```

An artist not found error.

``` json
{
  "type" : "other_error",
  "message" : "Artist Not Found"
}
```

A parameter validation error.

``` json
{
  "type" : "param_error",
  "message" : "Email can't be blank, Email is invalid, Password can't be blank.",
  "detail" : {
    "email" : ["can't be blank", "is invalid"],
    "password" : ["can't be blank"]
  }
}
```

### 429 Errors

The API will return an HTTP 429 `Too many requests` error when your client is over the rate limit. See [Rate Limiting](/v2/docs/rate_limiting) for more information.

### 500 Errors

Internal server errors in the 50x range are not expected. Please [report](/help) any 50x errors.

### 401 Broadway

The API has an easter egg, we'd love it for you to find it! You can get `401 Broadway`, which is the address of the [Artsy HQ in NYC](http://artsy.net/about), instead of `401 Unauthorized`. Happy hunting.
