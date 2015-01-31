[Documentation](/docs) &gt; Resources &gt; Images

## Images API

#### Retrieving an Image

Images are usually related to other objects, such as [profiles](/docs/profiles).


```
curl -v "#{ArtsyAPI.artsy_api_root}/images/{id}" -H "X-XAPP-Token:#{xapp_token}"
```

## Image JSON Format

#{modelref://Image}

#### Links

Key        | Target                                                  |
----------:|:--------------------------------------------------------|
self       | The image resource.                                     |

#### Example

``` json
#{resource://image/id=54bfdb597261692b57fd0000}
```
