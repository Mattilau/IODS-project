#Read in the “Human development” and “Gender inequality” data sets as follows:
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

#Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables:
str(gii)
dim(gii)
str(hd)
dim(hd)
summary(gii)
summary(hd)

#let us change column names
names(gii) <- c("GII Rank", "Country", "GII","Mat.Mor","Ado.Birth","Parli","Edu2.F","Edu2.M","Labo.F","Labo.M")
names(hd) <- c("HDI Rank", "Country", "HDI","Life.Exp","Edu.Exp","Mean.Edu","GNI","Gni-HDI.Rank")

#new variables
gii$Edu2.ratio <- gii$Edu2.F / gii$Edu2.M
gii$Labo.ratio <- gii$Labo.F / gii$Labo.M

#Join the two datasets:
library(dplyr)
library(readr)

human <- inner_join(gii, hd, by = "Country")

write_csv(human, "data/human.csv")

#continuing from human data:

library(readr)
human <- read_csv("data/human.csv")
str(human)
dim(human)
#our dataset consist of 195 observations of 19 variables. In the dataset, we examine the Human Development Index (HDI) and the factors affecting it. HDI is a index developed by UN to assess the development of a country, instead of looking just the GDP growth.
# In  the dataset, we compare countries with respect to their HDI and HDI rank, Global Innovation Index (GII) and GII rank, maternal mortality, adolescent birth rate, Education, labor, life and education expectancy, as well as their Gross National Income (GNI)

#We will eliminate all variables that are not necessary for our purposes, and leave only the following nine variables:  "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"


Human_new <- human[, c("Country", "Edu2.ratio", "Labo.ratio", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli")]


#Next, I want to eliminate all rows with missing values:

Human_new <- na.omit(Human_new)

#Next, I want to eliminate all observations that are regions instead of countries. Seems like all observations 156-162 are regions. Let us eliminate those:

Human_new <- Human_new[-c(156:162), ]

#Let us save the data in our folder and ovewrite the old dataset:

write_csv(Human_new, "data/human.csv")

#check if everything is in order:

library(readr)
human <- read_csv("data/human.csv")

#bingo

