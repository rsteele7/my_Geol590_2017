NYC Flights Code
================

    #---------------------------------#
    ######task 7 nycflights code#######
    #---------------------------------#
    #loading appropriate libraries
    library(nycflights13)
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

    #-------------Prepare weather data for placement in tables, graph---------------#
    #-------------------------------------------------------------------------------#
    #plot wind speed to visualise outliers
    nycflights13::weather %>%
      ggplot(aes(hour, wind_speed)) +
        geom_point()

    ## Warning: Removed 3 rows containing missing values (geom_point).

![](task07_files/figure-markdown_strict/unnamed-chunk-1-1.png)

    #remove outlier > 1,000 units of wind speed and values in wind_dir = NA
    #summarise with median wind speed for each wind direction at each airport
    airport_wind <- nycflights13::weather %>%
      filter(wind_speed<1000, !is.na(wind_dir)) %>%
      group_by(wind_dir,origin) %>%
      summarise(med_wind_spd = median(wind_speed)) %>%
      .[order(.$origin), ]


    #Determine directions with highest median speeds at each airport
    print(top_n(group_by(airport_wind, origin), 1, med_wind_spd))

    ## Source: local data frame [10 x 3]
    ## Groups: origin [3]
    ## 
    ##    wind_dir origin med_wind_spd
    ##       <dbl>  <chr>        <dbl>
    ## 1       290    EWR     12.65858
    ## 2       300    EWR     12.65858
    ## 3       320    EWR     12.65858
    ## 4       330    EWR     12.65858
    ## 5       290    JFK     14.96014
    ## 6       300    JFK     14.96014
    ## 7       310    JFK     14.96014
    ## 8       330    JFK     14.96014
    ## 9       270    LGA     13.80936
    ## 10      290    LGA     13.80936

    #---------------------Put weather data in tables and graphs-----------------------#
    #---------------------------------------------------------------------------------#
    #create separate tables of median wind speed/direction for every airport
    airport_wind_tbls <- airport_wind %>%
      group_by(origin) %>%
      do(airport_wind=data.frame(.)) %>%
      select(airport_wind) %>%
      lapply(function(x) {(x)})
    ewr_wind <- airport_wind_tbls$airport_wind[[1]]
    jfk_wind <- airport_wind_tbls$airport_wind[[2]]
    lga_wind <- airport_wind_tbls$airport_wind[[3]]


    #make graphs of median wind speed/direction for every airport
    airport_wind %>%
      ggplot(aes(x=wind_dir, y=med_wind_spd)) +
        geom_point() +
        facet_wrap(~origin) +
        xlab("Wind Direction") +
        ylab("Wind Speed")

![](task07_files/figure-markdown_strict/unnamed-chunk-1-2.png)

    #---------------------------------------JFK distance data---------------------------------------------------#
    #-----------------------------------------------------------------------------------------------------------#
    #Make table with airline name and median distance flown from JFK; arrange in order of decreasing mean flight distance
    jfk_flight_distance <- nycflights13::flights %>%
      left_join(airlines) %>%
      filter(origin == "JFK") %>%
      group_by(name) %>%
      summarise(med_dist = median(distance), mean_dist = mean(distance)) %>%
      .[order(.$mean_dist), ] %>%
      print()

    ## Joining, by = "carrier"

    ## # A tibble: 10 × 3
    ##                        name med_dist mean_dist
    ##                       <chr>    <dbl>     <dbl>
    ## 1  ExpressJet Airlines Inc.      228  228.8303
    ## 2                 Envoy Air      425  401.4698
    ## 3         Endeavor Air Inc.      427  506.8903
    ## 4           JetBlue Airways     1028 1113.6737
    ## 5           US Airways Inc.      541 1127.4407
    ## 6    American Airlines Inc.     1598 1660.8528
    ## 7      Delta Air Lines Inc.     1990 1689.3074
    ## 8            Virgin America     2475 2495.1196
    ## 9     United Air Lines Inc.     2586 2535.5922
    ## 10   Hawaiian Airlines Inc.     4983 4983.0000

    #--------------------------------------EWR flight number data---------------------------------------------#
    #---------------------------------------------------------------------------------------------------------#
    #Make wide data frame displaying number of flights leaving Newark airport each month from each airline
    leave_ewr <- nycflights13::flights %>%
      filter(origin == "EWR") %>%
      group_by(carrier, month) %>%
      summarise(flight_num = n()) %>%
      spread(carrier, flight_num) %>%
      print()

    ## # A tibble: 12 × 13
    ##    month  `9E`    AA    AS    B6    DL    EV    MQ    OO    UA    US    VX
    ## *  <int> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
    ## 1      1    82   298    62   573   279  3838   212    NA  3657   363    NA
    ## 2      2    75   268    56   532   249  3480   196    NA  3433   328    NA
    ## 3      3    91   295    62   612   319  3996   228    NA  3913   372    NA
    ## 4      4    88   288    60   567   364  3870   220    NA  4025   361   170
    ## 5      5   103   297    62   517   377  4039   226    NA  3874   381   186
    ## 6      6    88   291    60   506   347  3661   218     2  3931   390   180
    ## 7      7    94   303    62   546   340  3747   228    NA  4046   402   181
    ## 8      8    96   302    62   544   355  3636   227    NA  4050   385   182
    ## 9      9    87   282    60   478   423  3425   214    NA  3573   341   161
    ## 10    10   146   292    62   501   440  3587   140    NA  3875   365   170
    ## 11    11   153   277    52   544   418  3392    94     4  3776   346   161
    ## 12    12   165   294    54   637   431  3268    73    NA  3934   371   175
    ## # ... with 1 more variables: WN <int>

