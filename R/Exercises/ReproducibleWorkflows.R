################################################################################
### R-WORKSHOP                                                               ###
### EXERCISE 5: Developing reproducible workflows                            ### 
################################################################################

## OBJECTIVES:
## To learn now to wrangle raw data into a form useable for analysis and graphs.
## To do this in a way that each step is traceable and reproducible.
## To this end we'll be using the dplyr package.

########################
##1) Reading in the data
########################

## We will focus on a water temperature dataset. These type of data are ripe for 
## for scripted analysis because their formats remain constant but graphs frequently
## need to be updated to reflect new data.

rawdat<-read.csv("Calispell Creek and Tributary Temperatures.csv", stringsAsFactors=FALSE)

## Oops, we got an error! 
## QUESTION: Why?
## HINT 1: What is the default header argument for the read.csv function?
## HINT 2: Are there non-standard characters in the .csv headings? 

## There are two ways to fix this issue:
## a) Use short, descriptive headings for data input that are explained with paired meta-data.
## This is good data-management policy anyway.
## It is best if column headings do not have spaces or non-standard characters.
## If you need several words for a variable name, consider camelCase or under_score.

## a) Correct it in R. 
## This is an okay option when the headings are generated automatically,
## for example by a temperature logger. That's what we'll do here.

## Let's try again:
rawdat<-read.csv("Calispell Creek and Tributary Temperatures.csv", header=FALSE, stringsAsFactors=FALSE)

## QUESTION: What does stringsAsFactors mean? Why would we want to make it false?

## Look at the first 6 rows of rawdat
head(rawdat)

## QUESTION: What are the current column names? If you're not sure, check this way:
names(rawdat)

## We need to assign new column names. I suggest: date, time, calispell_temp, smalle_temp, winchester_temp
names(rawdat)<-c("date", "time", "calispell_temp", "smalle_temp", "winchester_temp")

## If I only wanted to change specific columns, I could specify them by position
## For example
names(rawdat)[1]<-"date"

## Then I need to get rid of the first row (which held the old column names)
## I'll do this by creating a new dataframe called mydat that is rawdat without the first row:
mydat<-rawdat[-1,]

#################################
## 2) dplyr tool number 1: tbl_df
#################################

## First things first, let's load dplyr:
library(dplyr)

## It's important that you have dplyr version 0.2 or later. To confirm, type:
packageVersion("dplyr")

## If your dplyr version is not at least 0.2, raise your hand or click on the packages tab to reinstall dplyr

## The first step of working with data in dplyr is to load the data in what the package authors call
## a 'data frame tbl' or 'tb_df'
## Use this code to create a new tbl_df called wtemp:

wtemp<-tbl_df(mydat)

## From ?tbl_df:  “The main advantage to using a tbl_df over a regular data frame is the printing.” 
## Let’s see what is meant by this. 

wtemp

## QUESTION: What class is wtemp? How many rows does wtemp have? How many columns?

## To reinforce how nice this is, print mydat instead:
mydat

## Ophf! To never see that again, let's remove rawdat and mydat from the workspace
rm(rawdat)
rm(mydat)

#################################
## 3) dplyr tool number 3: select
#################################

##

