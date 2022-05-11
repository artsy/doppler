[Public API Documentation](/v2) &gt; Resources &gt; Edition Sets

## Editions API

An edition set is usually a collection of prints created from the same matrix.

#### Retrieving an Edition

Editions are embedded within an artwork, but can also be retrieved individually by ID by rendering the "edition" link template from [root](#{ArtsyAPI::V2.root}).

```
curl -v "#{ArtsyAPI::V2.root}/edition/{id}?artwork_id={artwork_id}" -H "X-XAPP-Token: XAPP_TOKEN"
```

## Edition JSON Format

#{modelref://Edition}

#### Links

Key        | Target                                                  |
----------:|:--------------------------------------------------------|
self       | The artwork resource.                                   |
artwork    | [Artwork](/v2/docs/artworks) corresponding to the edition. |

#### Example

``` json
#{resource://edition/id=5097e5ebac8b8d0002000a07/artwork_id=5035a0faf852da0002000781}
```
