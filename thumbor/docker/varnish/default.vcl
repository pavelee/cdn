vcl 4.1;

# remove cookies, always cache
sub vcl_recv {
    # to enable cache, remove all cookies, varinsh by default do not cache sites with cookies
    unset req.http.Cookie;

    # https://stackoverflow.com/questions/38892021/how-to-clear-complete-cache-in-varnish
    # Command to clear complete cache for all URLs and all sub-domains
    # curl -X CLEAR_CACHE http://example.com
    if (req.method == "CLEAR_CACHE") {
        ban("req.http.host ~ .*");
        return (synth(200, "Full cache cleared"));
    }
}

backend default {
    .host = "thumbor";
    .port = "80";
}