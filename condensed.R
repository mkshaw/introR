# condensed.R --------------------------------------------------------

# This document is a pared-down version of the part1.R and part2.R files,
# intended for a shorter workshop. There is no new content, just a light
# reorganization to focus less on basic data structures and more on getting up
# and running using packages and conducting analyses, intended to be delivered
# as a single 90-minute workshop.

# Condensed Agenda --------------------------------------------------------

# R and RStudio, why we code
# Creating projects, where files live
# Variables, vectors, indexing vectors
# Loading files -- absolute vs relative filepaths
# Installing and loading packages -- dplyr, sjPlot
# Inspecting data: head, tail, str, View
# Functions
# dplyr verbs: filter, select, mutate, group_by, arrange
# Pipes
# Statistical tests: t-test, ANOVA, post-hocs, linear regression, logistic
# If time, graphing with ggplot2

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

# Variables, Vectors, and Indexing Vectors --------------------------------

# R is a flexible language that can perform a lot of tasks, from basic
# arithmetic up through advanced statistics analyses and graphing. It is often
# the case that we want to save the results of some work, either to use later on
# or just to save us from having to re-run things repeatedly. We can save
# results to a variable using the assignment operator, <- . I don't want to get
# into the nitty-gritty, but <- is convention when you're assigning values to
# variables, and = is typically used for function parameter definitions. Most
# important is that you are consistent.

# example 1: creating a variable that contains the result of addition
my_addition <- 35 + 24
print(my_addition)

# example 2: creating a variable that stores a string (text)
favourite_fruit <- "peach"
print(favourite_fruit)

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

# R can store more than single values at once! It can also store multiple
# elements together, for example the grades in a class or groceries:

grades <- c(88, 89, 85, 91)
print(grades)

groceries <- c("cereal", "milk", "bananas", "dragonfruit", "chicken", "basil")
print(groceries)

# You can index the elements of a vector to see what is stored. In R, indexing
# starts at 1 (unlike, e.g., Python where the first position is indexed to 0).
# So to access the value "bananas" from the groceries vector:

groceries[3]

# A vector can only be one data type (integers, doubles i.e., decimal numbers,
# strings). If you try to put multiple types into one list, the data will be
# coerced into a common type. For example, grocery items and how many of each to
# get:

groceries_numbered <- c("cereal", 1, "milk", 1, "bananas", 7, "dragonfruit", 2, "chicken", 1, "basil", 20)
print(groceries_numbered) # all entries coerced to strings

# Lists (not vectors) can contain multiple types:

groceries_list <- list("cereal", 1, "milk", 1, "bananas", 7)
groceries_list

# Installing and Loading Packages -----------------------------------------

# You can use existing functions in base R or create your own functions, and you
# can *also* use functions written by other people. Recall that R is
# open-source, meaning anyone can write functions that can be freely used by
# other people. It's like Wikipedia in that anyone can write something, but
# there are editors who check that edits make sense. When people publish their
# functions to be used by others, those functions are contained in *packages*.
# To use a package and the functions therein, you need to (1) install the
# package, (2) attach the package to your R session (what we have open right now
# is an R session).

# You only need to install the package once (or when it is updated), but you
# need to attach it to every session you want to use it in. It's like any other
# software: you need to download Google Chrome once to have it on your computer
# (and sometimes you need to redownload to update it), but every time you want
# to use it you have to open it.

# Note that I usually put ALL packages I'll be using at the very top of the
# document, along with the data I'll be using.

# to install, need to do this once
install.packages("dplyr") # you need the quotation marks
install.packages("sjPlot")

# to attach to your session, need to do this every session
library(dplyr)
library("dplyr") # you can use quotation marks or not when attaching

library(sjPlot)

# dplyr stands for "data pliers," and is used for manipulating data. Let's look
# at some example datasets included in the dplyr package, starting with mtcars.
# This has information about cars' fuel consumption. We will use sjPlot later,
# when we are presenting the results of our statistical analyses.

# Inspecting Data ---------------------------------------------------------

# It is usually a good idea to look over your data when you read it in. Reasons
# include (1) familiarizing yourself with its structure, (2) briefly checking it
# read in correctly.

# The mtcars dataset is included in dplyr, which we've loaded, so it's already
# available to us. A few useful functions for looking at your data in R:

head(mtcars) # look at the first few rows
tail(mtcars) # look at the last few rows
summary(mtcars) # get an overview of values
str(mtcars) # overview of data types
View(mtcars) # view the entire dataset

# Data Manipulation with dplyr --------------------------------------------

