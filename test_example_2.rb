require './jspec'

class YTest < Test
  def self.run
    public_instance_methods.grep(/_test$/).each do |name|
      self.new.run name
    end
  end

  def run name
    send name
  end
  
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
