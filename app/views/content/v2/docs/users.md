[Public API Documentation](/v2) &gt; Resources &gt; Users

``` alert[info]
This API endpoint requires a valid [user access token](/v2/docs/authentication).
```

## Users API

A user represents a registered account on Artsy.

#### Retrieving a User

Users can retrieve a specific user by rendering the "user" link template from [root](#{ArtsyApi::V2.root}).

```
curl -v "#{ArtsyApi::V2.root}/users/{id}" -H "X-Access-Token: ACCESS_TOKEN"
```

#### Retrieving Current User

Retrieve the currently authenticated user by following the [current_user](#{ArtsyApi::V2.root}/current_user) link from [root](#{ArtsyApi::V2.root}).

```
curl -v "#{ArtsyApi::V2.root}/current_user" -H "X-Access-Token: ACCESS_TOKEN"
```

The response will be a 302 redirect to a "users" link with the current user ID.

## User JSON Format

#{modelref://User}

#### Links

Key        | Target                                               |
----------:|:-----------------------------------------------------|
self       | The profile resource.                                |
profile    | Link to the user's [public profile](/v2/docs/profiles). |
user_details  | Link to user's [details](/v2/docs/user_details).     |

#### Example

``` json

{
  "id" : "52fe4b28c94d114d36000001",
  "name" : "Joe Person",
  "_links" : {
    "self" : {
      "href" : "#{ArtsyApi::V2.root}/users/52fe4b28c94d114d36000001"
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
