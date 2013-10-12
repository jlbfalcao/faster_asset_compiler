
module YUI
  class Compressor
    def initialize
      require File.expand_path('../yuicompressor-2.4.8.jar', __FILE__)
      java_import java.io.InputStreamReader
      java_import java.io.OutputStreamWriter
      java_import com.yahoo.platform.yui.compressor.JavaScriptCompressor
      java_import com.yahoo.platform.yui.compressor.CssCompressor
    end

    def stream(content, &block)
      output = StringIO.new
      reader = InputStreamReader.new(StringIO.new(content.to_s).to_inputstream)
      writer = OutputStreamWriter.new(output.to_outputstream)
      compressor = yield(reader, writer)
      
      writer.flush
      output.rewind
      output.read
    end
  end

  class ErrorReporter #:nodoc:
    def error(message, source_name, line, line_source, line_offset)
      if line < 0
        "\n[ERROR] %s" % message
      else
        "\n[ERROR] %s:%s:%s" % [line, line_offset, message]
      end
    end

    alias :warning :error

    def runtimeError(*args)
      raise 'Compression failed: %s' % error(*args)
    end
  end

  class CssCompressor < Compressor
    def compress(css)
      stream(css) do |reader, writer|
        compressor = Java::ComYahooPlatformYuiCompressor::CssCompressor.new(reader)   
        compressor.compress(writer, 0)
        compressor
      end
    end
  end

  class JavaScriptCompressor < Compressor
    def compress(js)
      stream(js) do |reader, writer|
        compressor = Java::ComYahooPlatformYuiCompressor::JavaScriptCompressor.new(reader, ErrorReporter.new) 
        
        linebreak = 0
        munge = true
        verbose = false
        preserveAllSemiColons = false
        disableOptimizations = false

        compressor.compress(writer, linebreak, munge, verbose, preserveAllSemiColons, disableOptimizations)
        compressor
      end
    end
  end
end

