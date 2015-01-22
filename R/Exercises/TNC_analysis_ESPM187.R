#################
#Import the data#
#################

mydat<-read.csv("TNC_BommerCanyon_data.csv")

#What does the dataset look like?
head(mydat)
str(mydat)

#YOUR TURN: What type of object is mydat?
#YOUR TURN: How many rows does mydat have?
#YOUR TURN: What type of values are in the nativeRich column?

#Before we get into it, let's get a feel for R's indexing format

#R uses a [row, column] indexing format 
#to get a feel for it, try calling the first 8 rows of the first column
mydat[1:8,1]

#you can call the same thing using the name of the first column
mydat[1:8, "plot"]

#or you can specify the column with a $, then select rows
mydat$plot[1:8]

#there is also a [[]] format for lists; don't worry about this now but it affects data structure
#for example, compare
str(mydat["plot"])
str(mydat[["plot"]])

####################
#Visualize the data#
####################

plot(nativeCover~exoticCover, data=mydat, bty="l", 
     xlab="Exotic cover proportion/4m2", ylab="Native cover proportion/4m2")

##YOUR TURN: Graph native richness by exotic richness. Is the pattern the same?

###############
#DATA ANALYSIS#
###############

####t-test####
#Let's test the hypothesis that the tarweed cover crop treatment influences native cover

#How many categories in the tarweed cover crop variable?
length(unique(mydat$tarweed))
#what test should we do? why?

help(t.test)
t.test(nativeCover~tarweed, data=mydat)

#YOUR TURN: Are you doing a one or two sided t-test?
#YOUR TURN: What is the p value?
#YOUR TURN: What would you conclude?

#Quick and dirty visualization
boxplot(nativeCover~tarweed, data=mydat)

#Now let's graph it formally!
#First we need to calculate mean values for a bargraph
natCovmean<-aggregate(nativeCover~tarweed, data=mydat, mean)

#Next we need to calculate the standard error of the mean
#se = sqrt(variance/n) = standard deviation/sqrt(n) 
#where n is sample size

#There is no built-in function in R for standard error
#So let's write one!
calcSE<-function(x){
  sd(x)/sqrt(length(x))
}

#Now we'll apply our calcSE function to our data
natCovSE<-aggregate(nativeCover~tarweed, data=mydat, calcSE)

#Let's graph it!
#To add standard error bars we need a package called "plotrix"
#You only need to run the "install.packages" command once 
install.packages("plotrix")

#But you do have to load the package each session you use it
library(plotrix)

#Let's plot it!
#Note how the barplot command is included inside the plotCI command
plotCI(barplot(natCovmean[,2], beside=T, ylim=c(0,.5), 
               ylab="Native cover proportion/4m2", xlab="Treatment", 
               names.arg=c("No Tarweed", "Tarweed")), 
       natCovmean[,2],uiw=natCovSE[,2],add=T, pch=NA)


####ANOVA####
##This experiment has a factorial design:
#tarweed and mulch treatments were done in all possible combinations
#This allows us to ask whether the effect of tarweed depends on mulching
#This time, let's use native richness/4m2 as our response variable

##YOUR TURN: what test would you need?

myanova<-aov(nativeRich~tarweed*mulch, data=mydat)
summary(myanova)

##YOUR TURN: does the effect of tarweed depend on mulching?

####REGRESSION####
#What if we are interested in whether plots with greater native richness
#better resist invasion (have lower exotic species cover)

myregression<-lm(exoticCover~nativeRich, data=mydat)
summary(myregression)

#YOUR TURN: What is the R2 value? Is the relationship significant?
#YOUR TURN: Does native richness matter?

#Let's graph it out
plot(exoticCover~nativeRich, data=mydat, bty="l", 
     ylab="Propotion exotic cover/4m2", xlab="Native richness/4m2")

#YOUR TURN: should you include a best fit line?
#If so, here's the command:
abline(myregression)



