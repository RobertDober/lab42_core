require "b_helper"

context Lab42::Behavior do 
  context "Composition" do 
    context "parameterless compostion (side effects ☹a)" do 
      it{ expect( (->{}.to_behavior | ->{}.to_behavior).() ).to be_nil }
    end # context "parameterless compostion (side effects ☹a)"
    context "array returning composition (careful with *)" do 
      let( :adder ){ Array.fm.<< :end }
      let( :reverser ){ Array.fm.reverse }
      let( :subject ){ adder | reverser }
      it "does not lose the arrays" do
        expect( subject.([:begin]) ).to eq [:end, :begin]
      end
    end # context "array returning composition (careful with *)"

    context "of two Behaviors" do 
      shared_examples_for "two behaviors" do
        it "is a Behavior" do
          expect( subject ).to be_kind_of described_class
        end
        it "is a pipe order composition, and not a functional order composition (∘)" do
          expect( subject.( 1 ) ).to be_even
        end
      end
      context "of the same kind:" do 
        context "SendBehavior" do 
          let( :subject ){ B(:+, 1) | B(:*, 2) }
          it_behaves_like "two behaviors"
        end # context "two SendBehaviors"
        context "BoundBehavior" do 
          let( :subject ){ 1.fn.+ | 2.fn.* }
          it_behaves_like "two behaviors"
        end # context "two BoundBehaviors"
        context "UnboundBehavior" do 
          let( :subject ){ Fixnum.fm.+( 1 ) | Fixnum.fm.*( 2 ) }
          it_behaves_like "two behaviors"
        end # context "two UnboundBehaviors"
        context "ProcBehavior" do
          let( :subject ){ described_class::ProcBehavior.new{|x|x.succ} | described_class::ProcBehavior.new{|x|x*2} }
          it_behaves_like "two behaviors"
        end
      end # context "it can combine two beahviors of the same kind"
    end # context "of two Behaviors"
  end # context "Composition"
end # context Lab42::Behavior::Composition
