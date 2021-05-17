

```r
######## RBSI 2019 Methods Lab 4 - Working With Data ########
######## Created by Gabriel Madson (6/4/19)

rm(list=ls())
setwd("~/Dropbox (Personal)/Bunche/Methods Lab")
```

```
## Error in setwd("~/Dropbox (Personal)/Bunche/Methods Lab"): cannot change working directory
```

```r
#### Administrative ####
# Go to ANES Data Center and register
# http://www.electionstudies.org 
# Come for help now, material builds

#### A Brief Review ####
x <- 8
y <- 34
x == 8 & y == 35 # T or F?
```

```
## [1] FALSE
```

```r
x == 8 | y == 35 # T or F?
```

```
## [1] TRUE
```

```r
x <- c(1, "a", 2, "b") 
x # what is they type?
```

```
## [1] "1" "a" "2" "b"
```

```r
#### Debugging ####
help("mean")
?str()
help("str")
# https://stackoverflow.com - someone has asked your question before

#### Filepaths ####
# Telling your computer how to locate folders, documents, pictures, etc.
# getwd() stands for 'get working directory' -- "where am I right now?"
# setwd() stands for 'set working directory' -- "look here until I say otherwise"

setwd("~/Dropbox (Personal)/Bunche/Methods Lab")
```

```
## Error in setwd("~/Dropbox (Personal)/Bunche/Methods Lab"): cannot change working directory
```

```r
getwd() # notice the quotes at the ends, forward slashes, and lack of whitespace
```

```
## [1] "/Users/gcheung/Dropbox/Duke/Summer 2021/RBSI Online/Methods Lab"
```

```r
file.choose()
```

```
## Error in file.choose(): file choice cancelled
```

```r
setwd("/Users/madson37/Desktop")
```

```
## Error in setwd("/Users/madson37/Desktop"): cannot change working directory
```

```r
getwd()
```

```
## [1] "/Users/gcheung/Dropbox/Duke/Summer 2021/RBSI Online/Methods Lab"
```

```r
file.choose() # notice where I start now
```

```
## Error in file.choose(): file choice cancelled
```

```r
## what is this ~ ?!
# ~ == 'home directory' which is different for everyone; just a shortcut
setwd("/Users/madson37/Dropbox (Personal)/Bunche/Methods Lab")
```

```
## Error in setwd("/Users/madson37/Dropbox (Personal)/Bunche/Methods Lab"): cannot change working directory
```

```r
# and 
setwd("~/Dropbox (Personal)/Bunche/Methods Lab")
```

```
## Error in setwd("~/Dropbox (Personal)/Bunche/Methods Lab"): cannot change working directory
```

```r
# are equivalent

## what is this . ?!
setwd("~/")
setwd("./Dropbox (Personal)/Bunche/Methods Lab") 
```

```
## Error in setwd("./Dropbox (Personal)/Bunche/Methods Lab"): cannot change working directory
```

```r
getwd()
```

```
## [1] "/Users/gcheung"
```

```r
# . == 'from where I currently am'

# We can also set the working directory under the Session tab above
#   or with the shortcut ctrl*shift*H [Mac]

## Why set filepaths?
# Saving to proper locations
# Separating different projects
# Loading files
# Computers are efficient, but stupid (too literal)

#### Packages ####
install.packages("foreign")
```

```
## Warning in install.packages :
##   package 'foreign' is not available (for R version 3.6.2)
```

```r
library(foreign)

#### Load data ####
# There are several 'read' functions that load data into R
read.csv() # for excel files (Note: first save excel file as .csv)
```

```
## Error in read.table(file = file, header = header, sep = sep, quote = quote, : argument "file" is missing, with no default
```

```r
read.table() # for text files (.txt)
```

```
## Error in read.table(): argument "file" is missing, with no default
```

```r
read.delim() # same as read.table, but with custom presents for tab separated data
```

```
## Error in read.table(file = file, header = header, sep = sep, quote = quote, : argument "file" is missing, with no default
```

```r
load() # for R data files
```

```
## Error in load(): argument "file" is missing, with no default
```

```r
# When data comes from an alternative statistical software (Stata, SPSS, etc.)
#   we need the foreign package to read the data
library(foreign)

read.spss() # for spss files (.sav)
```

```
## Error in grep("^(http|ftp|https)://", file): argument "file" is missing, with no default
```

```r
read.dta() # for stata files (Note: stata 13 files require special package)
```

```
## Error in grep("^(http|ftp|https)://", file): argument "file" is missing, with no default
```

```r
# Loading 2012 ANES Timeseries
anes12 <- read.spss("./anes_timeseries_2012/anes_timeseries_2012.sav")
```

