[Documentation](/docs) &gt; Resources &gt;

## Status

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
