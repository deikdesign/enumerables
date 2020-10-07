module Enumerable
  # my_each
  def my_each(&block)
    arr = self
    arr = arr.to_a if self.class == Range || arr.is_a?(Hash)
    count = 0
    if arr.is_a?(Hash)
      while count < arr.length
        yield arr[i][0], arr[i][1]
        count += 1
      end
      self
    elsif block
      while count < arr.length
        yield arr[count]
        count += 1
      end
      self
    else
      "\#<Enumerator: #{self}:my_each>"
    end
  end

  # my_each_with_index
  def my_each_with_index(&block)
    arr = self
    arr = arr.to_a if self.class == Range || arr.is_a?(Hash)
    count = 0
    if arr.is_a?(Hash)
      while count < arr.length
        yield arr[i], count
        count += 1
      end
      self
    elsif block
      while count < arr.length
        yield arr[count], count
        count += 1
      end
      self
    else
      "\#<Enumerator: #{self}:my_each_with_index>"
    end
  end

  # my_select
  def my_select(&block)
    return "\#<Enumerator: #{self}:my_select>" unless block

    
    temp = []
    self.my_each { |num| temp.push(num) if yield(num) }
    temp
  end

  # my_all
  def my_all?(paramet = nil)
    arr = self
    return true if arr.empty?

    if paramet.nil? && block_given?
      arr.my_each do |n|
        ans = yield n
        return false if ans == false
      end
    elsif paramet.nil? && !block_given?
      arr.my_each { |n| return false if n.nil? || !n }
    elsif paramet.is_a?(Regexp)
      arr.my_each { |x| return false unless x.match(paramet) }
    elsif paramet.is_a?(Module)
      my_each { |x| return false if x.is_a?(paramet) }
    else
      my_each { |x| return false if x != paramet }
    end
    true
  end

  # my_any
  def my_any?(paramet = nil)
    arr = self
    return true if arr.empty?

    if paramet.nil? && block_given?
      arr.my_each do |n|
        ans = yield n
        return true if ans == true
      end
    elsif paramet.nil? && !block_given?
      arr.my_each { |n| return true if !!n == true && !n.nil? }
    elsif paramet.is_a?(Regexp)
      arr.my_each { |x| return true if x.match(paramet) }
    elsif paramet.is_a?(Module)
      my_each { |x| return true if x.is_a?(paramet) }
    else
      my_each { |x| return true if x == paramet }
    end
    false
  end

  # my_none
  def my_none?(paramet = nil)
    arr = self
    return true if arr.empty?

    if paramet.nil? && block_given?
      arr.my_each do |n|
        ans = yield n
        return false if ans == true
      end
    elsif paramet.nil? && !block_given?
      arr.my_each { |n| return false if !!n == true && !n.nil? }
    elsif paramet.is_a?(Regexp)
      arr.my_each { |x| return false if x.match(paramet) }
    elsif paramet.is_a?(Module)
      my_each { |x| return false if x.is_a?(paramet) }
    end
    true
  end

  # my_count
  def my_count(para = nil)
    arr = self
    if para.nil? && !block_given?
      counter = 0
      arr.my_count { counter += 1 }
      counter
    elsif !para.nil? && !block_given?
      counter = 0
      arr.my_each { |x| counter += 1 if x == para }
      counter
    elsif para.nil? && block_given?
      counter = 0
      arr.my_each { |x| counter += 1 if yield x }
      counter
    end
  end

  # my_map
  def my_map(proc = nil)
    return to_enum unless block_given? || proc

    arr = self
    new_arr = []
    if proc
      arr.my_each { |num| new_arr.push(proc.call(num)) }
    else
      arr.my_each { |num| new_arr.push(yield(num)) }
    end
    new_arr
  end

  # my_inject
  def my_inject(startt = nil)
    arr = self
    if startt.nil? && block_given?
      i = 1
      sum = arr[0]
      while i < arr.length
        sum = yield sum, arr[i]
        i += 1
      end
      sum
    elsif !startt.nil? && block_given?
      i = 0
      sum = startt
      while i < arr.length
        sum = yield sum, arr[i]
        i += 1
      end
      sum
    else
      0
    end
  end
end

public

def multiply_els(arr)
  arr.my_inject { |result, element| result * element }
end
