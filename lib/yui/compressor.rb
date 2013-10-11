
module YUI

  JAR_FILE = File.expand_path('../yuicompressor-2.4.8.jar', __FILE__)

  class Compressor
    def initialize
      require JAR_FILE
      java_import java.io.InputStreamReader
      java_import java.io.OutputStreamWriter
      java_import com.yahoo.platform.yui.compressor.JavaScriptCompressor
      java_import com.yahoo.platform.yui.compressor.CssCompressor
    end

    def stream(content, &block)
      output = StringIO.new
      reader = InputStreamReader.new(StringIO.new(content.to_s).to_inputstream)
      writer = OutputStreamWriter.new(output.to_outputstream)
      compressor = yield(reader)
      # compressor = CssCompressor.new(reader)    
      compressor.compress(writer, *options)

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

    def runtimeError(*args)
      raise 'Compression failed: %s' % error(*args)
    end
  end

  class CssCompressor < Compressor

    def options
      # TODO: customize
      { :line_break => nil }
    end



    def compress(css)
      stream(css) do |reader|
         Java::ComYahooPlatformYuiCompressor::CssCompressor.new(reader)   
      end
      # output = StringIO.new
      # reader = InputStreamReader.new(StringIO.new(css.to_s).to_inputstream)
      # writer = OutputStreamWriter.new(output.to_outputstream)
      # compressor = CssCompressor.new(reader)    
      # compressor.compress(writer, *command_arguments(options))

      # writer.flush
      # output.rewind
      # output.read
    end
  end

  class JavaScriptCompressor < Compressor

    def options
      {
        :line_break => nil,
        :munge => true,
        :preserve_semicolons => false,
        :optimize => true
      }
    end

    def compress(js)
      # stream(js) do |reader|
      #   compressor = Java::ComYahooPlatformYuiCompressor::JavaScriptCompressor.new(reader, ErrorReporter.new) 
      # end
      output = StringIO.new
      reader = InputStreamReader.new(StringIO.new(js.to_s).to_inputstream)
      writer = OutputStreamWriter.new(output.to_outputstream)
      compressor = Java::ComYahooPlatformYuiCompressor::JavaScriptCompressor.new(reader, ErrorReporter.new)    
      compressor.compress(writer, *command_arguments(options))
      puts "done"

      writer.flush
      output.rewind
      output.read
    end
  end
end


