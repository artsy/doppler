[Public API Documentation](/v2) &gt; Resources &gt; Search

## Search API

Search for anything on Artsy.

#### Retrieving Search Results

Search for anything by following the [search](#{ArtsyAPI::V2.root}/search) link from [root](#{ArtsyAPI::V2.root}) with a query parameter.

```
curl -v "#{ArtsyAPI::V2.root}/search?q=Andy+Warhol" -H "X-XAPP-Token: XAPP_TOKEN"
```

The response is a [paginated result](/v2/docs/pagination) with embedded search results.

## Search Result JSON Format

#{modelref://SearchResult}

#### Possible Types

Type          | Resource                                           |
-------------:|:---------------------------------------------------|
Artist        | An Artsy [artist](/v2/docs/artists).                  |
Artwork       | An Artsy [artwork](/v2/docs/artworks).                |
Profile       | An Artsy [profile](/v2/docs/profiles).                |
Gene          | An Artsy [gene](/v2/docs/genes).                      |
Show          | An Artsy [show](/v2/docs/shows).                      |

The API will also return search results with a "null" value for "type". Those are not supported by the API (yet) and may include features, posts or shows.

#### Links

Key        | Target                                          |
----------:|:------------------------------------------------|
self       | The resource found, when available.             |
thumbnail  | Image thumbnail, when available.                |
permalink  | An external location on the artsy.net website.  |

``` alert[warning]
You can follow the "self" link on each individual search result, however because of delays in indexing and content restrictions there's no guarantee that those links will always return a resource. Notably, only a subset of artworks is available via the API, whereas search returns all content published on artsy.net.
```

#### Advanced Search

You can leverage the filtering capabilities of [Google Custom Search](https://developers.google.com/custom-search/v2/docs/structured_search) that provides the back-end for the Artsy search API.

For example, only search for artists by specifying an "artist" open-graph type with `more:pagemap:metatags-og_type:artist`.

```
curl -v "#{ArtsyAPI::V2.root}/search?q=Andy+Warhol+more:pagemap:metatags-og_type:artist" -H "X-XAPP-Token: XAPP_TOKEN"
```

#### Spell Check

If the API fails to find any results for a term it will attempt to correct its spelling. The response will be a 302 redirect to the suggested search URL. For example, searching for "Tauba Orbach" will redirect to a search for "Tauba Auerbach".

```
curl -v "#{ArtsyAPI::V2.root}/search?q=Tauba+Orbach" -H "X-XAPP-Token: XAPP_TOKEN"

< HTTP/1.1 302 Found
< Content-Type: application/json
< Location: #{ArtsyAPI::V2.root}/api/search?q=Tauba+Auerbach
```

``` json
{
  "_links" : {
    "location" : {
      "href" : "#{ArtsyAPI::V2.root}/search?q=Tauba+Auerbach"
    }
  }
}
```

#### Public Artworks, Stale and New Content

Search indexing is not immediate. Search results may not always contain content that has been very recently added.

Search results may contain metadata about artworks that are not publicly accessible via the Artsy API or that describe content that has been removed since it was last indexed. Following links for such results may result in a 404 Not Found error.

#### Example

``` json
#{resource://search/q=Andy Warhol}
```
