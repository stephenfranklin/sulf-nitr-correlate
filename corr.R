# corr.R
# Takes a directory of data files and a threshold for complete cases and 
# calculates the correlation between sulfate and nitrate for monitor locations
# where the number of completely observed cases (on all variables) is greater
# than the threshold. 
# The function should return a vector of correlations for
# the monitors that meet the threshold requirement. 
# If no monitors meet the threshold requirement, then the function should 
# return a numeric vector of length 0. 
# A prototype of this function follows
# corr <- function(directory, threshold = 0) {
#     ## 'directory' is a character vector of length 1 indicating
#     ## the location of the CSV files
#     
#     ## 'threshold' is a numeric vector of length 1 indicating the
#     ## number of completely observed observations (on all
#     ## variables) required to compute the correlation between
#     ## nitrate and sulfate; the default is 0
#     
#     ## Return a numeric vector of correlations
# }
corr <- function(directory, threshold = 0) {
    source("complete.R") # number of complete cases
    completes <- complete(directory=directory, id=1:10)
        # of all files there.
    #cat(sprintf("c.nrow: %i\n", nrow(completes)))
    selects <- subset(completes, completes$nobs>threshold)
        # select just the ones with enough complete cases.
    #cat(sprintf("dc.nrow: %i\n", nrow(desired.completes)))
    correlates <- vector(mode="numeric", length=nrow(selects))
    for(i in 1:nrow(selects)){
        cat(sprintf("id: %i\n",selects[i,"id"]))
        file <- paste(getwd(),"/",directory,"/",sprintf("%03.f",
                as.numeric(selects$id[i])),".csv", sep="")
        cat(sprintf("%s\n",file) )
        this<-(read.csv(file))
        that<-subset(this,complete.cases(this)==T) # filter the NAs
        correlates[i]<-cor(that$sulfate,that$nitrate)
    }
    #smean<-pollutantmean(directory=directory, pollutant="sulfate", id=desired.completes$id)
    #nmean<-pollutantmean(directory=directory, pollutant="nitrate", id=desired.completes$id)
    #cor(smean,nmean)
    return(correlates)
}