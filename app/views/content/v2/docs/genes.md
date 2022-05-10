[Public API Documentation](/v2) &gt; Resources &gt; Genes

## Genes API

Think about an art object, say a painting by Andy Warhol. You might say it is a painting, that it is a work of Pop Art, that it is a silkscreen, that it features an image of Marilyn Monroe, that it is very high contrast, or even that it emphasizes the flatness of the image. These characteristics or terms (e.g. "Pop Art", "Flatness", "Bright Colors") are what we call genes.

#### Retrieving Genes

Retrieve genes by following the [genes](#{ArtsyAPI::V2.root}/genes) link from [root](#{ArtsyAPI::V2.root}), or the "genes" links within an [artwork](/v2/docs/artworks) or [artist](/v2/docs/artists).

```
curl -v "#{ArtsyAPI::V2.root}/genes/{id}" -H "X-XAPP-Token: XAPP_TOKEN"
```

This endpoint accepts the following parameters.

Name       | Value                                                             |
----------:|:------------------------------------------------------------------|
artist_id  | Retrieve genes for a given [artist](/v2/docs/artists).               |
artwork_id | Retrieve genes for a given [artwork](/v2/docs/artworks).             |

## Gene JSON Format

#{modelref://Gene}

#### Links

Key                | Target                                                          |
------------------:|:----------------------------------------------------------------|
self               | The gene resource.                                              |
thumbnail          | Default image thumbnail.                                        |
image              | Curied image location.                                          |
permalink          | An external location on the artsy.net website.                  |
artists            | All [artists](/v2/docs/artists) that have this gene.               |
artworks           | Public domain [artworks](/v2/docs/artworks) that have this gene.   |
published_artworks | All published [artworks](/v2/docs/artworks) that have this gene.   |

#### Example

``` json
#{resource://gene/id=4e5e41670d2c670001030350}
```
