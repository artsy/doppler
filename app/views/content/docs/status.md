[Documentation](/docs) &gt; Resources &gt; Status

``` alert[info]
This API endpoint does not require authentication or authorization.
```

## Status API

This API retrieves the system status.

```
curl -v "#{ArtsyAPI.artsy_api_root}/status"
```

This endpoint does not accept any parameters and returns a status JSON document with the following fields.

Key           | Description                                 |
-------------:|:--------------------------------------------|
status        | System status, see below.                   |
updated_at    | Date/time when the status was last updated. |

#### Possible Status Values

Status        | Condition                                          |
-------------:|:---------------------------------------------------|
good          | All systems operational.                           |
minor         | Some parts of the API may not be fully functioning.|
major         | System is down and is experiencing a major outage. |

#### Example

``` json
{
  "status" : "minor",
  "updated_at" : "2014-08-29T21:45:51.000Z",
  "_links" : {
    "self" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/status"
    }
  }
}
```
