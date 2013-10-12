require 'test/unit'
require 'closure-compiler'

class Closure::CompilerTest < Test::Unit::TestCase

  def setup
    @c = Closure::Compiler.new
  end

  def test_compressing_one_file
    assert_equal @c.compress("function f(name) { return name;\n};\nalert('foo');\n"), "function f(a){return a}alert(\"foo\");\n"
  end

  def test_compressing_many_files
    assert_equal @c.compress("var n = 10;\nalert('foo');\n"), "var n=10;alert(\"foo\");\n"
    assert_equal @c.compress("var n = 10;\nalert('foo')\n var b = 's';;"), "var n=10;alert(\"foo\");var b=\"s\";\n"
  end
end
