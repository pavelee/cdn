vcl 4.1;

# remove cookies, always cache
sub vcl_recv {
    unset req.http.Cookie;
}

backend default {
    .host = "thumbor";
    .port = "80";
}