# Unlike in Excel, you can't access the data directly when Viewing it. Why?
# Because it's better to change it using your code in a reproducible way (no
# wondering if values were changed, forgetting what was changed or moved, etc.),
# and that's where dplyr comes in! It's an R package used for data manipulation,
# with a few main functions: filter (choosing certain rows), select (choosing
# certain columns), mutate (adding/changing columns), arrange (order of rows),
# summarize (summarizing, as the name suggests).

# Filter
# Our dataset has information about cars' number of cylinders. Generally, more
# cylinders = more power. We can use equality/relational statements to filter
# the dataset to cars that have more than/less than/equal to a certain number of
# cylinders.

filter(mtcars, cyl == 6) # equal to, notice the two ==
filter(mtcars, cyl < 6) # less than 6
filter(mtcars, cyl > 6) # greater than 6
filter(mtcars, cyl <= 6) # less than or equal to

# Take cyl == 6. We can see that there are 7 rows. But if we call mtcars, it's
# still the full dataset.
mtcars

# That's because we didn't save it to a new dataset. If we want to work with a
# new dataset, we would need to save it to a variable.
mtcars_6cyl <- filter(mtcars, cyl == 6)

# Select
# So filter chooses certain rows. Select chooses certain columns! Let's say we
# just wanted to look at the car's miles per gallon (mpg) and cylinders (cyl).

# either way works
select(mtcars, mpg, cyl)
select(mtcars, c(mpg, cyl))

# again, if we wanted a new dataset, we would have to save it
mtcars_mpg_cyl <- select(mtcars, c(mpg, cyl))

# You can also *deselect* certain columns using a minus sign.
select(mtcars, -mpg) # removes mpg
select(mtcars, -c(mpg, cyl)) # removes mpg and cyl

# Mutate
# Mutate adds or changes column values. For example, we have the variable qsec
# which is the time it takes a car to go a quarter of a mile, in seconds. Maybe
# we want to know how quickly it can go one mile. Let's multiply by four.

mutate(mtcars, milesec = 4*qsec)

# Group By
# grouping is a powerful operation for data manipulation. Sometimes you want
# information about an entire group, for example maybe we want the average
# horsepower across cylinders. To do that, we first group the dataset by number
# of cylinders, then use the mutate function to calculate average horsepower for
# each group, and then ungroup and go on with our day.

ungroup(mutate(group_by(mtcars, cyl), hp_average = mean(hp)))

# You might notice that it's getting a little difficult to read! This is where
# the "pipe" operator comes in. In older versions of R, it looks like this %>%
# and you have to attach the packages dplyr or magrittr to your session to use
# it. In R 4.1 and newer, there is a pipe built into base R, which looks like
## |>. The pipe makes it easier to read your code, because it takes the result of
# what you just ran, and passes it on to the next thing you're going to run. Our
# same operation looks like this using the pipe:

mtcars |>                           # take the dataset and pass it forward
  group_by(cyl) |>                  # group the dataset by cyl and pass it forward
  mutate(hp_average = mean(hp)) |>  # calculate the mean horsepower
  ungroup()                          # ungroup the dataset and print the result

# again, if you want to save the result of your calculation, you need to save it
# to a variable

mtcars_hp <- mtcars |>
  group_by(cyl) |>
  mutate(hp_average = mean(hp)) |>
  ungroup()

# Arrange
# Arrange organizes the rows in ascending or descending order. The default is
# ascending, i.e., lowest values at the top. If we want to see the lowest
# horsepower cars first:

arrange(mtcars, hp)
mtcars |> arrange(hp) # with the pipe

# highest horsepower, use desc() for descending
arrange(mtcars, desc(hp))
mtcars |> arrange(desc(hp))

# Summarize/Summarise (either spelling works)
# Summarize creates a new data frame summarizing some data. If the data are
# ungrouped, it returns one row. If the data are grouped, it returns one row per
# group. See some functions in the documentation: ?summarize.

mtcars |>
  summarize(mean = mean(hp),
            n = n())

# There are a bunch of other functions, as well, like renaming columns, removing
# them, doing rowwise operations, etc. https://dplyr.tidyverse.org/

# Statistical Analyses ----------------------------------------------------

# Let's do some common statistical analyses using a second dataset, starwars,
# which is included with dplyr and has information about 14 Star Wars characters
# like their height, mass, gender, species, etc. I saved it as a csv so we can
# practice loading files from outside of R.

# Option 1: relative filepath. RECOMMENDED.
starwars <- read.csv("starwars.csv")

# Option 2: absolute filepath. NOT RECOMMENDED. Your code will not work when
# someone else loads it because it will be referencing a specific filepath on
# *your* computer.
# starwars <- read.csv("/Users/yourname/R_tutorial/starwars.csv")

# first few rows
head(starwars)

