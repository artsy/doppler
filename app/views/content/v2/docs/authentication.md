[Public API Documentation](/v2) &gt; General &gt; Authentication

## Authentication

An authentication token is required to make API calls. A user account is not required, unless you want to perform actions on behalf of the user.

There're four ways to authenticate to the API:

* Using an XAPP Token obtained using a client application ID and secret without logging in.
* Logging in using an OAuth Token obtained via browser redirects.
* Logging in using an XAuth Token obtained using a client application ID, secret and a user's email and password.
* Logging in using an XAuth Token obtained from a user's OAuth Token, usually on a mobile device.

### Before Your Begin

First, create an application and obtain a client ID and secret by following the instructions in [Getting Started](/v2/start).

### Authenticate with an XAPP Token

This workflow is suitable for desktop or mobile clients. It allows anonymous logon to Artsy without any user access.

```
curl -v -X POST \
  #{ArtsyApi::V2.root}/tokens/xapp_token \
  -d client_id=[your client id] \
  -d client_secret=[your client secret]
```

Parameter     | Description                       |
-------------:|:----------------------------------|
client_id     | Your application's client ID.     |
client_secret | Your application's client secret. |

Note that you can also POST these parameters form-urlencoded in the body with the `application/x-www-form-urlencoded` content-type header, or as JSON, along with an `application/json` content-type.

The response from Artsy will be the following JSON.

```json
{
  "type" : "xapp_token",
  "token" : "...",
  "expires_at" : "2014-09-05T12:39:09.200Z"
}
```

Field         | Description                |
-------------:|:---------------------------|
type          | Always "xapp_token".       |
token         | Authentication token.      |
expires_at    | Token expiration date/time.|

Make requests by placing the token into an `X-Xapp-Token` header.

### Login using OAuth Web Browser Redirects

This is the preferred method for authenticating users and allows Artsy users to login to your application via Browser redirects. In this scenario Artsy acts as an OAuth provider. Users are prompted to trust your application and are notified about the host to which you are redirecting them.

``` alert[warning]
Currently there's no way to restrict the redirect addresses for your application and users are prompted to trust it every time they login. This will be implemented in the future.
```

Redirect users who wish to authenticate to the OAuth authorization url.

```
curl -v "#{ArtsyApi::V2.url}/oauth2/authorize?client_id=...&redirect_uri=...&response_type=code"
```

A logged in user will be redirected back to the url you have supplied, appending an authorization code `code=...`, eg. `https://[your redirect url]/?code=auth`.

Your server should make an OAuth2 POST request to the following url.

```
curl -v -X POST \
  #{ArtsyApi::V2.url}/oauth2/access_token \
  -d client_id=[your client id] \
  -d client_secret=[your client secret] \
  -d code=[code] \
  -d grant_type=authorization_code
```

Parameter     | Description                                 |
-------------:|:--------------------------------------------|
client_id     | Your application's client ID.               |
client_secret | Your application's client secret.           |
code          | Authorization code from the callback above. |
grant_type    | Set to "authorization_code".                |
state         | Optional state to include in the callback.  |
scope         | Optional authorization scope.               |

Set "scope" to "offline_access" to request a token that expires in 25 years instead of the standard 60 days.

The response from artsy.net will be a JSON containing an access token and an expiration date.

``` json
{
  "access_token" : "...",
  "expires_in" : "yyyy-mm-ddThh:mm:ss TZ"
}
```

Field         | Description                  |
-------------:|:-----------------------------|
access_token  | Authentication token.        |
expires_in    | Token expiration date/time.  |
state         | Optional state when present. |
scope         | Scope of access requested.   |

The value of "state" will be returned in the redirect URL for "authorize", the access token and error JSON.

Save the access token for this user in your database or persist it for the duration of the session.

Make requests by placing the token into an `X-Auth-Token` header.

In case of an error, the server will return an error JSON.

``` json
{
  "error" : "...",
  "error_description" : "..."
}
```

Field               | Description                   |
-------------------:|:------------------------------|
error               | OAuth 2 error code.           |
error_description   | Humanly readable description. |

### Login using an XAuth Token obtained from a User's Email and Password

If you store or prompt for the user's email and password, which is not recommended, you can obtain an OAuth token in exchange for those credentials.

```
curl -v -X POST \
  #{ArtsyApi::V2.url}/oauth2/access_token \
  -d client_id=[your client id] \
  -d client_secret=[your client secret] \
  -d grant_type=credentials \
  -d email=[user email] \
  -d password=[user password]
```

Parameter     | Description                                        |
-------------:|:---------------------------------------------------|
client_id     | Your application's client ID.                      |
client_secret | Your application's client secret.                  |
grant_type    | Set to "credentials".                              |
email         | User's email address.                              |
password      | User's password (avoid sending in a query string). |
scope         | Optional authorization scope.                      |

Set "scope" to "offline_access" to request a token that expires in 25 years instead of the standard 60 days.

The response from artsy.net will be a JSON containing an access token and an expiration date.

``` json
{
  "access_token" : "...",
  "expires_in" : "yyyy-mm-ddThh:mm:ss TZ"
}
```

Field         | Description                  |
-------------:|:-----------------------------|
access_token  | Authentication token.        |
expires_in    | Token expiration date/time.  |
scope         | Scope of access requested.   |

Make requests by placing the token into an `X-Auth-Token` header.

### Login using an XAuth Token obtained from a User's OAuth Token

If you have access to a user's social provider token (Facebook) or a social provider token and secret (Twitter), you can obtain an OAuth token in exchange for it.

```
curl -v -X POST \
  #{ArtsyApi::V2.url}/oauth2/access_token \
  -d client_id=[your client id] \
  -d client_secret=[your client secret] \
  -d grant_type=oauth_token \
  -d oauth_token=[token] \
  -d oauth_provider=[provider]
```

Parameter           | Description                                    |
-------------------:|:-----------------------------------------------|
client_id           | Your application's client ID.                  |
client_secret       | Your application's client secret.              |
grant_type          | Set to "oauth_token".                          |
oauth_token         | OAuth token obtained from Facebook or Twitter. |
oauth\_token_secret | OAuth token secret obtained from Twitter.      |
oauth_provider      | Either "facebook" or "twitter".                |
scope               | Optional authorization scope.                  |

Set "scope" as "offline_access" to request a token that expires in 25 years instead of the standard 60 days.

The response will be identical to the "credentials" grant type above.

### Expiring Tokens

You should offer users logout functionality and expire OAuth tokens obtained from the "oauth2/access_token" routes above by calling the following API.

```
curl -v -X DELETE \
  #{ArtsyApi::V2.root}/tokens/access_token \
  -d access_token=[access token]
```

Parameter           | Description                                                 |
-------------------:|:------------------------------------------------------------|
access_token        | Accesss token in a query string or the X-Auth-Token header. |

The response from Artsy will be the following JSON.

```json
{
  "id" : "...",
  "type" : "access_token",
  "token" : "...",
  "expired_at" : "2014-09-05T12:39:09.200Z"
}
```

Field         | Description                                           |
-------------:|:------------------------------------------------------|
id            | Expiration ID.                                        |
type          | Always "access_token".                                |
token         | Authentication token.                                 |
expired_at    | Date/time when the token expired, typically just now. |
