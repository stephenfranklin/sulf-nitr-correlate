# ## pollutantmean.R
# Calculates the mean of a pollutant (sulfate or nitrate) across a specified 
# list of monitors. The function 'pollutantmean' takes three arguments: 
# 'directory', 'pollutant', and 'id'. 
# Given a vector monitor ID numbers,'pollutantmean' reads that monitors' 
# particulate matter data from the directory specified in the 'directory' 
# argument 
# and returns the mean of the pollutant across all of the monitors, 
# ignoring any missing values coded as NA. 
#
# A prototype of the function is as follows
#     pollutantmean <- function(directory, pollutant, id = 1:332) {
#           ## 'directory' is a character vector of length 1 indicating
#           ## the location of the CSV files
#
#           ## 'pollutant' is a character vector of length 1 indicating
#           ## the name of the pollutant for which we will calculate the
#           ## mean; either "sulfate" or "nitrate".
#
#           ## 'id' is an integer vector indicating the monitor ID numbers
#           ## to be used
# 
#           ## Return the mean of the pollutant across all monitors list
#           ## in the 'id' vector (ignoring NA values)
#   }

pollutantmean <- function(directory, pollutant, id = 1:332) {
    setwd(paste("./",directory, sep=""))
    filenames <- paste(sprintf("%03.f", as.numeric(id)),".csv", sep="")
    X <- read.csv(filenames[1])  # make an empty vector
    for(i in filenames[-1]){
        cat(i)
        # = paste(directory,"/",sprintf("%03.f", as.numeric(i)),".csv", sep="")
        Y<-read.csv(i)
        #X<-rbind(X,Y[,pollutant])
        X<-rbind(X,Y)
    # now we have a vector containing the values of
    # the chosen pollutant in all the specfied files.
    }
    themean<-round(mean(X[,pollutant],na.rm=T),3)
    return(x)
}