# We'll focus on a few analyses that you might encounter or that you've seen
# before: t-tests, ANOVAs, linear and logistic regression. Then we'll look at
# displaying results nicely with sjPlot and graphing your regressions with
# marginaleffects.

# t-test
# Let's use a t-test to assess whether humans' weights are significantly
# different from other species.

unique(starwars$species) # we need to add a variable for human/non-human

starwars <- starwars |> 
  mutate(human = ifelse(species == "Human", "human", "nonhuman")) |> 
  mutate(human_droid_other = case_when(species == "Human" ~ "human",
                                       species == "Droid" ~ "droid",
                                       .default = "other"))

# In general, R formulas are "Y ~ X", which you can read as something like "Y
# predicted by X". So here, "mass 'predicted by' human status," which is to say
# "how does mass differ between the human and non-human species?"
t.test(mass ~ human, data = starwars)

# Linear regression
# you can use lm, also in the base stats package
# How are height and mass related?
# simple linear regression
model1 <- lm(mass ~ height, data = starwars) 
summary(model1)

# We can add other predictors for multiple linear regression
model2 <- lm(mass ~ height + gender, data = starwars) 
summary(model2)

# We can add other predictors for multiple linear regression
model3 <- lm(mass ~ height + gender, data = starwars)
summary(model3)

# anova
anova <- aov(mass ~ human_droid_other, data = starwars)
summary(anova)

# post-hoc tests (our result isn't significant, but just to illustrate how to do it)
TukeyHSD(anova)

# also note that a linear regression with a categorical predictor is just an anova, simpler to use one framework
anova_lm <- lm(mass ~ human_droid_other, data = starwars)
summary(anova_lm)

# # We won't discuss assumptions, but you can check with this package
# (https://easystats.github.io/performance/articles/check_model.html) or with
# any number of other R packages.

# Presenting Results: sjPlot and ggplot2 ----------------------------------

install.packages(c("sjPlot", "ggplot2")) # you have to do this once
library(sjPlot) # have to attach to session every time
library(ggplot2) 

# You can print your model results in nice tables and visualize your regression
# coefficients using the sjPlot package. In particular, the function tab_model()
# prints a table ("tab") for your model, and plot_model() generates a plot.

# For our simple linear regression, model
tab_model(model1)
plot_model(model1)

# For our multiple linear regression, model2
tab_model(model2)
plot_model(model2)

# For our simple linear regression, categorical predictor, anova_lm
tab_model(anova_lm)
plot_model(anova_lm)

# For our anova
tab_model(anova)

# If time, graphing with ggplot2 ------------------------------------------

# ggplot stands for "grammar of graphics" plotting, which is the idea that just
# like languages have grammars and once you know that you can construct totally
# new sentences, graphs also have a "grammar," fundamental elements that you can
# use to build all kinds of graphs.

# The main ingredients in a graph are (1) the plotting region (this would be
# like a piece of paper, in the physical world) and (2) the shapes you're using
# in your graph (this is your type of graph) In ggplot2, the shapes are
# generally called "geom"s, and some examples of geoms are histograms,
# scatterplots, bar graphs, line graphs, boxplots, violin plots. 

ggplot(starwars) + # this says "I'm making a plot", like getting out a piece of paper
  geom_point(mapping = aes(x = height, y = mass)) # this is the "point" geom, for a scatterplot. mapping = aes(...) describes what's on your axes

# you can use mapping = aes() in the ggplot() function, in which case it applies
# to ALL geoms unless overwritten, or in an individual geom (just applies to
# that geom).

# There's a lot of graphing, we're not going to come close to doing everything
# possible. There are some resources in the tutorial notes document for further
# learning. The main things we're going to touch on are a few basic shapes and
# colours.

# Graph of height by gender.
ggplot(starwars, mapping = aes(x = gender, y = height)) +
  geom_col()

# Some geoms distinguish between colour (the outside edge) and fill (the inside)

ggplot(starwars, mapping = aes(x = gender, colour = gender)) +
  geom_bar()

ggplot(starwars, mapping = aes(x = gender, fill = gender)) +
  geom_bar()

# some don't distinguish
ggplot(starwars) +
  geom_point(mapping = aes(x = height, y = mass, colour = gender))

# you can also do data manipulation and then pipe into a graph. NOTE THE
# DIFFERENCE: ggplot uses plus signs (+) to join things together, not pipes
# (%>% or |>).

starwars |>  
  ggplot() +
  geom_point(mapping = aes(x = height, y = mass, colour = gender))

starwars |>
  filter(!is.na(gender)) |>
  ggplot() +
  geom_point(mapping = aes(x = height, y = mass, colour = gender))

