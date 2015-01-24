################################################################################
### R-WORKSHOP                                                               ###
### EXERCISE 2: Looking at data                                              ### 
################################################################################

## OBJECTIVE: To learn how to create matrices and dataframes, read data in from external files,
## use several functions to examine data objects, deal with missing values, and subset vectors,
## matrices, and dataframes.

## Let's start with matrices. These are similar to vectors in that all of the data must be in the
## same format, but matrices have 2 dimensions (rows x columns). Correlation or covariance matrices
## are common in statistics. And of course in population biology, where population projection
## matrices are often used.

## We can enter the elements of a matrix from the keyboard. 

popproj <- matrix(c(0, 0.74, 0, 0, 0, 0.92, 0.27, 0, 0.92), ncol=3, nrow=3)

popproj    #This is a projection matrix, fecundity in the first row, probability of moving or surviving
           # to the next stage.

## So for fun let's enter a vector of population numbers in 3 stage classes.

popvector <- matrix(c(30, 100, 70), ncol=1)       #Starting population vector
popvector

## We can now calculate population numbers at the next time period.

nextgen <- popproj %*% popvector   
nextgen

## We could continue to project the population out this way, and R, like other languages,
## allows us to automate the process.

## From population biology, the first eigenvalue is the population growth rate when the stable
## age or stage distribution is reached. The latter is given by the first eigenvector. Both are 
## easily calculated from the population projection matrix:

eigen(popproj)

eigen(popproj)



###############################################################################################

## R has a number of useful functions to help keep track of data structures in the current
## working session. We can list all the objects with ls().

ls()

## We may have to check the class of an object, using class().

class(Redband)

class(popprojection)

class(Species.freq)

class(aovout)

## For several types of objects we may need to know the dimensions, type dim(). This will always
## give rows and then columns.

dim(popprojection)

dim(Redband)

## Or we may need just the number of columns given by ncol().

ncol(Redband)

ncol(popvector)

## What if you can't remember all the variable names for a dataset. Easy type names() with the 
## name of the object.

names(Redband)

names(popprojection)      #This is a matrix!

## Sometimes we need to just get a quick look at the columns of a dataframe. We can use summary().

summary(Redband)

summary(popprojection)    #Note that is does the summary for each vector or column of the matrix.

## 

## Frequently we need to know the data type for the columns in a dataframe. We'll do this for the 
## Redband dataframe.

str(Redband)

## Note the date, integer, numeric and factor datatypes. R will generally interpret these 
## correctly




