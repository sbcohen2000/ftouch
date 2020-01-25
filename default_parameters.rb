# Written by Samuel Burns Cohen
# Jan 25, 2019
# 
# default_parameters.rb
#
# This file defines the implementations of some parameters that are included
# by default

# parameter info
#   > each parameter lambda function must take no arguments
#   > each default parameter should return some contextual information that
#     can be retrived by calling its name. For example, the author of the 
#     document, or today's date.

DEFAULT_PARAMETERS = [
    Parameter.new('filename', -> {
        return 'yolo.txt'
    })
]