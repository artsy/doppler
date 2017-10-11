[Documentation](/docs) &gt; Resources &gt; Images

## Images API

#### Retrieving Images

Retrieve collections of images following the "images" link from [shows](/docs/shows).

```
curl -v "#{ArtsyAPI.artsy_api_root}/images?show_id={show_id}" -H "X-XAPP-Token:#{xapp_token}"
```

This endpoint accepts the following parameters.

Name       | Value                                                                               |
----------:|:------------------------------------------------------------------------------------|
show_id    | Retrieve images for a given [show](/docs/shows), often called "installation shots". |

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
