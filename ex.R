#Librarys
packages<-c(
  "Matrix",
  "purrr",
  "data.table",
  "tidyr",
  "arules",
  "rlang",
  "dplyr",
  "ggplot2",
  "corrplot",
  "gridExtra",
  "tm",
  "twitteR",
  "readr",
  "rstudioapi",
  "tidytext",
  "stringr",
  "stargazer",
  "wordcloud",
  "wordcloud2",
  "colourvalues",
  "viridis",
  "usmap"
)
if(!require("pacman")) install.packages("pacman")
pacman::p_load(packages, character.only = T)
sapply(packages, require, character.only = TRUE)

################################################################################################################
#This blok shows how data was modifyed BUT DO NOT RUN IT cos last step was made in excel
#Loading Data
#mbasket<-read.csv("MarketBasket.csv")
#
#formating Data
#mbasket<-mbasket %>% group_by(Order) %>% summarise(Description = paste(unique(Description), collapse = ', '))
#write.csv(mbasket, file="mbasket.csv")
################################################################################################################

#Loading ready Data
mbasket<- read.transactions("mbasket.csv", sep = ",")
summary(mbasket)

arules::inspect(mbasket[1:5]) #Look at first five transactions
itemFrequency(mbasket[, 1:3]) 

#Plot the frequency of items
itemFrequencyPlot(mbasket, support = 0.1) #at least 10% of cases

#Plot the frequency of items
itemFrequencyPlot(mbasket, topN = 20, horiz = TRUE) #20 most frequent

#Apply 'apriori' algorithm
apriori(mbasket)

#Add settings
#mbasketrules <- 
apriori(mbasket, parameter = list(support = 0.006, confidence = 0.25, minlen = 2))
#Summary of grocery association rules
summary(groceryrules)

#Look at the first three rules
inspect(groceryrules[1:3])

#Sorting grocery rules by lift
inspect(sort(groceryrules, by = "lift")[1:5])

#Finding subsets of rules containing any berry items
berryrules <- subset(groceryrules, items %in% "berries")
inspect(berryrules)

# writing the rules to a CSV file
write(groceryrules, file = "groceryrules.csv",
      sep = ",", quote = TRUE, row.names = FALSE)

# converting the rule set to a data frame
groceryrules_df <- as(groceryrules, "data.frame")
str(groceryrules_df) #Compactly display structure of R object




