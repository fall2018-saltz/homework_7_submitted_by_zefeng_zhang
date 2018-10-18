
# Homework 7 – Submitted by Zefeng Zhang (Ben) on Oct 17, 2018

#Load and Merge datasets
#1)	Read in the census dataset
library(ggplot2)
library(ggmap)
library(maps)
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

# Create the merged dataframe 
arrests$stateName <- row.names(arrests)
totalData<-merge (cleanCensus,arrests, by=c("stateName"))
str(totalData)
#View(totalData)


# 2)Add the area of each state, and the center of each state, to the merged dataframe
#using the ‘state.center’, ‘state.center’ and ‘state.name’ vectors

stateInfo <- data.frame("stateName"=state.name, "Area"=state.area,"Center"=state.center)
#View(stateinfo)
dfMerge <- merge(totalData, stateInfo,by="stateName")
#View(dfMerge)

#IT DOESN'T ALLOW ME TO INSTALL ANY PACKAGE 

#Step B: Generate a color coded map
#3)	Create a color coded map, based on the area of the state 

us <- map_data("state")
dfMerge$stateName<- tolower(dfMerge$stateName)

colCoMap <- ggplot(dfMerge, aes(map_id =stateName))  
colCoMap <- colCoMap+  geom_map(map = us, aes(fill=dfMerge$Area)) 
colCoMap <- colCoMap + expand_limits(x = us$long, y = us$lat)
colCoMap <- colCoMap + coord_map() +ggtitle("Basic Map of USA")
colCoMap
#View(colCoMap)
# Step C: Create a color shaded map of the U.S. based on the Murder rate for each state 

#4)	Repeat step B, but color code the map based on the murder rate of each state.

us <- map_data("state")
#View(us)

dfMerge$stateName<- tolower(dfMerge$stateName)
colCoMap <- ggplot(dfMerge, aes(map_id =stateName))  
colCoMapMur  <- colCoMap  +  geom_map(map = us, aes(fill=dfMerge$Murder)) 
colCoMapMur  <- colCoMapMur  + expand_limits(x = us$long, y = us$lat)
colCoMapMur  <- colCoMapMur   + coord_map() +ggtitle("Murder Rate of Each State")
colCoMapMur 

#5)  Show the population as a circle per state (the larger the population, the larger the circle)
#using the location defined by the center of each state

colCoMapPopPoint <- colCoMapMur + geom_point(data=dfMerge, aes(x=dfMerge$Center.x,y=dfMerge$Center.y,size=dfMerge$Area), color= "orange") + ggtitle ("Population/Murder of Each State")
colCoMapPopPoint
                                             
#Step D: Zoom the map
#6)	Repeat step C, but only show the states in the north east
#Hint: get the lat and lon of new york city
#Hint: set the xlim and ylim to NYC +/- 10

latlon <- geocode(source="dsk", "NYC, ny")
latlon
colCoMapPopZoom<- colCoMapPopPoint + xlim(latlon$lon-10,latlon$lon+10)+ylim(latlon$lat-10,latlon$lat+10)
colCoMapPopZoom
