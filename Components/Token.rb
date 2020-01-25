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
        :WHITESPACE   # whitespace tokens can only be created inside < ... >
    ]

    attr_reader :type, :content, :line, :column, :location

    def initialize(type, content, location)
        @type, @content = :ERROR, content
        @location = location

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
end