Babynames Code
==============

    #--------------------------------#
    ######task 7 babynames code#######
    #--------------------------------#
    library(babynames)


    #-Collecting and plotting most common baby names in 2014 across the years-#
    #-------------------------------------------------------------------------#
    #collect 10 most common male and female baby names in 2014 
    common_2014 <- babynames::babynames %>%
      filter(year==2014) %>%
      group_by(sex) %>%
      top_n(10, prop)


    #select frequencies throughout the years of the given baby names, plot
    keys <- c("name", "sex")
    babynames::babynames %>%
      merge(., common_2014[keys], by=keys) %>% #selects all babies of correct sex and name
      ggplot(aes(x=year, y=prop)) +
        geom_col() +
        facet_wrap(~name)

![](task07_files/figure-markdown_strict/unnamed-chunk-2-1.png)

    #-------------------common girl data-------------------------#
    #------------------------------------------------------------#
    #26th - 29th most common girls in 1896, 1942, 2016
    common_girls <- babynames::babynames %>%
      filter(year==1896 | year==1942 | year==2016, sex=="F") %>%
      group_by(year) %>%
      top_n(29, prop)  %>%
      top_n(-4, prop) %>%
      print()

    ## Source: local data frame [8 x 5]
    ## Groups: year [2]
    ## 
    ##    year   sex    name     n        prop
    ##   <dbl> <chr>   <chr> <int>       <dbl>
    ## 1  1896     F  Martha  2022 0.008023969
    ## 2  1896     F  Esther  1964 0.007793805
    ## 3  1896     F Frances  1964 0.007793805
    ## 4  1896     F   Edith  1932 0.007666819
    ## 5  1942     F   Helen 10014 0.007202575
    ## 6  1942     F Marilyn  9904 0.007123458
    ## 7  1942     F   Diane  9550 0.006868843
    ## 8  1942     F  Martha  9513 0.006842231

Data Wrangling Code
===================

Complete the following tasks using the package nasaweather and data
wrangling methods.

In the glacier dataset:

-   determine the id's and names of the largest (by area) glaciers for
    each country
-   determine the latitude and longitude of the single largest glacier

In the storm dataset:

-   determine the average wind and its variance for each type of storm
-   determine the number and names of hurricanes in 1999

<!-- -->

    #----------------------------------#
    #####task 7 data wrangling code#####
    #----------------------------------#

    #load appropriate libraries
    library(nasaweather)



    #----------------------glacier data---------------------------#
    #-------------------------------------------------------------#


    #determining largest glaciers in each country
    country_largest_glaciers <- nasaweather::glaciers %>%
      group_by(country) %>%
      top_n(1, area) %>%
      select(id, name, area, country) %>%
      print()

    ## Source: local data frame [5 x 4]
    ## Groups: country [5]
    ## 
    ##             id          name  area country
    ##          <chr>         <chr> <chr>   <chr>
    ## 1  CO1A0104005 SIMONS GRANDE  2.84      CO
    ## 2  EC1D3031002            NA     3      EC
    ## 3 PE1P005YQCB7    TULLPARAJ0  9.81      PE
    ## 4 RB1D22126456            NA   9.2      RB
    ## 5  VZ1A0014PH8      HUMBOLDT  1.98      VZ

    #latitude and longitude of largest glacier in the dataset
    largest_glacier <- nasaweather::glaciers %>%
      top_n(1, area) %>%
      select(name, lat, long, country) %>%
      print()

    ## # A tibble: 1 × 4
    ##         name       lat    long country
    ##        <chr>     <dbl>   <dbl>   <chr>
    ## 1 TULLPARAJ0 -9.406667 -77.325      PE

    #-----------------------------storm data--------------------------------#
    #-----------------------------------------------------------------------#


    #determining average wind and variance for each type of storm
    storm_wind_spd <- nasaweather::storms %>%
      group_by(type) %>%
      summarise(av_wind = mean(wind), var_wind = var(wind)) %>%
      print()

    ## # A tibble: 4 × 3
    ##                  type  av_wind  var_wind
    ##                 <chr>    <dbl>     <dbl>
    ## 1       Extratropical 40.06068 175.48293
    ## 2           Hurricane 84.65960 353.09629
    ## 3 Tropical Depression 27.35867  12.39454
    ## 4      Tropical Storm 47.32181 123.03578

    #determining number of hurricanes in 1999
    hurricane_1999 <- nasaweather::storms %>%
      filter(type == "Hurricane", year == 1999) %>%
      select(name) %>%
      group_by(name) %>%
      summarise() %>%
      print()

    ## # A tibble: 8 × 1
    ##     name
    ##    <chr>
    ## 1   Bret
    ## 2  Cindy
    ## 3 Dennis
    ## 4  Floyd
    ## 5   Gert
    ## 6  Irene
    ## 7   Jose
    ## 8  Lenny
