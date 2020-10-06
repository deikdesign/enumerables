module Enumerable
  # my_each
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = self
    i = 0
    while i < arr.length
      yield arr[i]
      i += 1
    end
  end

  #my_each_with_index 
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    arr = self
    i = 0
    while i < arr.length
      yield arr[i], i
      i += 1
    end
  end

  #my_select
  def my_select
    return to_enum(:my_select) unless block_given?

    temp_arr=[]
    arr = self
    arr.my_each do |num|
      ans = yield num
      temp_arr.push(num) if ans == true
    end
    temp_arr
  end

  #my_all
  def my_all?(paramet = nil)
    arr = self
    return true if arr.empty?

    if paramet.nil? && block_given?
      arr.my_each do |n|
        ans = yield n
        return false if ans == false
      end
    return true
    elsif paramet.nil? && !block_given?
      arr.my_each { |n| return false if n.nil? || !n }
    return true
    elsif paramet.is_a?(Regexp)
      arr.my_each { |x| return false if !x.match(paramet) }
    return true
    elsif paramet.is_a?(Module)
      my_each { |x| return false if x.is_a?(paramet) }
    return true
    else
      my_each { |x| return false if x != paramet }
    return true
    end
    return false
  end

  #my_any
  def my_any?(paramet = nil)
    arr = self
    return true if arr.empty?
    if paramet.nil? && block_given?
      arr.my_each do |n|
        ans = yield n
        return true if ans == true
      end
    return false
    elsif paramet.nil? && !block_given?
      arr.my_each { |n| return true if !n.nil? || n }
    return false
    elsif paramet.is_a?(Regexp)
      arr.my_each { |x| return true if x.match(paramet) }
    return false
    elsif paramet.is_a?(Module)
      my_each { |x| return true if x.is_a?(paramet) }
    return false
    else
      my_each { |x| return true if x == paramet }
    return false
    end
    return false
  end

  #my_none
  def my_none?(paramet = nil)
    arr = self
    return true if arr.empty?
    if paramet.nil? && block_given?
      arr.my_each do |n|
        ans = yield n
        return false if ans == true
      end
    return true
    elsif paramet.nil? && !block_given?
      arr.my_each { |n| return false if !n.nil? || n }
    return true
    elsif paramet.is_a?(Regexp)
      arr.my_each { |x| return false if x.match(paramet) }
    return true
    elsif paramet.is_a?(Module)
      my_each { |x| return false if x.is_a?(paramet) }
    return true
    else
      my_each { |x| return false if x == paramet }
    return true
    end
    return false
  end

  #my_count
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

  #my_map
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

  #my_inject
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