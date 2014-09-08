[Documentation](/docs) &gt; General &gt; Pagination and Collections

## Pagination And Collections

Paginated results, including [artists](/docs/artists) or [artworks](/docs/artworks), consist of a set of pagination-related fields, such as counts, links between pages and embedded results.

Each response contains the following fields.

Key         | Target                                          |
-----------:|:------------------------------------------------|
total_count | Total count of items.                           |

#### Total Count

Counting objects is not free. The value of "total\_count" is never set by default. Specify "total\_count=1" in the query string to retrieve it.

```
curl -v "#{ArtsyAPI.artsy_api_root}/artworks?public=true&total_count=1" -H "X-XAPP-Token:#{xapp_token}"
```

``` alert[warning]
The value of total\_count should not be used as an exact expectation of how many results the API may return. It's possible that new items have been inserted or existing items removed since the moment this value has been retrieved.
```

#### Links

Key        | Target                                                      |
----------:|:------------------------------------------------------------|
self       | Current page.                                               |
next       | Next page. If this value is not set, this is the last page. |

#### Parameters

All paginated APIs accept the following parameters.

Key         | Target                                                                                |
-----------:|:--------------------------------------------------------------------------------------|
total_count | Specify "total\_count=1" to retrieve the total count, see above.                      |
size        | Limit the number of embedded items in the response to this number.                    |
cursor      | A position within the results set.                                                    |

#### Example

``` json
{
  "total_count" : 1,
  "_links" : {
    "self" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/artists"
    },
    "next" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/artists?cursor=..."
    }
  },
  "_embedded" : {
    "artists" : [
      {
        "id" : "...",
        ...
      }
    ]
  }
}
```
