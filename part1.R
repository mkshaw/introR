# Part 1 Agenda ------------------------------------------------------------

# Why should we code?
# Setting up a project and organizing files
# R as calculator
# Variable assignment
# Control flow: if/else
# Control flow: for/while
# Functions
# Coding best practices

# Why Should We Code? -----------------------------------------------------

# We code to accomplish tasks that would be less efficient or impossible to do
# by hand. There are many different coding languages. Which one you use depends
# on the task at hand and the conventions of a given field. A lot of programming
# languages are flexible and *can* do a lot, but have different things that they
# excel at. I like to think of coding languages as being like utensils: they
# help us accomplish a task, and there are a lot of options, but some utensils
# are better at some jobs (e.g., spoon vs fork for eating soup).

# We're going to focus on R because that's a common option in psychological
# research. Why do people like using R/what makes it well-suited to
# psychological research? (1) It's open-source and free, meaning users like you
# and me can add additional functionality on top of base R, and it's free for
# anyone to use. (2) It has an active teaching community, so a lot of great
# resources for learning are freely available online. (3) Particularly thanks to
# Posit/RStudio, it's easy to set up projects and keep files organized. (4) It's
# excellent at statistical analyses and graphing.

# Some other options you may come across are SPSS and JASP, which are "point and
# click." These are powerful tools and can be totally fine for conducting
# analyses! They're just a little less flexible because you're limited to their
# existing functionality. They can also be less reproducible, with people
# clicking around and not saving their work. There are ways to save your work,
# which you should do if you're using them.

# Setting Up Projects -----------------------------------------------------

# It's important to keep files clean and organized when you're working on a
# project. I like to create folders dedicated to a given project, and then keep
# all files and data related to that project in a given folder. Let's create a
# folder for these workshops. Go to File -> New Project... -> New Directory ->
# New Project. Create a directory (AKA a folder) and choose where to put it, and
# click Create Project. This is where your files for these workshops will live!
# Let's make a file called day1.R (ctrl/cmd-shift-N or File -> New File -> R
# Script) for today's activities.

# Important things in RStudio to start: we have the console (runs code, doesn't
# save it), environment (shows all the objects you've created, right now we have
# none), and then the files/plots/help window. When you create a file, you also
# add a script editor.

# R as a Calculator -------------------------------------------------------

# addition
2 + 2

# subtraction
9 - 3

# multiplication
3 * 4

# division
12 / 2

# Variable Assignment -----------------------------------------------------

# It's not very likely that you would be using R as just a calculator. Usually,
# you'll use these operations as part of larger pipelines and want to save the
# results. We can save results to a variable using the assignment operator, <- .
# I don't want to get into the nitty-gritty, but <- is convention when you're
# assigning values to variables, even though = might work. There is a difference.
# Most important right now is that you are consistent.

a <- 2 + 2 # calculate
a          # print to console

b <-  9 - 3
b

c <- 3 * 4; c # store and print in one line
c             # call c again, just to show it's stored

# Let's take a moment here to talk about some coding best practices: commenting
# and spacing.

# I'm using comments in two ways right now: inline (next to code),
# and to create sections. Inline, I'm commenting with what I'm doing. This is
# not just to make it easier for others to read, it's for myself! You know what
# you're doing when you write your code, but when you come back days, weeks,
# months, years later, you won't always remember, so it's useful to have a quick
# description of what is happening and why. As an additional benefit, it can
# help people reading your code for the first time as well. With creating
# sections, I'm organizing my file so it's easy to navigate with a legend. These
# lines with a preceding # are comments, so won't be run when I run my code. If
# you follow up a comment with at least four hyphens (# ----), you create a new
# section. I have a ton of hyphens following my comment because it makes it
# easier to pick out sections when I scroll through the document, and it's the
# default of the automatic section creation function in R, which is ctrl-shift-R
# on a Mac.

# Notice that I'm spacing out everything. I have a space around the assignment
# operator <-, spaces between the addition/subtraction/multiplication/division
# sign and the numbers. This is because it's easier to read. For example, if I
# write:

2+2-1*8/3

# It's harder to read than:

2 + 2 - 1 * 8 / 3

# This is less noticeable with smaller lines like this, but when you have a
# bunch of text all at once, it's very noticeable when it's hard to read.

# Let's talk about variable types, as well. Like in English, we have numbers and
# letters as different "types" of information, we have different types of
# information in programming. The basic data types are character (text), numeric
# (decimals), integer (round numbers), logical (true/false), and complex
# (imaginary numbers, we won't discuss).

# character, also called strings
month <- "january"
typeof(month) # check data type

# numeric, also called double
doub <- 4.1
typeof(doub)

# integer
four <-  4L # the L forces it to save as an integer, because if we just do 4 it saves as 4.0 internally
typeof(four)

# logical, also called boolean
january <- TRUE
february <- FALSE
typeof(january)

