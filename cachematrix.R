#The first function, makeCacheMatrix creates a matrix,
#which is a list containing a function for : 
#(1) Setting values of the matrix
#(2) values of the matrix
#(3) Setting values of the inverse of matrix
#(4) Getting values of the inverse of matrix

#The second function calculates the inverse of matrix created with 
#the cacheMatrix function. It first checks if the inverse has been 
#calculated. If so, it gets the inverse from the cache else, it 
#calculates the inverse. 


#It is a list of functions for setting and getting values of matrix. 

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    setMatrix <- function(M) {
        x <<- M
        inv <<- NULL
    }
    getMatrix <- function() x
    setInvMatrix <- function(inverse) inv <<- inverse
    getInvMatrix <- function() inv
    list(setMatrix = setMatrix, getMatrix = getMatrix,
         setInvMatrix = setInvMatrix,
         getInvMatrix = getInvMatrix)
}

#This function calculates inverse of matrix.

cacheSolve <- function(x, ...) {
    M1 <- x$getInvMatrix()
    if(!is.null(M1)) {
        message("Got Data From Cached Matrix !")
        return(M1)
    }
    data <- x$getInvMatrix()
    M1 <- solve(data)
    x$setInvMatrix(M1)
    M1
}
