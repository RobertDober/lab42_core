require 'spec_helper'


describe File do
  let( :path ){ double }
  let( :block ){ double }
  let( :file ){ double }

  context 'file is writable' do 
    before do
      expect( File ).to receive( :writable? ).with( path ).and_return true
    end
    context 'method' do 
      it "executes block with arity 0" do
        block_proc = ->{}
        expect( block ).to receive( :to_proc ).and_return block_proc
        expect( block_proc ).to receive( :call ).with( no_args )
        File.if_writable path, &block
      end

      it "executes block with arity other than 0 by passing an open file, which will be closed" do
        block_proc = ->(a){}
        expect( File ).to receive( :open ){ |pth, mode, &blk|
          expect( pth ).to eq path
          expect( mode ).to eq 'a'
          expect( blk ).to eq block_proc
        }
        expect( block ).to receive( :to_proc ).and_return block_proc
        File.if_writable path, &block
      end

      it "returns a once executing enumerator" do
        e = File.if_writable path
        expect( e ).to be_kind_of Enumerator
        expect( e.next ).to eq path
        expect{ e.next }.to raise_error StopIteration
      end
    end # context 'method'
  end # context file is writable'

  context 'file is not writable' do 
    let( :block_proc ) { ->{ raise RuntimeError, "I shall not be called" } }
    before do
      expect( File ).to receive( :writable? ).with( path ).and_return false
    end
    it 'does not execute the block' do
      expect( block ).to receive(:to_proc).and_return block_proc
      File.if_writable path, &block
    end
    it 'returns an empty Enumerator' do
      e = File.if_writable path
      expect( e ).to be_kind_of Enumerator
      expect{ e.next }.to raise_error StopIteration
    end
  end # context 'file is not writable'

end
