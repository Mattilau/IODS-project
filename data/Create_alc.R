#Matti Laukkanen, 13.11.2023 Data wrangling exercise w/ UCI MAchine LEarning alcohol consumption data

student_mat <- read.csv("C:\\Users\\mattilau\\OneDrive - University of Helsinki\\IODS PROJECT\\IODS-project\\data\\student-mat.csv", header = TRUE, sep = ";")
student_por <- read.csv("C:\\Users\\mattilau\\OneDrive - University of Helsinki\\IODS PROJECT\\IODS-project\\data\\student-por.csv", header = TRUE, sep = ";")

#check the structure and dimensions of our dataset
str(student_mat)
dim(student_mat)

str(student_por)
dim(student_por)


#let us join the datasets by installing and loading dplyr package
install.packages("dplyr")
library(dplyr)

# Let us select the identifying columns for each dataset
identifying_columns <- setdiff(names(student_mat), c("failures", "paid", "absences", "G1", "G2", "G3"))

# Perform the inner join
Student_joined <- inner_join(student_mat[, identifying_columns], student_por[, identifying_columns], by = identifying_columns)


#remove all duplicates using 'distinct' from the dplyr package
Student_joined_clean <- distinct(Student_joined)

#let us create the new column for "alc_use", which is the average from "Dalc" and "Walc"
Student_joined_clean <- Student_joined_clean %>%
  mutate(alc_use = (Dalc + Walc) / 2)

#Next, we create the new logical column "high_use" using 'mutate' function again
Student_joined_clean <- Student_joined_clean %>%
  mutate(high_use = alc_use > 2)

#save the new dataset:
write.csv(Student_joined_clean, file = "data/studentclean.csv",row.names=FALSE)
#read the file
test<- read.csv("data/studentclean.csv", header = TRUE, sep = ",")
#Test the file
str(test)
head(test)
# all works!


