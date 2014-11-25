[Documentation](/docs) &gt; Resources &gt; Collection Items

## Collection Items API

A collection item belongs to a [collection](/docs/collection), a [user](/docs/users) and currently references an [artwork](/docs/artworks).

#### Retrieving Collection Items

``` alert[info]
If you're just trying to retrieve artworks that belong to a collection, use the [artworks](/docs/artworks) API.
```

You can retrieve collection items by following the "collection\_items" link from a [collection](/docs/collections).

```
curl -v "#{ArtsyAPI.artsy_api_root}/collection_items?collection_id=...&user_id=#{current_user.id}" -H "X-Access-Token:..."
```

This endpoint accepts the following parameters.

Name             | Value                                 |
----------------:|:--------------------------------------|
collection_id    | Collection ID, required.              |
user_id          | Collection owner (user) ID, required. |

The response is a [paginated result](/docs/pagination) with embedded collection items.

#### Retrieving a Collection Item

Users can retrieve a specific collection item by ID by rendering the "collection\_item" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/collection_items/{id}?collection_id=...&user_id=#{current_user.id}" -H "X-Access-Token:..."
```

#### Creating and Updating Collection Items

You can create collection items with POST to "collection\_items" and update a collection item, typically to change its position within a collection, with PUT to "collection\_item".

The following Ruby example creates a collection and adds an artwork to it.

```ruby
require 'hyperclient'

# access token should be obtained via OAuth
api = Hyperclient.new('http://localhost:3000/api') do |api|
  api.headers['Accept'] = 'application/vnd.artsy-v2+json'
  api.headers['X-Access-Token'] = '...'
end

# retrieve current user
current_user = api.current_user

# fetch the user's default collection
collection = api.collections(user_id: current_user.id, default: true, private: true).first

# add an artwork to the collection
artwork = api.artworks.first
collection.collection_items._post(artwork_id: artwork.id)
```

## Collection Item JSON Format

#{modelref://CollectionItem}

#### Links

Key               | Target                                                             |
-----------------:|:-------------------------------------------------------------------|
self              | The collection resource.                                           |
user              | [User](/docs/users) that owns the collection.                      |
collection        | [Collection](/docs/collections) that this item belongs to.         |
artwork           | [Artwork](/docs/artworks) referenced by this item.                 |

#### Example

``` json
{
  "id" : "...",
  "created_at" : "2014-11-25T19:30:15+00:00",
  "updated_at" : "2014-11-25T19:30:15+00:00",
  "position" : 1,
  "_links" : {
    "self" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/collection_items/...?collection_id=...&user_id=..."
    },
    "user" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/users/..."
    },
    "collection" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/collections/..."
    },
    "artwork" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/artworks/..."
    }
  }
}
```
