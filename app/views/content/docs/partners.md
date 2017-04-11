[Documentation](/docs) &gt; Resources &gt; Partners

## Partners API

A partner provides [artworks](/docs/artworks).

#### Retrieving Partners

Retrieve partners by following the [partners](#{ArtsyAPI.artsy_api_root}/partners) link from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/partners" -H "X-XAPP-Token:#{xapp_token}"
```

This endpoint accepts the following parameters.

Name       | Value                                                                                     |
----------:|:------------------------------------------------------------------------------------------|
user_id    | Retrieve partners that a [user](/docs/users) has access to.                               |
partner_id | Combine with 'user_id' to check whether a [user](/docs/users) has access to this partner. |

The response is a [paginated result](/docs/pagination) with embedded partners.

#### Retrieving a Partner

Users can retrieve a specific partner by ID by rendering the "partner" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/partners/{id}" -H "X-XAPP-Token:#{xapp_token}"
```

## Partner JSON Format

#{modelref://Partner}

#### Links

Key                | Target                                            |
------------------:|:--------------------------------------------------|
self               | The partner resource.                             |
profile            | Partner [profile](/docs/profiles).                |
permalink          | An external location on the artsy.net website.    |
website            | Official website.                                 |
artworks           | Partner [artworks](/docs/artworks).               |
artists            | Partner [artists](/docs/artists).               |
published_artworks | All published partner [artworks](/docs/artworks). |
shows              | Partner [shows](/docs/shows).                     |

#### Example

``` json
#{resource://partner/id=4f99c7b793ab4b0001000179}
```
