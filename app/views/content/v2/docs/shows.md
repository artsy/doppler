[Public API Documentation](/v2) &gt; Resources &gt; Shows

## Shows API

A show is a display of [artworks](/v2/docs/artworks) by one or several [artists](/v2/docs/artists), produced by an Artsy [partner](/v2/docs/partners).

#### Retrieving Shows

Retrieve shows by following the [shows](#{ArtsyApi::V2.root}/shows) link from [root](#{ArtsyApi::V2.root}), or the "shows" links within a [partner](/v2/docs/partners).

```
curl -v "#{ArtsyApi::V2.root}/shows/{id}" -H "X-XAPP-Token: XAPP_TOKEN"
```

This endpoint accepts the following parameters.

Name       | Value                                                             |
----------:|:------------------------------------------------------------------|
partner_id | Retrieve shows for a given [partner](/v2/docs/partners).             |
status     | Retrieve shows with a specific status (see below).                |
fair_id    | Retrieve shows for a given [fair](/v2/docs/fairs).                   |

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
image      | Curied image location.                          |
permalink  | An external location on the artsy.net website.  |
partner    | Show [partner](/v2/docs/partners).                 |
artworks   | Show [artworks](/v2/docs/artworks).                |

#### Example

``` json
#{resource://show/id=4ea19ee97bab1a0001001908}
```
