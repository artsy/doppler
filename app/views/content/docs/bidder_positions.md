[Documentation](/docs) &gt; Resources &gt; Bidder Positions

## Bidder Positions API

A bidder creates [bidder positions](/docs/bidder_positions).

``` alert[danger]
The Bidder Positions API is restricted to authorized applications/users.
```

#### Retrieving a Bidder Position

Users can retrieve a specific bidder position by ID by rendering the "bidder_position" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/bidder_positions/{id}" -H "X-XAPP-Token:#{xapp_token}"
```
## Bidder Position JSON Format

#{modelref://BidderPosition}

#### Links

Key                              | Target                                                              |
--------------------------------:|:--------------------------------------------------------------------|
self                             | The bidder position resource.                                       |
sale\_artwork                    | The [sale artwork](docs/sale_artworks) of the bidder position.      |
sale                             | The [sale](/docs/sales) of the bidder position.                     |
artwork                          | The [artwork](/docs/artworks) of the bidder position.               |
bidder                           | The [bidder](/docs/bidders) of the bidder position.               |

