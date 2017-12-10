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
        let( :subject ){ lhs | rhs }
        it "is a Behavior" do
          expect( subject ).to be_kind_of described_class
        end
        it "is a pipe order composition, and not a functional order composition (∘)" do
          expect( subject.( 1 ) ).to be_even
        end
      end

      context "of the same kind:" do
        context "SendBehavior" do 
          let( :lhs ){ B(:+, 1) }
          let( :rhs ){ B(:*, 2) }
          it_behaves_like "two behaviors"
        end # context "two SendBehaviors"
        context "BoundBehavior" do 
          let( :lhs ){ 1.fn.+ }
          let( :rhs ){ 2.fn.* }
          it_behaves_like "two behaviors"
        end # context "two BoundBehaviors"
        context "UnboundBehavior" do 
          let( :lhs ){ Fixnum.fm.+( 1 ) }
          let( :rhs ){ Fixnum.fm.*( 2 ) }
          it_behaves_like "two behaviors"
        end # context "two UnboundBehaviors"
        context "ProcBehavior" do
          let( :lhs ){ described_class::ProcBehavior.new{|x|x.succ} }
          let( :rhs ){ described_class::ProcBehavior.new{|x|x*2} }
          it_behaves_like "two behaviors"
        end
      end # context "it can combine two beahviors of the same kind"
      context "of different kinds" do 
        context "Send and..." do 
          let( :lhs ){ B(:+,1) }
          context "Bound" do 
            let( :rhs ){ 2.fn.* }
            it_behaves_like "two behaviors"
          end # context "Send and Bound"
          context "Unbound" do 
            let( :rhs ){ Fixnum.fm.*(2) }
            it_behaves_like "two behaviors"
          end # context "Send and Unbound"
          context "λ" do
            let( :rhs ){ ->(x){x*2} }
            it_behaves_like "two behaviors"
          end # context "Send and λ"
          context "Proc" do 
            let( :rhs ){ ->(x){x*2}.to_behavior }
            it_behaves_like "two behaviors"
          end # context "Send and Proc"
        end # context "Send and..."

        context "Unbound and ..." do
          let( :lhs ){ Fixnum.fm.+ 1 }
          context "Send" do 
            let( :rhs ){ B(:*,2) }
            it_behaves_like "two behaviors"
          end # context "Unbound and Send"
          context " Bound" do 
            let( :rhs ){ 2.fn.* }
            it_behaves_like "two behaviors"
          end
          context "Unbound and Proc" do 
            let( :rhs ){ ->(x){x*2}.to_behavior }
            it_behaves_like "two behaviors"
          end # context "Unbound and Proc"
          context "Unbound and λ" do 
            let( :rhs ){ ->(x){x*2} }
            it_behaves_like "two behaviors"
          end # context "Unbound and λ"
        end # context "Unbound and ..."

        context "Bound and..." do 
          let( :lhs ){ 1.fn.+ }
          context "Send" do
            let( :rhs ){ B(:*,2)  }
            it_behaves_like "two behaviors"
          end # context "Bound and Send"
          context "Unbound" do 
            let( :rhs ){ Fixnum.fm.*(2) }
            it_behaves_like "two behaviors"
          end # context "Bound and Unbound"
          context "Proc" do 
            let( :rhs ){ ->(x){x*2} }
            it_behaves_like "two behaviors"
          end # context "Bound and Proc"
          context "Bound and λ" do 
            let( :rhs ){ ->(x){x*2}}
            it_behaves_like "two behaviors"
          end # context "Bound and Proc"
        end # context "Bound and..."
      end # context "of different kinds"
    end # context "of two Behaviors"
  end # context "Composition"
end # contsext Lab42::Behavior::Composition
