class Test
  TESTS = []

  class << self
    def inherited x
      TESTS << x
    end

    def run_all_tests
      reporter = Reporter.new

      TESTS.each do |klass|
        klass.run reporter
      end

      reporter.summary
    end

    def run reporter
      public_instance_methods.grep(/_test$/).each do |name|
        reporter << self.new(name).run
      end
    end
  end

  attr_accessor :failure, :name
  alias failure? failure

  def initialize name
    self.name = name
  end

  def run
    send name
  rescue => e
    self.failure = e
  ensure
    return self
  end

  def assert test, msg= "Failed test"
    unless test then
      bt = caller.drop_while { |s| s =~ /#{__FILE__}/ }
      raise RuntimeError, msg, bt
    end
  end

  def assert_equal a, b
    assert a == b, "Failed assert_equal #{a} vs #{b}"
  end

  def assert_in_delta a, b
    assert (a-b).abs <= 0.01, "Failed assert_in_delta #{a} vs #{b}"
  end
end

class Reporter
  attr_accessor :failures

  def initialize
    self.failures = []
  end

  def << result
    unless result.failure? then
      print '.'
    else 
      print 'F'
      failures << result
    end
  end

  def summary
    puts

    print_failures
  end

  def print_failures
    failures.each do |result|
      failure = result.failure
      puts
      puts "Failure: #{result.class}##{result.name}: #{failure.message}"
      puts " #{failure.backtrace.first}"
    end
  end
end
