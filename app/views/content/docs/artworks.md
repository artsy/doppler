[Documentation](/docs) &gt; Resources &gt; Artworks

## Artworks API

An artwork is an artistic production created by an [artist](/docs/artists), multiple artists or an artist collective. An artwork may be part of a series and be reproduced in prints. Artworks are available from Artsy [partners](/docs/partners) and may be included in [shows](/docs/shows).

#### Retrieving Artworks

Retrieve artworks by following the [artworks](#{ArtsyAPI.artsy_api_root}/artworks) link from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/artworks" -H "X-XAPP-Token:#{xapp_token}"
```

This endpoint accepts the following parameters.

Name             | Value                                                                                         |
----------------:|:----------------------------------------------------------------------------------------------|
artist_id        | Retrieve artworks by a given [artist](/docs/artists).                                         |
partner_id       | Retrieve artworks that belong to a given [partner](/docs/partners).                           |
show_id          | Retrieve artworks that belong to a given [show](/docs/shows).                                 |
collection_id    | Retrieve artworks that belong to a given [collection](/docs/collections), sorted by position. |

The response is a [paginated result](/docs/pagination) with embedded artworks.

#### Retrieving an Artwork

Users can retrieve a specific artwork by ID by rendering the "artwork" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/artworks/{id}" -H "X-XAPP-Token:#{xapp_token}"
```

#### Retrieving Similar Artworks

Artsy continuously computes a K-nearest-neighbor graph for artworks using data from the [Art Genome Project](https://artsy.net/about/the-art-genome-project). Retrieve artworks similar to another artwork by following the "similar\_artworks" link in an artwork resource, which calls this endpoint with the `similar\_to\_artwork_id` parameter. The response is a non-paginated set of similar artworks.

## Artwork JSON Format

#{modelref://Artwork}

#### Links

Key                | Target                                           |
------------------:|:-------------------------------------------------|
self               | The artwork resource.                            |
thumbnail          | Default image thumbnail.                         |
image:self         | Curied image location.                           |
permalink          | An external location on the artsy.net website.   |
partner            | [Partner](/docs/partners) that owns the artwork. |
artists            | Artwork's [Artists](/docs/artists).              |
genes              | Artwork's [Genes](/docs/genes).                  |
similar\_artworks  | Artwork similar to the artwork.                  |

#### Embedded Collections

Key           | Target                                                                          |
-------------:|:--------------------------------------------------------------------------------|
editions      | A set of artwork [editions](/docs/editions) available for this artwork.         |

#### Example

``` json
#{resource://artwork/id=516dfb9ab31e2b2270000c45}
```
