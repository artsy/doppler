[Documentation](/docs) &gt; Resources &gt; User Details

``` alert[info]
This API endpoint requires a valid [user access token](/docs/authentication).
```

## User Details API

While a [user](/docs/users) represents publicly available reference about a registered user account on Artsy, user details are the private portion of such information, including the user's e-mail address or phone number.

#### Retrieving User Details

Users can retrieve a specific user by following the "user_details" link from a [user](/docs/users).

```
curl -v "#{ArtsyAPI.artsy_api_root}/user_details/{id}" -H "X-Access-Token:..."
```

## User Details JSON Format

#{modelref://UserDetail}

#### Links

Key        | Target                                               |
----------:|:-----------------------------------------------------|
self       | The profile resource.                                |
user       | Link to the [user](/docs/users) information.         |

#### Example

``` json
{
  "id" : "52fe4b28c94d114d36000001",
  "created_at" : "2014-02-14T16:58:17+00:00",
  "updated_at" : "2014-09-08T13:32:34+00:00",
  "type" : "User",
  "email" : "user@example.com",
  "birthday" : null,
  "phone" : null,
  "gender" : "female",
  "_links" : {
    "self" : {
      "href" : "http://localhost:3000/api/user_details/52fe4b28c94d114d36000001"
    },
    "user" : {
      "href" : "http://localhost:3000/api/user/52fe4b28c94d114d36000001"
    }
  }
}
```
