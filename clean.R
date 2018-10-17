
# Homework 7 – Submitted by Zefeng Zhang (Ben) on Oct 17, 2018

#Load and Merge datasets
#1)	Read in the census dataset
readStates<-function()
{
states<-raw_data
states<-states[-1,]
num.row<-nrow(states)
states<-states[-num.row,]
states<-states[,-1:-4]
colnames(states)<-c("stateName", "population","popOver18","percentOver18")
  return(states)
    
}
cleanCensus<-readStates()
str(cleanCensus)

#2)	Copy the USArrests dataset into a local variable (similar to HW 2)
arrests<-USArrests
str(arrests)
