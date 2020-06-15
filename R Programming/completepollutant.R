complete <- function(directory, id = 1:332) {
    dataframe = NULL    
    setwd(file.path(getwd(), directory))
    
    for (i in id)
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
        data = as.matrix(data)
        dataframe = rbind(dataframe, c(i,nrow(data))) 
    }
    dataframe = data.frame(dataframe)  
    names(dataframe) = c('id', 'nobs') 
    return (dataframe) 
}