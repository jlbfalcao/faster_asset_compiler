
require 'test/unit'
require 'yui/compressor'

class YUI::JavascriptCompressorTest < Test::Unit::TestCase
  def setup
    @c = YUI::JavaScriptCompressor.new
  end
  def test_compressing_one_file
    assert_equal @c.compress("function f(name) { return name;\n};\nalert('foo');\n"), "function f(a){return a\n}alert(\"foo\");"
  end

  def test_compressing_many_files
    assert_equal @c.compress("var n = 10;\nalert('foo');\n"), "var n=10;\nalert(\"foo\");"
    assert_equal @c.compress("var n = 10;\nalert('foo')\n var b = 's';;"), "var n=10;\nalert(\"foo\");\nvar b=\"s\";"
  end
end

