[Documentation](/docs) &gt; General &gt; Requests & Responses

## Requests & Responses

### Staging and Production

The base URL of the API is [https://api.artsy.net/api](https://api.artsy.net/api).

A test (staging) environment is also available at [https://stagingapi.artsy.net/api](https://stagingapi.artsy.net/api).

``` alert[info]
Staging can only take moderate traffic and does not have 100% uptime. The environment is rebuilt nightly around 5:30AM EST with a large amount of production data. Everything you may have created in staging the day before, including applications, will likely be destroyed within 24 hours. Please also note that staging can't send e-mails.
```

### Verbs

The API supports "OPTIONS", "HEAD", "POST" and "PUT".

* GET: Retrieves a resource or a collection of resources.
* POST: Creates resources.
* PUT: Updates a resource.
* DELETE: Deletes a resource.

### POST and PUT Content Types

When sending data via POST or PUT you may supply all the parameters in the query string or in the body of the request. The API accepts form data with `Content-Type: application/x-www-form-urlencoded` or JSON data with `Content-Type: application/json`.

Requests with other content-types will fail with `406 Not Acceptable` and a JSON error response.

```
curl -X POST "https://stagingapi.artsy.net/api/tokens/xapp_token" -H "Content-Type:invalid/type" -d "x=y"
```

```
HTTP/1.1 406 Not Acceptable
Content-Type: application/json
```

``` json
{
  "error" : "The requested content-type 'invalid/type' is not supported."
}
```

### JSON Response Format

#### JSON+HAL

All response bodies are in the [JSON+HAL Hypermedia format](http://stateless.co/hal_specification.html).

The simplest possible response is an empty JSON document.

``` json
{}
```

A JSON document can have keys and values. Typical resources contain a unique "id".

``` json
{
  "id" : "4d8b92b34eb68a1b2c0003f4",
  "name" : "Andy Warhol"
}
```

#### Timestamps

Most resources also contain a "created\_at" and "updated\_at" UTC timestamp in the [ISO 8601](http://en.wikipedia.org/wiki/ISO_8601) format, without millisecond precision.

``` json
{
  "reated_at" : "2010-08-23T14:15:30+00:00",
  "updated_at" : "2014-08-29T14:25:57+00:00"
}
```

#### Links

Links are always contained directly within a resource under the "_links" key. Links have a relation (aka. 'rel'). This indicates the semantic, or the meaning, of a particular link. The example below is a link to an artist's artworks.

``` json
{
    "_links" : {
        "artworks" : {
          "href" : "#{ArtsyAPI.artsy_api_root}/artworks?artist_id=4d8b92b34eb68a1b2c0003f4"
        }
    }
}
```

All top-level resources have a link to "self".

``` json
{
    "_links" : {
        "self" : {
          "href" : "#{ArtsyAPI.artsy_api_root}/artists/4d8b92b34eb68a1b2c0003f4"
        }
    }
}
```

For more advanced link structures see [links](/docs/links).

#### Collections

Collections of resources are returned the "_embedded" key under a type sub-key. The following example is an empty collection of artworks.

``` json
{
  "total_count" : 0,
  "_links" : {
    "self" : {
      "href" : "#{ArtsyAPI.artsy_api_root}/..."
    }
  },
  "_embedded" : {
    "artworks": [ ]
  }
}
```

For more information on iterating through large amounts of data or for obtaining counts see [pagination](/docs/pagination).

#### Errors

HTTP status codes are used to indicate success or failure of a request.

* 200 OK - Request succeeded.
* 201 Created - Resource created.

Error codes in the 400 range contain a JSON response that describes the error.

``` json
{
  "type" : "other_error",
  "message" : "Artist Not Found"
}
```

For more information about various error types see [errors](/docs/errors).

Error codes in the 500 range are not expected and should be [reported](/help).


