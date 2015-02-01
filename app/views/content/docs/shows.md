[Documentation](/docs) &gt; Resources &gt; Shows

## Shows API

A show is a display of [artworks](/docs/artworks) by one or several [artists](/docs/artists), produced by an Artsy [partner](/docs/partners).

#### Retrieving Shows

Retrieve shows by following the [shows](#{ArtsyAPI.artsy_api_root}/shows) link from [root](#{ArtsyAPI.artsy_api_root}), or the "shows" links within a [partner](/docs/partners).

```
curl -v "#{ArtsyAPI.artsy_api_root}/shows/{id}" -H "X-XAPP-Token:#{xapp_token}"
```

This endpoint accepts the following parameters.

Name       | Value                                                             |
----------:|:------------------------------------------------------------------|
partner_id | Retrieve shows for a given [partner](/docs/partners).             |
status     | Retrieve shows with a specific status (see below).                |
fair_id    | Retrieve shows for a given [fair](/docs/fairs).                   |

#### Show Status

Status        | Description                                        |
-------------:|:---------------------------------------------------|
upcoming      | Opening in the future.                             |
running       | Currently running.                                 |
closed        | Closed.                                            |
current       | Running or upcoming.                               |

## Show JSON Format

#{modelref://Show}

#### Links

Key        | Target                                          |
----------:|:------------------------------------------------|
self       | The show resource.                              |
thumbnail  | Default image thumbnail.                        |
image:self | Curied image location.                          |
permalink  | An external location on the artsy.net website.  |
partner    | Show [partner](/docs/partners).                 |
artworks   | Show [artworks](/docs/artworks).                |

#### Example

``` json
#{resource://show/id=4ea19ee97bab1a0001001908}
```
