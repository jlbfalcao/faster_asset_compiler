
require 'test/unit'
require 'yui/compressor'

class YUI::CssCompressorTest < Test::Unit::TestCase
  def test_compressing_one_file
    assert_equal YUI::CssCompressor.new.compress("#id {\n font-size: 10px; \n}\n"), "#id{font-size:10px}"
  end

  def test_compressing_many_files
    c = YUI::CssCompressor.new
    # assert_equal c.compress("#id {\n font-size: 10px; \n}\n"), "#id{font-size:10px}"
    # assert_equal c.compress("#id {\n font-size: 10px; \n}\nbody {}\ndiv    {background: #f0f;}\n"), "#id{font-size:10px}\ndiv{background:#f0f}"
  end
end

