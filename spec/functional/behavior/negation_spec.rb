require "b_helper"

describe Lab42::Behavior do 

  context "#negated" do 
    let( :negated ){ subject.negated }
    shared_examples_for "negated behavior" do
      it{  expect( negated.(1) ).to eq true  }
      it{  expect( negated.(2) ).to eq false }
    end

    describe described_class::ProcBehavior do 
      let( :subject ){ described_class::ProcBehavior.new{ |x| x.even? } }
      it_behaves_like "negated behavior" 
    end # describe UnboundBehavior

    describe described_class::SendBehavior do 
      let( :subject ){ B :even?  }
      it_behaves_like "negated behavior" 
    end # describe UnboundBehavior

    describe described_class::UnboundBehavior do 
      let( :subject ){ Integer.fm.even?  }
      it_behaves_like "negated behavior" 
    end # describe UnboundBehavior

    describe described_class::BoundBehavior do 
      it{  expect( 1.fn.even?.negated.() ).to eq true  }
      it{  expect( 2.fn.even?.negated.() ).to eq false }
    end # describe BoundBehavior

  end # context "#negated"
end # describe Lab42::Behavior