```
## Error in read.spss("./anes_timeseries_2012/anes_timeseries_2012.sav"): unable to open file: 'No such file or directory'
```

```r
anes12 <- read.spss(file.choose()) # Alternative: brings up current wd, but has nav
```

```
## Error in read.spss(file.choose()): file '/Users/gcheung/Dropbox/Duke/Summer 2021/RBSI Online/Methods Lab/lab3_using_data_19.R' is not in any supported SPSS format
```

```r
#### Getting to know the data ####
# Consult the codebook
length(anes12) # tells us how many columns (variables)
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
length(anes12$caseid) # tells us how many rows (observations)
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
summary(anes12) # brief overview of data (works best for small datasets)
```

```
## Error in summary(anes12): object 'anes12' not found
```

```r
summary(anes12$pid_x)
```

```
## Error in summary(anes12$pid_x): object 'anes12' not found
```

```r
head(anes12$pid_x, 10) # shows us the first few observations of a variable
```

```
## Error in head(anes12$pid_x, 10): object 'anes12' not found
```

```r
is.factor(anes12$pid_x)
```

```
## Error in is.factor(anes12$pid_x): object 'anes12' not found
```

```r
# how many observations are missing (NA) on this question?
# would we want this variable as a factor?

summary(anes12$relig_7cat_x)
```

```
## Error in summary(anes12$relig_7cat_x): object 'anes12' not found
```

```r
# would we want this variable as a factor?

summary(anes12$ft_dpc)
```

```
## Error in summary(anes12$ft_dpc): object 'anes12' not found
```

```r
is.factor(anes12$ft_dpc)
```

```
## Error in is.factor(anes12$ft_dpc): object 'anes12' not found
```

```r
levels(anes12$ft_dpc)
```

```
## Error in levels(anes12$ft_dpc): object 'anes12' not found
```

```r
# would we want this variable as a factor?

#### Cleaning/Recoding ####

summary(anes12$pid_x) # lets make pid ordinal
```

```
## Error in summary(anes12$pid_x): object 'anes12' not found
```

```r
## Two methods: the long way and exploiting the data
# Long way
pid_new1 <- c() # create an empty vector to store our new operationalization
pid_new1[anes12$pid_x == "1. Strong Democrat"] <- 1
```

```
## Error in pid_new1[anes12$pid_x == "1. Strong Democrat"] <- 1: object 'anes12' not found
```

```r
length(pid_new1) # notice it autofills to equal the length of the data
```

```
## [1] 0
```

```r
head(pid_new1, 10) # but all non-Strong Democrats are given a value of NA
```

```
## NULL
```

```r
pid_new1[anes12$pid_x == "2. Not very strong Democract"] <- 2
```

```
## Error in pid_new1[anes12$pid_x == "2. Not very strong Democract"] <- 2: object 'anes12' not found
```

```r
pid_new1[anes12$pid_x == "3. Independent-Democrat"] <- 3
```

```
## Error in pid_new1[anes12$pid_x == "3. Independent-Democrat"] <- 3: object 'anes12' not found
```

```r
pid_new1[anes12$pid_x == "4. Independent"] <- 4
```

```
## Error in pid_new1[anes12$pid_x == "4. Independent"] <- 4: object 'anes12' not found
```

```r
pid_new1[anes12$pid_x == "5. Independent-Republican"] <- 5
```

```
## Error in pid_new1[anes12$pid_x == "5. Independent-Republican"] <- 5: object 'anes12' not found
```

```r
pid_new1[anes12$pid_x == "6. Not very strong Republican"] <- 6
```

```
## Error in pid_new1[anes12$pid_x == "6. Not very strong Republican"] <- 6: object 'anes12' not found
```

```r
pid_new1[anes12$pid_x == "7. Strong Republican"] <- 7
```

```
## Error in pid_new1[anes12$pid_x == "7. Strong Republican"] <- 7: object 'anes12' not found
```

```r
summary(pid_new1) # what happened to the missing category?
```

```
## Length  Class   Mode 
##      0   NULL   NULL
```

```r
hist(pid_new1)
```

```
## Error in hist.default(pid_new1): 'x' must be numeric
```

```r
# Trick way
head(anes12$pid_x)
```

```
## Error in head(anes12$pid_x): object 'anes12' not found
```

```r
levels(anes12$pid_x)
```

```
## Error in levels(anes12$pid_x): object 'anes12' not found
```

```r
head(as.numeric(anes12$pid_x))
```

```
## Error in head(as.numeric(anes12$pid_x)): object 'anes12' not found
```

```r
pid_new2 <- as.numeric(anes12$pid_x)
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
summary(pid_new2) # what happened to the missing category now?
```

```
## Error in summary(pid_new2): object 'pid_new2' not found
```

