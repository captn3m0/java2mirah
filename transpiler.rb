require_relative './lexer.rb'
module Java2Mirah
  class Transpiler
    attr_accessor :source
    attr_accessor :filename

    def initialize(source, filename='STDIN')
      self.source = source
      self.filename = filename
    end

    def tokens
      @tokens ||= Java2Mirah::Lexer.lex(source, filename)
    end

=begin
    def tree
      @tree ||= tree_constructor
    end
=end

    def process
      puts tokens
    end

=begin
  def target=(x)
      @target = TargetVersion.new(x.to_s)
    end

    def target
      @target ||= TargetVersion.new
    end

    private

    def tree_constructor
      Rubby::Parser.parse(tokens).each do |node|
        node.walk(node.children, self)
      end
    end
=end

  end
end