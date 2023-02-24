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
#This blok shows how data was modified BUT DO NOT RUN IT cos last step was made in excel
#Loading Data
#mbasket<-read.csv("MarketBasket.csv")
#
#formating Data
#mbasket<-mbasket %>% group_by(Order) %>% summarise(Description = paste(unique(Description), collapse = ', '))
#mbasket<-mbasket %>% mutate(across(where(is.character), tolower)) 
#write.csv(mbasket, file="mbasket.csv")
################################################################################################################

#Loading ready Data
mbasket<- read.transactions("mbasket.csv", sep = ",")
summary(mbasket)
arules::inspect(mbasket[1:5]) #Look at first five transactions
itemFrequency(mbasket[, 1:3]) 

itemFrequencyPlot(mbasket, support = 0.1) #at least 10% of cases
itemFrequencyPlot(mbasket,
                  topN = 20,
                  horiz = TRUE,
                  xlab = NULL,
                  ylab = NULL) #20 most frequent

#Add settings
mbasketrules <- apriori(mbasket, parameter = list(support = 0.009, confidence = 0.25, minlen = 2))
summary(mbasketrules)
inspect(mbasketrules[1:10])
inspect(sort(mbasketrules, by = "confidence")[1:3])

#######
#RULES#
#######

birth <- (3+6+1+9+9+9)*100
#Finding subsets of rules
#PS not interesting
gourdrules <- subset(mbasketrules, items %in% "gourd / cucumber")
inspect(gourdrules)

#Finding subsets of rules 
InstantNoodlesrules <- subset(mbasketrules, items %in% "instant noodles")
inspect(instantnoodlesrules)

#Finding subsets of rules 
OrganicSaltRules <- subset(mbasketrules, items %in% "organic salt")
inspect(OrganicSaltRules)

#Finding subsets of rules containing 
RiceRules <- subset(mbasketrules, items %in% "raw rice")
inspect(RiceRules)
#########
#WRITING#
#########
# writing the rules to a CSV 
write(InstantNoodlesrules, file = "InstantNoodlesrules.csv",
      sep = ",", quote = TRUE, row.names = FALSE)

InstantNoodlesrules_df <- as(InstantNoodlesrules, "data.frame")
str(InstantNoodlesrules_df) 




