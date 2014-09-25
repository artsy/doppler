[Documentation](/docs) &gt; Resources &gt; Search

## Search API

Search for anything on Artsy.

#### Retrieving Search Results

Search for anything by following the [search](#{ArtsyAPI.artsy_api_root}/search) link from [root](#{ArtsyAPI.artsy_api_root}) with a query parameter.

```
curl -v "#{ArtsyAPI.artsy_api_root}/search?q=Andy+Warhol" -H "X-XAPP-Token:#{xapp_token}"
```

The response is a [paginated result](/docs/pagination) with embedded search results.

## Search Result JSON Format

#{modelref://SearchResult}

#### Possible Types

Type          | Resource                                           |
-------------:|:---------------------------------------------------|
Artist        | An Artsy [artist](/docs/artists).                  |
Artwork       | An Artsy [artwork](/docs/artworks).                |
Profile       | An Artsy [profile](/docs/profiles).                |
Gene          | An Artsy [gene](/docs/genes).                      |

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

You can leverage the filtering capabilities of [Google Custom Search](https://developers.google.com/custom-search/docs/structured_search) that provides the back-end for the Artsy search API.

For example, only search for artists by specifying an "artist" open-graph type with `more:pagemap:metatags-og_type:artist`.

```
curl -v "#{ArtsyAPI.artsy_api_root}/search?q=Andy+Warhol+more:pagemap:metatags-og_type:artist" -H "X-XAPP-Token:#{xapp_token}"
```

#### Example

``` json
#{resource://search/q=Andy Warhol}
```
