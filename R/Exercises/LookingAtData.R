################################################################################
### R-WORKSHOP                                                               ###
### MODULE 2: Looking at data                                                ### 
################################################################################

## OBJECTIVE: In this exercise we will learn how to (1) create matrices and dataframes in R, 
## (2) read data in from external files, (3) use built-in functions to examine data objects, 
## (4) deal with missing values, and (5) subset vectors, matrices, and dataframes.


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

## Oops! dim() only retrieves the dimensions of a matrix, array or dataframe. 
## But we can use length() to determine a vector's length.
## TASK: Use length() to find the legnth of firstvector.

## Take a look at the dim help file
?dim 

## According to ?dim, the dim() function can be used to both retrieve or SET the dimensions of an object.
## Let's use it to set the dimensions of firstvector.
dim(firstvector) <- c(4,6)

## QUESTION: What are the dimensions of firstvector now? Use dim() to find out
## QUESTION: What is the class of firstvector now? Use the class() function to find out.

## Congratulations, you've changed a 24-element into a 4 row by 6 column matrix!
## To reflect this change, let's assign our new matrix to an object called "firstmatrix"
firstmatrix<-firstvector

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
# cbind indicates "column bind" - it to binds columns together. rbind is the corresponding function for rows.
cbind(participants, firstmatrix)

## QUESTION: what attributes of the matrix change when we do this?

## Remember that a matrix can only contain one type of data! 
## We added a character vector to a numeric matrix!
## And what did R do in response? Forced all of the numbers into character values. 

## QUESTION: What data structure allows columns with different data types?

## Let's create a dataframe called "happydata" by binding participants and first matrix
happydata <- data.frame(participants, firstmatrix)

## TASK: View the contents of happydata.
## TASK: Find the class and dimension of happydata.

## One last problem, the names of the columns are not descriptive. So we'll fix that.
## TASK: Create a vector called cnames containing "participant", "time1", "time2", "time3", "time4", "time5", "time6"
## Hint: you could copy those names from above. Don't forget to concatenate using c()!

## TASK: Use the names() function to set the column names attribute for our 
## data frame. This will be similar to our use of dim() to set the dimension of a vector.

## TASK: View the final data frame.


################################################################################
### Objective 2: Reading data from external files                            ### 
################################################################################

## R is quite versatile in pulling data in from various file types and databases. 
## We won't have time to consider all of the possibilities and will use very 
## straightforward comma separated values or .csv files. We recognize that most
## participants use Excel and although it is possible to pull data directly from 
## Excel, there are a number of gotchas (e.g., extraneous formulas, graphics, etc.)
## that can create problems. 
## If you're transitioning from storing data in Excel to .csv files and want some help
## feel free to talk to us at break or shoot us an email!

##SETTING THE WORKING DIRECTORY
## Our first step is to specify the file path that leads to our data.
## This is called our "working directory"
## Let's check what are current working directory is:
getwd()

## We can view all the files in our working directory:
dir()

## We will be using a file called "whoshere.csv"
## It is in the Data folder of the zipped R-Workshop folder
## To set your working directory, click on the "Session" tab in RStudio
## Then Click on "Set working directory" -> "Choose directory" 
## and navigate to the "Data" folder in your saved R-Workshop folder

## Once you've done that, look down at your R Console; it will have printed setwd(YOURFILEPATH)
## You can copy that and set use it to set your working directory within the console in future.
## Double check that your working directory is set to Data
getwd()

## And that it contains the whoshere.csv file
dir()

## The good/bad news is that this step is often the one that trips people up the most! 
## Lauren's first year of programming was filled with perpetually forgetting to set her working directory and 
## calling her dad in tears wondering where her files were... 


## READING DATA INTO R
## Once we've set our working directory, let's read in our first .csv file.
wshpfolks <- read.csv(file="whoshere.csv", header=TRUE, sep=",")

## TASK: Find the class and dimensions of this dataset.

## You can use the View() function to look at wshpfolks Try it!
## You can also view the dataset by clicking on "Environment" in the upper right panel, 
## then clicking on the name of the object (in this case: wshpfolks)

## You can also use the names() function to look at the variable names:
names(wshpfolks)

