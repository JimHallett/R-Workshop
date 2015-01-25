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
## tidyr solution: gather and spread
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

wtemp_gathered<-gather(wtemp, site, temperature, calispell_temp:winchester_temp)
wtemp_gathered

## QUESTION: What are the dataframe, key and value names and gathered columns in the above call?

## QUESTION: Even though I would say that having values stored as column headers is messy,
## at times it is extremely useful! Name a scenario in which you would want to convert 
## tidy data to this "wider" format.

## Fortunately, tidyr includes a function to make it easy for us to spread data back out
## From the help, we just specify the dataframe, key and value
?spread

## Try it, this time using the pipeline syntax:
wtemp_gathered %>% 
  spread( site, temperature, fill=NA)

## This is also helpful whenever a single observation is recorded in multiple rows.
## A tip-off that this might be the case is when one column has a name like "variable" and another "value"


#########################################################
##2) Problem: Multiple variables are stored in one column
## tidyr solution: separate
#########################################################

## Let's revisit the Lower Spokane fish data
## I've added a some - but not all ;) - of the messiness for pedagogical purposes
## Let's read it in and convert it to a dataframe table:
fishcatch<-dat %>%
  tbl_df()

## Now have a look. Which column stores multiple variables?
fishcatch

## The separate command helps us do that.
## The separate command is smart and looks for a pattern to separate on
## This is great! But we could specify if we wanted it,
## as always look at the documentation for syntax: ?separate
fishcatch %>%
  separate(FishLength_Weight, c("Length", "Width"))

## TASK: Let's revisit the gathered wtemp dataframe table. 
## It would be nice  to remove the "_temp" from each of the site names
## Do this by adding to that pipeline (copied below)
## First separate site into new "site" and "measurement" columns,
## then remove the unnecessary "measurement" column (hint: select is helpful here)

wtemp_gathered <- wtemp %>%
  gather(site, temperature, calispell_temp:winchester_temp) 


############################################################
## 3) Problem: Variables are stored in both rows and columns
## tidyr solution: gather then filter 
############################################################

## Look again at the fishcatch dataframe table
fishcatch

## QUESTION: What information is implicit based on a row/column combination?

## The headers "CapturedFloyTagNo" and "AppliedFloyTagNo" are all different values of 
## what should be a "TagType" variable

## Let's continue to fishcatch pipeline to clean this up
## We can do it with the gather function, adding an argument to remove NAs
fishcatch %>%
  separate(FishLength_Weight, c("Length", "Width")) %>%
  gather(TagType, TagName, CapturedFloyTagNo, AppliedFloyTagNo, na.rm=TRUE) 

## And really what this variable tells us is: has this fish been tagged before?
## We might prefer to store this information in a binary newCapture column 
fishcatch %>%
  separate(FishLength_Weight, c("Length", "Width")) %>%
  gather(TagType, TagName, CapturedFloyTagNo, AppliedFloyTagNo, na.rm=TRUE) %>%
  ## NEW CODE:
  #create the newCapture column
  mutate(newCapture=1, newCapture=ifelse(TagType=="CapturedFloyTagNo", 0, newCapture)) %>%
  #remove the redundant TagType column
  select(-TagType)


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







