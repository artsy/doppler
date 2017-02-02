[Documentation](/docs) &gt; Resources &gt; Bids

## Bids API

An Bid is created while processing a [bidder position](/docs/bidder_positions) (following that Auction's rules regarding increments, reserve pricing and so on).

For more information about how Artsy's bidding logic and models, see our [blog post on the topic](http://artsy.github.io/blog/2014/04/17/building-an-english-auction-with-mongodb/).

``` alert[danger]
The Bids API is restricted to authorized applications/users.
```

#### Retrieving a Bid

Users can retrieve a specific bid by ID by rendering the "bid" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/bids/{id}" -H "X-XAPP-Token:#{xapp_token}"
```

## Bid JSON Format

#{modelref://Bid}

#### Links

Key                | Target                                                |
------------------:|:------------------------------------------------------|
self               | The bid resource.                                     |
position           | The source [bidder position](docs/bidder_positions)   |
artwork            | The associated [artwork](docs/artworks)               |
sale               | The [sale](docs/sales) where the bid was placed       |

