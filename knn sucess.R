cancer <- read.csv("~/Desktop/LosProject/cancer-patient-data-sets.csv")
View(cancer)
dim(cancer)
table(cancer$Level)
x = subset(cancer, select = -c(Patient.Id,Level))
View(x)
dim(x)
data_norm <- function(x) {  return((x) - min(x))/(max(x) - min(x))  }
data_norm
#wdbc = 
#data(wdbc)
wdbc_norm <-as.data.frame(lapply(cancer[2:24], data_norm))
View(wdbc_norm)
summary(wdbc_norm[,2:5])
#summary(wdbc_norm[,1:4])
smp_size <- floor(0.8*nrow(cancer))
set.seed(123)
train_ind<-sample(seq_len(nrow(cancer)),size = smp_size)
cancer_train<-wdbc_norm[train_ind,]
cancer_test<-wdbc_norm[-train_ind,]
dim(cancer_train)
dim(cancer_test)
cancer_train_labels<-cancer[train_ind,25]
cancer_test_labels<-cancer[-train_ind,25]
length(cancer_train_labels)
length(cancer_test_labels)
library(class)
wdbc_test_pred <-knn(train = cancer_train,test = cancer_test, cl = cancer_train_labels,k=21)
length(cancer_train)
#install.packages("gmodels")
library(gmodels)
library(ggplot2)
library(caret)

#table(wdbc_pred,cancer[8001:10000,1])
cancer_test_labels=factor(c(cancer_test_labels))
str(cancer_test_labels)
str(wdbc_test_pred)
confusionMatrix(wdbc_test_pred,cancer_test_labels)
CrossTable(x= cancer_test_labels, y = wdbc_test_pred, prop.chisq = FALSE)
