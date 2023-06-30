# localcache - Caches in github cache or locally
When using local runners, the github action cache sometimes causes timeouts or
is quite slow when multiple parallel runners are requesting data from the cache.
When setting up a local https://github.com/mayth/go-simple-upload-server, this
action can be used to generate an archive and store it on this upload server
instead of google cache. If no "chache_url is provided,e.g. when running the
original github runners, it will use the github cache instead.

# Usage
To create a cache, localcache can be used as a "stand in" instead of cache.
If the provided cache_url_ is empty, the standard cache action will be used.
If it is not empty, the fields cache_url and cache_token will be used for
caching.