[Documentation](/docs) &gt; General &gt; Markdown Content

## Markdown Content

Many content fields in the Artsy API, such as [artist](/docs/artists) bios or [gene](/docs/genes) descriptions, will return data in [markdown format](http://daringfireball.net/projects/markdown/syntax). For example, the description of the "Pop Art" gene includes the following.

```
_“The Pop artists did images that anybody walking down Broadway could recognize in a split second—comics, picnic tables, men’s trousers, celebrities, shower curtains, refrigerators, coke bottles—all the great modern things that the Abstract Expressionists tried so hard not to notice at all.” –[Andy Warhol](/artist/andy-warhol)_
```

Once rendered, this becomes a quoted italic text.

_“The Pop artists did images that anybody walking down Broadway could recognize in a split second—comics, picnic tables, men’s trousers, celebrities, shower curtains, refrigerators, coke bottles—all the great modern things that the Abstract Expressionists tried so hard not to notice at all.” –[Andy Warhol](https://artsy.net/artist/andy-warhol)_

``` alert[info]
Some internal links within the markdown content may be relative to https://artsy.net.
```

``` alert[danger]
While rich user-generated content on Artsy is often parsed, sanitized and converted to markdown in the API output, you should never trust any data returned by the API to be safe in your application. Fields that don't accept rich content (eg. artwork titles) will store user's input "as is" without any cleanup.
```
