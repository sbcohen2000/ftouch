# ftouch

ftouch is a program that creates new files with a template. The template is defined by a .tf file which determines the initial contents of the file. The .tf file can include parameters as well. These parameters can be set by the user, but a number of existing parameters are included with the application. Each parameter injects custom information into the text of the file such as the date, time, or username of the user who created the file. Each parameter can also be modified by classes. Classes filter the parameter’s value, for example, capitalizing every character or wrapping after a certain line number. 

## Getting Started
to install ftouch, navigate to its directory and run:
```
$ make install
```
to uninstall, run:
```
$ make uninstall
```
ftouch is written in Ruby. To run the program without installing, type:
```
$ Ruby main.rb 
```
or
```
$ ./main.rb
```
The program will accept two input arguments. The first argument is required and is the name of the output file. If the output file does not exist, ftouch will create it. The second argument is the path of the configuration file to use for formatting. If it is not included, the default configuration will be used in `./configs/default.ft`.

## Configuration
Below is an example of a configuration file and the resulting output file.
\n`$ cat configs/default.ft`
```
<author = "Samuel Burns Cohen">
// Created by <author>
// Created on <date>
//
// <filename>
// 
```
The above configuration file produces the following:
\n`$ ./main.rb test.c && cat test.c`
```
// Created by Samuel Burns Cohen
// Created on 1/25/2020
//
// test.c
//
```
And here is a summary of the currently supported syntax:
```
<param>
<param class,class,class> param with classes
<param class(arg)>        class with argument
<param =value>            assignment

default params:
    date     -> MM/DD/YYYY
    day      -> DD
    month    -> MM
    year     -> YYYY
    time     -> hh:mm
    hour     -> hh
    min      -> mm
    sec      -> ss
    filename -> name of file
```