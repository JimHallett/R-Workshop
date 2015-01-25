################################################################################
### R-WORKSHOP                                                               ###
### EXERCISE 2: Looking at data                                              ### 
################################################################################

## OBJECTIVE: In this exercise we will learn how to (1) create matrices and dataframes, 
## (2) read data in from external files, (3) use builtin functions to examine data objects, 
## (4) deal with missing values, and subset vectors, matrices, and dataframes.


################################################################################
### Objective 1: creating matrices and dataframes                            ### 
################################################################################


## Let's start with matrices. These are similar to vectors in that all of the 
## data must be of the same type (e.g., numbers), but matrices have 2 dimensions 
## (rows x columns). Matrices (e.g., for correlation and covariance coefficients)
## are common in statistics. And of course in population biology, where population 
## projection matrices are used.

## We'll first create a simple vector containing the number 1 through 24. 
## The colon : operator can be used to create a sequence.

firstvector <- 1:24

## TASK: view the vector that you just created.

## The dim() function gives us the dimensions of an object.
## QUESTION: What's the result of the dim(firstvector)?
## TASK: Try it!

## Oh, the vector apparently doesn't have a dimension. But we can use 
## length(firstvector) to determine it's length.

## QUESTION: What is the length of firstvector?
## TASK: Use the length() function.

## We now have the information we wanted. Now we'll see what happens when we 
## give a vector a dim attribute. 

## TASK: Type dim(firstvector) <- c(4,6)

## QUESTION: What are the dimensions of firstvector now? 
## TASK: View firstvector and use the dim() function.

## The function dim() clearly can find the dimension, but also set it!

## QUESTION: What is the class of firstvector now?
## TASK: Use the class() function to find out.

## Congratulations, you've changed a 24-element into a 4 row by 6 column matrix!
## QUESTION: Would it be useful to change the name of firstvector?
## TASK: Give it the name firstmatrix.

## We can also create a similar matrix as follows:
secondmatrix <- matrix(1:24, nrow=4, ncol=6)

## We can check to see if the matrices are the same using the identical() function.

identical(firstmatrix, secondmatrix)  #Did we succeed?

## Suppose that firstmatrix represents the happiness levels over time for some
## participants of the workshop. Each row represents a participant and each
## column represents happiness level taken at 6 times during the workshop.
## It would be useful to label the rows so that we know who the participants are.
## We'll add a column to the matrix to do this.

participants <- c("Chuck", "Dan", "Debbie", "Kendra")

## Now we'll use the cbind() function to combine participants and firstmatrix.

cbind(participants, firstmatrix)

## QUESTION: what things are different about this result?

## Remember that a matrix can only contain one type of data, and then what did you do?
## You added a character vector. And what did R do? Forced all of the numbers into 
## character values. 

## QUESTION: Is there a solution to this problem?
## TASK1: Type happydata <- data.frame(participants, firstmatrix)
## TASK2: View the contents of happydata.
## TASK3: Find the class and dimension of happydata.

## One last problem, the names of the columns are not descriptive. So we'll fix that.

## TASK4: Create a vector callend cnames containing "participant",time1", "time2", etc.

## TASK5: Use the colnames() function to set the column names attribute for our 
## data frame. This will be similar to our use of dim() to set the dimension of a vector.

## TASK6: View the final data frame.


















## We can enter the elements of a matrix from the keyboard. 

alpha <- matrix(c(1, 2, 3, 4), nrow = 2)

## QUESTION: How are the rows and columns of the matrix filled by this command? 
## TASK: Look at the matrix!

## There are several functions that can inform us about an object:
## class() can confirm whether alpha is a matrix or not. Try it.
## dim() tells us the numbers of rows and columns.




















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




