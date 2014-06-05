thomasmckay @ #theforeman requested that I file a bug report and provide
example code related to a possible 10x runtime slowdown when using apipie
to enumerate hosts via TheForeman API.

this repo contains nearly the bare minimum use-case. `$work` **requires**
Kerberos. I've produced a clever hack in `ext/net_http.rb` to enable Kerberos
for apipie (and anything else based on `Net::HTTP`).

I originally chose HTTPI because it supported `curb`, which is one of the only
Ruby HTTP libraries with Kerberos support. however, since HTTPI is generic, it
was trivial to run `Net::HTTP` + `ext/net_http.rb`. this combination seems to be
**faster** than HTTPI with `curb`, giving me confidence that `ext/net_http.rb`
does not introduce a significant performance hit.

here are some sample runs:

% bundle exec ./benchmark/apipie.rb https://theforeman.example.com
       user     system      total        real
   0.000000   0.000000   0.000000 (  0.000384)
   0.190000   0.020000   0.210000 (  2.443758)
  13.140000   0.570000  13.710000 (194.143426)

% bundle exec ./benchmark/httpi-curb.rb https://theforeman.example.com
       user     system      total        real
   0.000000   0.000000   0.000000 (  0.000007)
   0.010000   0.000000   0.010000 (  0.124643)
   0.860000   0.130000   0.990000 (  7.236611)

% bundle exec ./benchmark/httpi-net_http.rb https://theforeman.example.com
       user     system      total        real
   0.000000   0.000000   0.000000 (  0.000007)
   0.020000   0.010000   0.030000 (  0.236881)
   0.930000   0.090000   1.020000 (  6.479033)
