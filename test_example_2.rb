require './jspec'

class YTest < Test
  def first_test
    a = 1
    assert_equal 1, a
  end

  def second_test
    a = 1
    a += 1
    assert_equal 2, a
  end

  def third_test
    a = 1
    assert_equal 1, a
  end
end
