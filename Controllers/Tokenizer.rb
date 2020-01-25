# Written by Samuel Burns Cohen
# Jan 24, 2019
# 
# Tokenizer.rb
#
# This file defines the Tokenizer class

require_relative '../Components/Token'

class Tokenizer
public

    def initialize(text)
        @text = text
        @chunk_start = @chunk_end = 0
        #inside is true whenever the tokenizer is inside angle brackets
        @inside = false 

        @current_line = 1;
        @current_column = 0;
    end

    def scan()
        @chunk_start = @chunk_end
        return make_token(:EOF, nil) if at_end?

        if @inside then
            c = peek_and_advance()

            return group_whitespace() if whitespace?(c)
            return group_number() if numeric?(c)
            return group_identifier() if alpha?(c)

            case c
            when '<'
                return make_token(:L_ANGLE, nil)
            when '>'
                @inside = false
                return make_token(:R_ANGLE, nil)
            when '('
                return make_token(:OPEN_PAREN, nil)
            when ')'
                return close_paren(:CLOSE_PAREN, nil)
            when ','
                return make_token(:COMMA, nil)
            when '='
                return make_token(:GETS, nil)
            when '"'
                return group_string()
            end
        end

        return group_text() if !@inside

        return make_token(:ERROR, "unrecognized symbol \'#{c}\'")
    end

private

    def make_token(type, content)
        Token.new(type, content, @current_line, @current_column)
    end

    def group_whitespace()
        while whitespace?(peek()) do
            peek_and_advance()
        end

        return make_token(:WHITESPACE, get_current_chunk())
    end

    def group_identifier()
        while alpha?(peek()) or numeric?(peek()) do
            peek_and_advance()
        end

        return make_token(:IDENT, get_current_chunk())
    end

    def group_number()
        while numeric?(peek()) do
            peek_and_advance()
        end

        return make_token(:NUMBER, get_current_chunk().to_i)
    end

    def group_string()
        while peek() != '"' do
            return make_token(:ERROR, 'unmatched string') if at_end?
            peek_and_advance()
        end
        peek_and_advance() #discard closing quote
        return make_token(:STRING, get_current_chunk()[1..-2])
    end

    #group_text creates a TEXT token by searching for an open angle bracket
    def group_text()
        while peek() != "<" and !at_end? do
            peek_and_advance()
        end
        @inside = true
        make_token(:TEXT, get_current_chunk())
    end

    def peek_and_advance()
        #update placement info for error handling
        @current_column += 1
        if @text[@chunk_end] == "\n" then
            @current_line += 1 
            @current_column = 0
        end

        #increment the chunk pointer and return the char
        @chunk_end += 1
        @text[@chunk_end - 1]
    end

    def get_current_chunk()
        #get the text bound by @chunk_start (inclusive) and 
        #@chunk_end (exclusive)
        @text[@chunk_start...@chunk_end]
    end

    def at_end?()
        #@chunk_end points to one past the end of the string,
        #so comparison to the @text.length is valid without subtracting 1
        @chunk_end >= @text.length
    end

    def peek()
        @text[@chunk_end]
    end

    def alpha?(char)
        char.match(/^[[:alpha:]]$/)
    end

    def numeric?(char)
        char.match(/[0-9]/)
    end

    def whitespace?(char)
        char.match(/\s/)
    end
end