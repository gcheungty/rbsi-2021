install.packages("haven")
install.packages("dplyr")
install.packages("tidyverse")
library(dplyr)
library(tidyverse)
library(haven)
library(data.table)

lapop_guatemala_2019 <- read_dta("Downloads/Guatemala LAPOP AmericasBarometer 2019 v1.0_W.dta")
lapop_guatemala_2017 <- read_dta("Downloads/823416394Guatemala LAPOP AmericasBarometer 2017 V1.0_W.dta")
lapop_guatemala_2014 <- read_dta("~/Downloads/1519863689Guatemala LAPOP AmericasBarometer 2014 v3.0_W.dta")
lapop_guatemala_2012 <- read_dta("~/Downloads/2041873797Guatemala LAPOP AmericasBarometer 2012 Rev1_W.dta")
lapop_guatemala_2010 <- read_dta("Downloads/305797627Guatemala_LAPOP_AmericasBarometer 2010 data set  approved V3.dta")
lapop_guatemala_2008 <- read_dta("Downloads/130872853guatemala_lapop_dims_2008_final_data_set_v10.dta")
lapop_guatemala_2006 <- read_dta("Downloads/784250406guatemala_ lapop_final 2006 data set 092906.dta")
lapop_guatemala_2004 <- read_dta("Downloads/1111117573guatemala 2004 export version.dta")

lapop_guatemala_2004 <- lapop_guatemala_2004 %>%
  mutate(idnum = as.character(idnum)) 
lapop_guatemala_2006 <- lapop_guatemala_2006 %>%
  mutate(idnum = as.character(idnum)) 
lapop_guatemala_2008 <- lapop_guatemala_2008 %>%
  mutate(idnum = as.character(idnum)) 
lapop_guatemala_2010 <- lapop_guatemala_2010 %>%
  mutate(idnum = as.character(idnum)) %>%
  select(-clusterdesc)
lapop_guatemala_2012 <- lapop_guatemala_2012 %>%
  mutate(idnum = as.character(idnum), fecha = as.numeric(fecha), ti = as.numeric(ti))
lapop_guatemala_2014 <- lapop_guatemala_2014 %>%
  mutate(idnum = as.character(idnum), fecha = as.numeric(fecha), ti = as.numeric(ti))
lapop_guatemala_2017 <- lapop_guatemala_2017 %>%
  mutate(idnum = as.character(idnum), fecha = as.numeric(fecha), ti = as.numeric(ti))
lapop_guatemala_2019 <- lapop_guatemala_2019 %>%
  mutate(idnum = as.character(idnum), fecha = as.numeric(fecha), ti = as.numeric(ti))

table(lapop_guatemala_2006$idnum)

rbindlist(list(lapop_guatemala_2012, lapop_guatemala_2014))

guatemala_merge1 <- dplyr::bind_rows(lapop_guatemala_2012, lapop_guatemala_2014)
guatemala_merge2 <- dplyr::bind_rows(guatemala_merge1, lapop_guatemala_2017)
guatemala_merge3 <- dplyr::bind_rows(guatemala_merge2, lapop_guatemala_2019)
guatemala_merge4 <- dplyr::bind_rows(guatemala_merge3, lapop_guatemala_2010)
guatemala_merge5 <- dplyr::bind_rows(guatemala_merge4, lapop_guatemala_2008)
guatemala_merge6 <- dplyr::bind_rows(guatemala_merge5, lapop_guatemala_2006)
guatemala_merge7 <- dplyr::bind_rows(guatemala_merge6, lapop_guatemala_2004)


PN4 - are you satisfied with democracy
DEM2 - if democracy is preferable
ETID - are you latina or indigenous or other 
ED - what was the last year of education you completed 
VB2 - last election vote 
q10g


table(lapop_guatemala_2014$etid)
table(lapop_guatemala_2014$dem2)
table(lapop_guatemala_2014$pn4)
table(lapop_guatemala_2014$vb2)

