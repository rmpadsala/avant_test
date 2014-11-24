DIR_PATHS = ["./factors_and_caching",
  "./twitter_test" ]

DIR_PATHS.each do |path|
  rb_all = Dir["#{path}/*.rb"]
  rb_all.each do |file|
    require file
  end
end
