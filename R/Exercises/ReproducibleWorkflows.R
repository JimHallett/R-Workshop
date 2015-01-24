################################################################################
### R-WORKSHOP                                                               ###
### EXERCISE 5: Developing reproducible workflows                            ### 
################################################################################

## OBJECTIVES:
## To learn how to wrangle raw data into a form useable for analysis and graphs.
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

## To illustrate why it would be easier to have cleaner column headings to begin with
## Here's the same data but saved with our new column names
mydat2<-read.csv("Calispell Creek and Tributary Temperatures2.csv", stringsAsFactors=F)

## What data type does R assign to each column of mydat2?
## Why is this different than rawdat?


#################################
## 2) dplyr tool number 0: tbl_df
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
## 3) dplyr tool number 1: select
#################################

## Later we will 'tidy' this dataset to include a 'site' variable and 'temperature' variable
## But for now, let's imagine that we are only intested in the temperature at the Calispell site
## select helps us to reduce the dataframe to just columns of interesting
select(wtemp, calispell_temp, date, time)

## QUESTION: Are the columns in the same order as wtemp?
## NOTE: We didn't have to type wtemp$date etc as we normally would; 
## the select() function knows we are referring to wtemp.

## Recall that in R, the : operator is a compact way to create a sequence of numbers. For example:
5:20

## Normally this notation is just for numbers, but select() allows you to specify a sequence of columns this way.
## This can save a bunch of typing! 

## TASK: Select date, time and calispell_temp using this notation

## Print the entire dataframe again, to remember what it looks like.
## We can also specify the columns that we want to discard. Let's remove smalle_temp, winchester_temp that way:
select(wtemp, -smalle_temp, -winchester_temp)

## TASK: Get that result a third way, by removing all columns from smalle_temp:winchester_temp.
## Be careful! select(wtemp, -smalle_temp:winchester_temp) doesn't do it...


#################################
## 3) dplyr tool number 2: filter
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

## QUESTION: Why did we need to use double equal signs (ie == vs =)?

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
## for which the value of calispell_temp is not NA.
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

## It’s common to create a new variable based on the value of one or more variables already in a dataset. 
## The mutate() function does exactly this.

## I like that the data are all in C. But what if we want to talk to a "I'm not a scientist" politician about water temperature?
## We might want to convert it to F.
mutate(wtemp, calispell_temp_F = calispell_temp*9/5 + 32)

## To make our data more usable, we also might want to summarize data across time, or by month and year.
## The lubridate package helps a lot with this! Here is just a taste, but if you deal with dates a lot check out the package.
## There is also a great swirl tutorial on how to use it, and feel free to ask us to help with your date strings as well.
## Let's load lubridate:
library(lubridate)

## TASK: Look at the lubridate help page. What do the functions with 'y' 'm' and 'd' (in various orders) do?  
?lubridate

## Try it out:
mdy("1/13/09")

## Once dates are saved as POSIXct date-time objects, we can extract information from them. Try it out.
## First, let's save the character string as a date-time object:
mydate<-mdy("1/13/09")

## Then extract the month and day:
month(mydate)
day(mydate)

##QUESTION: How would you extract the year from mydate?

## Let's use the mutate and mdy functions to create a variable called date2 that stores the date as a POSIXct date-time object.
mutate(wtemp, date2=mdy(date))

## Finally, we can use mutate to create several columns. For example, let's create date2, then create a column for month and year
mutate(wtemp, date2=mdy(date), month=month(date2), year=year(date2))

## Let's go ahead and save those changes in an object called wtemp2 object:
wtemp2<-mutate(wtemp, date2=mdy(date), month=month(date2), year=year(date2))


####################################
## 6) dplyr tool number 5: summarize
####################################

## Often we want to look at summarized as opposed to raw data. 
## At a basic level, summarize will condense all rows of a variable into one, summarized value.
## For example, let's look at the mean water temperature at Calispell
summarize(wtemp2, avg_temp_calispell= mean(calispell_temp, na.rm=TRUE))

## QUESTION: What did na.rm=TRUE?
## TASK: Can you use summarize to get the max value for the calispell_temp variable?
## QUESTION: Do you think this level of aggregation is very interesting?