```r
pid_new2 <- pid_new2 - 1
```

```
## Error in eval(expr, envir, enclos): object 'pid_new2' not found
```

```r
pid_new2 <- ifelse(pid_new2 == 0, NA, pid_new2) # if true, do this, otherwise do this
```

```
## Error in ifelse(pid_new2 == 0, NA, pid_new2): object 'pid_new2' not found
```

```r
summary(pid_new2)
```

```
## Error in summary(pid_new2): object 'pid_new2' not found
```

```r
summary(pid_new1) # exactly the same
```

```
## Length  Class   Mode 
##      0   NULL   NULL
```

```r
# Note: I didnt put these new variables into the dataset, you can do this two ways
anes12$pid_new <- pid_new2 # add a new variable to the dataset
```

```
## Error in eval(expr, envir, enclos): object 'pid_new2' not found
```

```r
anes12$pid_x <- pid_new2 # or edit an existing variable (careful with this method)
```

```
## Error in eval(expr, envir, enclos): object 'pid_new2' not found
```

```r
summary(anes12$ft_dpc) # now lets recode the feeling thermometer variable
```

```
## Error in summary(anes12$ft_dpc): object 'anes12' not found
```

```r
# we have to deal with the notorious factor-numeric problem of R
levels(anes12$ft_dpc) # these are not actually factors, they are numeric entries
```

```
## Error in levels(anes12$ft_dpc): object 'anes12' not found
```

```r
# lets try the trick we used with pid
head(anes12$ft_dpc) # the first 6 people evaluated Obama as 100/100
```

```
## Error in head(anes12$ft_dpc): object 'anes12' not found
```

```r
ft_new1 <- as.numeric(anes12$ft_dpc) # lets just convert to numeric
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
head(ft_new1) # 7!?!?!?!?!?! Why not 100?
```

```
## Error in head(ft_new1): object 'ft_new1' not found
```

```r
levels(anes12$ft_dpc) # factor levels are numeric, but not ordered properly
```

```
## Error in levels(anes12$ft_dpc): object 'anes12' not found
```

```r
ft_new2 <- as.character(anes12$ft_dpc)
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
head(ft_new2) # now its correct but we need to make it numeric
```

```
## Error in head(ft_new2): object 'ft_new2' not found
```

```r
ft_new2 <- as.numeric(ft_new2)
```

```
## Error in eval(expr, envir, enclos): object 'ft_new2' not found
```

```r
summary(ft_new2) # seemed to work but why that warning message?
```

```
## Error in summary(ft_new2): object 'ft_new2' not found
```

```r
length(which(anes12$ft_dpc == "-2. Don't recognize" |
             anes12$ft_dpc == "-8. Don't know" | 
             anes12$ft_dpc == "-9. Refused"))
```

```
## Error in which(anes12$ft_dpc == "-2. Don't recognize" | anes12$ft_dpc == : object 'anes12' not found
```

```r
# Note: this can all be done in a single line of code
ft_new3 <- as.numeric(as.character(anes12$ft_dpc))
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
summary(ft_new2)
```

```
## Error in summary(ft_new2): object 'ft_new2' not found
```

```r
summary(ft_new3) # equivalent
```

```
## Error in summary(ft_new3): object 'ft_new3' not found
```

```r
#### Variable Creation ####

summary(anes12$relig_7cat_x) # lets say we are only interested in binary religious
```

```
## Error in summary(anes12$relig_7cat_x): object 'anes12' not found
```

```r
religious <- ifelse(anes12$relig_7cat_x == "8. Not religious", 1, 0)
```

```
## Error in ifelse(anes12$relig_7cat_x == "8. Not religious", 1, 0): object 'anes12' not found
```

```r
# who is the 'base case' here? does it matter?

# lets build a new variable based on media exposure
summary(anes12$prmedia_wkinews) # days in week read news on internet
```

```
## Error in summary(anes12$prmedia_wkinews): object 'anes12' not found
```

```r
summary(anes12$prmedia_wktvnws) #... on tv
```

```
## Error in summary(anes12$prmedia_wktvnws): object 'anes12' not found
```

```r
summary(anes12$prmedia_wkpaprnws) #... in newspaper
```

```
## Error in summary(anes12$prmedia_wkpaprnws): object 'anes12' not found
```

```r
summary(anes12$prmedia_wkrdnws) #... on radio
```

```
## Error in summary(anes12$prmedia_wkrdnws): object 'anes12' not found
```

```r
int_news <- as.numeric(anes12$prmedia_wkinews) # days in week read news on internet
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
summary(int_news) # what does 1 represent? 12?
```

```
## Error in summary(int_news): object 'int_news' not found
```

