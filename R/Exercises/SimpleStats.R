################################################################################
### R-WORKSHOP                                                               ###
### EXERCISE 3: Simple statistics                                            ### 
################################################################################

## OBJECTIVE: To explore some simple statistics and analyses.

## We'll use some fish data from Chuck Lee at WDFW for the Lower Spokane River.

## First we'll read in the data.

SpokaneFish <- read.csv(file="LowSpokaneClean.csv", header=TRUE, sep=',')
# Fix dates
SpokaneFish$Date <- as.Date(SpokaneFish$Date, "%m/%d/%Y")
# Make it easier to see in the console
tbl_df(SpokaneFish)

# We often want to look at frequency data, for example, the numbers of each fish
# species in our samples.

# We use the table command to determine counts:

table(SpokaneFish$Species)  # Prints number of each species to the console

# We can also store this table

Species.freq <- table(SpokaneFish$Species)

# We then also allows us to calculate proportions

prop.table(Species.freq)

# Or round to 2 decimal places

round(prop.table(Species.freq),3)

# Or express as percent by multiplying by 100

round(prop.table(Species.freq), 3) * 100

# We'll just consider redband trout (RB) to look at quantitative variables

Redband <- SpokaneFish[ which(SpokaneFish$Species=='RB'), ]   #There are several ways to subset data

# Descriptive statistics are useful for understanding data. The redband data include weights and fin lengths.
# We'll look at these 2 variables. The built in function summary is useful.

summary(Redband$FinLength)
summary(Redband$Weight)

# We can run the command for the entire data table, but some results may be meaningless.

summary(Redband)

# There are other descriptors in packages such as psych. This package will have to be installed.

library(psych)

describe(Redband$FinLength) 
describe(Redband$Weight)

# We also gain a lot of understanding by graphing our data. We'll start with some quick and simple
# plots. 

# We created several tables above, but now we'll save one to plot:

speciesplot <- round(prop.table(Species.freq), 3) * 100

barplot(speciesplot)

# Well this is boring, but we can at least see some of the parameters that can be changed. For example,
# we can change the order of the bars, flip them horizontally, and add an x-label.

barplot(speciesplot[order(speciesplot)], 
horiz = TRUE,  
xlab = "Proportion of total capture")  

# This is obviously very rudimentary and there are other graphics packages that provide greater
# flexibility. We'll use ggplot2 for this session. Some others including ggvis are still being
# developed and will provide interactivity. Shiny also provides direct interaction, but requires
# initial setup - more on that later.

library(ggplot2)

# We'll first look at the relationship between fin length and weight in Spokane River redband.
# First, a simple scatterplot:

qplot(FinLength, Weight, data = Redband)

# Note that we can also identify the dataset by using Redband$FinLength. 

# This scatterplot shows a curvilinear relationship between weight and fin length. 
# We can deal with this in several ways, but here we apply a log transformation to the data.

qplot(log(FinLength), log(Weight), data = Redband, geom=c("point"))

# That helps linerize the data. So now we'll create a linear regression line to fit the data.

qplot(log(FinLength), log(Weight), data = Redband, geom=c("smooth"),  method="lm", formula=y~x)

# And now combine both the linear regression line with the point data. 

qplot(log(FinLength), log(Weight), data = Redband, geom=c("point", "smooth"),  method="lm", formula=y~x)

# There are of course additional options for graph creation including axis labels.

qplot(log(FinLength), log(Weight), data = Redband, geom=c("point", "smooth"),  method="lm", 
      formula=y~x, xlab="Fin Length", ylab = "Weight")

# The graph can be saved as an object, too.

graph1 <- qplot(log(FinLength), log(Weight), data = Redband, geom=c("point", "smooth"),  method="lm", formula=y~x)










 




















