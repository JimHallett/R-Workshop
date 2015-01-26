################################################################################
### R-WORKSHOP                                                               ###
### MODULE 4: Graphs for publication                                         ### 
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
    ## A default dataset and set of mappings from variables to aesthetics.
    ## One or more layers. Each layer includes have one geometric object, one statistical transformation,
        ## one position adjustment, and one dataset and set of aesthetic mappings.
    ## One scale for each aesthetic mapping.
    ## A coordinate system (ie, Cartesian, Polar, etc).
    ## The facet specification.

## First let's load ggplot2
library(ggplot2)

## Make sure your working directory is set to R-Workshop/Data!
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

## A stat takes a dataset as input and visualizes a new, processed dataset with new variables as output.

## For example, if we could relate length and width by calculating and graphing a smoothing function:
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point() + geom_smooth()

## Another example of a statistical transformation is geom_boxplot() which:
    ## Calculates a new dataset based on statistically transforming the default dataset and aesthetics (Weight and ScaleAge)
      ## In this case, it creates a dataframe of  the mean and upper and lower quantiles of Weight within ScaleAge
    ## Adds this transformed data as a geometric object
ggplot(Redband, aes(x=as.factor(ScaleAge), y=Weight)) + geom_boxplot()

## QUESTION: Can you name another statistical transformation? Hint: we saw one in the SimpleStats module.


#########################################
## 3) Adding layers: Position adjustments
#########################################

## Sometimes we need to tweak the position of the geometric objects in a plot, 
## for example if they would otherwise obscure each other.
## This might occur in a scatter plot with few unique values, in which case you would add a jitter option:
    ## geom_point(position="jitter")

## And we commonly need position adjustments for barplots, where they either need to be stacked or dodged.
## For example, we might want to visualize mean weight by scale age and pass as a barplot

## To illustrate, first run this code to summarize our data.
## We will discuss the syntax below in length later; but trust me on it for now.
library(dplyr)
Redband2<- tbl_df(Redband) %>%
  filter (!is.na(ScaleAge) & !is.na(Weight) & (Pass==1 | Pass==2))%>%
  group_by(ScaleAge, Pass) %>%
  summarize(meanWeight=mean(Weight), seWeight=sd(Weight)/sqrt(length(Weight)))

## Take a look at Redband2
Redband2

## Let's make a bar graph with the following:
## Default dataframe: Redband2
## Aesthetics: x=ScaleAge, y=meanWeight, fill color = Pass
##  ScaleAge on x axis, meanWeight on y axis, and Pass represented by fill color.
ggplot(Redband2, aes(x=as.factor(ScaleAge), y=meanWeight, fill=as.factor(Pass))) +
  geom_bar(stat="identity")

## I don't like the stacked graphs that much! I'd much rather have each pass side by side, 
## within the ScaleAge category. We can specify the position within geom_bar()
ggplot(Redband2, aes(x=as.factor(ScaleAge), y=meanWeight, fill=as.factor(Pass))) +
  geom_bar(stat="identity", position="dodge")


#########################################
## 4) Adding layers: standard error terms
#########################################

## The graph we just created looks great, but is missing something really important!
## QUESTION: What is it missing?!

## Let's create an aesthetic called limits to describe the upper and lower se bounds
limits<-aes(ymax=meanWeight+seWeight, ymin=meanWeight-seWeight)

## We can add a second layer to our graph that includes this 'limits' aesthetic
## Note that this layer also has a position adjustment
ggplot(Redband2, aes(x=as.factor(ScaleAge), y=meanWeight, fill=as.factor(Pass))) + 
  geom_bar(stat="identity", position="dodge") + geom_errorbar(limits, position="dodge")


#########################################
## 5) Altering scales
#########################################

## A scale controls the mapping from data to aesthetic attribute. 
## For example, the following are all aspects of scale:
## The size and color of points and lines, axes limits and labels
## Manipulating scale parameters goes a long way in making a graph publication-ready!

## Let's start by revisiting our basic length by weight scatter plot
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point()

## We could alter the size and color and shape of the points
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point(size=1, color="darkblue", shape=1)

## We could add on to alter the x and y axes scales; for example, let's make put them on a log10 scale
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point(size=1, color="darkblue", shape=1) +
  scale_x_log10() + scale_y_log10()

## We could customize the x and y axis labels
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point(size=1, color="darkblue", shape=1) +
  scale_x_log10() + scale_y_log10() +
  xlab("Redband trout length (mm)") + ylab("Redband trought weight (g)")


#########################################
## 5) Specifying facets
#########################################

## Faceting makes it easy to graph subsets of an entire dataset. 
## For example, we could relate length and width within each age class.
## We do that by adding a facet specification to our initial graph:
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point() + facet_wrap(~ScaleAge)

## We could also make a grid by faceting one variable by another.
ggplot(Redband, aes(x=Length, y=Weight)) + geom_point() + facet_grid(Year~ScaleAge) 

#########################################
## 5) Storing and exporting graphs
#########################################

## Once we have a graph we love, we need to export it at a publication-quality resolution.
## I think this is a lovable graph, so I'm saving it as "RB_LengthWidth".

## Note that ggplot2 includes default color themes (here I changed to the default a classic theme)
## The overrode default text size settings to make the text bigger

RB_LengthWidth <- ggplot(Redband, aes(x=Length, y=Weight)) + geom_point(size=2, color="black", shape=1) +
  geom_smooth() + 
  scale_x_log10() + scale_y_log10() +
  xlab("Redband trout length (mm)") + ylab("Redband trought weight (g)") + 
  theme_classic() + 
  theme(text = element_text(size=20))

## Let's look at it:
print(RB_LengthWidth)

## Nice! We can export from all in all kinds of file formats. Take a look:
?tiff
?pdf

## For example, let's export as a tiff file
## Unless we specify otherwise, we will find it in our working directory.
## The default export unit for tif is pixel, but you can specify in, cm or mm if you like,
## and you can change the aspect ratio by adjusting width and height

tiff("LittleSpokane_RB_LengthWidth.tiff", width=560, height=480)
print(RB_LengthWidth)
dev.off()
