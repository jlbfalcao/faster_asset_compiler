
require 'benchmark'

module Closure
  class Compiler
    def initialize
      require File.expand_path "compiler.jar", File.dirname(__FILE__)
      
      require 'java'
      import com.google.javascript.jscomp.JSSourceFile
      import com.google.javascript.jscomp.Compiler
      import com.google.javascript.jscomp.VariableRenamingPolicy
      import com.google.javascript.jscomp.CompilerOptions
      import com.google.javascript.jscomp.CompilationLevel
      import com.google.javascript.jscomp.WarningLevel
      import java.util.logging.Level
      
      @opts = CompilerOptions.new
      
      # TODO: configure Compilation Level
      CompilationLevel::SIMPLE_OPTIMIZATIONS.setOptionsForCompilationLevel(@opts)
      
      # TODO: configure Warning Level
      # WarningLevel.const_get(warning_level).setOptionsForWarningLevel(opts)
      com.google.javascript.jscomp.Compiler.setLoggingLevel(Level::WARNING)
    end

    def compress(js)
      puts "Compiling javascript"
      return js
      result = nil
      Benchmark.bm do |x|
        x.report do
          source = JSSourceFile.fromCode("unknown", js)
          compiler = Java::ComGoogleJavascriptJscomp::Compiler.new

          res = compiler.compile([], [source], @opts)
          result = compiler.toSource() + "\n"

          raise Error, result unless res.success
          # yield(StringIO.new(result)) if block_given?
        end
      end
      return result# nothing todo.
    end
  end
end

