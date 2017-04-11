[Documentation](/docs) &gt; Resources &gt; Artists

## Artists API

An artist creates [artworks](/docs/artworks).

An artist is generally one person, but can also be two people collaborating, a collective of people, or even a mysterious entity such as "Banksy".

#### Retrieving Artists

Retrieve artists by following the [artists](#{ArtsyAPI.artsy_api_root}/artists) link from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/artists" -H "X-XAPP-Token:#{xapp_token}"
```

This endpoint accepts the following parameters.

Name                    | Value                                                                                       |
-----------------------:|:--------------------------------------------------------------------------------------------|
artwork\_id             | Retrieve artists for a given [artwork](/docs/artworks).                                     |
similar\_to\_artist\_id | Return artists similar to a given artist.                                                   |
similarity\_type        | Similarity type, either `default` or `contemporary`. See below.                             |
gene\_id                | Return a set of artists that represent a given [gene](/docs/genes).                         |
artworks                | Only return artists with artworks.                                                          |
published\_artworks     | Only return artists with published artworks.                                                |
partner\_id             | Return artists with artworks that belong to the [partner](/docs/partners).                  |

The response is a [paginated result](/docs/pagination) with embedded artists.

#### Retrieving an Artist

Users can retrieve a specific artist by ID by rendering the "artist" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/artists/{id}" -H "X-XAPP-Token:#{xapp_token}"
```

#### Retrieving an Artwork's Artists

Follow the "artists" link from an [artwork](/docs/artworks), which calls this endpoint with the `artwork_id` parameter.

#### Retrieving Similar Artists

Artsy continuously computes a K-nearest-neighbor graph for artists using data from the [Art Genome Project](https://artsy.net/about/the-art-genome-project). Retrieve artists similar to another artist by following the "similar\_artists" or the "similar\_contemporary\_artists" links in an artist resource, which calls this endpoint with the `similar_to_artist_id` parameter and an optional `similarity_type` value. The response is a non-paginated set of similar artists or similar contemporary artists, respectively.

## Artist JSON Format

#{modelref://Artist}

#### Links

Key                              | Target                                          |
--------------------------------:|:------------------------------------------------|
self                             | The artist resource.                            |
thumbnail                        | Default image thumbnail.                        |
image                            | Curied image location.                          |
permalink                        | An external location on the artsy.net website.  |
artworks                         | All artist's [artworks](/docs/artworks).        |
similar\_artists                 | Artists similar to this artist.                 |
similar\_contemporary\_artists   | Contemporary artists similar to this artist.    |

#### Example

``` json
#{resource://artist/id=4d8b92b34eb68a1b2c0003f4}
```
