Task Eight
==========

    ############################################task 8 code ##############################################
    library(tidyverse)

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

    library(microbenchmark)

    ## Warning: package 'microbenchmark' was built under R version 3.3.3

    #Function to add values in columns
    column_adder <- function(data_frame, col.one, col.two, sum.col) {
      
      if(class(data_frame) != "data.frame") {
        warning("Data frame not supplied") #warning for if data_frame argument is not a data frame
      }
      
      if(!(col.one %in% colnames(data_frame)) | !(col.two %in% colnames(data_frame))) {
        warning("One of your columns in not in the supplied data frame") #warning for if either supplied columns to add are not actually columns in given data frame
      }
      
      tryCatch(data_frame$sum.col <- (data_frame[, col.one] + data_frame[, col.two]),  #runs function and returns warnings if column values are non-numeric
               warning=function(w){
                 message("One or more values to add is non-numeric.")
                 return(NA)
      })
      
      return(data_frame)
    }

    #Code lines to generate warnings and errors; using mtcars as an example

    my_mtcars <- mtcars #so I can edit this to my liking without changing mtcars itself
    my_mtcars <- column_adder(mtcars, "mpg", "cyl", sum) 
    my_mtcars$names <- rownames(my_mtcars)
    n_mtcars <- column_adder(my_mtcars, "mpg", "cyl", sum)
    #n_mtcars <- column_adder(my_mtcars, "names", "mpg", sum) ***throws an error as "names" has no numeric values
    new.vec <- c(1,3,5,7,9)
    #add.vec.columns <- column_adder(new.vec, "mpg", "cyl", sum) ***throws an error as a data frame is not supplied, and correct columns not present

    #adder using for loop
    adder <- function(my.vec) {
      sum <- 0
      for(i in my.vec) {
        sum <- sum + i
      }
      return(sum)
    }

    test.vec <- 1:10^4 #test value to test my function against built-in sum function
    adder(test.vec) #returns summed value using my function

    ## [1] 50005000

    sum(test.vec) #returns summed values using built in function

    ## [1] 50005000

    microbenchmark( #returns the differences between efficiency of my function and the built-in function
      adder(test.vec),
      sum(test.vec)
    )

    ## Unit: microseconds
    ##             expr      min      lq       mean   median        uq      max
    ##  adder(test.vec) 3237.003 3274.76 3585.68393 3331.209 3503.9530 5252.153
    ##    sum(test.vec)    6.419    6.42    7.50309    6.797    8.1185   13.216
    ##  neval
    ##    100
    ##    100