## You can isolate individual columns using datframe$columnname, for example:
wshpfolks$Participant

## TASK: Do this for the Organization variable. How many levels are there?


################################################################################
### Objective 3: Use built-in functions to examine data objects              ### 
################################################################################

## We're going to read in a dataset that we'll be using from time to time.
SpokaneFish <- read.csv("LowerSpokaneFish.csv")

## R has a number of useful functions to help keep track of data structures in the current
## working session. We can list all the objects with ls().
ls()

## We may have to check the class of an object, using class().
class(SpokaneFish)

## For several types of objects we may need to know the dimensions, type dim(). This will always
## give rows and then columns.
dim(SpokaneFish)

## Or we may need just the number of columns given by ncol().
ncol(SpokaneFish)


## What if you can't remember all the variable names for a dataset. Easy type names() with the 
## name of the object.

## TASK: Run the names command for the SpokaneFish dataset

## QUESTION: What happens when we do this for a matrix?
## TASK: Try the names() function on firstmatrix.

## Sometimes we need to just get a quick look at the columns of a dataframe. We can use summary().
summary(SpokaneFish)

## Frequently we need to know the data type for the columns in a dataframe. We'll do this for the 
## SpokaneFish dataframe.
str(SpokaneFish)

## Note the date, integer, numeric and factor datatypes. R will generally interpret these 
## correctly


################################################################################
### Objective 4: Missing data                                                ### 
################################################################################

## R represents missing values in 2 ways: if the data are not available
## (e.g., technician falls out of the boat before weighing a fish), then it is
## denoted NA. Sometimes a calculation will result in an impossible value, such
## as dividing by zero. R uses NaN (not a number) for these situations. 

## We can check for missing values with the is.na() function.
## QUESTION: Are there missing values in the SpokaneFish data for weight?
## TASK: Use the is.na() function to check.

## Depending on the operation, R will delete records where data are missing. 
## For example, if we are looking at the relationship between length and weight, 
## any records missing either length or weight would not be used.

## If you use a placeholder for a missing value, it will have to be recoded to NA.
## This can be done in R, but we will leave it for later.



################################################################################
### Objective 5: Subsetting vectors, matrices, and dataframes                ### 
################################################################################

## We've already given you a clue about how to subset a dataframe by isolating 
## individual variables (dataframe$variable).
## The SpokaneFish dataset has 16 variables, but we may only need to be concerned with
## a few of those. We'll pull out Species, Finlength, and Weight.
SpokaneFishSubset <- subset(SpokaneFish, select = c("Species", "FinLength", "Weight"))

## TASK: Dang, I wanted to keep the ScaleAge variable. Perform the subset function again, this time including ScaleAge.

## Of course, similar methods exist for vectors and matrices. But we have to be
## clear about the column or row numbers involved. 

## Remember firstmatrix? Imagine we we want to remove column 6 and row 4. 
## Print firstmatrix. Notice the row and column numbers. 
## In R, the syntax is always [row, column]
## The following therefore removes row 4, then removes column 6
firstmatrixReduced <- firstmatrix[-4,]
firstmatrixReduced2 <- firstmatrixReduced[,-6]



################################################################################
### Bonus: creating a population projection matrix!                          ### 
################################################################################

## For folks that might work with age or stage structured populations, R can be used to 
## analyse population projection matrices. Projection matrices have fecundity in the first row, 
## probability of transition to the next stage in the other rows.
popproj <- matrix(c(0, 0.74, 0, 0, 0, 0.92, 0.27, 0, 0.92), ncol=3, nrow=3)
popproj    

## For fun let's enter a vector of population numbers in 3 stage classes.
popvector <- matrix(c(30, 100, 70), ncol=1) #Starting population vector with a dimension.
popvector

## We can now calculate population numbers at the next time period.
nextgen <- popproj %*% popvector      #Note that we use matrix multiplication notation %.%
nextgen

## We could continue to project the population out this way, and R, like other languages,
## allows us to automate the process.

## From population biology, the first eigenvalue is the population growth rate when the stable
## age or stage distribution is reached. The latter is given by the first eigenvector. Both are 
## easily calculated from the population projection matrix:
eigen(popproj)