guatemala_2014 <- lapop_guatemala_2014 %>%
  mutate(indigenous = ifelse(etid == 3, 1, 0)) %>% 
  mutate(dem_prefer = ifelse(dem2 == 3, 1,
                      ifelse(dem2 == 1, 2,
                      ifelse(dem2 == 2, 3, NA)))) %>%
  mutate(dem_satisfy = ifelse(pn4 == 1, 4, 
                       ifelse(pn4 == 2, 3, 
                       ifelse(pn4 == 3, 2, 
                       ifelse(pn4 == 4, 1, NA))))) %>%
  mutate(vote2011 = ifelse(vb2 == 1, 1, 
                    ifelse(vb2 == 2, 0, NA)))

guatemala_2014$dem3 <- guatemala_2014$dem2
table(guatemala_2014$dem_prefer)
table(guatemala_2014$dem_satisfy)

Y - preference for democracy
X - indigenous 

guatemala_2014b <- guatemala_2014 %>% 
  drop_na(indigenous, q10g)
  

model1 <- lm(dem_prefer ~ indigenous, data = guatemala_2014)
summary(model1)
model2 <- lm(dem_satisfy ~ indigenous, data = guatemala_2014)
summary(model2)
model2b <- lm(dem_satisfy ~ indigenous + ed + q10g, data = guatemala_2014)
summary(model2b)

cor(guatemala_2014b$indigenous, guatemala_2014b$q10g)

model3 <- lm(dem_satisfy ~ indigenous + vb2, data = guatemala_2014)
summary(model3)

H1: Indigenous people prefer democracy more than Ladinos
H2: Indigenous people who have voted prefer democracy more than any other group
H3: Indigenous people who dont have a formal education still prefer democracy more 


guatemala_all3 <- guatemala_merge3 %>%
  mutate(indigenous = ifelse(etid == 3, 1, 0)) %>% 
  mutate(dem_prefer = ifelse(dem2 == 3, 1,
                             ifelse(dem2 == 1, 2,
                                    ifelse(dem2 == 2, 3, NA)))) %>%
  mutate(dem_satisfy = ifelse(pn4 == 1, 4, 
                              ifelse(pn4 == 2, 3, 
                                     ifelse(pn4 == 3, 2, 
                                            ifelse(pn4 == 4, 1, NA))))) %>%
  mutate(vote2011 = ifelse(vb2 == 1, 1, 
                           ifelse(vb2 == 2, 0, NA)))

guatemala_all3b <- guatemala_all3 %>% 
  drop_na(indigenous, q10g)

model1 <- lm(dem_prefer ~ indigenous, data = guatemala_all3)
summary(model1)
model2 <- lm(dem_satisfy ~ indigenous, data = guatemala_all3)
summary(model2)
model2b <- lm(dem_satisfy ~ indigenous + ed + q10g, data = guatemala_all3)
summary(model2b)

cor(guatemala_all3b$indigenous, guatemala_all3b$q10g)

model3 <- lm(dem_satisfy ~ indigenous * vb2, data = guatemala_all3)
summary(model3)

guatemala_all7 <- guatemala_merge7 %>%
  mutate(indigenous = ifelse(etid == 3, 1, 0)) %>% 
  mutate(dem_prefer = ifelse(dem2 == 3, 1,
                             ifelse(dem2 == 1, 2,
                                    ifelse(dem2 == 2, 3, NA)))) %>%
  mutate(dem_satisfy = ifelse(pn4 == 1, 4, 
                              ifelse(pn4 == 2, 3, 
                                     ifelse(pn4 == 3, 2, 
                                            ifelse(pn4 == 4, 1, NA))))) %>%
  mutate(vote2011 = ifelse(vb2 == 1, 1, 
                           ifelse(vb2 == 2, 0, NA)))

guatemala_all7b <- guatemala_all7 %>% 
  drop_na(indigenous, q10g)

