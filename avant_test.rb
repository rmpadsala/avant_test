require "./factors_and_caching/factors_and_caching"
require "./twitter_test/twitter_stream_collector"

# Run test 1
out_test_1 = AvantTest::FactorsAndCaching.new([10,2,5,20]).collect_factors
p "factors_and_caching output for ary ([10,2,5,20]) - #{out_test_1}"

# Run test 2
out_test_2 = AvantTest::TwitterStreamCollector.new().frequent_words
p "most frequent words in last 5 minutes #{out_test_2}"
