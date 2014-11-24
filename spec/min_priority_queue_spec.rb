require 'spec_helper'

describe "MinPriorityQueue" do
  before :each do
    @object = AvantTest::MinPriorityQueue.new
  end

  describe "instance_methods" do
    it "should respond to instance methods" do
      expect(@object).to respond_to(:empty?)
      expect(@object).to respond_to(:priority_q)
      expect(@object).to respond_to(:insert)
      expect(@object).to respond_to(:peek)
      expect(@object).to respond_to(:delete_min)
      expect(@object.private_methods.include?(:promote)).to be true
      expect(@object.private_methods.include?(:demote)).to be true
    end
  end

  describe ".insert" do
    before {
      @object.insert(AvantTest::MinPriorityQueue::QueueElement.new("banana", 10))
      @object.insert(AvantTest::MinPriorityQueue::QueueElement.new("orange", 5))
      @object.insert(AvantTest::MinPriorityQueue::QueueElement.new("grapes", 3))
      @object.insert(AvantTest::MinPriorityQueue::QueueElement.new("apple", 6))
    }

    it { expect(@object.priority_q[0].word).to eq("grapes") }
    it { expect(@object.priority_q[0].frequency).to eq(3) }

    it { expect(@object.priority_q[1].word).to eq("apple") }
    it { expect(@object.priority_q[1].frequency).to eq(6) }

    it { expect(@object.priority_q[2].word).to eq("orange") }
    it { expect(@object.priority_q[2].frequency).to eq(5) }

    it { expect(@object.priority_q[3].word).to eq("banana") }
    it { expect(@object.priority_q[3].frequency).to eq(10) }
  end

  describe ".delete_min" do
    before {
      @object.insert(AvantTest::MinPriorityQueue::QueueElement.new("banana", 10))
      @object.insert(AvantTest::MinPriorityQueue::QueueElement.new("orange", 5))
      @object.insert(AvantTest::MinPriorityQueue::QueueElement.new("grapes", 3))
      @object.insert(AvantTest::MinPriorityQueue::QueueElement.new("apple", 6))
    }

    it {
      min = @object.delete_min
      expect(@object.priority_q[0].word).to eq("orange")
      expect(@object.priority_q[0].frequency).to eq(5)

      expect(@object.priority_q[1].word).to eq("apple")
      expect(@object.priority_q[1].frequency).to eq(6)

      expect(@object.priority_q[2].word).to eq("banana")
      expect(@object.priority_q[2].frequency).to eq(10)
    }

    it {
      min = @object.delete_min
      min = @object.delete_min

      expect(@object.priority_q[0].word).to eq("apple")
      expect(@object.priority_q[0].frequency).to eq(6)

      expect(@object.priority_q[1].word).to eq("banana")
      expect(@object.priority_q[1].frequency).to eq(10)
    }
  end
end