model1 <- lm(dem_prefer ~ indigenous, data = guatemala_all7)
summary(model1)
model2 <- lm(dem_satisfy ~ indigenous, data = guatemala_all7)
summary(model2)
model2b <- lm(dem_satisfy ~ indigenous + ed + q10g, data = guatemala_all7)
summary(model2b)

cor(guatemala_all7b$indigenous, guatemala_all7b$q10g)

model3 <- lm(dem_satisfy ~ indigenous * vb2, data = guatemala_all7)
summary(model3)

EPR.2021 <- read.csv("~/Downloads/EPR-2021.csv")
View(EPR.2021)

epr_01 <- EPR.2021 %>%
  filter(statename == "Indonesia" | statename == "Mexico")

epr_02 <- EPR.2021 %>%
  filter(statename == "Guatemala")

epr_03 <- EPR.2021 %>%
  filter(statename == "Guatemala")

epr_07 <- EPR.2021 %>% 
  filter(statename %in% mar_04_country) %>%
  mutate(conflict_id = seq(183))

test <- epr_07 %>% 
  gather("point", "year", -c("gwid", "statename", "group", "groupid", "gwgroupid", "umbrella", "size", "status", "reg_aut", "conflict_id")) %>%
  group_by(conflict_id) %>% 
  complete(year = seq(year[1], year[2])) %>%
  fill(everything(), .direction = "up")

test <- test %>%
  arrange(conflict_id, year) %>% 
  rename(country = statename)

write.csv(epr_01, file = "epr_indonesia-mexico.csv")
write.csv(epr_02, file = "epr_guatemala.csv")
write.csv(epr_06, file = "epr_indigenous.csv")

marupdate_20042006 <- read.csv("~/Downloads/marupdate_20042006.csv")

mar_01 <- marupdate_20042006 %>%
  filter(country == "Indonesia" | country == "Mexico")
mar_02 <- marupdate_20042006 %>%
  filter(country == "Guatemala")
mar_03 <- marupdate_20042006 %>%
  filter(VMAR_Group == "Indigenous Peoples") # 33 observations

mar_04 <- marupdate_20042006 %>%
  filter(VMAR_Group == "Indigenous Peoples" | VMAR_Group == "Indigenous Highland Peoples") # 42observations

mar_04_country <- levels(as.factor(mar_04$country))

mar_06 <- marupdate_20042006 %>% 
  filter(country %in% mar_04_country)

table(mar_06$year)


mar_05 <- marupdate_20042006 %>%
  filter(VMAR_Region == "Latin America and the Caribbean") # 99

mar_03 <- marupdate_20042006 %>%

write.csv(mar_01, file = "mar_indonesia-mexico.csv")
write.csv(mar_02, file = "mar_guatemala.csv")
write.csv(mar_06, file = "mar_indigenous.csv")

test02 <- merge(mar_06, test, by = c("country", "year"), all.x = TRUE)


discrimination status - REPVIOL
Autonomy - reg_auto
Representation - LEGISREP,EXECREP, GUARREP

## YOUSSEF 

library(dplyr)
ab_2 <- read.csv("~/Downloads/ABII_English.csv")
ab_3 <- read.csv("~/Downloads/ABIII_English.csv")
ab_4 <- read.csv("~/Downloads/ABIV_English.csv")

egypt_2 <- ab_2 %>%
  filter(country == "5. Egypt") %>%
  mutate(q403b = ifelse(q403 == "1. yes", 1, 
                  ifelse(q403 == "2. no", 0, 
                  ifelse(q403 == "3. i do not follow these media", 1, 
                  ifelse(q403 == "8. i don't know", 1, NA))))) %>%
  drop_na(q403b)

table(as.factor(egypt_2$q2011))
table(as.factor(egypt_2$q2016))
table(as.factor(egypt_2$q403))
table(egypt_2$q403)
table(egypt_2$q403b)

egypt_3 <- ab_3 %>%
  filter(country == "Egypt")

