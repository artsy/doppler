[Public API Documentation](/v2) &gt; Resources &gt; Fairs

## Fairs API

An art fair is an event to which [partners](/v2/docs/partners) bring [shows](/v2/docs/shows) with [artworks](/v2/docs/artworks).

#### Retrieving Fairs

Retrieve fairs by following the [fairs](#{ArtsyApi::V2.root}/fairs) link from [root](#{ArtsyApi::V2.root}).

```
curl -v "#{ArtsyApi::V2.root}/fairs" -H "X-XAPP-Token: XAPP_TOKEN"
```

This endpoint accepts the following parameters.

Name       | Value                                                                                     |
----------:|:------------------------------------------------------------------------------------------|
status     | One of 'running', 'closed', 'upcoming' or 'current'.                                      |

The response is a [paginated result](/v2/docs/pagination) with embedded fairs.

#### Retrieving a Fair

Users can retrieve a specific fair by ID by rendering the "fair" link template from [root](#{ArtsyApi::V2.root}).

```
curl -v "#{ArtsyApi::V2.root}/fairs/{id}" -H "X-XAPP-Token: XAPP_TOKEN"
```

## Fair JSON Format

#{modelref://Fair}

#### Links

Key        | Target                                          |
----------:|:------------------------------------------------|
self       | The fair resource.                              |
shows      | Fair [shows](/v2/docs/shows).                      |

#### Example

``` json
#{resource://fair/id=543865d4726169329c350300}
```