```r
tv_news <- as.numeric(anes12$prmedia_wktvnws) #... on tv
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
nwsp_news <- as.numeric(anes12$prmedia_wkpaprnws) #... in newspaper
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
rad_news <- as.numeric(anes12$prmedia_wkrdnws) #... on radio
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
# identify NAs
int_news <- ifelse(int_news <= 4, NA, int_news)
```

```
## Error in ifelse(int_news <= 4, NA, int_news): object 'int_news' not found
```

```r
tv_news <- ifelse(tv_news <= 3, NA, tv_news)
```

```
## Error in ifelse(tv_news <= 3, NA, tv_news): object 'tv_news' not found
```

```r
nwsp_news <- ifelse(nwsp_news <= 3, NA, nwsp_news)
```

```
## Error in ifelse(nwsp_news <= 3, NA, nwsp_news): object 'nwsp_news' not found
```

```r
rad_news <- ifelse(rad_news <= 3, NA, rad_news)
```

```
## Error in ifelse(rad_news <= 3, NA, rad_news): object 'rad_news' not found
```

```r
# reorientate 
int_news <- int_news - 5
```

```
## Error in eval(expr, envir, enclos): object 'int_news' not found
```

```r
tv_news <- tv_news - 4
```

```
## Error in eval(expr, envir, enclos): object 'tv_news' not found
```

```r
nwsp_news <- nwsp_news - 4
```

```
## Error in eval(expr, envir, enclos): object 'nwsp_news' not found
```

```r
rad_news <- rad_news - 4
```

```
## Error in eval(expr, envir, enclos): object 'rad_news' not found
```

```r
# create the index
media_exposure <- (int_news + tv_news + nwsp_news + rad_news)
```

```
## Error in eval(expr, envir, enclos): object 'int_news' not found
```

```r
summary(media_exposure)
```

```
## Error in summary(media_exposure): object 'media_exposure' not found
```

```r
# what does 0 represent? 28? What about 7? be wary of how you interpret
exposure_2 <- media_exposure / 7 # how is this interpreted?
```

```
## Error in eval(expr, envir, enclos): object 'media_exposure' not found
```

```r
length(which(nwsp_news > 0 & rad_news > 0)) / length(anes12$caseid)
```

```
## Error in which(nwsp_news > 0 & rad_news > 0): object 'nwsp_news' not found
```

```r
#### Subsetting ####
anes12 <- as.data.frame(anes12) # we need dataframes to subset, anes is currently list
```

```
## Error in as.data.frame(anes12): object 'anes12' not found
```

```r
data1 <- anes12[1:10, ] # first 10 respondents, all variables
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
data2 <- anes12[ ,1:10] # all respondents, first 10 variables
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
data3 <- anes12[c(1:10, 100:110), seq(from = 1, to = 6, by = 2)] # whats this?
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
data4 <- anes12[-c(100:110), ] # dataset minus respondents 100 thru 110
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
trolls <- c(12, 45, 68, 754)
data5 <- anes12[-trolls, ]
```

```
## Error in eval(expr, envir, enclos): object 'anes12' not found
```

```r
?subset

summary(anes12$libcpre_self)
```

```
## Error in summary(anes12$libcpre_self): object 'anes12' not found
```

```r
ext_cons_data <- subset(anes12, anes12$libcpre_self == "7. Extremely conservative")
```

```
## Error in subset(anes12, anes12$libcpre_self == "7. Extremely conservative"): object 'anes12' not found
```

```r
length(ext_cons_data$libcpre_self)
```

```
## Error in eval(expr, envir, enclos): object 'ext_cons_data' not found
```

```r
summary(ext_cons_data$libcpre_self)
```

```
## Error in summary(ext_cons_data$libcpre_self): object 'ext_cons_data' not found
```

```r
## Why subset?
# make large datasets run faster
# drop nefarius respondents
# make comparisons to full dataset

#### Merging ####
rm(list=ls())
house12 <- read.delim("house12", sep = ",")
```

```
## Warning in file(file, "rt"): cannot open file 'house12': No such file or
## directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
state12 <- read.delim("StateVars.txt", sep = ",")
```

```
## Warning in file(file, "rt"): cannot open file 'StateVars.txt': No such file
## or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
View(house12)
```

```
## Error in View : object 'house12' not found
```

```r
View(state12)
```

```
## Error in View : object 'state12' not found
```

```r
?merge
full_data <- merge(house12, state12, by.x = "stateAbbr", by.y = "StAbr")
```

```
## Error in merge(house12, state12, by.x = "stateAbbr", by.y = "StAbr"): object 'house12' not found
```

```r
# http://www.princeton.edu/~otorres/Merge101R.pdf
```

