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

## What is tidy data?
## Tidy data are data that are easy to transform and visualize. 
## The key idea is that variables are stored in a consistent way.
    ## Each variable forms a column
    ## Each observation forms a row
    ## Each type of observational unit forms a table

## There are five common problems associated with messy data:
    ## Column headers are values, not variable names
    ## Multiple variables are stored in one column
    ## Variables are stored in both rows and columns
    ## Multiple types of observational units are stored in the same table
    ## A single observational unit is stored in multiple tables

## Load the tidyr and dplyr libraries
library(tidyr)
library(dplyr)

#######################################
##1) Problem: Column headers are values
## tidyr solution: gather
#######################################

## We've already seen this problem before! 
## We ignored it for the moment, but now is a good time to fix it.
## Remember the Calispell water temperature data? Let's look at it again:
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

## QUESTION: What is the dataframe, key and value names and gathered columns in the above call?

#########################################################
##1) Problem: Multiple variables are stored on one column
## tidyr solution: separate
#########################################################


