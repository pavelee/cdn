vcl 4.1;

import std;

# remove cookies, always cache
sub vcl_recv {
    # to enable cache, remove all cookies, varinsh by default do not cache sites with cookies
    unset req.http.Cookie;

    # https://stackoverflow.com/questions/38892021/how-to-clear-complete-cache-in-varnish
    # Command to clear complete cache for all URLs and all sub-domains
    # curl -X CLEAR_CACHE --header "CLEAR_CACHE_KEY: YOUR_CACHE_KEY"  http://localhost:8080
    if (req.method == "CLEAR_CACHE") {
        if (req.http.CLEAR_CACHE_KEY == "${CLEAR_CACHE_KEY}") {
            ban("req.http.host ~ .*");
            return (synth(200, "Full cache cleared ${CLEAR_CACHE_KEY}"));
        } else {
            return (synth(400, "Wrong CLEAR_CACHE_KEY"));
        }
    }
}

backend default {
    .host = "${THUMBOR_SERVICE_NAME}";
    .port = "${THUMBOR_SERVICE_PORT}";
}