class Test
  TESTS = []

  def self.inherited x
    TESTS << x
  end

  def self.run_all_tests
    TESTS.each do |klass|
      klass.run
    end
    puts
  end

  def self.run
    public_instance_methods.grep(/_test$/).each do |name|
      e = self.new.run name
      unless e then
        print '.'
      else 
        puts
        puts "Failure: #{self}##{name}: #{e.message}"
        puts " #{e.backtrace.first}"
      end
    end
  end

  def run name
    send name
    false
  rescue => e
    e
  end

  def assert test, msg= "Failed test"
    unless test then
      bt = caller.drop_while { |s| s =~ /#{__FILE__}/ }
      raise RuntimeError, msg, bt
    end
  end

  def assert_equal a, b
    assert a == b, "Failled assert_equal #{a} vs #{b}"
  end

  def assert_in_delta a, b
    assert (a-b).abs <= 0.01, "Failed assert_in_delta #{a} vs #{b}"
  end
end

