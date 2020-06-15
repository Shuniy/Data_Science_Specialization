rankhospital <- function(state,outcome,num){
    data <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
    outcomes <- data.frame(cbind(data[,2],data[,7],data[,11],data[,17],data[,23]),stringsAsFactors = FALSE)
    colnames(outcomes) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
    
    if (!state %in% outcomes[, "state"]) {
        stop('invalid state')
    } else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
        stop('invalid outcome')
    } else if (is.numeric(num)) {
        s <- which(outcomes[, "state"] == state)
        t <- outcomes[s, ]                     # extracting dataframe for the called state
        t[, eval(outcome)] <- as.numeric(t[, eval(outcome)])
        t <- t[order(t[, eval(outcome)], t[, "hospital"]), ]
        output <- t[, "hospital"][num]
    } else if (!is.numeric(num)){
        if (num == "best") {
            output <- best(state, outcome)
        } else if (num == "worst") {
            s <- which(outcomes[, "state"] == state)
            t <- outcomes[s, ]    
            t[, eval(outcome)] <- as.numeric(t[, eval(outcome)])
            t <- t[order(t[, eval(outcome)], t[, "hospital"], decreasng = TRUE), ]
            output <- t[, "hospital"][1]
        } else {
            stop('invalid num')
        }
    }
                
    return(output)
}
