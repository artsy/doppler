[Documentation](/docs) &gt; Resources &gt; Edition Sets

## Edition Sets API

An edition set is usually a collection of prints created from the same matrix.

#### Retrieving Edition Sets

Retrieve edition sets by following edition set links within an [artwork](/docs/artworks).

#### Retrieving an Edition Set

Editions are embedded within an artwork, but can also be retrieved individually by ID by rendering the "edition_set" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/edition_set/{id}?artwork_id={artwork_id}" -H "X-XAPP-Token:#{xapp_token}"
```

## Edition Set JSON Format

#{modelref://EditionSet}

#### Links

Key        | Target                                                  |
----------:|:--------------------------------------------------------|
self       | The artwork resource.                                   |
artwork    | [Artwork](/docs/artworks) corresponding to the edition. |

#### Example

``` json
#{resource://edition_set/id=4ebd8c9817958d0001006b54/artwork_id=4d8b92c34eb68a1b2c000496}
```