table(as.numeric(as.factor(egypt_3$q2016)))
egypt_4 <- ab_4 %>%
  filter(country == "Egypt") %>%
  mutate(q403b = ifelse(q403 == "Yes", 1, 
                        ifelse(q403 == "No", 0, 
                               ifelse(q403 == "Have not tried (Do not read)", 1, NA)))) %>%
  drop_na(q403b)
  
table(egypt_4$q403)
table(egypt_4$q404)

egypt_merge <- dplyr::bind_rows(egypt_2, egypt_3)
egypt_all <- bind_rows(egypt_merge, egypt_4)
write.csv(egypt_all, "egypt_all.csv")

hist(egypt_2$q403b, xlim = c(0, 1))
hist(egypt_4$q403b, xlim = c(0, 1))




### Monica ### 

library(dplyr)
library(countrycode)


monica_data <- da36410.0001
monica_data$not_born <- ifelse(monica_data$MBORN == "(2) No, Not Born In U.S." & monica_data$FBORN == "(2) No, Not Born In U.S.", 1, 0)
monica_data$us_born <- ifelse(monica_data$MBORN == "(1) Yes, Born In U.S." & monica_data$FBORN == "(1) Yes, Born In U.S.", 1, 0)
monica_data$black_id <- ifelse(monica_data$PPETHM == "(2) Black, Non-Hispanic", 1, 0)

black_data <- monica_data %>% 
  filter(PPETHM == "(2) Black, Non-Hispanic")

us_data <- black_data %>% 
  filter(us_born == 1)

immigrant_data <- black_data %>%
  filter(not_born == 1)

table(black_data$not_born)
table(black_data$us_born)
table(black_data$Q36A)
table(black_data$Q40A)
table(black_data$YRSINUS)

table(black_data$XPARTY7)
table(us_data$XPARTY7)
table(immigrant_data$XPARTY7)

table(monica_data$Q36A)
summary(monica_data$Q40A)

monica_data$XPARTY7 <- as.numeric(monica_data$XPARTY7)
monica_data$Q36A <- as.numeric(monica_data$Q36A)
monica_data$Q40A <- as.numeric(monica_data$Q40A)
monica_data$test <- monica_data$Q36A + monica_data$Q40A
table(monica_data$test)

summary(lm(XPARTY7 ~ black_id + us_born + Q36A, data = monica_data))
monica_m01 <- lm(XPARTY7 ~ black_id + Q36A * us_born, data = monica_data)
monica_m02 <- lm(XPARTY7 ~ Q36A * us_born, data = black_data)
summary(monica_m02)

emmip(monica_m01, us_born ~ Q36A, CIs = TRUE)

DOV_ANCSTID  - COUNTRY OF ORIGIN
USBORN - IMMIGRANT STATUS
XPARTY7 - PARTY ID (7 point)
PPETHM (RACE) - RACE

1. COUNTRY OF ORIGIN "AUTHORITARIANESS" - freedom house data
2. Create a variable for political assimilation 
Average political conformity of state of residence compared to the individual''s expressed party id
2a. Make the political conformity of the state 7 points, to compare to individual party id 
2b. Make individual party id binary, because state political ideology is binary


DV: political assimilation
IDV: country of origin 

lm(political assimilation ~ country of origin, age, employed)

library(dplyr)
library(countrycode)
monica_data2 <- da36410.0001

immigrant_data <- monica_data2 %>%
  filter(USBORN == "(2) No, Not Born In U.S.")

immigrant_data$country_origin <- countryname(immigrant_data$DOV_ANCSTID)
sum(is.na(immigrant_data$country_origin <- countryname(immigrant_data$DOV_ANCSTID)))

freedom_house_2012 <- read.csv("~/Downloads/freedom_house_2012.csv")

immigrant_data$XPARTY7 <- as.numeric(immigrant_data$XPARTY7)

table(immigrant_data$party_id)
table(immigrant_data$PPSTATEN)

