[Public API Documentation](/v2) &gt; Resources &gt; Profiles

## Profiles API

A public profile provides information about a [partner](/v2/docs/partners) or a [user](/v2/docs/users).

#### Retrieving Profiles

Retrieve profiles by following the [profiles](#{ArtsyAPI::V2.root}/profiles) link from [root](#{ArtsyAPI::V2.root}).

```
curl -v "#{ArtsyAPI::V2.root}/profiles" -H "X-XAPP-Token:#{xapp_token}"
```

The response is a [paginated result](/v2/docs/pagination) with embedded profiles.

#### Retrieving a Profile

Users can retrieve a specific profile by ID by rendering the "profile" link template from [root](#{ArtsyAPI::V2.root}).

```
curl -v "#{ArtsyAPI::V2.root}/profiles/{id}" -H "X-XAPP-Token:#{xapp_token}"
```

## Profile JSON Format

#{modelref://Profile}

#### Links

Key         | Target                                                          |
-----------:|:----------------------------------------------------------------|
self        | The profile resource.                                           |
permalink   | An external location on the artsy.net website.                  |
owner       | Profile owner ([user](/v2/docs/users), [fair](/v2/docs/fairs), etc).  |
cover_image | A cover [image](/v2/docs/images).                                  |
image:self  | Curied image location.                                          |
website     | Official website.                                               |

#### Example

``` json
#{resource://profile/id=5159dac69a608324390001e5}
```
