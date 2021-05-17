install.packages("ggplot2")
install.packages("lattice")
install.packages("rlang")
install.packages("lava")
install.packages("caret",dep = TRUE)
install.packages("purrr")
library(ggplot2)
library(lattice)
library(lava)
library(purrr)
library(caret)
install.packages("klaR")
install.packages("MASS")
library(MASS)
library(klaR)
cancer <- read.csv("~/Documents/MBD_Subject/MASTER_PROJECT/cancer-patient-data-sets.csv")
View(cancer)
table(cancer$Level)
data<- sample(2,nrow(cancer),replace=TRUE,prob = c(0.8,0.2))
trainD<- cancer[data==1,2:25]
testD<- cancer[data==2,2:25]
nrow(trainD)
nrow(testD)
#install.packages("rminer")
library(rminer)
#install.packages("e1071")
library(e1071)
naive_model<- naiveBayes(Level ~ .,data=trainD)
naive_model

saveRDS(naive_model, "naive_model.rds")

testmodel<-predict(naive_model,testD)
testmodel
