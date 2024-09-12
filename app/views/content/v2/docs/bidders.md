[Public API Documentation](/v2) &gt; Resources &gt; Bidders

## Bidders API

A bidder is a [user](/v2/docs/users) registered for a specific [sale](/v2/docs/sales).

``` alert[danger]
The Bidders API is restricted to authorized applications/users.
```

#### Retrieving Bidders

Users can retrieve bidders by following the [bidders](#{ArtsyApi::V2.root}/bidders) link from [root](#{ArtsyApi::V2.root}).

```
curl -v "#{ArtsyApi::V2.root}/bidders?user_id=USER_ID" -H "X-Access-Token: ACCESS_TOKEN"
```

This endpoint accepts the following parameters.

Name       | Value                          |
----------:|:-------------------------------|
sale_id    | Applicable Auction (sale) ID.  |

The response is a [paginated result](/v2/docs/pagination) with embedded bidders.

``` json
{
  "total_count" : 1,
  "_links" : {
    "self" : {
      "href" : "#{ArtsyApi::V2.root}/bidders?sale_id=..."
    },
    "next" : {
      "href" : "#{ArtsyApi::V2.root}/bidders?cursor=...&sale_id=..."
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

Authorized users and applications can retrieve a specific bidder by ID by rendering the "bidder" link template from [root](#{ArtsyApi::V2.root}).

```
curl -v "#{ArtsyApi::V2.root}/bidders/{id}" -H "X-XAPP-Token: XAPP_TOKEN"
```

## Bidder JSON Format

# {modelref://Bidder}

#### Links

Key                              | Target                                                              |
--------------------------------:|:--------------------------------------------------------------------|
self                             | The bidder resource.                                       |
sale                             | The [sale](/v2/docs/sales) of the bidder                               |
user                             | The [user](/v2/docs/users) of the bidder                               |
user_detail                      | The [user detail](/v2/docs/user_details) of the bidder                 |
