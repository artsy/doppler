[Documentation](/docs) &gt; Resources &gt; Users

``` alert[info]
This API endpoint requires a valid [user access token](/docs/authentication).
```

## Users API

A user represents a registered account on Artsy.

#### Retrieving a User

Users can retrieve a specific user by rendering the "user" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/users/{id}" -H "X-Access-Token:..."
```

#### Retrieving Current User

Retrieve the currently authenticated user by following the [current_user](#{ArtsyAPI.artsy_api_root}/current_user) link from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/current_user" -H "X-Access-Token:#{access_token}"
```

The response will be a 302 redirect to a "users" link with the current user ID.

## User JSON Format

#{modelref://User}

#### Links

Key        | Target                                               |
----------:|:-----------------------------------------------------|
self       | The profile resource.                                |
profile    | Link to the user's [public profile](/docs/profiles). |
user_details  | Link to user's [details](/docs/user_details).     |

#### Example

``` json

{
  "id" : "52fe4b28c94d114d36000001",
  "name" : "Joe Person",
  "_links" : {
    "self" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/users/52fe4b28c94d114d36000001"
    },
    "profile" : {
      "href" : "http://localhost:3000/api/profiles/52fe4b2ac94d114d36000005"
    },
    "user_details" : {
      "href" : "http://localhost:3000/api/user_details/52fe4b28c94d114d36000001"
    }
  }
}
```

