## function that gets a vector of twitter-style dates and parses into a useful date format

parseDates <- function(x) # x is vector of twitter-style dates and times
{
	paste0(substr(x,1,4), substr(x,6,7), substr(x,9,10), substr(x,12,13), substr(x,15,16), substr(x,18,19))
}

