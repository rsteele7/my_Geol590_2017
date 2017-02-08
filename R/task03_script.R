##############Task 3 code###################

###Question: Explore vectorization. Explain the differences and the similarities between the following code snippets. 
#What data structure are a, b, and c?
#Code snippet 1
a <- 1
b <- 2
c <- a + b

#Code snippet 2
set.seed(0) #random results same for everyone
d <- rnorm(20)
e <- rnorm(20)
f <- d + e

###Answer: The code snippets each assign double (numeric) atomic vectors to the variables a, b, and c (code snippet 1) 
#and d, e, f (code snippet 2). Variables a, b, d, and e each have specific values assigned where the values assigned 
#to a and b are specifically chosen and the values assigned to d and e are randomly chosen by the computer using a 
#seed. Variables c and f are similar in that instead of having a specific value assigned to them, their values are the 
#sum of a and b (code snippet 1) and the sum of d and e (code snippet 2). Therefore, these variables are dependent upon 
#the values of the other variables within their respective code snippets.

###Question: Name three wasy you could use attributes to make data analysis code more reproducible (i.e., easier for
#yourself and others to understand).

###Answer: Use them to denote categories, units, attach other useful data to the object

###Question: Create a vector of length 5 and use the attr function to associate two different attributes to the vector
nums <- c(1:5) #vector of length 5
attr(nums, "Name") <- "Stephen" #attribute 1
attr(nums, "Favorite Superhero") <- "Iron man" #attribute 2
print (nums)
print (attributes(nums))

###Question: What happens to a factor when you modify its levels?
###Answer: The order that a factor is saved in changes to match the order the levels are in.
## In the case below: f1 <- factor(letters) assigns the alphabet, in order, to the factor f1
## levels(f1) <- rev(levels(f1) reverses the order of the levels, changing it from alphabetical order to reverse alphabetical order.

f1 <- factor(letters) #assigns the alphabet, in order, to the factor f1
print ("f1"); print(f1)
levels(f1) <- rev(levels(f1)) #assigns the alphabet in reverse order to the levels in f1
print ("f1"); print (f1)
###Question: What does this code do? How do f2 and f3 differ from f1?
f2 <- rev(factor(letters)) #assigns the alphabet in reverse order to the factor f2
print ("f2"); print (f2)
f3 <- factor(letters, levels = rev(letters)) #assigns the alphabet, in order, to the factor f3, and assigns the alphabet in reverse order to f3's levels
print ("f3"); print(f3)
###Answer: f2 <-  rev(factor(letters)) assigns the alphabet in reverse order to the factor f2, but its levels remain in alphabetical order
#f3 <- factor(letters, levels = rev(letters)) assigns the alphabet in order to the factor f3 and assigns the alphabet in reverse orders to its levels

###Question: What does dim return when applied to a vector and why?
###Answer: Null, because in R vectors don't have dimensions

###Question: What attributes does a data frame possess?
###Answer: Names (equivalent to column names), row.names (row names), class (object type)

###Question: What does as.matrix() do when applied to a data frame with columns of different types?
###Answer: It turns the data frame into a character matrix

###Question: Can you have a data frame with 0 rows? What about 0 columns?
edf <- data.frame()
print(df)
###Answer: Yes to both.

###Question: Use read.csv() to read the file 2016_10_11_plate_reader.csv in the github data directory, and store it in memory as an object. 
#This is an output from an instrument that I have, that measures fluorescence in each well of a 96-well plate. (Hint: use the optional 
#argument skip = 33. What effect does that have?)
plateread <- read.csv(file ="UTK/SteenR/data/2016_10_11_plate_reader.csv")
plateread33 <- read.csv(file="UTK/SteenR/data/2016_10_11_plate_reader.csv", skip=33) #skip allows you to skip a specified number of rows

###Question: What kind of object did you create? What data type is each column of that object (str())?
###Answer: This created a data frame. The first column held factors, the second held numbers, the third held integers.

###Question: load tidyverse
library(tidyverse)

###Question: read the same file using the read_csv function. How is the resulting object different?
plateread_td <- read_csv(file ="UTK/SteenR/data/2016_10_11_plate_reader.csv")
plateread33_td <- read_csv(file="UTK/SteenR/data/2016_10_11_plate_reader.csv", skip=33) #skip allows you to skip a specified number of rows
###Answer: the column names were not changed, all blank locations in the file were filled in with NA instead of being blank, and several classes 
#of the object were made (tbl_df, tbl, and data.frame)

###Question: Why does nrow(mtcars) give a different result than length(mtcars)? What does ncol(mtcars) return? What is each telling you, and why?
###Answer: nrow(mtcars) gives 32 while length(mtcars) gives 11 (same as ncol(mtcars)) because nrow() gives the number of rows in the data frame 
#and length and ncol give the number of columns in the data frame.

###Question: Create a vector that is the cyl column of mtcars in two different ways:
cyl.vec <- mtcars$cyl
str(cyl.vec)
cyl.vec2 <- mtcars[[2]]
str(cyl.vec2)

###Question: Create a data frame that contains all the columns of mtcars, but only with cars that weigh less than 3.0 OR more than 4.0 (weight is in the wt column)
mpg_sep <- mtcars[mtcars$wt < 3.0 | mtcars$wt > 4.0, ]

###Question: Create a data frame that contains all the rows of mtcars, but only the mpg and wt
mpg_wt <- mtcars[, c(1,6)]

###Question: Which cars in the database get gas mileage (mpg) equal to the median gas mileage for the set? (Use median and which).s
cars_med_mpg <- mtcars[c(which(mtcars$mpg == median(mtcars$mpg))), ] #Merc 280 and Pontiac Firebird
print(cars_med_mpg)

###Question: Fix the following subsetting errors. 
#mtcars[mtcars$cyl = 4, ] # Incorrect version
print(mtcars[mtcars$cyl == 4, ]) #Corrected version
#mtcars[-1:4, ] #Incorrect version
print(mtcars[1:4, ]) #correct version
#mtcars[mtcars$cyl <= 5] #Incorrect version
print(mtcars[mtcars$cyl <= 5, ]) #Correct version
#mtcars[mtcars$cyl == 4 | 6, ] #Incorrect version
print(mtcars[mtcars$cyl == 4 | mtcars$cyl == 6, ]) #Correct version
