[Documentation](/docs) &gt; General &gt; Links Between Resources

## Links Between Resources

Links in HAL responses are contained directly within a resource. Thet are represented as a JSON object contained within a "\_links" hash.

``` json
{
    "_links" : {
        "next" : {
          "href": "#{ArtsyAPI.artsy_api_root}/..."
        }
    }
}
```

#### API Discoverability

A HAL API should be navigated from its [root](#{ArtsyAPI.artsy_api_root}). The root itself is a collection of links.

#### Link Relations

Links have a relation, aka. "rel". This indicates the semantic, the meaning, of a particular link. Link rels are the main way of distinguishing between a resource's links. It's basically just a key within the "\_links" hash, associating the link meaning (the 'rel') with the link object that contains data like the actual "href" value:

``` json
{
    "_links" : {
        "artworks" : {
          "href": "#{ArtsyAPI.artsy_api_root}/..."
        }
    }
}
```

The "rel" above is "artworks" and can be typically found in an [artist](/docs/artists) JSON object. Link rels are URLs which reveal documentation about the given link, making them "discoverable".

#### Templated Links

Templated links have a "templated" attribute set to "true".

```json
"_links" :
  "artist" : {
    "href" : "#{ArtsyAPI.artsy_api_root}/artists/{id}",
    "templated" : true
  }
}
```

Query string parameters are declared as follows.

```json
"_links" :
  "artist" : {
    "href" : "#{ArtsyAPI.artsy_api_root}/artworks{?public,artist_id}",
    "templated" : true
  }
}
```

#### Curies

URLs are generally quite long. To get around this, HAL provides "curies", which are basically named tokens that you can define in the document and use to express link relation URIs in a friendlier, more compact fashion.

The [artwork](/docs/artworks) API includes an "image" curie that can be resolved to multiple image versions.

```json
"image_versions" : ["small", "square", "medium", "tall"],
"_links" :
  {
    "curies": [
      {
        "name" : "image",
        "href" : "http://static.artsy.net/additional_images/515b244538ad2d3bc5000026/3/{?rel}",
        "templated" : true
      }
    ],
    "image:self" : {
      "href" : "{?image_version}.jpg"
    }
  }
}
```


