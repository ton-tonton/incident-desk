module EnvTestHelper
  def with_env(vars)
    original = vars.keys.to_h { |key| [ key, ENV[key] ] }
    vars.each { |key, value| ENV[key] = value }
    yield
  ensure
    original.each { |key, value| ENV[key] = value }
  end
end
