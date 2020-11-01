require "lab42/core/record"
context Kernel.method(:Record) do
  context "simple case" do
    let :implementation do
      Record(:name, :age, sex: :female)
    end
    let(:subject) { implementation.new(name: "me", age: 42) }
    let(:values) { [subject.name, subject.age, subject.sex] }
    
    it "can be constructed" do
      subject
    end

    it "has the correct values" do
      expect(values).to eq(["me", 42, :female])
    end

    it "is mutable" do
      subject.sex = :other
      subject.age = 55
      expect(values).to eq(["me", 55, :other])
    end

    it "needs all required values" do
      expect{ implementation.new(name: "me") }.to raise_error(ArgumentError, /missing required keys: \[:age\]/ )
    end

    it "does not accept other values" do
      expect{ implementation.new(unknown: 1, name: "me", age: 0) }.to raise_error(ArgumentError, /forbidden args: \[:unknown\]/ )
      
    end
  end
end
