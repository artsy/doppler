[Public API Documentation](/v2) &gt; Resources &gt; Bidder Positions

## Bidder Positions API

A bidder creates [bidder positions](/v2/docs/bidder_positions).

``` alert[danger]
The Bidder Positions API is restricted to authorized applications/users.
```

#### Retrieving a Bidder Position

Users can retrieve a specific bidder position by ID by rendering the "bidder_position" link template from [root](#{ArtsyAPI::V2.root}).

```
curl -v "#{ArtsyAPI::V2.root}/bidder_positions/{id}" -H "X-XAPP-Token:#{xapp_token}"
```
## Bidder Position JSON Format

#{modelref://BidderPosition}

#### Links

Key                              | Target                                                              |
--------------------------------:|:--------------------------------------------------------------------|
self                             | The bidder position resource.                                       |
sale\_artwork                    | The [sale artwork](docs/sale_artworks) of the bidder position.      |
sale                             | The [sale](/v2/docs/sales) of the bidder position.                     |
artwork                          | The [artwork](/v2/docs/artworks) of the bidder position.               |
bidder                           | The [bidder](/v2/docs/bidders) of the bidder position.               |

