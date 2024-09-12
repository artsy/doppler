[Public API Documentation](/v2) &gt; Resources &gt; Partners

## Partners API

A partner provides [artworks](/v2/docs/artworks).

#### Retrieving Partners

Retrieve partners by following the [partners](#{ArtsyApi::V2.root}/partners) link from [root](#{ArtsyApi::V2.root}).

```
curl -v "#{ArtsyApi::V2.root}/partners" -H "X-XAPP-Token: XAPP_TOKEN"
```

This endpoint accepts the following parameters.

Name       | Value                                                                                     |
----------:|:------------------------------------------------------------------------------------------|
user_id    | Retrieve partners that a [user](/v2/docs/users) has access to.                               |
partner_id | Combine with 'user_id' to check whether a [user](/v2/docs/users) has access to this partner. |

The response is a [paginated result](/v2/docs/pagination) with embedded partners.

#### Retrieving a Partner

Users can retrieve a specific partner by ID by rendering the "partner" link template from [root](#{ArtsyApi::V2.root}).

```
curl -v "#{ArtsyApi::V2.root}/partners/{id}" -H "X-XAPP-Token: XAPP_TOKEN"
```

## Partner JSON Format

#{modelref://Partner}

#### Links

Key                | Target                                            |
------------------:|:--------------------------------------------------|
self               | The partner resource.                             |
profile            | Partner [profile](/v2/docs/profiles).                |
permalink          | An external location on the artsy.net website.    |
website            | Official website.                                 |
artworks           | Partner [artworks](/v2/docs/artworks).               |
artists            | Partner [artists](/v2/docs/artists).               |
published_artworks | All published partner [artworks](/v2/docs/artworks). |
shows              | Partner [shows](/v2/docs/shows).                     |

#### Example

``` json
#{resource://partner/id=4f99c7b793ab4b0001000179}
```
