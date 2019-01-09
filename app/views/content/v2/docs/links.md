[Public API Documentation](/v2) &gt; General &gt; Links Between Resources

## Links Between Resources

Links in HAL responses are contained directly within a resource. Thet are represented as a JSON object contained within a "\_links" hash.

``` json
{
    "_links" : {
        "next" : {
          "href": "#{ArtsyAPI::V2.root}/..."
        }
    }
}
```

#### API Discoverability

A HAL API should be navigated from its [root](#{ArtsyAPI::V2.root}). The root itself is a collection of links.

#### Link Relations

Links have a relation, aka. "rel". This indicates the semantic, the meaning, of a particular link. Link rels are the main way of distinguishing between a resource's links. It's basically just a key within the "\_links" hash, associating the link meaning (the 'rel') with the link object that contains data like the actual "href" value:

``` json
{
    "_links" : {
        "artworks" : {
          "href": "#{ArtsyAPI::V2.root}/..."
        }
    }
}
```

The "rel" above is "artworks" and can be typically found in an [artist](/v2/docs/artists) JSON object. Link rels are URLs which reveal documentation about the given link, making them "discoverable".

#### Templated Links

Templated links have a "templated" attribute set to "true".

```json
"_links" :
  "artist" : {
    "href" : "#{ArtsyAPI::V2.root}/artists/{id}",
    "templated" : true
  }
}
```

Query string parameters are declared as follows.

```json
"_links" :
  "artist" : {
    "href" : "#{ArtsyAPI::V2.root}/artworks{?public,artist_id}",
    "templated" : true
  }
}
```
