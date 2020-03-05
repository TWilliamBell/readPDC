#' Read Pandas complex numbers into R from a csv file
#' 
#' The only function in this package, developed in the aftermath of
#' realizing that I had written complex numbers to a file that neither
#' Python (inc. Pandas!) nor R could read by default.
#'
#' @param path Path to the csv file
#' @param nchars Expected number of characters in csv file, passed to readChar
#' @param ... Arguments passed to read.csv after the data is cleaned.
#'
#' @return The complex data, having been read into R.
#' 
#' @export
#'
#' @examples
#' complexData <- read.pdc("./data/complexData.csv") 

read.pdc <- function(path, nchars = 10000000, ...) {
  dat <- readChar(con = path, nchars = nchars)
  dat <- gsub("\\(", "", dat)
  dat <- gsub("j\\)", "", dat)
  dat <- gsub(",", "i,", dat)
  dat <- gsub("\\n", "i
              ", dat)
  dat <- gsub(" ", "", dat)
  dat <- paste0(dat, "i")
  dat <- read.csv(text = dat, colClasses = "complex", ...)
}