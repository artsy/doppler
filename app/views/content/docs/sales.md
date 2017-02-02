[Documentation](/docs) &gt; Resources &gt; Sales

## Sales API

Sales and Auctions are available at the sales endpoint.

#### Retrieving Sales

Users can retrieve their own applications by following the [sales](#{ArtsyAPI.artsy_api_root}/sales) link from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/sales" -H "X-Access-Token:#{access_token}"
```

This endpoint accepts the following parameters.

Name       | Value                                  |
----------:|:---------------------------------------|
live       | Boolean- filter live auctions only     |
is_auction | Boolean- filter auctions only          |
published  | Boolean- limit to published sales      |

``` alert[warning]
Only authorized users/applications may access **unpublished** sales=
```

The response is a [paginated result](/docs/pagination) with embedded sales.

``` json
{
  "total_count" : 1,
  "_links" : {
    "self" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/sales?live=..."
    },
    "next" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/sales?cursor=...&live=..."
    }
  },
  "_embedded" : {
    "sales" : [
      {
        "id":"...",
        ...
      }
    ]
  }
}
```

#### Retrieving a Sale

Users can retrieve a specific sale by ID by rendering the "sale" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/sales/{id}" -H "X-XAPP-Token:#{xapp_token}"
```
## Sale JSON Format

#{modelref://Sale}

#### Example

``` json
#{resource://sale/id=58126d67cd530e21c40002ec}
```

