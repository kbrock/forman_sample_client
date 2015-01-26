This leverages the sample clients from theforeman-apipie-bugreport

It added a sample from foreman_api. So people can compare a few usecases for fetching data from foreman

All versions are comperable.

 % bundle exec ./benchmark/httpi-net_http.rb https://theforeman.example.com
       user     system      total        real
   0.000000   0.000000   0.000000 (  0.000006)
   0.000000   0.000000   0.000000 (  0.138969)
   0.020000   0.010000   0.030000 (  4.615861)
Hosts collected: 20
 % bundle exec ./benchmark/api.rb https://theforeman.example.com
       user     system      total        real
   0.000000   0.000000   0.000000 (  0.000006)
   0.010000   0.000000   0.010000 (  0.891452)
   0.050000   0.010000   0.060000 (  4.256251)
Hosts collected: 20
 % bundle exec ./benchmark/apipie.rb https://theforeman.example.com
       user     system      total        real
   0.000000   0.000000   0.000000 (  0.000309)
   0.050000   0.010000   0.060000 (  1.270242)
   0.150000   0.010000   0.160000 (  4.180101)
Hosts collected: 20
 % bundle exec ./benchmark/httpi-curb.rb https://theforeman.example.com
