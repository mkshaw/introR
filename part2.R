# Part 2 Agenda ------------------------------------------------------------

# Installing and loading packages
# Loading datasets
# Data Manipulation with dplyr
# Statistical analyses: t-test, linear and logistic regression
# Graphing with ggplot2
# Troubleshooting

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

# to attach to your session, need to do this every session
library(dplyr)
library("dplyr") # you can use quotation marks or not when attaching

# dplyr stands for "data pliers," and is used for manipulating data. Let's look
# at some example datasets included in the dplyr package, starting with mtcars.
# This has information about cars' fuel consumption.

# Loading datasets --------------------------------------------------------

# Because the dataset is included in dplyr, which we've loaded, it's already
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

# You might notice that it's getting a little difficult ot read! This is where
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
  mutate(human = ifelse(species == "Human", "human", "nonhuman"))

# In general, R formulas are "Y ~ X", which you can read as something like "Y
# predicted by X". So here, "mass 'predicted by' human status," which is to say
# "how does mass differ between the human and non-human species?"
t.test(mass ~ human, data = starwars)

# Linear regression
# you can use lm, also in the base stats package
# How are height and mass related?
model <- lm(mass ~ height, data = starwars)
summary(model)

# a linear regression with a categorical predictor is an anova
# for example, effect of gender on height
# in these data, gender = female or male
model2 <- lm(mass ~ gender, data = starwars)
summary(model2)

# We can add other predictors for multiple linear regression
model3 <- lm(mass ~ height + gender, data = starwars)
summary(model3)

# # We won't discuss assumptions, but you can check with this package
# (https://easystats.github.io/performance/articles/check_model.html) or with
# the graphing discussed below.
# diagnostics <- plot(performance::check_model(model3, panel = F))
# diagnostics 

# Logistic Regression (plus data manipulation) ----------------------------

# let's read in some data about chess games These data are a subset of games
# from 2017, from the lichess database: https://database.lichess.org/
chess <- read.csv("chess.csv")

str(chess)

# Result: the result of the game from the white pieces' perspective
# WhiteElo: the rating of the person playing the white pieces
# BlackElo: the rating of the person playing the black pieces

# let's look at how rating difference affects winning
# first, we want a binary outcome, let's create a variable called "WhiteWins".
# If white wins, it equals 1, otherwise 0. (I removed draws from these data.)
# Then, we want to create one variable to represent the rating differences
# between players. Let's make it WhiteElo - BlackElo, so positive numbers mean
# the person playing white is stronger and vice versa. (We could have chosen the
# opposite direction, too, this is just easier in my mind for conceptualizing
# the results.)

chess <- chess |> 
  mutate(WhiteWins = ifelse(Result == "1-0", 1, 0),
         RatingDiff = WhiteElo - BlackElo)
  
# you can use glm, in the base stats package
model4 <- glm(WhiteWins ~ RatingDiff,
              family = binomial,
              data = chess)
summary(model4) # summary returns the log odds, we can calculate odds ratios
exp(coef(model4)) # this returns e^beta

# Presenting Results: sjPlot and ggplot2 ----------------------------------

install.packages(c("sjPlot", "ggplot2")) # you have to do this once
library(sjPlot) # have to attach to session every time
library(ggplot2) 

# You can print your model results in nice tables and visualize your regression
# coefficients using the sjPlot package. In particular, the function tab_model()
# prints a table ("tab") for your model, and plot_model() generates a plot.

# For our simple linear regression, model
tab_model(model)
plot_model(model)

# For our simple linear regression, categorical predictor, model2
tab_model(model2)
plot_model(model2)

# For our multiple linear regression, model3
tab_model(model3)
plot_model(model3)

# For our logistic regression
tab_model(model4) # converts to odds ratios for you
plot_model(model4)

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

# Troubleshooting ---------------------------------------------------------

# You WILL run into problems/errors/bugs while coding. It's all part of the
# process, and you get better at coding by running into problems and then
# solving them. It sounds basic, but truly a huge part of troubleshooting and
# debugging is just Googling. There are tons of answers on StackExchange,
# reddit, ChatGPT, etc. All you need to do is copy-paste your exact error
# message into Google. A few things to note: (1) try to avoid copy-pasting
# solutions. Instead, look at what it says, try to understand, and then
# implement your own solution. It's fine to copy-paste sometimes, just try to
# copy-paste less as time goes on. It will help you really understand your code.
# (2) With ChatGPT, same thing, try to understand (or ask it to explain until
# you understand), and note that I personally have seen ChatGPT give nonsense,
# not-working code. You need to understand what you're trying to do before you
# can code it up or recognize when there are mistakes. (3) If you're asking a
# question on a forum like StackExchange, make sure you are very detailed about
# what you're trying to do, what solutions you have tried already, and include
# data that replicates your problem. Also make sure you've searched to see if
# someone has asked that question already. If you don't do these four things,
# you're less likely to get an answer.
