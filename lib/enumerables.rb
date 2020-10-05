module Enumerable
  #my_each
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

end