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

tests were run one at a time and in order. tests were performed multiple times,
but no data analysis was done beyond visually ensuring the results "looked close"
between runs.

here are some sample runs:

    % bundle exec ./benchmark/apipie.rb https://theforeman.example.com
           user     system      total        real
       0.000000   0.000000   0.000000 (  0.000393)
       0.210000   0.010000   0.220000 (  3.783021)
      13.030000   0.460000  13.490000 (191.435855)
    Hosts collected: 78

    % bundle exec ./benchmark/httpi-curb.rb https://theforeman.example.com
           user     system      total        real
       0.000000   0.000000   0.000000 (  0.000009)
       0.010000   0.000000   0.010000 (  0.091757)
       0.770000   0.100000   0.870000 (  6.935639)
    Hosts collected: 78

    % bundle exec ./benchmark/httpi-net_http.rb https://theforeman.example.com
           user     system      total        real
       0.000000   0.000000   0.000000 (  0.000006)
       0.030000   0.000000   0.030000 (  0.110068)
       0.960000   0.120000   1.080000 (  6.727047)
    Hosts collected: 78
