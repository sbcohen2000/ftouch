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

    def class_list(parameter_name)
        loop do
            accept(:WHITESPACE)
            class_name = peek().content
            expect(:IDENT)

            class_arguments = Array.new
            
            #accept possible input argument
            if peek().type == :OPEN_PAREN then
                accept(:WHITESPACE)
                class_arguments << constant
                accept(:WHITESPACE)
                expect(:CLOSE_PAREN)
            end

            accept(:WHITESPACE)

            @symbol_table.apply_class(parameter_name, 
                                      class_name, 
                                      class_arguments)

            break if !accept(:COMMA)
        end
    end

    def constant()
        #accept whitespace after assignment
        accept(:WHITESPACE)
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
        expression_should_output = true
        expect(:IDENT)
        accept(:WHITESPACE)
        #if a "<" does not follow the identifer, then some whitespace
        #and a class list, or an assignment statement must follow 
        if peek().type != :R_ANGLE then
            if accept(:GETS) then
                @symbol_table.set(parameter_name, constant())
                #assignment statements do not produce output
                expression_should_output = false
            else
                class_list(parameter_name)
            end
        end
        #output the value of the parameter after all classes have been applied
        if expression_should_output then
            print @symbol_table.get(parameter_name).value 
        end
        expect(:R_ANGLE)
    end

    def body()
        until next_is_eof do
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