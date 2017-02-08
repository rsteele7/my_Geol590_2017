#################Where to go for dinner decider#################

dinvar <- 0 #temporary variable to hold location and check/control values
locations <- c() #variable to hold the list of places to eat
##while loop and if loop that allow user to input places they could go to eat and
#appends user-inputted locations to "locations" vector

while (dinvar != 1) {
    dinvar <- readline("Enter dinner location option or 1 to exit. ")
    if (dinvar != 1) {
      locations <- c(locations,dinvar)
    }
}

decision <- sample(locations, 1) #samples one of the values randomly
print(c("You should eat at", decision), quote=FALSE) #gives the user its decision
