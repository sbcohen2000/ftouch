# Written by Samuel Burns Cohen
# Jan 24, 2019
# 
# Token.rb
#
# This file defines a Token

class Token
    TOKEN_TYPES = [
        :EOF,         # final token in a file
        :ERROR,
        :IDENT,       # the name of a parameter or class
        :GETS,        # assignment equals
        :L_ANGLE,
        :R_ANGLE,
        :OPEN_PAREN,
        :CLOSE_PAREN,
        :TEXT,        # text that must be preserved, but not part of the grammar
        :COMMA,
        :NUMBER,
        :STRING,
        :WHITESPACE,  # whitespace tokens can only be created inside < ... >
    ]

    attr_reader :type, :content, :line, :column

    def initialize(type, content, line, column)
        @type, @content = :ERROR, content
        @line, @column = line, column

        TOKEN_TYPES.each do |t|
            if t == type then
                @type = t
                return
            end
        end
    end

    def to_s
        @type.to_s
    end

    def location
        "#{@line}:#{@column}"
    end
end