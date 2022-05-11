[Public API Documentation](/v2) &gt; Resources &gt; User Details

``` alert[info]
This User Details API is restricted to authorized applications and users with a valid [user access token](/v2/docs/authentication).
```


## User Details API

While a [user](/v2/docs/users) represents publicly available reference about a registered user account on Artsy, user details are the private portion of such information, including the user's e-mail address or phone number.

#### Retrieving User Details

Users can retrieve a specific user by following the "user_details" link from a [user](/v2/docs/users).

```
curl -v "#{ArtsyAPI::V2.root}/user_details/{id}" -H "X-Access-Token: ACCESS_TOKEN"
```

## User Details JSON Format

#{modelref://UserDetail}

#### Links

Key        | Target                                                                  |
----------:|:------------------------------------------------------------------------|
self       | The profile resource.                                                   |
user       | Link to the [user](/v2/docs/users) information.                            |
partners   | Link to [partners](/v2/docs/partners) this user has management access to.  |

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
      "href" : "#{ArtsyAPI::V2.root}/user_details/52fe4b28c94d114d36000001"
    },
    "user" : {
      "href" : "#{ArtsyAPI::V2.root}/user/52fe4b28c94d114d36000001"
    }
  }
}
```
