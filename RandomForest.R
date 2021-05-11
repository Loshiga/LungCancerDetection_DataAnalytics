#install.packages("randomFrorest") 
library("randomForest")
cancer <-read.csv("~/Desktop/LosProject/cancer-patient-data-sets.csv")
View(cancer)
#bagging
library(ipred)
#install.packages(ipred)
cancer$Level <- as.factor(cancer$Level)
cancer_bagging <- cancer[2:25]
cancerbagging <- bagging(Level ~ .,cancer_bagging)
predict_level <-predict(cancerbagging,cancer_bagging) 
cancer_bagging$prediction <- predict_level 
head(cancer_bagging) 
with(cancer_bagging,table(Level,prediction))
#end og bagging
set.seed(250)
library(ggplot2)
library(caret)
intrain <- createDataPartition(y =cancer$Level, p= 0.8, list = FALSE) 
training <- cancer[intrain,]
testing <- cancer[-intrain,]
dim(training)
rf<- randomForest(Level ~ .,training)
rf
pmodel <- predict(rf,testing)
pmodel
table(testing[,24],pmodel) 
mean(testing[,24]==pmodel) 
confusionMatrix(pmodel, testing$Level )
