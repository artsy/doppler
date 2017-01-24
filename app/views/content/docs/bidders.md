[Documentation](/docs) &gt; Resources &gt; Bidders

## Bidders API

A bidder is a [user](/docs/users) registered for a specific [sale](/docs/sales).

``` alert[danger]
The Bidders API is restricted to authorized applications/users.
```

#### Retrieving Bidders

Users can retrieve their own applications by following the [bidders](#{ArtsyAPI.artsy_api_root}/bidders) link from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/bidders?user_id=#{current_user.id}" -H "X-Access-Token:#{access_token}"
```

This endpoint accepts the following parameters.

Name       | Value                          |
----------:|:-------------------------------|
sale_id    | Applicable Auction (sale) ID.  |

The response is a [paginated result](/docs/pagination) with embedded bidders.

``` json
{
  "total_count" : 1,
  "_links" : {
    "self" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/bidders?sale_id=..."
    },
    "next" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/bidders?cursor=...&sale_id=..."
    }
  },
  "_embedded" : {
    "bidders" : [
      {
        "id":"...",
        ...
      }
    ]
  }
}
```

A request without a `sale_id` will receive a paginated list of all bidders.

#### Retrieving a Bidder

Authorized users and applications can retrieve a specific bidder by ID by rendering the "bidder" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/bidders/{id}" -H "X-XAPP-Token:#{xapp_token}"
```

#### Links

Key                              | Target                                                              |
--------------------------------:|:--------------------------------------------------------------------|
self                             | The bidder position resource.                                       |
sale                             | The [sale](/docs/sales) of the bidder                               |
user                             | The [user](/docs/users) of the bidder                               |
user_detail                      | The [user detail](/docs/user_details) of the bidder                 |

