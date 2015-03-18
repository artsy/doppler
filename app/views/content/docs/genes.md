[Documentation](/docs) &gt; Resources &gt; Genes

## Genes API

Think about an art object, say a painting by Andy Warhol. You might say it is a painting, that it is a work of Pop Art, that it is a silkscreen, that it features an image of Marilyn Monroe, that it is very high contrast, or even that it emphasizes the flatness of the image. These characteristics or terms (e.g. "Pop Art", "Flatness", "Bright Colors") are what we call genes.

#### Retrieving Genes

Retrieve genes by following the [genes](#{ArtsyAPI.artsy_api_root}/genes) link from [root](#{ArtsyAPI.artsy_api_root}), or the "genes" links within an [artwork](/docs/artworks) or [artist](/docs/artists).

```
curl -v "#{ArtsyAPI.artsy_api_root}/genes/{id}" -H "X-XAPP-Token:#{xapp_token}"
```

This endpoint accepts the following parameters.

Name       | Value                                                             |
----------:|:------------------------------------------------------------------|
artist_id  | Retrieve genes for a given [artist](/docs/artists).               |
artwork_id | Retrieve genes for a given [artwork](/docs/artworks).             |

## Gene JSON Format

#{modelref://Gene}

#### Links

Key        | Target                                          |
----------:|:------------------------------------------------|
self       | The gene resource.                              |
thumbnail  | Default image thumbnail.                        |
image:self | Curied image location.                          |
permalink  | An external location on the artsy.net website.  |

#### Example

``` json
#{resource://gene/id=4e5e41670d2c670001030350}
```
