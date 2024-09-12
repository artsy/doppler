[Public API Documentation](/v2) &gt; Resources &gt; Artworks

## Artworks API

An artwork is an artistic production created by an [artist](/v2/docs/artists), multiple artists or an artist collective. An artwork may be part of a series and be reproduced in prints. Artworks are available from Artsy [partners](/v2/docs/partners) and may be included in [shows](/v2/docs/shows).

#### Retrieving Artworks

Retrieve artworks by following the [artworks](#{ArtsyApi::V2.root}/artworks) link from [root](#{ArtsyApi::V2.root}).

```
curl -v "#{ArtsyApi::V2.root}/artworks" -H "X-XAPP-Token: XAPP_TOKEN"
```

This endpoint accepts the following parameters.

Name              | Value                                                                                              |
-----------------:|:---------------------------------------------------------------------------------------------------|
artist\_id        | Retrieve artworks by a given [artist](/v2/docs/artists).                                              |
partner\_id       | Retrieve artworks that belong to a given [partner](/v2/docs/partners).                                |
show\_id          | Retrieve artworks that belong to a given [show](/v2/docs/shows).                                      |
collection\_id    | Retrieve artworks that belong to a given [collection](/v2/docs/collections), sorted by position.      |
user\_id          | The user that owns the [collection](/v2/docs/collections), required when collection\_id is specified. |

The response is a [paginated result](/v2/docs/pagination) with embedded artworks.

#### Retrieving an Artwork

Users can retrieve a specific artwork by ID by rendering the "artwork" link template from [root](#{ArtsyApi::V2.root}).

```
curl -v "#{ArtsyApi::V2.root}/artworks/{id}" -H "X-XAPP-Token: XAPP_TOKEN"
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
image              | Curied image location.                           |
permalink          | An external location on the artsy.net website.   |
partner            | [Partner](/v2/docs/partners) that owns the artwork. |
artists            | Artwork's [Artists](/v2/docs/artists).              |
genes              | Artwork's [Genes](/v2/docs/genes).                  |
similar\_artworks  | Artwork similar to the artwork.                  |

#### Embedded Collections

Key           | Target                                                                          |
-------------:|:--------------------------------------------------------------------------------|
editions      | A set of artwork [editions](/v2/docs/editions) available for this artwork.         |

#### Example

``` json
#{resource://artwork/id=516dfb9ab31e2b2270000c45}
```
