# UN-COMMENT THE FOLLOWING LINE IF TIDYVERSE IS NOT INSTALLED
#install.packages("tidyverse")

library(tidyverse)
shots <- read_csv("C:/Users/evang/OneDrive/Desktop/RStuff/Thunder Application/shots_data.csv")

# For the provided shot coordinate and outcome dataset, determine the effective field goal 
# percentage and percentage of team shots attempted (shot distribution) within the following 
# shot zones: Two Point (2PT), Non Corner 3 (NC3) and Corner 3 (C3).



# SETTING ZONES: add column of dataframe with zones
shots <- shots %>% mutate(zone = case_when(x>22|x<(-22) & y<= 7.8 ~ "C3",
                                        x<=22 & x>=(-22) & y<=(sqrt((23.75^2)-(x^2))) ~ "2PT",
                                        TRUE ~ "NC3"))
# check for NA's (because of warning message)
numberofNAs <- which(is.na(shots))
numberofNAs



# FIELD GOAL PERCENTAGE
shotsteamA <- shots %>% filter(team == "Team A")
shotsteamB <- shots %>% filter(team == "Team B")

FGP_A2PT <- ((shotsteamA %>% filter(zone == "2PT", fgmade == 1) %>% summarize(n()))
            /(shotsteamA %>% filter(zone == "2PT") %>% summarize(n())))*100
FGP_ANC3 <- ((shotsteamA %>% filter(zone == "NC3", fgmade == 1) %>% summarize(n()))
             /(shotsteamA %>% filter(zone == "NC3") %>% summarize(n())))*100
FGP_AC3 <- ((shotsteamA %>% filter(zone == "C3", fgmade == 1) %>% summarize(n()))
             /(shotsteamA %>% filter(zone == "C3") %>% summarize(n())))*100

FGP_B2PT <- ((shotsteamB %>% filter(zone == "2PT", fgmade == 1) %>% summarize(n()))
             /(shotsteamB %>% filter(zone == "2PT") %>% summarize(n())))*100
FGP_BNC3 <- ((shotsteamB %>% filter(zone == "NC3", fgmade == 1) %>% summarize(n()))
             /(shotsteamB %>% filter(zone == "NC3") %>% summarize(n())))*100
FGP_BC3 <- ((shotsteamB %>% filter(zone == "C3", fgmade == 1) %>% summarize(n()))
            /(shotsteamB %>% filter(zone == "C3") %>% summarize(n())))*100
# round the values
FGP_A2PT <- format(round(FGP_A2PT, 3), nsmall = 3)
FGP_ANC3 <- format(round(FGP_ANC3, 3), nsmall = 3)
FGP_AC3 <- format(round(FGP_AC3, 3), nsmall = 3)
FGP_B2PT <- format(round(FGP_B2PT, 3), nsmall = 3)
FGP_BNC3 <- format(round(FGP_BNC3, 3), nsmall = 3)
FGP_BC3 <- format(round(FGP_BC3, 3), nsmall = 3)
# print the results
print(paste("For Team A, the field goal percentages in the Two Point, Non Corner 3, and Corner 3 Zones are about: ",FGP_A2PT,"%, ",FGP_ANC3,"%, and ",FGP_AC3,"%, respectively."))
print(paste("For Team B, the field goal percentages in the Two Point, Non Corner 3, and Corner 3 Zones are about: ",FGP_B2PT,"%, ",FGP_BNC3,"%, and ",FGP_BC3,"%, respectively."))



# SHOT DISTRIBUTION
SD_A2PT <- ((shotsteamA %>% filter(zone == "2PT") %>% summarize(n()))
            /(shotsteamA %>% summarize(n())))*100
SD_ANC3 <- ((shotsteamA %>% filter(zone == "NC3") %>% summarize(n()))
            /(shotsteamA %>% summarize(n())))*100
SD_AC3 <- ((shotsteamA %>% filter(zone == "C3") %>% summarize(n()))
            /(shotsteamA %>% summarize(n())))*100
SD_B2PT <- ((shotsteamB %>% filter(zone == "2PT") %>% summarize(n()))
            /(shotsteamB %>% summarize(n())))*100
SD_BNC3 <- ((shotsteamB %>% filter(zone == "NC3") %>% summarize(n()))
            /(shotsteamB %>% summarize(n())))*100
SD_BC3 <- ((shotsteamB %>% filter(zone == "C3") %>% summarize(n()))
           /(shotsteamB %>% summarize(n())))*100
# round the values
SD_A2PT <- format(round(SD_A2PT, 3), nsmall = 3)
SD_ANC3 <- format(round(SD_ANC3, 3), nsmall = 3)
SD_AC3 <- format(round(SD_AC3, 3), nsmall = 3)
SD_B2PT <- format(round(SD_B2PT, 3), nsmall = 3)
SD_BNC3 <- format(round(SD_BNC3, 3), nsmall = 3)
SD_BC3 <- format(round(SD_BC3, 3), nsmall = 3)
# print the results
print(paste("The shot distribution for Team A is approximately as follows: ", SD_A2PT, "% in the Two Point Zone, ", SD_ANC3, "% in the Non Corner 3 Zone, ", SD_AC3, "% in the Corner 3 Zone."))
print(paste("The shot distribution for Team B is approximately as follows: ", SD_B2PT, "% in the Two Point Zone, ", SD_BNC3, "% in the Non Corner 3 Zone, ", SD_BC3, "% in the Corner 3 Zone."))

