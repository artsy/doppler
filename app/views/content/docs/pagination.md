[Documentation](/docs) &gt; General &gt; Pagination and Sets

## Pagination And Sets

Paginated results, including [artists](/docs/artists) or [artworks](/docs/artworks), consist of a set of pagination-related fields, such as counts, links between pages and embedded results.

Each response contains the following fields.

Key         | Target                                          |
-----------:|:------------------------------------------------|
total_count | Total count of items.                           |

#### Total Count

Counting objects is not free. The value of "total\_count" is never set by default. Specify "total\_count=1" in the query string to retrieve it.

```
curl -v "#{ArtsyAPI.artsy_api_root}/artworks?total_count=1" -H "X-XAPP-Token:#{xapp_token}"
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
offset      | Skip this number of items, mutually exclusive with a cursor.

``` alert[warning]
The cursor and offset pagination parameters are mutually exclusive. Attempting to use both of them in an API call will result in an explicit 400 error from the API. We prefer cursor-based pagination, however there is a need for a more conventional based paging scheme. Passing in an offset parameter will first skip that number of records, and then begin cursor-based paging from there.
```

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
