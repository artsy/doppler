[Public API Documentation](/v2) &gt; General &gt; Rate Limiting

## Rate Limiting

Artsy API is currently rate-limited to 5 requests per second per client application ID. API calls will return an HTTP 429 `Too many requests` error when your client is over that limit. You will not be blacklisted by default, only throttled.

We currently do not offer a way to raise this limit, please [contact us](https://developers.artsy.net/help) if you need help.
