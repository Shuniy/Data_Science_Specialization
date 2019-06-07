outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])



best <- function(state, outcome) {
    
    data <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
    
    outcomes <- data.frame(cbind(data[,2],data[,7],data[,11],data[,17],data[,23]),stringsAsFactors = FALSE)
    colnames(outcomes) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
    
    if(!state %in% outcomes[,"state"]) {
        stop("UNABLE TO DO")
    }
    else if (!outcome %in%  c("heart attack", "heart failure", "pneumonia")) {
        stop("CANT DO IT")
    } 
    else{
        s <- which(outcomes[,"state"] == state)
        t <- outcomes[s,]
        y <- as.numeric(t[,eval(outcome)])
        val <- min(y,na.rm = TRUE)
        name <- t[,"hospital"][which(y == val)]
        ordered <- name[order(name)]
    }
    return(ordered)    
}