# We're also seeing some important naming conventions here. There are different
# variable name conventions, and some hard rules. The hard rules are: no hyphens
# (underscores are okay), no numbers at the beginning of variable (e.g., 1red
# won't work, red1 would work), no reserved words (TRUE, FALSE, NULL). Some
# different conventions are snake_case and camelCase. I prefer snake_case.
# http://adv-r.had.co.nz/Style.html for more conventions.

# Control Flow: if/else ---------------------------------------------------

# It's not uncommon to want to run more than just one line at a time. Sometimes
# we want to run something different depending on the value stored in a
# variable. For example, maybe if it's January we want to print "Happy New
# Year!" We can accomplish that with an if statement. This is the programming
# equivalent of the logic "if this thing is true, then do this other thing." The
# structure is as follows:

# if (CONDITION) {
#
#   DO THIS THING
#
# }

# For our January example, recall we stored "january" in the month variable earlier.

if (month == "january") {

  print("Happy New Year!")

}

# note we're using == here, not =. If you use one =, it will be mistaken for
# assignment.

# Other examples of comparisons:

a <- 1

# if a is less than 1
if (a < 1) {

  print("a is less than 1")

}

# if a is less than or equal to 1
if (a <= 1) {

  print("a is less than or equal to 1")

}

# Notice that at first, nothing printed because our condition evaluated to
# FALSE. If we want to run something in the case that the condition is false, we
# can add an "else" statement.

if (a < 1) {

  print("a is less than 1")

} else {

  print ("a is equal to or greater than 1")

}

# We can also add additional conditions beyond the first if with else/if
# statements. This translates to "if THIS THING is true, do this, or if not if
# THIS OTHER THING is true, do this other thing."

if (a < 1) {

  print("a is less than 1")

} else if (a > 1) {

  print ("a is greater than 1")

} else {

  print("a is equal to 1")

}

# Control Flow: for/while -------------------------------------------------

# An if/else statement checks a condition and runs once. But maybe you want to
# conduct an operation many times. You can use a for or while loop to accomplish
# this. In plain English, a for loop runs FOR the amount of time you specify. A
# while loops runs WHILE a given condition is true. Let's look at two examples.

# For loop syntax is as follows:

# for (NUMBER OF ITERATIONS) {
#
#   DO THIS
#
# }

# As an example, let's print 1 through 10 to the console.
# for every element in i
for (i in 1:10) {

  print(i)

}

# We can also print the other way:

for (i in 10:1) {

  print(i)

}

# Let's combine this countdown with an if statement:

for (i in 10:1) {

  print(i)

  if (i == 1) {
    print("blastoff!")
  }

}

# note that this isn't very efficient, checking an if statement every time the
# loop runs. I'm just showing you can combine these data structures.

# You can also use a for loop to interact with a larger data structure, like a
# vector (a bunch of numbers all stored in one object). Here's what a vector
# looks like:

vec <- c(12, 3, 14, 29, 5)
vec

# you can access items in the vector with their index using square brackets. The
# first item is 1, the second is 2, and so on:

vec[1]
vec[2]

# we can assess how long the vector is with the length() function
length(vec)

# print each item in the vector

for (i in 1:length(vec)) { # i is the index, in 1:5

  print(vec[i])

}

# You can also make a vector of non-numbers, in which case the entire thing will be a string vector.

string_vec <- c("apple", "banana", 3, "fifteen")
typeof(string_vec)

# accessing elements works the same way:
string_vec[2]

for (i in 1:length(string_vec)) {

  print(string_vec[i])

}

# notice that the "3" is a string here, not a number

# While loops are used less often, but they run WHILE a given condition is true.

# while (CONDITION is true) {
#
#   DO THIS
#
# }

# We can rejig our for loop to be a while loop

# create index
i = 1

while (i <= 10) {

  print(i)

  # we have to manually iterate
  i = i + 1

}

# Functions ---------------------------------------------------------------

# We've already started to use some functions, like print() and length(). A
# function: (1) takes in some inputs, (2) does some operation, (3) returns the
# result of the operation. There are some functions built into "base R," i.e.,
# it's already on your computer when you downloaded R! An example is the "sum"
# function.

# Inputs: numbers
# Operation: addition
# Output: the sum
sum(2, 3)

sum(3, 5)
sum(10, 20, 45, 3)

# Another example is the mean() function.
# Inputs: a vector of numbers.
# Operation: calculate the mean.
# Output: the mean.

mean(vec)
mean(c(3, 4, 5))

# If you want to learn about the inputs to a function, you can type
# ?function_name or help(function_name) to read the documentation. Let's look at
# the documentation for the mean.
?mean
?sum

help(mean)
help(sum)

# You can also write your own functions.

# name <- function(variables) {
#   operations
#   return(the result)
# }

# Let's recreate the sum function for two variables

sum2 <- function(var1, var2) {

  result <- var1 + var2

  return(result)

}

sum2(3, 4)

