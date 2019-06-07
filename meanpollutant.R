pollutantmean <- function(directory, pollutant, id = 1:332) {
    
    setwd(file.path(getwd(), directory)) 
    total = 0                            
    observations = 0                     
    for (i in id) {
        if (i <10) { 
            data1 <- read.csv(paste("00", as.character(i), ".csv"))
        } else if (i>=10 & i<100) { 
            data1 <- read.csv(paste("0", as.character(i), ".csv"))
        }
     }
        data1 = na.omit(data1)    
        observations = observations + nrow(data1)
        if (pollutant == "sulfate") {total = total + sum(data1$sulfate)}
        else {total = total + sum(data1$nitrate)}
    return (total/observations)
}