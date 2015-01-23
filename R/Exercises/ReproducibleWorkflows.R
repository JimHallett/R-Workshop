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

## One last bit of housekeeping we have to do because of the odd column names.
## Check the current structure of mydat
str(mydat)

## QUESTION: Why are all the columns character vectors?

#################################
## 2) dplyr tool number 1: tbl_df
#################################

## First things first, let's load dplyr:
library(dplyr)

## It's important that you have dplyr version 0.2 or later. To confirm, type:
packageVersion("dplyr")

## If your dplyr version is not at least 0.2, raise your hand or click on the packages tab to reinstall dplyr.

## The first step of working with data in dplyr is to load the data in what the package authors call
## a 'data frame tbl' or 'tb_df'.
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
## 3) dplyr tool number 2: select
#################################

## Later we will 'tidy' this dataset to include a 'site' variable and 'temperature' variable
## But for now, let's imagine that we are only intested in the temperature at the Calispell site
## select helps us to reduce the dataframe to just columns of interesting

select(wtemp, calispell_temp, date, time)

## QUESTION: Are the columns in the same order as wtemp?
## NOTE: We didn't have to type wtemp$date etc as we normally would; 
## the select() function knows we are referring to wtemp

## Remember that in R, the : operator is a compact way to create a sequence of numbers? For example:
5:20

## Normally this notation is just for numbers, but select() allows you to specify a sequence of columns this way.
## This can save a bunch of typing! 

## TASK: Select date, time and calispell_temp using this notation

## Print the entire dataframe again, to remember what it looks like.
## We can also specify the columns that we want to discard. Let's remove smalle_temp, winchester_temp that way:

select(wtemp, -smalle_temp, -winchester_temp)

## TASK: Get that result  a third way, by removing all columns from smalle_temp:winchester_temp.
## Be careful! select(wtemp, -smalle_temp:winchester_temp) doesn't do it...


#################################
## 3) dplyr tool number 3: filter
#################################

