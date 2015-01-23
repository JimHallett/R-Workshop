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

## Here is one way to change the temperature columns to numeric. 
## Helpful note: This works because they are character values;
## if R the columns were factors we would have to convert them to character vectors 
## before converting to numeric (otherwise it would give numeric assignments to each factor level)
mydat$calispell_temp<-as.numeric(mydat$calispell_temp)
mydat$smalle_temp<-as.numeric(mydat$smalle_temp)
mydat$winchester_temp<-as.numeric(mydat$winchester_temp)


## QUESTION: How would we convert a factor to a character?
## QUESTION: What are two ways to verify that the temperature columns are numeric?


#################################
## 2) dplyr tool number 1: tbl_df
#################################mydat


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

#Now that you know how to select a subset of columns using select(), 
#a natural next question is “How do I select a subset of rows?” 
#That’s where the filter() function comes in.

## I might be worried about high water temperatures. 
## Let's filter the the dataframe table to only include data with temperature equal or greater than 15 C

filter(wtemp, calispell_temp>=15)

## QUESTION: How many rows match this condition?

## We can also filter based on multiple conditions. 
## For example, did the water get hot (=>15) on the 4th of July, 2013? I want both conditions to be true:
filter(wtemp, calispell_temp>=15, date == "7/4/13")

##And I can filter based on "or" - if any condition is true. 
## For example, was water temp >=15 at any site?
filter(wtemp, calispell_temp>=15 | smalle_temp>=15 | winchester_temp>=15)

##QUESTION: How many rows match this condition?

## Finally, we might want to only get the row which do not have missing data. R represents missing values with NA
## We can detect missing values with the is.na() function.
## Try it out:
is.na(c(3,5, NA, 6))

## Now put an exclamation point (!) before is.na() to change all of the TRUEs to FALSEs and FALSEs to TRUEs
## This tells us what is NOT NA:
!is.na(c(3,5, NA, 6))

## TASK: Time to put this all together. Please filter all of the rows of wtemp 
## For which the value of calispell_temp is not NA.
## How many rows match this condition?


##################################
## 4) dplyr tool number 3: arrange
##################################

## Sometimes we want order the rows of a dataset according to the values of a particular variable
## For example, let's order the dataframe by calispell_temp 

arrange(wtemp, calispell_temp)

## QUESTION: What is the lowest temperature observed in Calispell Creek?

## But wait! We're more worried about high temperatures.
## To do the same, but in descending order, you have two options. 
arrange(wtemp, -calispell_temp)
arrange(wtemp, desc(calispell_temp))

## And you can arrange by mutiple variables. 
## TASK: arrange the dataframe by date then desc(smalle_temp)


##################################
## 5) dplyr tool number 4: mutate
##################################