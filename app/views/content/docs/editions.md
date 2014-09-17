[Documentation](/docs) &gt; Resources &gt; Edition Sets

## Editions API

An edition set is usually a collection of prints created from the same matrix.

#### Retrieving an Edition

Editions are embedded within an artwork, but can also be retrieved individually by ID by rendering the "edition" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/edition/{id}?artwork_id={artwork_id}" -H "X-XAPP-Token:#{xapp_token}"
```

## Edition JSON Format

#{modelref://Edition}

#### Links

Key        | Target                                                  |
----------:|:--------------------------------------------------------|
self       | The artwork resource.                                   |
artwork    | [Artwork](/docs/artworks) corresponding to the edition. |

#### Example

``` json
#{resource://edition/id=5097e5ebac8b8d0002000a07/artwork_id=5035a0faf852da0002000781}
```
