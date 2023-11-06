#Matti Laukkanen, 6.11.2023, data exercise script

#Read the data file into R:
my_data <- read.csv("C:\\Users\\mattilau\\OneDrive - University of Helsinki\\IODS PROJECT\\IODS-project\\data\\JYTOPKYS3-data.txt", header = TRUE, sep = "\t")

# Explore the structure of the data
str(my_data)
#structure lists the variables and inputs of a specific variable

# Get the dimensions of the data
dim(my_data)
#the dimensions, i.e., the number of rows and columns in the dataset is 183 rows, 60 columns. (or 183 observations of 60 variables)

#let us create a new dataset for analysis:
learning2014 <- my_data[, c("gender", "Age", "Attitude", "Points")]  # invididual columns
#Add columns for combined question, divide them by the column numbers to get the mean:

#deep, (na.rm=true drops the NA values, if there are any)
learning2014$deep <- (rowSums(my_data[, c("D03", "D11", "D19", "D27")], na.rm = TRUE) +
  rowSums(my_data[, c("D07", "D14", "D22", "D30")], na.rm = TRUE) +
  rowSums(my_data[, c("D06", "D15", "D23", "D31")], na.rm = TRUE))/12

#stra
learning2014$stra <- (rowSums(my_data[, c("ST01", "ST09", "ST17", "ST25")], na.rm = TRUE) +
  rowSums(my_data[, c("ST04", "ST12", "ST20", "ST28")], na.rm = TRUE)) / 8

#surf
learning2014$surf <- (rowSums(my_data[, c("SU02", "SU10", "SU18", "SU26")], na.rm = TRUE) +
  rowSums(my_data[, c("SU05", "SU13", "SU21", "SU29")], na.rm = TRUE) +
  rowSums(my_data[, c("SU08", "SU16", "SU24", "SU32")], na.rm = TRUE)) / 12

#exclude zeros from points:
learning2014 <- learning2014[learning2014$Points != 0, ]

#It seems like the attitude variable that is already included in my_data is a sum of the combined variables but not the mean. Let us take the mean from that as well:
learning2014$Attitude <- learning2014$Attitude / 10

# NOw learning2014 dataset seems to match with the one in Moodle.

#save the file
write.csv(learning2014, file = "data/learning2014.csv",row.names=FALSE)
#read the file
test<- read.csv("data/learning2014.csv", header = TRUE, sep = ",")
#Test the file
str(test)
head(test)
# all works!

