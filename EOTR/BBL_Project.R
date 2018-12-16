# Proposed Data Project
# Basic Business Licenses in DC, 2017
# URL: http://opendata.dc.gov/datasets/basic-business-license-in-2017

library(dplyr)          # For data manipulation
library(ggplot2)        # For plots
library(ggmap)          # For DC map
library(knitr)          # For Kable

dcmap <- get_googlemap(center=c(lon = -77.03687, lat = 38.90719), zoom = 12, scale = 2)
ggmap(dcmap) + geom_point(data=eotr.grocery, aes(x=LONGITUDE, y=LATITUDE, label=), fill="blue") 
        

setwd("C:/Users/sugac_000/Desktop/Data Incubator Challenge")

# Read in data set
bbl <- read.csv("Basic_Business_License_in_2017.csv",header=TRUE)
str(bbl)
#table(bbl$WARD)
#table(bbl$ZIPCODE)
#table(bbl$LICENSECATEGORY)
#table(bbl$LICENSECATEGORY,bbl$WARD==7 | bbl$WARD==8)

# Create indicator for wards that are located east of the river (EOTR)
bbl$EOTR[bbl$WARD == 7 | bbl$WARD == 8] <- "EOTR"
bbl$EOTR[bbl$WARD != 7 & bbl$WARD != 8] <- "non-EOTR"

# What are top License Categories for EOTR? 
# How do they compare to the rest of DC?
top.cat <- as.data.frame(table(bbl$LICENSECATEGORY, bbl$EOTR))
# Order by top categories for EOTR vs. non-EOTR
top.cat <- top.cat[order(top.cat$Var2, -top.cat$Freq),]
top.cat <- subset(top.cat, (top.cat$Var2 == "non-EOTR" & top.cat$Freq > 2300) | (top.cat$Var2 == "EOTR" & top.cat$Freq > 150))
# Create bar chart of top 10 categories for EOTR vs. non-EOTR
ggplot(top.cat,aes(x = Var1, y = Freq, fill = Var2) ) + geom_bar(stat="identity") + coord_flip() + 
        labs(y= "Number of BBLs", x="License Category", fill = "Location")

bbl.eotr <- subset(bbl, bbl$WARD ==7 | bbl$WARD == 8)
bbl.wotr <- subset(bbl, bbl$WARD != 7 & bbl$WARD != 8)
bbl.ward7 <- subset(bbl, bbl$WARD==7)
bbl.ward8 <- subset(bbl, bbl$WARD==8)

# Grocery store BBLs EOTR compared to rest of DC
eotr.grocery <- subset(bbl.eotr, bbl.eotr$LICENSECATEGORY=="Grocery Store")
wotr.grocery <- subset(bbl.wotr, bbl.wotr$LICENSECATEGORY=="Grocery Store")
bbl.grocery <- subset(bbl, bbl$LICENSECATEGORY=="Grocery Store")
ward7.grocery <- subset(bbl.ward7, bbl.ward7$LICENSECATEGORY=="Grocery Store")

map("state", region="district of columbia")
#points(bbl.ward7$LONGITUDE-0.025, bbl.ward7$LATITUDE, col = "red", cex = 0.6)
#points(ward7.grocery$LONGITUDE-0.025, ward7.grocery$LATITUDE, col="blue", cex=0.6)
#points(bbl.ward8$LONGITUDE-0.025, bbl.ward8$LATITUDE, col="green", cex = .6)
points(eotr.grocery$LONGITUDE-0.025, eotr.grocery$LATITUDE, col="blue", cex=0.6)
points(wotr.grocery$LONGITUDE, wotr.grocery$LATITUDE, col ="gray",cex=0.6)


# BBLs for Business Improvement Districts, by Ward
kable(table(bbl$BUSINESSIMPROVEMENTDISTRICT,bbl$WARD))
#        |                          |    1|    2|    3|    4|    5|    6|    7|    8|
#        |:-------------------------|----:|----:|----:|----:|----:|----:|----:|----:|
#        |ADAMS MORGAN BID          |  366|    0|    0|    0|    0|    0|    0|    0|
#        |CAPITOL HILL BID          |    0|    1|    0|    0|    0| 1210|    0|    0|
#        |CAPITOL RIVERFRONT BID    |    0|    0|    0|    0|    0| 1115|    0|    0|
#        |DOWNTOWN BID              |    0| 4632|    0|    0|    0|  150|    0|    0|
#        |GEORGETOWN BID            |    0|  489|    0|    0|    0|    0|    0|    0|
#        |GOLDEN TRIANGLE BID       |    0| 1190|    0|    0|    0|    0|    0|    0|
#        |MOUNT VERNON TRIANGLE CID |    0|    0|    0|    0|    0|  207|    0|    0|
#        |NOMA BID                  |    0|    0|    0|    0|   39|  370|    0|    0|
#        |NONE                      | 5720| 4785| 3486| 3860| 9986| 6525| 2885| 3760|
# Interestingly, none in Wards 7 or 8

######## END OF CODE #############