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
