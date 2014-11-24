require 'benchmark'
require './factors_and_caching/factors_and_caching'

f_n_c_obj = AvantTest::FactorsAndCaching.new((1..10000).to_a)
Benchmark.bm do |x|
  x.report("collect_factors") { f_n_c_obj.collect_factors }
  x.report("collect_factors_no_cache") { f_n_c_obj.collect_factors_no_cache }
end