###################################
## 6) dplyr tool number 6: group_by
###################################

## That last one was supposed to be a leading question. I don't think mean temperature is that insightful. 
## I'm more interested in how temperature changes with month or year.
## If we add the group_by function, summarize will give us the requested value FOR EACH GROUP.

## First, let's create a new dataframe table that is equal to to wtemp2 but includes two grouping variables: month and year
wtemp_by_monthyear<-group_by(wtemp2, month, year)
## QUESTION: Print wtemp and wtemp_by_month. Can you see how they differ?

## Use summarize again, but this time on wtemp_by_month.
summarize(wtemp_by_monthyear, avg_temp_calispell= mean(calispell_temp, na.rm=TRUE))

## Let's take this a step further, and look at the mean and standard error.
## First, run this code to store a function that calculate SE
calcSE<-function(x){
  x<-x[is.na(x)==F]
  sd(x)/sqrt(length(x))
}

## Then, let's summarize calispell both by mean and se and store it as a new dataframe:
wtemp_calispell_summary<- summarize(wtemp_by_monthyear, avg_temp_calispell= mean(calispell_temp, na.rm=TRUE),  
          se_temp_calispell= calcSE(calispell_temp))

## Notice how this gets our data into great shape for plotting. Just for fun, let's plot mean temp by month and include se
library(ggplot2)
ggplot(wtemp_calispell_summary, aes(x=month, y=avg_temp_calispell)) +geom_bar(stat="identity", fill="grey") + 
  geom_errorbar(aes(ymax=avg_temp_calispell+se_temp_calispell, ymin=avg_temp_calispell-se_temp_calispell), width=.1) + 
  theme_bw() + xlab("Month") + ylab("Mean temperature at Calispell Creek (degrees C)") + facet_wrap(~year) 


## One last note on group_by: If you group a dataframe table and then create a new variable with mutate, the value for that variable 
## will be repeated for each member of the group. For example:
mutate(wtemp_by_monthyear, avg_temp_calispell=mean(calispell_temp, na.rm=TRUE))

## QUESTION: Can you think of a scenario in which this is what would want to do?


#############################################
## 7) dplyr tool number 7: %>% (the pipeline)
#############################################

## It took us a lot of steps to get from the raw data to that graph!
## We had to: 
## 0) turn the dataframe into a dataframe table
## 1) select the date, time and Calispell temperature variable
## 2) filter out the missing values from the temperature variable
## 3) arrange by temperature (well, we didn't haaave to, but it was nice)
## 4) mutate a whole lot! we created the date2 column (a date-time object) and used it to create a month and a year column
## 5) group_by month and year
## 6) summarize temperature by mean and se
## 7) THEN graph

## This is a "workflow" - and dplyr has a handy tool to make this process clear and easy.
## It is called the "pipeline". Everytime a function is followed by the %>%,  it indicates that more work will be done on the object.
## To illustrate, here is the pipeline to create a graphical object stored as "Calispell_monthlytemp" from the initial wtemp dataframe 

Calispell_monthtemp <-wtemp %>%
  tbl_df()%>%
  select(date, time, calispell_temp) %>%
  filter(!is.na(calispell_temp)) %>%
  arrange(calispell_temp) %>%  
  mutate(date2=mdy(date), month=month(date2), year=year(date2)) %>%
  group_by(month, year) %>%
  summarize(avg_temp_calispell= mean(calispell_temp),  
            se_temp_calispell= calcSE(calispell_temp)) %>%
  ggplot(aes(x=month, y=avg_temp_calispell)) +geom_bar(stat="identity", fill="grey") + 
    geom_errorbar(aes(ymax=avg_temp_calispell+se_temp_calispell, ymin=avg_temp_calispell-se_temp_calispell), width=.1) + 
    theme_bw() + xlab("Month") + ylab("Mean temperature at Calispell Creek (degrees C)") + facet_wrap(~year) 

##  Nice!! Let's look at what we created:
Calispell_monthtemp

## QUESTION: Where is (are) the dataset specified in the pipeline?

## For the next module we will continue to work with this pipeline structure to get lots of practice with it!

