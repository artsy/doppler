[Documentation](/docs) &gt; Resources &gt; Artists

## Artists API

An artist creates [artworks](/docs/artworks).

An artist is generally one person, but can also be two people collaborating, a collective of people, or even a mysterious entity such as "Banksy".

#### Retrieving Artists

Retrieve artists by following the [artists](#{ArtsyAPI.artsy_api_root}/artists) link from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/artists" -H "X-XAPP-Token:#{xapp_token}"
```

The response is a [paginated result](/docs/pagination) with embedded artists.

``` json
{
  "total_count" : 1,
  "_links" : {
    "self" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/artists"
    },
    "next" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/artists?cursor=..."
    }
  },
  "_embedded" : {
    "artists" : [
      {
        "id" : "...",
        ...
      }
    ]
  }
}
```

#### Retrieving an Artist

Users can retrieve a specific artist by ID by rendering the "artist" link template from [root](#{ArtsyAPI.artsy_api_root}).

```
curl -v "#{ArtsyAPI.artsy_api_root}/artists/#{application_id}" -H "X-XAPP-Token:#{xapp_token}"
```

## Artist JSON Format

Key              | Description                                        |
----------------:|:---------------------------------------------------|
id               | Artist ID.                                         |
updated_at       | Date/time when the status was created.             |
updated_at       | Date/time when the status was last updated.        |
name             | Artist's name.                                     |
gender           | Artist's gender, typically "male" or "female".     |
birthday         | Date or time period when the artist was born.      |
hometown         | The city in which the artist was born.             |
location         | The city in which the artist is currently working. |
nationality      | The country that best defines this artist.         |
statement        | Artist statement.                                  |
biography        | Biography.                                         |
blurb            | A short blurb that best describes the artist.      |
education        | Degrees and academic achievements.                 |
awards           | Awards and recognitions.                           |
publications     | Mentions in printed and online material.           |
collections      | Collections that include the artist\'s works.      |
soloexhibitions  | A list of solo exhibitions.                        |
groupexhibitions | A list of group exhibitions.                       |
image_versions   | Available image versions.                          |

#### Links

Key        | Target                                          |
----------:|:------------------------------------------------|
self       | The artist resource.                            |
thumbnail  | Default image thumbnail.                        |
image:self | Curied image location.                          |
permalink  | An external location on the artsy.net website.  |
artworks   | All artist's [artworks](/docs/artworks).        |

#### Example

``` json

{
  "id" : "4d8b92b34eb68a1b2c0003f4",
  "created_at" : "2010-08-23T14:15:30.000Z",
  "updated_at" : "2014-09-04T06:29:38.000Z",
  "name" : "Andy Warhol",
  "gender" : "male",
  "birthday" : "1928",
  "hometown" : "Pittsburgh, Pennsylvania",
  "location" : "New York ",
  "nationality" : "American",
  "statement" : "",
  "biography" : "An American painter, ...",
  "blurb" : "Obsessed with celebrity, ...",
  "education" : "",
  "awards" : "",
  "publications" : "",
  "collections" : "",
  "soloexhibitions" : "",
  "groupexhibitions" : "",
  "_links" : {
    "curies" : [
      {
        "name" : "image",
        "href" : "http://static1.artsy.net/artist_images/52f6bdda4a04f5d504f69b03/1/{?rel}",
        "templated" : true
      }
    ],
    "thumbnail" : {
      "href" : "http://static1.artsy.net/artist_images/52f6bdda4a04f5d504f69b03/1/four_thirds.jpg"
    },
    "image:self" : {
      "href" : "{?image_version}.jpg"
    },
    "self" : {
      "href" : "https://api.artsy.net/api/artists/4d8b92b34eb68a1b2c0003f4"
    },
    "permalink" : {
      "href" : "http://artsy.net/artist/andy-warhol"
    },
    "artworks" : {
      "href" : "https://api.artsy.net/api/artworks?artist_id=4d8b92b34eb68a1b2c0003f4&public=true"
    }
  },
  "image_versions" : ["square", "tall", "large", "four_thirds"]
}
```
