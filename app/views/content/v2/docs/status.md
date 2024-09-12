[Public API Documentation](/v2) &gt; Resources &gt; Status

``` alert[info]
This API endpoint does not require authentication or authorization.
```

## Status API

This API retrieves the system status.

```
curl -v "#{ArtsyApi::V2.root}/status"
```

This endpoint does not accept any parameters and returns a status JSON document with the following fields.

# {modelref://System}

#### Possible Status Values

Status        | Condition                                          |
-------------:|:---------------------------------------------------|
good          | All systems operational.                           |
minor         | Some parts of the API may not be fully functioning.|
major         | System is down and is experiencing a major outage. |

#### Example

``` json
#{resource://status}
```
