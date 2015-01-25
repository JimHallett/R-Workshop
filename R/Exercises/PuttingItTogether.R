#############################################################################################################
##                                                                                                         ##
## The last exercise!                                                                                      ##
##                                                                                                         ##
## Putting it all together: R for better monitoring and reporting.                                         ##
##                                                                                                         ##
#############################################################################################################

## We're going to spend most of our remaining time by applying what you've learned to a dataset supplied by 
## Jason Connor. The dataset includes fisheries data collected by electrofishing on tributaries of Priest River.
## Our objectives for this exercise are to (1) create a dataframe from an Excel file, (2) prepare 
## the dataframe for analysis and describe its structure, (3) plot length distributions for each
## species of fish, (4) plot weight against length and include the regression line, (5) create a location by
## species matrix using tidyr.

#############################################################################################################
##                                                                                                         ##
## Objective 1: Create a dataframe by importing data from an Excel file                                    ##
##                                                                                                         ##
## Pull "2013 PR Tributary Electrofishing Data.xlsx" from jimhallett.weebly.com                            ##
##                                                                                                         ##
## Use read.csv to pull the data from Sheet 1                                                              ##
##                                                                                                         ##
#############################################################################################################

## Are there cleanup steps before the data can be read in?

#############################################################################################################
##                                                                                                         ##
## Objective 2: Prepare the dataframe for analysis                                                         ##
##                                                                                                         ##
## Are all the variables labeled apropriately?                                                             ##
##                                                                                                         ##
## Are the data in the correct data types? How many integer variables are there?                           ##
##                                                                                                         ##
#############################################################################################################

#############################################################################################################
##                                                                                                         ##
## Objective 3: Plot length distributions for each species                                                 ##
##                                                                                                         ##
## Think especially about how you will subset the data by species.                                         ##
##                                                                                                         ##
#############################################################################################################

#############################################################################################################
##                                                                                                         ##
## Objective 4: Make a scatterplot of the relationship between length and weight for the most              ##
## common species. Then add the regression line.                                                           ##
##                                                                                                         ##
#############################################################################################################

#############################################################################################################
##                                                                                                         ##
## Objective 5: Species (cols) by location (rows) are commonly the basis for analysis of species           ##
## diversity. For this dataframe, locations are tributaries. Create a matrix of locations by species       ##
## where the elements are counts of each species at a location.                                            ##
##                                                                                                         ##
#############################################################################################################

#############################################################################################################
##                                                                                                         ##
## Wow. If you've made it this far, we hope that you have an initial understanding of the some of the      ##
## advantages that R might provide in working with your data. But, there is much more that R can now do    ##
## particularly in creating reports (RMarkdown), in developing interactive analysis and graphing (Shiny,   ##
## ggvis), and in providing other forms of analysis.                                                       ##
##                                                                                                         ##
#############################################################################################################
