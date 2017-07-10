



## function that gets a vector of twitter-style dates and parses into a useful date format

parseDates <- function(x) # x is vector of twitter-style dates and times
{
	paste0(substr(x,1,4), substr(x,6,7), substr(x,9,10), substr(x,12,13), substr(x,15,16), substr(x,18,19))
}

setwd("/Users/jamesbronzan/projects/EDGI-twitter")

# input file
all_tweets <- read.csv("edgi-epa-6.csv")

# clean up dates to form YYYYMMDDHHMMSS
all_tweets$handydate <- parseDates(all_tweets$tweet_datetime)

# buckets
yr <- c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
year_month <- c(paste0("2013",c("08", "09", "10", "11", "12"), paste0("2014", yr), paste0("2015", yr), paste0("2016", yr)))

# get all the handles in here
handles <- unique(all_tweets$original_screenname)

for (h in 1:length(handles))
{

}