setwd('C://Users/prakh/Downloads/Docs/Study/Sem 3/IE 7280 Stats Xie Wei/Project')
df <- read.csv("oasis_longitudinal.csv")
df

#
dim(df)

#
str(df)

#
summary(df)

install.packages(c("psych"))
install.packages(c("plyr"))
install.packages(c("corrplot"))
install.packages(c("caret"))
install.packages(c("caretEnsemble"))
install.packages(c("randomForest"))
install.packages(c("xgboost"))

library(psych)
library(plyr)
library(corrplot)
library(caret)
library(caretEnsemble)
library(ggplot2)
library(dplyr)
library(randomForest)
library(xgboost)

#
describe(df)


#Drop hand
table(df$Hand)
df$Hand<-NULL

#Drop Ids
subject_id<-df$Subject.ID
MRI_id<-df$MRI.ID


df$Subject.ID<-NULL
df$MRI.ID<-NULL

df

#Checking for null values
sort(apply(df, 2, function(x){sum(is.na(x))}), decreasing = TRUE)

#Comparison between CDR and Age
ggplot(df, aes(as.factor(CDR), Age))+
  geom_boxplot(col = "black")+
  ggtitle("Degree of CDR by Age")+
  xlab("CDR")+
  theme(plot.title = element_text(hjust = .5))

#Comparison of Clinical Dementia Rating by Age
x<-ggplot(df, aes(as.factor(CDR), Age, fill = M.F))+
  geom_boxplot()+
  ggtitle("Comparison of Clinical Dementia Rating by Age")+
  xlab("Clinical Dementia Rating")+
  #geom_text(stat = "count", aes(label = ..count..), y = 60, col = "red")+
  theme(plot.title = element_text(hjust = .5))
x+ scale_fill_brewer(palette="Set1")

#Group by CDR and M.F
df%>%
  group_by(as.factor(CDR), as.factor(M.F))%>%
  summarise(n = n())



#Updating CDR levels from 4 to 3.
table(df$CD)
df$CDR<-ifelse(df$CDR==2, 1, df$CDR)

#Updated plot for Comparison of CDR by Age
q<- ggplot(df, aes(as.factor(CDR), Age, fill = M.F))+
  geom_boxplot()+
  ggtitle("Comparision of Clinical Dementia Rating by Age")+
  xlab("Clinical Dementia Rating")+
  #geom_text(stat = "count", aes(label = ..count..), y = 60, col = "red")+
  theme(plot.title = element_text(hjust = .5))
q+scale_fill_brewer(palette="Set1")

#Comparison of Age and Sex
ggplot(df, aes(Age, fill = M.F))+
  geom_histogram()+
  facet_wrap(~M.F)+
  scale_fill_manual(values = c("brown", "orange"))+
  ggtitle("Comparison of Age by Sex")+
  theme(plot.title = element_text(hjust = .5))

#Count of Males Vs Females.
ggplot(df, aes(M.F, fill = M.F))+
  geom_bar()+
  scale_fill_manual(values = c("brown", "orange"))+
  geom_text(stat = "count", aes(label = ..count..), y = 5, col = "white", fontface = "bold")+
  ggtitle("Count of Male vs Female")+
  theme(plot.title = element_text(hjust = .5))

#Count of Group by CDR
b<-ggplot(df, aes(Group, fill = as.factor(CDR)))+
  geom_bar()+
  ggtitle("Count of Group by CDR")+
  theme(plot.title = element_text(hjust = .5))
b+scale_fill_brewer(palette="Set1")

df%>%
  group_by(Group, as.factor(CDR))%>%
  summarise(n = n())

#Relationship between Years of education and Mini Mental State Examination
ggplot(df, aes(y=MMSE, x=EDUC)) + 
  geom_point(colour="Black")+
  geom_smooth(method='lm', formula= y~x)+
  xlab("Years of Education")+
  ylab("MMSE")+
  ggtitle("Relationship between Years of education and Mini Mental State Examination")+
  theme(plot.title = element_text(color="Black", size=14, face="bold",hjust = 0.5),
        axis.title.x = element_text(color="Black", size=14, face="bold"),
        axis.title.y = element_text(color="Black", size=14, face="bold"))

sort(apply(df, 2, function(x){sum(is.na(x))}), decreasing = TRUE)

