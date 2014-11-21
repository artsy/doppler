[Documentation](/docs) &gt; Resources &gt; Collections

## Collections API

A collection belongs to a [user](/docs/users) and contains [artworks](/docs/artworks). A collection may be public or private: public collections are available for everyone to see and private collections are not. Every user has a default collection, often referred to as "favorites".

#### Retrieving Collections

You can retrieve a user's public collections by following the "public\_collections" link from a [user](/docs/user). Users can retrieve their own public and private collections by following the [collections](#{ArtsyAPI.artsy_api_root}/collections) link from [user details](/docs/user_details).

```
curl -v "#{ArtsyAPI.artsy_api_root}/collections?user_id=#{current_user.id}&private=true" -H "X-Access-Token:#{access_token}"
```

This endpoint accepts the following parameters.

Name       | Value                                 |
----------:|:--------------------------------------|
user_id    | Collection owner (user) ID, required. |
private    | Also retrieve private collections.    |

The response is a [paginated result](/docs/pagination) with embedded collections.

#### Retrieving a Collection

Users can retrieve a specific collection by ID by rendering the "collection" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/collections/#{id}&user_id=#{user_id}" -H "X-Access-Token:#{access_token}"
```

``` alert[danger]
Users are only authorized to retrieve their own private collections.
```

#### Creating and Updating Collections

You can create a collection with POST and update a collection with PUT on the "collections" link, "#{ArtsyAPI.artsy_api_root}/collections". All fields from the collection JSON format below are supported, except "id". A "user\_id" is required.

## Collection JSON Format

#{modelref://Collection}

#### Links

Key        | Target                                            |
----------:|:--------------------------------------------------|
self       | The collection resource.                          |
user       | User that owns the collection.                    |
artworks   | Artworks in this collection, sorted by position.  |


#### Example

``` json
{
  "id" : "...",
  "created_at" : "2014-08-31T15:05:29+00:00",
  "updated_at" : "2014-08-31T15:05:29+00:00",
  "name" : "Saved Artwork",
  "description" : "Default collection, favorites.",
  "default" : true,
  "private" : true,
  "_links" : {
    "self" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/collections/..."},
    "user" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/users/4dc805b18101da0001000489"
    },
    "artworks" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/artworks?collection_id=..."
    }
  }
}
```
