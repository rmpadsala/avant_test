require "spec_helper"

describe "FactorsAndCaching" do
  describe "instance_methods" do
    let (:object) { AvantTest::FactorsAndCaching.new([]) }
    it "should respond to instance methods" do
      expect(object).to respond_to(:collect_factors)
    end
  end

  describe "test factors" do
    it "number should return all the factors in sorted order" do
      expect(2.factors).to eq([1, 2])
      expect(5.factors).to eq([1, 5])
      expect(10.factors).to eq([1, 2, 5, 10])
      expect(20.factors).to eq([1, 2, 4, 5, 10, 20])
      expect(500.factors).to eq([1, 2, 4, 5, 10, 20, 25, 50, 100, 125, 250, 500])
      expect(50000.factors).to eq([1, 2, 4, 5, 8, 10, 16, 20, 25, 40, 50, 80, 100, 125, 200, 250, 400, 500, 625, 1000, 1250, 2000, 2500, 3125, 5000, 6250, 10000, 12500, 25000, 50000])
    end
  end

  describe ".collect_factors" do
    describe "for each element in an array it should return all the intergers that are factors of an element" do
      context "empty input array" do
        let (:object) { AvantTest::FactorsAndCaching.new([]) }
        it { expect(object.collect_factors).to eq({}) }
      end

      context "test-1 input array([10,2,5,20])" do
        let (:object) { AvantTest::FactorsAndCaching.new([10,2,5,20]) }
        it "should return correct result hash" do
          hash = object.collect_factors
          expect(hash[2]).to eq([])
          expect(hash[5]).to eq([])
          expect(hash[10]).to eq([2,5])
          expect(hash[20]).to eq([2,5,10])
        end
      end

      context "test-2 input array([10, 2, 5, 20, 4, 25, 75, 48, 46, 21, 7, 9, 3, 13, 18])" do
        let (:object) { AvantTest::FactorsAndCaching.new([10, 2, 5, 20, 4, 25, 75, 48, 46, 21, 7, 9, 3, 13, 18]) }
        it "should return correct result hash" do
          hash = object.collect_factors
          expect(hash[2]).to eq([])
          expect(hash[5]).to eq([])
          expect(hash[13]).to eq([])
          expect(hash[75]).to eq([3,5,25])
          expect(hash[46]).to eq([2])
          expect(hash[21]).to eq([3,7])
        end
      end
    end
  end
end
