# min priroty queue implementation. Each item in the queue is
# an object with string and frequency attribute. Proirity is
# determined using frequency attribute. Object with lowest frequency
# value will be the first one in the queue.
module AvantTest
  class MinPriorityQueue
    QueueElement = Struct.new(:word, :frequency)

    attr_reader :priority_q

    def initialize
      @queue = [nil]
    end

    def size
      @queue.size
    end

    def empty?
      @queue.compact.empty?
    end

    def priority_q
      @queue.compact
    end

    def insert(item)
      # insert item at the end of the queue and while maintaining heap variance
      @queue << item
      promote(@queue.size-1)
      item
    end

    def peek
      # get minimum item value
      raise "queue is empty" if empty?
      @queue[1]
    end

    def delete_min
      # delete minimum value (root) from binary heap and update queue so that heap property
      # satisfies
      raise "queue is empty" if empty?
      min = @queue[1]
      @queue[1], @queue[size-1] = @queue[size-1], @queue[1]
      @queue.pop # remove last element
      demote(1)
      min
    end

    private
      def compare(left, right)
        left.frequency <=> right.frequency
      end

      def greater(left, right)
        compare(left, right) > 0
      end

      def promote(k)
        while (k > 1 && greater(@queue[k/2], @queue[k]))
          @queue[k/2], @queue[k] = @queue[k], @queue[k/2]
          k = k/2
        end
      end

      def demote(k)
        while (2*k <= size-1)
          j = 2*k
          j += 1 if (j < size - 1  && greater(@queue[j], @queue[j+1]))

          break unless greater(@queue[k], @queue[j])

          @queue[k], @queue[j] = @queue[j], @queue[k]
          k = j
        end
      end
  end
end
