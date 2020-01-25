# Written by Samuel Burns Cohen
# Jan 25, 2019
# 
# default_classes.rb
#
# This file defines the implementations of each built-in ftouch class

# class info:
#   > each class has must take two arguments: param, and arguments
#   > the parameter argument is the instance of the Parameter class 
#     that has this class
#   > the arguments argument is an array of values passed in from the class
#   > invocation. i.e <parameter class(class_argument), other_class>

DEFAULT_CLASSES = [
    Parameter.new('capitalize',  ->(param, arguments) {
        return param.value.upcase
    })
]