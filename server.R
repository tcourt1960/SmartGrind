

library(shiny)
library("randomForest")
library("caret")

#Cross Validation Strategy
# Step #1.  Divide the training set into two parts
# 70% training  30% testing


trainraw<-read.csv("data/GrindingDatenbank.csv",na.strings=c("", "NA", "NULL"),encoding="UTF-8")
trainraw$Datum<-as.Date(trainraw$Datum, format = "%m/%d/%Y")

#Schaefer data started at 2011-05-25
trainraw<-subset(trainraw,Datum >= '2011-05-25')


input_columns<-c(8:22,25,27:30,40)
output_columns<-c(51:64,75)

input_names<-names(trainraw[input_columns])
output_names<-names(trainraw[output_columns])

dataTOuse<-trainraw[c(input_columns,output_columns)]
dataTOuse$I_dM<-as.numeric(dataTOuse$I_dM)
dataTOuse$O_Qwr<-as.numeric(dataTOuse$O_Qwr)
dataTOuse$O_Q.wr<-as.numeric(dataTOuse$O_Q.wr)

dataTOuse<-dataTOuse[complete.cases(dataTOuse),]

#Let's look at historgrams of the Input and Output variables
# numvars<-length(input_columns)+length(output_columns)
# for (i in 1:numvars) {
#   hist(dataTOuse[,i],main=colnames(dataTOuse[i]))
# }

