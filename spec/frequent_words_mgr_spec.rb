require "spec_helper"

describe "FactorsAndCaching" do
  describe "instance_methods" do
    let (:object) { AvantTest::FrequentWordsMgr.new({}) }
    it "should respond to instance methods" do
      expect(object).to respond_to(:frequent_words)
    end
  end

  describe ".frequent_words" do
    context "empty input hash" do
      let (:object) { AvantTest::FrequentWordsMgr.new({}) }
      it { expect(object.frequent_words).to eq([]) }
    end

    context "max 2 frequent words" do
      let (:hash) { {"I" => 14, "like" => 3, "meow" => 3, "cat" => 1, "foo" => 100, "geek" => 3 } }
      let (:object) { AvantTest::FrequentWordsMgr.new(hash, 2) }

      it { expect(object.frequent_words).to eq([["foo", 100], ["I", 14]]) }
    end

    context "max 5 frequent words" do
      let (:hash) { {"I" => 14, "like" => 3, "meow" => 4, "cat" => 1, "foo" => 100, "geek" => 7 } }
      let (:object) { AvantTest::FrequentWordsMgr.new(hash, 5) }

      it { expect(object.frequent_words).to eq([["foo", 100], ["I",14], ["geek",7], ["meow",4], ["like", 3]])}
    end

    context "max 10 frequent words" do
      let (:hash) { {"I" => 14, "like" => 3, "meow" => 4, "cat" => 1, "foo" => 100, "geek" => 7 } }
      let (:object) { AvantTest::FrequentWordsMgr.new(hash) }

      it { expect(object.frequent_words).to eq([["foo", 100], ["I",14], ["geek",7], ["meow",4], ["like", 3], ["cat",1]])}
    end
  end
end
