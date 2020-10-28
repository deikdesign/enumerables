require_relative '../lib/enumerables.rb'

describe Enumerable do
  describe '#my_each' do
    it 'my_each returns the self if the block is given' do
      expect([1, 2, 3].my_each { |n| n + 1 }).to eql([1, 2, 3])
    end

    it 'my_each returns the enumerator if the block is not given' do
      expect([1, 2, 3].my_each).to be_a(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'my_each_with_index returns the enumerator if the block is not given' do
      expect([1, 2, 3].my_each_with_index).to be_a(Enumerator)
    end

    it 'my_each_with_index returns the slef if the block is given' do
      expect([1, 2, 3].my_each_with_index { |val, ind| val + ind }).to eql([1, 2, 3])
    end
  end

  describe '#my_select' do
    it 'my_select returns the enumerator if the block is not given' do
      expect([1, 2, 3].my_select).to be_a(Enumerator)
    end

    it 'my_select returns the array which are the selected elements in block' do
      expect([1, 2, 3].my_select { |val| val > 1 }).to eql([2, 3])
    end
  end

  describe '#my_all?' do
    it 'my_all? returns true if self has no element' do
      expect([].my_all?).to eql(true)
    end

    it 'my_all? returns true if it has no parameter and all elements of self is true' do
      expect([1, 2, 3].my_all?).to eql(true)
    end

    it 'my_all? returns false if any of conditions in block is not true for every element of self' do
      expect([1, 2, 3].my_all? { |val| val != 1 }).to eql(false)
    end

    it 'my_all? returns true only if all of conditions in block is true for every element self' do
      expect([1, 2, 3].my_all? { |val| val < 4 }).to eql(true)
    end

    it 'my_all? returns true if it has parameter and all elements match that parameter' do
      expect([1, 1, 1].my_all?(1)).to eql(true)
    end

    it 'my_all? returns false if it has parameter and all elements does not match that parameter' do
      expect([1, 2, 1].my_all?(1)).to eql(false)
    end
  end

  describe '#my_any?' do
    it 'my_any? returns true if self has no element' do
      expect([].my_any?).to eql(true)
    end

    it 'my_any? returns true if condition in block is true for any element in self' do
      expect([1, 2, 3].my_any? { |val| val == 2 }).to eql(true)
    end

    it 'my_any? returns false if condition in block is false for every element in self' do
      expect([1, 2, 3].my_any? { |val| val == 4 }).to eql(false)
    end

    it 'my_any? returns true if block is not given and any element in self is true' do
      expect([false, true, false].my_any?).to eql(true)
    end

    it 'my_any? returns false if block is not given and all element in self is false' do
      expect([false, false, false].my_any?).to eql(false)
    end

    it 'my_any? returns true if any element in self matches the parameter' do
      expect([1, 2, 3].my_any?(1)).to eql(true)
    end

    it 'my_any? returns false if all the element in self does not matches the parameter' do
      expect([1, 2, 3].my_any?(4)).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'my_none? returns true if self has no element' do
      expect([].my_none?).to eql(true)
    end

    it 'my_none? returns true if condition in block is false for every element in self' do
      expect([1, 2, 3].my_none? { |val| val == 4 }).to eql(true)
    end

    it 'my_none? returns false if condition in block is true for any element in self' do
      expect([1, 2, 3].my_none? { |val| val == 3 }).to eql(false)
    end

    it 'my_none? returns false if block is not given and any element in self is true' do
      expect([false, true, false].my_none?).to eql(false)
    end

    it 'my_none? returns true if block is not given and all element in self is false' do
      expect([false, false, false].my_none?).to eql(true)
    end

    it 'my_none? returns false if any element in self matches the parameter' do
      expect([1, 2, 3].my_none?(1)).to eql(false)
    end

    it 'my_none? returns true if all the element in self does not matches the parameter' do
      expect([1, 2, 3].my_none?(4)).to eql(true)
    end
  end

  describe '#my_count' do
    it 'my_count returns the number of elements of self if no block, no parameter given' do
      expect([1, 2, 3].my_count).to eql(3)
    end

    it 'my_count returns the number of elements of self, satisfies the condition in block' do
      expect([1, 2, 3].my_count { |val| val > 1 }).to eql(2)
    end

    it 'my_count returns the number of elements of self, matches the parameter' do
      expect([1, 2, 3].my_count(1)).to eql(1)
    end
  end

  describe '#my_map' do
    it 'my_map returns enumerator if no block or no argument given' do
      expect([1, 2, 3].my_map).to be_a(Enumerator)
    end

    it 'my_map returns the array consits of elements of yeilded in block' do
      expect([1, 2, 3].my_map { |val| (val + 1) * 2 }).to eql([4, 6, 8])
    end
  end

  describe '#my_inject' do
    it 'my_inject does operation on the elements given in block and return its result' do
      expect([5, 6, 7, 8, 9, 10].my_inject { |sum, n| sum + n }).to eql(45)
    end
  end
end
