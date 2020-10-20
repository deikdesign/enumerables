module Enumerable # rubocop:disable Metrics/ModuleLength
  # my_each
  def my_each(&block)
    arr = self
    arr = arr.to_a
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
    end
    arr.to_enum
  end

  # my_each_with_index
  def my_each_with_index(&block)
    arr = self
    arr = arr.to_a
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
      arr.to_enum
    end
  end

  # my_select
  def my_select(&block)
    arr = self
    return arr.to_enum unless block

    temp = []
    arr.my_each { |num| temp.push(num) if yield(num) }
    temp
  end

  # my_all
  def my_all?(paramet = nil)
    an = true
    arr = self
    arr = arr.to_a
    return true if arr.empty?

    if block_given?
      arr.my_each do |n|
        ans = yield n
        return false if ans == false
      end
    else
      an = check_regx(paramet, arr)
    end
    an
  end

  # my_method1
  def check_regx(paramet, arr)
    an = false
    if paramet.nil?
      arr.my_each { |n| return false if n.nil? || !n }
    else
      an = check_regx_other(paramet, arr)
    end
    an
  end

  def check_regx_other(paramet, arr)
    if paramet.is_a?(Regexp)
      arr.my_each { |x| return false unless x.match?(paramet) }
    elsif paramet.is_a?(Class)
      arr.my_each { |x| return false unless x.is_a?(paramet) }
    else
      arr.my_each { |x| return false if x != paramet }
    end
    true
  end

  # my_any
  def my_any?(paramet = nil)
    an = false
    arr = self
    arr = arr.to_a
    return true if arr.empty?

    if block_given?
      arr.my_each do |n|
        ans = yield n
        return true if ans == true
      end
    else
      an = check_other(paramet, arr)
    end
    an
  end

  # my_method2
  def check_other(paramet, arr)
    an = false
    if paramet.nil?
      arr.my_each { |n| return true if !n == false && !n.nil? }
    else
      an = check_other_helper(paramet, arr)
    end
    an
  end

  def check_other_helper(paramet, arr)
    if paramet.is_a?(Regexp)
      arr.my_each { |x| return true if x.match?(paramet) }
    elsif paramet.is_a?(Class)
      arr.my_each { |x| return true if x.is_a?(paramet) }
    else
      arr.my_each { |x| return true if x == paramet }
    end
    false
  end

  # my_none
  def my_none?(paramet = nil)
    an = true
    arr = self
    arr = arr.to_a
    return true if arr.empty?

    if block_given?
      arr.my_each do |n|
        ans = yield n
        return false if ans == true
      end
    else
      an = check_class(paramet, arr)
    end
    an
  end

  # my_method3
  def check_class(paramet, arr)
    an = false
    if paramet.nil?
      arr.my_each { |n| return false if !n == false && !n.nil? }
    else
      an = check_class_helper(paramet, arr)
    end
    an
  end

  def check_class_helper(paramet, arr)
    if paramet.is_a?(Regexp)
      arr.my_each { |x| return false if x.match?(paramet) }
    elsif paramet.is_a?(Class)
      arr.my_each { |x| return false if x.is_a?(paramet) }
    else
      arr.my_each { |x| return false if x == paramet }
    end
    true
  end

  # my_count
  def my_count(para = nil)
    arr = self
    arr = arr.to_a
    counter = 0
    if block_given?
      arr.my_each { |x| counter += 1 if yield x }
    elsif !para.nil?
      arr.my_each { |x| counter += 1 if x == para }
    else
      arr.my_count { counter += 1 }
    end
    counter
  end

  # my_map
  def my_map(proc = nil)
    return to_enum unless block_given? || proc

    arr = self
    arr = arr.to_a
    new_arr = []
    if proc
      arr.my_each { |num| new_arr.push(proc.call(num)) }
    else
      arr.my_each { |num| new_arr.push(yield(num)) }
    end
    new_arr
  end

  # 9.my_inject
  def my_inject(int = nil, sec = nil)
    if check_signs(int, sec)
      sec = int
      int = nil
    end
    if !block_given? && !sec.nil?
      to_a.my_each { |item| int = int.nil? ? item : int.send(sec, item) }
    else
      to_a.my_each { |item| int = int.nil? ? item : yield(int, item) }
    end
    int
  end

  def check_signs(int, sec)
    return true if (!int.nil? && sec.nil?) && (int.is_a?(Symbol) || int.is_a?(String))

    false
  end
end

public

def multiply_els(arr)
  arr.my_inject { |result, element| result * element }
end
