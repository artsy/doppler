[Documentation](/docs) &gt; Resources &gt; Profiles

## Profiles API

A public profile provides information about a [partner](/docs/partners) or a [user](/docs/users).

#### Retrieving Profiles

Retrieve profiles by following the [profiles](#{ArtsyAPI.artsy_api_root}/profiles) link from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/profiles" -H "X-XAPP-Token:#{xapp_token}"
```

The response is a [paginated result](/docs/pagination) with embedded profiles.

#### Retrieving a Profile

Users can retrieve a specific profile by ID by rendering the "profile" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/profiles/{id}" -H "X-XAPP-Token:#{xapp_token}"
```

## Profile JSON Format

#{modelref://Profile}

#### Links

Key         | Target                                          |
-----------:|:------------------------------------------------|
self        | The profile resource.                           |
permalink   | An external location on the artsy.net website.  |
cover_image | A cover [image](/docs/images).                  |
image:self  | Curied image location.                          |
website     | Official website.                               |

#### Example

``` json
#{resource://profile/id=5159dac69a608324390001e5}
```