cd <- 'https://bit.ly/2ToSrFv'
cd <- read.csv(cd)
immigrant_data$state <- countrycode(immigrant_data$PPSTATEN,  'abbreviation', 'state', custom_dict = cd, origin_regex = TRUE)
immigrant_data$state <- ifelse(immigrant_data$PPSTATEN == "(53) DC", "District of Columbia", immigrant_data$state)

party_df <- data.frame(state = c("District of Columbia", "Hawaii", "Maryland", "Rhode Island" , "New York", "Massachusetts", "Connecticut", "Vermont", "Illinois", "Delaware", "California", "New Jersey", "Michigan", "Minnesota", "Washington", "Maine", "Oregon", "New Mexico", "Pennsylvania", "Ohio", "Florida", "Iowa", "Wisconsin", "North Carolina", "West Virginia", "Kentucky", "New Hampshire", "Louisiana", "Virginia", "Arkansas", "Nevada", "Colorado", "Arizona", "Missouri", "Indiana", "Texas", "Georgia", "Tennessee", "South Dakota", "Mississippi", "South Carolina", "Oklahoma", "Alaska", "Montana", "Alabama", "Kansas", "Nebraska", "North Dakota", "Idaho", "Wyoming", "Utah"), 
                democratic_advantage = c(64.1, 24.0, 23.1, 23.1, 22.1, 20.0, 17.0, 16.9, 16.7, 15.9, 14.9, 13.1, 12.3, 11.3, 9.8, 8.2, 7.2, 7.0, 6.2, 5.5, 4.5, 4.3, 4.1, 2.9, 2.7, 1.5, 0.4, -1.3, -1.4, -1.4, -2.0, -2.4, -3.5, -3.6, -4.3, -4.5, -4.7, -4.8, -4.9, -5.1, -7.4, -9.8, -12.2, -13.4, -14.6, -16.3, -16.9, -18.5, -27.6, -30.0, -36.7))

party_df$state_id <- ifelse(party_df$democratic_advantage > 9.8 , "Strong Democrat", 0)
party_df$state_id <- ifelse(10 > party_df$democratic_advantage & party_df$democratic_advantage > 5 , "Not Strong Democrat", party_df$state_id)
party_df$state_id <- ifelse(5 > party_df$democratic_advantage & party_df$democratic_advantage > 0 , "Leaning Democrat", party_df$state_id)
party_df$state_id <- ifelse(0 > party_df$democratic_advantage & party_df$democratic_advantage > -5 , "Leaning Republican", party_df$state_id)
party_df$state_id <- ifelse(-5 > party_df$democratic_advantage & party_df$democratic_advantage > -10 , "Not Strong Republican", party_df$state_id)
party_df$state_id <- ifelse(-10 > party_df$democratic_advantage, "Strong Republican", party_df$state_id)

party_df$state_id <- ifelse(party_df$democratic_advantage > 9.8 , 7, 0)
party_df$state_id <- ifelse(10 > party_df$democratic_advantage & party_df$democratic_advantage > 5 , 6, party_df$state_id)
party_df$state_id <- ifelse(5 > party_df$democratic_advantage & party_df$democratic_advantage > 0 , 5, party_df$state_id)
party_df$state_id <- ifelse(0 > party_df$democratic_advantage & party_df$democratic_advantage > -5 , 3, party_df$state_id)
party_df$state_id <- ifelse(-5 > party_df$democratic_advantage & party_df$democratic_advantage > -10 , 2, party_df$state_id)
party_df$state_id <- ifelse(-10 > party_df$democratic_advantage, 1, party_df$state_id)

