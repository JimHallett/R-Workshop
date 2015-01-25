################################################################################
### R-WORKSHOP                                                               ###
### EXERCISE 4: Graphs for publication                                       ### 
################################################################################

## OBJECTIVES:
## To develop a "grammar of graphics".
## To apply this approach to created publication-quality graphs with ggplot2.
## To learn how to export graphs for publication.

## The author of ggplot2, Hadley Wickham, discusses his graphing philosophy
## in his Grammar of Graphics  paper: http://vita.had.co.nz/papers/layered-grammar.pdf
## It is a handy paper!
## There is also excellent ggplot2 documentation at: http://docs.ggplot2.org/current/

## What is a grammar of graphics?
## A grammar of graphics is a tool that enables us to concisely describe the components of a graph.
## This allows us to move beyond named graphics (e.g., the "barplot" we saw earlier) 
## and gain insight into the structure that underlies graphics (we saw a bit of this with "qplot").
## Components that make up a graph include:
    ## Data and aesthetic mapping
    ## Geometric objects
    ## Scales
    ## Facet specification
    ## Statistical transformations
    ## The coordinate system (position)

## Together, the data, mapping, statistical transformation and geometric object form a layer.
## A plot may have multiple layers; for example, 
## when we overlayed a scatterplot with a smoothed line.

## Thus, a layered grammar of graphics builds a plot this way:
    ## A default dataset and set of mappings from variables to aesthetics
    ## One or more layers. Each layer includes have one geometric object, one statistical transformation,
        ## one position adjustment, and one dataset and set of aesthetic mappings
    ## One scale for each aesthetic mapping
    ## A coordinate system
    ## The facet specification


SpokaneFish <- read.csv(file="LowerSpokaneFish.csv", header=TRUE)
# Fix dates
SpokaneFish$Date <- as.Date(SpokaneFish$Date, "%m/%d/%Y")
Redband <- subset(SpokaneFish, Species=="RB" & is.na(ScaleAge)==F )   #This is one of several ways to subset data


#############################
## 1) Aesthetics and mapping
############################
## Recall that we were interested in the relationship between fish length and weight for Redband trout
## The first thing we need to do is specify the default dataset and relationship between variables and aesthetics

## QUESTION: In the code below, what is the default dataset? What are the aesthetics?
## QUESTION: When you run the code below, why don't we see a graph?
ggplot(Redband, aes(x=Length, y=Weight))


######################################
## 2) Adding layers: Geometric objects
######################################

## We need to specify a layer!
## At a minimum, we must specify a geometric object (what shape to add to the plot)
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point()

## We can also add aesthetics to the geometric object.
## For example, we can color points based on ScaleAge.
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point(aes(color=as.factor(ScaleAge)))

## TASK: Alter the aesthetics of the geometric object so that their shape varies with as.factor(ScaleAge)

## TASK: visit the ggplot2 documentation webpage at http://docs.ggplot2.org/current/
## Name five other geometric objects


################################################
## 2) Adding layers: Statistical transformations
################################################

## A stat takes a dataset as input and retulrsn a dataset as output,
## so a state can add new variables to the original dataset. 
## It is also possible to map aesthetics onto these new variables.
## For example, we described weight within each factor of ScaleAge.
## Here, the geom_boxplot() call does two things:
    ## It calculates a new dataset based on statistically transforming the default dataset and aesthetics (Weight and ScaleAge)
      ## In this case, it creates a dataframe of  the mean and upper and lower quantiles of Weight within ScaleAge
    ## It adds this transformed data as a geometric object

ggplot(Redband, aes(x=as.factor(ScaleAge), y=Weight)) + geom_boxplot()

## We can change the aesthetics of geom_boxplot() too
ggplot(Redband, aes(x=as.factor(ScaleAge), y=Weight)) + geom_boxplot(aes(fill=factor(ScaleAge)))

## And we can add new aesthetics to geom_boxplot that alter the statistical transformation
ggplot(Redband, aes(x=as.factor(ScaleAge), y=Weight)) + geom_boxplot(aes(fill=factor(Pass)))

## QUESTION: Can you name another statistical transformation? Hint: we saw one in the SimpleStats module.


#########################################
## 3) Adding layers: Position adjustments
#########################################

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