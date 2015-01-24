################################################################################
### R-WORKSHOP                                                               ###
### EXERCISE 6: Tidying Data                                                 ### 
################################################################################

## OBJECTIVES:
## To learn what tidy data means.
## To learn how to tidy data in a way that is traceable and reproducible.
## To this end we'll be using the tidyr and dplyr packages.

## The author of tidyr, Hadley Wickham, discusses the philosophy of tidy data
## in his Tidy Data paper: http://vita.had.co.nz/papers/tidy-data.pdf
## It is really worth a read! 

## What are tidy data?
## Tidy data are data that are easy to transform and visualize. 
## The key idea is that variables are stored in a consistent way.
    ## Each variable forms a column
    ## Each observation forms a row
    ## Each type of observational unit forms a table

## There are five common problems associated with messy data:
    ## 1) Column headers are values, not variable names
    ## 2) Multiple variables are stored in one column
    ## 3) Variables are stored in both rows and columns
    ## 4) Multiple types of observational units are stored in the same table
    ## 5) A single observational unit is stored in multiple tables

## Load the tidyr and dplyr libraries
library(tidyr)
library(dplyr)

#######################################
##1) Problem: Column headers are values
## tidyr solution: gather
#######################################

## We've already seen this problem before! 
## We ignored it for the moment, but now is a good time to fix it.
## Remember the Calispell water temperature data? Let's look at it again. 
## If it isn't still in your workspace, load it this way:
wtemp<-tbl_df(read.csv("Calispell Creek and Tributary Temperatures2.csv", stringsAsFactors=F))
wtemp


## QUESTION: What is messy about this data?

## To fix it, we'll use the gather function. 
## Pull up the gather help documentation.
?gather

## Note that the gather() call takes the following arguments, in order
## The dataframe
## The name of the key column to create in the output
## The name of the value column to create in the output
## The columns to gather

gather(wtemp, site, temperature, calispell_temp:winchester_temp)

## QUESTION: What are the dataframe, key and value names and gathered columns in the above call?

## QUESTION: Even though I would say that having values stored as column headers is messy,
## at times it is extremely useful! Can you name a scenario in which you would want to convert 
## tidy data to this "wider" format?

## Fortunately, tidyr includes a function to make it easy for us to 

## (unique observations )

#########################################################
##2) Problem: Multiple variables are stored in one column
## tidyr solution: separate
#########################################################

## Let's revisit the Lower Spokane fish data
## I've added a some - but not all ;) - of the messiness for pedagogical purposes
## Let's have a look:

dat<-tbl_df(read.csv("LowSpokaneClean.csv")) %>%
  mutate(FishLength_Weight=paste(FinLength, Weight, sep="_")) %>%
  select(Date, Year, Pass, Site.No., FishNo, Species, FishLength_Weight, ScaleAge, CapturedFloyTagNo, AppliedFloyTagNo,
         CapturedPITTagNo, ActivePITTagNo, AgeMethod)

fishcatch<-dat
fishcatch %>%
  separate(FishLength_Weight, c("Length", "Width"))


## TASK: Let's revisit the 'gathered' wtemp dataframe table. 
## It would be nice  to remove the "_temp" from each of the site names
## Do this by adding to the pipeline I've started below. 
## First seperate site into new "site" and "measurement" columns,
## then remove the unnecessary "measurement" column (hint: select is helpful here)

wtemp%>%
  gather(site, temperature, calispell_temp:winchester_temp) 

  # %>%
  # separate(site, c("site", "measurement")) %>%
  # select(-measurement)


############################################################
## 3) Problem: Variables are stored in both rows and columns
## tidyr solution: gather then filter 
############################################################

## Look again at the fishcatch dataframe table
fishcatch

## QUESTION: What information is implicit based on a row/column combination?

#The headers of CapturedFloyTagNo and AppliedFloyTagNo are all different values of what should be a "TagType" Variable

## Let's verify that this is the case:
fishcatch %>%
  filter(!is.na(CapturedFloyTagNo), !is.na(AppliedFloyTagNo))


## Let's continue to fishcatch pipeline to clean this up
## We can do it with the gather function, adding an argument to remove NAs
fishcatch %>%
  separate(FishLength_Weight, c("Length", "Width")) %>%
  gather(TagType, TagName, CapturedFloyTagNo, AppliedFloyTagNo, na.rm=TRUE) 


###############################################################################
##4) Problem: Multiple types of observational units are stored in the same table
## tidyr solution: create two "linked" dataframes by selecting relevant columns; 
## reduce those to unique observations
################################################################################


## USE THE BSC EFFORT DATA
fishcatch %>%
  select(ActivePITTagNo)%>%
  unique()




## Site information vs sampling information
student_info <- students4 %>%
  select(id, name, sex) %>%
  unique %>%
  print

## Related problem: leaving blanks, relying on data to be sorted correctly



#################################################################################
##5) Problem: A single observational unit is stored in multiple tables
## tidyr solution: 
################################################################################

## The fifth common messy data scenario is when a single observational unit is stored in multiple tables.
## It’s the opposite of the fourth problem.

## passed and failed example
## actually is a variable called status







