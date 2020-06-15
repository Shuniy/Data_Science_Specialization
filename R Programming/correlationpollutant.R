corr <- function(directory, threshold = 0) {
    setwd(file.path(getwd(), directory)) 
    
    correlationVector = NULL 
    for (i in 1:332)
    {
        if (i <10) { 
            data <- read.csv(paste("0","0", as.character(i), ".csv"))
        }
        
        else if (i>=10 & i<100) { 
            data <- read.csv(paste("0", as.character(i), ".csv"))
        }
        else       { 
            data <- read.csv(paste(as.character(i), ".csv"))
        }
        data = na.omit(data) 
        if (nrow(data) > threshold) {
            correlationVector = c(correlationVector, cor(data[,2], data[,3]))
        }
    }
    return (correlationVector)
}