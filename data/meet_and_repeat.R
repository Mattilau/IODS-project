
BPRS <- read.table("data/BPRS.txt", header = TRUE, sep = " ")
RATS <- read.table("data/Rats.txt", header = TRUE, sep = "\t")
str(RATS)
str(BPRS)
#BPRS includes clinical trial data of 40 males during an 8 week treatments. (BPRS=Brief Psychiatric Rating Scale)
#In Rats, we study how rats grow. Three groups of rats, with each group given a specific diet. WDx: weight on day x

#let us change categorical variables into factors:
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$Group <- factor(RATS$Group)
RATS$ID <- factor(RATS$ID)

#convert data to long form:
library(tidyr)
library(dplyr)


BPRSL <- gather(BPRS, key = weeks, value = bprs, week0:week8) %>%
  mutate(week = as.integer(substr(weeks, 5, 5)))

RATSL <- gather(RATS, key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

#Now we have the datasets BPRSL and RATSL presenting the long form of the original data. 
#Instead of having a single row for each subject, we have now a single row for each observation.
str(RATSL)
str(BPRSL)




