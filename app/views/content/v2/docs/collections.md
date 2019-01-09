[Public API Documentation](/v2) &gt; Resources &gt; Collections

## Collections API

A collection belongs to a [user](/v2/docs/users) and contains [artworks](/v2/docs/artworks). A collection may be public or private: public collections are available for everyone to see and private collections are not. Every user has a default collection, often referred to as "Favorites" and called "Saved Artwork" by default.

#### Retrieving Collections

You can retrieve a user's public collections by following the "public\_collections" link from a [user](/v2/docs/users). Users can retrieve their own public and private collections by following the [collections](#{ArtsyAPI::V2.root}/collections) link from [user details](/v2/docs/user_details).

```
curl -v "#{ArtsyAPI::V2.root}/collections?user_id=#{current_user.id}&private=true" -H "X-Access-Token:..."
```

This endpoint accepts the following parameters.

Name       | Value                                 |
----------:|:--------------------------------------|
user_id    | Collection owner (user) ID, required. |
private    | Also retrieve private collections.    |

The response is a [paginated result](/v2/docs/pagination) with embedded collections.

#### Retrieving a Collection

Users can retrieve a specific collection by ID by rendering the "collection" link template from [root](#{ArtsyAPI::V2.root}).

```
curl -v "#{ArtsyAPI::V2.root}/collections/{id}?user_id=#{current_user.id}" -H "X-Access-Token:..."
```

``` alert[danger]
Users are only authorized to retrieve their own private collections.
```

#### Creating and Updating Collections

You can create a collection with POST to "collections" and update a collection with PUT on "collection". All fields from the collection JSON format below are supported, except "id". A "user\_id" is required.

See [this topic](/v2/docs/collection_items) for documentation on how to add artworks to a collection.

## Collection Item JSON Format

#{modelref://Collection}

#### Links

Key               | Target                                                             |
-----------------:|:-------------------------------------------------------------------|
self              | The collection resource.                                           |
user              | [User](/v2/docs/users) that owns the collection.                      |
artworks          | [Artworks](/v2/docs/artworks) in this collection, sorted by position. |
collection\_items | [Collection Items](/v2/docs/collection_items) in this collection.     |

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
      "href" : "#{ArtsyAPI::V2.root}/collections/..."},
    "user" : {
      "href" : "#{ArtsyAPI::V2.root}/users/4dc805b18101da0001000489"
    },
    "artworks" : {
      "href" : "#{ArtsyAPI::V2.root}/artworks?collection_id=...&user_id=..."
    },
    "collection_items" : {
      "href" : "#{ArtsyAPI::V2.root}/collection_items?collection_id=...&user_id=..."
    }
  }
}
```
