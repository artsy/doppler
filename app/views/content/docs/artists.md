[Documentation](/docs) &gt; Resources &gt; Artists

## Artists API

An artist creates [artworks](/docs/artworks).

An artist is generally one person, but can also be two people collaborating, a collective of people, or even a mysterious entity such as "Banksy".

#### Retrieving Artists

Retrieve artists by following the [artists](#{ArtsyAPI.artsy_api_root}/artists) link from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/artists" -H "X-XAPP-Token:#{xapp_token}"
```

The response is a [paginated result](/docs/pagination) with embedded artists.

#### Retrieving an Artist

Users can retrieve a specific artist by ID by rendering the "artist" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/artists/{id}" -H "X-XAPP-Token:#{xapp_token}"
```

## Artist JSON Format

#{modelref://Artist}

#### Links

Key        | Target                                          |
----------:|:------------------------------------------------|
self       | The artist resource.                            |
thumbnail  | Default image thumbnail.                        |
image:self | Curied image location.                          |
permalink  | An external location on the artsy.net website.  |
artworks   | All artist's [artworks](/docs/artworks).        |

#### Example

``` json
#{resource://artist/id=4d8b92b34eb68a1b2c0003f4}
```
