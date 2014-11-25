[Documentation](/docs) &gt; Resources &gt; Applications

``` alert[info]
This API endpoint requires a valid [user access token](/docs/authentication).
```

## Applications API

An application provides a client ID and secret to interact with the Artsy API. See [Authentication](/docs/authentication) for more information.

#### Retrieving Applications

Users can retrieve their own applications by following the [applications](#{ArtsyAPI.artsy_api_root}/applications) link from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/applications?user_id=#{current_user.id}" -H "X-Access-Token:#{access_token}"
```

This endpoint accepts the following parameters.

Name       | Value                          |
----------:|:-------------------------------|
user_id    | Application owner (user) ID.   |

The response is a [paginated result](/docs/pagination) with embedded applications.

``` json
{
  "total_count" : 1,
  "_links" : {
    "self" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/applications?user_id=..."
    },
    "next" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/applications?cursor=...&user_id=..."
    }
  },
  "_embedded" : {
    "applications" : [
      {
        "id":"...",
        ...
      }
    ]
  }
}
```

A request without a "user_id" will be redirected accordingly with a 302 HTTP status code.

#### Retrieving an Application

Users can retrieve a specific application by ID by rendering the "application" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/applications/{id}" -H "X-Access-Token:..."
```

``` alert[danger]
Users are only authorized to retrieve their own applications.
```

## Application JSON Format

#{modelref://Application}

#### Links

Key        | Target                          |
----------:|:--------------------------------|
self       | The application resource.       |
user       | User that owns the application. |


#### Example

``` json
{
  "id" : "...",
  "created_at" : "2014-08-31T15:05:29+00:00",
  "updated_at" : "2014-08-31T15:05:29+00:00",
  "name" : "Test",
  "client_id" : "...",
  "client_secret" : "...",
  "enabled" : true,
  "_links" : {
    "self" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/applications/..."},
    "user" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/users/4dc805b18101da0001000489"
    }
  }
}
```
