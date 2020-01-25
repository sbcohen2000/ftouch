# Written by Samuel Burns Cohen
# Jan 24, 2019
# 
# Parser.rb
#
# This file defines the Parser class

require_relative '../Components/Token'
require_relative 'Tokenizer'
require_relative '../Models/SymbolTable'

class Parser
    def initialize(text)
        @tokenizer = Tokenizer.new(text)
        @symbol_table = SymbolTable.new()

        @this_token = @tokenizer.scan()
        @next_token = @tokenizer.scan()
    end

    def advance()
        @this_token = @next_token
        @next_token = @tokenizer.scan()
    end

    def next_is_eof()
        return @next_token.type == :EOF
    end

    def peek()
        @this_token
    end

    def expect(token_type)
        return true if accept(token_type)
        #todo: do a proper error
        puts "Expected #{token_type} but got #{@this_token.type}"
        return false
    end

    def accept(token_type)
        if peek().type == token_type then
            advance()
            return true
        end
        return false
    end

    def output_text()
        print peek().content
        accept(:TEXT)
    end

    #RDP functions below

    def class_list()
        loop do
            accept(:WHITESPACE)
            class_name = peek().content
            expect(:IDENT)

            puts "class name: #{class_name}"
            #accept possible input argument
            if peek().type == :OPEN_PAREN then
                accept(:WHITESPACE)
                constant
                accept(:WHITESPACE)
                expect(:CLOSE_PAREN)
            end

            accept(:WHITESPACE)
            break if !accept(:COMMA)
        end
    end

    def constant()
        value = peek().content
        if peek().type == :NUMBER then
            accept(:NUMBER)
        else
            expect(:STRING)
        end
        return value
    end

    def expression()
        parameter_name = peek().content
        expect(:IDENT)
        puts @symbol_table.get_value(parameter_name)
        accept(:WHITESPACE)
        #if a "<" does not follow the identifer, then some whitespace
        #and a class list, or an assignment statement must follow 
        if peek().type != :R_ANGLE then
            if accept(:GETS) then
                constant
            else
                class_list
            end
        end
        expect(:R_ANGLE)
    end

    def body()
        until next_is_eof do
            #puts peek().type
            if peek().type == :TEXT then
                output_text 
            elsif accept(:L_ANGLE) then
                accept(:WHITESPACE) #accept possible whitespace
                expression
            else
            end
        end
    end
end