require './jspec'

class ZTest < Test
  def self.run
    public_instance_methods.grep(/_test$/).each do |name|
      begin
        self.new.run name
        print '.'
      rescue => e
        puts "Failure: #{self}##{name}: #{e.message}"
        puts " #{e.backtrace.first}"
      end
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
