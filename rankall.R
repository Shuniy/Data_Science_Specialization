rankall <- function(outcome, num) {
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data <- data[c(2, 7, 11, 17, 23)]
    names(data)[1] <- "name"
    names(data)[2] <- "state"
    names(data)[3] <- "heart attack"
    names(data)[4] <- "heart failure"
    names(data)[5] <- "pneumonia"
    outcomes = c("heart attack", "heart failure", "pneumonia")
    if( outcome %in% outcomes == FALSE ) stop("Cant Do it")
    if( num != "best" && num != "worst" && num%%1 != 0 ) stop("Cant do")
    data <- data[data[outcome] != 'Not Available', ]
    data[outcome] <- as.data.frame(sapply(data[outcome], as.numeric))
    data <- data[order(data$name), ]
    data <- data[order(data[outcome]), ]
    getRank <- function(f, s, n) {
        f <- f[f$state==s, ]
        val <- f[, outcome]
        if( n == "best" ) {
            rowNum <- which.min(val)
        } else if( n == "worst" ) {
            rowNum <- which.max(val)
        } else {
            rowNum <- n
        }
        f[rowNum, ]$name
    }
    states <- data[, 2]
    states <- unique(states)
    newdata <- data.frame("hospital"=character(), "state"=character())
    for(st in states) {
        hosp <- getRank(data, st, num)
        newdata <- rbind(newdata, data.frame(hospital=hosp, state=st))
    }
    newdata <- newdata[order(newdata['state']), ]
    newdata
}