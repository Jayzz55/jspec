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
