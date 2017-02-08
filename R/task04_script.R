##################### Task 04 Code ##########################

library(ggplot2)
print(nrow(diamonds)) #gives the number of rows in diamonds
set.seed(1410) #sets random number generator to a certain seed; ensures entire class will get the same result
dsmall <- diamonds[sample(nrow(diamonds), 100), ] #takes a 'random' sample of 100 of the rows in diamonds

#scatterplot of x vs y, colored by z and facetted by cut
print(ggplot(dsmall, aes(x = x, y = y, colour = z)) + 
        geom_point() + 
        facet_wrap(~cut)) 

#scatterplot of carat vs price, colored by cut and and with lm smooth lines without standard error bars
print(ggplot(dsmall, aes(x = carat, y = price, colour = cut)) + 
        geom_point() + 
        geom_smooth(se = FALSE, method = "lm"))

#density plot of carat, colored by clarity, and facetted by clarity
print(ggplot(dsmall, aes(carat, colour = clarity)) + 
        geom_density() + 
        facet_wrap(~clarity))

#boxplot of cut vs. price
print(ggplot(dsmall, aes(cut, price)) + 
        geom_boxplot())

#scatterplot of x vs y (red points) with a smooth line (thick blue dashes) and units included in axis labels
print(ggplot(dsmall, aes(x = x, y = y)) + 
        geom_point(colour = "red") + 
        geom_smooth(method = "loess", linetype = 2, colour = "blue") + 
        xlab("x, in mm") + 
        ylab("y, in mm"))

############################# ugly plots ##########################################
##Loading required packages##
packs <- c("png", "grid")
lapply(packs, require, character.only = TRUE)

##Loading picture with cigarettes##
img <- readPNG("data/smoking.png")
g <- rasterGrob(img, interpolate=TRUE)

##Loading external youth smoking survey##
df <- read.csv("data/Youth_Tobacco_Survey__YTS__Data.csv")
df_ugly <- df[sample(nrow(df), 100), ]

##Plot of smoking data##
print(ggplot(df_ugly, aes(x = Data_Value, y = Data_Value_Std_Err, colour = Gender)) + 
        xlab("Standard Error") + 
        ylab("Percent") + 
        ggtitle("Youth Smokers") +
        annotation_custom(g, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf) + 
        scale_x_continuous(expand=c(0,0)) + 
        scale_y_log10(expand=c(0,0)) + 
        geom_point() + 
        geom_smooth(se = FALSE, method = "loess", linetype = 2, colour = "white") +
        theme(
          axis.text = element_text(size=35, colour = "magenta"),
          legend.key = element_rect(fill= "orange"),
          legend.background = element_rect(fill = "green"),
          title = element_text(size=14, colour = "navy"),
          axis.title = element_text(size = 16, colour = "orange"),
          legend.text = element_text(colour = "green"),
          legend.title = element_text(color = "brown")
          ))