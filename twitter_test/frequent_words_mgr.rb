require_relative "min_priority_queue"

module AvantTest
  # Algorithm
  # 1. consturct the hash of words from twitter api stream.
  # 2. iterate the hash and insert items into min_priority_queue while maintaining
  #    size of min_priority_queue = max_frequent_word_count
  class FrequentWordsMgr
    MAX_FREQUENT_WORD_COUNT = 10

    def initialize(words_hash, max_frequent_word_count = MAX_FREQUENT_WORD_COUNT)
      @words_hash = words_hash
      @freq_word_q = MinPriorityQueue.new
      @max_frequent_word_count = max_frequent_word_count
    end

    def frequent_words
      @words_hash.each { |word, frequency|
        @freq_word_q.insert(MinPriorityQueue::QueueElement.new(word, frequency))
        @freq_word_q.delete_min if (@freq_word_q.size - 1) > @max_frequent_word_count
      }

      @freq_word_q.priority_q.sort_by { |item| item.frequency }.reverse.map { |item| item.word }
    end
  end
end
