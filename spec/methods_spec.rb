# require '../lib/enumerables.rb'
require '../lib/enumerables'

describe Enumerable do
  let(:array) { [1, 2, 3, 4, 5] }
  let(:range) { (0..5) }
  let(:hash) { { a: 1, b: 2, c: 3 } }
  let(:my_proc) { proc { |num| num + 1 } }

  describe '#my_each' do
    it 'return correct array' do
      expect(array.my_each { |i| i > 2 }).to eql(array)
    end
    it 'check if it is accepting range' do
      expect(range.my_each { |i| i > 2 }).to eql(range)
    end
    it 'check if it is accepting hash' do
      expect(hash.my_each { |i| i }).to eql(hash)
    end
    it 'when block is not given return Enumerator' do
      expect(array.my_each).to be_an(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'return correct array' do
      expect(hash.my_each_with_index { |i, _ind| i }).to eql(hash)
    end
    it 'check if it is accepting range' do
      expect(range.my_each_with_index { |i, _ind| i > 2 }).to eql(range)
    end
    it 'check if it is accepting hash' do
      expect(hash.my_each_with_index { |i, _ind| i }).to eql(hash)
    end
    it 'when block is not given return Enumerator' do
      expect(array.my_each_with_index).to be_an(Enumerator)
    end
  end

  describe '#my_select' do
    it 'when block is not given return Enumerator' do
      expect(array.my_each_with_index).to be_an(Enumerator)
    end

    it 'returns to an array' do
      expect(array.my_select { |num| num > 3 }).to eql([4, 5])
    end

    it 'returns an array into a range' do
      expect(array.my_select { |num| num < 3 }).to eql([1, 2])
    end

    it 'returns an array into a hash' do
      expect(hash.my_select { |_num, value| value > 2 }).to eql([[:c, 3]])
    end
  end

  describe '#my_all' do
    it 'if all value for an array are true return true' do
      expect(array.my_all? { |n| n > 2 }).to eql false
    end

    it 'if all value are false for an array return false' do
      expect(array.my_all? { |n| n > 6 }).to eql false
    end

    it 'return false when one value is false in a range' do
      expect(range.my_all? { |n| n > 2 }).to eql false
    end

    it 'return true when all values are true ' do
      expect(range.my_all?(&:zero?)).to eql true
    end

    it 'return true when all values are true in a hash' do
      expect(hash.my_all? { |n| n <=> 0 }).to eql true
    end

    it 'return false when one value is false in a hash' do
      expect(hash.my_all? { |n| n == 3 }).to eql false
    end
  end

  describe '#my_any?' do
    it 'return true when any value is true on the array' do
      expect(array.my_any? { |n| n > 2 }).to eql true
    end

    it 'return false when no value is true on the array' do
      expect(array.my_any? { |n| n > 6 }).to eql false
    end

    it 'return true when any value is true on the range' do
      expect(range.my_any? { |n| n > 2}).to eql true
    end

    it 'return false when no value is true on the range' do
      expect(range.my_any? { |n| n > 6}).to eql false
    end

    it 'return false when any value is true on a hash' do
      expect(hash.my_any? { |_n, value| value > 2}).to eql true
    end

    it 'return false when no value is true on a hash' do
      expect(hash.my_any? { |_n, value| value > 6}).to eql false
    end
  end

  describe '#my_none?' do
    it 'return true when no value is true on an array' do
      expect(range.my_none? { |n| n > 6}).to eql true
    end

    it 'return true when any value is true on an array' do
      expect(range.my_none? { |n| n > 2}).to eql false
    end

    it 'return false when any value is true on a range' do
      expect(range.my_none? { |n| n > 6}).to eql true
    end

    it 'return false when any value is false on a range' do
      expect(range.my_none? { |n| n > 2}).to eql false
    end

    it 'return true when no value is true on a range' do
      expect(range.my_none? { |key, _value| key > 6}).to eql true
    end

    it 'return true when all values are false on the hash' do
      expect(range.my_none? { |key, _value| key > 6}).to eql true
    end
  end

  describe '#my_count?' do
    it 'return to an array when no block  and no argument are given' do
      expect(array.my_count).to eql(5)
    end

    it 'elements in a range when no block  and no argument are given' do
      expect(range.my_count).to eql(6)
    end

    it 'elements in a hash when no block  and no argument are given' do
      expect(hash.my_count).to eql(3)
    end

    it 'return elements when block is given' do
      expect(array.my_count { |x| x == 2}).to eql(1)
    end

    it 'return elements are equal to arg value' do
      expect(array.my_count(1)).to eql(1)
    end
  end

  describe '#my_map?' do
    it 'array for each element of an array' do
      expect(array.my_map { |num| num * 2}).to eql([2, 4, 6, 8, 10])
    end

    it 'array for each element of a range' do
      expect(range.my_map { |num| num * 2}).to eql([0, 2, 4, 6, 8, 10])
    end

    it 'return to an Enumerator when there is not given block' do
      expect(array.my_map).to be_an(Enumerator)
    end

    it 'accepts a proc' do
      expect(array.my_map(&my_proc)).to eql([2, 3, 4, 5, 6])
    end
  end

  describe '#my_inject?' do
    it 'symbol in an inject array' do
      expect(array.my_inject(0, :+)).to eql 15
    end

    it 'inject arr with vlaue and symbol' do
      expect(array.my_inject(0, :+)).to eql 15
    end

    it 'inject arr with symbol' do
      expect(array.my_inject(:*)).to eql 120
    end

    it 'inject arr with vlaue and symbol' do
      expect(array.my_inject(1, :*)).to eql 120
    end

    it 'inject arr if the block is given' do
      expect(array.my_inject { |item, int| item + int }).to eql 15
    end

    it 'inject range if the block is given' do
      expect(range.my_inject { |sum, num| sum + num }).to eql 15
    end

    it 'inject enumerator if arg is given' do
      expect(range.my_inject).to be_an(Enumerator)
    end
  end
end
