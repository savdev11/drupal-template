vcl 4.1;

backend default {
  .host = "web";
  .port = "80";
}

acl purge {
  "localhost";
  "app";
  "web";
}

sub vcl_recv {
  if (req.method == "PURGE") {
    if (client.ip !~ purge) {
      return (synth(405, "Not allowed."));
    }
    return (purge);
  }

  if (req.url ~ "^/admin" || req.url ~ "^/user" || req.http.Authorization) {
    return (pass);
  }

  if (req.http.Cookie ~ "SESS" || req.http.Cookie ~ "SSESS") {
    return (pass);
  }
}

sub vcl_backend_response {
  if (beresp.http.Cache-Control ~ "private") {
    set beresp.uncacheable = true;
    return (deliver);
  }

  if (beresp.ttl <= 0s) {
    set beresp.ttl = 120s;
  }
}
