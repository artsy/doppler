[Documentation](/docs) &gt; Resources &gt;

## Applications

An application provides a client ID and secret to interact with the Artsy API. See [Authentication](/docs/authentication) for more information.

Key           | Description                                 |
-------------:|:--------------------------------------------|
id            | Application ID.                             |
updated_at    | Date/time when the status was created.      |
updated_at    | Date/time when the status was last updated. |
name          | Application name.                           |
client_id     | Auto-generated client ID.                   |
client_secret | Auto-generated client secret.               |
enabled       | True if the application is enabled.         |

#### Retrieving

Users can retrieve their own applications by following the [applications](#{ArtsyAPI.artsy_api_root}/applications) link from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/applications?user_id=#{current_user.id}" -H "X-Access-Token:#{access_token}"
```

This endpoint accepts the following parameters.

Name       | Value                                      |
----------:|:-------------------------------------------|
user_id    | ID of the user who owns the applications.  |

#### Links

Key        | Target                          |
----------:|:--------------------------------|
self       | The application resource.       |
user       | User that owns the application. |


#### Example

``` json
{
  "id" : "540339b97261692388020000",
  "created_at" : "2014-08-31T15:05:29.000Z",
  "updated_at" : "2014-08-31T15:05:29.000Z",
  "name" : "Test",
  "client_id" : "01fc61a684426633802c",
  "client_secret" : "e4a23e7963164120e045e34d26d35126",
  "enabled" : true,
  "_links" : {
    "self" : {
      "href" : "http://staging.artsy.net/api/applications/540339b97261692388020000"},
    "user" : {
      "href" : "http://staging.artsy.net/api/users/4dc805b18101da0001000489"
    }
  }
}
```

#### Authorization

This API endpoint requires a valid user access token.
