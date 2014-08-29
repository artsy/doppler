## Authentication

An authentication token is required to make API calls. A user account is not required, unless you want to perform actions on behalf of the user.

There're four ways to authenticate to the API:

* Using an XAPP Token obtained using a client application ID and secret without logging in.
* Logging in using an OAuth Token obtained via browser redirects.
* Logging in using an XAuth Token obtained using a client application ID, secret and a user's email and password.
* Logging in using an XAuth Token obtained from a user's OAuth Token, usually on a mobile device.

### Before Your Begin

First, create an application and obtain a client ID and secret by following the instructions in [Getting Started](/start).

### Authenticate with an XAPP Token

This workflow is suitable for desktop or mobile clients. It allows anonymous logon to Artsy without any user access.

```
curl -v -X POST "#{ArtsyAPI.artsy_api_root}/tokens/xapp_token?client_id=...&client_secret=..."
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
  "expires" : "2014-09-05T12:39:09.200Z"
}
```

Field         | Description                |
-------------:|:---------------------------|
type          | Always "xapp_token".       |
token         | Authentication token.      |
expires       | Token expiration date/time.|

Make requests by placing the token into an `X-Xapp-Token` header.

### Login using OAuth Web Browser Redirects

This workflow allows users to login via Browser redirects. This is the preferred method for authenticating users, however currently it will not ask users to authorize your application and will not redirect users back to a non artsy.net URL. This will be implemented in the near future.

Redirect users who wish to authenticate to the OAuth authorization url.

```
#{ArtsyAPI.artsy_api_root}/oauth2/authorize?client_id=...&redirect_uri=...&response_type=code
```

A logged in user will be redirected back to the url you have supplied, appending an authorization code `code=...`, eg. `https://[your redirect url]/?code=auth`.

Your server should make an OAuth2 POST or GET request to the following url.

```
#{ArtsyAPI.artsy_api_root}/oauth2/access_token?client_id=...&client_secret=...&code=...&grant_type=authorization_code
```

Parameter     | Description                                 |
-------------:|:--------------------------------------------|
client_id     | Your application's client ID.               |
client_secret | Your application's client secret.           |
code          | Authorization code from the callback above. |
grant_type    | Set to "authorization_code".                |
state         | Optional state to include in the callback.  |

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

The value of *state* will be returned in the redirect URL for *authorize*, the access token and error JSON.

Specify scope as *offline_access* to request a token that expires in 25 years instead of the standard 60 days.

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
#{ArtsyAPI.artsy_api_root}/oauth2/access_token?client_id=...&client_secret=...&grant_type=credentials&email=...&password=...
```

Parameter     | Description                                 |
-------------:|:--------------------------------------------|
client_id     | Your application's client ID.               |
client_secret | Your application's client secret.           |
grant_type    | Set to "credentials".                       |
email         | User's email address.                       |
password      | User's password.                            |

The response from Artsy will be the following JSON.


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

Specify scope as *offline_access* to request a token that expires in 25 years instead of the standard 60 days.

Make requests by placing the token into an `X-Auth-Token` header.

### Login using an XAuth Token obtained from a User's OAuth Token

If you have access to a user's social provider token (Facebook) or a social provider token and secret (Twitter), you can obtain an OAuth token in exchange for it.

```
#{ArtsyAPI.artsy_api_root}/oauth2/access_token?client_id=...&client_secret=...&grant_type=oauth_token&oauth_token=...&oauth_provider=...
```

Parameter           | Description                                    |
-------------------:|:-----------------------------------------------|
client_id           | Your application's client ID.                  |
client_secret       | Your application's client secret.              |
grant_type          | Set to "oauth_token".                          |
oauth_token         | OAuth token obtained from Facebook or Twitter. |
oauth\_token_secret | OAuth token secret obtained from Twitter.      |
oauth_provider      | Either "facebook" or "twitter".                |
scope               | Scope of access requested.                     |

Specify scope as *offline_access* to request a token that expires in 25 years instead of the standard 60 days.

The response will be identical to the "credentials" grant type above.
