require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Schrodinger's Cat" do

  specify 'SchrodingersCat class should be defined' do
    defined?(SchrodingersCat).should be_true
  end

  # describe Array do
  #   it { should respond_to :compact_with_schrodinger }
  # end

  describe SchrodingersCat do
    let(:original) { mock('original') }
    subject(:cat) { described_class.new(original) }

    it 'is modeled after nil' do
      described_class::MODEL_OBJECT.should be_nil
    end

    its(:dup) { should be_nil }
  end

  describe Object do
    before(:each) do
      subject.stub(:do_something => :result)
    end

    describe 'Basic responses' do
      %w(if_a? unless_a? only_if_a? only_unless_a? assuming_a if_equals_a?
         unless_equals_a? only_if_equals_a? only_unless_equals_a?
         assuming_equals_a if? unless? only_if? only_unless?).each do |meth|
        it { should respond_to meth.to_sym }
      end
    end

    describe '#if_a?' do
      it 'returns self for false check' do
        subject.if_a?(Numeric).do_something.should be subject
      end

      it 'calls chained method for true check' do
        subject.if_a?(Object).do_something.should == :result
      end

      it 'returns evaluated block for true check' do
        subject.if_a?(Object) { |o| o.do_something }.should == :result
      end

      context 'with custom :conditions' do
        it 'evaluates uses :conditions for truth check' do
          subject.if_a?(Numeric, :conditions => true).do_something.should == :result
          subject.if_a?(Numeric, :conditions => false).do_something.should be subject
        end
      end

      context 'with custom :check requested' do
        it 'calls the :check method instead of :is_one_kind_of?' do
          subject.should_receive(:some_check).with(Numeric)
          subject.if_a?(Numeric, :check => :some_check)
        end
      end

      context 'with :opposite conditions requested' do

        it 'returns self for true check' do
          subject.if_a?(Object, :opposite => true).do_something.should be subject
        end

        it 'calls chained method for false check' do
          subject.if_a?(Numeric, :opposite => true).do_something.should == :result
        end

        it 'returns evaluated block for false check' do
          subject.if_a?(Numeric, :opposite => true) { |o| o.do_something }.should == :result
        end
      end

      context 'with custom :else provided' do

        it 'returns self for true check' do
          subject.if_a?(Object, :else => :something_else).do_something.should == :result
        end

        it 'returns else for false check' do
          subject.if_a?(Numeric, :else => :something_else).do_something.should == :something_else
        end
      end

      context 'with custom :chain provided' do

        it 'returns a SchrodingersCat' do
          subject.if_a?(Numeric, :chain => true).do_something.should be_a SchrodingersCat
        end
      end
    end

    describe '#unless_a?' do
      it 'simply calls #if_a? with :opposite => true' do
        subject.should_receive(:if_a?).with(Numeric, hash_including(:opposite => true))
        subject.unless_a?(Numeric)
      end
    end

    describe '#only_if_a?' do
      it 'simply calls #if_a? with :else => nil' do
        subject.should_receive(:if_a?).with(Numeric, hash_including(:else => nil))
        subject.only_if_a?(Numeric)
      end
    end

    describe '#only_unless_a?' do
      it 'simply calls #only_if_a? with :opposite => true' do
        subject.should_receive(:only_if_a?).with(Numeric, hash_including(:opposite => true))
        subject.only_unless_a?(Numeric)
      end
    end

    describe '#assuming_a' do
      it 'simply calls #if_a? with :chain => true' do
        subject.should_receive(:if_a?).with(Numeric, hash_including(:chain => true))
        subject.assuming_a(Numeric)
      end
    end

    describe '#if_equals_a?' do
      it 'simply calls #if_a? with :check => :is_included_in?' do
        subject.should_receive(:if_a?).with(Numeric, hash_including(:conditions))
        subject.if_equals_a?(Numeric)
      end
    end

    describe '#unless_equals_a?' do
      it 'simply calls #if_equals_a? with :opposite => true' do
        subject.should_receive(:if_equals_a?).with(Numeric, hash_including(:opposite => true))
        subject.unless_equals_a?(Numeric)
      end
    end

    describe '#only_if_equals_a?' do
      it 'simply calls #if_equals_a? with :else => nil' do
        subject.should_receive(:if_equals_a?).with(Numeric, hash_including(:else => nil))
        subject.only_if_equals_a?(Numeric)
      end
    end

    describe '#only_unless_equals_a?' do
      it 'simply calls #unless_equals_a? with :else => nil' do
        subject.should_receive(:unless_equals_a?).with(Numeric, hash_including(:else => nil))
        subject.only_unless_equals_a?(Numeric)
      end
    end

    describe '#assuming_equals_a' do
      it 'simply calls #if_equals_a? with :chain => true' do
        subject.should_receive(:if_equals_a?).with(Numeric, hash_including(:chain => true))
        subject.assuming_equals_a(Numeric)
      end
    end

    describe '#if?' do
      it 'simply calls #if_a? with :conditions => something' do
        Object.any_instance.stub(:resolve_conditions => :resolved_conditions)
        subject.should_receive(:if_a?).with(hash_including(:conditions => :resolved_conditions))
        subject.if?(:varied)
      end
    end

    describe '#unless?' do
      it 'simply calls #if? with :opposite => true' do
        subject.should_receive(:if?).with(:varied, hash_including(:opposite => true))
        subject.unless?(:varied)
      end
    end

    describe '#only_if?' do
      it 'simply calls #if? with :else => nil' do
        subject.should_receive(:if?).with(:varied, hash_including(:else => nil))
        subject.only_if?(:varied)
      end
    end

    describe '#only_unless?' do
      it 'simply calls #only_if? with :opposite => true' do
        subject.should_receive(:only_if?).with(:varied, hash_including(:opposite => true))
        subject.only_unless?(:varied)
      end
    end
  end # / describe Object

  describe 'Real world examples' do
    let(:hash) { { :a => 3 } }

    describe '#if_a?' do

      it 'checks false and returns self despite method' do
        hash.if_a?(Numeric).keys.should == hash
      end

      it 'checks true and calls the chained method' do
        hash.if_a?(Hash).keys.should == [:a]
      end

      it 'checks true and returns the result of block' do
        hash.if_a?(Hash) { |h| h.keys }.should == [:a]
      end
    end

    describe '#unless_a?' do

      it 'checks false and returns self despite method' do
        hash.unless_a?(Hash).keys.should == hash
      end

      it 'checks true and calls the chained method' do
        hash.unless_a?(Numeric).keys.should == [:a]
      end

      it 'checks true and returns the result of block' do
        hash.unless_a?(Numeric) { |h| h.keys }.should == [:a]
      end
    end

    describe '#only_if_a?' do

      it 'checks false and returns nil' do
        hash.only_if_a?(String).to_sym.should be_nil
      end

      it 'checks true and calls the method' do
        hash.only_if_a?(Hash).keys.should == [:a]
      end
    end

    describe '#only_unless_a?' do

      it 'checks false and returns nil' do
        hash.only_unless_a?(Hash).to_sym.should be_nil
      end

      it 'checks true and calls the method' do
        hash.only_unless_a?(String).keys.should == [:a]
      end
    end

    describe '#assuming_a' do

      it 'allows chaining of methods without error even if check was false' do
        expect { hash.assuming_a(String).upcase.capitalize.downcase
          }.not_to raise_error
      end

      it 'returns a SchrodingersCat if check was false' do
        result = hash.assuming_a(String).upcase.capitalize.downcase
        result.should be_a SchrodingersCat
        result.inspect.should == 'nil'
      end
    end

    describe '#if_equals_a?' do

      it 'checks false and returns self' do
        hash.if_equals_a?({ 'a' => 4 }).keys.should be hash
        3.if_equals_a?(4).keys.should == 3
      end

      it 'checks true and calls the method' do
        # hash.if_equals_a?({ 'a' => 4 }, { :a => 4 }).keys.should == [:a] # FIXME: merging options assumes the latest of arguments is not an arg but an option...
        3.if_equals_a?(0, 3).succ.should == 4
      end
    end

    describe '#unless_equals_a?' do

      it 'checks false and returns self' do
        3.unless_equals_a?(3).keys.should == 3
      end

      it 'checks true and calls the method' do
        3.unless_equals_a?(0, 1).succ.should == 4
      end
    end

    describe '#only_if_equals_a?' do

      it 'checks false and returns nil' do
        3.only_if_equals_a?(4).keys.should be_nil
      end

      it 'checks true and calls the method' do
        3.only_if_equals_a?(1, 2, 3).succ.should == 4
      end
    end

    describe '#only_unless_equals_a?' do

      it 'checks false and returns nil' do
        3.only_unless_equals_a?(3, 4).keys.should be_nil
      end

      it 'checks true and calls the method' do
        3.only_unless_equals_a?(1, 2).succ.should == 4
      end
    end

    describe '#assuming_equals_a' do

      it 'checks false and returns SchrodingersCat' do
        3.assuming_equals_a(4).succ.succ.succ.should be_a SchrodingersCat
      end

      it 'checks true and calls the chained methods' do
        3.assuming_equals_a(3).succ.succ.succ.should == 6
      end
    end

    describe '#if?' do

      it 'checks custom predicate symbol' do
        3.if?(:odd?).succ.should == 4
        3.if?(:even?).succ.should == 3
      end

      it 'checks custom predicate symbol with a method' do
        3.if?([:is_a?, Numeric]).succ.should == 4
        3.if?([:is_a?, Array]).first.should == 3
      end

      it 'checks the return of sending receiver an arbitrary method supplied as String beginning with a period' do
        3.if?('.succ.even?').succ.should == 4
        3.if?('.succ.odd?').succ.should == 3
      end

      it 'checks the return of arbitrary method supplied as String' do
        3.if?('Date.new.is_a?(Date)').succ.should == 4
        3.if?('Date.new.is_a?(String)').succ.should == 3
      end
    end

    # No need to belabor the point. You get it, right?
    # describe '#unless?'
    # describe '#only_if?'
    # describe '#only_unless?'
  end

end