df$MMSE<-ifelse(is.na(df$MMSE), median(df$MMSE, na.rm = TRUE), df$MMSE)
df$SES<-ifelse(is.na(df$SES), median(df$SES, na.rm = TRUE), df$SES)


df$Group<-as.factor(df$Group)
df$M.F<-as.factor(df$M.F)
df$CDR<-as.factor(ifelse(df$CDR==.5, 1,df$CDR))


fv<-df[, sapply(df, is.factor)]
CDR<-fv$CDR
dum_var<-dummyVars(~., fv[,-3])
fv<-as.data.frame(predict(dum_var, fv[,-3]))
fv<-as.data.frame(cbind(fv, CDR))
df
fv
nv<-df[, sapply(df, is.numeric)]
correlations<-cor(nv)
correlations
highCorr<-findCorrelation(correlations, cutoff = .75)
highCorr
nv<-nv[,-highCorr]
nv

nv$Visit<-scale(nv$Visit)
nv$Age<-scale(nv$Age)
nv$EDUC<-scale(nv$EDUC)
nv$MMSE<-scale(nv$MMSE)
nv$nWBV<-scale(nv$nWBV)
nv$ASF<-scale(nv$ASF)
fv
nv





train_alzh<-as.data.frame(cbind(nv, fv))
train_alzh
train_alzh<-train_alzh[,c(-8,-9,-10)]
train_alzh

install.packages(c("glmnet"))
install.packages(c("kernlab"))


#Lasso Regression.
ctrl<-trainControl(method = "cv", number = 10)
set.seed(111344323)
lasso_model<-train(CDR~., data = train_alzh, method = "glmnet", metric = "Accuracy", trControl = ctrl,
                 tuneGrid = expand.grid(alpha = 1, lambda = seq(0, .015, length = 30)))
max(lasso_model$results$Accuracy)
lasso_model$bestTune
coef(lasso_model$finalModel, lasso_model$finalModel$lambdaOpt)
plot(lasso_model)

#SVM
set.seed(10000000)
svm_model<-train(CDR~., data = train_alzh, method = "svmRadial", metric = "Accuracy", trControl = ctrl, tuneLength = 15)
varImp(svm_model)
max(svm_model$results$Accuracy)
svm_model$bestTune
plot(svm_model)

#KNN
set.seed(11)
knn_model1<-train(CDR~., data = train_alzh, method = "knn", metric = "Accuracy", trControl = ctrl,
               tuneGrid = data.frame(.k = 1:20))


knn_model1$bestTune
max(knn_model1$results$Accuracy)
plot(knn_model1)


#RandomForest
set.seed(11)
randomForestModule<-randomForest(CDR~., data = train_alzh, importance =T)
importance(randomForestModule, type = 1)
varImpPlot(randomForestModule)



df_trainRF <- round(0.8 * nrow(df)) #80% of length of main data set as integer
train_randomInd <- sample(1:nrow(df), df_trainRF) #creating a vector with random indices
train <- df[train_randomInd, ] #generating train data set (with ideces = train_indices)
test <- df #generating test data set




#Random Forest.
formula <- CDR ~ M.F + Age + EDUC + SES + MMSE + eTIV + nWBV
randomeFModel <- randomForest(formula = formula,
                          data = train,
                          importance=TRUE)
xc = predict(randomeFModel ,newdata=train)
xc

# Print the model output
print(randomeFModel)
plot(randomeFModel, main = "Model Error by Number of Trees")
legend(x = "right", 
       legend = colnames(randomeFModel$err.rate),
       fill = 1:ncol(randomeFModel$err.rate))
varImpPlot(randomeFModel, main = "Importance of Variables") #plot variance importance
models<-list("lasso" = lasso.mod, "svm" = svm.mod, "knn" = knn.mod)


#Comparision of Accuracy with different models.
mod_accuracy<-c(0.7587 ,0.8167417, 0.8541528, 0.8194444, 0.9062 )
Model<-c("Decision Tree","Lasso", "SVM", "KNN","Random Forest")

data.frame(Model, mod_accuracy)%>%
  ggplot(aes(reorder(Model, mod_accuracy), mod_accuracy*100))+
  geom_point(col = "black", size = 6)+
  geom_point(col = "blue", size = 2)+
  ggtitle("Accuracy by Model")+
  ylab("Accuracy %")+
  xlab("Model")+
  theme(plot.title = element_text(hjust =.5))

df

