require 'rltk/lexer'

module Java2Mirah
  class Lexer < RLTK::Lexer
    # Skip newlines and tabs
    rule(/\t/)
    rule(/\n/)
    rule(/ /)

    # Operators and delimiters.
    rule(/private/)     { [:ACCESS_IDENTIFIER, 'PUBLIC'] }
    rule(/import/)      { :IMPORT }
    rule(/public/)      { [:ACCESS_IDENTIFIER, 'PRIVATE'] }
    rule(/protected/)   { [:ACCESS_IDENTIFIER, 'PROTECTED'] }
    rule(/implements/)  { :IMPLEMENTS }
    rule(/super/)       { :SUPER }
    rule(/extends/)     { :EXTENDS }
    rule(/class/)       { :CLASS }
    rule(/interface/)   { :INTERFACE }
    rule(/this/)        { :THIS }

    # Flow control
    rule(/if/)          { :IF }
    rule(/else/)        { :ELSE }
    rule(/else if/)     { :ELIF }
    rule(/while/)       { :WHILE }
    rule(/continue/)    { :CONTINUE }
    rule(/goto/)        { :GOTO }
    rule(/for/)         { :FOR }
    rule(/case/)        { :CASE }
    rule(/default/)     { :DEFAULT }
    rule(/break/)       { :BREAK }
    rule(/return/)      { :RETURN }

    # Booleans
    rule(/true/)        { [:BOOLEAN, true] }
    rule(/false/)       { [:BOOLEAN, false] }

    # Variable types
    rule(/int/)         {[:VAR_TYPE, 'INT']}
    rule(/String/)      {[:VAR_TYPE, 'STRING']}
    rule(/byte/)        {[:VAR_TYPE, 'BYTE']}
    rule(/long/)        {[:VAR_TYPE, 'LONG']}
    rule(/float/)       {[:VAR_TYPE, 'FLOAT']}
    rule(/double/)      {[:VAR_TYPE, 'DOUBLE']}
    rule(/char/)        {[:VAR_TYPE, 'CHAR']}
    rule(/short/)       {[:VAR_TYPE, 'SHORT']}
    rule(/void/)        {[:VAR_TYPE, 'VOID']}
    rule(/\./)          {[:DOT]}
    rule(/:/)           {[:COLON]}
    rule(/,/)           {[:COMMA]}

    rule(/[A-Za-z_][A-Za-z0-9_]*/)       { |n| [:NAME, n.to_s] }
    rule(/\"[^\"]*"/)   { |s| [:STRING, s.to_s] }
    rule(/-?[0-9][0-9]*/){ |t| [:INT,t.to_i] }
    rule(/\+/)          { :PLUS }
    rule(/-/)           { :MINUS }
    rule(/\*/)          { :MULTIPLY }
    rule(/\//)          { :DIVIDE }
    rule(/%/)           { :MODULO }
    rule(/{/)           { :LBRACE }
    rule(/}/)           { :RBRACE }
    rule(/;/)           { :SEMICOLON }
    rule(/\(/)          { :LPAREN }
    rule(/\)/)          { :RPAREN }
    rule(/\[/)          { :LBRACKET }
    rule(/\]/)          { :RBRACKET }
    rule(/throws/)      { :THROWS }


    %w[ \+= -= \*= /= %= ].each do |op|
      rule(%r|#{op}|) { |e| [ :ASSIGNMENTOP, e ] }
    end
    rule(/</)    { [ :LT, "<" ] }
    rule(/>/)    { [ :GT, ">" ] }
    rule(/\&/) { |e| [ :AMPER, e ] }
    rule(/\^/) { |e| [ :HAT, e ] }
    %w[ \| << >> ].each do |op|
      rule(%r|#{op}|) { |e| [ :BITWISEOP, e ] }
    end
    %w[ == != > < >= <= <=> === ].each do |op|
      rule(%r|#{op}|) { |e| [ :COMPARISONOP, e ] }
    end
    rule(/\=/)          { :ASSIGNQ }

    rule(/\/\/.*\n/)    { |c| [:COMMENT, c[2..-1]]}

    rule(/./)           { |v| [:UNKNOWN, v.to_s] }
  end
end