# Written by Samuel Burns Cohen
# Jan 24, 2019
# 
# SymbolTable.rb
#
# This file defines the SymbolTable class

require_relative '../Components/Parameter' 

require_relative '../default_parameters.rb'
require_relative '../default_classes.rb'

class SymbolTable
public

    def initialize()
        @parameters = DEFAULT_PARAMETERS
        @classes = DEFAULT_CLASSES
    end

    def set(parameter_name, value)
        parameter = find_parameter(parameter_name)
        return parameter.value if parameter != nil
        add(parameter_name, value)
        return value
    end

    def get(parameter_name)
        param = find_parameter(parameter_name)
        return param if param != nil
        puts "Parameter #{parameter_name} was not found"
    end

    def apply_class(parameter_name, class_name, arguments)
        parameter = get(parameter_name)
        c = find_class(class_name)
        if c != nil then
            parameter.apply_class(c.raw_value, arguments)
        else
            puts "Class #{class_name} was not found"
        end
    end

private

    def add(parameter_name, value)
        @parameters << Parameter.new(parameter_name, value)
    end

    def add_defaults()
        # @parameters << Parameter.new('filename', -> {
        #     return 'yolo.txt'
        # })
        # 
    end

    def find_parameter(parameter_name)
        @parameters.each do |param|
            return param if param.name == parameter_name
        end
        return nil
    end

    def find_class(class_name)
        @classes.each do |c|
            return c if c.name == class_name
        end
        return nil
    end

end