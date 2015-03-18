[Documentation](/docs) &gt; Resources &gt; Fairs

## Fairs API

An art fair is an event to which [partners](/docs/partners) bring [shows](/docs/shows) with [artworks](/docs/artworks).

#### Retrieving Fairs

Retrieve fairs by following the [fairs](#{ArtsyAPI.artsy_api_root}/fairs) link from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/fairs" -H "X-XAPP-Token:#{xapp_token}"
```

This endpoint accepts the following parameters.

Name       | Value                                                                                     |
----------:|:------------------------------------------------------------------------------------------|
status     | One of 'running', 'closed', 'upcoming' or 'current'.                                      |

The response is a [paginated result](/docs/pagination) with embedded fairs.

#### Retrieving a Fair

Users can retrieve a specific fair by ID by rendering the "fair" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/fairs/{id}" -H "X-XAPP-Token:#{xapp_token}"
```

## Fair JSON Format

#{modelref://Fair}

#### Links

Key        | Target                                          |
----------:|:------------------------------------------------|
self       | The fair resource.                              |
shows      | Fair [shows](/docs/shows).                      |

#### Example

``` json
#{resource://fair/id=543865d4726169329c350300}
```