immigrant_data$party2 <- ifelse(immigrant_data$XPARTY7 == 1, "republican", NA)
immigrant_data$party2 <- ifelse(immigrant_data$XPARTY7 == 2, "republican", immigrant_data$party2)
immigrant_data$party2 <- ifelse(immigrant_data$XPARTY7 == 3, "republican", immigrant_data$party2)
immigrant_data$party2 <- ifelse(immigrant_data$XPARTY7 == 5, "democrat", immigrant_data$party2)
immigrant_data$party2 <- ifelse(immigrant_data$XPARTY7 == 6, "democrat", immigrant_data$party2)
immigrant_data$party2 <- ifelse(immigrant_data$XPARTY7 == 7, "democrat", immigrant_data$party2)
immigrant_data$party2

immigrant_data$party3 <- ifelse(immigrant_data$XPARTY7 < 4, "republican", NA)
immigrant_data$party3 <- ifelse(immigrant_data$XPARTY7 > 4, "democrat", immigrant_data$party3)
immigrant_data$party3

immigrant_data_2 <- merge(immigrant_data, freedom_house_2012, by.x = "country_origin", by.y = "Country")

immigrant_data_3 <- merge(immigrant_data_2, party_df, by = "state")

immigrant_data_3$party7  <- immigrant_data_3$XPARTY7 

write.csv(immigrant_data_3, "immigrant_data_3.csv")

variables <- c("state", "country_origin", "party_id", "state_id", "PR")
immigrant_data4 <- immigrant_data_3[variables]

immigrant_data_3$math1 <- immigrant_data_3$state_id - immigrant_data_3$party7

immigrant_data_3$assimialted <- ifelse(immigrant_data_3$state_id - immigrant_data_3$party7 < 3, 1 , 0)

myvars <- c("v1", "v2", "v3")
newdata <- mydata[myvars]

### CAROLINA 

load("~/Downloads/ICPSR_36680/DS0001/36680-0001-Data.rda")
lines_data <- da36680.0001
str(da36680.0001$STATE)
table(da36680.0001$THERMGR_THGRPOLICE)
summary(da36680.0001$THERMGR_THGRPOLICE)

library(countrycode)
cd <- 'https://bit.ly/2ToSrFv'
cd <- read.csv(cd)
lines_data$State <- countrycode(lines_data$STATE,  'abbreviation', 'state', custom_dict = cd, origin_regex = TRUE)
lines_data$State <- ifelse(lines_data$STATE == "DC", "District of Columbia", lines_data$State)
table(lines_data$State)

?merge
lines_merge <- merge(lines_data, deportations.2011.2007, by.x = "State", by.y = "State")

write.csv(lines_merge, "lines_merge.csv")

library(dplyr)
lines_mergeb <- lines_merge %>% 
  mutate(deport_rate = as.numeric(deport_rate), CAMPINT_POLATTREV = as.numeric(CAMPINT_POLATTREV), NATURALIZE = as.numeric(NATURALIZE), DISCRIM_DISCIMMIG = as.numeric(DISCRIM_DISCIMMIG), IMMIGPO_IMMLEVEL = as.numeric(IMMIGPO_IMMLEVEL)) 
  

model_1 <- lm(THERMGR_THGRPOLICE ~ deport_rate, data = lines_mergeb)
summary(model_1)
model_1 <- lm(DISCRIM_DISCIMMIG ~ deport_rate + CAMPINT_POLATTREV + NATURALIZE, data = lines_mergeb)
summary(model_1)
model_1 <- lm(IMMIGPO_IMMLEVEL ~ deport_rate + CAMPINT_POLATTREV + NATURALIZE, data = lines_mergeb)
summary(model_1)

1. Match deportation to states in survey 
2. Clean the data (Get rid of the NAs)
3. Running a regression lm()
4. Running a regression with controls 

DISCRIM_DISCIMMIG: Post: How much discrimination is there in the United States today against Immigrants?
  DISCRIM_DISCHISP: Post: How much discrimination is there in the United States today against Hispanics?
  IMMIG_IMMPOL: Which comes closest to your view about what government policy should be toward unauthorized immigrants now living in the United States?
  Which comes closest to your view about what government policy should be toward unauthorized immigrants now living in the United States?