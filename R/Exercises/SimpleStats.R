################################################################################
### R-WORKSHOP                                                               ###
### EXERCISE 3: Simple statistics                                            ### 
################################################################################

## OBJECTIVE: To explore some simple statistics and analyses.

## We'll use some fish data from Chuck Lee at WDFW for the Lower Spokane River.

################################################################################
### Preliminary: Reading the data                                            ###
################################################################################

## First we'll read in the data and get it ready to use.

SpokaneFish <- read.csv(file="LowSpokaneClean.csv", header=TRUE, sep=',')

# Fix dates
SpokaneFish$Date <- as.Date(SpokaneFish$Date, "%m/%d/%Y")

# Make it easier to see in the console
# This is a function in the dplyr package, we'll spend a lot of time with that package later.
# First we need to load dplyr.
library(dplyr)

# Then save our data in a "dataframe table" format, which makes it nicer to print.
SpokaneFish <- tbl_df(SpokaneFish)

# Print SpokaneFish to take a look:
SpokaneFish


################################################################################
### EXERCISE 1: Looking at frequencies                                       ###
################################################################################

# We often want to look at frequency data, for example, the numbers of each fish
# species in our samples.

# We use the table command to determine counts:
table(SpokaneFish$Species)  # Prints number of each species to the console

# TASK: Use the table function to create a table of captures at each sampling site.

# We can also store tables, as done here for fish species:
Species.freq <- table(SpokaneFish$Species)

# We can use this stored table to further characterize the data.
# For example, R can then calculate proportions:
prop.table(Species.freq)

# Don't think the data are quite that precise! Let's round to 2 decimal places:
round(prop.table(Species.freq), 2)

# QUESTION: Is this satisfactory? How might you modify the result?
# TASK: Sometimes we'll want to convert to percentages. Can you do that for this example?


################################################################################
### EXERCISE 2: Looking at summary statistics                                ###
################################################################################

# By a large margin Redband trout was the most common species.
# Let's focus on characterizing the size structure of the Redband trout population.

# First create a dataframe that only includes Redband trout.
Redband <- SpokaneFish[ which(SpokaneFish$Species=='RB'), ]   #This is one of several ways to subset data

# Descriptive statistics are useful for understanding data. The redband data include weights and fin lengths.
# We'll look at these 2 variables. The built in function summary is useful.
summary(Redband$FinLength)
summary(Redband$Weight)

# We can run the command for the entire data table, but some results may be meaningless.
summary(Redband)

# There are other descriptors in packages such as psych. This package will have to be installed.
# You only have to do this step the first time! After you've installed, go ahead a comment this line out.
install.packages("psych") 

# But we need to load the package at the beginning of each work session.
library(psych)

# Check out the describe function in the psych library.
describe(Redband$FinLength) 
describe(Redband$Weight)

# QUESTION: What is the median legnth of a Redband trout in the Lower Spokane?


################################################################################
### EXERCISE 3: Exploratory graphing                                         ###
################################################################################

# We also gain a lot of understanding by graphing our data. 
# We'll start with some quick and simple plots. 

# We created several tables above, but now we'll save the species frequency table 
# in a dataframe called "speciesplot" 
speciesplot <- round(prop.table(Species.freq), 3) * 100

# A quick bargraph really highlights how common the Redband trout is!
barplot(speciesplot, xlab="Species", ylab="Percentage of total capture")

# Even though barplot is a quick and dirty way to visualize, you can still "dress it up" a lot.
# We can do this altering the input dataframe or specifying arguments in the function.
# For example, we can change the order of the bars and flip them horizontally. And keep on adding axes labels!
barplot(speciesplot[order(speciesplot)], 
horiz = TRUE,  
ylab="Species",
xlab="Percentage of total capture")  

# QUESTION: What would you type to see other argument options in th barplot function?


################################################################################
### EXERCISE 4: More flexible exploratory graphing                           ###
################################################################################

# The previous function barplot makes one type of plot (a barplot!).
# The ggplot2 package provides a "quick plot" option that can make many different types of graphs.
# Unless you specify the type, it will guess based on your data inputs - this is handy for preliminary graphing.

# First, load in the ggplot2 package.
library(ggplot2)

