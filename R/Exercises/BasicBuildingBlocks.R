################################################################################
### R-WORKSHOP                                                               ###
### EXERCISE 1: Basic building blocks                                        ### 
################################################################################

## OBJECTIVE:
## To explore the basic building blocks of the R programming language.
## We will practice the concepts of 'function' and 'argument', 
## and learn some basic functions in R. 


########################################################################
## 1) In it's simplest form, R can be used as an interactive calculator. 
########################################################################

## Type this in the console; note the use of the operator '+' 
2 + 3

## TASK: Use the other basic algebraic operators: '-', '*', '/' and '^' to 
## substract, multiply, etc. the values 2 and 3.
 
## Like any good interactive calculator, 
## R follows the standard mathematical order of operations. 

## Type:
3+2/8

#Now type:
(3+2)/8

## QUESTION: Why are the results different?

## TASK: What is the result of: multiplying 5 by 11, then dividing that value by 3, 
## adding 6 to it, and rising that result to 2? Write this operation as a 
## single line of code.


######################################################
## 2) Functions can replace basic algebraic operators.
######################################################

## Type this into the console:
sum(2, 3)

## QUESTION: What is 'sum'? 

#Now type:
Sum(2, 3)

# The above command should give you an error. This is because R distinguishes 
# lower case from UPPER case. The function 'sum' is not the same 
# as 'Sum', and in this case 'Sum' does not exist.


################################################
##3) Results can be stored and reused as objects.
################################################

## We've summed 2 and 3 a lot! This time let's just save the results for future use.
## Type:
x <- sum(2,3)

## This can be read as "x gets 2 plus 3". Notice that R did not print the result 5 this time.
## To view the contents of the variable x, jut type x and press Enter:

x

## Now store the results of x/8 in a new variable y:

y<- x/8

##QUESTION: What is the value of y?


######################################################
##4) A collection of values can be stored as a vector.
######################################################

## The easiest way to create a vector is with the c() function, 
## which stands for 'concatenate' or 'combine'. 
## Let's store a vector of 1.1, 9 and 3.14 in a variable called z:
z<- c(1.1, 9, 3.14)

## Type z to view its contents:
z

## QUESTION: What do you notice about z?
## TASK: How long is z? Use the function 'length' to confirm the length of this vector.




c("Inga", "punctata")
# Concatenates the characters "Inga" and "punctata" forming a vector of length 2.

## TASK: Use the function length to confirm the length of this vector

paste("Inga", "punctata")
# Pastes the characters "Inga" and "punctata" to form a single character string 
# (length = 1) by joining them.

## TASK: Use the function length to confirm the length of this vector

## TASK: Use the function 'paste' to join together the genus and species of your 
## favorite species. Then, use the function 'paste; to paste together, in this 
## order, the species and genus and family of your favorite species. 


?paste
# Opens the help for the function 'paste'.

## TASK: Using the help for this function, identify what is the role of the 
## argument 'sep'.
## TASK: Does this argument have a predetermined value? What is that value?
## TASK: Use 'paste' to join together the genus and species names of your 
## favorite species using the character '_' to separate the two words.


?rep
# Opens the help for the function rep.

## TAKS: Read the help for this function, and identify its main arguments.
## TASK: Run lines 1 to 9 of the examples in the help page. What is this 
## piece of code doing?


rep(x=c("Pouroma", "minor"), times=7)
rep(x=c("Pouroma", "minor"), each=7)
# Uses the function rep to repeat the information in the argument x. 

## TASK: How and why are the results of the two lines above different?
## TASK: Create a vector that contains “R is awesome!” 1000 times. If you want, 
## use the function 'rep' to help you complete this task quickly.
## TASK: Rewrite the code above in 3 different ways: 
##  1. using the names of the arguments in their predetermined order 
##  2. excluding the names of the arguments 
##  3. changing the order of the arguments 

## TASK: What is (are) the problem(s) with the following line of code? Read the 
## error and correct the code. 
Rep(cSocratea exorrhiza), Times=7)


rnorm(n=50)
# Generates a vector that contains 50 random values from a normal distribution.


rnorm(50)
# Also generates a vector that contain 50 random values from a normal distribution. 

## TASK: According to the help of the function 'rnorm': 
##  1. What other arguments belong to this function?
##  2. What are the predetermined values for these additional arguments?
## TASK: Generate a vector of length 25 with random values from a normal 
## distribution with mean 50 and standard deviation 20. 


plot(x=rnorm(50), y=rnorm(50))
# The function plot is used to make many types of figures. In this case, it is 
# used to make  a scatterplot. In the figure, two random variables are plotted 
# against each other. 


A <- rnorm(n=1000, mean=0, sd=1)
B <- rnorm(1000, sd=25, mean=100)
# This creates two vectors with random values taken from a normal distribution 
# and saves then in two objects named A and B. Note the order in the arguments 
# between the two calls to the function rnorm. 


hist(A, col="lightblue")
# Creates a histogram of values in the vector A. 

## TASK: Using the help in R, create a histogram of the values in vector B where 
##  1. data is presented in 30 bars,
##  2. bars are red, and 
##  3. the X axis has the name 'Values of random vector B'. 


## TASK: Before running the following code, can you predict how the output of 
## the next three commands will be different?
plot(A,  B)
plot(y=A,  x=B)
plot(x=B, y=A)

A <- 1:20 
# Re-rewrites object A, not with the sequence: 1, 2, 3,..., 20.

## TASK: Create another object of name 'a' with the same sequence, but use the 
## function 'seq'.

## TASK: Create a figure where you relate the values of 'A' with the values of 
## vector 'a' – meaning create a scatterplot. 

## TASK: Use the function 'lines' to create line of 1:1 correspondence on top of 
## the scatterplot (origin at 0,0 coordenates and end at 20,20 coords). To 
## create this line, the function will need the X and Y coordinates for a point 
## of departure and a point of arrival. 


## TASK: Can you read and understand the code that follows?
pred <- rnorm(250, 40, 10)
resp <- 15 + 1.55*pred + rnorm(250, sd=5, mean=0)
plot(pred, resp, cex=2, pch=21, col= "grey60", bg="gold")

## TASK: Make a figure similar to the one above, but change (1) the size of the 
## symbols, (2) the type of symbol, and (3) the color of the symbol. 

## TASK: If you calculated the average and standard deviation of the values in 
## vector pred, what would you expect? Calculate them using the functions mean 
## and sd and confirm/revise your expectations. 


lm(resp ~ pred)
## The function lm creates linear models. In this case, 'lm' is making a linear 
## OLS regression where  resp is a function of the variable pred. The symbol '~' 
## generally means "is a function of" and is used in formulas. 


summary(object=lm(resp ~ pred))
# The function 'summary' creates, obviously, a summary of the information 
# contained in its 'object' argument. In this case, it provides information for 
# the linear regression between resp and pred. 

## TASK: Make a summary of a vector of 300 random values taken from a normal 
## distribution with a mean of -13 and a standard deviation of 5. 





