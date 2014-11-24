# monkey patch integer class to return factors of given integer
class Integer
  # runtime (O(sqrt n))
  def factors
    1.upto(Math.sqrt(self)).select { |i| (self % i).zero? }.inject([]) do |f, i|
      f << i
      f << self/i unless i == self/i
      f
    end.sort
  end
end

module AvantTest
  # Algorithm Description
  # 1. Sort input ary in descending order
  #    starting from highest element will help us cache values for lower elements in the input ary
  #    we can also use binary search on sorted ary (if needed)
  # 2. For each input element in sorted ary and construct result hash
  #    a) collect all the factors of that element
  #    b) foreach factor, run binary search on input ary and check if element is present or not
  #       if present that add it to the resultant hash keyed off of element
  #    c) While computing step b) if element is present the input ary then follow step a) and b) for
  #       this value so that we can cach the factors and eleminate the need for recomputing it again
  #       when same element is encountered.
  class FactorsAndCaching
    def initialize(ary)
      @input = Array.new(ary)
      # sort input array in descending order first (nlogn)
      @input.sort! {|x, y| y <=> x}
    end

    def collect_factors
      # run time O (n (sqrt(n) + f log n) where f is number of factors of a number
      @input.inject({}) { |result, elem|
        elem_factors = elem.factors
        # remove last element from factors ary as it's the same element
        elem_factors.pop

        # check if we have aleardy computed the factors of given element if so
        # skip the computation
        if !result.has_key?(elem)
          out_ary = []
          elem_factors.each { |e_f|
            unless @input.bsearch { |x| x - e_f }.nil?
              e_f_factors = e_f.factors
              e_f_factors.pop
              result[e_f] = e_f_factors.select {
                |item| !@input.bsearch { |x| x - item }.nil?
              } unless result.has_key?(e_f)
              out_ary << e_f
            end
          }
          result[elem] = out_ary
        else
          # p "skiping computation for #{elem}"
        end
        result
      }
    end

    def collect_factors_no_cache
      # run time O (n (sqrt(n) + f log n) where f is number of factors of a number
      @input.inject({}) { |result, elem|
        elem_factors = elem.factors
        # remove last element from factors ary as it's the same element
        elem_factors.pop
        # check if we have aleardy computed the factors of given element if so
        # skip the computation (this will skip computation only if element recurrs
        # in input ary)
        result[elem] = elem_factors.select {
          |item| !@input.bsearch { |x| x - item }.nil?
        } unless result.has_key?(elem)
        result
      }
    end
  end
end