# "Guessing" which plot type to use works best when data are in a dataframe instead of a table,
# because as we saw in the "LookingatData" module, dataframes have information on the type of data.
# For example, integer and numeric columns are continuous variables; character and factor columns are categorical.

# Let's revisit the Redband dataframe to look at the relationship between fin length and weight in Spokane River redband.
# First, a simple scatterplot:
qplot(FinLength, Weight, data = Redband) 

# Note that we can also identify the dataset by using Redband$FinLength, etc. 

# This scatterplot shows a curvilinear relationship between weight and fin length. 
# We can deal with this in several ways, but here we apply a log transformation to the data.
qplot(log(FinLength), log(Weight), data = Redband)

# That helps linerize the data. So now we'll create a linear regression line to fit the data.
qplot(log(FinLength), log(Weight), data = Redband, geom=c("smooth"),  method="lm", formula=y~x)

# And now combine both the linear regression line with the point data. 
qplot(log(FinLength), log(Weight), data = Redband, geom=c("point", "smooth"),  method="lm", formula=y~x)

# QUESTION: By comparing the arguments specified in the above three graphs, what do you think the 
# default option of geom=c() is?
# Check that you are right:
?qplot

# ?qplot highlights that there are a lot of different argument options.
# One to always remember is specifying axis labels.
# qplot (and the base function plot) will default to column headings, but sometimes we want to be more descriptive.
qplot(log(FinLength), log(Weight), data = Redband, geom=c("point", "smooth"),  method="lm", 
      formula=y~x, xlab="Log (Fin Length (mm))", ylab = "Log (Weight (g))")

# The graph can be saved as an object, too.
graph1 <- qplot(log(FinLength), log(Weight), data = Redband, geom=c("point", "smooth"),  
           method="lm", 
           formula=y~x, xlab="Log (Fin Length (mm))", ylab = "Log (Weight (g))")

# Print it!
print(graph1)

# Our preliminary graphing indicates a positive relationship between  log(fin length) and log(weight). 
# We could think of this as a simple linear model.
weightmodel1 <- lm(Weight~FinLength, data=Redband)
summary(weightmodel1)

# What if that's not the whole story? Sometimes weight is a factor of both length and age.
# Let's first visualize how fine weight and legnth relate as a fuction of scale age.
qplot(log(FinLength), log(Weight), data = Redband, color=factor(ScaleAge))

# We could think of this as a multiple regression model with one continuous and one categorical variable.
weightmodel2 <- lm(Weight~FinLength + factor(ScaleAge), data=Redband)
summary(weightmodel2)

# This quick and dirty look seems to support at the relationship between scale age and growth.

# Let's next look at the relationship between fin length (quantitative) and scale age (qualitative).
# We'll start with a simple histogram. 
hist(Redband$FinLength)

# Which we'll add some color to and adjust the bar widths.

hist(Redband$FinLength, breaks=100, main="", col="Red")

# Plot the histgram for redband weight. 

# The histogram of fin lengths suggests that there are at least 3 cohorts.  
# Let's look at this as a function of scale age.
# First we create a factor for scale age:

scale.f <- factor(Redband$ScaleAge)      #Creates a factor of the scale ages

# What does this factor look like?

# Now we'll create a density plot based on this factor. The line width is increased (lwd=3)
# to make it easier to see.

sm.density.compare(Redband$FinLength, Redband$ScaleAge, lwd=3)

# We can also show this as a whisker plot:

plot(Redband$FinLength ~ scale.f) 


################################################################################
### EXERCISE 5: Testing for differences                                      ###
################################################################################


# Both density and whisker plots for fin length show some clear separation between some 
# scale age classes and a degree of overlap for the older classes. We can examine this further with 
# analysis of variance (ANOVA). The question is whether the means of the groups differ.


aovout.fl = aov(Redband$FinLength ~ factor(Redband$ScaleAge))
summary(aovout.fl)
             
# This shows us that there are significant differences among the 8 scale age groups.
# Next we'll do a multiple comparisons test to see where the differences reside.

TukeyHSD(aovout, conf.level = 0.95)

# This test indicates that scale age groups 0, 1, 2, 3 and 4 are distinct. Groups 4 and 5 overlap
# and there is substantial overlap amongst the later age groups. 

# Does weight show the same pattern as fin length?

###################################################################################################

