set.seed(1234)
#Setup Grinding Time Output
inTrain <- createDataPartition(y=dataTOuse$O_tgrind, p=0.80,list=FALSE8
training <- dataTOuse[inTrain,]
testing<-dataTOuse[-inTrain,]

cat("before fitting\n")
fit_O_tgrind<-randomForest(training$O_tgrind~.,data=training[input_names],importance=TRUE)
fit_O_fr<-randomForest(training$O_fr~.,data=training[input_names],importance=TRUE)
fit_O_ff<-randomForest(training$O_fr~.,data=training[input_names],importance=TRUE)

# plot(fit_O_tgrind, log="y")
# MDSplot(fit_O_tgrind, training$O_tgrind)

fit_O_Q.wr<-randomForest(training$O_Q.wr~.,data=training[input_names],importance=TRUE)
fit_O_Q.wf<-randomForest(training$O_Q.wf~.,data=training[input_names],importance=TRUE)
cat("after fitting\n")

#Now, find out how accurate the prediction is for the cross-validation data.
#ie., the portion of the training data set aside for cross-validation.

predicted_tgrind<-predict(fit_O_tgrind,training)
importance(fit_O_tgrind)
varImpPlot(fit_O_tgrind)

importance(fit_O_fr)
varImpPlot(fit_O_fr)

importance(fit_O_Q.wr)
varImpPlot(fit_O_Q.wr)
# 
# plot(training$O_tgrind,predicted_training,main="All data - training")
# abline(0,1)
# 
# 
# validation<-predict(fit,testing)
# plot( testing$O_tgrind,validation,main="All data- validation")
# abline(0,1)
# 
# #Which predictors are most important?
# importance(fit)
# varImpPlot(fit_O_ff)



#BUild user interface
#set initial input values to mean of each distribution
meanOfinputs<-training[0,]
meanOfinputs[1,]<-colMeans(training)

# meanOfinputs[I_m]<-input$mu
# test_predict<-predict(fit,meanOfinputs)
# test_predict





shinyServer(
  function(input, output) {
    
    
    output$tgrindHist <- renderPlot({
      meanOfinputs$I_bw<-(input$I_bw)
      meanOfinputs$I_m<-(input$I_m)
      meanOfinputs$I_z<-(input$I_z)
      meanOfinputs$I_a<-(input$I_a)
      meanOfinputs$I_b<-(input$I_b)
      meanOfinputs$I_x<-(input$I_x)
      meanOfinputs$I_dFa<-(input$I_dFa)
      meanOfinputs$I_dFf<-(input$I_dFf)
      meanOfinputs$I_df<-(input$I_df)
      meanOfinputs$I_Ds<-(input$I_Ds)
      meanOfinputs$I_Fr<-(input$I_Fr)
      meanOfinputs$I_cb<-(input$I_cb)
      meanOfinputs$I_k<-(input$I_k)
#       meanOfinputs$I_dM<-(input$I_dM)
      meanOfinputs$I_Abricht.methode<-(input$I_Abricht.methode)
#       meanOfinputs$I_ZahnfuÃ<-(input$I_ZahnfuÃ)
      meanOfinputs$I_d0<-(input$I_d0)
      meanOfinputs$I_b0<-(input$I_b0)
      meanOfinputs$I_z0<-(input$I_z0)
      meanOfinputs$I_vcI<-(input$I_vcI)
      meanOfinputs$I_kWheel<-(input$I_kWheel)
      
      tgrind_predict<-predict(fit_O_tgrind,meanOfinputs)

      hist(training$O_tgrind, xlab='tgrind', col='lightgreen',main='Histogram',breaks=seq(0,max(training$O_tgrind),l=80))
     
      lines(c(tgrind_predict, tgrind_predict), c(0, 200),col="red",lwd=5)
    })

    output$fr <- renderPlot({
      meanOfinputs$I_bw<-(input$I_bw)
      meanOfinputs$I_m<-(input$I_m)
      meanOfinputs$I_z<-(input$I_z)
      meanOfinputs$I_a<-(input$I_a)
      meanOfinputs$I_b<-(input$I_b)
      meanOfinputs$I_x<-(input$I_x)
      meanOfinputs$I_dFa<-(input$I_dFa)
      meanOfinputs$I_dFf<-(input$I_dFf)
      meanOfinputs$I_df<-(input$I_df)
      meanOfinputs$I_Ds<-(input$I_Ds)
      meanOfinputs$I_Fr<-(input$I_Fr)
      meanOfinputs$I_cb<-(input$I_cb)
      meanOfinputs$I_k<-(input$I_k)
      #       meanOfinputs$I_dM<-(input$I_dM)
      meanOfinputs$I_Abricht.methode<-(input$I_Abricht.methode)
      #       meanOfinputs$I_ZahnfuÃ<-(input$I_ZahnfuÃ)
      meanOfinputs$I_d0<-(input$I_d0)
      meanOfinputs$I_b0<-(input$I_b0)
      meanOfinputs$I_z0<-(input$I_z0)
      meanOfinputs$I_vcI<-(input$I_vcI)
      meanOfinputs$I_kWheel<-(input$I_kWheel)
      
      fr_predict<-predict(fit_O_fr,meanOfinputs)
      ff_predict<-predict(fit_O_ff,meanOfinputs)
      
      par(mfrow=c(2,1))
      
      hist(training$O_fr, xlab='fr- Roughing feedrate', col='lightgreen',main='Histogram',breaks=seq(0,max(training$O_fr),l=80,right=FALSE))
        lines(c(fr_predict, fr_predict), c(0, 80),col="red",lwd=5)
      hist(training$O_ff, xlab='ff-Finishing feedrate', col='lightgreen',main='Histogram',breaks=seq(0,max(training$O_fr),l=80))
         lines(c(ff_predict, ff_predict), c(0, 80),col="red",lwd=5)
#       varImpPlot(fit_O_fr)
})




output$Q.wr <- renderPlot({
  meanOfinputs$I_bw<-(input$I_bw)
  meanOfinputs$I_m<-(input$I_m)
  meanOfinputs$I_z<-(input$I_z)
  meanOfinputs$I_a<-(input$I_a)
  meanOfinputs$I_b<-(input$I_b)
  meanOfinputs$I_x<-(input$I_x)
  meanOfinputs$I_dFa<-(input$I_dFa)
  meanOfinputs$I_dFf<-(input$I_dFf)
  meanOfinputs$I_df<-(input$I_df)
  meanOfinputs$I_Ds<-(input$I_Ds)
  meanOfinputs$I_Fr<-(input$I_Fr)
  meanOfinputs$I_cb<-(input$I_cb)
  meanOfinputs$I_k<-(input$I_k)
  #       meanOfinputs$I_dM<-(input$I_dM)
  meanOfinputs$I_Abricht.methode<-(input$I_Abricht.methode)
  #       meanOfinputs$I_ZahnfuÃ<-(input$I_ZahnfuÃ)
  meanOfinputs$I_d0<-(input$I_d0)
  meanOfinputs$I_b0<-(input$I_b0)
  meanOfinputs$I_z0<-(input$I_z0)
  meanOfinputs$I_vcI<-(input$I_vcI)
  meanOfinputs$I_kWheel<-(input$I_kWheel)
  
  Q.wr_predict<-predict(fit_O_Q.wr,meanOfinputs)
  
  hist(training$O_Q.wr, xlab='Material Removal Rate - roughing', col='lightgreen',main='Histogram',breaks=seq(0,max(training$O_Q.wr),l=80))
  
  lines(c(Q.wr_predict, Q.wr_predict), c(0, 80),col="red",lwd=5)
})

    
#     output$myval<-renderText(test_predict)
  }
)

